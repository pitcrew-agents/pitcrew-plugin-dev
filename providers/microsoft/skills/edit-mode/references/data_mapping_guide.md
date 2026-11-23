# Data Mapping Guide

This guide explains how data flows between tasks in an agent.
Every task reads from source paths via `input_mapping` and writes
results to state paths via `output_mapping`.

---

## The Three Source Namespaces

| Namespace | What it contains | Example path |
|---|---|---|
| `$.run_input.*` | Text/number/boolean fields the user fills in per run | `$.run_input.advisor_email` |
| `$.files.*` | Files uploaded by the user per run | `$.files.document` |
| `$.state.*` | Outputs written by previous tasks | `$.state.document_text` |

**You can only read from `$.run_input.*` and `$.files.*` if the field is defined in `input_schema`.**
**You can only read from `$.state.X` if a previous task wrote to `$.state.X` via output_mapping.**

---

## input_mapping

Maps the task's parameter names to the source paths where values come from.

```json
"input_mapping": {
  "document_url":  "$.files.uploaded_pdf",
  "policy_id":     "$.state.selected_policy.upload_id",
  "advisor_email": "$.run_input.advisor_email"
}
```

The left side is the parameter name the tool or LLM expects.
The right side is where the value comes from.

### Dot-access into structured state

When a previous `llm_call` task writes a structured object (via `"parsed"` output_mapping),
you can access individual fields with dot notation:

```
$.state.analysis             → the whole analysis object
$.state.analysis.status      → just the "status" field
$.state.analysis.score       → just the "score" field
```

**Maximum two levels of dot-access** (e.g. `$.state.X.Y`). Deeper access
(`$.state.X.Y.Z`) requires the output_schema to define nested objects — which is
not supported. Flatten your schemas instead.

### Literal values in input_mapping

For tool_call tasks, some parameters can be set to literal string values directly:

```json
"input_mapping": {
  "title":        "My Report Title",
  "instructions": "Create a summary with a stat row and a findings table.",
  "document_url": "$.files.uploaded_doc"
}
```

Literals are passed as-is. Use them for static configuration that doesn't change per run.

---

## output_mapping

Maps the task's output keys to state paths where results are stored.

```json
"output_mapping": {
  "content": "$.state.document_text"
}
```

The left side is the output key produced by the tool or LLM.
The right side is where it is stored for downstream tasks to read.

### llm_call output keys

| Key | When to use |
|---|---|
| `"raw_response"` | The LLM's entire response as a plain string |
| `"parsed"` | Structured output matching `output_schema` — gives a typed object |

Use `"parsed"` when downstream tasks need specific fields from the LLM response.
Use `"raw_response"` when the output is a plain string (draft email, free-form summary).

### Final task output keys

The last task in the last swimlane MUST write to `$.state.final_report`.

```json
// generate_report tool (preferred for rich structured output)
"output_mapping": {
  "json_report":  "$.state.final_report",
  "content_type": "$.state.report_content_type"
}

// llm_call fallback (simple text only)
"output_mapping": {
  "raw_response": "$.state.final_report"
}
```

---

## Common Patterns

### Pattern 1: File → Extract → Report

```
Task A (tool_call: read_pdf)
  input_mapping:  { "document_url": "$.files.uploaded_pdf" }
  output_mapping: { "content": "$.state.document_text" }

Task B (llm_call)
  input_mapping:  { "document_text": "$.state.document_text" }
  output_mapping: { "parsed": "$.state.analysis" }
  output_schema:  { "status": string, "findings": string }

Task C (tool_call: generate_report)
  input_mapping: {
    "inputs": { "status": "$.state.analysis.status", "findings": "$.state.analysis.findings" }
  }
  output_mapping: { "json_report": "$.state.final_report", "content_type": "$.state.report_content_type" }
```

### Pattern 2: Select from list then use

When an LLM selects one item from a list returned by a tool, it MUST return
the **complete original object**, not a reconstructed subset:

```
Task A (tool_call: list_policies)
  output_mapping: { "policies": "$.state.available_policies" }

Task B (llm_call) — selects the matching policy
  input_mapping:  { "policies": "$.state.available_policies" }
  output_mapping: { "parsed": "$.state.selected_policy" }
  output_schema:  { "upload_id": string, "name": string }
  instructions:   "Find the policy matching X. Return the EXACT object from the list — do not reconstruct."

Task C (tool_call: validate_content)
  input_mapping: {
    "policy_id": "$.state.selected_policy.upload_id",   ← dot-access into structured output
    "content":   "$.state.document_text"
  }
```

### Pattern 3: User text input

```
input_schema:
  "advisor_email": { "type": "string", "displayName": "Advisor Email" }

Task (tool_call: send_email)
  input_mapping: {
    "to":      "$.run_input.advisor_email",
    "subject": "Your Report",
    "body":    "$.state.report_text"
  }
```

### Pattern 4: Conditional routing based on state

```
Swimlane 0: Classify (writes $.state.risk_level via llm_call with output_schema)

Swimlane 0 exit_criteria:
  type: conditional_routing
  branches:
    - condition: "$.state.risk_level == 'high'"   eval_mode: structured   target: 1
    - condition: "$.state.risk_level == 'medium'" eval_mode: structured   target: 2
  default_branch: target: 3

Swimlane 1: High Risk Path   (branch_group: "risk", exit_criteria.next_position: 4)
Swimlane 2: Medium Risk Path (branch_group: "risk", exit_criteria.next_position: 4)
Swimlane 3: Low Risk Path    (branch_group: "risk", exit_criteria.next_position: 4)

Swimlane 4: Generate Report  (no branch_group — reconvergence point)
```

---

## Intra-swimlane Dependencies

When Task B reads `$.state.X` written by Task A, and both are in the **same swimlane**,
Task B must declare Task A's position in its `dependencies` array:

```json
// Task A at position 0 — writes $.state.parsed_data
{ "position": 0, "output_mapping": { "parsed": "$.state.parsed_data" }, "dependencies": [] }

// Task B at position 1 — reads $.state.parsed_data  ← must depend on position 0
{ "position": 1, "input_mapping": { "data": "$.state.parsed_data" }, "dependencies": [0] }
```

Tasks in **different swimlanes** are automatically sequential — no dependencies needed.
The first task of every swimlane must always have `dependencies: []`.

---

## What NEVER to do

| ❌ Wrong | ✓ Correct |
|---|---|
| `"$.state.X"` before any task wrote to it | Make sure a previous task writes to `$.state.X` |
| `"$.files.X"` in an `llm_call` input_mapping | Insert a `read_pdf`/`analyze_csv` tool_call first |
| `"$.input.X"` | Use `"$.run_input.X"` |
| `"$.state.X.Y.Z"` (three levels deep) | Flatten output_schema: use `X_Y_Z` as top-level property |
| `"$.run_input.X"` when X is not in input_schema | Add X to input_schema, or read from $.state.X instead |
| Last task NOT writing to `$.state.final_report` | Wire generate_report output to `$.state.final_report` |
| output_schema with `"type": "object"` property | Flatten nested objects to top-level string/number fields |
