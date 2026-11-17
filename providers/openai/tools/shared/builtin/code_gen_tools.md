# code_gen_tools

## generate_and_execute
**Input schema:**
```json
{
  "type": "object",
  "properties": {
    "prompt": {
      "type": "string",
      "description": "Natural language instruction describing the task to perform. Examples: 'filter accounts with value < $500k', 'verify if this email is valid', 'fill the HTML template with the content from the text file'."
    },
    "input": {
      "description": "Optional raw input data for the task \u2014 can be a string (email, text), object (JSON), array, number, or any JSON-serializable value. Available in generated code as the `user_input` variable."
    },
    "files": {
      "type": "array",
      "items": {
        "type": "string"
      },
      "description": "Optional list of file paths to use as input. If omitted, the task is a pure code/logic task with no file input."
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
      "description": "Desired output format. Use 'auto' to let the LLM decide based on the prompt.",
      "default": "auto"
    },
    "max_iterations": {
      "type": "integer",
      "description": "Maximum ReAct loop iterations for error correction (default: 5, max: 10).",
      "default": 5
    },
    "output_filename": {
      "type": "string",
      "description": "Optional custom filename for generated output files (without extension)."
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
      "description": "Output text/JSON for non-file results"
    },
    "output_files": {
      "type": "array",
      "description": "Generated output files with download_url or local_path"
    },
    "iterations": {
      "type": "integer"
    },
    "error": {
      "type": "string"
    }
  }
}
```
