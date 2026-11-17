# ips_variance_tools

## calculate_ips_variance
**Input schema:**
```json
{
  "type": "object",
  "properties": {
    "positions": {
      "type": "array",
      "description": "List of aggregated positions by asset class",
      "items": {
        "type": "object",
        "properties": {
          "asset_class": {
            "type": "string",
            "enum": [
              "Equity",
              "Fixed Income",
              "Alternative",
              "Cash"
            ],
            "description": "Asset class name"
          },
          "market_value": {
            "type": "number",
            "description": "Total market value for this asset class"
          }
        },
        "required": [
          "asset_class",
          "market_value"
        ]
      }
    },
    "ips_targets": {
      "type": "object",
      "description": "IPS target allocations and ranges",
      "properties": {
        "equity_target": {
          "type": "number"
        },
        "equity_range_min": {
          "type": "number"
        },
        "equity_range_max": {
          "type": "number"
        },
        "fixed_income_target": {
          "type": "number"
        },
        "fixed_income_range_min": {
          "type": "number"
        },
        "fixed_income_range_max": {
          "type": "number"
        },
        "alternative_target": {
          "type": "number"
        },
        "alternative_range_min": {
          "type": "number"
        },
        "alternative_range_max": {
          "type": "number"
        },
        "cash_target": {
          "type": "number"
        },
        "cash_range_min": {
          "type": "number"
        },
        "cash_range_max": {
          "type": "number"
        }
      },
      "required": [
        "equity_target",
        "equity_range_min",
        "equity_range_max",
        "fixed_income_target",
        "fixed_income_range_min",
        "fixed_income_range_max",
        "alternative_target",
        "alternative_range_min",
        "alternative_range_max",
        "cash_target",
        "cash_range_min",
        "cash_range_max"
      ]
    },
    "rebalance_threshold": {
      "type": "number",
      "default": 5.0,
      "description": "Deviation percentage that triggers rebalance flag (default 5%)"
    }
  },
  "required": [
    "positions",
    "ips_targets"
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
    "error": {
      "type": "string"
    },
    "total_portfolio_value": {
      "type": "number"
    },
    "allocations": {
      "type": "array",
      "items": {
        "type": "object",
        "properties": {
          "asset_class": {
            "type": "string"
          },
          "market_value": {
            "type": "number"
          },
          "percentage": {
            "type": "number"
          }
        }
      }
    },
    "variance_analysis": {
      "type": "array",
      "items": {
        "type": "object",
        "properties": {
          "asset_class": {
            "type": "string"
          },
          "target_pct": {
            "type": "number"
          },
          "actual_pct": {
            "type": "number"
          },
          "deviation": {
            "type": "number"
          },
          "range_min": {
            "type": "number"
          },
          "range_max": {
            "type": "number"
          },
          "in_range": {
            "type": "boolean"
          },
          "rebalance_needed": {
            "type": "boolean"
          }
        }
      }
    },
    "overall_rebalance_needed": {
      "type": "boolean"
    },
    "out_of_range_count": {
      "type": "integer"
    }
  }
}
```
