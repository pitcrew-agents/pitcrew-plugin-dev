# csv_analysis_tools

## analyze_csv
**Input schema:**
```json
{
  "type": "object",
  "properties": {
    "file_path": {
      "type": "string",
      "description": "Path to the spreadsheet file (CSV or Excel .xlsx/.xls)"
    },
    "prompt": {
      "type": "string",
      "description": "Natural language description of the analysis or transformation to perform"
    },
    "inputs": {
      "description": "Raw input data \u2014 can be a single string, object (dict), array, or any JSON-serializable value. Also accepts an array of mixed types. Available in generated code as `user_inputs` (list) and `user_input` (first item)."
    },
    "output_format": {
      "type": "string",
      "enum": [
        "json",
        "markdown",
        "csv",
        "excel"
      ],
      "default": "json",
      "description": "Desired output format. Use \"csv\" or \"excel\" for file outputs with download URL."
    },
    "sheet_name": {
      "type": "string",
      "description": "Optional: specific sheet name to analyze (for Excel files with multiple sheets)"
    },
    "max_iterations": {
      "type": "integer",
      "default": 5,
      "minimum": 1,
      "maximum": 10,
      "description": "Maximum ReAct iterations for error correction (default: 5)"
    },
    "output_filename": {
      "type": "string",
      "description": "Optional custom filename for file outputs (csv/excel)"
    }
  },
  "required": [
    "file_path",
    "prompt"
  ]
}
```

**Output schema:**
```json
{
  "type": "object",
  "properties": {
    "success": {
      "type": "boolean",
      "description": "Whether the analysis succeeded"
    },
    "result": {
      "description": "Analysis output (JSON object for output_format=json, string for output_format=markdown)"
    },
    "raw_output": {
      "type": "string",
      "description": "Raw stdout from code execution"
    },
    "download_url": {
      "type": "string",
      "description": "S3 presigned URL for downloading file outputs (csv/excel)"
    },
    "filename": {
      "type": "string",
      "description": "Name of the output file"
    },
    "file_size_bytes": {
      "type": "integer",
      "description": "Size of the output file in bytes"
    },
    "local_path": {
      "type": "string",
      "description": "Local file path if S3 upload failed"
    },
    "preview": {
      "type": "string",
      "description": "Preview of output data (first few rows for CSV)"
    },
    "output_row_count": {
      "type": "integer",
      "description": "Number of rows in CSV output"
    },
    "structure": {
      "type": "array",
      "description": "Analyzed structure of input file (sheets, columns, data types)",
      "items": {
        "type": "object"
      }
    },
    "final_code": {
      "type": "string",
      "description": "Final Python code that was executed successfully"
    },
    "iterations": {
      "type": "array",
      "description": "Details of each ReAct iteration",
      "items": {
        "type": "object"
      }
    },
    "total_iterations": {
      "type": "integer",
      "description": "Total number of iterations performed"
    },
    "total_time_ms": {
      "type": "integer",
      "description": "Total execution time in milliseconds"
    },
    "file_type": {
      "type": "string",
      "enum": [
        "csv",
        "excel"
      ],
      "description": "Type of the input file"
    },
    "error": {
      "type": "string",
      "description": "Error message if analysis failed"
    }
  },
  "required": [
    "success"
  ]
}
```

## analyze_csv_with_schema
**Input schema:**
```json
{
  "type": "object",
  "properties": {
    "file_path": {
      "type": "string",
      "description": "Path to the spreadsheet file (CSV or Excel)"
    },
    "prompt": {
      "type": "string",
      "description": "Natural language description of the analysis to perform"
    },
    "output_schema": {
      "type": "object",
      "description": "JSON Schema defining the expected output structure"
    },
    "max_iterations": {
      "type": "integer",
      "default": 5,
      "minimum": 1,
      "maximum": 10,
      "description": "Maximum ReAct iterations for error correction (default: 5)"
    }
  },
  "required": [
    "file_path",
    "prompt",
    "output_schema"
  ]
}
```

**Output schema:**
```json
{
  "type": "object",
  "properties": {
    "success": {
      "type": "boolean",
      "description": "Whether the analysis succeeded"
    },
    "result": {
      "description": "Analysis output conforming to the provided output_schema"
    },
    "schema_valid": {
      "type": "boolean",
      "description": "Whether the output matches the provided schema (null if jsonschema library not available)"
    },
    "schema_error": {
      "type": "string",
      "description": "Schema validation error message if validation failed"
    },
    "raw_output": {
      "type": "string",
      "description": "Raw stdout from code execution"
    },
    "structure": {
      "type": "array",
      "description": "Analyzed structure of input file",
      "items": {
        "type": "object"
      }
    },
    "final_code": {
      "type": "string",
      "description": "Final Python code that was executed"
    },
    "iterations": {
      "type": "array",
      "description": "Details of each ReAct iteration",
      "items": {
        "type": "object"
      }
    },
    "total_iterations": {
      "type": "integer",
      "description": "Total number of iterations performed"
    },
    "total_time_ms": {
      "type": "integer",
      "description": "Total execution time in milliseconds"
    },
    "file_type": {
      "type": "string",
      "enum": [
        "csv",
        "excel"
      ],
      "description": "Type of the input file"
    },
    "error": {
      "type": "string",
      "description": "Error message if analysis failed"
    }
  },
  "required": [
    "success"
  ]
}
```
