---
name: salesforce-mapping
description: >
  Connect a form artifact to Salesforce: choose which Salesforce field each
  question prefills from (read) and writes back to (write), and whether the
  write-back is manual (the sender clicks Sync) or automatic (on submit). Use
  when the user mentions Salesforce, a CRM, prefilling a form from client
  records, or updating the CRM from what a client filled in. Runs inside
  studio-build-mode, after the fields exist. Also covers reading and running
  the write-back on a submitted send.
compatibility: Studio Builder
---

## Role

You wire a form draft to the user's own Salesforce so a send starts with the client's details filled in (**read**, "prefill") and what the
client confirms or adds goes back to the Contact (**write**, "write-back"). You choose the fields yourself from the org's real field list
and the form's questions, show the user a short table, and apply it with one tool call.

<constraints>
- Fields come from `crm_get_schema`, never from memory. A path you did not see in the schema is not offered (custom fields differ in every org).
- Work on the draft after `studio_write_fields` and `studio_write_structure`. Mapping is applied with `studio_set_crm_mapping`; never write `binding`, `writeBack` or `connectors` into the fields yourself.
- Show the user the mapping table and wait for their OK before applying it. Writing to a client's CRM record is the user's decision, including the mode.
- Default write-back to `manual`. Use `auto` only when the user asks for it, and say what auto does (below).
- `sync_write_back` changes the client's real Salesforce record: only after the user has seen `get_write_back_plan` and said go. Never on your own.
- Never map secrets (SSN, bank account, government id), signatures, consents, files or uploads: the tool refuses them. Do not try to get round it.
- Everything runs with the signed-in user's own Salesforce access. If they can't see a field in Salesforce, you can't map it.
</constraints>

## Tools

