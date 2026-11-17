# lighthouse_tool

## get_lighthouse_score
**Input schema:**
```json
{
  "type": "object",
  "properties": {
    "url": {
      "type": "string",
      "description": "Live URL to audit with Lighthouse"
    },
    "categories": {
      "type": "array",
      "items": {
        "type": "string"
      },
      "description": "Lighthouse categories to run. Options: performance, accessibility, best-practices, seo, pwa. Defaults to all five."
    },
    "config": {
      "type": "object",
      "description": "Optional overrides: timeout_sec (int, default 120), form_factors (list, default [\"mobile\", \"desktop\"])"
    }
  },
  "required": [
    "url"
  ]
}
```

**Output schema:**
```json
{
  "type": "object",
  "properties": {
    "url": {
      "type": "string"
    },
    "audit_timestamp": {
      "type": "string"
    },
    "lighthouse_version": {
      "type": "string"
    },
    "summary_scores": {
      "type": "object",
      "description": "Worst score per category across all form factors (0-100)"
    },
    "results": {
      "type": "object",
      "description": "Per form-factor report: mobile and/or desktop"
    }
  }
}
```
