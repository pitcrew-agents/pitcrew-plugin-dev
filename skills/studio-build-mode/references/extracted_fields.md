---
name: studio-extracted-fields
description: >
  How to turn the output of get_form_fields (the backend's form extraction of a
  PDF in a collection) into studio_write_fields / studio_write_structure input.
---

# Building from extracted fields

`get_form_fields(collection_id, md5_hash)` returns what the backend's form classifier found in a
PDF form. Use it as the field list; do not retype the form.

## What you get

```
fields:  [{label, name, type, widget, confidence, page, section, options: [{value,label}], columns, flags, decided_by}]
display: [{label, type, page, section}]     headings, paragraphs, disclosures printed on the form
dropped: [{id, reason}]                     things the classifier decided are not inputs
missing: [{box, type, label}]               inputs it believes exist but could not tie to a tag
flags, stats, pages
```

Each field may also carry `sourceMapping` (where its answer is written in the PDF). Ignore it:
this builder does not write `sourceMapping`, `binding`, `writeBack`, `connectors` or `sourceCollectionId`.

## Field mapping

| Extracted | Form field |
|---|---|
| `type` | `type`, if it is in `field_types.md`. Otherwise stop and ask; never invent a type. |
| `label` | `label`, unchanged |
| `name` | basis for `key`: lower snake_case, unique across the form; add `_2`, `_3` on clashes |
| `options[]` | `config.options` as `{value, label}`, in the same order (`single_select`, `multi_select`) |
| `columns[]` | the columns of a `repeating_group`; check them against `field_types.md` |
| `page`, `section` | screen grouping: one screen per `section` (split sections of more than 4 fields) |
| `display[]` of type heading / paragraph / disclosure | `heading`, `paragraph`, `disclosure` fields on the screen of their `section` |

Required-ness, validation, consent wording and signature rules are not in the extraction. Read them
from the document with `get_relevant_citations` (step 0.6), and mark everything you add that way.

## Check before planning

Put these in the plan for the user to decide; do not silently fix them:

- `type: null`: the classifier could not decide. Propose a type from the label and mark it "Added by me".
- `confidence` under 0.7, or any entry in the field's `flags`: list it as "check".
- `dropped`: list the ones that look like real inputs.
- `missing`: list them; add a field only with the user's OK.
- A signature or date-signed pair: use `signature` with `config.signers` and `config.typedMustMatch`, not two text fields.
- Fields for a second person (joint holder): set `respondent: "co_client"` and declare both respondents.
- Whether each field is filled by the client or the advisor (`owner: "member"`): the PDF does not say; ask.

## Plan source column

An extracted field cites `form extraction p.<page> "<label>"`. If the extraction has fewer fields
than the document describes (`stats.unclassified`, `missing`), say so rather than inventing them.
