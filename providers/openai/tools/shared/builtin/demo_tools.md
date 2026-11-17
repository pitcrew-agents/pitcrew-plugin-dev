# demo_tools

## batch_download_files
**Input schema:**
```json
{
  "type": "object",
  "properties": {
    "files": {
      "type": "string",
      "description": "List of file objects from google_drive.list_files output. Pass the files array directly (e.g., {{task1.output.files}}). Each file object should have id and name fields."
    },
    "skip_folders": {
      "type": "boolean",
      "description": "If true, skip folders in the files list. Defaults to true.",
      "default": true
    },
    "subfolder": {
      "type": "string",
      "description": "Optional subfolder name within the run tmp directory. Files saved to /tmp/kanban-runs/{run_id}/{subfolder}/"
    }
  },
  "required": [
    "files"
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
      "description": "True if all files downloaded successfully"
    },
    "downloaded": {
      "type": "array",
      "description": "List of successfully downloaded files",
      "items": {
        "type": "object",
        "properties": {
          "id": {
            "type": "string"
          },
          "name": {
            "type": "string"
          },
          "output_path": {
            "type": "string"
          },
          "size": {
            "type": "integer"
          },
          "mime_type": {
            "type": "string"
          }
        }
      }
    },
    "failed": {
      "type": "array",
      "description": "List of files that failed to download",
      "items": {
        "type": "object",
        "properties": {
          "id": {
            "type": "string"
          },
          "name": {
            "type": "string"
          },
          "error": {
            "type": "string"
          }
        }
      }
    },
    "skipped": {
      "type": "array",
      "description": "List of skipped items (e.g., folders)",
      "items": {
        "type": "object",
        "properties": {
          "id": {
            "type": "string"
          },
          "name": {
            "type": "string"
          },
          "reason": {
            "type": "string"
          }
        }
      }
    },
    "run_id": {
      "type": "string",
      "description": "Kanban run ID used"
    },
    "output_directory": {
      "type": "string",
      "description": "Full directory path where files were saved"
    },
    "summary": {
      "type": "object",
      "description": "Summary counts",
      "properties": {
        "total": {
          "type": "integer"
        },
        "downloaded": {
          "type": "integer"
        },
        "failed": {
          "type": "integer"
        },
        "skipped": {
          "type": "integer"
        }
      }
    },
    "error": {
      "type": "string",
      "description": "Error message if the operation failed entirely"
    }
  }
}
```

## batch_read_pdfs
**Input schema:**
```json
{
  "type": "object",
  "properties": {
    "downloaded": {
      "type": "string",
      "description": "List of downloaded file objects from batch_download_files output. Pass the downloaded array directly (e.g., {{task2.output.downloaded}}). Each object should have output_path and name fields."
    },
    "pages": {
      "type": "string",
      "description": "Optional page specification for all PDFs (e.g., \"1-5\", \"1,3,5\", \"all\"). If not specified, reads all pages."
    }
  },
  "required": [
    "downloaded"
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
      "description": "True if all PDFs were read successfully"
    },
    "results": {
      "type": "array",
      "description": "List of successfully read PDFs with their content",
      "items": {
        "type": "object",
        "properties": {
          "name": {
            "type": "string"
          },
          "path": {
            "type": "string"
          },
          "content": {
            "type": "string",
            "description": "Extracted text content"
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
          "char_count": {
            "type": "integer"
          },
          "metadata": {
            "type": "object"
          }
        }
      }
    },
    "failed": {
      "type": "array",
      "description": "List of files that failed to read",
      "items": {
        "type": "object",
        "properties": {
          "name": {
            "type": "string"
          },
          "path": {
            "type": "string"
          },
          "error": {
            "type": "string"
          }
        }
      }
    },
    "skipped": {
      "type": "array",
      "description": "List of non-PDF files that were skipped",
      "items": {
        "type": "object",
        "properties": {
          "name": {
            "type": "string"
          },
          "path": {
            "type": "string"
          },
          "reason": {
            "type": "string"
          }
        }
      }
    },
    "summary": {
      "type": "object",
      "properties": {
        "total": {
          "type": "integer"
        },
        "read": {
          "type": "integer"
        },
        "failed": {
          "type": "integer"
        },
        "skipped": {
          "type": "integer"
        }
      }
    }
  }
}
```

