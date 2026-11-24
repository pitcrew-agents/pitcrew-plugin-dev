---
name: studio-manual-fill-example
description: >
  One complete joint-account form where every answer is typed by hand: some by the
  advisor, some by the client, some by a joint holder. Copy its shapes.
---

# Manual-fill example: joint account application

Build order: collection with the source file ready → `studio_create_session(collection_id)`
→ `studio_write_fields` (header + fields + respondents) → `studio_validate_form`
→ `studio_write_structure` (screens, rules, completion) → `studio_set_delivery`
→ `studio_validate_form`.

## studio_write_fields

`form_header`
```json
{
  "title": "Joint account application",
  "schemaVersion": "0.3.0",
  "delivery": {"allowFinishLater": true}
}
```
(The real delivery settings are written with `studio_set_delivery` below.)

`respondents` (client first, then the extra person)
```json
[
  {"role": "client", "label": "Account holder"},
  {"role": "co_client", "label": "Joint account holder",
   "presentWhen": {"expr": "answers.registration.value == 'joint'"},
   "verification": {"method": "email_code", "digits": 6, "sentTo": "co_email"}}
]
```

`fields`
```json
[
  {"key": "registration", "type": "single_select", "widget": "radio",
   "label": "Registration", "owner": "member",
   "config": {"options": {"kind": "static", "options": [
     {"value": "ind", "label": "Individual"},
     {"value": "joint", "label": "Joint tenants"}]}},
   "validation": {"required": true}},
  {"key": "needed_by", "type": "date", "widget": "date_picker",
   "label": "Finish by", "owner": "member", "validation": {"required": true}},
  {"key": "advisor_note", "type": "long_text", "label": "Note from {{member.firstName}}",
   "owner": "member", "config": {"rows": 4}, "validation": {"maxLength": 1000}},
  {"key": "what_youll_need", "type": "paragraph", "label": "What you'll need",
   "config": {"text": "Your Social Security number and employer details.", "tone": "info"}},

  {"key": "primary_name", "type": "person_name", "label": "Full name",
   "respondent": "client", "validation": {"required": true}},
  {"key": "primary_email", "type": "email", "label": "Email",
   "respondent": "client", "validation": {"required": true}},
  {"key": "employment", "type": "single_select", "widget": "radio",
   "label": "Employment status", "respondent": "client",
   "config": {"options": {"kind": "static", "options": [
     {"value": "employed", "label": "Employed"},
     {"value": "retired", "label": "Retired"}]}},
   "validation": {"required": true}},
  {"key": "employer", "type": "short_text", "label": "Employer", "respondent": "client",
   "visibleWhen":  {"expr": "answers.employment.value == 'employed'"},
   "requiredWhen": {"expr": "answers.employment.value == 'employed'"}},
  {"key": "paperless", "type": "single_select", "widget": "radio",
   "label": "Statements", "respondent": "client",
   "config": {"options": {"kind": "static", "options": [
     {"value": "enrolled", "label": "Paperless (email)"},
     {"value": "paper", "label": "Paper by mail"}]}},
   "defaultValue": {"value": "enrolled"}},
  {"key": "primary_ssn", "type": "government_id", "widget": "secret_input",
   "label": "Social Security number", "respondent": "client",
   "config": {"idKind": "ssn", "destination": "vault", "displayMask": "last4"},
   "validation": {"required": true}},
  {"key": "primary_ssn_confirm", "type": "government_id", "widget": "secret_input",
   "label": "Confirm Social Security number", "respondent": "client",
   "config": {"idKind": "ssn", "destination": "vault", "displayMask": "last4"},
   "validation": {"required": true}},
  {"key": "primary_agreement", "type": "consent", "label": "I agree to the account agreement",
   "respondent": "client",
   "config": {"text": "I have read and agree to the account agreement.", "textVersion": "v1"}},
  {"key": "primary_signature", "type": "signature", "widget": "typed_signature",
   "label": "Type your full name to sign", "respondent": "client",
   "config": {"signers": [{"role": "client", "nameField": "primary_name"}],
              "requireAll": true, "typedMustMatch": "primary_name"},
   "validation": {"required": true}},

  {"key": "co_name", "type": "person_name", "label": "Full name",
   "respondent": "co_client", "validation": {"required": true}},
  {"key": "co_email", "type": "email", "label": "Email",
   "respondent": "co_client", "validation": {"required": true}},
  {"key": "co_signature", "type": "signature", "widget": "typed_signature",
   "label": "Type your full name to sign", "respondent": "co_client",
   "config": {"signers": [{"role": "co_client", "nameField": "co_name"}],
              "requireAll": true, "typedMustMatch": "co_name"},
   "validation": {"required": true}}
]
```

