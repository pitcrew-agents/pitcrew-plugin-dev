# document_intelligence_tools

## document_intelligence_ingest
**Input schema:**
```json
{
  "type": "object",
  "properties": {
    "file_paths": {
      "type": "array",
      "items": {
        "type": "string"
      },
      "displayName": "File Paths",
      "description": "S3 keys or local paths to documents to ingest. Supported formats: PDF, scanned PDF, CSV, Excel."
    },
    "collection_name": {
      "type": "string",
      "displayName": "Collection Name",
      "description": "Name for the persistent document collection. Reuse the same name across runs to add documents incrementally. Defaults to the current run ID if not provided."
    },
    "chunk_size": {
      "type": "integer",
      "default": 800,
      "displayName": "Chunk Size",
      "description": "Target size for text chunks in tokens. Affects retrieval granularity."
    },
    "chunk_overlap": {
      "type": "integer",
      "default": 200,
      "displayName": "Chunk Overlap",
      "description": "Token overlap between adjacent chunks to preserve context across chunk boundaries."
    },
    "select_schema": {
      "type": "boolean",
      "default": true,
      "displayName": "Select Schema",
      "description": "When true (default), runs LLM classification to select domain, tabular schema, and text schema for each document, and extracts schema-defined domain field prerequisites. When false, skips schema selection \u2014 domain classification and section detection still run. Use false for free-form RAG workflows that do not require structured extraction."
    }
  },
  "required": [
    "file_paths"
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
      "description": "True if ingestion completed without error."
    },
    "collection_name": {
      "type": "string",
      "description": "The name of the collection that was created or updated. Pass to query and extract tools."
    },
    "document_hashes": {
      "type": "array",
      "items": {
        "type": "string"
      },
      "description": "MD5 hashes of successfully ingested documents."
    },
    "documents": {
      "type": "object",
      "description": "Per-document classification results keyed by MD5 hash. Each value contains domain (detected domain name), tabular_schema (schema doc_type for structured table extraction, or null), and text_schema (schema doc_type for RAG text extraction, or null). Pass directly to extract_document_tabular and document_intelligence_query in documents mode.",
      "additionalProperties": {
        "type": "object",
        "properties": {
          "domain": {
            "type": "string"
          },
          "tabular_schema": {
            "type": "string"
          },
          "text_schema": {
            "type": "string"
          }
        }
      }
    },
    "documents_processed": {
      "type": "integer"
    },
    "documents_skipped": {
      "type": "integer"
    },
    "total_chunks": {
      "type": "integer"
    },
    "processing_summary": {
      "type": "array",
      "description": "Per-file processing results.",
      "items": {
        "type": "object",
        "properties": {
          "file": {
            "type": "string"
          },
          "status": {
            "type": "string",
            "enum": [
              "processed",
              "skipped",
              "error",
              "empty"
            ]
          },
          "pages": {
            "type": "integer"
          },
          "chunks": {
            "type": "integer"
          },
          "tables": {
            "type": "integer"
          }
        }
      }
    }
  }
}
```

