# landing_page_tool

## generate_landing_page
**Input schema:**
```json
{
  "type": "object",
  "properties": {
    "md_content": {
      "type": "string",
      "description": "The markdown file content/path with YAML frontmatter"
    },
    "template_content": {
      "type": "string",
      "description": "The HTML template content/path (use v3 template with data-field attributes)"
    }
  },
  "required": [
    "md_content",
    "template_content"
  ]
}
```

**Output schema:**
```json
{
  "type": "object",
  "properties": {
    "html": {
      "type": "string",
      "description": "The generated HTML content"
    },
    "agent_name": {
      "type": "string",
      "description": "The agent name from frontmatter"
    },
    "slug": {
      "type": "string",
      "description": "The agent slug from frontmatter"
    },
    "error": {
      "type": "string",
      "description": "Error message if generation failed"
    }
  }
}
```
