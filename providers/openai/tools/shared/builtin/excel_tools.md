# excel_tools

## read_excel
**Input schema:**
```json
{
  "type": "object",
  "properties": {
    "path": {
      "type": "string",
      "description": "Path to the Excel file to read."
    },
    "table_name": {
      "type": "string",
      "description": "Table (sheet) to read. With all_sheets=False (default): reads this table or the active table if not specified. With all_sheets=True: acts as a whitelist \u2014 only this table is returned."
    },
    "filter_column": {
      "type": "string",
      "description": "Column name to filter rows on. Requires filter_value."
    },
    "filter_value": {
      "oneOf": [
        {
          "type": "string"
        },
        {
          "type": "array",
          "items": {
            "type": "string"
          }
        }
      ],
      "description": "Value(s) to match in filter_column (string comparison). With all_sheets=True and no table_name: filter applies to all tables. With table_name set: filter applies only to that table; other tables return unfiltered data."
    },
    "all_sheets": {
      "type": "boolean",
      "description": "If true, return all tables (or only table_name if set as whitelist). If false (default), return one table \u2014 table_name or the active table.",
      "default": false
    },
    "llm_fallback": {
      "type": "boolean",
      "description": "If true, use an LLM call via Bedrock to detect the header row when the heuristic finds no string-to-number transition (e.g. fully text-based tables). If false (default), assumes row 0 is the header \u2014 fully deterministic, no LLM call.",
      "default": false
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
    "path": {
      "type": "string",
      "description": "Absolute validated path of the file that was read."
    },
    "table_name": {
      "oneOf": [
        {
          "type": "string"
        },
        {
          "type": "array",
          "items": {
            "type": "string"
          }
        }
      ],
      "description": "Name(s) of the table(s) present in this response. A string when a single sheet was read; a list when multiple sheets were read. Use these names as keys to access individual sheet data, e.g. output[\"Sales\"]."
    },
    "error": {
      "type": "string",
      "description": "Present only on top-level failure. Describes what went wrong."
    }
  },
  "additionalProperties": {
    "type": "object",
    "description": "Each additional key is a table name matching an entry in the \"table_name\" field. Access table data via output[table_name] or in output_mapping as TableName.data, TableName.headers, TableName.column_sums, etc. When no table_name input is provided and all_sheets=False, an additional \"_active\" key is also present alongside the literal table name key, pointing to the same data. Use \"_active\" in board output mappings when the table name is not known at board design time (e.g. user-uploaded files with variable table names). When table_name is specified as input, \"_active\" is absent.",
    "properties": {
      "pre_headers": {
        "type": "array",
        "items": {
          "type": "array",
          "items": {}
        },
        "description": "Rows above the detected header row, each as a list of serialized cell values. Empty list when the header row is row 0.",
        "default": []
      },
      "headers": {
        "type": "array",
        "items": {
          "type": "string"
        },
        "description": "Column header names from the detected header row."
      },
      "data": {
        "type": "array",
        "items": {
          "type": "object",
          "additionalProperties": true
        },
        "description": "Data rows as a list of dicts. Each dict maps column header to cell value. When filter_column is set, only matching rows appear."
      },
      "row_count": {
        "type": "integer",
        "description": "Number of rows in data (after filtering, if applicable)."
      },
      "column_count": {
        "type": "integer",
        "description": "Number of columns derived from the header row."
      },
      "column_sums": {
        "type": "object",
        "additionalProperties": {
          "type": "number"
        },
        "description": "Sum of each numeric column across all data rows. Only present when at least one numeric column exists."
      },
      "filter_applied": {
        "type": "object",
        "description": "Present only when filter_column was applied to this sheet.",
        "properties": {
          "column": {
            "type": "string",
            "description": "The column that was filtered on."
          },
          "values": {
            "type": "array",
            "items": {
              "type": "string"
            },
            "description": "The filter values matched against (normalized to strings)."
          },
          "total_rows_scanned": {
            "type": "integer",
            "description": "Total data rows examined before filtering."
          },
          "rows_matched": {
            "type": "integer",
            "description": "Number of rows that matched the filter."
          },
          "column_not_found": {
            "type": "boolean",
            "description": "Present and true when filter_column did not exist in this sheet. data will be empty."
          }
        }
      },
      "error": {
        "type": "string",
        "description": "Present only when this specific sheet could not be read."
      }
    }
  }
}
```