Notes
- `owner: member` fields (`registration`, `needed_by`, `advisor_note`) are filled by the advisor before sending.
- Everything with a `respondent` is typed by that person. `owner` stays the default (`client`).
- Co-client fields repeat the client's questions under their own keys (`co_*`). Keys are unique per form.
- `consent` has no `validation` block; `heading`, `paragraph`, `disclosure`, `group`, `hidden` and `calculated` take none either.
- `verification.sentTo` names real fields (`primary_email`, `co_email`); the co-holder's own block is on their respondent entry.

## studio_write_structure

`screens`
```json
[
  {"id": "setup", "title": "Your account", "estimatedMinutesLeft": 5, "submitLabel": "Start",
   "sections": [{"fields": ["registration", "needed_by", "advisor_note", "what_youll_need"]}]},
  {"id": "details", "title": "Your details", "estimatedMinutesLeft": 3,
   "sections": [
     {"title": "Account holder", "fields": ["primary_name", "primary_email", "employment", "employer", "paperless"]},
     {"title": "Joint account holder", "fields": ["co_name", "co_email"]}]},
  {"id": "secure", "title": "Secure details", "estimatedMinutesLeft": 2,
   "sections": [{"fields": ["primary_ssn", "primary_ssn_confirm"]}]},
  {"id": "sign", "title": "Review and sign", "estimatedMinutesLeft": 1, "submitLabel": "Sign",
   "summaryOf": ["registration", "primary_name"],
   "sections": [
     {"title": "Account holder", "fields": ["primary_agreement", "primary_signature"]},
     {"title": "Joint account holder", "fields": ["co_signature"]}]}
]
```

`rules`
```json
[
  {"kind": "compare", "id": "ssn_match", "left": "primary_ssn", "op": "eq",
   "right": "primary_ssn_confirm", "message": "The two numbers don't match."},
  {"kind": "expression", "id": "joint_needs_two", "fields": ["registration", "co_name"],
   "expr": {"expr": "answers.registration.value == 'ind' or answers.co_name"},
   "message": "A joint registration needs two account holders."}
]
```

`completion`
```json
{
  "title": "{{member.firstName}} has everything",
  "message": "Next, {{member.firstName}} reviews it and sends it on.",
  "offerSignedCopy": true,
  "variants": [
    {"when": {"expr": "respondent == 'client' and respondents.co_client.present and respondents.co_client.status != 'submitted'"},
     "title": "You've signed", "message": "We're waiting for {{answers.co_name.first}} to sign."},
    {"when": {"expr": "respondent == 'co_client' and respondents.client.status != 'submitted'"},
     "title": "You've signed", "message": "We're waiting for {{answers.primary_name.first}} to sign."}
  ]
}
```

## studio_set_delivery

"Email code, 6 digits, link good for 10 days, remind on days 2 and 5 and the day before expiry":

```json
{
  "verification_method": "email_code",
  "verification_sent_to": "primary_email",
  "code_digits": 6,
  "link_expires_in_days": 10,
  "reminders_on_days": [2, 5],
  "reminders_before_expiry_days": [1],
  "channels": ["web"],
  "subject": "Open your account with {{org.name}}",
  "button_label": "Open your application"
}
```

This writes `verification: {method: email_code, digits: 6, sentTo: primary_email}`,
`linkExpires: {"expr": "today() + 10"}`, the reminders, channels, subject and button label.
