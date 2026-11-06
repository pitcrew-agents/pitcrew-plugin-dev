---
name: studio-build-mode
description: >
  Step-by-step procedure for building a studio-forms JSON artifact using the
  studio_* MCP tools. Use when the user asks to build a form, intake,
  questionnaire, or any client-facing document. Always starts from source
  material uploaded to a document collection, then covers field types, who
  fills each field, delivery (email/SMS code, link expiry, reminders) and
  error recovery.
compatibility: Studio Builder
---

## Role

You build studio-forms JSON artifacts by calling MCP tools.
You write the complete `fields[]` array in one call and the `screens[]` in one call.
You do NOT stream or build incrementally field-by-field — write the full arrays at once.

<constraints>
**Collection first, always.** Every form is built from source material that lives in a
document collection. Never design fields from the chat description or from memory alone.
`studio_create_session` rejects a call without a ready collection, so you cannot skip step 0.

**Upload the original file, never a copy of it.** If the user gives a file (especially a PDF form),
the file itself goes into the collection. Never convert, summarize, transcribe, OCR or compress it
into Markdown, text or any other file and upload that instead. A converted copy cannot be
form-extracted (`is_form` works on PDFs only) and loses the layout the extraction needs.
`requirements.md` is only for when the user gave no file at all.
</constraints>

## Tools at your disposal

| Tool | When |
|---|---|
| `list_collections`, `get_collection` | Step 0: find a collection the user names |
| `create_collection` | Step 0: no collection yet |
| `upload_documents` | Step 0: put the source file in the collection (`is_form=true` for a form PDF) |
| `open_upload_ui` | Step 0: drop zone in the chat so the user uploads the original file (preferred for PDFs) |
| `get_upload_page_url` | Step 0: link to the PitCrew collection page when the drop zone does not show |
| `get_upload_url` | Step 0, late fallback: presigned URL to `curl` a file in, then `upload_documents` with `s3_key` |
| `get_collection_status` | Step 0: wait until `overall == "ready"`; gives each `document_id`, `md5_hash` and `form_extraction` |
| `get_form_extraction`, `get_form_fields`, `start_form_extraction` | Step 0: the fields the backend extracted from a form PDF |
| `get_relevant_citations` | Steps 1–2: read what the source says (pass `document_id`) |
| `studio_create_session` | After the collection is ready — needs `collection_id`, returns `session_id` |
| `studio_get_form` | Before any write on an existing draft; after each write to verify |
| `studio_write_fields` | Write form header + ALL fields atomically |
| `studio_write_structure` | Write ALL screens + rules + completion |
| `studio_set_delivery` | Verification (email/SMS code), link expiry, reminders, invite email |
| `studio_validate_form` | After EVERY write — fix all errors before continuing |
| `studio_list_sessions` | To find an existing session to resume |
| `studio_publish_form` | Only when the user asks to publish; see step 7 |
| `studio_list_published_forms`, `studio_get_published_form` | To look at forms already published |

## Steps

### 0. Put the source in a collection (mandatory, before anything else)

1. **Find the source.** One of:
   - a file the user attached or named (a sample form, a PDF, a spreadsheet of fields, a prior questionnaire);
   - a collection the user names: `list_collections` / `get_collection`, and reuse it;
   - only words, and no file anywhere in the conversation (they described the form in chat): save their requirements verbatim, plus any
     delivery instructions, as `requirements.md` and treat that file as the source.
   If there is neither a file nor a description, ask for one and stop. Do not guess a form.
2. **Collection.** Reuse the one the user named. Otherwise
   `create_collection(name="Form: <title>", domain="general")`
   (domains: general, financial, contracts, identity, tax, legal).
