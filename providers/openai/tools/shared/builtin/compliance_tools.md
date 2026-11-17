# compliance_tools

## list_policies
**Input schema:**
```json
{
  "type": "object",
  "properties": {
    "limit": {
      "type": "integer",
      "description": "Maximum number of policies to return",
      "default": 50
    }
  },
  "required": []
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
    "policies": {
      "type": "array",
      "items": {
        "type": "object",
        "properties": {
          "upload_id": {
            "type": "string"
          },
          "original_filename": {
            "type": "string"
          },
          "file_size": {
            "type": "integer"
          },
          "upload_created_at": {
            "type": "string"
          },
          "overall_status": {
            "type": "string"
          },
          "processing_stage": {
            "type": "string"
          },
          "can_download": {
            "type": "boolean"
          },
          "is_global": {
            "type": "boolean"
          },
          "policy_name": {
            "type": "string"
          },
          "ar_description": {
            "type": "string"
          }
        }
      }
    },
    "total_count": {
      "type": "integer"
    },
    "error": {
      "type": "string"
    }
  }
}
```

## get_policy_rules
**Input schema:**
```json
{
  "type": "object",
  "properties": {
    "policy_id": {
      "type": "string",
      "description": "UUID of the policy to download rules from"
    }
  },
  "required": [
    "policy_id"
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
    "rules": {
      "type": "array",
      "items": {
        "type": "object",
        "properties": {
          "id": {
            "type": "string"
          },
          "aws_ar_rule_id": {
            "type": "string"
          },
          "rule_type": {
            "type": "string"
          },
          "description": {
            "type": "string"
          },
          "expression": {
            "type": "string"
          },
          "tags": {
            "type": "array",
            "items": {
              "type": "string"
            }
          },
          "alternateExpression": {
            "type": "string"
          },
          "tag_mappings": {
            "type": "object",
            "description": "Map of tag name to chunk_id",
            "additionalProperties": {
              "type": "string"
            }
          }
        }
      }
    },
    "rule_count": {
      "type": "integer"
    },
    "policy_name": {
      "type": "string"
    },
    "policy_id": {
      "type": "string"
    },
    "error": {
      "type": "string"
    }
  }
}
```

## submit_validation
**Input schema:**
```json
{
  "type": "object",
  "properties": {
    "policy_id": {
      "type": "string",
      "description": "UUID of the policy to validate against"
    },
    "content": {
      "type": "string",
      "description": "Text content to validate"
    },
    "rule_ids": {
      "type": "array",
      "items": {
        "type": "string"
      },
      "description": "Optional list of specific rule IDs to validate against"
    },
    "enable_llm_judge": {
      "type": "boolean",
      "description": "Whether to enable LLM judge",
      "default": false
    }
  },
  "required": [
    "policy_id",
    "content"
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
    "job_id": {
      "type": "string"
    },
    "status": {
      "type": "string"
    },
    "error": {
      "type": "string"
    }
  }
}
```