| Tool | When |
|---|---|
| `crm_status` | First: is Salesforce connected for this user? |
| `crm_get_schema` | The Salesforce fields. Ask narrow: `search`, `objects`, `types`, `writable_only`, `custom_only` |
| `studio_get_crm_mapping` | The questions that can be mapped (with the Salesforce types that fit each) and what is mapped now |
| `studio_set_crm_mapping` | Apply `read`, `write` and `write_back` in one call; refuses and lists every problem, applying nothing |
| `studio_validate_form` | After applying, as always |
| `get_write_back_plan`, `sync_write_back` | After a client submits: see what would change, then write it (with the user's go-ahead) |

## Steps

### A. Decide whether Salesforce is wanted

Only when the user mentions Salesforce, a CRM, prefill, "pull from our records", or "update our CRM". If they did not, do not raise it.
Ask what they want ONE time, in plain words:
- **Prefill:** "Should the form start with the client's details from Salesforce (name, email, phone, …)?"
- **Write back:** "Should what the client enters go back to Salesforce? Automatically when they submit, or should the sender check and click Sync?"

### B. Check the connection

`crm_status`. Not connected: tell the user to connect Salesforce in the Garage (PitCrew app) first. You can still apply the mapping
(paths are then unchecked and the reply says `pathsChecked: false`), but say that clearly and suggest connecting before they send.

### C. Read the form and the org

1. `studio_get_crm_mapping(session_id)`: the questions that can be mapped. Keep to those. `notMappable` explains the rest (secrets, signatures, files).
2. For each question, `crm_get_schema(search="<its words>")`, or one call per object for a few questions: `crm_get_schema(objects=["Contact"], limit=200)`.
   Prefer a field whose type fits the question (the tool lists `readsCrmTypes`). Read `references/salesforce_fields.md` for the usual choices and the rules below.
3. Contact is the client. Use Account or Opportunity only when the question is plainly about the household, company or deal (Account Name, Opportunity Amount).

### D. Choose, per question

- **Read** a field the client's record already holds, so the client confirms instead of typing: name, email, phone, date of birth, address, employer.
- **Write** only answers the client gives or corrects and the CRM should keep. Questions that are only ever confirmation of something that never changes need no write.
- A question may read one field and write another, or only write (a number the sender types when sending, or a new answer).
- Do not write to read-only fields: ask `crm_get_schema(writable_only=true)`.
- A joint holder's questions (`respondent: co_client`) are not mapped. Say so in the table.
- **Approval policy per write** (default `member_approval`):
  - `member_approval`: the sender's Sync, or automatic in auto mode.
  - `admin_approval`: only an owner or admin's Sync, never automatic. Use for sensitive money fields (income, net worth, account value) unless the user says otherwise.
  - `never`: kept on the form, never written.

### E. Show the mapping, then apply

```
**Salesforce mapping** (write-back: manual — the sender clicks Sync after the client submits)
| Question (key)        | Reads                  | Writes back to          | Approval        |
|-----------------------|------------------------|-------------------------|-----------------|
| Full name (full_name) | Contact.Name           | —                       |                 |
| Email (email)         | Contact.Email          | Contact.Email           | sender          |
| Mobile (mobile)       | —                      | Contact.MobilePhone     | sender          |
| Annual income (income)| Contact.Income__c      | Contact.Income__c       | admin only      |
Not mapped: ssn (secret), signature, joint holder's questions.
```

Say what you left unmapped and why. When the user agrees, one call:

```
studio_set_crm_mapping(session_id,
  read={"full_name": "Contact.Name", "email": "Contact.Email", "income": "Contact.Income__c"},
  write={"email": "Contact.Email", "mobile": "Contact.MobilePhone",
         "income": {"target": "Contact.Income__c", "policy": "admin_approval"}},
  write_back="manual")
```

- Read `warnings` and `pathsChecked` in the reply and relay them.
- On `success: false` read `problems` (every refusal at once), fix them, and call again. Nothing was applied.
- Then `studio_validate_form`, and show the final mapping with `studio_get_crm_mapping`.

### F. Tell the user how it will behave (every time)

> **Prefill:** when {sender} sends this form to a client, they pick the Salesforce contact; the questions start with that contact's values and the client confirms or corrects them.
> **Write-back — manual:** after the client submits, the send page shows a Sync panel: each answer next to what Salesforce holds now. The sender ticks what to write and clicks Sync.
> **Write-back — automatic:** the moment the client submits, answers are written using the sender's own Salesforce access. It writes a value when Salesforce is empty there, unchanged since the prefill, or the question wasn't prefilled (a number the sender typed). If someone changed the value in Salesforce after the prefill, it is left for the sender to decide in the Sync panel.

Mention that sending (picking the Salesforce contact) happens in the PitCrew app. Mapping on an already published form is changed in the app: the form's **Data sources** tab → **Edit mapping**.

### G. After a client submits (only when the user asks)

1. `get_write_back_plan(send_id)`. Show a table: question, Salesforce now (`current`), client's answer (`value`), and `status`:
   - `ready`: safe. `unchanged`: already in Salesforce. `conflict`: Salesforce holds something different, so it is only replaced if the user says so. `unavailable`: the user's access can't read that field. `duplicate`: two questions to one field. `approval: "admin"`: needs an owner or admin.
2. Ask which to write and whether to overwrite any conflict. Do not call `sync_write_back` until the user says.
3. `sync_write_back(send_id, keys=[...], overwrite=[...])`. Report `written`, `failed` (with the reason), `waitingForAdmin` and `skipped`.

## Error recovery

| What you see | What to do |
|---|---|
| `crm_status` not connected / "connect Salesforce" | Ask the user to connect it in the Garage, then retry |
| `studio_set_crm_mapping`: "isn't a field this Salesforce user can read" | Wrong path or no access: search again with `crm_get_schema` |
| "is read-only in Salesforce" | Pick an updateable field (`writable_only=true`), or keep it read-only (prefill only) |
| "compound address" | Addresses can be read but not written; leave the write off |
| "can't be prefilled from the CRM" | Secret, signature or file question: leave it unmapped |
| "No form draft yet" | Write the fields first (`studio_write_fields`) |
| `warnings`: mode is 'off' but targets are set | Add `write_back="manual"` (or `"auto"`) |
| Rewrote the fields afterwards | The mapping is kept for questions that keep their key; check with `studio_get_crm_mapping` |

## References

- `skills/salesforce-mapping/references/salesforce_fields.md` — which Salesforce field and type fits each question, patterns, and a worked example
