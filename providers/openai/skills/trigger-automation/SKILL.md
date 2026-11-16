---
name: trigger-automation
description: >
  Set up a trigger that fires an existing PitCrew agent automatically — on a
  cron schedule, when an external event happens in Gmail / Drive / Slack /
  etc., or chained to another agent's bulk run. Activate when the user asks
  to schedule an agent, run it on an event, or wire two agents together.
---

## When to use this skill

Activate when the user says things like:

- "run this agent every Monday morning", "every 2 hours", "once a day"
- "when I get a new email from X, run my Y agent"
- "whenever a new file lands in this Drive folder, …"
- "after my bulk run of agent A finishes, start agent B"
- "start a bulk run of agent C whenever D runs"
- "turn off / pause this trigger", "delete this trigger", "show me what's scheduled"

Do NOT activate for:

- Running an agent **once right now** → use `start_agent_run` instead
- Building or editing an agent → use the Builder skills
- Changing an agent's per-run settings → use `configurations`, not triggers

## The four trigger types

Pick the right one based on how the user wants the agent to fire.

| Trigger type | Fires when | User-phrase examples | Tool |
|---|---|---|---|
| **Schedule** | A cron expression matches, in a specific timezone | "every weekday at 9am", "every hour" | `create_schedule_trigger` |
| **Event** | An external app (Gmail, Drive, Slack, …) emits a configured event via Composio | "when a Gmail arrives", "when a Drive file is uploaded" | `create_event_trigger` (then `enable_trigger`) |
| **Start bulk** | A parent agent runs — kicks off a bulk run of a child agent, one child per iterated item | "when I run A, bulk-run B for every row in A's output" | `create_start_bulk_trigger` |
| **After bulk** | A target agent's bulk run completes — fires this agent with aggregated results | "after bulk C finishes, run D with the aggregated reports" | `create_after_bulk_trigger` |

## Core workflow

1. **Identify the target agent.** If the user didn't name an exact agent, call `list_agents` and have the user pick. Capture the `agent_id`.
2. **Fetch the agent's schema.** Call `get_agent(agent_id)` and read `input_schema.properties` + `input_schema.required`. You need this for every trigger type to know what the agent expects as inputs. For start_bulk / after_bulk, also read `state_schema` and the swimlane task `output_mapping` entries to know which `$.state.*` and `$.bulk_run.*` paths are valid.
3. **Pre-flight based on trigger type** (see the per-type sections below).
4. **Resolve the mapping.** See the "Mapping agent inputs" section — auto-map what you can, ask for the rest.
5. **Check existing triggers.** Call `list_agent_triggers` on the agent. If a similar trigger already exists, tell the user and ask whether to replace it or create another, the backend allows duplicates, so don't rely on it to deduplicate.
6. **Confirm the full plan before creating.** Show the user a compact summary: trigger type and name; (Schedule) cron + timezone; (Event) toolkit + trigger slug + the user-supplied `trigger_config`; the complete `payload_mapping` (or `iterate` for start_bulk) shown side by side with the agent's input_schema; and what happens next. Wait for an explicit yes. Triggers create recurring real-world activity, a wrong mapping could email the wrong person or run an agent every minute instead of every day.
7. **Create.** Call the matching `create_*_trigger` tool.
8. **For Event triggers only**: the trigger is returned **inactive**. Call `enable_trigger` immediately after a successful create. Do NOT tell the user the trigger is active until `enable_trigger` succeeds.
9. **Summarise back.** Tell the user: trigger name, what fires it, when the next run will be (for Schedule / After bulk), and how to disable or delete it.

## Pre-flight: Schedule triggers

Before calling `create_schedule_trigger`:

1. **Call `list_schedule_presets`.** If a preset matches the user's intent ("every hour", "every weekday at 9am"), use the preset's `cron` value verbatim. Do not invent cron if a preset fits.
2. **Confirm the timezone.** Default sensibly to the user's locale if obvious from their message; otherwise ask. Timezone is required — the trigger will not create without it.
3. **payload_mapping** is optional. Only ask the user if the agent needs inputs that don't have sensible defaults in its spec.

## Pre-flight: Event triggers

Before calling `create_event_trigger`:

1. **Call `list_toolkits`** to confirm the app the user mentioned (Gmail, Drive, Slack, …) is actually connected.
2. **Call `list_available_external_triggers`** with the relevant toolkit slug. Each returned trigger has:
   - `slug` → use as `trigger_slug`
   - `toolkit_slug` → use as `toolkit_slug`
   - `config_schema` → tells you what to put in `trigger_config`
   - `payload_schema` → tells you what fields will be available for `payload_mapping`
