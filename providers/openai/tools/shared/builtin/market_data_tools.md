# market_data_tools

## get_market_context
**Input schema:**
```json
{
  "type": "object",
  "required": [
    "submarket",
    "building_class",
    "sqft"
  ],
  "properties": {
    "submarket": {
      "type": "string",
      "description": "Submarket name (e.g. 'Downtown Austin', 'South Lamar')"
    },
    "building_class": {
      "type": "string",
      "enum": [
        "A",
        "B",
        "C"
      ],
      "description": "Building class"
    },
    "sqft": {
      "type": "integer",
      "description": "Space size in square feet"
    },
    "current_rent_monthly": {
      "type": "integer",
      "description": "Tenant's current monthly rent in dollars"
    },
    "lease_from_date": {
      "type": "string",
      "description": "Lease start date (YYYY-MM-DD) \u2014 used to compute tenancy length"
    },
    "lease_to_date": {
      "type": "string",
      "description": "Lease expiry date (YYYY-MM-DD)"
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
    "avg_market_rent_per_sqft_year": {
      "type": "number"
    },
    "avg_market_rent_monthly": {
      "type": "integer"
    },
    "vacancy_rate_pct": {
      "type": "number"
    },
    "landlord_leverage": {
      "type": "string"
    },
    "yoy_rent_change_pct": {
      "type": "number"
    },
    "comparables": {
      "type": "array",
      "items": {
        "type": "object"
      }
    },
    "tenant_leverage_factors": {
      "type": "array",
      "items": {
        "type": "string"
      }
    },
    "data_source": {
      "type": "string"
    }
  }
}
```
