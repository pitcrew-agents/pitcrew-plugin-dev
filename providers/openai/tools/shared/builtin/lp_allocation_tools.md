# lp_allocation_tools

## parse_lp_csv
**Input schema:**
```json
{
  "type": "object",
  "properties": {
    "file_path": {
      "type": "string",
      "description": "S3 path (s3://bucket/key) or local file path to LP Setup CSV"
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
    "lp_records": {
      "type": "array",
      "description": "List of parsed LP records with all fields"
    },
    "total_lp_commitments": {
      "type": "number",
      "description": "Sum of all LP capital commitments"
    },
    "validation_errors": {
      "type": "array",
      "description": "List of validation error messages"
    },
    "count": {
      "type": "integer"
    },
    "message": {
      "type": "string"
    }
  }
}
```

## parse_fund_itd_csv
**Input schema:**
```json
{
  "type": "object",
  "properties": {
    "file_path": {
      "type": "string",
      "description": "S3 path (s3://bucket/key) or local file path to Fund ITD CSV"
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
    "fund_itd": {
      "type": "object",
      "description": "Parsed fund-level ITD totals"
    },
    "validation_errors": {
      "type": "array",
      "description": "List of validation warnings"
    },
    "message": {
      "type": "string"
    }
  }
}
```

## parse_fund_quarterly_csv
**Input schema:**
```json
{
  "type": "object",
  "properties": {
    "file_path": {
      "type": "string",
      "description": "S3 path (s3://bucket/key) or local file path to Fund Quarterly CSV"
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
    "fund_quarterly": {
      "type": "object",
      "description": "Parsed fund-level quarterly totals"
    },
    "validation_errors": {
      "type": "array",
      "description": "List of validation warnings"
    },
    "message": {
      "type": "string"
    }
  }
}
```

## generate_allocation_itd
**Input schema:**
```json
{
  "type": "object",
  "properties": {
    "lp_records": {
      "type": "array",
      "description": "Parsed LP records from parse_lp_csv"
    },
    "fund_itd": {
      "type": "object",
      "description": "Parsed fund ITD totals from parse_fund_itd_csv"
    },
    "output_path": {
      "type": "string",
      "description": "Optional S3 or local path for output. If omitted, uploads to S3 automatically."
    },
    "run_id": {
      "type": "string",
      "description": "Optional run ID for S3 path generation"
    }
  },
  "required": [
    "lp_records",
    "fund_itd"
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
    "output_path": {
      "type": "string",
      "description": "Pre-signed download URL"
    },
    "download_url": {
      "type": "string",
      "description": "Pre-signed download URL"
    },
    "s3_path": {
      "type": "string",
      "description": "S3 path (s3://bucket/key) for use as input to other tools"
    },
    "filename": {
      "type": "string",
      "description": "Clean filename without UUID prefix, for use as Drive/email attachment name"
    },
    "summary": {
      "type": "object"
    },
    "message": {
      "type": "string"
    }
  }
}
```

## generate_allocation_q126
**Input schema:**
```json
{
  "type": "object",
  "properties": {
    "lp_records": {
      "type": "array",
      "description": "Parsed LP records from parse_lp_csv"
    },
    "fund_itd": {
      "type": "object",
      "description": "Parsed fund ITD totals from parse_fund_itd_csv"
    },
    "fund_quarterly": {
      "type": "object",
      "description": "Parsed fund quarterly totals from parse_fund_quarterly_csv"
    },
    "output_path": {
      "type": "string",
      "description": "Optional S3 or local path for output. If omitted, uploads to S3 automatically."
    },
    "run_id": {
      "type": "string",
      "description": "Optional run ID for S3 path generation"
    }
  },
  "required": [
    "lp_records",
    "fund_itd",
    "fund_quarterly"
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
    "output_path": {
      "type": "string",
      "description": "Pre-signed download URL"
    },
    "download_url": {
      "type": "string",
      "description": "Pre-signed download URL"
    },
    "s3_path": {
      "type": "string",
      "description": "S3 path (s3://bucket/key) for use as input to other tools"
    },
    "filename": {
      "type": "string",
      "description": "Clean filename without UUID prefix, for use as Drive/email attachment name"
    },
    "summary": {
      "type": "object"
    },
    "message": {
      "type": "string"
    }
  }
}
```

