# aws_cli_tools

## aws_execute
**Input schema:**
```json
{
  "type": "object",
  "properties": {
    "prompt": {
      "type": "string",
      "description": "Natural language AWS task. Examples: 'List all IAM users and when they were created', 'Show this month's AWS billing breakdown by service', 'Check which S3 buckets have public access enabled'. Claude Code will run the appropriate `awscli` commands and return findings."
    },
    "context": {
      "type": "string",
      "description": "Optional extra guidance appended to the system prompt."
    },
    "output_dir": {
      "type": "string",
      "description": "Container path where output files are written (default /tmp/output).",
      "default": "/tmp/output"
    },
    "timeout": {
      "type": "integer",
      "description": "Max seconds for Claude Code to run (default 300).",
      "default": 300
    }
  },
  "required": [
    "prompt"
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
    "stdout": {
      "type": "string",
      "description": "Claude Code output including AWS CLI results."
    },
    "output_file_content": {
      "type": "string",
      "description": "Raw content of the first output file, if any."
    },
    "output_files": {
      "type": "array"
    },
    "download_url": {
      "type": "string"
    },
    "error": {
      "type": "string"
    }
  }
}
```