## get_validation_results
**Input schema:**
```json
{
  "type": "object",
  "properties": {
    "job_id": {
      "type": "string",
      "description": "The validation job ID"
    },
    "wait_for_completion": {
      "type": "boolean",
      "description": "Whether to poll until job completes",
      "default": true
    },
    "max_wait_seconds": {
      "type": "integer",
      "description": "Maximum time to wait for completion",
      "default": 600
    }
  },
  "required": [
    "job_id"
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
    "status": {
      "type": "string",
      "description": "completed, failed, pending, or timeout"
    },
    "job_id": {
      "type": "string"
    },
    "results": {
      "type": "object",
      "description": "Validation results (present when status=completed)",
      "properties": {
        "rules": {
          "type": "array",
          "items": {
            "type": "object",
            "properties": {
              "rule_id": {
                "type": "string",
                "description": "Unique rule identifier"
              },
              "rule_type": {
                "type": "string",
                "description": "Rule type (smt_boolean, regex, keyword, etc.)"
              },
              "description": {
                "type": "string",
                "description": "Human-readable rule description"
              },
              "status": {
                "type": "string",
                "description": "Compliance verdict from the sequential validation pipeline",
                "enum": [
                  "Satisfied",
                  "Not-Satisfied",
                  "Needs-Clarification",
                  "Not-Relevant"
                ]
              },
              "is_relevant": {
                "type": "boolean",
                "description": "Whether the rule is relevant to the document"
              },
              "relevance_reasoning": {
                "type": "string",
                "description": "Why this rule is or is not relevant"
              },
              "compliance_reasoning": {
                "type": "string",
                "description": "Evidence-based compliance analysis"
              },
              "failure_explanation": {
                "type": "string",
                "description": "Why the rule failed (if Not-Satisfied)"
              },
              "remediation_suggestions": {
                "type": "string",
                "description": "How to fix compliance (if Not-Satisfied)"
              },
              "formal_consistency": {
                "type": "object",
                "description": "Formal logic consistency check between LLM verdict and solver",
                "properties": {
                  "status": {
                    "type": "string",
                    "enum": [
                      "Consistent",
                      "Inconsistent",
                      "Undetermined",
                      "Skipped",
                      "Error"
                    ]
                  },
                  "assigned_variables": {
                    "type": "object",
                    "description": "Variable values extracted from document"
                  }
                }
              },
              "variables": {
                "type": "object",
                "description": "Extracted variable values for this rule"
              },
              "citations": {
                "type": "object",
                "description": "Policy citations grounding this rule",
                "properties": {
                  "grounding_statements": {
                    "type": "array",
                    "items": {
                      "type": "object",
                      "properties": {
                        "text": {
                          "type": "string"
                        },
                        "statement_id": {
                          "type": "string"
                        }
                      }
                    }
                  }
                }
              }
            }
          }
        },
        "summary": {
          "type": "object",
          "description": "Overall validation summary with status counts",
          "properties": {
            "total_rules": {
              "type": "integer"
            },
            "contextual": {
              "type": "object",
              "properties": {
                "satisfied": {
                  "type": "integer"
                },
                "not_satisfied": {
                  "type": "integer"
                },
                "needs_clarification": {
                  "type": "integer"
                },
                "not_relevant": {
                  "type": "integer"
                }
              }
            },
            "formal_consistency": {
              "type": "object",
              "properties": {
                "consistent": {
                  "type": "integer"
                },
                "inconsistent": {
                  "type": "integer"
                },
                "undetermined": {
                  "type": "integer"
                },
                "skipped": {
                  "type": "integer"
                }
              }
            }
          }
        },
        "clarification_questions": {
          "type": "object",
          "description": "Questions for rules with Needs-Clarification status, keyed by rule_id. Check this dict when a rule has status Needs-Clarification.",
          "additionalProperties": {
            "type": "object",
            "properties": {
              "question": {
                "type": "string",
                "description": "Plain-English question to resolve ambiguity"
              },
              "rule_description": {
                "type": "string"
              },
              "policy_citation": {
                "type": "string",
                "description": "Original policy text"
              },
              "variable_names": {
                "type": "array",
                "items": {
                  "type": "string"
                }
              },
              "original_reasoning": {
                "type": "string",
                "description": "Why clarification is needed"
              }
            }
          }
        }
      }
    },
    "error": {
      "type": "string"
    }
  }
}
```

## get_rules_by_tags
**Input schema:**
```json
{
  "type": "object",
  "properties": {
    "policy_id": {
      "type": "string",
      "description": "UUID of the policy"
    },
    "tags": {
      "type": "array",
      "items": {
        "type": "string"
      },
      "description": "List of tag names to filter by"
    }
  },
  "required": [
    "policy_id",
    "tags"
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
    "matching_rules": {
      "type": "array"
    },
    "match_count": {
      "type": "integer"
    },
    "error": {
      "type": "string"
    }
  }
}
```

## get_rules_by_type
**Input schema:**
```json
{
  "type": "object",
  "properties": {
    "policy_id": {
      "type": "string",
      "description": "UUID of the policy"
    },
    "rule_type": {
      "type": "string",
      "description": "Auto-tag category to filter by: \"Promissory Language\", \"Performance Presentation\", \"Testimonials and Endorsements\", or \"Risk Disclosures\"",
      "enum": [
        "Promissory Language",
        "Performance Presentation",
        "Testimonials and Endorsements",
        "Risk Disclosures"
      ]
    }
  },
  "required": [
    "policy_id",
    "rule_type"
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
      "description": "True if rules were successfully retrieved"
    },
    "rules": {
      "type": "array",
      "description": "List of rule objects matching the specified type",
      "items": {
        "type": "object"
      }
    },
    "rule_ids": {
      "type": "array",
      "description": "List of rule IDs matching the specified type",
      "items": {
        "type": "string"
      }
    },
    "rule_count": {
      "type": "integer",
      "description": "Number of rules matching the type"
    },
    "rule_type": {
      "type": "string",
      "description": "The requested rule type category"
    },
    "policy_id": {
      "type": "string",
      "description": "UUID of the policy"
    },
    "error": {
      "type": "string",
      "description": "Error message if retrieval failed"
    }
  }
}
```

## get_rule_citations
**Input schema:**
```json
{
  "type": "object",
  "properties": {
    "policy_id": {
      "type": "string",
      "description": "UUID of the policy"
    },
    "rule_ids": {
      "type": "array",
      "items": {
        "type": "string"
      },
      "description": "Optional list of rule IDs to get citations for"
    }
  },
  "required": [
    "policy_id"
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
    "citations": {
      "type": "object",
      "description": "Map of rule_id to list of citation objects",
      "additionalProperties": {
        "type": "array",
        "items": {
          "type": "object",
          "properties": {
            "chunk_id": {
              "type": "string"
            },
            "content": {
              "type": "string"
            },
            "section_title": {
              "type": "string"
            }
          }
        }
      }
    },
    "total_citations": {
      "type": "integer"
    },
    "rules_with_citations": {
      "type": "integer"
    },
    "error": {
      "type": "string"
    }
  }
}
```

