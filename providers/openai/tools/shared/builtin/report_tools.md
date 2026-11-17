# report_tools

## generate_report
Generate a structured JSON report using LLM with validation and fallback. Available components: alert (error/info/success/warning), badge (error/success/warning), calendar (event_list/grid), chart (bar/funnel/line/pie), download (primary/secondary), heading (h1/h2/h3), key_value_list, list (bullet/checklist/numbered), next_steps, progress (bar/ring), stat (card/chips/row), table (basic/comparison/status_summary/tabbed), text (blockquote/paragraph), timeline

**Input schema:**
```json
{
  "type": "object",
  "properties": {
    "title": {
      "type": "string",
      "description": "Report title"
    },
    "instructions": {
      "type": "string",
      "description": "Detailed instructions for report structure and content"
    },
    "inputs": {
      "type": "object",
      "description": "Dynamic data to pass to the LLM (any key-value pairs)",
      "additionalProperties": true
    },
    "model": {
      "type": "string",
      "description": "Optional model override (default: sonnet)"
    }
  },
  "required": [
    "title",
    "instructions",
    "inputs"
  ]
}
```

**Output schema:**
```json
{
  "type": "object",
  "properties": {
    "json_report": {
      "type": "object",
      "description": "The generated JSON report (if successful)"
    },
    "markdown_report": {
      "type": "string",
      "description": "Markdown fallback (if JSON validation failed)"
    },
    "content_type": {
      "type": "string",
      "enum": [
        "json",
        "markdown"
      ]
    },
    "retries": {
      "type": "integer",
      "description": "Number of retries attempted"
    },
    "error": {
      "type": "string",
      "description": "Error message if generation failed"
    }
  }
}
```

## assemble_report_json
**Input schema:**
```json
{
  "type": "object",
  "properties": {
    "title": {
      "type": "string",
      "description": "Report title"
    },
    "sections": {
      "type": "array",
      "description": "Array of section definitions",
      "items": {
        "type": "object",
        "properties": {
          "id": {
            "type": "string",
            "description": "Section ID"
          },
          "title": {
            "type": "string",
            "description": "Section title (optional)"
          },
          "components": {
            "type": "array",
            "description": "Array of component definitions",
            "items": {
              "type": "object",
              "properties": {
                "type": {
                  "type": "string",
                  "enum": [
                    "alert",
                    "badge",
                    "calendar",
                    "chart",
                    "download",
                    "heading",
                    "key_value_list",
                    "list",
                    "next_steps",
                    "progress",
                    "stat",
                    "table",
                    "text",
                    "timeline"
                  ],
                  "description": "Component type"
                },
                "variant": {
                  "type": "string",
                  "description": "Component variant (type-specific)"
                },
                "data": {
                  "type": "object",
                  "description": "Inline component data"
                },
                "data_ref": {
                  "type": "string",
                  "description": "Reference key for data injection"
                }
              },
              "required": [
                "type"
              ]
            }
          }
        },
        "required": [
          "components"
        ]
      }
    },
    "data": {
      "type": "object",
      "description": "Data dictionary for injection via data_ref",
      "additionalProperties": true
    }
  },
  "required": [
    "title",
    "sections"
  ]
}
```

**Output schema:**
```json
{
  "type": "object",
  "properties": {
    "json_report": {
      "type": "object",
      "description": "The generated JSON report"
    },
    "content_type": {
      "type": "string",
      "const": "json"
    },
    "error": {
      "type": "string",
      "description": "Error message if generation failed"
    }
  }
}
```
