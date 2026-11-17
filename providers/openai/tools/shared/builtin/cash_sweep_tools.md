# cash_sweep_tools

## parse_billing_csv
**Input schema:**
```json
{
  "type": "object",
  "properties": {
    "file_path": {
      "type": "string",
      "description": "Path to the billing preview CSV file"
    },
    "run_id": {
      "type": "string",
      "description": "Board run ID \u2014 when provided, uploads full output to S3 and returns s3_key stub"
    }
  },
  "required": [
    "file_path"
  ]
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
    "s3_key": {
      "type": "string",
      "description": "S3 key of the uploaded output JSON (returned when run_id is provided)"
    },
    "row_count": {
      "type": "integer",
      "description": "Total rows parsed"
    },
    "unique_accounts": {
      "type": "integer",
      "description": "Number of unique accounts"
    },
    "total_fees": {
      "type": "number",
      "description": "Sum of all fees"
    },
    "error": {
      "type": "string",
      "description": "Error message if parsing failed"
    }
  }
}
```

## parse_position_csv
**Input schema:**
```json
{
  "type": "object",
  "properties": {
    "file_path": {
      "type": "string",
      "description": "Path to the Schwab position export CSV file"
    },
    "run_id": {
      "type": "string",
      "description": "Board run ID \u2014 when provided, uploads full output to S3 and returns s3_key stub"
    }
  },
  "required": [
    "file_path"
  ]
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
    "s3_key": {
      "type": "string",
      "description": "S3 key of the uploaded output JSON (returned when run_id is provided)"
    },
    "row_count": {
      "type": "integer",
      "description": "Total rows parsed"
    },
    "unique_accounts": {
      "type": "integer",
      "description": "Number of unique accounts"
    },
    "error": {
      "type": "string",
      "description": "Error message if parsing failed"
    }
  }
}
```

## validate_cash_sweep_data
**Input schema:**
```json
{
  "type": "object",
  "properties": {
    "billing_records_s3_key": {
      "type": "string",
      "description": "S3 key from parse_billing_csv output"
    },
    "position_accounts_s3_key": {
      "type": "string",
      "description": "S3 key from parse_position_csv output"
    },
    "fee_debit_date": {
      "type": "string",
      "description": "Expected fee debit date (YYYY-MM-DD)"
    },
    "position_export_date": {
      "type": "string",
      "description": "Date position file was exported (YYYY-MM-DD)"
    }
  },
  "required": [
    "billing_records_s3_key",
    "position_accounts_s3_key"
  ]
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
    "warnings": {
      "type": "array",
      "description": "List of data quality warnings with code, severity, message",
      "items": {
        "type": "object"
      }
    },
    "matched_count": {
      "type": "integer",
      "description": "Number of accounts matched between billing and positions"
    },
    "unmatched_accounts": {
      "type": "array",
      "description": "List of account IDs in billing but not in positions",
      "items": {
        "type": "string"
      }
    },
    "days_until_debit": {
      "type": "integer",
      "description": "Business days until fee debit date"
    },
    "data_age_hours": {
      "type": "number",
      "description": "Hours since position data was exported"
    },
    "error": {
      "type": "string",
      "description": "Error message if validation failed"
    }
  }
}
```

## calculate_cash_shortfalls
**Input schema:**
```json
{
  "type": "object",
  "properties": {
    "billing_records_s3_key": {
      "type": "string",
      "description": "S3 key from parse_billing_csv output"
    },
    "position_accounts_s3_key": {
      "type": "string",
      "description": "S3 key from parse_position_csv output"
    },
    "run_id": {
      "type": "string",
      "description": "Board run ID \u2014 when provided, uploads output to S3 and returns s3_key stub"
    },
    "buffer_percentage": {
      "type": "number",
      "description": "Safety buffer as percentage of fee (default 0.05 = 5%)"
    },
    "minimum_buffer": {
      "type": "number",
      "description": "Minimum buffer amount in dollars (default 50)"
    }
  },
  "required": [
    "billing_records_s3_key",
    "position_accounts_s3_key"
  ]
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
    "s3_key": {
      "type": "string",
      "description": "S3 key of the uploaded output JSON (returned when run_id is provided)"
    },
    "total_shortfall": {
      "type": "number",
      "description": "Total dollar shortfall across all accounts"
    },
    "accounts_with_shortfall": {
      "type": "integer",
      "description": "Count of accounts with cash shortfall"
    },
    "total_accounts": {
      "type": "integer",
      "description": "Total accounts analyzed"
    },
    "error": {
      "type": "string",
      "description": "Error message if calculation failed"
    }
  }
}
```

