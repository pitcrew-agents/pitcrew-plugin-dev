# filesystem_tools

## save_text_as_file
**Input schema:**
```json
{
  "type": "object",
  "required": [
    "text"
  ],
  "properties": {
    "text": {
      "type": "string",
      "description": "Plain text content to save as a .txt file in S3. The s3_key returned can be passed directly to document_intelligence_ingest as a file path."
    },
    "filename": {
      "type": "string",
      "description": "Optional filename for the saved file (defaults to input.txt). A .txt extension is added automatically if not present.",
      "default": "input.txt"
    }
  }
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
    "s3_key": {
      "type": "string",
      "description": "S3 key of the uploaded file \u2014 pass to document_intelligence_ingest as a file path."
    },
    "filename": {
      "type": "string"
    },
    "size": {
      "type": "integer",
      "description": "Size of the text in characters."
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

## read_file
**Input schema:**
```json
{
  "type": "object",
  "properties": {
    "path": {
      "type": "string",
      "description": "Path to the file to read"
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
    "content": {
      "type": "string"
    },
    "path": {
      "type": "string"
    },
    "size": {
      "type": "integer"
    },
    "error": {
      "type": "string"
    }
  }
}
```

## write_file
**Input schema:**
```json
{
  "type": "object",
  "properties": {
    "path": {
      "type": "string",
      "description": "Path to the file to write"
    },
    "content": {
      "type": "string",
      "description": "Content to write to the file"
    }
  },
  "required": [
    "path",
    "content"
  ]
}
```

**Output schema:**
```json
{
  "type": "object",
  "properties": {
    "path": {
      "type": "string"
    },
    "size": {
      "type": "integer"
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

## list_directory
**Input schema:**
```json
{
  "type": "object",
  "properties": {
    "path": {
      "type": "string",
      "description": "Path to the directory to list"
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
    "path": {
      "type": "string"
    },
    "entries": {
      "type": "array",
      "items": {
        "type": "object",
        "properties": {
          "name": {
            "type": "string"
          },
          "path": {
            "type": "string"
          },
          "is_directory": {
            "type": "boolean"
          },
          "size": {
            "type": "null"
          },
          "modified_at": {
            "type": "string"
          }
        }
      }
    },
    "count": {
      "type": "integer"
    },
    "error": {
      "type": "string"
    }
  }
}
```

## create_directory
**Input schema:**
```json
{
  "type": "object",
  "properties": {
    "path": {
      "type": "string",
      "description": "Path to the directory to create"
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
    "path": {
      "type": "string"
    },
    "success": {
      "type": "boolean"
    },
    "created": {
      "type": "boolean"
    },
    "error": {
      "type": "string"
    }
  }
}
```

## delete_file
**Input schema:**
```json
{
  "type": "object",
  "properties": {
    "path": {
      "type": "string",
      "description": "Path to the file to delete"
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
    "path": {
      "type": "string"
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

## copy_file
**Input schema:**
```json
{
  "type": "object",
  "properties": {
    "source": {
      "type": "string",
      "description": "Path to the source file"
    },
    "destination": {
      "type": "string",
      "description": "Path to the destination"
    }
  },
  "required": [
    "source",
    "destination"
  ]
}
```

**Output schema:**
```json
{
  "type": "object",
  "properties": {
    "source": {
      "type": "string"
    },
    "destination": {
      "type": "string"
    },
    "size": {
      "type": "integer"
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

## move_file
**Input schema:**
```json
{
  "type": "object",
  "properties": {
    "source": {
      "type": "string",
      "description": "Path to the source file"
    },
    "destination": {
      "type": "string",
      "description": "Path to the destination"
    }
  },
  "required": [
    "source",
    "destination"
  ]
}
```

**Output schema:**
```json
{
  "type": "object",
  "properties": {
    "source": {
      "type": "string"
    },
    "destination": {
      "type": "string"
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

## get_file_info
**Input schema:**
```json
{
  "type": "object",
  "properties": {
    "path": {
      "type": "string",
      "description": "Path to the file"
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
    "path": {
      "type": "string"
    },
    "name": {
      "type": "string"
    },
    "is_directory": {
      "type": "boolean"
    },
    "size": {
      "type": "integer"
    },
    "created_at": {
      "type": "string"
    },
    "modified_at": {
      "type": "string"
    },
    "accessed_at": {
      "type": "string"
    },
    "permissions": {
      "type": "string"
    },
    "error": {
      "type": "string"
    }
  }
}
```
