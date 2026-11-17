# custodian_forms_extractor

## extract_custodian_account_form
**Input schema:**
```json
{
  "type": "object",
  "properties": {
    "pdf_path": {
      "type": "string",
      "description": "Local path to the filled custodian account opening form PDF. The custodian is auto-detected from the filename. Supported custodians: Fidelity, Tradefusion, Goldman Sachs, Charles Schwab (account transfer), Wells Fargo WellsTrade, JPMorgan Asset Management."
    },
    "custodian": {
      "type": "string",
      "description": "Override auto-detection. One of: fidelity, tradefusion, goldman_sachs, schwab, wells_fargo, jpmorgan."
    },
    "s3_bucket": {
      "type": "string",
      "description": "S3 bucket for Textract fallback. Required for goldman_sachs, wells_fargo, and jpmorgan (Textract-only custodians). Defaults to app config."
    },
    "max_wait_seconds": {
      "type": "integer",
      "default": 300,
      "description": "Max seconds to wait for Textract job (fallback only)."
    }
  },
  "required": [
    "pdf_path"
  ]
}
```

**Output schema:**
```json
{
  "type": "object",
  "properties": {
    "custodian": {
      "type": "string"
    },
    "fields": {
      "type": "object"
    },
    "_meta": {
      "type": "object"
    },
    "error": {
      "type": "string"
    }
  }
}
```
