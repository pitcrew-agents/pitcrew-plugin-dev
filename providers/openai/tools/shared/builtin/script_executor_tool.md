# script_executor_tool

## execute_script
**Input schema:**
```json
{
  "type": "object",
  "properties": {
    "script_id": {
      "type": "string",
      "description": "UUID of the custom script to execute"
    }
  },
  "required": [
    "script_id"
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
    "result": {
      "description": "Return value from the script"
    },
    "output_files": {
      "type": "array",
      "description": "Output files with S3 download URLs"
    },
    "error": {
      "type": "string"
    }
  }
}
```
