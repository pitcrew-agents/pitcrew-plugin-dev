# sec_tools

## fetch_adv_part1
**Input schema:**
```json
{
  "type": "object",
  "properties": {
    "crd_number": {
      "type": "string",
      "description": "The firm's CRD (Central Registration Depository) number"
    }
  },
  "required": [
    "crd_number"
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
    "adv_data": {
      "type": "object",
      "description": "ADV Part 1 data with human-readable field names (e.g., total_employees, clients_individuals_count, raum_total)"
    },
    "firm_name": {
      "type": "string",
      "description": "Business name of the firm"
    },
    "legal_name": {
      "type": "string",
      "description": "Legal name of the firm"
    },
    "crd_number": {
      "type": "string"
    },
    "sec_number": {
      "type": "string",
      "description": "SEC registration number if available"
    },
    "registration_source": {
      "type": "string",
      "description": "Registration type: \"SEC\" or \"STATE\""
    },
    "error": {
      "type": "string",
      "description": "Error message if fetch failed"
    }
  }
}
```

## fetch_adv_part2
**Input schema:**
```json
{
  "type": "object",
  "properties": {
    "crd_number": {
      "type": "string",
      "description": "The firm's CRD (Central Registration Depository) number"
    }
  },
  "required": [
    "crd_number"
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
    "crd_number": {
      "type": "string"
    },
    "brochure_count": {
      "type": "integer",
      "description": "Number of qualifying brochures downloaded"
    },
    "brochure_names": {
      "type": "array",
      "description": "Names of all qualifying brochures downloaded",
      "items": {
        "type": "string"
      }
    },
    "documents": {
      "type": "array",
      "description": "Array of individual brochure documents with separate text for each",
      "items": {
        "type": "object",
        "properties": {
          "name": {
            "type": "string",
            "description": "Brochure document name"
          },
          "type": {
            "type": "string",
            "description": "Detected type: \"firm_brochure\", \"wrap_fee\", or \"unknown\""
          },
          "text": {
            "type": "string",
            "description": "Full extracted text from this brochure"
          },
          "text_length": {
            "type": "integer",
            "description": "Length of text in characters"
          }
        }
      }
    },
    "available_brochures": {
      "type": "array",
      "description": "List of all brochure names on the SEC page (including excluded ones)",
      "items": {
        "type": "string"
      }
    },
    "error": {
      "type": "string",
      "description": "Error message if fetch failed"
    }
  }
}
```

## extract_section_from_text
**Input schema:**
```json
{
  "type": "object",
  "properties": {
    "documents": {
      "type": "array",
      "description": "Array of brochure documents from fetch_adv_part2.documents. Extracts from each document separately for accurate per-document results.",
      "items": {
        "type": "object",
        "properties": {
          "name": {
            "type": "string"
          },
          "type": {
            "type": "string"
          },
          "text": {
            "type": "string"
          },
          "text_length": {
            "type": "integer"
          }
        }
      }
    },
    "item_number": {
      "type": "integer",
      "description": "The Item number to extract (1-18). Key items: 4=Advisory Business, 5=Fees and Compensation, 7=Types of Clients",
      "minimum": 1,
      "maximum": 18
    }
  },
  "required": [
    "documents",
    "item_number"
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
    "item_number": {
      "type": "integer",
      "description": "The Item number that was extracted"
    },
    "item_title": {
      "type": "string",
      "description": "Title of the section (e.g., \"Fees and Compensation\")"
    },
    "content": {
      "type": "string",
      "description": "Extracted section text. When using documents input, combines results from all documents with source labels."
    },
    "content_length": {
      "type": "integer",
      "description": "Length of extracted content in characters"
    },
    "per_document": {
      "type": "array",
      "description": "Per-document extraction results (only present when documents input is used)",
      "items": {
        "type": "object",
        "properties": {
          "source": {
            "type": "string",
            "description": "Brochure document name"
          },
          "type": {
            "type": "string",
            "description": "Brochure type"
          },
          "success": {
            "type": "boolean"
          },
          "content": {
            "type": "string",
            "description": "Extracted section from this document"
          },
          "content_length": {
            "type": "integer"
          },
          "error": {
            "type": "string"
          }
        }
      }
    },
    "error": {
      "type": "string",
      "description": "Error message if extraction failed"
    }
  }
}
```

## fetch_form_crs
**Input schema:**
```json
{
  "type": "object",
  "properties": {
    "crd_number": {
      "type": "string",
      "description": "The firm's CRD (Central Registration Depository) number"
    }
  },
  "required": [
    "crd_number"
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
    "crd_number": {
      "type": "string"
    },
    "full_text": {
      "type": "string",
      "description": "Extracted text from Form CRS PDF"
    },
    "text_length": {
      "type": "integer",
      "description": "Length of extracted text in characters"
    },
    "source_url": {
      "type": "string",
      "description": "SEC API URL where the CRS was retrieved from"
    },
    "error": {
      "type": "string",
      "description": "Error message if fetch failed"
    }
  }
}
```

