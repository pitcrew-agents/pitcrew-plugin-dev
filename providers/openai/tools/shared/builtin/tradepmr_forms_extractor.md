# tradepmr_forms_extractor

## extract_account_linking
**Input schema:**
```json
{
  "type": "object",
  "properties": {
    "pdf_path": {
      "type": "string",
      "description": "Local path to the filled PDF."
    },
    "s3_bucket": {
      "type": "string",
      "description": "S3 bucket for Textract fallback. Defaults to app config."
    },
    "max_wait_seconds": {
      "type": "integer",
      "description": "Max seconds to wait for Textract job (default 300).",
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
  "description": "Extract fields from the TradePMR Account Linking Application.",
  "properties": {
    "_meta": {
      "type": "object"
    },
    "error": {
      "type": "string"
    }
  },
  "additionalProperties": true
}
```

## extract_account_transfer
**Input schema:**
```json
{
  "type": "object",
  "properties": {
    "pdf_path": {
      "type": "string",
      "description": "Local path to the filled PDF."
    },
    "s3_bucket": {
      "type": "string",
      "description": "S3 bucket for Textract fallback. Defaults to app config."
    },
    "max_wait_seconds": {
      "type": "integer",
      "description": "Max seconds to wait for Textract job (default 300).",
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
  "description": "Extract fields from the TradePMR Account Transfer Form (ACAT).",
  "properties": {
    "_meta": {
      "type": "object"
    },
    "error": {
      "type": "string"
    }
  },
  "additionalProperties": true
}
```

## extract_account_update
**Input schema:**
```json
{
  "type": "object",
  "properties": {
    "pdf_path": {
      "type": "string",
      "description": "Local path to the filled PDF."
    },
    "s3_bucket": {
      "type": "string",
      "description": "S3 bucket for Textract fallback. Defaults to app config."
    },
    "max_wait_seconds": {
      "type": "integer",
      "description": "Max seconds to wait for Textract job (default 300).",
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
  "description": "Extract fields from the TradePMR Account Update Form.",
  "properties": {
    "_meta": {
      "type": "object"
    },
    "error": {
      "type": "string"
    }
  },
  "additionalProperties": true
}
```

## extract_ach_authorization
**Input schema:**
```json
{
  "type": "object",
  "properties": {
    "pdf_path": {
      "type": "string",
      "description": "Local path to the filled PDF."
    },
    "s3_bucket": {
      "type": "string",
      "description": "S3 bucket for Textract fallback. Defaults to app config."
    },
    "max_wait_seconds": {
      "type": "integer",
      "description": "Max seconds to wait for Textract job (default 300).",
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
  "description": "Extract fields from the TradePMR ACH Authorization Agreement.",
  "properties": {
    "_meta": {
      "type": "object"
    },
    "error": {
      "type": "string"
    }
  },
  "additionalProperties": true
}
```

## extract_client_signature_verification
**Input schema:**
```json
{
  "type": "object",
  "properties": {
    "pdf_path": {
      "type": "string",
      "description": "Local path to the filled PDF."
    },
    "s3_bucket": {
      "type": "string",
      "description": "S3 bucket for Textract fallback. Defaults to app config."
    },
    "max_wait_seconds": {
      "type": "integer",
      "description": "Max seconds to wait for Textract job (default 300).",
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
  "description": "Extract fields from the TradePMR Client Signature Verification form.",
  "properties": {
    "_meta": {
      "type": "object"
    },
    "error": {
      "type": "string"
    }
  },
  "additionalProperties": true
}
```

## extract_daily_trade_confirmation_waiver
**Input schema:**
```json
{
  "type": "object",
  "properties": {
    "pdf_path": {
      "type": "string",
      "description": "Local path to the filled PDF."
    },
    "s3_bucket": {
      "type": "string",
      "description": "S3 bucket for Textract fallback. Defaults to app config."
    },
    "max_wait_seconds": {
      "type": "integer",
      "description": "Max seconds to wait for Textract job (default 300).",
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
  "description": "Extract fields from the TradePMR Daily Trade Confirmation Waiver.",
  "properties": {
    "_meta": {
      "type": "object"
    },
    "error": {
      "type": "string"
    }
  },
  "additionalProperties": true
}
```