## classify_cash_sweep_accounts
**Input schema:**
```json
{
  "type": "object",
  "properties": {
    "analyzed_accounts_s3_key": {
      "type": "string",
      "description": "S3 key from calculate_cash_shortfalls output"
    },
    "run_id": {
      "type": "string",
      "description": "Board run ID \u2014 when provided, uploads output to S3 and returns s3_key stub"
    },
    "excess_cash_threshold": {
      "type": "number",
      "description": "Minimum excess cash to flag for efficiency (default 5000)"
    },
    "sweep_rate": {
      "type": "number",
      "description": "Current bank sweep APY (default 0.0045 = 0.45%)"
    },
    "mmf_rate": {
      "type": "number",
      "description": "Available MMF APY (default 0.051 = 5.1%)"
    }
  },
  "required": [
    "analyzed_accounts_s3_key"
  ]
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
    "s3_key": {
      "type": "string",
      "description": "S3 key of the uploaded output JSON containing all classified account lists"
    },
    "summary": {
      "type": "object",
      "description": "Summary statistics with counts and totals by category"
    },
    "error": {
      "type": "string",
      "description": "Error message if classification failed"
    }
  }
}
```

## generate_cash_sweep_trades
**Input schema:**
```json
{
  "type": "object",
  "properties": {
    "classify_s3_key": {
      "type": "string",
      "description": "S3 key from classify_cash_sweep_accounts output"
    },
    "minimum_trade_amount": {
      "type": "number",
      "description": "Minimum trade amount in dollars (default 10)"
    }
  },
  "required": [
    "classify_s3_key"
  ]
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
    "trade_orders": {
      "type": "array",
      "description": "List of MMF sell orders ready for execution",
      "items": {
        "type": "object"
      }
    },
    "trade_count": {
      "type": "integer",
      "description": "Number of trade orders generated"
    },
    "total_trade_amount": {
      "type": "number",
      "description": "Total dollar amount of all trades"
    },
    "trades_by_symbol": {
      "type": "object",
      "description": "Trade counts and amounts grouped by MMF symbol"
    },
    "excluded_trades": {
      "type": "array",
      "description": "Accounts excluded from trading with reasons",
      "items": {
        "type": "object"
      }
    },
    "error": {
      "type": "string",
      "description": "Error message if trade generation failed"
    }
  }
}
```

## create_schwab_trade_file
**Input schema:**
```json
{
  "type": "object",
  "properties": {
    "trade_orders": {
      "type": "array",
      "description": "List of trade orders from generate_cash_sweep_trades"
    },
    "run_id": {
      "type": "string",
      "description": "Optional run ID for file naming and storage"
    }
  },
  "required": []
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
    "download_url": {
      "type": "string",
      "description": "S3 presigned URL for downloading the trade file"
    },
    "file_key": {
      "type": "string",
      "description": "S3 file key for the uploaded trade file"
    },
    "filename": {
      "type": "string",
      "description": "Generated filename for the trade file"
    },
    "file_content_preview": {
      "type": "string",
      "description": "First 500 characters of the CSV file"
    },
    "total_orders": {
      "type": "integer",
      "description": "Number of orders in the trade file"
    },
    "file_size_bytes": {
      "type": "integer",
      "description": "Size of the generated file in bytes"
    },
    "error": {
      "type": "string",
      "description": "Error message if file creation failed"
    }
  }
}
```

