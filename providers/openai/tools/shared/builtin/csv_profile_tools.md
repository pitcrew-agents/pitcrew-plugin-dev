# csv_profile_tools

## profile_csv
**Input schema:**
```json
{
  "type": "object",
  "required": [
    "file_path"
  ],
  "properties": {
    "file_path": {
      "type": "string",
      "description": "Path to the CSV file to profile."
    },
    "selected_columns": {
      "type": "array",
      "items": {
        "type": "string"
      },
      "description": "Optional list of column names the user selected as identifying fields. If omitted, all usable columns are included."
    }
  }
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
    "total_rows": {
      "type": "integer"
    },
    "total_columns": {
      "type": "integer"
    },
    "columns": {
      "type": "array"
    },
    "suggested_rules": {
      "type": "array"
    },
    "suggested_thresholds": {
      "type": "object"
    },
    "warnings": {
      "type": "array",
      "items": {
        "type": "string"
      }
    },
    "error": {
      "type": "string"
    }
  }
}
```
