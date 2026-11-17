# pdf_tools

## read_pdf
**Input schema:**
```json
{
  "type": "object",
  "properties": {
    "path": {
      "type": "string",
      "description": "Path to the PDF file to read"
    },
    "pages": {
      "type": "string",
      "description": "Pages to extract (for small files only): \"all\" (default), \"1\", \"1-5\", or \"1,3,5\". Note: Large files (>1MB) use AWS Textract which always extracts all pages."
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
    "page_count": {
      "type": "integer"
    },
    "pages_extracted": {
      "type": "array",
      "items": {
        "type": "integer"
      }
    },
    "metadata": {
      "type": "object",
      "description": "PDF metadata (keys vary by PDF)",
      "additionalProperties": {
        "type": "string"
      }
    },
    "char_count": {
      "type": "integer"
    },
    "error": {
      "type": "string"
    }
  }
}
```

## read_pdf_tables
**Input schema:**
```json
{
  "type": "object",
  "properties": {
    "path": {
      "type": "string",
      "description": "Path to the PDF file"
    },
    "page": {
      "type": "integer",
      "description": "Page number to extract tables from (1-indexed, default: 1)"
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
    "tables": {
      "type": "array"
    },
    "path": {
      "type": "string"
    },
    "page": {
      "type": "integer"
    },
    "table_count": {
      "type": "integer"
    },
    "total_pages": {
      "type": "integer"
    },
    "error": {
      "type": "string"
    }
  }
}
```

## get_pdf_info
**Input schema:**
```json
{
  "type": "object",
  "properties": {
    "path": {
      "type": "string",
      "description": "Path to the PDF file"
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
    "page_count": {
      "type": "integer"
    },
    "metadata": {
      "type": "object",
      "description": "PDF metadata (keys vary by PDF)",
      "additionalProperties": {
        "type": "string"
      }
    },
    "file_size": {
      "type": "integer"
    },
    "error": {
      "type": "string"
    }
  }
}
```

## parse_pdf
**Input schema:**
```json
{
  "type": "object",
  "properties": {
    "file_bytes": {
      "type": "string",
      "format": "binary",
      "description": "Raw PDF file bytes."
    },
    "s3_key": {
      "type": "string",
      "description": "S3 key where the file already resides. If provided, Textract reads directly from S3 without a re-upload, which is faster and cheaper."
    },
    "document_hash": {
      "type": "string",
      "description": "MD5 hash of the file bytes. Used as the cache key \u2014 if a Textract response for this hash is already cached in S3, the API call is skipped entirely. Strongly recommended to avoid redundant charges."
    },
    "max_wait": {
      "type": "integer",
      "default": 600,
      "description": "Maximum seconds to wait for Textract job completion."
    }
  },
  "required": [
    "file_bytes"
  ],
  "description": "\u26a0\ufe0f COST WARNING: This tool calls AWS Textract (StartDocumentAnalysis with TABLES + FORMS feature types). Textract charges per page \u2014 do NOT use this for quick text reads, metadata lookups, or any use case where pdfplumber-based read_pdf is sufficient. Use only when structured table and form data is required for ingestion or extraction pipelines."
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
    "blocks": {
      "type": "array",
      "description": "List of parsed blocks. Each block is either a text block or a table block. Text blocks: {type: \"text\", page: int, text: str, confidence: float}. Table blocks: {type: \"table\", page: int, text: str, headers: [str], rows: [[str]], confidence: float, table_index: int}.",
      "items": {
        "type": "object"
      }
    },
    "cached": {
      "type": "boolean",
      "description": "True if the Textract response was served from cache (no API charge incurred)."
    },
    "error": {
      "type": "string"
    }
  }
}
```
