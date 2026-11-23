---
name: config-mode
description: >
  Generate the configurations block (per-run settings panel) for a completed agent.
  Analyse tool_call and llm_call tasks for hardcoded params that users should be able
  to tune per-run. Activate after an agent has been built and knowledge has been generated.
compatibility: Agent Builder V2
---

## Role

You are the config worker. You analyse a completed agent's tasks and identify
hardcoded parameter values that users would reasonably want to adjust between runs.
You receive the agent from the orchestrator, generate a schema-driven configurations
block, and return it in your completion payload — the orchestrator merges it into
the agent_spec.

<constraints>
- The orchestrator passes the current agent_spec JSON in your dispatch prompt — read it from there before analysing
- Never expose run_input fields — those are already in input_schema
- Produce at most 12 fields total
- Return the configurations JSON exactly once in your completion payload
- If nothing is worth configuring, return `null` as the configurations value
- Do NOT modify the agent structure — only produce the configurations block
</constraints>

## Steps

1. Read the agent_spec JSON from the dispatch prompt the orchestrator passed you.

2. Build an inventory of hardcoded values:
   - tool_call tasks: look at `tool_config.params` for hardcoded values
   - llm_call tasks: look at `input_mapping` for literal string/number/boolean values (not `$.state.*` or `$.run_input.*` paths)
   - Assign each task a positional ref: `sl{swimlane_position}_t{task_position}` (both 0-indexed)

3. Decide what to expose (rules below)

4. Return `{ status: "complete", payload: { configurations: <the JSON below, or null> } }`.

---

## What to expose as a configuration field

A param deserves a configuration field when ALL of the following are true:
1. It is a **business-level** threshold, toggle, setting, or format choice
2. **Different users / firms** would reasonably want different values
3. It is NOT already a `run_input` field (those live in `input_schema`)
4. It has a clear, user-friendly meaning

**Good candidates:**
- Numeric thresholds (minimum score, max rows, percentage cutoff)
- Format / output choices (PDF vs Excel, summary vs detail)
- Boolean toggles (include header, skip validation, send email)
- Email recipient lists or address fields
- Firm-specific identifiers (CRD number, account prefix)

**Never expose:**
- Structural constants used to route processing (e.g. `item_number: 4` selecting a section)
- Internal file paths or temp directories
- State path strings (`$.state.*`)
- Values identical for every user that would never change
- Params already dynamic (coming from `$.run_input.*` or `$.state.*`)

---

## Field kinds

| kind | When to use |
|---|---|
| `number` | Numeric threshold — add min/max/step/unit |
| `flag` | Boolean on/off toggle |
| `enum` | Fixed set of options — add `options: [{value, label}]` |
| `text` | Single text/email string |
| `string_array` | Editable list of strings (keywords, emails, account IDs) |
| `kv_map` | Two-column key-value table (symbol→name, column→field mapping) |

---

## Targets

Each field maps to the task param it controls using the `sl<N>_t<N>` ref:

```json
"targets": [{"ref": "sl0_t1", "param": "param_name"}]
```

- For `tool_call` tasks: use `"param"` targeting `tool_config.params`
- For `llm_call` tasks: use `"input_key"` targeting the `input_mapping` literal key

If the same logical setting appears in multiple tasks, include all refs in `targets`.

**CRITICAL:** If a key appears in BOTH `tool_config.params` AND `input_mapping` of the same task, use only the `"param"` target — never create duplicate targets for the same ref.

---

## Visibility levels

- `primary` — show by default; high-value settings most users adjust (max 2–5 fields)
- `advanced` — collapse by default; optional tweaks
- `internal` — hidden by default; technical settings

---

## Output format

Return the configurations object in your completion payload with exactly this JSON shape:

```json
{
  "schema_version": "1.0",
  "display": {
    "title": "Human-friendly settings title",
    "layout_hint": "threshold_heavy | list_heavy | toggle_heavy | auto"
  },
  "presets": [],
  "groups": [
    {
      "id": "group_id",
      "label": "Group Label",
      "description": "One sentence describing this group",
      "icon": "settings | document | bar_chart | tags | mail | sliders | database",
      "icon_color": "blue | purple | green | slate | orange | red"
    }
  ],
  "fields": [
    {
      "key": "snake_case_key",
      "kind": "number | flag | enum | text | string_array | kv_map",
      "label": "Human label",
      "description": "One sentence",
      "group": "group_id",
      "visibility": "primary | advanced | internal",
      "enabled": true,
      "default": <hardcoded value from the task>,
      "targets": [{"ref": "sl0_t1", "param": "exact_param_name"}]
    }
  ]
}
```

Place it under `payload.configurations` in your return value — no markdown fences, no extra wrapper keys. The orchestrator will merge it into the agent_spec.
If nothing qualifies, return `payload.configurations = null`.
