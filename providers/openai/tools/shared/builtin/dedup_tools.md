# dedup_tools

## deduplicate_csv
**Input schema:**
```json
{
  "type": "object",
  "required": [
    "file_path",
    "rules"
  ],
  "properties": {
    "file_path": {
      "type": "string",
      "description": "Path to the CSV file to deduplicate."
    },
    "rules": {
      "type": "array",
      "description": "Matching rules. Each rule defines a column, how to compare it, and its weight.",
      "items": {
        "type": "object",
        "required": [
          "column",
          "match_type",
          "weight"
        ],
        "properties": {
          "column": {
            "type": "string",
            "description": "Column name in the CSV."
          },
          "match_type": {
            "type": "string",
            "enum": [
              "exact",
              "fuzzy"
            ]
          },
          "weight": {
            "type": "number",
            "description": "Relative importance (e.g. 100 for email, 30 for name)."
          },
          "required": {
            "type": "boolean",
            "description": "If true, both records must have a non-null value in this column \u2014 pairs missing it are discarded before scoring."
          },
          "min_score": {
            "type": "number",
            "description": "0.0\u20131.0. If both records have a value and similarity < min_score, the pair is discarded. Null on either side is ignored."
          }
        }
      }
    },
    "confirmed_threshold": {
      "type": "number",
      "default": 90,
      "description": "Confidence >= this \u2192 confirmed duplicate."
    },
    "review_threshold": {
      "type": "number",
      "default": 60,
      "description": "Confidence >= this \u2192 needs human review."
    },
    "min_confidence": {
      "type": "number",
      "default": 40,
      "description": "Pairs below this confidence are discarded."
    },
    "prefix": {
      "type": "string",
      "default": "dedup",
      "description": "Output filename prefix."
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
    "total_records": {
      "type": "integer"
    },
    "clean_records": {
      "type": "integer"
    },
    "duplicate_records": {
      "type": "integer"
    },
    "review_records": {
      "type": "integer"
    },
    "clean_records_download_url": {
      "type": "string"
    },
    "clean_records_local_path": {
      "type": "string"
    },
    "duplicate_report_download_url": {
      "type": "string"
    },
    "duplicate_report_local_path": {
      "type": "string"
    },
    "review_queue_download_url": {
      "type": "string"
    },
    "review_queue_local_path": {
      "type": "string"
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