## write_excel
**Input schema:**
```json
{
  "type": "object",
  "properties": {
    "path": {
      "type": "string",
      "description": "Path to the Excel file to create/overwrite"
    },
    "data": {
      "type": "array",
      "items": {
        "type": "object"
      },
      "description": "List of dictionaries representing rows (keys are column headers)"
    },
    "sheet_name": {
      "type": "string",
      "description": "Name of the sheet to create (optional, defaults to \"Sheet1\")"
    }
  },
  "required": [
    "path",
    "data"
  ]
}
```

**Output schema:**
```json
{
  "type": "object",
  "properties": {
    "path": {
      "type": "string"
    },
    "sheet_name": {
      "type": "string"
    },
    "row_count": {
      "type": "integer"
    },
    "column_count": {
      "type": "integer"
    },
    "headers": {
      "type": "array",
      "items": {
        "type": "string"
      }
    },
    "success": {
      "type": "boolean"
    },
    "error": {
      "type": "string"
    }
  }
}
```

## read_excel_sheet
**Input schema:**
```json
{
  "type": "object",
  "properties": {
    "path": {
      "type": "string",
      "description": "Path to the Excel file"
    },
    "sheet_name": {
      "type": "string",
      "description": "Name of the sheet to read (required)"
    }
  },
  "required": [
    "path",
    "sheet_name"
  ]
}
```

**Output schema:**
```json
{
  "type": "object",
  "description": "Same format as read_excel output scoped to the requested sheet. Access data via output[sheet_name].data, headers via output[sheet_name].headers, etc.",
  "properties": {
    "path": {
      "type": "string",
      "description": "Validated path of the file read."
    },
    "sheets": {
      "type": "array",
      "items": {
        "type": "string"
      },
      "description": "Single-item list containing the requested sheet name."
    },
    "error": {
      "type": "string",
      "description": "Present only on top-level failure."
    }
  },
  "additionalProperties": {
    "type": "object",
    "description": "The requested sheet object, keyed by its name.",
    "properties": {
      "pre_headers": {
        "type": "array",
        "items": {
          "type": "array",
          "items": {}
        },
        "description": "Rows above the detected header row. Empty list when header is row 0.",
        "default": []
      },
      "headers": {
        "type": "array",
        "items": {
          "type": "string"
        },
        "description": "Column header names from the detected header row."
      },
      "data": {
        "type": "array",
        "items": {
          "type": "object",
          "additionalProperties": true
        },
        "description": "Data rows as a list of dicts keyed by column header."
      },
      "row_count": {
        "type": "integer",
        "description": "Number of rows in data."
      },
      "column_count": {
        "type": "integer",
        "description": "Number of columns in the header row."
      },
      "column_sums": {
        "type": "object",
        "additionalProperties": {
          "type": "number"
        },
        "description": "Sum of each numeric column. Only present when numeric columns exist."
      },
      "filter_applied": {
        "type": "object",
        "description": "Present only when filter_column was applied.",
        "properties": {
          "column": {
            "type": "string",
            "description": "Column filtered on."
          },
          "values": {
            "type": "array",
            "items": {
              "type": "string"
            },
            "description": "Filter values matched against."
          },
          "total_rows_scanned": {
            "type": "integer",
            "description": "Rows examined before filtering."
          },
          "rows_matched": {
            "type": "integer",
            "description": "Rows that matched the filter."
          },
          "column_not_found": {
            "type": "boolean",
            "description": "True when filter_column was not found in this sheet."
          }
        }
      },
      "error": {
        "type": "string",
        "description": "Present only when this sheet could not be read."
      }
    }
  }
}
```

## compute_lease_renewal_dates
**Input schema:**
```json
{
  "type": "object",
  "required": [
    "tenant_name",
    "action_deadline"
  ],
  "properties": {
    "tenant_name": {
      "type": "string",
      "description": "Tenant name \u2014 used in event summaries"
    },
    "unit": {
      "type": "string",
      "description": "Unit identifier"
    },
    "action_deadline": {
      "type": "string",
      "description": "Action deadline date (YYYY-MM-DD)"
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
    "events": {
      "type": "array",
      "items": {
        "type": "object",
        "properties": {
          "summary": {
            "type": "string"
          },
          "start_datetime": {
            "type": "string"
          },
          "description": {
            "type": "string"
          }
        }
      }
    },
    "error": {
      "type": "string"
    }
  }
}
```

