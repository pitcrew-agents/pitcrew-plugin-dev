# math_tools

## add
Add two numbers together. Returns {"result": a + b}.

**Use when:** Use to add two numeric values. IMPORTANT: The exact tool_name to use in tool_config is "add" — never "math_tools.add" or "math_tools/add".

**Input schema:**
```json
{
  "type": "object",
  "properties": {
    "a": {
      "type": "number",
      "description": "First number"
    },
    "b": {
      "type": "number",
      "description": "Second number"
    }
  },
  "required": [
    "a",
    "b"
  ]
}
```

**Output schema:**
```json
{
  "type": "object",
  "properties": {
    "result": {
      "type": "integer"
    },
    "error": {
      "type": "string"
    }
  }
}
```

## subtract
**Input schema:**
```json
{
  "type": "object",
  "properties": {
    "a": {
      "type": "number",
      "description": "First number (minuend)"
    },
    "b": {
      "type": "number",
      "description": "Second number (subtrahend)"
    }
  },
  "required": [
    "a",
    "b"
  ]
}
```

**Output schema:**
```json
{
  "type": "object",
  "properties": {
    "result": {
      "type": "integer"
    },
    "error": {
      "type": "string"
    }
  }
}
```

## multiply
**Input schema:**
```json
{
  "type": "object",
  "properties": {
    "a": {
      "type": "number",
      "description": "First number"
    },
    "b": {
      "type": "number",
      "description": "Second number"
    }
  },
  "required": [
    "a",
    "b"
  ]
}
```

**Output schema:**
```json
{
  "type": "object",
  "properties": {
    "result": {
      "type": "integer"
    },
    "error": {
      "type": "string"
    }
  }
}
```

## divide
**Input schema:**
```json
{
  "type": "object",
  "properties": {
    "a": {
      "type": "number",
      "description": "Dividend"
    },
    "b": {
      "type": "number",
      "description": "Divisor (cannot be zero)"
    }
  },
  "required": [
    "a",
    "b"
  ]
}
```

**Output schema:**
```json
{
  "type": "object",
  "properties": {
    "result": {
      "type": "number"
    },
    "error": {
      "type": "string"
    }
  }
}
```

## calculate_percentage
**Input schema:**
```json
{
  "type": "object",
  "properties": {
    "value": {
      "type": "number",
      "description": "The base value"
    },
    "percentage": {
      "type": "number",
      "description": "The percentage to calculate (e.g., 15 for 15%)"
    }
  },
  "required": [
    "value",
    "percentage"
  ]
}
```

**Output schema:**
```json
{
  "type": "object",
  "properties": {
    "result": {
      "type": "number"
    },
    "error": {
      "type": "string"
    }
  }
}
```