3. **Build `trigger_config`** from `config_schema`. Fields with a `default` can be left out unless the user wants to override them. Ask the user for each required field without a default (e.g. a Gmail search `query` to narrow which messages fire the trigger).
4. **Build `payload_mapping`** via the "Mapping agent inputs" section below. Do not hand-roll it inline here.
5. **Call `create_event_trigger`.** The returned trigger has `enabled: false`.
6. **Immediately call `enable_trigger`.** Only now is the trigger live.

## Pre-flight: Start-bulk and After-bulk triggers

Before calling `create_start_bulk_trigger` or `create_after_bulk_trigger`:

1. **Call `list_agents`** and confirm the target agent exists. Use its id as `target_agent_id`.
2. **Call `get_agent(target_agent_id)`** so you have the downstream agent's `input_schema` for the mapping step.
3. For **start_bulk**: ask the user what field in the parent agent's output represents the "list of things to iterate over." Build an `iterate` map like `{"client_id": "$.state.items[*].id"}`, grounding the JSONPath in the parent's `state_schema` / task output_mappings (from the parent's `get_agent` response). `iterate` must be non-empty, the backend rejects empty.
4. For **after_bulk**: ask the user what aggregated data the downstream agent needs. Options for `aggregate_mode`: `final_reports` (default, list of each child's final report), `all_outputs` (list of every task output per child), `s3_manifest` (pointer to full artifact set in S3). Build `payload_mapping` with JSONPath rooted at `$.bulk_run`, following the "Mapping agent inputs" section.

## Mapping agent inputs

Every trigger type needs a `payload_mapping` (or `iterate`, for start_bulk) that satisfies the target agent's `input_schema`. The mapping **syntax differs by trigger type**, this is the part the model gets wrong most often, so read the table carefully:

| Trigger type | Mapping lives in | Syntax | Example |
|---|---|---|---|
| **Schedule** | `payload_mapping` | **Static values only.** Values are passed verbatim as run_input, no path resolution. | `{"plan_tier": "basic", "client_id": "123"}` |
| **Event** | `payload_mapping` | **Dot notation into the event's payload.** Keys are the agent's input field names; values are paths into the trigger's `payload_schema`. NO `$.` prefix, NO JSONPath. | `{"email_subject": "subject", "pdf_file": "attachment_list"}` |
| **Start-bulk** | `iterate` (and optional `shared`) | **JSONPath** rooted at the PARENT agent's run state. `$.state.*`, `$.run_input.*`. `[*]` wildcard supported for array fan-out. | `{"client_id": "$.state.filtered_leases[*].id"}` |
| **After-bulk** | `payload_mapping` | **JSONPath** rooted at the aggregated bulk-run output. `$.bulk_run.*`, `$.state.*`, `$.run_input.*`. | `{"report_summary": "$.bulk_run.per_run_array[*].final_report"}` |

### Event-trigger mapping (dot notation) — the common gotcha

The backend `_apply_payload_mapping` + `_extract_value` in `kanban_trigger_service.py` parse the path with dot notation and bracket indexes, NOT JSONPath. Supported forms:

| Form | Example | Resolves to |
|---|---|---|
| Bare top-level key | `"subject"` | `payload["subject"]` |
| Nested key | `"headers.from"` | `payload["headers"]["from"]` |
| Array index (brackets) | `"attachment_list[0]"` | `payload["attachment_list"][0]` |
| Array index (dot) | `"items.0"` | `payload["items"][0]` |
| Static literal | `"__static__:basic"` | the string `"basic"` |

Anything that starts with `$.` is treated as a literal key name, won't match, and the field is silently dropped. Do not use `$.payload.`, `$.`, or `[*]` in event `payload_mapping`.

The webhook payload the server maps against is already the inner object described by the trigger's `payload_schema` (the Composio envelope is unwrapped before mapping). So the top-level keys in `payload_schema.properties` are what you reference directly.

### Resolution order

1. **Enumerate the agent's required inputs.** From `get_agent(agent_id).agent.input_schema`, list every field in `required`, plus any optional fields the user explicitly mentioned. Note which ones have `format: "file"`, they get special handling by the backend (see below).

2. **Build the mapping using the right syntax for the trigger type** (see the table above). Common auto-mappings for Gmail events:

   | Agent input (case-insensitive) | Payload path |
   |---|---|
   | `subject`, `email_subject` | `subject` |
   | `sender`, `from_email`, `from` | `sender` |
   | `body`, `message_text`, `email_body` | `message_text` |
   | `thread_id` | `thread_id` |
   | `to`, `recipient` | `to` |
   | any file-format field, when payload has `attachment_list` | `attachment_list` (pass the whole list, let the backend fetch; do NOT drill into `[0].url`) |

   For file fields specifically: the backend reads `input_schema.properties[field].format == "file"`, uses `toolkit_slug` to know how to download (Composio fetches the Gmail attachment by message_id automatically), and uploads to the run's S3 collection. Mapping to the array field like `"attachment_list"` is sufficient.

   Only auto-map when you're confident. If several payload fields could plausibly fit one agent input (e.g. `recipients` vs `to` vs `cc`), ask.

3. **Ask the user for the rest.** For every required agent input you did not auto-map, prompt with the field name, its description from `input_schema`, and its type. Offer sensible options when payload fields could plausibly fit. For Schedule triggers, remember these are static values, so you are asking the user for the literal value to use on every run.

4. **Present the resolved mapping back for confirmation** as part of step 6 of the Core workflow. Show it as a table: agent input → source (auto or user-supplied). Do not call any `create_*_trigger` tool until the user confirms.

## Important things to tell the user

- **No test-fire**: there is no API to fire a trigger immediately for testing. It will fire on its actual next real occurrence (next cron tick, next real email, next real bulk completion). Set expectations accordingly.
- **Admin role required** for creating, enabling, disabling, deleting. If the backend returns 403, surface it as "you need admin role in your organization to manage triggers."
- **Composio-backed event triggers** depend on the user having connected the relevant app (Gmail, Drive, etc.) in their PitCrew settings. If `enable_trigger` fails with an auth-shaped error, point them to the integrations page.
- **Duplicates are allowed** — the backend will happily create two identical triggers. Only `list_agent_triggers` + user confirmation prevents this.
- **Deleting is permanent.** `delete_trigger` cannot be undone. For a pause, use `disable_trigger` instead.

## Diagnosing a trigger that didn't fire

If the user says their trigger didn't fire:

1. Call `list_agent_triggers` to check `status` (should be `active`) and `enabled` (should be `true`).
2. Call `list_trigger_executions` to see whether the trigger received an event at all. If no executions, the issue is upstream (schedule hasn't ticked yet, Gmail hasn't matched, bulk run hasn't completed). If executions exist but failed, the payload_mapping or the agent itself likely has an issue.

If the trigger fired but the agent ran with missing inputs (e.g. the user says "the run started but the PDF was never attached"):

- You almost certainly used JSONPath (`$.payload.subject`, `$.payload.attachment_list[0]`) in an **event** trigger's `payload_mapping`. The backend parses that as a literal key name, finds nothing, drops the field silently. Re-read "Mapping agent inputs" above, delete the trigger with `delete_trigger`, and recreate it with bare dot-notation keys (`"subject"`, `"attachment_list"`).

## Tool reference

Discovery (read-only):
- `list_agents` — all agents in the org; use to let the user pick one
- `get_agent(agent_id, include_swimlanes?)` — one agent's full spec, including `input_schema`, `state_schema`, `output_schema`, and swimlane tasks. Required before building any `payload_mapping` or `iterate`.
- `list_toolkits` — connected third-party apps for Event triggers
- `list_available_external_triggers(toolkits, limit)` — specific event slugs within an app; each entry carries `config_schema` and `payload_schema`
- `list_schedule_presets` — cron presets (hourly, weekday 9am, etc.)
- `list_agent_triggers(agent_id)` — existing triggers on an agent

Creation:
- `create_schedule_trigger(agent_id, name, schedule_expression, timezone, payload_mapping?)`
- `create_event_trigger(agent_id, name, trigger_slug, toolkit_slug, trigger_config, payload_mapping)` → **then** `enable_trigger`
- `create_start_bulk_trigger(agent_id, name, target_agent_id, iterate, shared?, config_id?)`
- `create_after_bulk_trigger(agent_id, name, target_agent_id, aggregate_mode?, min_success_rate?, payload_mapping?)`

Lifecycle:
- `enable_trigger(agent_id, trigger_id)`
- `disable_trigger(agent_id, trigger_id)`
- `delete_trigger(agent_id, trigger_id)` — permanent

Debugging:
- `list_trigger_executions(agent_id, trigger_id, limit?, offset?)`