## build_sheet_range
**Input schema:**
```json
{
  "type": "object",
  "required": [
    "column",
    "row_number"
  ],
  "properties": {
    "column": {
      "type": "string",
      "description": "Column letter (e.g. \"N\")"
    },
    "row_number": {
      "type": "integer",
      "description": "1-based row number"
    },
    "sheet_name": {
      "type": "string",
      "description": "Sheet tab name (default \"Sheet1\")"
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
    "range": {
      "type": "string",
      "description": "A1 notation string e.g. \"Sheet1!N5\""
    }
  }
}
```

## parse_google_sheet_url
**Input schema:**
```json
{
  "type": "object",
  "required": [
    "url"
  ],
  "properties": {
    "url": {
      "type": "string",
      "description": "Full Google Sheets URL"
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
    "spreadsheet_id": {
      "type": "string",
      "description": "Spreadsheet ID extracted from URL"
    },
    "gid": {
      "type": "string",
      "description": "Sheet tab gid if present, else null"
    },
    "error": {
      "type": "string"
    }
  }
}
```

## filter_dataframe
**Input schema:**
```json
{
  "type": "object",
  "properties": {
    "data": {
      "type": "array",
      "description": "2D array where first row is headers (e.g. from GOOGLESHEETS_BATCH_GET valueRanges[0].values). Provide this OR csv_path.",
      "items": {
        "type": "array"
      }
    },
    "csv_path": {
      "type": "string",
      "description": "Local path to a CSV file. Provide this OR data."
    },
    "filters": {
      "type": "array",
      "description": "Declarative filter rules applied sequentially. Supported types: date_range, equals, not_equals, blank, not_blank.",
      "items": {
        "type": "object",
        "required": [
          "type",
          "column"
        ],
        "properties": {
          "type": {
            "type": "string",
            "enum": [
              "date_range",
              "equals",
              "not_equals",
              "blank",
              "not_blank",
              "gt",
              "gte",
              "lt",
              "lte"
            ]
          },
          "column": {
            "type": "string",
            "description": "Column name to filter on"
          },
          "min_days": {
            "type": "integer",
            "description": "For date_range: minimum days from today (inclusive)"
          },
          "max_days": {
            "type": "integer",
            "description": "For date_range: maximum days from today (inclusive)"
          },
          "value": {
            "type": "string",
            "description": "For equals/not_equals/gt/gte/lt/lte: value to compare. For numeric columns pass a number as string (e.g. \"1000\"). For date columns pass ISO date string (e.g. \"2027-01-01\")."
          }
        }
      }
    },
    "computed_fields": {
      "type": "array",
      "description": "Extra columns to compute after filtering. Supported types: days_from_today, date_subtract.",
      "items": {
        "type": "object",
        "required": [
          "name",
          "type",
          "column"
        ],
        "properties": {
          "name": {
            "type": "string",
            "description": "Output column name"
          },
          "type": {
            "type": "string",
            "enum": [
              "days_from_today",
              "date_subtract"
            ]
          },
          "column": {
            "type": "string",
            "description": "Source date column"
          },
          "days": {
            "description": "For date_subtract: integer number of days, or name of another column containing the value"
          }
        }
      }
    },
    "include_row_number": {
      "type": "boolean",
      "description": "Include 1-based row_number in output (accounts for header row). Default true. Useful for writing back to the sheet.",
      "default": true
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
    "total_input": {
      "type": "integer",
      "description": "Total rows before filtering"
    },
    "total_matched": {
      "type": "integer",
      "description": "Rows remaining after all filters"
    },
    "rows": {
      "type": "array",
      "items": {
        "type": "object"
      },
      "description": "Filtered rows as list of dicts. Includes row_number if include_row_number=true."
    },
    "error": {
      "type": "string"
    }
  }
}
```

## list_excel_sheets
**Input schema:**
```json
{
  "type": "object",
  "properties": {
    "path": {
      "type": "string",
      "description": "Path to the Excel file"
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
    "sheets": {
      "type": "array",
      "items": {
        "type": "string"
      }
    },
    "count": {
      "type": "integer"
    },
    "path": {
      "type": "string"
    },
    "error": {
      "type": "string"
    }
  }
}
```
