# http_tools

## http_get
**Input schema:**
```json
{
  "type": "object",
  "properties": {
    "url": {
      "type": "string",
      "description": "The URL to fetch"
    },
    "headers": {
      "type": "object",
      "description": "Optional HTTP headers as key-value pairs",
      "additionalProperties": {
        "type": "string"
      }
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
    "status_code": {
      "type": "integer",
      "description": "HTTP status code"
    },
    "body": {
      "description": "Response body (parsed JSON object/array or raw string)",
      "oneOf": [
        {
          "type": "object",
          "additionalProperties": true
        },
        {
          "type": "array"
        },
        {
          "type": "string"
        }
      ]
    },
    "is_json": {
      "type": "boolean",
      "description": "Whether body was parsed as JSON"
    },
    "headers": {
      "type": "object",
      "description": "Response headers",
      "additionalProperties": {
        "type": "string"
      }
    },
    "url": {
      "type": "string",
      "description": "Final URL after redirects"
    },
    "success": {
      "type": "boolean"
    },
    "error": {
      "type": "string"
    }
  }
}
```

## http_post
**Input schema:**
```json
{
  "type": "object",
  "properties": {
    "url": {
      "type": "string",
      "description": "The URL to post to"
    },
    "body": {
      "description": "Request body - dict for JSON, string for raw data"
    },
    "headers": {
      "type": "object",
      "description": "Optional HTTP headers as key-value pairs",
      "additionalProperties": {
        "type": "string"
      }
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
    "status_code": {
      "type": "integer",
      "description": "HTTP status code"
    },
    "body": {
      "description": "Response body (parsed JSON object/array or raw string)",
      "oneOf": [
        {
          "type": "object",
          "additionalProperties": true
        },
        {
          "type": "array"
        },
        {
          "type": "string"
        }
      ]
    },
    "is_json": {
      "type": "boolean",
      "description": "Whether body was parsed as JSON"
    },
    "headers": {
      "type": "object",
      "description": "Response headers",
      "additionalProperties": {
        "type": "string"
      }
    },
    "url": {
      "type": "string",
      "description": "Final URL after redirects"
    },
    "success": {
      "type": "boolean"
    },
    "error": {
      "type": "string"
    }
  }
}
```

## download_file
**Input schema:**
```json
{
  "type": "object",
  "properties": {
    "url": {
      "type": "string",
      "description": "The URL to download the file from"
    },
    "filename": {
      "type": "string",
      "description": "Optional custom filename. If not provided, extracted from URL or headers"
    },
    "headers": {
      "type": "object",
      "description": "Optional HTTP headers as key-value pairs",
      "additionalProperties": {
        "type": "string"
      }
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
    "success": {
      "type": "boolean",
      "description": "True if download succeeded"
    },
    "path": {
      "type": "string",
      "description": "Local file path where the file was saved"
    },
    "filename": {
      "type": "string",
      "description": "The saved filename"
    },
    "file_size": {
      "type": "integer",
      "description": "Size in bytes"
    },
    "content_type": {
      "type": "string",
      "description": "MIME type from response headers"
    },
    "source_url": {
      "type": "string",
      "description": "Final URL after redirects"
    },
    "error": {
      "type": "string",
      "description": "Error message if download failed"
    },
    "requested_url": {
      "type": "string",
      "description": "Original requested URL (on error)"
    },
    "final_url": {
      "type": "string",
      "description": "Final URL after redirects (on error)"
    }
  }
}
```

## prepare_file_for_upload
**Input schema:**
```json
{
  "type": "object",
  "properties": {
    "path": {
      "type": "string",
      "description": "Local file path OR URL (e.g. S3 presigned URL from code_gen) to read and encode for upload"
    }
  },
  "required": [
    "path"
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
      "description": "True if file was prepared successfully"
    },
    "file_to_upload": {
      "type": "string",
      "description": "Base64-encoded file content ready for Composio upload tools"
    },
    "filename": {
      "type": "string",
      "description": "The file basename"
    },
    "mime_type": {
      "type": "string",
      "description": "Detected MIME type of the file"
    },
    "file_size": {
      "type": "integer",
      "description": "File size in bytes"
    }
  }
}
```