## extract_drs_transfer
**Input schema:**
```json
{
  "type": "object",
  "properties": {
    "pdf_path": {
      "type": "string",
      "description": "Local path to the filled PDF."
    },
    "s3_bucket": {
      "type": "string",
      "description": "S3 bucket for Textract fallback. Defaults to app config."
    },
    "max_wait_seconds": {
      "type": "integer",
      "description": "Max seconds to wait for Textract job (default 300).",
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
  "description": "Extract fields from the TradePMR DRS Transfer Authorization.",
  "properties": {
    "_meta": {
      "type": "object"
    },
    "error": {
      "type": "string"
    }
  },
  "additionalProperties": true
}
```

## extract_ira_distribution
**Input schema:**
```json
{
  "type": "object",
  "properties": {
    "pdf_path": {
      "type": "string",
      "description": "Local path to the filled PDF."
    },
    "s3_bucket": {
      "type": "string",
      "description": "S3 bucket for Textract fallback. Defaults to app config."
    },
    "max_wait_seconds": {
      "type": "integer",
      "description": "Max seconds to wait for Textract job (default 300).",
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
  "description": "Extract fields from the TradePMR IRA Distribution Request.",
  "properties": {
    "_meta": {
      "type": "object"
    },
    "error": {
      "type": "string"
    }
  },
  "additionalProperties": true
}
```

## extract_ira_minor_child
**Input schema:**
```json
{
  "type": "object",
  "properties": {
    "pdf_path": {
      "type": "string",
      "description": "Local path to the filled PDF."
    },
    "s3_bucket": {
      "type": "string",
      "description": "S3 bucket for Textract fallback. Defaults to app config."
    },
    "max_wait_seconds": {
      "type": "integer",
      "description": "Max seconds to wait for Textract job (default 300).",
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
  "description": "Extract fields from the TradePMR IRA for Minor Child form (Textract only).",
  "properties": {
    "_meta": {
      "type": "object"
    },
    "error": {
      "type": "string"
    }
  },
  "additionalProperties": true
}
```

## extract_ira_excess_removal
**Input schema:**
```json
{
  "type": "object",
  "properties": {
    "pdf_path": {
      "type": "string",
      "description": "Local path to the filled PDF."
    },
    "s3_bucket": {
      "type": "string",
      "description": "S3 bucket for Textract fallback. Defaults to app config."
    },
    "max_wait_seconds": {
      "type": "integer",
      "description": "Max seconds to wait for Textract job (default 300).",
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
  "description": "Extract fields from the TradePMR IRA Removal of Excess Contribution.",
  "properties": {
    "_meta": {
      "type": "object"
    },
    "error": {
      "type": "string"
    }
  },
  "additionalProperties": true
}
```

## extract_loa_check_journal
**Input schema:**
```json
{
  "type": "object",
  "properties": {
    "pdf_path": {
      "type": "string",
      "description": "Local path to the filled PDF."
    },
    "s3_bucket": {
      "type": "string",
      "description": "S3 bucket for Textract fallback. Defaults to app config."
    },
    "max_wait_seconds": {
      "type": "integer",
      "description": "Max seconds to wait for Textract job (default 300).",
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
  "description": "Extract fields from the TradePMR LOA for Check or Journal Transfer.",
  "properties": {
    "_meta": {
      "type": "object"
    },
    "error": {
      "type": "string"
    }
  },
  "additionalProperties": true
}
```

## extract_loa_wire
**Input schema:**
```json
{
  "type": "object",
  "properties": {
    "pdf_path": {
      "type": "string",
      "description": "Local path to the filled PDF."
    },
    "s3_bucket": {
      "type": "string",
      "description": "S3 bucket for Textract fallback. Defaults to app config."
    },
    "max_wait_seconds": {
      "type": "integer",
      "description": "Max seconds to wait for Textract job (default 300).",
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
  "description": "Extract fields from the TradePMR LOA to Wire Funds.",
  "properties": {
    "_meta": {
      "type": "object"
    },
    "error": {
      "type": "string"
    }
  },
  "additionalProperties": true
}
```

## extract_one_and_same
**Input schema:**
```json
{
  "type": "object",
  "properties": {
    "pdf_path": {
      "type": "string",
      "description": "Local path to the filled PDF."
    },
    "s3_bucket": {
      "type": "string",
      "description": "S3 bucket for Textract fallback. Defaults to app config."
    },
    "max_wait_seconds": {
      "type": "integer",
      "description": "Max seconds to wait for Textract job (default 300).",
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
  "description": "Extract fields from the TradePMR One and Same Letter.",
  "properties": {
    "_meta": {
      "type": "object"
    },
    "error": {
      "type": "string"
    }
  },
  "additionalProperties": true
}
```

