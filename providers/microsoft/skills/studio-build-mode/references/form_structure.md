---
name: studio-form-structure
description: >
  Reference for studio-forms structural elements: screens, rules, delivery,
  completion, and respondents. Read alongside field_types.md.
---

# Studio Forms — Form Structure Reference

## Screens

A screen is a step in the multi-page form wizard. Fields are grouped into sections.

```json
{
  "id":                   "personal_info",    // unique, snake_case
  "title":               "Your details",
  "estimatedMinutesLeft": 4,                 // shown in progress indicator
  "intro":               "{{member.firstName}} has prefilled this from your records.",
  "submitLabel":         "All correct — continue",
  "summaryOf":           ["full_name", "email"],  // read-only recap at top
  "sections": [
    {
      "title": "Optional section heading",
      "fields": ["full_name", "email", "dob"]
    }
  ]
}
```

Rules:
- A field appears on **at most one** screen.
- Every key in `sections[].fields` must exist in `fields[]`.
- `summaryOf` keys must also exist in `fields[]`.
- Screen order is array order — the client sees "Step N of N".
- Screen `id` values must be unique.

## Cross-field rules

Three kinds of rules go in `rules[]`:

### compare
```json
{
  "kind": "compare", "id": "end_after_start",
  "left": "end_date", "op": "gte", "right": "start_date",
  "message": "End date must be on or after start date."
}
```
Ops: `eq`, `ne`, `lt`, `lte`, `gt`, `gte`.
`right` can be a field key (string) or a literal value.

### sum
```json
{
  "kind": "sum", "id": "allocation_totals_100",
  "fields": ["equity_pct", "bond_pct", "cash_pct"],
  "equals": "100",
  "message": "Allocation must total 100%."
}
```

### expression
```json
{
  "kind": "expression", "id": "holders_different",
  "expr": {"expr": "answers.full_name.first != answers.co_name.first"},
  "message": "The two account holders must be different people."
}
```

## Delivery block

```json
"delivery": {
  "channels":    ["web"],                  // ["web"] or ["web","sms"]
  "from":        "member",                 // who sends the link
  "subject":     "Please complete your annual review",
  "message":     "This should take about 5 minutes.",
  "buttonLabel": "Start your review",
  "verification": {
    "method":         "sms_code",         // or "email_code" or "none"
    "digits":         6,
    "sentTo":         "mobile",           // field key or "primary_mobile"
    "fallbackMethod": "email_code",        // optional
    "fallbackSentTo": "email"             // optional
  },
  "allowFinishLater":          true,
  "remindersOnDays":           [2, 5],
  "remindersBeforeExpiryDays": [1],
  "linkExpires":               {"expr": "today() + 10"}   // 10 days after sending; or "answers.needed_by", or a date string
}
```

Write this block with `studio_set_delivery`, not by hand.

| Setting | Meaning |
|---|---|
| `verification.method` | `email_code`, `sms_code` or `none` (the schema default is `sms_code` with no destination, so always set it) |
| `verification.digits` | code length, 4 to 8 |
| `verification.sentTo` / `fallbackSentTo` | key of an email or mobile phone field in the form; the code goes to the contact the advisor enters at send time |
| `verification.fallbackMethod` | must differ from `method`; needs `fallbackSentTo` |
| `linkExpires` | `{"expr": "today() + N"}` (N = 1 to 90 days after sending), `{"expr": "answers.<date field>"}`, or a date. Unset means the platform default, 14 days. It must resolve to a day between today and 90 days out |
| `remindersOnDays` | days after sending |
| `remindersBeforeExpiryDays` | days before expiry; needs `linkExpires` |
| `channels` | `web`, `sms` |

SMS is not live yet: the platform emails the code even for `sms_code`.
A respondent can override verification with their own block (see "Multi-respondent forms").

## Completion screen