## get_lp_statement_data
**Input schema:**
```json
{
  "type": "object",
  "properties": {
    "allocation_itd_path": {
      "type": "string",
      "description": "S3 or local path to AllocationITD xlsx file"
    },
    "allocation_q126_path": {
      "type": "string",
      "description": "S3 or local path to AllocationQ126 xlsx file"
    },
    "partner_numbers": {
      "type": "array",
      "items": {
        "type": "string"
      },
      "description": "Optional list of partner numbers to filter; omit to return all LPs"
    }
  },
  "required": [
    "allocation_itd_path",
    "allocation_q126_path"
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
    "fund_name": {
      "type": "string"
    },
    "period_end": {
      "type": "string"
    },
    "quarter": {
      "type": "string"
    },
    "lp_statements": {
      "type": "array",
      "description": "Per-LP structured data for statement generation"
    },
    "count": {
      "type": "integer"
    },
    "message": {
      "type": "string"
    }
  }
}
```

## generate_lp_statement_pdf
**Input schema:**
```json
{
  "type": "object",
  "properties": {
    "lp_statements": {
      "type": "array",
      "description": "List of LP statement dicts from get_lp_statement_data"
    },
    "fund_name": {
      "type": "string",
      "description": "Fund name for PDF header"
    },
    "period_end": {
      "type": "string",
      "description": "Period end display string e.g. 03/31/2026"
    },
    "quarter": {
      "type": "string",
      "description": "Quarter label e.g. Q1 2026"
    },
    "partner_numbers": {
      "type": "array",
      "items": {
        "type": "string"
      },
      "description": "Optional filter \u2014 omit to generate PDFs for all LPs"
    },
    "run_id": {
      "type": "string"
    }
  },
  "required": [
    "lp_statements",
    "fund_name",
    "period_end",
    "quarter"
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
    "statements": {
      "type": "array",
      "description": "List of {partner_number, partner_name, account_id, filename, download_url, s3_path} \u2014 filename follows format: BGVII-<ACCOUNT_ID> BGV II LP Partner Cap Stmt <Q> <YEAR> <PARTNER_NAME>.pdf"
    },
    "count": {
      "type": "integer"
    },
    "message": {
      "type": "string"
    }
  }
}
```

## validate_lp_statement_data
**Input schema:**
```json
{
  "type": "object",
  "properties": {
    "lp_statements": {
      "type": "array",
      "description": "List of LP statement dicts from get_lp_statement_data"
    },
    "lp_data": {
      "type": "object",
      "description": "Single LP data dict from parse_bgv_excel"
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
      "type": "boolean",
      "description": "False if any LP has transfer_of_interest > 0"
    },
    "valid_count": {
      "type": "integer"
    },
    "error_count": {
      "type": "integer"
    },
    "errors": {
      "type": "array",
      "description": "List of {partner_number, partner_name, missing_fields, message} for blocked partners"
    },
    "valid_partner_numbers": {
      "type": "array"
    },
    "message": {
      "type": "string"
    }
  }
}
```

## parse_bgv_excel
**Input schema:**
```json
{
  "type": "object",
  "properties": {
    "file_path": {
      "type": "string",
      "description": "S3 or local path to the BGV Excel file (with Allocation ITD and Allocation Q126 sheets)"
    },
    "partner_number": {
      "type": "string",
      "description": "Partner number to extract (e.g. \"17\")"
    }
  },
  "required": [
    "file_path",
    "partner_number"
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
    "lp_data": {
      "type": "object",
      "description": "Structured LP data including main fund and co-investment sections"
    },
    "message": {
      "type": "string"
    }
  }
}
```

## generate_bgv_statement_pdf
**Input schema:**
```json
{
  "type": "object",
  "properties": {
    "lp_data": {
      "type": "object",
      "description": "LP data dict from parse_bgv_excel"
    },
    "quarter": {
      "type": "string",
      "description": "Quarter label e.g. Q1 2026"
    },
    "period_end": {
      "type": "string",
      "description": "Period end display string e.g. March 31, 2026"
    },
    "fund_name": {
      "type": "string",
      "description": "Fund name for the PDF header"
    },
    "run_id": {
      "type": "string"
    }
  },
  "required": [
    "lp_data",
    "quarter",
    "period_end",
    "fund_name"
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
      "type": "string"
    },
    "s3_path": {
      "type": "string"
    },
    "filename": {
      "type": "string"
    },
    "message": {
      "type": "string"
    }
  }
}
```
