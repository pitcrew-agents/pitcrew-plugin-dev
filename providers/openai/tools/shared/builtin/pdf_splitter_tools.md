# pdf_splitter_tools

## split_pdf
**Input schema:**
```json
{
  "type": "object",
  "properties": {
    "file_path": {
      "type": "string",
      "description": "Local path to the bundled PDF containing multiple forms."
    },
    "upload_to_s3": {
      "type": "boolean",
      "default": true,
      "description": "Upload each split PDF to S3 and include a presigned download URL. Default true."
    }
  },
  "required": [
    "file_path"
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
      "description": "Whether splitting succeeded."
    },
    "total_pages": {
      "type": "integer",
      "description": "Total number of pages across all detected forms."
    },
    "forms_found": {
      "type": "integer",
      "description": "Number of individual forms detected."
    },
    "forms": {
      "type": "array",
      "description": "List of detected forms with metadata and download URLs.",
      "items": {
        "type": "object",
        "properties": {
          "form_index": {
            "type": "integer"
          },
          "form_code": {
            "type": [
              "string",
              "null"
            ]
          },
          "form_name": {
            "type": [
              "string",
              "null"
            ]
          },
          "page_range": {
            "type": "array",
            "items": {
              "type": "integer"
            }
          },
          "page_count": {
            "type": "integer"
          },
          "filename": {
            "type": "string"
          },
          "download_url": {
            "type": [
              "string",
              "null"
            ]
          },
          "file_size_bytes": {
            "type": "integer"
          }
        }
      }
    },
    "error": {
      "type": [
        "string",
        "null"
      ],
      "description": "Error message if splitting failed."
    }
  }
}
```

## split_and_extract
**Input schema:**
```json
{
  "type": "object",
  "properties": {
    "file_path": {
      "type": "string",
      "description": "Local path to the bundled TradePMR PDF."
    }
  },
  "required": [
    "file_path"
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
    "forms_found": {
      "type": "integer"
    },
    "total_pages": {
      "type": "integer"
    },
    "form_fields": {
      "type": "object",
      "description": "Merged canonical field dict from all extracted forms."
    },
    "extracted_forms": {
      "type": "array",
      "description": "Per-form metadata, extracted fields, and S3 download URL.",
      "items": {
        "type": "object",
        "properties": {
          "form_index": {
            "type": "integer"
          },
          "form_name": {
            "type": [
              "string",
              "null"
            ]
          },
          "form_code": {
            "type": [
              "string",
              "null"
            ]
          },
          "page_range": {
            "type": "array",
            "items": {
              "type": "integer"
            }
          },
          "page_count": {
            "type": "integer"
          },
          "filename": {
            "type": "string"
          },
          "download_url": {
            "type": [
              "string",
              "null"
            ]
          },
          "file_size_bytes": {
            "type": "integer"
          },
          "form_fields": {
            "type": "object"
          },
          "extraction_error": {
            "type": [
              "string",
              "null"
            ]
          }
        }
      }
    },
    "error": {
      "type": [
        "string",
        "null"
      ]
    }
  }
}
```
