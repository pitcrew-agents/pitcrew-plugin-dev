# textract_tools

## extract_text_textract
**Input schema:**
```json
{
  "type": "object",
  "properties": {
    "path": {
      "type": "string",
      "description": "Path to PDF file (local or s3:// URL)"
    },
    "extract_tables": {
      "type": "boolean",
      "description": "Extract tables and forms (default: false)",
      "default": false
    },
    "s3_bucket": {
      "type": "string",
      "description": "S3 bucket for temporary storage (required for local files)"
    }
  },
  "required": [
    "path"
  ]
}
```

**Output schema:**
```json
{
  "type": "object",
  "properties": {
    "content": {
      "type": "string"
    },
    "page_count": {
      "type": "integer"
    },
    "char_count": {
      "type": "integer"
    },
    "tables": {
      "type": "array"
    },
    "metadata": {
      "type": "object"
    },
    "error": {
      "type": "string"
    }
  }
}
```
