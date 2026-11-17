# financial_spreading_tools

## populate_spreading_template
**Input schema:**
```json
{
  "type": "object",
  "required": [
    "template_rows",
    "extracted_fields"
  ],
  "properties": {
    "template_rows": {
      "type": "array",
      "description": "Rows from spreading_template.csv. Each row must have template_label, category, section, used_in_ratio."
    },
    "extracted_fields": {
      "type": "object",
      "description": "Extracted financial values keyed by alias from document_intelligence_query. Expected keys: total_current_assets, total_current_liabilities, total_assets, total_liabilities, intangible_assets, net_operating_income, total_debt_service, ebitda, long_term_debt, current_portion_ltd, interest_expense, principal_payments, addback_candidate, period."
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
    "period": {
      "type": "string"
    },
    "populated_template": {
      "type": "array",
      "description": "Template rows populated with extracted values. Columns: template_label, category, section, used_in_ratio, value_{period} (dynamic column name based on the fiscal year period, e.g. value_fy2025 or value_fy2026)."
    },
    "populated_count": {
      "type": "integer",
      "description": "Number of template rows with a value populated."
    },
    "unmapped_template_rows": {
      "type": "array",
      "items": {
        "type": "string"
      },
      "description": "Template labels with no matching extracted value."
    },
    "unmapped_count": {
      "type": "integer"
    },
    "addback_candidates": {
      "type": "array",
      "description": "Potential add-back items with label, value, page, note."
    },
    "download_url": {
      "type": "string",
      "description": "Presigned download URL for the populated spreading template CSV."
    },
    "s3_key": {
      "type": "string"
    },
    "error": {
      "type": "string"
    }
  }
}
```

## normalize_financial_line_items
**Input schema:**
```json
{
  "type": "object",
  "required": [
    "raw_line_items",
    "template_labels"
  ],
  "properties": {
    "raw_line_items": {
      "type": "array",
      "description": "Raw line items extracted from the borrower's financial statement. Each item must have 'label' and 'value'. Optional: period, page, section.",
      "items": {
        "type": "object",
        "properties": {
          "label": {
            "type": "string"
          },
          "value": {
            "type": "number"
          },
          "period": {
            "type": "string"
          },
          "page": {
            "type": "string"
          },
          "section": {
            "type": "string"
          }
        }
      }
    },
    "template_labels": {
      "type": "array",
      "items": {
        "type": "string"
      },
      "description": "List of standard template label strings from spreading_template.csv."
    },
    "confidence_threshold": {
      "type": "number",
      "default": 0.75,
      "description": "Minimum confidence score (0-1) to auto-map a label. Below this, the item is flagged for analyst review."
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
    "mapped_count": {
      "type": "integer"
    },
    "flagged_count": {
      "type": "integer"
    },
    "addback_candidates_count": {
      "type": "integer"
    },
    "unmapped_count": {
      "type": "integer"
    },
    "mapped": {
      "type": "array",
      "description": "Successfully mapped line items with template_label and source citation."
    },
    "flagged": {
      "type": "array",
      "description": "Low-confidence matches requiring analyst confirmation."
    },
    "addback_candidates": {
      "type": "array",
      "description": "Items flagged as potential non-recurring add-backs. Analyst must decide."
    },
    "unmapped": {
      "type": "array",
      "description": "Items with no template match found."
    },
    "error": {
      "type": "string"
    }
  }
}
```

## compute_financial_ratios
**Input schema:**
```json
{
  "type": "object",
  "required": [
    "line_items"
  ],
  "properties": {
    "line_items": {
      "type": "object",
      "description": "Normalized line items keyed by template label \u2192 numeric value. Must include: Net Operating Income, Total Debt Service, Total Current Assets, Total Current Liabilities, EBITDA, Total Assets, Total Liabilities, Intangible Assets.",
      "additionalProperties": {
        "type": "number"
      }
    },
    "covenants": {
      "type": "array",
      "description": "Covenant thresholds from loan agreement. Each item: {covenant, threshold, direction}.",
      "items": {
        "type": "object",
        "properties": {
          "covenant": {
            "type": "string"
          },
          "threshold": {
            "type": "number"
          },
          "direction": {
            "type": "string",
            "enum": [
              ">=",
              "<=",
              ">",
              "<"
            ]
          }
        }
      }
    },
    "addback_candidates": {
      "type": "array",
      "description": "Optional. Add-back candidates from normalize_financial_line_items. Each must have 'value'. Applied to NOI and EBITDA to compute adjusted ratios."
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
    "reported": {
      "type": "object",
      "description": "Ratios and covenant flags computed from as-reported financials (no add-backs).",
      "properties": {
        "ratios": {
          "type": "object"
        },
        "covenant_flags": {
          "type": "array"
        },
        "breaches": {
          "type": "array"
        },
        "breach_count": {
          "type": "integer"
        }
      }
    },
    "adjusted": {
      "type": "object",
      "description": "Ratios and covenant flags with all add-back candidates applied. Null if no add-backs exist. Analyst must decide whether to accept.",
      "properties": {
        "ratios": {
          "type": "object"
        },
        "covenant_flags": {
          "type": "array"
        },
        "breaches": {
          "type": "array"
        },
        "breach_count": {
          "type": "integer"
        },
        "addback_applied": {
          "type": "array",
          "description": "Add-backs that were applied with label, value, and source page."
        },
        "total_addback_amount": {
          "type": "number"
        }
      }
    },
    "has_addbacks": {
      "type": "boolean"
    },
    "breaches": {
      "type": "array",
      "description": "Breaches from reported ratios (convenience field)."
    },
    "breach_count": {
      "type": "integer"
    },
    "computation_errors": {
      "type": "array"
    },
    "error": {
      "type": "string"
    }
  }
}
```
