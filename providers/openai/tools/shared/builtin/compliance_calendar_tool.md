# compliance_calendar_tool

## generate_compliance_calendar
**Input schema:**
```json
{
  "type": "object",
  "properties": {
    "firm_data": {
      "type": "object",
      "description": "Object containing all 33 required firm fields (firmName, crd, stateTier, etc.)"
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
    "events": {
      "type": "array",
      "description": "List of compliance calendar events",
      "items": {
        "type": "object",
        "properties": {
          "id": {
            "type": "string"
          },
          "templateId": {
            "type": "string"
          },
          "title": {
            "type": "string"
          },
          "description": {
            "type": "string"
          },
          "dueDate": {
            "type": "string"
          },
          "priority": {
            "type": "string"
          },
          "category": {
            "type": "string"
          },
          "reference": {
            "type": "string"
          },
          "portal": {
            "type": "string"
          },
          "reminders": {
            "type": "array"
          }
        }
      }
    },
    "stateTier": {
      "type": "string",
      "description": "State registration tier (Tier1, Tier2, Tier3, or SEC)"
    },
    "periodStart": {
      "type": "string",
      "description": "Calendar period start date (ISO format)"
    },
    "periodEnd": {
      "type": "string",
      "description": "Calendar period end date (ISO format)"
    },
    "summary": {
      "type": "object",
      "description": "Summary statistics about the generated calendar"
    },
    "success": {
      "type": "boolean",
      "description": "False if calendar generation failed"
    },
    "error": {
      "type": "string",
      "description": "Error message if generation failed"
    }
  }
}
```