## create_analysis_export_csv
**Input schema:**
```json
{
  "type": "object",
  "properties": {
    "classify_s3_key": {
      "type": "string",
      "description": "S3 key from classify_cash_sweep_accounts output"
    }
  },
  "required": [
    "classify_s3_key"
  ]
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
    "download_url": {
      "type": "string",
      "description": "S3 presigned URL for downloading the analysis export"
    },
    "file_key": {
      "type": "string",
      "description": "S3 file key for the uploaded export file"
    },
    "filename": {
      "type": "string",
      "description": "Generated filename for the export file"
    },
    "file_content_preview": {
      "type": "string",
      "description": "First 500 characters of the CSV file"
    },
    "total_accounts": {
      "type": "integer",
      "description": "Total number of accounts in the export"
    },
    "classification_counts": {
      "type": "object",
      "description": "Count of accounts by classification category"
    },
    "error": {
      "type": "string",
      "description": "Error message if export creation failed"
    }
  }
}
```

## create_billing_file_export
**Input schema:**
```json
{
  "type": "object",
  "properties": {
    "classify_s3_key": {
      "type": "string",
      "description": "S3 key from classify_cash_sweep_accounts output"
    },
    "billing_s3_key": {
      "type": "string",
      "description": "S3 key from parse_billing_csv output (used to fetch original_headers)"
    }
  },
  "required": [
    "classify_s3_key"
  ]
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
    "download_url": {
      "type": "string",
      "description": "S3 presigned URL for downloading the billing export"
    },
    "filename": {
      "type": "string",
      "description": "Generated filename for the export file"
    },
    "total_accounts": {
      "type": "integer",
      "description": "Total accounts in the export"
    },
    "valid_count": {
      "type": "integer",
      "description": "Number of valid accounts"
    },
    "inefficiency_count": {
      "type": "integer",
      "description": "Number of inefficiency accounts"
    },
    "error": {
      "type": "string",
      "description": "Error message if export creation failed"
    }
  }
}
```

## generate_cash_sweep_report
**Input schema:**
```json
{
  "type": "object",
  "properties": {
    "classify_s3_key": {
      "type": "string",
      "description": "S3 key from classify_cash_sweep_accounts output"
    },
    "trade_orders": {
      "type": "array",
      "description": "List of trade orders from generate_cash_sweep_trades"
    },
    "trade_file_download_url": {
      "type": "string",
      "description": "S3 presigned URL for trade file"
    },
    "analysis_export_download_url": {
      "type": "string",
      "description": "S3 presigned URL for analysis export"
    },
    "billing_file_download_url": {
      "type": "string",
      "description": "S3 presigned URL for billing export"
    },
    "data_warnings": {
      "type": "array",
      "description": "Data quality warnings"
    },
    "total_fees": {
      "type": "number",
      "description": "Total fees being analyzed"
    },
    "billing_unique_accounts": {
      "type": "integer"
    },
    "matched_account_count": {
      "type": "integer"
    },
    "unmatched_accounts": {
      "type": "array"
    },
    "days_until_debit": {
      "type": "integer"
    },
    "fee_debit_date": {
      "type": "string"
    },
    "trade_count": {
      "type": "integer"
    },
    "total_trade_amount": {
      "type": "number"
    },
    "trades_by_symbol": {
      "type": "object"
    },
    "report_summary_text": {
      "type": "string"
    },
    "critical_insight": {
      "type": "string"
    },
    "manual_review_insight": {
      "type": "string"
    },
    "efficiency_insight": {
      "type": "string"
    },
    "ok_insight": {
      "type": "string"
    },
    "generated_next_steps": {
      "type": "array"
    }
  },
  "required": [
    "classify_s3_key"
  ]
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
    "html_report": {
      "type": "string",
      "description": "Complete HTML report with embedded CSS using PitCrew design system"
    },
    "content_type": {
      "type": "string",
      "description": "Content type indicator (always \"html\")"
    },
    "error": {
      "type": "string",
      "description": "Error message if report generation failed"
    }
  }
}
```
