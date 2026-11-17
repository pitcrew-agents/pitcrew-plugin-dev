# board_orchestration_tools

## start_board_run
**Input schema:**
```json
{
  "type": "object",
  "properties": {
    "board_id": {
      "type": "string",
      "description": "UUID or reference_id of the board to run."
    },
    "run_input": {
      "type": "object",
      "description": "Input data to pass to the child board run."
    }
  },
  "required": [
    "board_id"
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
    "run_id": {
      "type": "string"
    },
    "board_id": {
      "type": "string"
    },
    "error": {
      "type": "string"
    }
  }
}
```