## validate_content
**Input schema:**
```json
{
  "type": "object",
  "properties": {
    "policy_id": {
      "type": "string",
      "description": "UUID of the policy to validate against"
    },
    "content": {
      "type": "string",
      "description": "Text content to validate"
    },
    "rule_ids": {
      "type": "array",
      "items": {
        "type": "string"
      },
      "description": "Optional list of specific rule IDs to validate against"
    },
    "enable_llm_judge": {
      "type": "boolean",
      "description": "Whether to enable LLM judge",
      "default": false
    },
    "max_wait_seconds": {
      "type": "integer",
      "description": "Maximum time to wait for validation completion",
      "default": 600
    },
    "pause_for_clarification": {
      "type": "boolean",
      "description": "Whether to pause the board run when clarification questions are generated. If false, clarification questions are skipped and the run continues.",
      "default": false
    }
  },
  "required": [
    "policy_id",
    "content"
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
    "job_id": {
      "type": "string"
    },
    "result": {
      "type": "object",
      "description": "Validation result (if completed)",
      "properties": {
        "rules": {
          "type": "array",
          "items": {
            "type": "object",
            "properties": {
              "rule_id": {
                "type": "string",
                "description": "Unique rule identifier"
              },
              "rule_type": {
                "type": "string",
                "description": "Rule type (smt_boolean, regex, keyword, etc.)"
              },
              "description": {
                "type": "string",
                "description": "Human-readable rule description"
              },
              "status": {
                "type": "string",
                "description": "Compliance verdict from the sequential validation pipeline",
                "enum": [
                  "Satisfied",
                  "Not-Satisfied",
                  "Needs-Clarification",
                  "Not-Relevant"
                ]
              },
              "is_relevant": {
                "type": "boolean",
                "description": "Whether the rule is relevant to the document"
              },
              "relevance_reasoning": {
                "type": "string",
                "description": "Why this rule is or is not relevant"
              },
              "compliance_reasoning": {
                "type": "string",
                "description": "Evidence-based compliance analysis"
              },
              "failure_explanation": {
                "type": "string",
                "description": "Why the rule failed (if Not-Satisfied)"
              },
              "remediation_suggestions": {
                "type": "string",
                "description": "How to fix compliance (if Not-Satisfied)"
              },
              "formal_consistency": {
                "type": "object",
                "description": "Formal logic consistency check between LLM verdict and solver",
                "properties": {
                  "status": {
                    "type": "string",
                    "enum": [
                      "Consistent",
                      "Inconsistent",
                      "Undetermined",
                      "Skipped",
                      "Error"
                    ]
                  },
                  "assigned_variables": {
                    "type": "object",
                    "description": "Variable values extracted from document"
                  }
                }
              },
              "variables": {
                "type": "object",
                "description": "Extracted variable values for this rule"
              },
              "citations": {
                "type": "object",
                "description": "Policy citations grounding this rule",
                "properties": {
                  "grounding_statements": {
                    "type": "array",
                    "items": {
                      "type": "object",
                      "properties": {
                        "text": {
                          "type": "string"
                        },
                        "statement_id": {
                          "type": "string"
                        }
                      }
                    }
                  }
                }
              }
            }
          }
        },
        "summary": {
          "type": "object",
          "description": "Overall validation summary with status counts",
          "properties": {
            "total_rules": {
              "type": "integer"
            },
            "contextual": {
              "type": "object",
              "properties": {
                "satisfied": {
                  "type": "integer"
                },
                "not_satisfied": {
                  "type": "integer"
                },
                "needs_clarification": {
                  "type": "integer"
                },
                "not_relevant": {
                  "type": "integer"
                }
              }
            },
            "formal_consistency": {
              "type": "object",
              "properties": {
                "consistent": {
                  "type": "integer"
                },
                "inconsistent": {
                  "type": "integer"
                },
                "undetermined": {
                  "type": "integer"
                },
                "skipped": {
                  "type": "integer"
                }
              }
            }
          }
        },
        "clarification_questions": {
          "type": "object",
          "description": "Questions for rules with Needs-Clarification status, keyed by rule_id. Check this dict when a rule has status Needs-Clarification.",
          "additionalProperties": {
            "type": "object",
            "properties": {
              "question": {
                "type": "string",
                "description": "Plain-English question to resolve ambiguity"
              },
              "rule_description": {
                "type": "string"
              },
              "policy_citation": {
                "type": "string",
                "description": "Original policy text"
              },
              "variable_names": {
                "type": "array",
                "items": {
                  "type": "string"
                }
              },
              "original_reasoning": {
                "type": "string",
                "description": "Why clarification is needed"
              }
            }
          }
        }
      }
    },
    "error": {
      "type": "string"
    }
  }
}
```
