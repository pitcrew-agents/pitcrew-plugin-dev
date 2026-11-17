# tradepmr_acroform_extractor

## extract_tradepmr_form
**Input schema:**
```json
{
  "type": "object",
  "properties": {
    "pdf_path": {
      "type": "string",
      "description": "Local path to the filled TradePMR New Account Application PDF (Individual/Joint/Custodian). Automatically uses AcroForm extraction for digitally-filled PDFs (fast, ~50ms, 100% accurate on checkboxes) and falls back to AWS Textract FORMS for scanned/printed PDFs."
    },
    "s3_bucket": {
      "type": "string",
      "description": "S3 bucket for the Textract fallback path. Defaults to the app config value (pdf_extraction.s3_bucket). Not needed for digitally-filled PDFs."
    },
    "max_wait_seconds": {
      "type": "integer",
      "description": "Max seconds to wait for Textract job (default 300, fallback only).",
      "default": 300
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
  "description": "Structured extraction of all form fields.",
  "properties": {
    "header": {
      "type": "object"
    },
    "registration_type": {
      "type": "object"
    },
    "primary_holder": {
      "type": "object"
    },
    "secondary_holder": {
      "type": [
        "object",
        "null"
      ]
    },
    "margin": {
      "type": "object"
    },
    "service_instructions": {
      "type": "object"
    },
    "interested_party": {
      "type": "object"
    },
    "trusted_contact": {
      "type": "object"
    },
    "certification": {
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
