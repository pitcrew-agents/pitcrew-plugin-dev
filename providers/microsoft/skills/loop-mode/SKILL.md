---
name: loop-mode
description: >
  Add a loop swimlane to an agent. Activate when the user's workflow needs to
  process each item in a list — e.g. "for each email", "for every client",
  "process each row". Loop is a swimlane-level feature, not a task_type.
compatibility: Agent Builder V2
---

## What a loop swimlane is

A loop swimlane runs all its tasks **once per item** in a runtime list from state.
The compiler handles the iteration — the agent JSON only needs four extra fields on
the swimlane object. The tasks inside are normal `llm_call` and `tool_call` tasks.

---

## When to use a loop swimlane

Use a loop swimlane when:
- The workflow needs to process each item in a list individually
- The list is dynamic (size unknown at build time, comes from a previous task's output)
- Each iteration needs its own task execution (e.g. analyse each email, validate each record)

**Do NOT use** a loop swimlane for:
- Sending emails / making external API calls in the loop body — `code_gen` has no network access,
  and loop tasks run inside the same sandbox. If each iteration requires a Composio integration call,
  use `EXA_GET_CONTENTS_ACTION` (accepts a list) or a batch Composio tool that processes the whole list at once.
- Static lists where `code_gen` or `analyze_csv` can process the whole list in one pass

---

## Loop swimlane JSON fields

Add these four fields to the swimlane object alongside `name`, `position`, and `tasks`:

```json
{
  "name": "Process Each Email",
  "position": 2,
  "loop_source": "$.state.emails",
  "loop_item_key": "current_email",
  "loop_error_policy": "skip_errors",
  "loop_output_mapping": {
    "summary": "$.task_outputs.sl2_t0.parsed.summary"
  },
  "tasks": [ ... ]
}
```

| Field | Required | Description |
|---|---|---|
| `loop_source` | Yes | JSONPath to the list in state. Must point to an array: `$.state.emails`, `$.state.records` |
| `loop_item_key` | Yes | Name of the state key injected per iteration. Tasks read the current item via `$.state.<loop_item_key>` |
| `loop_error_policy` | No | `"skip_errors"` (default), `"fail_fast"`, or `"require_all"` |
| `loop_output_mapping` | No | Fields to collect from each iteration into the results list. If omitted, the last task's full output is stored per iteration |

---

## How to reference the current item inside tasks

Within a loop swimlane's tasks, the current iteration item is available at:

```
$.state.<loop_item_key>
```

Example: if `loop_item_key` is `"current_email"`:

```json
"input_mapping": {
  "email_subject": "$.state.current_email.subject",
  "email_body":    "$.state.current_email.body"
}
```

The item can be a string, number, or object — match the dot-access path to the item's structure.

---

## Loop results

After the loop completes, the accumulated results are stored at:

```
$.state.<swimlane_name_snake_case>_results
```

The results key is the swimlane `name` lowercased with spaces and hyphens replaced by underscores,
plus `_results`. Examples:
- `"Process Each Email"` → `$.state.process_each_email_results`
- `"Send Reply"` → `$.state.send_reply_results`

Each entry in the results list has:
```json
{
  "index": 0,
  "item": <the original item>,
  "success": true,
  "<loop_output_mapping keys>": <extracted values>
}
```

The downstream swimlane reads `$.state.process_each_email_results` to aggregate or report.

---

## loop_error_policy values

| Policy | Behaviour |
|---|---|
| `"skip_errors"` (default) | Failed iterations are recorded with `success: false` and skipped. Loop continues. |
| `"fail_fast"` | First task failure aborts the entire loop immediately. The run fails. |
| `"require_all"` | Loop finishes all iterations, then fails the run if any iteration failed. |

---

## loop_output_mapping

Specifies which fields to extract from each iteration and store in the results entry.

```json
"loop_output_mapping": {
  "reply_text": "$.task_outputs.sl2_t0.parsed.reply",
  "sentiment":  "$.task_outputs.sl2_t0.parsed.sentiment"
}
```

- Left side: the key name in each result entry
- Right side: JSONPath to the value within `task_outputs` for that iteration
- Uses `sl<N>_t<N>` task refs, same as everywhere else in the agent

If `loop_output_mapping` is omitted, the last task's full output is stored as `"output"` per entry.

---

## Complete example — Analyse each uploaded email

Agent: user uploads a JSON file of emails, the agent reads it, then analyses each email for sentiment.

```json
{
  "name": "Email Sentiment Analyser",
  "description": "Reads uploaded emails and analyses sentiment for each one.",
  "input_schema": {
    "type": "object",
    "properties": {
      "emails_file": {
        "type": "string",
        "format": "file",
        "displayName": "Emails JSON",
        "description": "JSON array of {subject, body} email objects"
      }
    },
    "required": ["emails_file"]
  },
  "swimlanes": [
    {
      "name": "Load Emails",
      "position": 0,
      "instructions": "Parse the uploaded emails file",
      "tasks": [
        {
          "name": "Parse Emails",
          "task_type": "tool_call",
          "position": 0,
          "instructions": "Parse the uploaded JSON file into an array of email objects.",
          "tool_config": { "tool_name": "code_gen", "params": {} },
          "input_mapping": {
            "prompt": "Read the input file as JSON and return the array as-is.",
            "files": ["$.files.emails_file"],
            "output_format": "json"
          },
          "output_mapping": { "result": "$.state.emails" },
          "dependencies": []
        }
      ]
    },
    {
      "name": "Analyse Each Email",
      "position": 1,
      "instructions": "Analyse sentiment for each email",
      "loop_source": "$.state.emails",
      "loop_item_key": "current_email",
      "loop_error_policy": "skip_errors",
      "loop_output_mapping": {
        "subject":   "$.task_outputs.sl1_t0.parsed.subject",
        "sentiment": "$.task_outputs.sl1_t0.parsed.sentiment"
      },
      "tasks": [
        {
          "name": "Analyse Sentiment",
          "task_type": "llm_call",
          "position": 0,
          "instructions": "Classify the email's sentiment as positive, neutral, or negative. Return JSON with 'subject' (the email subject line) and 'sentiment' (positive/neutral/negative).",
          "input_mapping": {
            "subject": "$.state.current_email.subject",
            "body":    "$.state.current_email.body"
          },
          "output_mapping": { "parsed": "$.state.last_analysis" },
          "output_schema": {
            "type": "object",
            "properties": {
              "subject":   { "type": "string" },
              "sentiment": { "type": "string" }
            }
          },
          "dependencies": []
        }
      ]
    },
    {
      "name": "Generate Report",
      "position": 2,
      "instructions": "Summarise all sentiment results into a report",
      "tasks": [
        {
          "name": "Build Report",
          "task_type": "tool_call",
          "position": 0,
          "instructions": "Generate a sentiment summary report",
          "tool_config": { "tool_name": "generate_report", "params": {} },
          "input_mapping": {
            "title": "Email Sentiment Report",
            "instructions": "Show a stat row with total emails and counts per sentiment. Then a table listing each email subject and its sentiment.",
            "inputs": { "results": "$.state.analyse_each_email_results" }
          },
          "output_mapping": {
            "json_report": "$.state.final_report",
            "content_type": "$.state.report_content_type"
          },
          "dependencies": []
        }
      ]
    }
  ]
}
```

---

## Key rules when adding a loop swimlane

1. `loop_source` must point to an array that a **previous swimlane** writes to `$.state.*`
2. `loop_item_key` must be a simple identifier string (`current_email`, not `$.state.current_email`)
3. Tasks inside the loop swimlane read the current item via `$.state.<loop_item_key>`
4. The first task in the loop swimlane must have `dependencies: []`
5. The results key downstream is `$.state.<swimlane_name_snake_case>_results`
6. Loop tasks use normal `llm_call` / `tool_call` task types — no special loop task_type exists
7. `loop_output_mapping` task refs use the **loop swimlane's own position** number (e.g. `sl1_t0` if the loop is swimlane position 1)
8. Do NOT put network-dependent tool_calls (Composio integrations) inside a loop body — use batch tools instead