```json
"completion": {
  "title":          "{{member.firstName}} has everything.",
  "message":        "You'll receive a copy by email.",
  "offerSignedCopy": true,
  "emailSignedCopy": true,
  "variants": [
    {
      "when": {
        "expr": "respondent == 'client' and respondents.co_client.present and respondents.co_client.status != 'submitted'"
      },
      "title": "You've signed",
      "message": "We're waiting for the joint holder to sign."
    }
  ]
}
```

The key is `when` (never `condition`). The first variant whose `when` is true wins; unset keys fall back to the base screen.

## Multi-respondent forms (joint accounts)

Pass `respondents` in `studio_write_fields`. Leave it out for a single-signer form. As soon
as you declare any respondent, `client` must be in the list too.

```json
"respondents": [
  {"role": "client", "label": "Account holder"},
  {
    "role":  "co_client",
    "label": "Joint account holder",
    "presentWhen": {
      "expr": "answers.registration.value in ['jtwros', 'tic']"
    },
    "verification": {
      "method":         "sms_code", "digits": 6, "sentTo": "co_mobile",
      "fallbackMethod": "email_code", "fallbackSentTo": "co_email"
    }
  }
]
```

On each field that belongs to the co-client:
```json
"respondent":  "co_client"
```

On fields visible (read-only) to the other holder:
```json
"sharedWith": ["co_client"]
```

## Who fills each field (manual fill)

| Need | Set |
|------|-----|
| The client answers it (default) | nothing (`owner` defaults to `client`) |
| The advisor fills it before sending | `"owner": "member"` |
| Fixed by the form, nobody edits it | `"owner": "locked"` (or `"system"`) |
| A second person answers it | `"respondent": "co_client"` + declare `respondents` |
| The other person can read the answer | `"sharedWith": ["co_client"]` |
| Preselect a client answer | `"defaultValue": {"value": "enrolled"}` (single_select; a yes_no takes `"yes"` or `"no"`) |

Rules the validator enforces:
- `owner` is `client`, `member`, `system` or `locked`. `co_client` is never an owner; use `respondent`.
- Secret fields (`government_id`, `bank_account`) must be client-owned and cannot have `defaultValue`.
- `defaultValue` is only for client-owned input fields, written in the shape the answer is stored in, and checked against the field's options.
- Only client-owned fields can have a non-client `respondent`.
- `respondent` and `sharedWith` roles must be declared in `respondents`; `sharedWith` cannot list the field's own respondent.
- Put the advisor's (`member`) fields on the first screen and keep them few.
- `hidden` and `calculated` values are not populated at runtime yet; avoid them unless asked.
- Do not add `binding`, `writeBack`, `sourceMapping`, `connectors` or `sourceCollectionId` yet.

## Expressions

`visibleWhen`, `requiredWhen`, `presentWhen`, `completion.variants[].when`, rule `expr` and
`delivery.linkExpires` are `{"expr": "..."}` objects. Allowed:
- `answers.<key>` (`.value` for selects, `.first` for a person_name), `respondent`,
  `respondents.<role>.present`, `respondents.<role>.status`, literals, `['a','b']` lists, `today()`
- `==` `!=` `<` `<=` `>` `>=` `in` `and` `or` `not`, parentheses, `+` `-`, `.year` `.month` `.day`
- A bare `answers.<key>` is true when answered.
Anything else is rejected, and every `answers.<key>` must name a real field.

`delivery.verification.sentTo` / `fallbackSentTo` must be the key of a field in the form.

## Placeholders

Available in label and helpText:
- `{{member.firstName}}` — advisor's first name
- `{{org.name}}` — organisation name
- `{{respondent.firstName}}` — current respondent's first name
- `{{progress.prefilled}}` — how many fields were prefilled ("8 of 12 details are already filled in")
- `{{answers.some_key}}` — value of another field (must exist in fields[])

## Connectors

Not supported by this builder yet. Do not write `connectors`.