## batch_extract_pdf_data
**Input schema:**
```json
{
  "type": "object",
  "properties": {
    "results": {
      "type": "string",
      "description": "List of PDF read results from batch_read_pdfs output. Pass the results array directly (e.g., {{task3.output.results}}). Each object should have content, name, and path fields."
    },
    "fields": {
      "type": "string",
      "description": "Optional list of field names to extract. If not provided, uses default Client Intake Form fields."
    }
  },
  "required": [
    "results"
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
      "description": "True if all PDFs were processed successfully"
    },
    "extracted": {
      "type": "array",
      "description": "List of successfully extracted data",
      "items": {
        "type": "object",
        "properties": {
          "name": {
            "type": "string"
          },
          "path": {
            "type": "string"
          },
          "data": {
            "type": "object",
            "description": "Extracted field values"
          }
        }
      }
    },
    "failed": {
      "type": "array",
      "description": "List of PDFs that failed extraction",
      "items": {
        "type": "object",
        "properties": {
          "name": {
            "type": "string"
          },
          "path": {
            "type": "string"
          },
          "error": {
            "type": "string"
          }
        }
      }
    },
    "fields": {
      "type": "array",
      "description": "List of fields that were extracted",
      "items": {
        "type": "string"
      }
    },
    "summary": {
      "type": "object",
      "properties": {
        "total": {
          "type": "integer"
        },
        "extracted": {
          "type": "integer"
        },
        "failed": {
          "type": "integer"
        }
      }
    }
  }
}
```

## batch_validate_extracted_data
**Input schema:**
```json
{
  "type": "object",
  "properties": {
    "extracted": {
      "type": "string",
      "description": "List of extracted data from batch_extract_pdf_data output. Pass the extracted array directly (e.g., {{task4.output.extracted}}). Each object should have name, path, and data fields."
    },
    "required_fields": {
      "type": "string",
      "description": "Optional list of required field names. If not provided, uses default Client Intake Form required fields (name, DOB, SSN, email, phone, address, income, net worth, investment profile, regulatory questions, signature)."
    }
  },
  "required": [
    "extracted"
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
      "description": "True if validation completed for all records"
    },
    "validated": {
      "type": "array",
      "description": "List of validated records with status and notes",
      "items": {
        "type": "object",
        "properties": {
          "name": {
            "type": "string"
          },
          "path": {
            "type": "string"
          },
          "data": {
            "type": "object",
            "description": "Original extracted field values"
          },
          "status": {
            "type": "string",
            "description": "Validation status: valid, missing, or invalid"
          },
          "notes": {
            "type": "string",
            "description": "Summary of validation issues"
          },
          "missing_required": {
            "type": "array",
            "items": {
              "type": "string"
            },
            "description": "List of missing required fields"
          },
          "invalid_fields": {
            "type": "array",
            "items": {
              "type": "object",
              "properties": {
                "field": {
                  "type": "string"
                },
                "reason": {
                  "type": "string"
                }
              }
            },
            "description": "List of invalid fields with reasons"
          }
        }
      }
    },
    "required_fields": {
      "type": "array",
      "description": "List of required fields that were checked",
      "items": {
        "type": "string"
      }
    },
    "summary": {
      "type": "object",
      "properties": {
        "total": {
          "type": "integer"
        },
        "valid": {
          "type": "integer"
        },
        "missing": {
          "type": "integer"
        },
        "invalid": {
          "type": "integer"
        }
      }
    }
  }
}
```
