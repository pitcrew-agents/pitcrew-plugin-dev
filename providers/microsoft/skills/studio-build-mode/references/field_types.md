---
name: studio-field-types
description: >
  Complete reference for all 52 studio-forms field types. Read before calling
  studio_write_fields to pick the correct type string and config shape.
---

# Studio Forms — Field Type Reference

Schema 0.3.0 · 52 types · 14 categories

## CRITICAL: type strings are exact

Always use the exact string in the `Code` column. Never invent variations.

---

## Text (3)

| Name | Code | Stores | Key config |
|---|---|---|---|
| Short text | `short_text` | text | `placeholder?`, `inputMode?` |
| Long text | `long_text` | text | `rows?` |
| Rich text | `rich_text` | formatted text (web only) | `allowedMarks?` |

## Number (6)

| Name | Code | Stores | Key config |
|---|---|---|---|
| Whole number | `integer` | whole number | `step?`, `unit?` |
| Decimal | `decimal` | decimal (as text) | `step?`, `unit?`, `precision?` |
| Money | `currency` | `{amount, currency}` | `currency?`, `allowCurrencyChange?` |
| Percentage | `percentage` | decimal (as text) | `precision?` |
| Range (min to max) | `range` | min and max (web only) | `lower`, `upper`, `step?` |
| Rating / scale | `rating` | whole number on scale | `scaleMin?`, `scaleMax?`, `minLabel?`, `maxLabel?` |

## Date and time (7)

| Name | Code | Stores | Key config / validation |
|---|---|---|---|
| Date | `date` | ISO date string | `minDate?`, `maxDate?` |
| Time | `time` | time string | `minuteStep?` |
| Date and time | `datetime` | date+time | `timezone?`, `fixedTimezone?` |
| Date range | `date_range` | start+end dates (web only) | `maxSpanDays?` |
| Year | `year` | integer year | `min?`, `max?` |
| Month and year | `month_year` | month+year | — |
| Duration | `duration` | ISO duration | `units?` |

**Date of birth** — use `date_of_birth` (personal type), NOT `date`:

```json
{"key": "dob", "type": "date_of_birth", "label": "Date of birth",
 "widget": "typed_date",
 "validation": {"required": true, "minAge": 18}}
```

## Choice (7)

| Name | Code | Stores | Key config |
|---|---|---|---|
| Yes / No | `yes_no` | "yes" / "no" / "unsure" | `allowUnsure?`, `unsureLabel?` |
| Single select | `single_select` | `{value}` | `options`, `allowOther?`, `limitTo?` |
| Multi select | `multi_select` | `[{value}]` | `options`, `allowOther?`, `minSelected?`, `maxSelected?` |
| Ranking | `ranking` | options in order (web only) | `options`, `rankAll?` |
| Matrix / grid | `matrix` | option(s) per row (web only) | `rows`, `columns`, `multiplePerRow?` |
| Dependent select | `cascading_select` | option per level (web only) | `levels` |
| Allocation | `allocation` | % split across items | `items`, `total?` |

**Static options shape (single_select / multi_select):**
```json
"config": {
  "options": {
    "kind": "static",
    "options": [
      {"value": "conservative", "label": "Conservative"},
      {"value": "moderate",     "label": "Moderate"},
      {"value": "aggressive",   "label": "Aggressive"}
    ]
  }
}
```

## Contact (5)

| Name | Code | Stores | Key config |
|---|---|---|---|
| Person name | `person_name` | `{first, last, middle?, suffix?}` | `parts?` |
| Email | `email` | email address | `verify?` |
| Phone | `phone` | E.164 number | `defaultCountry?`, `kind?`, `verify?` |
| Postal address | `address` | structured address | `countries?`, `normalize?`, `excludePoBox?` |
| Website / URL | `url` | web link | — |

## Sensitive (3) — 🔒 SECRET fields

| Name | Code | Channel | Notes |
|---|---|---|---|
| Government ID | `government_id` | **web-only** | SSN, EIN, passport. Secret: encrypted, never logged, vault ref only. Needs `config.idKind` |
| Date of birth | `date_of_birth` | web+SMS | Personal: masked in logs. NOT secret |
| Bank account | `bank_account` | **web-only** | Secret: same as government_id |

