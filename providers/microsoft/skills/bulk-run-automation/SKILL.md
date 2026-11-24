---
name: bulk-run-automation
description: >
  Run an existing PitCrew agent in bulk over N items at once: N PDFs, N rows
  of a spreadsheet, N files in a Drive folder, N objects under an S3 prefix.
  Activate when the user asks to process a batch, a folder, a sheet, a
  mailbox export, or anything phrased as "for each of these, run the agent".
---

## When to use this skill

Activate when the user says things like:

- "run this agent on all these PDFs", "on every file in this folder"
- "process this spreadsheet", "one run per row of this CSV"
- "run it on every file under this S3 prefix"
- "bulk process", "batch", "run in parallel over N inputs"
- "check status of my bulk run", "cancel the bulk run"

Do NOT activate for:

- Running the agent **once** over one input → use `start_agent_run`
- Scheduling, event-driven, or chained runs → use `trigger-automation`
- Building or editing an agent → use the Builder skills

## The mental model

A bulk run fans an agent out into N child runs. Each child gets:

- **iterate** inputs: a different value per child (the per-item inputs)
- **shared** inputs: the same value for every child

The config (`BulkRunConfig`) names which input fields are iterate vs shared,
and for file fields the `source_type`: `local`, `s3`, or `gdrive`. One
agent can have many saved configs for different bulk-run shapes.

## The three execution modes

Picked by what you attach when calling `start_bulk_run`. One iterate source,
one mode:

| Use `iterate_*` parameter | Mode | Use when |
|---|---|---|
| `iterate_staging` | Mode A, local files | User has files on disk. Create a staging session, upload each file once, then list filenames. |
| `iterate_s3` | Mode A, S3 prefix | Files already in S3 under a known prefix. |
| `iterate_gdrive` | Mode A, Drive folder | User points at a Google Drive folder. One run per file in it. |
| `iterate_manifest` | Mode B, CSV manifest + per-field files | 2+ iterate fields, especially mixing text + files. CSV columns = iterate field names, rows = one child each. |
| `iterate_text_csv` | Text mode | All iterate fields are text (no files). CSV columns = field names, rows = one child each. |

If the user has ONE file field to iterate over, prefer Mode A. If they have
multiple iterate fields (e.g. `client_name` text + `invoice_pdf` file in the
same row), use Mode B with a manifest CSV. If every iterate is text, use
text mode.

## Core workflow

1. **Identify the agent.** If the user didn't name one, call `list_agents`
   and pick with them. Capture `agent_id`.
2. **Fetch the agent's schema.** Call `get_agent(agent_id)` and read
   `input_schema.properties` + `input_schema.required`. You need the exact
   field names and types (text vs file) for every subsequent step.
3. **Find or create a config.** Call `list_bulk_run_configs(agent_id)`. If a
   saved config matches the user's intent, reuse its `config_id`. Otherwise
   propose one from the agent's schema and the user's description (see
   "Config design" below) and call `create_bulk_run_config`.
4. **Pick the iterate source.** See the mode table. If the user is ambiguous,
   infer from how they describe the input: a folder path → Mode A; a
   spreadsheet → Mode B or text; a Drive link → Mode A gdrive; an S3 URI →
   Mode A s3.
5. **Pre-flight the source** (see "Pre-flight" below).
6. **Stage files if needed.** For local files, create a staging session,
   upload each file via `upload_bulk_staging_file`, then reference them in
   `iterate_staging.filenames`.
7. **Confirm the full plan before starting.** Show the user, compactly:
   the agent name, config name + field roles, which iterate source is being
   used, the item count that will produce, every shared value, and the
   estimated cost scale ("this will produce N child runs"). Wait for yes.
   A bulk run is expensive and hard to stop cleanly, confirmation is not
   optional.
8. **Start.** Call `start_bulk_run`. Capture the returned `bulk_run.id`.
9. **Poll.** Loop `get_bulk_run_status(bulk_run_id)` at a sensible cadence
   (see "Polling" below), summarising progress. Stop polling once every
   item is in a terminal state.
10. **Report.** Give the user a summary: completed, failed, cancelled; link
    them to the agent's runs list; and if any items failed, suggest how to
    drill in with `get_bulk_run(bulk_run_id)`.

## Config design

A config is just `{name, field_configs: [{field_name, role, source_type}]}`.
Build it from the agent's `input_schema.properties`:

- Required file field the user wants to iterate over → `role: iterate`,
  `source_type: local | s3 | gdrive` based on where the files live.
- Required text field the user wants to vary per item → `role: iterate`,
  `source_type` omitted.
- Required input the user wants the same value for across every child →
  `role: shared`, `source_type` for file fields.
- Required input neither varying nor shared → ask the user.
- Optional input the user doesn't mention → omit from field_configs (the
  backend will use the agent's default, if any).

Give the config a human-readable `name` that matches the job:
"Invoice folder monthly", "Client intake sheet", not "default".

## Pre-flight: Mode A (single iterate)

Based on the source:

- `iterate_staging`: no external pre-check, but tell the user how many
  files you're about to upload before starting the loop. Confirm if > 50.
