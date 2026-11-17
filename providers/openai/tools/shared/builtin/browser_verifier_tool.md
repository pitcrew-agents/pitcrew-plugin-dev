# browser_verifier_tool

## verify_live_page
**Input schema:**
```json
{
  "type": "object",
  "properties": {
    "live_url": {
      "type": "string",
      "description": "URL of the live webpage to verify"
    },
    "template_source": {
      "type": "string",
      "description": "Template to compare against: local file path, URL, or raw HTML string. CSS/JS expectations are derived from the template automatically."
    },
    "verification_config": {
      "type": "object",
      "description": "Optional config overrides. Supported keys: browser (headless, timeout_ms, viewport, wait_until), styles (properties, size_tolerance_pct, color_delta_e), console (fail_on_errors, ignore_patterns), visual (enabled, pixel_diff_threshold), decision (high_issue_threshold, pass_threshold)."
    }
  },
  "required": [
    "live_url",
    "template_source"
  ]
}
```

**Output schema:**
```json
{
  "type": "object",
  "properties": {
    "decision": {
      "type": "string",
      "enum": [
        "PASS",
        "FAIL"
      ]
    },
    "summary": {
      "type": "object"
    },
    "validations": {
      "type": "object",
      "description": "Keys: computed_styles, dom_structure, font_rendering, css_resources, js_resources, meta_tags, console, visual"
    },
    "actionable_items": {
      "type": "array"
    },
    "network_report": {
      "type": "object"
    },
    "console_errors": {
      "type": "array"
    }
  }
}
```