**Secret fields cannot be used in SMS-only forms.**

```json
{"key": "ssn", "type": "government_id", "label": "Social Security number",
 "config": {"idKind": "ssn", "destination": "pass_through", "displayMask": "last4"},
 "validation": {"required": true}}
```

## Files (3) — web only

| Name | Code |
|---|---|
| File upload | `file_upload` |
| Photo / camera | `photo_capture` |
| Audio / video | `audio_video` |

```json
{"key": "statements", "type": "file_upload", "label": "Account statements",
 "config": {"accept": ["application/pdf"], "extract": true},
 "validation": {"maxFiles": 3, "maxSizeMb": 25}}
```

## Signature and consent (3) — web only for signature/initials

| Name | Code | Required config |
|---|---|---|
| Signature | `signature` | `signers: [{role, nameField}]`, `typedMustMatch?` |
| Initials | `initials` | — |
| Consent / acknowledgment | `consent` | `text`, `textVersion` |

```json
{"key": "sig", "type": "signature", "label": "Type your full name to sign",
 "widget": "typed_signature",
 "config": {
   "signers": [{"role": "client", "nameField": "full_name"}],
   "typedMustMatch": "full_name"
 },
 "validation": {"required": true}}

{"key": "ack", "type": "consent", "label": "I agree",
 "config": {"text": "I have read and agree to the terms.", "textVersion": "v1"}}
```

Rules: owner `client` only; signer `role` is `client` or `co_client`; `typedMustMatch` should be a `person_name` field; the signing date is stamped automatically, so there is no separate date field.

## Structure (2)

| Name | Code | Notes |
|---|---|---|
| Group | `group` | Stores object of child answers. `config.fields` = array of child field defs |
| Repeating group | `repeating_group` | Stores list of rows. Needs `config.fields`, `validation.minItems?`, `validation.maxItems?` |

## Display-only (5) — take no answer

| Name | Code | Required config |
|---|---|---|
| Heading | `heading` | `text`, `level?` |
| Instructions | `paragraph` | `text`, `tone?` |
| Disclosure | `disclosure` | `text`, `textVersion`, `collapsed?`, `requireOpened?` |
| Calculated value | `calculated` | `expression`, `resultType`, `dependsOn` |
| Hidden value | `hidden` | `source`, `param?`, `path?`, `constant?` |

```json
{"key": "disc", "type": "disclosure", "label": "Important disclosures",
 "config": {
   "text": "Your information is confidential.",
   "textVersion": "v1",
   "collapsed": true,
   "requireOpened": true
 }}
```

## References (4) — web only

| Name | Code | Notes |
|---|---|---|
| Record lookup | `record_lookup` | `connector`, `entity`, `displayField?` |
| Entity lookup | `entity_lookup` | `entityKind`, `provider` |
| Country / region | `country_region` | `level?`, `country?` |
| Team member | `team_member` | `roles?` |

## Interaction (3) — web only

| Name | Code |
|---|---|
| Choose an option | `option_cards` |
| Book a time | `appointment` |
| Payment | `payment` |

## Location (1) — web only

| Name | Code |
|---|---|
| Map location | `geo_point` |

---

## Conditional fields

```json
{"key": "details", "type": "long_text", "label": "Describe the change",
 "visibleWhen":  {"expr": "answers.changed.value == 'yes'"},
 "requiredWhen": {"expr": "answers.changed.value == 'yes'"}}
```

Always use `{"expr": "..."}` objects — never a plain string.

## Binding sources (not supported by this builder yet — do not add `binding`)

```json
"binding": {"source": "system_of_record", "path": "client.fieldName", "confidence": "high"}
"binding": {"source": "document",          "path": "filename#p1",       "confidence": "high"}
"binding": {"source": "member",                                          "confidence": "high"}
"binding": {"source": "computed",          "path": "suggested.value",   "confidence": "member_reviews"}
```
