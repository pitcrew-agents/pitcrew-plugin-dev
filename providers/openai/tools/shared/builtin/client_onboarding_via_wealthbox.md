# client_onboarding_via_wealthbox

## identify_missing_fields
**Input schema:**
```json
{
  "type": "object",
  "required": [
    "contact"
  ],
  "properties": {
    "contact": {
      "type": "object",
      "description": "Wealthbox contact object from wealthbox.list_contacts or wealthbox.get_contact (first item in contacts array)"
    }
  }
}
```

**Output schema:**
```json
{
  "type": "object",
  "properties": {
    "parsed": {
      "type": "object",
      "properties": {
        "client_found": {
          "type": "boolean"
        },
        "client_name": {
          "type": "string"
        },
        "client_email": {
          "type": "string"
        },
        "wealthbox_id": {
          "type": "integer"
        },
        "missing_fields": {
          "type": "array"
        },
        "all_required_fields": {
          "type": "array"
        },
        "message": {
          "type": "string"
        }
      }
    }
  }
}
```

## compose_onboarding_email
**Input schema:**
```json
{
  "type": "object",
  "required": [
    "validation_result",
    "html_template"
  ],
  "properties": {
    "validation_result": {
      "type": "object",
      "description": "Output from identify_missing_fields ($.state.validation_result)"
    },
    "html_template": {
      "type": "string",
      "description": "Raw HTML template content with {{PLACEHOLDER}} tokens"
    }
  }
}
```

**Output schema:**
```json
{
  "type": "object",
  "properties": {
    "parsed": {
      "type": "object",
      "properties": {
        "subject": {
          "type": "string"
        },
        "body": {
          "type": "string"
        },
        "skip_email": {
          "type": "boolean"
        }
      }
    }
  }
}
```
