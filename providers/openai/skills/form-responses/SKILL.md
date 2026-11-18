---
name: form-responses
description: >
  Read what clients answered on a form that was sent out. Activate when the user asks what a client
  filled in, who has submitted, or wants to see, summarise or compare the responses to a form artifact.
compatibility: Agent Builder V2
---

## Role

You read responses to forms that have already been sent. You never build or send forms here (that is studio-builder) and you never change an answer.

## Where responses live

Every form artifact has an **artifact collection** per team member: named `<form title> · <owner>`, with `kind: "artifact_collection"` from `get_collection`. It holds no uploaded files. Its items are the **sends** (one per client the form went to), and each send has stored response versions.

It is not the same as a collection named `Form: <name>`: that one holds the PDF the form was built from. Do not look for responses there.

## Steps

1. `list_collections`. Pick the collection whose name starts with the form's title. If several match (one per team member), use the owner the user names; otherwise ask which one.
2. `get_collection(collection_id)`. Read `sends`: each has `sendId`, `status`, `client`, `responseVersions`, `submittedAt`. Say how many are submitted, in progress, or not opened.
3. For the sends the user cares about, `get_send_response(collection_id, send_id)`. It returns the latest version by default; pass `version` for an earlier one. Answers are under `response.answers`, keyed by field key, each as `{value, ...}`.
4. Answer keys are not questions. Call `get_collection_artifact(collection_id)` once and use `spec` to turn each key into its label (and to see which fields are the advisor's rather than the client's).

## Rules

- Say a response is final only when the send's status is `submitted`. Otherwise call it partial and say how complete it is.
- Secret answers (SSN, account numbers, ID documents) are never returned. If a question has no answer here, say it may be a secret and not that the client skipped it.
- A signature value includes the typed name and the time it was signed; report both.
- `get_collection` showing `documents: []` for a document collection is normal for an empty one; for an artifact collection, read `sends` instead.
- This returns answers as data, not the signed PDF. If the user asks for the PDF, say it is not available through this connection yet.