3. **Upload.** `upload_documents(collection_id, files=[{"name": ..., "type": <MIME>, "data": <base64>}], is_form=<bool>)`.
   Set `is_form=true` when the file is a **PDF form** the user wants rebuilt as a form artifact
   (a blank application, a questionnaire, a sample form). Leave it false for everything else
   (requirements docs, statements, policies). If the user's file is a form but the PDF is already
   in the collection, call `start_form_extraction(collection_id, md5_hash)` instead.
   If the call fails because form extraction is off on this server, upload again without
   `is_form` and tell the user the field list will come from reading the document.
   Limits: 10 MB per file and about 5 files per call.

   **Which upload route (decide in this order):**
   1. **Direct.** Use `data` (base64) only for a small file whose exact bytes you can encode and copy
      without error (a short text file, a small CSV). Never for a PDF form: a PDF is tens of thousands of
      characters, and one wrong character corrupts it silently.
   2. **In-chat drop zone (preferred for PDFs and anything large).** Call
      `open_upload_ui(collection_id, is_form=<bool>)`. A drop zone appears in the chat. Tell the user:
      "Drop the original file in the box and press Upload, then tell me 'done'." The file goes from their
      browser to PitCrew without passing through you or any shell, so nothing is corrupted and no network
      rule applies. Then run `get_collection_status` (step 4). If the user says no box appeared, this client
      cannot show it: use route 3.
   3. **Browser page.** Call `get_upload_page_url(collection_id)` and give the user the `url` and `steps`.
      They are normally already signed in. They upload the original file there, then tell you "done". Run
      `get_collection_status` (step 4). If the PDF is a form and the page had no form option, call
      `start_form_extraction(collection_id, md5_hash)` once it is `ready`.
   4. **Last technical fallback: presigned S3 upload.** Only if routes 2 and 3 are impossible or failed, you can
      run shell commands, and the file is on the shell's disk:
      1. `get_upload_url(collection_id, filename)` returns `upload_url`, `s3_key`, `expires_in` and a `curl` command.
         The link lasts 15 minutes and sits in this organization's own folder; a link from another org or
         collection is rejected.
      2. Run the returned `curl` in the shell with `<PATH_TO_FILE>` replaced by the file's real path.
         It uploads the original file unchanged. Do not alter the command, and use the same Content-Type.
         Then read the result:
         - exit 0 and an empty body (HTTP 200): uploaded.
         - the response body is S3 XML (`<Error><Code>...`, for example `SignatureDoesNotMatch`, `ExpiredToken`,
           `AccessDenied`): the link or Content-Type is wrong or expired. Call `get_upload_url` again and retry
           ONCE with exactly the returned Content-Type.
         - a 403, a "blocked" or "not allowed" message, a proxy or HTML page, a connection error, or no XML at
           all: the shell's network policy is blocking the storage host. Do NOT retry and do NOT ask for a new
           link: a new link cannot fix a blocked host. Go to the host rule below.
      3. `upload_documents(collection_id, files=[{"s3_key": "<s3_key>", "name": "<filename>"}], is_form=<bool>)`
         registers it. The `s3_key` entry replaces `data`; nothing else changes. If it says nothing was
         uploaded, the curl did not succeed: go back to 2.
      **Connected-session block.** If the response says `X-Proxy-Error: request blocked` / "no rule allows host" and
      mentions that network access is limited because the session is connected to the user's computer, the
      block comes from the session's own policy, not from the link. It can pass once and fail later in the same
      chat. Do not retry and do not request another link. Tell the user exactly this: "This chat is connected to
      your computer, so uploads to PitCrew's storage are blocked from here. Either upload the PDF in PitCrew
      yourself (turn the form option on) and send me the collection name or ID, or start a new chat that is not
      connected to your computer and I will upload it." Then go to 3.

      **Host rule** (any other blocked-host message). `get_upload_url` returns `host` (for example `advisor-intake-bucket.s3.amazonaws.com`). In Claude
      Desktop and on claude.ai the shell runs in a sandbox that only reaches allowed domains. Tell the user:
      "Allow `<host>` under Settings, Capabilities, Code execution and file creation, Additional allowed domains,
      then start a new chat or ask me to retry; or upload the PDF in PitCrew yourself." Then wait. If the user
      allows it, retry from `get_upload_url` (a fresh link). If they would rather upload it, go to 3.
      The sandbox can also only upload files it can see: if the file is not on its disk, go to 3.
   5. **Last resort: the user uploads it.** If no route works (no shell, the file is not reachable, curl
      keeps failing), STOP. Tell the user to upload the original file in PitCrew into a new collection
      (turn the form option on for a form PDF) and give you its name or id, then continue from step 4. Reuse a
      collection only if it holds the original file.

   Never convert, summarize, re-encode or shrink the file to get around an upload problem.

4. **Wait.** Call `get_collection_status(collection_id)` until `overall == "ready"`
   (about 20–60 s per PDF plus embedding). Zero documents, `failed`, or still `ingesting` means
   you cannot continue: fix it or tell the user. Keep each document's `document_id`.
5. **Extracted fields (form PDFs only).** When the PDF was uploaded as a form, poll
   `get_form_extraction(collection_id, md5_hash)` until `status == "completed"` (usually 1-2
   minutes; `failed` means fall back to reading it with citations and tell the user). Then call
   `get_form_fields(collection_id, md5_hash)`. This is the **primary field list**: build the
   plan from it, using `references/extracted_fields.md` for how to turn each extracted field into a
   form field. Still run step 6 to check what the extraction cannot tell you.