## document_intelligence_query
**Input schema:**
```json
{
  "type": "object",
  "description": "\u26a0\ufe0f TWO MUTUALLY EXCLUSIVE INPUT MODES \u2014 provide exactly one of 'questions' OR 'documents':\n\n\u2022 FREE-FORM MODE ('questions'): Pass a list of natural language question strings. Each is answered independently using RAG retrieval. Answers are prose by default.\n\n\u2022 DOCUMENTS MODE ('documents'): Pass a dict keyed by document hash where each value contains a 'text_schema' and 'domain'. Each document is queried using its own schema. Returns a 'documents' dict keyed by hash.",
  "properties": {
    "collection_name": {
      "type": "string",
      "displayName": "Collection Name",
      "description": "Name of the persistent document collection to query."
    },
    "questions": {
      "type": "array",
      "items": {
        "type": "string"
      },
      "displayName": "Questions",
      "description": "FREE-FORM MODE. Mutually exclusive with 'documents'. List of natural language questions to answer from the collection. Each question is answered independently using RAG retrieval."
    },
    "aliases": {
      "type": "array",
      "items": {
        "type": "string"
      },
      "displayName": "Aliases",
      "description": "FREE-FORM MODE. Optional list of output key names, one per question (same order as 'questions'). When provided, each answer's 'alias' field is set and extracted_fields is populated with these keys. Example: aliases=['named_insured', 'expiry_date'] \u2192 extracted_fields.named_insured, extracted_fields.expiry_date. If omitted, aliases default to null and extracted_fields uses positional keys (q1, q2...). Existing boards without aliases continue to work unchanged."
    },
    "documents": {
      "type": "object",
      "displayName": "Documents",
      "description": "DOCUMENTS MODE. Mutually exclusive with 'questions'. Dict keyed by document MD5 hash. Each value must contain 'text_schema' (schema file name without extension) and 'domain'. Documents with null text_schema are skipped."
    },
    "domain": {
      "type": "string",
      "enum": [
        "general",
        "financial",
        "contracts"
      ],
      "default": "general",
      "displayName": "Domain",
      "description": "Domain for section filtering and answer generation prompts. Used in free-form mode only."
    },
    "document_hashes": {
      "oneOf": [
        {
          "type": "string"
        },
        {
          "type": "array",
          "items": {
            "type": "string"
          }
        }
      ],
      "displayName": "Document Hashes",
      "description": "Optional filter for free-form mode. MD5 hash(es) to scope retrieval to specific documents. When omitted, the entire collection is searched."
    },
    "json_output": {
      "type": "boolean",
      "default": false,
      "displayName": "JSON Output",
      "description": "Free-form mode only. When true, answers are parsed values rather than prose. Use for questions with clear, extractable answers (names, dates, amounts)."
    },
    "batch_size": {
      "type": "integer",
      "default": 1,
      "displayName": "Batch Size",
      "description": "Free-form mode only. Number of questions answered in a single LLM call. Default of 1 gives maximum accuracy. Higher values reduce LLM calls but may reduce accuracy."
    },
    "top_k": {
      "type": "integer",
      "default": 8,
      "displayName": "Top K",
      "description": "Number of document chunks to retrieve per question."
    },
    "similarity_threshold": {
      "type": "number",
      "default": 0.3,
      "displayName": "Similarity Threshold",
      "description": "Minimum cosine similarity for retrieved chunks. Capped at 0.5 internally."
    },
    "model_id": {
      "type": "string",
      "displayName": "Model ID",
      "description": "Optional Bedrock model ID override for answer generation."
    },
    "text_schema_override": {
      "type": "string",
      "displayName": "Text Schema Override",
      "description": "Documents mode only. When provided, applies this schema (file name without extension) to ALL documents regardless of the schema stored in the documents map. Use to hardcode a specific schema in a board. Defaults to null."
    },
    "force": {
      "type": "boolean",
      "default": false,
      "displayName": "Force Re-extraction",
      "description": "Documents mode only. When true, extraction runs even if results already exist in the fields store. Use when the schema has changed or re-extraction is explicitly needed. Defaults to false."
    }
  },
  "required": [
    "collection_name"
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
    "answers": {
      "type": "array",
      "description": "FREE-FORM MODE ONLY. Absent in documents mode. One object per question in the order they were asked.",
      "items": {
        "type": "object",
        "properties": {
          "question": {
            "type": "string"
          },
          "answer": {
            "description": "Prose string when json_output=false (default). Parsed typed value (string, number, list, etc.) when json_output=true. null when status is 'not_found' and json_output=true."
          },
          "alias": {
            "type": "string",
            "description": "Present only when the question was sourced from a schema field with an alias."
          },
          "confidence": {
            "type": "number"
          },
          "status": {
            "type": "string",
            "enum": [
              "answered",
              "not_found",
              "error"
            ]
          },
          "citations": {
            "type": "array",
            "items": {
              "type": "object",
              "properties": {
                "document": {
                  "type": "string"
                },
                "page": {
                  "type": "integer"
                },
                "section_name": {
                  "type": "string",
                  "description": "Raw section heading text from the document (e.g. 'Consolidated Statements of Operations'). Empty string if no heading was detected."
                },
                "section_type": {
                  "type": "string",
                  "description": "Domain-normalised section label (e.g. income_statement, balance_sheet). Empty string if domain classification did not assign a section."
                }
              }
            }
          }
        }
      }
    },
    "extracted_fields": {
      "type": "object",
      "description": "FREE-FORM MODE ONLY, only when json_output=true AND at least one question has an alias. Top-level key \u2014 not nested inside 'documents'. Keyed by question alias \u2192 parsed typed value. Absent when json_output=false or no aliases are present.",
      "additionalProperties": true
    },
    "missing_fields": {
      "type": "array",
      "description": "FREE-FORM MODE ONLY, only when json_output=true AND at least one question has an alias. Top-level key \u2014 not nested inside 'documents'. Questions with aliases that could not be answered. Absent when json_output=false or no aliases are present.",
      "items": {
        "type": "object",
        "properties": {
          "alias": {
            "type": "string"
          },
          "question": {
            "type": "string"
          },
          "reason": {
            "type": "string"
          }
        }
      }
    },
    "documents": {
      "type": "object",
      "description": "DOCUMENTS MODE ONLY. Absent in free-form mode. Keyed by document MD5 hash (same keys as the input 'documents' param). Each value is an object with four keys: (1) 'extracted_fields': dict of alias\u2192typed value for output=True fields; (2) 'citations': dict of alias\u2192{document, page, section} citing the source chunk; (3) 'missing_fields': list of {alias, reason} for fields that could not be extracted; (4) 'derived_key_values': {extracted_fields, leaf_contexts} \u2014 the internal derived-key state (all is_derived_key fields, including output=False). Pass to extract_document_tabular.derived_key_values when running tabular extraction on the same document.",
      "additionalProperties": {
        "type": "object",
        "properties": {
          "extracted_fields": {
            "type": "object",
            "description": "Keyed by field alias \u2192 typed extracted value.",
            "additionalProperties": true
          },
          "citations": {
            "type": "object",
            "description": "Keyed by field alias \u2192 {document, page, section}.",
            "additionalProperties": true
          },
          "missing_fields": {
            "type": "array",
            "description": "Fields that could not be answered.",
            "items": {
              "type": "object",
              "properties": {
                "alias": {
                  "type": "string"
                },
                "question": {
                  "type": "string"
                },
                "reason": {
                  "type": "string"
                }
              }
            }
          }
        }
      }
    },
    "questions_total": {
      "type": "integer",
      "description": "FREE-FORM MODE ONLY. Total number of questions asked."
    },
    "questions_answered": {
      "type": "integer",
      "description": "FREE-FORM MODE ONLY. Number of questions successfully answered."
    },
    "questions_not_found": {
      "type": "integer",
      "description": "FREE-FORM MODE ONLY. Number of questions that could not be answered."
    },
    "average_confidence": {
      "type": "number",
      "description": "FREE-FORM MODE ONLY. Average confidence score across all answered questions."
    },
    "error": {
      "type": "string",
      "description": "Present only when success is false."
    }
  }
}
```

