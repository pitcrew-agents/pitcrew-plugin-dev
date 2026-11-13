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
**First action: the upload box.** If the user's message mentions a form, PDF, document or file to build
from ("create an artifact from this form", "build this in PitCrew"), your FIRST tool call is
`open_upload_ui(is_form=true, collection_name="Form: <title or file name>")` (use `is_form=false` for
non-form documents). Do it before anything else: do not read, summarise or describe the attachment, do not
ask questions, do not list collections, do not create a collection yourself (the tool does it). Say one line,
"Drop your file in the box and press Upload", and wait. Skip this only if the user names an existing
collection, or described the form in words with no file.
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
| `open_upload_ui` | FIRST action when a file is involved: upload box in the chat (creates the collection if none is given); the user drops the original file |
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
2. **Collection.** Reuse the one the user named. If a file is involved, `open_upload_ui` creates it. Otherwise (words only)
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

   **How to upload (two ways only):**
   1. **Small text files:** `upload_documents` with `data` (base64), only for a file whose exact bytes you can
      encode and copy without error (a short text file, a small CSV). Never for a PDF: a PDF is tens of
      thousands of characters, and one wrong character corrupts it silently.
   2. **Everything else, and every PDF form:** call `open_upload_ui(is_form=<bool>, collection_name=...)` (add `collection_id` to use an existing collection). An
      upload box appears in the chat. Tell the user in one line: "Drop your file in the box and press Upload."
      Then stop and wait. The file goes from their browser straight to PitCrew, so you never handle its bytes,
      nothing is converted and no shell or network rule is involved. When it finishes, the box posts a message
      into the chat ("Uploaded. Please continue with collection ..."). Then run `get_collection_status` (step 4).
      If the user says no box appeared, this client cannot show it: ask them to upload the original file in
      PitCrew (form option on for a form PDF) and send you the collection name or id, then continue from step 4.
      If the PDF is a form and was uploaded without the form option, call
      `start_form_extraction(collection_id, md5_hash)` once it is `ready`.

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
