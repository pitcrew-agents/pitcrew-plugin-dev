# claude_execute_tools

## claude_execute
**Input schema:**
```json
{
  "type": "object",
  "properties": {
    "prompt": {
      "type": "string",
      "description": "Natural language task for Claude Code CLI. Claude Code runs autonomously inside an isolated sandbox \u2014 it can read/write files, run shell commands, install packages, use git, open GitHub PRs, call APIs, and more."
    },
    "files": {
      "type": "array",
      "items": {
        "type": "string"
      },
      "description": "Optional local file paths to upload into the sandbox before Claude Code starts."
    },
    "context": {
      "description": "Additional context or instructions for Claude Code. Can be string, dict, list, or any JSON-serializable value. Small strings (<5000 chars) are appended to the prompt. Dicts/lists/large strings are written to a JSON file and uploaded to the sandbox. Use this to provide background data, analysis results, configurations, or any structured information."
    },
    "env": {
      "type": "object",
      "description": "Extra environment variables for the sandbox. AWS credentials and CLAUDE_CODE_USE_BEDROCK=1 are forwarded automatically.",
      "additionalProperties": {
        "type": "string"
      }
    },
    "output_dir": {
      "type": "string",
      "description": "Container path where Claude Code writes output files (default /tmp/output).",
      "default": "/tmp/output"
    },
    "timeout": {
      "type": "integer",
      "description": "Max seconds for Claude Code to run (default 600).",
      "default": 600
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
      "type": "string"
    },
    "output_file_content": {
      "type": "string",
      "description": "Raw string content of the first output file. Use this for downstream tools that need file content directly."
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
