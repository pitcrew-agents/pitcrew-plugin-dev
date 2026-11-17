# html_validator_tool

## validate_html
**Input schema:**
```json
{
  "type": "object",
  "properties": {
    "generated_html": {
      "type": "string",
      "description": "Generated HTML to validate. Can be: raw HTML string, file path, or URL (required)"
    },
    "template_source": {
      "type": "string",
      "description": "Template/production HTML to compare against. Can be: raw HTML string, file path, or URL (required)"
    },
    "validation_config": {
      "type": "object",
      "description": "Optional configuration overrides for tolerances and thresholds"
    }
  },
  "required": [
    "generated_html",
    "template_source"
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
      "description": "Final validation decision"
    },
    "summary": {
      "type": "object",
      "description": "Summary of validation results"
    },
    "validations": {
      "type": "object",
      "description": "Detailed validation results by layer"
    },
    "actionable_items": {
      "type": "array",
      "description": "List of issues with fix suggestions"
    },
    "error": {
      "type": "string",
      "description": "Error message if validation failed"
    }
  }
}
```
