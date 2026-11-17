# adv_comparison_tool

## compare_adv_data
**Input schema:**
```json
{
  "type": "object",
  "properties": {
    "pdf_text": {
      "type": "string",
      "description": "Full text content extracted from ADV PDF"
    },
    "api_data": {
      "type": "object",
      "description": "Structured data from fetch_adv_part1 (the data field)"
    }
  },
  "required": [
    "pdf_text",
    "api_data"
  ]
}
```

**Output schema:**
```json
{
  "type": "object",
  "properties": {
    "is_valid": {
      "type": "boolean",
      "description": "True if all found fields match between API and PDF"
    },
    "fields_matched": {
      "type": "integer",
      "description": "Number of fields that matched"
    },
    "fields_total": {
      "type": "integer",
      "description": "Total number of fields compared (13)"
    },
    "comparison": {
      "type": "array",
      "description": "Detailed comparison results for each field",
      "items": {
        "type": "object",
        "properties": {
          "field": {
            "type": "string"
          },
          "api_value": {
            "type": "string"
          },
          "pdf_value": {
            "type": "string"
          },
          "found": {
            "type": "boolean"
          },
          "match": {
            "type": "boolean"
          }
        }
      }
    },
    "error": {
      "type": "string",
      "description": "Error message if validation failed, or first mismatch description"
    },
    "success": {
      "type": "boolean",
      "description": "False if input validation failed"
    }
  }
}
```
