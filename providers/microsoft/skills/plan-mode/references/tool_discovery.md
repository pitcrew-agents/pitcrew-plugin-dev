# Tool Discovery Guide

Workflow tools are the building blocks a PitCrew agent runs inside its workflow. You do not call
them yourself; you find them through three PitCrew MCP tools and put their names in the plan.

| MCP tool | Use it to |
|---|---|
| `list_workflow_tools()` | See the name and description of every workflow tool, plus the list of Composio toolkits |
| `list_toolkit_tools(toolkit, page)` | See the actions inside one Composio toolkit, 100 per page |
| `get_workflow_tool_schema(name)` | Confirm a tool exists and read its inputs and outputs |

---

## Step-by-Step Discovery Process

### Step 1: List everything once

Call `list_workflow_tools()` at the start of discovery. It returns four groups:

- `native`: PitCrew's built-in tools (PDF, Excel, CSV, compliance, SEC, reports, files, HTTP, ...)
- `integrations`: PitCrew's own integration tools, named `<app>.<action>` (e.g. `gmail.send_message`,
  `wealthbox.get_contact`, `tradepmr.get_account`)
- `custom_scripts`: the organisation's own published scripts
- `toolkits`: Composio apps (slug, name, description). Their actions are not listed here.

Read the names and descriptions and pick one tool for each step of the workflow.

### Step 2: Pick in this order of preference

For each step, use the first group that covers it:

1. **Native tools**
2. **PitCrew integrations** (`<app>.<action>`). Prefer these over a Composio toolkit for the same app:
   use `gmail.send_message`, not `GMAIL_SEND_EMAIL`.
3. **Composio toolkits**, only when no native or PitCrew integration tool covers the step
4. **Custom scripts**
5. **Dynamic integrations**

Ignore whether an app is connected. The user connects it when the agent runs.

If the user names an app ambiguously (for example "calendar" or "CRM") and more than one app fits,
ask which one they use.

### Step 3: Find Composio actions when needed

When a step needs a Composio app:

1. Pick the toolkit from the `toolkits` list by its description, e.g. `hubspot`.
2. Call `list_toolkit_tools(toolkit="hubspot")`.
3. If the right action is not on the page and `has_more` is true, call again with `page` + 1.
   Large toolkits such as GitHub (about 870 actions) span several pages.

### Step 4: Confirm every chosen tool

Call `get_workflow_tool_schema(name)` for each tool you plan to use. It confirms the tool exists and
shows the inputs it needs, so you can check the plan can supply them.

If a name is not found, do not guess or invent one. Look it up again in Step 1 or Step 3.

---

## Tool Name Conventions

| Source | Name format | `category` from get_workflow_tool_schema | Example |
|---|---|---|---|
| Native | `snake_case` | a tool category such as `pdf` | `read_pdf`, `analyze_csv`, `generate_report` |
| PitCrew integration | `<app>.<action>` | `integration:<app>` | `gmail.send_message`, `wealthbox.get_contact` |
| Composio | `ALLCAPS_WITH_UNDERSCORES` | `composio` | `GMAIL_SEND_EMAIL`, `SLACK_SEND_MESSAGE` |

Tell the source from the name and `category`, never from the app name. `gmail.send_message` is
PitCrew's own Gmail integration: it uses PitCrew's own sign-in and the user connects it in PitCrew. It
is **not** Composio. Only `ALLCAPS` tools with category `composio` are Composio actions.

Always use the exact `name` returned by the MCP tools. It is what the edit worker wires into
`tool_config.tool_name`.

---

## Common Native Tools

These cover most workflows. Still confirm each one with `get_workflow_tool_schema` before using it.

| Tool | When to use |
|---|---|
| `download_file` | Download a file from a URL to make it available for other tools |
| `read_pdf` | Extract text from a PDF |
| `read_pdf_tables` | Extract tables from a PDF |
| `analyze_csv` | Parse and analyse a CSV file |
| `write_file` | Write content to a file |
| `read_file` | Read a file's content |
| `http_get` | Make an HTTP GET request |
| `http_post` | Make an HTTP POST request |
| `scrape_url` | Scrape content from a web page |
| `code_gen` | Generate and execute Python code in a sandbox (no network access) |
| `validate_content` | Validate content against policy rules |
| `generate_report` | Generate a rich structured report (always use as the final task) |

---

## Choosing Between Tools

### File processing
- PDF: `read_pdf` (text) or `read_pdf_tables` (tables)
- CSV: `analyze_csv`
- Excel: look for the Excel tools in the `native` group of `list_workflow_tools`
- Word/HTML: `download_file` first, then `read_file`

### External services
- Gmail: `gmail.send_message`, `gmail.list_messages`, `gmail.read_message` (PitCrew integration)
- Wealthbox, TradePMR, Google Drive: their `<app>.<action>` PitCrew integration tools
- Slack, HubSpot, Salesforce and other apps: the Composio toolkit, via `list_toolkit_tools`

### Data validation/compliance
- Policy checks: `validate_content`
- Custom validation logic: `code_gen` (Python sandbox, no network)
- LLM-based assessment: use an `llm_call` task in the agent

### Final output (always include)
- `generate_report` for any agent producing structured findings, summaries, or reports
- Do NOT use plain `llm_call` as the last task unless the output is conversational text only

---

## Inclusion in the Plan

The plan's `tools` list holds the exact tool names the edit worker will use in
`tool_config.tool_name`:

```json
["read_pdf", "validate_content", "gmail.send_message", "generate_report"]
```

Do NOT include:
- Tools you discovered but won't use
- Vague categories or toolkit slugs
- Tools that require integrations the user hasn't mentioned needing

The edit worker reads each tool's schema with `get_workflow_tool_schema(name)` before building the agent.
