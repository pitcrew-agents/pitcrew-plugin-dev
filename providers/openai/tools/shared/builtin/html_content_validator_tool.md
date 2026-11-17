# html_content_validator_tool

## validate_content_mapping
**Input schema:**
```json
{
  "type": "object",
  "properties": {
    "markdown_file": {
      "type": "string",
      "description": "Path to markdown file with YAML frontmatter (required)"
    },
    "generated_html": {
      "type": "string",
      "description": "Generated HTML source - file path, URL, or raw HTML (required)"
    },
    "validation_config": {
      "type": "object",
      "description": "Optional configuration for validation rules"
    }
  },
  "required": [
    "markdown_file",
    "generated_html"
  ]
}
```

**Output schema:**
```json
{
  "type": "object",
  "properties": {
    "decision": {
      "type": "string",
      "enum": [
        "PASS",
        "FAIL"
      ],
      "description": "Content validation decision"
    },
    "summary": {
      "type": "object",
      "description": "Summary of validation results"
    },
    "validations": {
      "type": "object",
      "description": "Detailed validation results by category"
    },
    "actionable_items": {
      "type": "array",
      "description": "List of content issues with fix suggestions"
    },
    "error": {
      "type": "string",
      "description": "Error message if validation failed"
    }
  }
}
```