- `iterate_s3`: no pre-check tool, but echo back the prefix verbatim so
  the user can spot a typo.
- `iterate_gdrive`: call `list_toolkits` and confirm `googledrive` is
  connected before starting the run. If not connected, stop and tell the
  user to connect Drive in the PitCrew app first, do not try to run.

## Pre-flight: Mode B (manifest)

1. Call `get_bulk_run_csv_template(agent_id, config_id)` to get the exact
   header row the backend expects. Use these column names verbatim.
2. If the user supplied a spreadsheet link (Google Sheets, Excel), read it
   and map its columns onto the template's columns, flagging mismatches.
3. For each file-field column: decide its `file_sources` entry:
   - Local files → upload to a per-field staging session and use
     `{"staging_id": "..."}`.
   - Drive folder containing those files → `{"folder_url": "..."}`.
   - Inline bytes (small, rare) → `{"folder_files": [{filename, content_b64, content_type}]}`.
4. Verify every filename referenced in the CSV exists in its field's
   source before calling `start_bulk_run`. The backend fails the whole run
   on the first missing file, so catching it client-side saves a round
   trip.

## Pre-flight: text mode

1. Call `get_bulk_run_csv_template(agent_id, config_id)` — this also works
   for text-only configs.
2. If the user supplied a spreadsheet or pasted rows, normalise to CSV
   with the template's headers. Confirm the row count before starting.

## Local-file staging flow

For Mode A `iterate_staging` or Mode B per-field staging:

1. `create_bulk_staging_session(agent_id)` → capture `staging_id`.
2. For each local file:
   - Read the bytes.
   - `upload_bulk_staging_file(staging_id, filename, content_b64, content_type?)`.
   - Each file is a separate tool call, each capped at 10 MB. Do this in
     order; if any upload fails, surface it immediately rather than
     continuing, since a bulk run with a missing file will blow up.
3. If the user aborts before `start_bulk_run`, call
   `delete_bulk_staging_session(staging_id)` to clean up. After a
   successful bulk run the backend auto-cleans; no manual delete needed.

## Confirmation pattern

Before calling `start_bulk_run`, show the user:

```
About to run <agent name> in bulk.
  Config: <config name>  (iterate: <fields>; shared: <fields>)
  Source: <mode> — <N> items
  Shared values:
    <field>: <summary of value>
    ...
  Expected child runs: <N>
Confirm?
```

Do not start without an explicit yes. If the user asks you to change
anything (remove an item, swap a shared value, use a different config),
re-show the summary and ask again.

## Polling

After `start_bulk_run`, call `get_bulk_run_status` periodically. Pick the
cadence yourself based on how many items and how long the agent typically
runs: a 5-item bulk might poll every 15s, a 500-item bulk every 2 minutes.
Between polls, tell the user "x of N complete, y running, z failed" so
they see progress.

Stop polling once every item is in a terminal state (completed, failed,
cancelled). Do NOT keep polling a finished bulk run.

If the user says cancel, call `cancel_bulk_run(bulk_run_id)` and confirm
back.

## Mapping agent inputs

The config decides which inputs are iterate vs shared; the iterate source
decides how iterate values arrive. Shared values need to be collected
explicitly before calling `start_bulk_run`:

- Shared text field → user provides a single value; pass in `shared_texts`.
- Shared file field → user uploads once; pass bytes in `shared_files`
  (one 10 MB cap, inline). If the shared file is large or already in S3,
  create a dedicated single-item config instead (not supported in v1 via
  staging for shared files).

For every field in the config's `field_configs`, you need to have
collected a value (iterate source or shared) before confirming the plan.
If any are missing when you build the confirmation summary, ask the user
for them.

## Diagnosis / common issues

- **"Bulk run config not found"** → `config_id` is wrong or deleted.
  Re-list and pick again.
- **"No iterate files, S3 prefix, or text values provided"** → the mode
  didn't carry any items. Check that filenames were actually uploaded to
  staging, or the S3 prefix / Drive folder isn't empty.
- **"Staging session not found or expired"** → staging sessions are
  short-lived. If a long time passed between upload and `start_bulk_run`,
  the session may have expired. Create a new one and re-upload.
- **"Composio is not configured"** → Drive source used but the org has
  no Composio setup. Not fixable in-chat; tell the user.
- **CSV row N: file "X" not found for field "Y"** → the manifest
  references a filename that isn't in the field's staging / folder.
  Catch this client-side before starting.

## Tools this skill uses

- `list_agents`, `get_agent` (agent lookup and schema)
- `list_toolkits` (Drive connection check)
- `list_bulk_run_configs`, `create_bulk_run_config`,
  `update_bulk_run_config`, `delete_bulk_run_config`
- `get_bulk_run_csv_template`
- `create_bulk_staging_session`, `upload_bulk_staging_file`,
  `delete_bulk_staging_session`
- `start_bulk_run`
- `list_bulk_runs`, `get_bulk_run`, `get_bulk_run_status`, `cancel_bulk_run`