## document_intelligence_export
**Input schema:**
```json
{
  "type": "object",
  "properties": {
    "answers": {
      "type": "array",
      "displayName": "Answers",
      "description": "Answer objects from a prior question-answering step. Each item must have 'question', 'answer', 'status', and 'citations' fields."
    },
    "format": {
      "type": "string",
      "enum": [
        "excel",
        "json",
        "pdf"
      ],
      "default": "excel",
      "displayName": "Format",
      "description": "Export format. Excel includes per-question rows with citations; PDF generates a formatted report; JSON returns raw answer data."
    },
    "title": {
      "type": "string",
      "default": "Document Intelligence Report",
      "displayName": "Report Title",
      "description": "Title shown on the exported report."
    },
    "domain": {
      "type": "string",
      "enum": [
        "general",
        "financial"
      ],
      "default": "general",
      "displayName": "Domain",
      "description": "Domain configuration \u2014 affects export column layout (e.g. 'financial' adds Fiscal Years and Section columns)."
    },
    "output_filename": {
      "type": "string",
      "displayName": "Output Filename",
      "description": "Custom output filename without extension. Defaults to a generated name if not provided."
    }
  },
  "required": [
    "answers",
    "format"
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
    "download_url": {
      "type": "string"
    },
    "filename": {
      "type": "string"
    },
    "format": {
      "type": "string"
    },
    "file_size_bytes": {
      "type": "integer"
    },
    "questions_exported": {
      "type": "integer"
    },
    "s3_key": {
      "type": "string"
    }
  }
}
```
