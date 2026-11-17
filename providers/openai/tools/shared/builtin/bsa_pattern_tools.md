# bsa_pattern_tools

## detect_bsa_patterns
**Input schema:**
```json
{
  "type": "object",
  "required": [
    "transactions_file"
  ],
  "properties": {
    "transactions_file": {
      "type": "string",
      "description": "File path or S3 key of the transaction CSV. Required columns: txn_id, date, account_id, customer_name, type, amount. Optional: branch, counterparty."
    },
    "risk_ratings_file": {
      "type": "string",
      "description": "Optional file path or S3 key of a risk ratings CSV with columns: account_id, rating (low/med/high)."
    },
    "config": {
      "type": "object",
      "description": "Optional threshold overrides. Omitted keys use BSA defaults.",
      "properties": {
        "structuring": {
          "type": "object"
        },
        "velocity": {
          "type": "object"
        },
        "round_trip": {
          "type": "object"
        }
      }
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
    "total_transactions": {
      "type": "integer"
    },
    "flags_count": {
      "type": "integer"
    },
    "high_severity_count": {
      "type": "integer"
    },
    "medium_severity_count": {
      "type": "integer"
    },
    "dismissals_count": {
      "type": "integer"
    },
    "triage_flags_s3_key": {
      "type": "string"
    },
    "triage_flags_download_url": {
      "type": "string",
      "description": "Download link for triage_flags.csv"
    },
    "dismissal_log_s3_key": {
      "type": "string"
    },
    "dismissal_log_download_url": {
      "type": "string",
      "description": "Download link for dismissal_log.csv"
    },
    "flags": {
      "type": "array",
      "description": "Ranked flags passed to draft_sar_narratives"
    },
    "dismissal_log": {
      "type": "array"
    },
    "error": {
      "type": "string"
    }
  }
}
```

## draft_sar_narratives
**Input schema:**
```json
{
  "type": "object",
  "required": [
    "flags"
  ],
  "properties": {
    "flags": {
      "type": "array",
      "description": "Ranked flags array from detect_bsa_patterns output."
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
    "flags_processed": {
      "type": "integer"
    },
    "triage_with_narratives_s3_key": {
      "type": "string"
    },
    "triage_with_narratives_download_url": {
      "type": "string",
      "description": "Download link for triage_flags_with_narratives.csv"
    },
    "error": {
      "type": "string"
    }
  }
}
```
