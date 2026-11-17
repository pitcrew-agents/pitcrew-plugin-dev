# business_day_tools

## calculate_business_day_deadlines
**Input schema:**
```json
{
  "type": "object",
  "required": [
    "notice_date",
    "clock_type"
  ],
  "properties": {
    "notice_date": {
      "type": "string",
      "description": "ISO date (YYYY-MM-DD) when the member gave notice of the dispute. The clock starts the next business day."
    },
    "clock_type": {
      "type": "string",
      "enum": [
        "standard",
        "new_account",
        "pos_foreign"
      ],
      "description": "Reg E clock variant to apply. 'standard': 10 business days, 45-day extension. 'new_account': account under 30 days old \u2014 20 business days, 45-day extension. 'pos_foreign': point-of-sale or foreign-initiated \u2014 10 business days, 90-day extension."
    },
    "holidays": {
      "type": "array",
      "items": {
        "type": "string"
      },
      "description": "Institution holidays (YYYY-MM-DD) to exclude from business-day counts. Weekends are always excluded automatically.",
      "default": []
    },
    "config": {
      "type": "object",
      "description": "Optional overrides for deadline day counts. Omitted keys use Reg E defaults.",
      "properties": {
        "standard_business_days": {
          "type": "integer",
          "default": 10
        },
        "new_account_business_days": {
          "type": "integer",
          "default": 20
        },
        "extended_calendar_days": {
          "type": "integer",
          "default": 45
        },
        "extended_pos_foreign_calendar_days": {
          "type": "integer",
          "default": 90
        },
        "report_to_member_business_days": {
          "type": "integer",
          "default": 3
        },
        "error_correction_business_days": {
          "type": "integer",
          "default": 1
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
    "notice_date": {
      "type": "string",
      "description": "Echo of the input notice date."
    },
    "clock_type": {
      "type": "string",
      "description": "Echo of the clock type used."
    },
    "determination_deadline": {
      "type": "string",
      "description": "Last date to complete the error determination (10 or 20 business days from notice)."
    },
    "provisional_credit_deadline": {
      "type": "string",
      "description": "Last date to issue provisional credit to qualify for the extended window. Same as determination_deadline."
    },
    "extended_deadline": {
      "type": "string",
      "description": "Last date to complete investigation if provisional credit was issued (45 or 90 calendar days from notice)."
    },
    "report_to_member_deadline": {
      "type": "string",
      "description": "Last date to report results to the member (3 business days after determination_deadline)."
    },
    "error_correction_deadline": {
      "type": "string",
      "description": "Last date to correct any confirmed error (1 business day after determination_deadline)."
    },
    "determination_business_days": {
      "type": "integer"
    },
    "extended_calendar_days": {
      "type": "integer"
    },
    "holidays_encountered": {
      "type": "array",
      "items": {
        "type": "string"
      },
      "description": "Institution holidays that fell within any computed deadline window."
    },
    "error": {
      "type": "string",
      "description": "Present only when success is false."
    }
  }
}
```