## fetch_adv_part1_bulk
**Input schema:**
```json
{
  "type": "object",
  "properties": {
    "crd_numbers": {
      "type": "array",
      "items": {
        "type": "string"
      },
      "minItems": 1,
      "maxItems": 10,
      "description": "Array of CRD numbers to fetch Part 1A data for"
    }
  },
  "required": [
    "crd_numbers"
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
      "description": "True if at least one CRD fetch succeeded"
    },
    "results": {
      "type": "object",
      "description": "Dict keyed by CRD number with per-firm Part 1A data (each with success, data, extracted_fields, etc.)"
    },
    "summary": {
      "type": "object",
      "description": "Summary with total, successful, and failed counts",
      "properties": {
        "total": {
          "type": "integer"
        },
        "successful": {
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

## fetch_adv_part2_bulk
**Input schema:**
```json
{
  "type": "object",
  "properties": {
    "crd_numbers": {
      "type": "array",
      "items": {
        "type": "string"
      },
      "minItems": 1,
      "maxItems": 10,
      "description": "Array of CRD numbers to fetch Part 2A brochure text for"
    }
  },
  "required": [
    "crd_numbers"
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
      "description": "True if at least one CRD fetch succeeded"
    },
    "results": {
      "type": "object",
      "description": "Dict keyed by CRD number with per-firm Part 2A data (each with success, full_text, brochure_name, etc.)"
    },
    "summary": {
      "type": "object",
      "description": "Summary with total, successful, and failed counts",
      "properties": {
        "total": {
          "type": "integer"
        },
        "successful": {
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

## fetch_form_crs_bulk
**Input schema:**
```json
{
  "type": "object",
  "properties": {
    "crd_numbers": {
      "type": "array",
      "items": {
        "type": "string"
      },
      "minItems": 1,
      "maxItems": 10,
      "description": "Array of CRD numbers to fetch Form CRS for"
    }
  },
  "required": [
    "crd_numbers"
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
      "description": "True if at least one CRD fetch succeeded"
    },
    "results": {
      "type": "object",
      "description": "Dict keyed by CRD number with per-firm CRS data (each with success, full_text, source_url, etc.)"
    },
    "summary": {
      "type": "object",
      "description": "Summary with total, successful, and failed counts",
      "properties": {
        "total": {
          "type": "integer"
        },
        "successful": {
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

## extract_section_from_text_bulk
**Input schema:**
```json
{
  "type": "object",
  "properties": {
    "texts": {
      "type": "object",
      "description": "Dictionary mapping CRD numbers to brochure text or fetch result objects (with full_text field)"
    },
    "item_number": {
      "type": "integer",
      "description": "The Item number to extract (1-18). Use 5 for Fees and Compensation.",
      "minimum": 1,
      "maximum": 18
    }
  },
  "required": [
    "texts",
    "item_number"
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
      "description": "True if at least one extraction succeeded"
    },
    "results": {
      "type": "object",
      "description": "Dict keyed by CRD number with per-firm section data (each with success, content, item_title, etc.)"
    },
    "summary": {
      "type": "object",
      "description": "Summary with total, successful, and failed counts",
      "properties": {
        "total": {
          "type": "integer"
        },
        "successful": {
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

## extract_fees_part1a
**Input schema:**
```json
{
  "type": "object",
  "properties": {
    "user_crd": {
      "type": "string",
      "description": "The user's firm CRD number"
    },
    "user_part1a_data": {
      "type": "object",
      "description": "The user firm's Part 1A data (the data field from fetch_adv_part1)"
    },
    "competitor_part1a_results": {
      "type": "object",
      "description": "Results from fetch_adv_part1_bulk, keyed by CRD number"
    }
  },
  "required": [
    "user_crd",
    "user_part1a_data",
    "competitor_part1a_results"
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
    "extracted_fees": {
      "type": "object",
      "description": "Dict keyed by CRD with per-firm extracted fee data from LLM analysis"
    },
    "summary": {
      "type": "object",
      "description": "Summary with total, successful, and failed counts",
      "properties": {
        "total": {
          "type": "integer"
        },
        "successful": {
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

## extract_fees_part2a
**Input schema:**
```json
{
  "type": "object",
  "properties": {
    "user_crd": {
      "type": "string",
      "description": "The user's firm CRD number"
    },
    "user_item5_content": {
      "type": "string",
      "description": "The user firm's Item 5 extracted text"
    },
    "competitor_item5_results": {
      "type": "object",
      "description": "Results from extract_section_from_text_bulk, keyed by CRD number"
    }
  },
  "required": [
    "user_crd",
    "user_item5_content",
    "competitor_item5_results"
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
    "extracted_fees": {
      "type": "object",
      "description": "Dict keyed by CRD with per-firm extracted fee data from LLM analysis"
    },
    "summary": {
      "type": "object",
      "description": "Summary with total, successful, and failed counts",
      "properties": {
        "total": {
          "type": "integer"
        },
        "successful": {
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

## extract_fees_form_crs
**Input schema:**
```json
{
  "type": "object",
  "properties": {
    "user_crd": {
      "type": "string",
      "description": "The user's firm CRD number"
    },
    "user_crs_text": {
      "type": "string",
      "description": "The user firm's Form CRS text"
    },
    "competitor_crs_results": {
      "type": "object",
      "description": "Results from fetch_form_crs_bulk, keyed by CRD number"
    }
  },
  "required": [
    "user_crd",
    "user_crs_text",
    "competitor_crs_results"
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
    "extracted_fees": {
      "type": "object",
      "description": "Dict keyed by CRD with per-firm extracted fee data from LLM analysis"
    },
    "summary": {
      "type": "object",
      "description": "Summary with total, successful, and failed counts",
      "properties": {
        "total": {
          "type": "integer"
        },
        "successful": {
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
