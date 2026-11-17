# calendar_markdown_tool

## generate_calendar_markdown
**Input schema:**
```json
{
  "type": "object",
  "properties": {
    "events": {
      "type": "array",
      "description": "Array of event objects with id, title, dueDate, priority, category"
    },
    "firm_name": {
      "type": "string",
      "description": "Name of the firm"
    },
    "state_tier": {
      "type": "string",
      "description": "State tier classification (TIER_1_CA, TIER_2_NY, etc.)"
    },
    "summary": {
      "type": "object",
      "description": "Summary statistics with totalEvents, byCategory, byPriority, byMonth"
    },
    "ics_download_url": {
      "type": "string",
      "description": "Optional presigned URL for ICS calendar download"
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
    "raw_response": {
      "type": "string",
      "description": "Formatted markdown calendar report content"
    },
    "text": {
      "type": "string",
      "description": "Formatted markdown calendar report content (same as raw_response)"
    },
    "success": {
      "type": "boolean",
      "description": "True if generation succeeded"
    },
    "error": {
      "type": "string",
      "description": "Error message if generation failed"
    }
  }
}
```

## generate_ics_calendar
**Input schema:**
```json
{
  "type": "object",
  "properties": {
    "events": {
      "type": "array",
      "description": "Array of event objects with id, title, dueDate, priority, category, description"
    },
    "firm_name": {
      "type": "string",
      "description": "Name of the firm for calendar metadata"
    },
    "crd": {
      "type": "string",
      "description": "Optional CRD number for filename"
    }
  },
  "required": [
    "events",
    "firm_name"
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
      "description": "True if ICS generation and S3 upload succeeded"
    },
    "download_url": {
      "type": "string",
      "description": "Presigned S3 URL for downloading the ICS file (valid for 7 days)"
    },
    "ics_content": {
      "type": "string",
      "description": "The generated ICS calendar content"
    },
    "event_count": {
      "type": "integer",
      "description": "Number of events included in the calendar"
    },
    "file_key": {
      "type": "string",
      "description": "S3 file key for the uploaded ICS file"
    },
    "expires_in": {
      "type": "integer",
      "description": "Seconds until the download URL expires"
    },
    "error": {
      "type": "string",
      "description": "Error message if generation or upload failed"
    }
  }
}
```

## save_ics_calendar
**Input schema:**
```json
{
  "type": "object",
  "properties": {
    "ics_content": {
      "type": "string",
      "description": "The ICS calendar content string"
    },
    "filename": {
      "type": "string",
      "description": "Filename for the ICS file (default: Compliance_Calendar.ics)"
    }
  },
  "required": [
    "ics_content"
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
      "description": "True if S3 upload succeeded"
    },
    "download_url": {
      "type": "string",
      "description": "Presigned S3 URL for downloading the ICS file (valid for 7 days)"
    },
    "file_key": {
      "type": "string",
      "description": "S3 file key for the uploaded ICS file"
    },
    "expires_in": {
      "type": "integer",
      "description": "Seconds until the download URL expires"
    },
    "error": {
      "type": "string",
      "description": "Error message if upload failed"
    }
  }
}
```