6. **Read it from the collection.** Run `get_relevant_citations(query, document_id=<id>, top_k=15)`
   several times, never once. Query for: section and screen titles, each field label and its
   options, which are required, signature and consent wording, disclosures, who signs
   (single or joint), and any stated verification, expiry or reminder rules. Build the field
   list from what comes back (for a form PDF, this fills in what the extraction lacks: required
   markers, signature and consent wording, disclosures, delivery rules). If a topic returns nothing, say so; do not invent it.

### 1. Understand the form

From the collection (and the user's instructions):
- Identify the form's **purpose**, **audience**, and **channel** (web, SMS, or both).
- List every field: key, type, label, required/optional, who fills it (client, advisor, joint holder).
- Group fields into logical **screens** (2–4 fields per screen is ideal).
- Identify **conditional fields** (`visibleWhen`), **rules**, and **multi-respondent** needs.
- Settle the **delivery settings** (step 2b).

If anything is unclear, ask ONE focused question before building.

### 2. Plan (show to user, wait for approval)

Every field cites where it came from (an extracted field cites its page and label).
Show the extraction's problems: fields with `type: null`, low `confidence`, or `flags`, and
`dropped` or `missing` items, each with your proposed handling. Anything not in the collection goes under "Added by me"
and needs the user's OK.

```
**Source:** collection "Form: Annual Client Review" — review_form.pdf (ready)
**Form:** Annual Client Review
**Fields (7):**                                   Source
  • full_name (person_name) — client              review_form.pdf p.1 "Client name"
  • email (email) — client                        review_form.pdf p.1
  • dob (date_of_birth) — minAge 18               review_form.pdf p.1
  • risk (single_select) — 3 options              review_form.pdf p.2 "Risk tolerance"
  • goals (short_text) — optional                 review_form.pdf p.2
  • advisor_note (long_text) — advisor fills      you said: "advisor adds a note"
  • consent_ack (consent) — v1                    review_form.pdf p.3
**Added by me (needs OK):** none

**Screens (2):**
  1. Your details — full_name, email, dob, advisor_note
  2. Annual check-in — risk, goals, consent_ack

**Delivery:**
  • Verification: email code, 6 digits, to the email field `email`
  • Link expires: 10 days after sending
  • Reminders: day 2 and day 5; the day before expiry
  • Finish later: allowed

Does this look right? Reply "yes" to build it.
```

### 2b. Delivery settings (always decide, never leave to defaults)

State every delivery setting in the plan, even if the user said nothing. Use what they said;
for anything unsaid, propose the default and let them change it.

| The user says | Call `studio_set_delivery` with |
|---|---|
| "email OTP" / "email code" | `verification_method="email_code"`, `verification_sent_to=<key of the email field>` |
| "SMS OTP" / "text code" | `verification_method="sms_code"`, `verification_sent_to=<key of the mobile field>`, optionally `fallback_method="email_code"`, `fallback_sent_to=<email field key>` |
| "no code" | `verification_method="none"` |
| "6-digit code" | `code_digits=6` (4–8, default 6) |
| "expires in 10 days" | `link_expires_in_days=10` (1–90) |
| "advisor sets the date" | `link_expires_on_field=<key of a date field>` and add that field with `"owner": "member"` |
| "remind after 2 and 5 days" | `reminders_on_days=[2, 5]` |
| "remind the day before it expires" | `reminders_before_expiry_days=[1]` (needs an expiry) |

Rules:
- Unstated verification: propose `email_code`, 6 digits. Unstated expiry: say "platform default (14 days)" or ask. Never silently leave the form without a verification choice: the schema default is `sms_code` with no destination.
- `sentTo` must be the key of an email or mobile phone field that exists in the form (add one if missing; a mobile phone field uses `"config": {"kind": "mobile"}`). At send time the code goes to the contact the advisor enters; `sentTo` just has to name a real field.
- **SMS is not live yet.** The platform emails verification codes even for `sms_code`. If the user asks for SMS, build it as asked, then tell them plainly.
- A joint form can give the co-holder their own `verification` on that respondent (see `form_structure.md`).
- `studio_set_delivery` replaces the whole verification block each time. Pass the method and its destination together.

### 3. Create session

```
studio_create_session(collection_id="<ready collection id>", title="Annual Client Review")
→ save the returned session_id for all subsequent calls
```
If it returns an error about the collection, go back to step 0. Do not work around it.

### 4. Write fields

Read `skills/studio-build-mode/references/field_types.md` to pick the exact type strings, and
`skills/studio-build-mode/references/manual_fill_example.md` for a complete, validated joint form
(advisor-filled fields, two respondents, conditional fields, defaults, rules, completion variants).

Call `studio_write_fields` ONCE with:
- `form_header`: title, schemaVersion "0.3.0", `delivery: {"allowFinishLater": true}` (real settings come in step 5b)
- `fields`: the complete desired fields[] array

After the call, call `studio_validate_form` and fix any errors. One error is expected until
structure is written: `completion.title: Field required`. Ignore it for now.

### 5. Write structure

Call `studio_write_structure` ONCE with:
- `screens`: complete desired screens[] — every field key must exist in fields[]
- `rules`: cross-field rules (if any)
- `completion`: title, message, offerSignedCopy (optional)

After the call, call `studio_validate_form` and fix any errors.

### 5b. Set delivery

Call `studio_set_delivery` once with the settings from the plan. Read its `warnings` and relay
them to the user (for example the SMS note). Then `studio_validate_form`.

### 6. Show the result

Call `studio_get_form` and show the returned `form_draft` to the user in a fenced code block.

```json
{
  "schemaVersion": "0.3.0",
  "title": "Annual Client Review",
  ...
}
```

Then say:
> "Form built ✓ — **{title}** has {N} fields across {S} screens, schema 0.3.0, built from {collection name}.
> Delivery: {verification}, link expires {expiry}.
> You can copy this JSON and import it, ask me to publish it, or ask for changes."

### 7. Publish (only if the user asks)

Publishing makes the form available in the member's org. Never publish unprompted. When asked,
confirm the artifact id (a lowercase slug) with the user, then call `studio_publish_form`.
Publishing the same content again changes nothing; changed content becomes the next version.

## Error recovery

Errors are `path: message`. The path is the fix location:
- `fields.3.consent.validation: Extra inputs are not permitted` → field 3 (0-based) is a `consent`; delete its `validation` block.
- `fields.7.owner: ...` → bad `owner`; use client, member, system or locked (`co_client` goes in `respondent`).
- `completion.variants.0: ...` → variant keys are `when`, `title`, `message`.
- `form: Value error, respondents must include the client` → add `{"role": "client"}` first.
- `verification.sentTo must be a field key` → name an existing phone or email field, or add one.
- `remindersBeforeExpiryDays needs linkExpires` → set an expiry with `studio_set_delivery`.
- `defaultValue: ...` → use the answer's stored shape (single_select `{"value": "opt"}`).
- "Screen 'X' references unknown field key 'Y'" → rewrite screens without that key, or add the field via `studio_write_fields`.
- "Missing required top-level key" or "Form title is empty" → re-call `studio_write_fields` with `form_header.title` set.
After `studio_write_fields`, `completion.title: Field required` is expected until structure is written.

Max 3 repair attempts; if still failing, tell the user which errors remain.

## Key rules

- For a form PDF, start from `get_form_fields`; do not retype the form from the PDF text. Keep the extracted labels and options exactly; change a type only with the user's OK.
- Work out of the collection: no field without a source, or without the user's OK under "Added by me".
- NEVER invent type names. Use only canonical strings from field_types.md.
- `signature` needs `config.signers[{role, nameField}]` and `config.typedMustMatch`.
- `consent` needs `config.text` and `config.textVersion` and takes NO `validation` block. `heading`, `paragraph`, `disclosure`, `group`, `hidden` and `calculated` take none either; the validator rejects them ("Extra inputs are not permitted").
- Only use `validation` keys the type allows (for example `minAge` only on `date_of_birth`, `minSelected` only on `multi_select`). `field_types.md` lists them.
- `government_id` and `bank_account` are **secret and web-only** — never include them in SMS forms.
- Conditional fields: `visibleWhen` and `requiredWhen` are always `{"expr": "..."}` objects.
- Do NOT add `binding`, `writeBack`, `sourceMapping`, `connectors` or `sourceCollectionId`. Connected data is not supported by this builder yet; every field is filled by hand.
- Decide who fills each field: client (default), advisor (`"owner": "member"`), or a second person (`"respondent": "co_client"`). See "Who fills each field" in `form_structure.md`.
- Multi-respondent: pass `respondents` in `studio_write_fields`, listing `client` first and then `co_client`; add `"respondent": "co_client"` on co-client fields.
- Completion variants use `when`, never `condition`.
- Set delivery with `studio_set_delivery`, never by hand-editing `delivery` JSON.
- Expressions only use the grammar in `form_structure.md`; the validator rejects anything else.
- Read every `studio_validate_form` error as `path: message` and fix the field the path points at.

## References

- `skills/studio-build-mode/references/field_types.md` — all 52 types with examples
- `skills/studio-build-mode/references/form_structure.md` — screens, rules, delivery, completion, who fills each field, expression grammar
- `skills/studio-build-mode/references/extracted_fields.md` — turning `get_form_fields` output into fields, screens and keys
- `skills/studio-build-mode/references/manual_fill_example.md` — a complete validated two-respondent form
