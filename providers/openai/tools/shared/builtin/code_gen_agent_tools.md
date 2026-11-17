# code_gen_agent_tools

## code_gen
Execute arbitrary Python code in a sandboxed AWS AgentCore environment. The agent writes code, runs it, verifies the output, and iterates automatically. Supports any file type as input: CSV, Excel, JSON, HTML, PDF, images, Word docs. Produces text, JSON, CSV, Excel, HTML, or downloadable file outputs.

**When to use:** Pass a clear natural-language 'prompt' describing exactly what to compute. Pass input data via 'input' (raw JSON/text) or 'files' (list of file paths). Set 'output_format' to hint the desired output type (json, csv, excel, html, text). The result is in output['result'] for text/JSON, or output['output_files'] for files.

**Use when:** Use code_gen for any task requiring custom computation, data transformation, file format conversion, mathematical calculations, data analysis, or logic that cannot be expressed as a simple LLM call. Examples: adding two numbers, parsing a CSV, converting Excel to JSON, filtering a dataset, generating a chart, validating email addresses, HTML-to-PDF via Python, or any multi-step data pipeline.
**Avoid when:** Do NOT use for tasks that require real-time external API calls, OAuth authentication, or accessing live data sources — use the appropriate Composio integration tool instead. code_gen has no network access inside the sandbox.

**Input schema:**
```json
{
  "type": "object",
  "properties": {
    "prompt": {
      "type": "string",
      "description": "Natural language instruction describing the task to perform. Examples: 'analyse this CSV and produce a summary report', 'convert this Excel file to JSON', 'validate these email addresses'."
    },
    "input": {
      "description": "Optional raw input data \u2014 string, object, or array. Serialized as input.json and uploaded to the sandbox."
    },
    "files": {
      "type": "array",
      "items": {
        "type": "string"
      },
      "description": "Optional list of input file paths. Supports any file type: CSV, Excel, JSON, HTML, PDF, images, Word docs, and more."
    },
    "output_format": {
      "type": "string",
      "enum": [
        "auto",
        "json",
        "csv",
        "excel",
        "html",
        "text",
        "markdown"
      ],
      "description": "Hint for the desired output format. Default: 'auto'.",
      "default": "auto"
    },
    "output_filename": {
      "type": "string",
      "description": "Optional preferred output filename (without extension)."
    }
  },
  "required": [
    "prompt"
  ]
}
```

**Output schema:**
```json
{
  "type": "object",
  "properties": {
    "success": {
      "type": "boolean"
    },
    "result": {
      "description": "Text or parsed JSON output from the agent"
    },
    "output_files": {
      "type": "array",
      "description": "Generated output files with download_url or local_path"
    },
    "output_file_path": {
      "type": "string",
      "description": "Path or URL of the first output file"
    },
    "download_url": {
      "type": "string"
    },
    "local_path": {
      "type": "string"
    },
    "error": {
      "type": "string"
    }
  }
}
```