## extract_options_agreement
**Input schema:**
```json
{
  "type": "object",
  "properties": {
    "pdf_path": {
      "type": "string",
      "description": "Local path to the filled PDF."
    },
    "s3_bucket": {
      "type": "string",
      "description": "S3 bucket for Textract fallback. Defaults to app config."
    },
    "max_wait_seconds": {
      "type": "integer",
      "description": "Max seconds to wait for Textract job (default 300).",
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
  "description": "Extract fields from the TradePMR Options Agreement.",
  "properties": {
    "_meta": {
      "type": "object"
    },
    "error": {
      "type": "string"
    }
  },
  "additionalProperties": true
}
```

## extract_qualified_plan_disbursement
**Input schema:**
```json
{
  "type": "object",
  "properties": {
    "pdf_path": {
      "type": "string",
      "description": "Local path to the filled PDF."
    },
    "s3_bucket": {
      "type": "string",
      "description": "S3 bucket for Textract fallback. Defaults to app config."
    },
    "max_wait_seconds": {
      "type": "integer",
      "description": "Max seconds to wait for Textract job (default 300).",
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
  "description": "Extract fields from the TradePMR Qualified Retirement Plan Disbursement LOA.",
  "properties": {
    "_meta": {
      "type": "object"
    },
    "error": {
      "type": "string"
    }
  },
  "additionalProperties": true
}
```

## extract_security_removal
**Input schema:**
```json
{
  "type": "object",
  "properties": {
    "pdf_path": {
      "type": "string",
      "description": "Local path to the filled PDF."
    },
    "s3_bucket": {
      "type": "string",
      "description": "S3 bucket for Textract fallback. Defaults to app config."
    },
    "max_wait_seconds": {
      "type": "integer",
      "description": "Max seconds to wait for Textract job (default 300).",
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
  "description": "Extract fields from the TradePMR Request for Security Removal.",
  "properties": {
    "_meta": {
      "type": "object"
    },
    "error": {
      "type": "string"
    }
  },
  "additionalProperties": true
}
```

## extract_roth_ira_conversion
**Input schema:**
```json
{
  "type": "object",
  "properties": {
    "pdf_path": {
      "type": "string",
      "description": "Local path to the filled PDF."
    },
    "s3_bucket": {
      "type": "string",
      "description": "S3 bucket for Textract fallback. Defaults to app config."
    },
    "max_wait_seconds": {
      "type": "integer",
      "description": "Max seconds to wait for Textract job (default 300).",
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
  "description": "Extract fields from the TradePMR Roth IRA Conversion form.",
  "properties": {
    "_meta": {
      "type": "object"
    },
    "error": {
      "type": "string"
    }
  },
  "additionalProperties": true
}
```

## extract_ira_recharacterization
**Input schema:**
```json
{
  "type": "object",
  "properties": {
    "pdf_path": {
      "type": "string",
      "description": "Local path to the filled PDF."
    },
    "s3_bucket": {
      "type": "string",
      "description": "S3 bucket for Textract fallback. Defaults to app config."
    },
    "max_wait_seconds": {
      "type": "integer",
      "description": "Max seconds to wait for Textract job (default 300).",
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
  "description": "Extract fields from the TradePMR IRA Recharacterization form.",
  "properties": {
    "_meta": {
      "type": "object"
    },
    "error": {
      "type": "string"
    }
  },
  "additionalProperties": true
}
```

## extract_trusted_contact_authorization
**Input schema:**
```json
{
  "type": "object",
  "properties": {
    "pdf_path": {
      "type": "string",
      "description": "Local path to the filled PDF."
    },
    "s3_bucket": {
      "type": "string",
      "description": "S3 bucket for Textract fallback. Defaults to app config."
    },
    "max_wait_seconds": {
      "type": "integer",
      "description": "Max seconds to wait for Textract job (default 300).",
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
  "description": "Extract fields from the TradePMR Trusted Contact Person Authorization.",
  "properties": {
    "_meta": {
      "type": "object"
    },
    "error": {
      "type": "string"
    }
  },
  "additionalProperties": true
}
```
