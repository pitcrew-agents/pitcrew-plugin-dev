# typeform

## TYPEFORM_CREATE_ACCOUNT_WORKSPACE
Tool to create a new workspace in a specific Typeform account. Use when you need to create a workspace within a particular account using the account ID.

**Input schema:**
```json
{
  "type": "object",
  "title": "TypeformCreateAccountWorkspaceRequest",
  "required": [
    "account_id",
    "name"
  ],
  "properties": {
    "name": {
      "type": "string",
      "title": "Name",
      "examples": [
        "Marketing Team",
        "Product Development",
        "Customer Research"
      ],
      "description": "Name of the new workspace to create"
    },
    "account_id": {
      "type": "string",
      "title": "Account Id",
      "examples": [
        "01KEBVS4Y8D96GR8E7Z6MGV20A"
      ],
      "description": "The ULID format identifier for the account where the workspace will be created"
    }
  }
}
```

**Output schema:**
```json
{
  "type": "object",
  "$defs": {
    "WorkspaceSelf": {
      "type": "object",
      "title": "WorkspaceSelf",
      "required": [
        "href"
      ],
      "properties": {
        "href": {
          "type": "string",
          "title": "Href",
          "description": "Link to the workspace"
        }
      }
    },
    "WorkspaceForms": {
      "type": "object",
      "title": "WorkspaceForms",
      "required": [
        "href"
      ],
      "properties": {
        "href": {
          "type": "string",
          "title": "Href",
          "description": "Link to typeforms in the workspace"
        },
        "count": {
          "type": "integer",
          "title": "Count",
          "default": 0,
          "description": "Number of typeforms in the workspace"
        }
      }
    },
    "WorkspaceMember": {
      "type": "object",
      "title": "WorkspaceMember",
      "required": [
        "email",
        "name",
        "role"
      ],
      "properties": {
        "name": {
          "type": "string",
          "title": "Name",
          "description": "Member name"
        },
        "role": {
          "type": "string",
          "title": "Role",
          "description": "Member role in the workspace. Valid values are 'owner' or 'member'"
        },
        "email": {
          "type": "string",
          "title": "Email",
          "description": "Member email address"
        }
      }
    },
    "TypeformCreateAccountWorkspaceResponse": {
      "type": "object",
      "title": "TypeformCreateAccountWorkspaceResponse",
      "required": [
        "id"
      ],
      "properties": {
        "id": {
          "type": "string",
          "title": "Id",
          "description": "Unique identifier for the workspace"
        },
        "name": {
          "type": "string",
          "title": "Name",
          "description": "Name of the workspace"
        },
        "self": {
          "type": "object",
          "title": "Self",
          "required": [
            "href"
          ],
          "properties": {
            "href": {
              "type": "string",
              "title": "Href",
              "description": "Link to the workspace"
            }
          },
          "description": "Self reference links for the workspace"
        },
        "forms": {
          "type": "object",
          "title": "Forms",
          "required": [
            "href"
          ],
          "properties": {
            "href": {
              "type": "string",
              "title": "Href",
              "description": "Link to typeforms in the workspace"
            },
            "count": {
              "type": "integer",
              "title": "Count",
              "default": 0,
              "description": "Number of typeforms in the workspace"
            }
          },
          "description": "Information about forms in the workspace"
        },
        "shared": {
          "type": "boolean",
          "title": "Shared",
          "description": "Indicates whether the workspace is shared with a team"
        },
        "members": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "WorkspaceMember",
            "required": [
              "email",
              "name",
              "role"
            ],
            "properties": {
              "name": {
                "type": "string",
                "title": "Name",
                "description": "Member name"
              },
              "role": {
                "type": "string",
                "title": "Role",
                "description": "Member role in the workspace. Valid values are 'owner' or 'member'"
              },
              "email": {
                "type": "string",
                "title": "Email",
                "description": "Member email address"
              }
            }
          },
          "title": "Members",
          "description": "List of workspace members with their roles"
        },
        "account_id": {
          "type": "string",
          "title": "Account Id",
          "description": "ID in the ULID format of the account where workspace belongs to"
        }
      }
    }
  },
  "title": "TypeformCreateAccountWorkspaceResponseWrapper",
  "required": [
    "data",
    "successful"
  ],
  "properties": {
    "data": {
      "type": "object",
      "title": "Data",
      "required": [
        "id"
      ],
      "properties": {
        "id": {
          "type": "string",
          "title": "Id",
          "description": "Unique identifier for the workspace"
        },
        "name": {
          "type": "string",
          "title": "Name",
          "description": "Name of the workspace"
        },
        "self": {
          "type": "object",
          "title": "Self",
          "required": [
            "href"
          ],
          "properties": {
            "href": {
              "type": "string",
              "title": "Href",
              "description": "Link to the workspace"
            }
          },
          "description": "Self reference links for the workspace"
        },
        "forms": {
          "type": "object",
          "title": "Forms",
          "required": [
            "href"
          ],
          "properties": {
            "href": {
              "type": "string",
              "title": "Href",
              "description": "Link to typeforms in the workspace"
            },
            "count": {
              "type": "integer",
              "title": "Count",
              "default": 0,
              "description": "Number of typeforms in the workspace"
            }
          },
          "description": "Information about forms in the workspace"
        },
        "shared": {
          "type": "boolean",
          "title": "Shared",
          "description": "Indicates whether the workspace is shared with a team"
        },
        "members": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "WorkspaceMember",
            "required": [
              "email",
              "name",
              "role"
            ],
            "properties": {
              "name": {
                "type": "string",
                "title": "Name",
                "description": "Member name"
              },
              "role": {
                "type": "string",
                "title": "Role",
                "description": "Member role in the workspace. Valid values are 'owner' or 'member'"
              },
              "email": {
                "type": "string",
                "title": "Email",
                "description": "Member email address"
              }
            }
          },
          "title": "Members",
          "description": "List of workspace members with their roles"
        },
        "account_id": {
          "type": "string",
          "title": "Account Id",
          "description": "ID in the ULID format of the account where workspace belongs to"
        }
      },
      "description": "Data from the action execution"
    },
    "error": {
      "type": "string",
      "title": "Error",
      "description": "Error if any occurred during the execution of the action"
    },
    "successful": {
      "type": "boolean",
      "title": "Successful",
      "description": "Whether or not the action execution was successful or not"
    }
  }
}
```

## TYPEFORM_CREATE_FORM
Tool to create a new Typeform form with customizable fields, logic, and settings. Use when you need to programmatically create a form with specific questions, welcome screens, thank you screens, and conditional logic.

**Input schema:**
```json
{
  "type": "object",
  "title": "CreateFormRequest",
  "required": [
    "title"
  ],
  "properties": {
    "type": {
      "type": "string",
      "title": "Type",
      "examples": [
        "quiz",
        "form"
      ],
      "description": "Form type (quiz, classification, score, branching, etc.)"
    },
    "logic": {
      "type": "array",
      "items": {
        "type": "object",
        "title": "LogicJump",
        "required": [
          "type",
          "ref",
          "actions"
        ],
        "properties": {
          "ref": {
            "type": "string",
            "title": "Ref",
            "description": "Reference to the field this logic applies to"
          },
          "type": {
            "type": "string",
            "title": "Type",
            "examples": [
              "field"
            ],
            "description": "Logic type (field, hidden)"
          },
          "actions": {
            "type": "array",
            "items": {
              "type": "object",
              "additionalProperties": true
            },
            "title": "Actions",
            "description": "Actions to perform based on conditions"
          }
        },
        "description": "Logic jump configuration"
      },
      "title": "Logic",
      "description": "Conditional logic jumps and variable calculations"
    },
    "theme": {
      "type": "object",
      "title": "ThemeReference",
      "required": [
        "href"
      ],
      "properties": {
        "href": {
          "type": "string",
          "title": "Href",
          "description": "Theme URL reference"
        }
      },
      "description": "Theme reference",
      "additionalProperties": false
    },
    "title": {
      "type": "string",
      "title": "Title",
      "examples": [
        "Customer Feedback Survey",
        "Event Registration Form"
      ],
      "description": "Form title"
    },
    "fields": {
      "type": "array",
      "items": {
        "type": "object",
        "title": "FormField",
        "required": [
          "title",
          "type"
        ],
        "properties": {
          "ref": {
            "type": "string",
            "title": "Ref",
            "description": "Unique reference for the field"
          },
          "type": {
            "type": "string",
            "title": "Type",
            "examples": [
              "short_text",
              "email",
              "multiple_choice",
              "nps",
              "rating"
            ],
            "description": "Field type. Valid types: calendly, contact_info, date, dropdown, email, file_upload, group, legal, long_text, matrix, multi_format, multiple_choice, nps, number, opinion_scale, payment, phone_number, picture_choice, ranking, rating, short_text, statement, website, yes_no"
          },
          "title": {
            "type": "string",
            "title": "Title",
            "examples": [
              "What is your name?"
            ],
            "description": "Field title/question"
          },
          "attachment": {
            "type": "object",
            "title": "FieldAttachment",
            "properties": {
              "href": {
                "type": "string",
                "title": "Href",
                "description": "URL of the attachment"
              },
              "type": {
                "type": "string",
                "title": "Type",
                "description": "Type of attachment (image, video)"
              },
              "scale": {
                "type": "number",
                "title": "Scale",
                "description": "Scale factor for the attachment"
              },
              "properties": {
                "type": "object",
                "title": "Properties",
                "description": "Additional properties",
                "additionalProperties": true
              }
            },
            "description": "Attachment for a field (image, video, etc.)",
            "additionalProperties": false
          },
          "properties": {
            "type": "object",
            "title": "FieldProperties",
            "properties": {
              "fields": {
                "type": "array",
                "items": {
                  "type": "object",
                  "additionalProperties": true
                },
                "title": "Fields",
                "description": "Sub-fields for group fields"
              },
              "choices": {
                "type": "array",
                "items": {
                  "type": "object",
                  "additionalProperties": true
                },
                "title": "Choices",
                "description": "Choices for multiple choice fields"
              },
              "randomize": {
                "type": "boolean",
                "title": "Randomize",
                "description": "Randomize choice order"
              },
              "hide_marks": {
                "type": "boolean",
                "title": "Hide Marks",
                "description": "Hide marks on opinion scale"
              },
              "button_text": {
                "type": "string",
                "title": "Button Text",
                "description": "Custom button text"
              },
              "description": {
                "type": "string",
                "title": "Description",
                "description": "Field description"
              },
              "allow_other_choice": {
                "type": "boolean",
                "title": "Allow Other Choice",
                "description": "Allow other choice option"
              },
              "alphabetical_order": {
                "type": "boolean",
                "title": "Alphabetical Order",
                "description": "Sort choices alphabetically"
              },
              "vertical_alignment": {
                "type": "boolean",
                "title": "Vertical Alignment",
                "description": "Vertical alignment for choices"
              },
              "allow_multiple_selection": {
                "type": "boolean",
                "title": "Allow Multiple Selection",
                "description": "Allow multiple selections"
              }
            },
            "description": "Properties for a field",
            "additionalProperties": false
          },
          "validations": {
            "type": "object",
            "title": "FieldValidation",
            "properties": {
              "required": {
                "type": "boolean",
                "title": "Required",
                "description": "Whether the field is required"
              },
              "max_value": {
                "type": "number",
                "title": "Max Value",
                "description": "Maximum value for number fields"
              },
              "min_value": {
                "type": "number",
                "title": "Min Value",
                "description": "Minimum value for number fields"
              },
              "max_length": {
                "type": "integer",
                "title": "Max Length",
                "description": "Maximum length for text fields"
              },
              "min_length": {
                "type": "integer",
                "title": "Min Length",
                "description": "Minimum length for text fields"
              }
            },
            "description": "Validation rules for a field",
            "additionalProperties": false
          }
        },
        "description": "A form field definition"
      },
      "title": "Fields",
      "description": "Array of field definitions for the form questions"
    },
    "settings": {
      "type": "object",
      "title": "FormSettings",
      "properties": {
        "is_trial": {
          "type": "boolean",
          "title": "Is Trial",
          "description": "Is trial form"
        },
        "language": {
          "type": "string",
          "title": "Language",
          "examples": [
            "en"
          ],
          "description": "Form language code"
        },
        "is_public": {
          "type": "boolean",
          "title": "Is Public",
          "description": "Make form public"
        },
        "capabilities": {
          "type": "object",
          "title": "Capabilities",
          "description": "Form capabilities",
          "additionalProperties": true
        },
        "progress_bar": {
          "type": "string",
          "title": "Progress Bar",
          "description": "Progress bar type (proportion, percentage)"
        },
        "notifications": {
          "type": "object",
          "title": "Notifications",
          "description": "Notification settings",
          "additionalProperties": true
        },
        "facebook_pixel": {
          "type": "string",
          "title": "Facebook Pixel",
          "description": "Facebook Pixel ID"
        },
        "hide_navigation": {
          "type": "boolean",
          "title": "Hide Navigation",
          "description": "Hide navigation"
        },
        "google_analytics": {
          "type": "string",
          "title": "Google Analytics",
          "description": "Google Analytics ID"
        },
        "autosave_progress": {
          "type": "boolean",
          "title": "Autosave Progress",
          "description": "Autosave respondent progress"
        },
        "show_progress_bar": {
          "type": "boolean",
          "title": "Show Progress Bar",
          "description": "Show progress bar"
        },
        "are_uploads_public": {
          "type": "boolean",
          "title": "Are Uploads Public",
          "description": "Make uploads public"
        },
        "google_tag_manager": {
          "type": "string",
          "title": "Google Tag Manager",
          "description": "Google Tag Manager ID"
        },
        "show_cookie_consent": {
          "type": "boolean",
          "title": "Show Cookie Consent",
          "description": "Show cookie consent"
        },
        "free_form_navigation": {
          "type": "boolean",
          "title": "Free Form Navigation",
          "description": "Allow free form navigation"
        },
        "show_question_number": {
          "type": "boolean",
          "title": "Show Question Number",
          "description": "Show question numbers"
        },
        "pro_subdomain_enabled": {
          "type": "boolean",
          "title": "Pro Subdomain Enabled",
          "description": "Enable pro subdomain"
        },
        "show_time_to_complete": {
          "type": "boolean",
          "title": "Show Time To Complete",
          "description": "Show estimated completion time"
        },
        "show_typeform_branding": {
          "type": "boolean",
          "title": "Show Typeform Branding",
          "description": "Show Typeform branding"
        },
        "show_key_hint_on_choices": {
          "type": "boolean",
          "title": "Show Key Hint On Choices",
          "description": "Show keyboard hints"
        },
        "redirect_after_submit_url": {
          "type": "string",
          "title": "Redirect After Submit Url",
          "description": "Redirect URL after submission"
        },
        "show_number_of_submissions": {
          "type": "boolean",
          "title": "Show Number Of Submissions",
          "description": "Show number of submissions"
        }
      },
      "description": "Form settings configuration",
      "additionalProperties": false
    },
    "workspace": {
      "type": "object",
      "title": "WorkspaceReference",
      "required": [
        "href"
      ],
      "properties": {
        "href": {
          "type": "string",
          "title": "Href",
          "description": "Workspace URL reference"
        }
      },
      "description": "Workspace reference",
      "additionalProperties": false
    },
    "welcome_screens": {
      "type": "array",
      "items": {
        "type": "object",
        "title": "WelcomeScreen",
        "properties": {
          "title": {
            "type": "string",
            "title": "Title",
            "description": "Welcome screen title"
          },
          "attachment": {
            "type": "object",
            "title": "FieldAttachment",
            "properties": {
              "href": {
                "type": "string",
                "title": "Href",
                "description": "URL of the attachment"
              },
              "type": {
                "type": "string",
                "title": "Type",
                "description": "Type of attachment (image, video)"
              },
              "scale": {
                "type": "number",
                "title": "Scale",
                "description": "Scale factor for the attachment"
              },
              "properties": {
                "type": "object",
                "title": "Properties",
                "description": "Additional properties",
                "additionalProperties": true
              }
            },
            "description": "Attachment for a field (image, video, etc.)",
            "additionalProperties": false
          },
          "properties": {
            "type": "object",
            "title": "Properties",
            "description": "Welcome screen properties",
            "additionalProperties": true
          }
        },
        "description": "Welcome screen configuration"
      },
      "title": "Welcome Screens",
      "description": "Introductory content screens shown before form fields"
    },
    "thankyou_screens": {
      "type": "array",
      "items": {
        "type": "object",
        "title": "ThankyouScreen",
        "properties": {
          "title": {
            "type": "string",
            "title": "Title",
            "description": "Thank you screen title"
          },
          "attachment": {
            "type": "object",
            "title": "FieldAttachment",
            "properties": {
              "href": {
                "type": "string",
                "title": "Href",
                "description": "URL of the attachment"
              },
              "type": {
                "type": "string",
                "title": "Type",
                "description": "Type of attachment (image, video)"
              },
              "scale": {
                "type": "number",
                "title": "Scale",
                "description": "Scale factor for the attachment"
              },
              "properties": {
                "type": "object",
                "title": "Properties",
                "description": "Additional properties",
                "additionalProperties": true
              }
            },
            "description": "Attachment for a field (image, video, etc.)",
            "additionalProperties": false
          },
          "properties": {
            "type": "object",
            "title": "Properties",
            "description": "Thank you screen properties including redirect URLs",
            "additionalProperties": true
          }
        },
        "description": "Thank you screen configuration"
      },
      "title": "Thankyou Screens",
      "description": "Completion screens shown after form submission"
    }
  },
  "description": "Request to create a new Typeform form"
}
```

**Output schema:**
```json
{
  "type": "object",
  "$defs": {
    "FormLinksResponse": {
      "type": "object",
      "title": "FormLinksResponse",
      "properties": {
        "display": {
          "type": "string",
          "title": "Display",
          "description": "Display URL for the form"
        }
      },
      "description": "Links to form resources"
    },
    "FormThemeResponse": {
      "type": "object",
      "title": "FormThemeResponse",
      "properties": {
        "href": {
          "type": "string",
          "title": "Href",
          "description": "Theme URL reference"
        }
      },
      "description": "Theme information in response"
    },
    "CreateFormResponse": {
      "type": "object",
      "title": "CreateFormResponse",
      "required": [
        "id",
        "title"
      ],
      "properties": {
        "id": {
          "type": "string",
          "title": "Id",
          "description": "Unique identifier for the created form"
        },
        "type": {
          "type": "string",
          "title": "Type",
          "description": "Form type"
        },
        "logic": {
          "type": "array",
          "items": {
            "type": "object",
            "additionalProperties": true
          },
          "title": "Logic",
          "description": "Logic jumps"
        },
        "theme": {
          "type": "object",
          "title": "Theme",
          "properties": {
            "href": {
              "type": "string",
              "title": "Href",
              "description": "Theme URL reference"
            }
          },
          "description": "Theme reference"
        },
        "title": {
          "type": "string",
          "title": "Title",
          "description": "Form title"
        },
        "_links": {
          "type": "object",
          "title": " Links",
          "properties": {
            "display": {
              "type": "string",
              "title": "Display",
              "description": "Display URL for the form"
            }
          },
          "description": "Resource links"
        },
        "fields": {
          "type": "array",
          "items": {
            "type": "object",
            "additionalProperties": true
          },
          "title": "Fields",
          "description": "Form fields with complete configuration"
        },
        "hidden": {
          "type": "array",
          "items": {
            "type": "string"
          },
          "title": "Hidden",
          "description": "Hidden field variable names"
        },
        "settings": {
          "type": "object",
          "title": "Settings",
          "description": "Form settings",
          "additionalProperties": true
        },
        "variables": {
          "type": "object",
          "title": "Variables",
          "description": "Score, price, and enrichment variables",
          "additionalProperties": true
        },
        "workspace": {
          "type": "object",
          "title": "Workspace",
          "properties": {
            "href": {
              "type": "string",
              "title": "Href",
              "description": "Workspace URL reference"
            }
          },
          "description": "Workspace reference"
        },
        "welcome_screens": {
          "type": "array",
          "items": {
            "type": "object",
            "additionalProperties": true
          },
          "title": "Welcome Screens",
          "description": "Welcome screens"
        },
        "thankyou_screens": {
          "type": "array",
          "items": {
            "type": "object",
            "additionalProperties": true
          },
          "title": "Thankyou Screens",
          "description": "Thank you screens"
        }
      },
      "description": "Response containing the created form details"
    },
    "FormWorkspaceResponse": {
      "type": "object",
      "title": "FormWorkspaceResponse",
      "properties": {
        "href": {
          "type": "string",
          "title": "Href",
          "description": "Workspace URL reference"
        }
      },
      "description": "Workspace information in response"
    }
  },
  "title": "CreateFormResponseWrapper",
  "required": [
    "data",
    "successful"
  ],
  "properties": {
    "data": {
      "type": "object",
      "title": "Data",
      "required": [
        "id",
        "title"
      ],
      "properties": {
        "id": {
          "type": "string",
          "title": "Id",
          "description": "Unique identifier for the created form"
        },
        "type": {
          "type": "string",
          "title": "Type",
          "description": "Form type"
        },
        "logic": {
          "type": "array",
          "items": {
            "type": "object",
            "additionalProperties": true
          },
          "title": "Logic",
          "description": "Logic jumps"
        },
        "theme": {
          "type": "object",
          "title": "Theme",
          "properties": {
            "href": {
              "type": "string",
              "title": "Href",
              "description": "Theme URL reference"
            }
          },
          "description": "Theme reference"
        },
        "title": {
          "type": "string",
          "title": "Title",
          "description": "Form title"
        },
        "_links": {
          "type": "object",
          "title": " Links",
          "properties": {
            "display": {
              "type": "string",
              "title": "Display",
              "description": "Display URL for the form"
            }
          },
          "description": "Resource links"
        },
        "fields": {
          "type": "array",
          "items": {
            "type": "object",
            "additionalProperties": true
          },
          "title": "Fields",
          "description": "Form fields with complete configuration"
        },
        "hidden": {
          "type": "array",
          "items": {
            "type": "string"
          },
          "title": "Hidden",
          "description": "Hidden field variable names"
        },
        "settings": {
          "type": "object",
          "title": "Settings",
          "description": "Form settings",
          "additionalProperties": true
        },
        "variables": {
          "type": "object",
          "title": "Variables",
          "description": "Score, price, and enrichment variables",
          "additionalProperties": true
        },
        "workspace": {
          "type": "object",
          "title": "Workspace",
          "properties": {
            "href": {
              "type": "string",
              "title": "Href",
              "description": "Workspace URL reference"
            }
          },
          "description": "Workspace reference"
        },
        "welcome_screens": {
          "type": "array",
          "items": {
            "type": "object",
            "additionalProperties": true
          },
          "title": "Welcome Screens",
          "description": "Welcome screens"
        },
        "thankyou_screens": {
          "type": "array",
          "items": {
            "type": "object",
            "additionalProperties": true
          },
          "title": "Thankyou Screens",
          "description": "Thank you screens"
        }
      },
      "description": "Data from the action execution"
    },
    "error": {
      "type": "string",
      "title": "Error",
      "description": "Error if any occurred during the execution of the action"
    },
    "successful": {
      "type": "boolean",
      "title": "Successful",
      "description": "Whether or not the action execution was successful or not"
    }
  }
}
```

## TYPEFORM_CREATE_IMAGE
Tool to upload a new image to your Typeform account via base64 encoding or URL. Use when you need to add images for forms or presentations. Either 'image' (base64) or 'url' parameter must be provided.

**Input schema:**
```json
{
  "type": "object",
  "title": "CreateImageRequest",
  "required": [
    "file_name"
  ],
  "properties": {
    "url": {
      "type": "string",
      "title": "Url",
      "examples": [
        "https://images.unsplash.com/photo-1506905925346-21bda4d32df4"
      ],
      "description": "Direct link to an existing image online. Either 'image' or 'url' must be provided."
    },
    "image": {
      "type": "string",
      "title": "Image",
      "description": "Base64 code for the image (exclude data:image descriptors). Either 'image' or 'url' must be provided."
    },
    "file_name": {
      "type": "string",
      "title": "File Name",
      "examples": [
        "test_image.jpg",
        "banner.png"
      ],
      "description": "The name assigned to your image file"
    }
  }
}
```

**Output schema:**
```json
{
  "type": "object",
  "$defs": {
    "CreateImageResponse": {
      "type": "object",
      "title": "CreateImageResponse",
      "required": [
        "id",
        "src",
        "file_name",
        "width",
        "height",
        "media_type",
        "has_alpha",
        "avg_color"
      ],
      "properties": {
        "id": {
          "type": "string",
          "title": "Id",
          "description": "Unique ID for the image"
        },
        "src": {
          "type": "string",
          "title": "Src",
          "description": "URL for the image"
        },
        "width": {
          "type": "integer",
          "title": "Width",
          "description": "Width of the image in pixels"
        },
        "height": {
          "type": "integer",
          "title": "Height",
          "description": "Height of the image in pixels"
        },
        "avg_color": {
          "type": "string",
          "title": "Avg Color",
          "description": "Average color of the image in hexadecimal format"
        },
        "file_name": {
          "type": "string",
          "title": "File Name",
          "description": "File name for the image"
        },
        "has_alpha": {
          "type": "boolean",
          "title": "Has Alpha",
          "description": "True if image has alpha channel (transparency), otherwise false"
        },
        "media_type": {
          "type": "string",
          "title": "Media Type",
          "description": "The MIME type of the image"
        }
      }
    }
  },
  "title": "CreateImageResponseWrapper",
  "required": [
    "data",
    "successful"
  ],
  "properties": {
    "data": {
      "type": "object",
      "title": "Data",
      "required": [
        "id",
        "src",
        "file_name",
        "width",
        "height",
        "media_type",
        "has_alpha",
        "avg_color"
      ],
      "properties": {
        "id": {
          "type": "string",
          "title": "Id",
          "description": "Unique ID for the image"
        },
        "src": {
          "type": "string",
          "title": "Src",
          "description": "URL for the image"
        },
        "width": {
          "type": "integer",
          "title": "Width",
          "description": "Width of the image in pixels"
        },
        "height": {
          "type": "integer",
          "title": "Height",
          "description": "Height of the image in pixels"
        },
        "avg_color": {
          "type": "string",
          "title": "Avg Color",
          "description": "Average color of the image in hexadecimal format"
        },
        "file_name": {
          "type": "string",
          "title": "File Name",
          "description": "File name for the image"
        },
        "has_alpha": {
          "type": "boolean",
          "title": "Has Alpha",
          "description": "True if image has alpha channel (transparency), otherwise false"
        },
        "media_type": {
          "type": "string",
          "title": "Media Type",
          "description": "The MIME type of the image"
        }
      },
      "description": "Data from the action execution"
    },
    "error": {
      "type": "string",
      "title": "Error",
      "description": "Error if any occurred during the execution of the action"
    },
    "successful": {
      "type": "boolean",
      "title": "Successful",
      "description": "Whether or not the action execution was successful or not"
    }
  }
}
```

## TYPEFORM_CREATE_OR_UPDATE_WEBHOOK
Tool to create a new webhook or update an existing one for a specified Typeform. Use when you need to configure webhooks to receive form response notifications at a specified URL.

**Input schema:**
```json
{
  "type": "object",
  "title": "TypeformCreateOrUpdateWebhookRequest",
  "required": [
    "form_id",
    "tag",
    "url"
  ],
  "properties": {
    "tag": {
      "type": "string",
      "title": "Tag",
      "examples": [
        "test-webhook-tag"
      ],
      "description": "Unique webhook name you assign to identify this webhook"
    },
    "url": {
      "type": "string",
      "title": "Url",
      "examples": [
        "https://webhook.site/unique-url-test"
      ],
      "description": "Webhook destination URL where form responses will be sent"
    },
    "secret": {
      "type": "string",
      "title": "Secret",
      "description": "HMAC SHA256 signing key for payload verification. Use this to verify webhook authenticity"
    },
    "enabled": {
      "type": "boolean",
      "title": "Enabled",
      "default": true,
      "description": "Whether to send responses immediately. Set to true to enable the webhook, false to disable it"
    },
    "form_id": {
      "type": "string",
      "title": "Form Id",
      "examples": [
        "Y78g1cmS"
      ],
      "description": "Unique identifier for the form"
    },
    "verify_ssl": {
      "type": "boolean",
      "title": "Verify Ssl",
      "description": "Whether to verify SSL certificates during webhook delivery. Set to false if using self-signed certificates"
    },
    "event_types": {
      "type": "object",
      "title": "Event Types",
      "description": "Event types that trigger the webhook (e.g., {'form_response_partial': True}). If not specified, defaults to form_response",
      "additionalProperties": {
        "type": "boolean"
      }
    }
  }
}
```

**Output schema:**
```json
{
  "type": "object",
  "$defs": {
    "TypeformCreateOrUpdateWebhookResponse": {
      "type": "object",
      "title": "TypeformCreateOrUpdateWebhookResponse",
      "properties": {
        "id": {
          "type": "string",
          "title": "Id",
          "description": "Unique identifier for the webhook"
        },
        "tag": {
          "type": "string",
          "title": "Tag",
          "description": "Webhook tag/name"
        },
        "url": {
          "type": "string",
          "title": "Url",
          "description": "Webhook destination URL"
        },
        "secret": {
          "type": "string",
          "title": "Secret",
          "description": "Secret key for HMAC signature verification"
        },
        "enabled": {
          "type": "boolean",
          "title": "Enabled",
          "description": "Whether the webhook is enabled"
        },
        "form_id": {
          "type": "string",
          "title": "Form Id",
          "description": "Form ID this webhook is associated with"
        },
        "created_at": {
          "type": "string",
          "title": "Created At",
          "description": "ISO 8601 timestamp when the webhook was created"
        },
        "updated_at": {
          "type": "string",
          "title": "Updated At",
          "description": "ISO 8601 timestamp when the webhook was last updated"
        },
        "verify_ssl": {
          "type": "boolean",
          "title": "Verify Ssl",
          "description": "Whether SSL certificate verification is enabled"
        },
        "event_types": {
          "type": "object",
          "title": "Event Types",
          "description": "Event types that trigger the webhook",
          "additionalProperties": {
            "type": "boolean"
          }
        }
      }
    }
  },
  "title": "TypeformCreateOrUpdateWebhookResponseWrapper",
  "required": [
    "data",
    "successful"
  ],
  "properties": {
    "data": {
      "type": "object",
      "title": "Data",
      "properties": {
        "id": {
          "type": "string",
          "title": "Id",
          "description": "Unique identifier for the webhook"
        },
        "tag": {
          "type": "string",
          "title": "Tag",
          "description": "Webhook tag/name"
        },
        "url": {
          "type": "string",
          "title": "Url",
          "description": "Webhook destination URL"
        },
        "secret": {
          "type": "string",
          "title": "Secret",
          "description": "Secret key for HMAC signature verification"
        },
        "enabled": {
          "type": "boolean",
          "title": "Enabled",
          "description": "Whether the webhook is enabled"
        },
        "form_id": {
          "type": "string",
          "title": "Form Id",
          "description": "Form ID this webhook is associated with"
        },
        "created_at": {
          "type": "string",
          "title": "Created At",
          "description": "ISO 8601 timestamp when the webhook was created"
        },
        "updated_at": {
          "type": "string",
          "title": "Updated At",
          "description": "ISO 8601 timestamp when the webhook was last updated"
        },
        "verify_ssl": {
          "type": "boolean",
          "title": "Verify Ssl",
          "description": "Whether SSL certificate verification is enabled"
        },
        "event_types": {
          "type": "object",
          "title": "Event Types",
          "description": "Event types that trigger the webhook",
          "additionalProperties": {
            "type": "boolean"
          }
        }
      },
      "description": "Data from the action execution"
    },
    "error": {
      "type": "string",
      "title": "Error",
      "description": "Error if any occurred during the execution of the action"
    },
    "successful": {
      "type": "boolean",
      "title": "Successful",
      "description": "Whether or not the action execution was successful or not"
    }
  }
}
```

## TYPEFORM_CREATE_THEME
Tool to create a new custom theme in Typeform with colors, fonts, background, and layout settings. Use when you need to create a theme for branding and styling Typeform forms.

**Input schema:**
```json
{
  "type": "object",
  "title": "CreateThemeRequest",
  "required": [
    "colors",
    "fields",
    "font"
  ],
  "properties": {
    "font": {
      "type": "string",
      "title": "Font",
      "examples": [
        "Karla"
      ],
      "description": "Font choice from predefined Typeform options (e.g., 'Karla', 'Arial', 'Georgia'). This field is required by the API."
    },
    "name": {
      "type": "string",
      "title": "Name",
      "examples": [
        "Test Theme Created by API"
      ],
      "description": "Name of the theme"
    },
    "colors": {
      "type": "object",
      "title": "Colors",
      "required": [
        "answer",
        "background",
        "button",
        "question"
      ],
      "properties": {
        "answer": {
          "type": "string",
          "title": "Answer",
          "examples": [
            "#4FB0AE"
          ],
          "description": "Hex color code for answer text (e.g., '#4FB0AE')"
        },
        "button": {
          "type": "string",
          "title": "Button",
          "examples": [
            "#4FB0AE"
          ],
          "description": "Hex color code for button (e.g., '#4FB0AE')"
        },
        "question": {
          "type": "string",
          "title": "Question",
          "examples": [
            "#3D3D3D"
          ],
          "description": "Hex color code for question text (e.g., '#3D3D3D')"
        },
        "background": {
          "type": "string",
          "title": "Background",
          "examples": [
            "#FFFFFF"
          ],
          "description": "Hex color code for background (e.g., '#FFFFFF')"
        }
      },
      "description": "Color configuration with answer, background, button, and question hex values. All color fields are required.",
      "additionalProperties": false
    },
    "fields": {
      "type": "object",
      "title": "Fields",
      "required": [
        "alignment",
        "font_size"
      ],
      "properties": {
        "alignment": {
          "enum": [
            "left",
            "center"
          ],
          "type": "string",
          "title": "Alignment",
          "examples": [
            "left"
          ],
          "description": "Text alignment for form fields. Must be 'left' or 'center'"
        },
        "font_size": {
          "enum": [
            "small",
            "medium",
            "large"
          ],
          "type": "string",
          "title": "Font Size",
          "examples": [
            "medium"
          ],
          "description": "Font size for form fields. Must be 'small', 'medium', or 'large'"
        }
      },
      "description": "Field alignment (left/center) and font_size (small/medium/large). Both fields are required.",
      "additionalProperties": false
    },
    "background": {
      "type": "object",
      "title": "BackgroundModel",
      "required": [
        "href"
      ],
      "properties": {
        "href": {
          "type": "string",
          "title": "Href",
          "examples": [
            "https://example.com/image.jpg"
          ],
          "description": "URL of the background image"
        },
        "layout": {
          "enum": [
            "fullscreen",
            "repeat",
            "no-repeat"
          ],
          "type": "string",
          "title": "Layout",
          "examples": [
            "fullscreen"
          ],
          "description": "Background image layout. Must be 'fullscreen', 'repeat', or 'no-repeat'"
        },
        "brightness": {
          "type": "number",
          "title": "Brightness",
          "maximum": 1,
          "minimum": -1,
          "examples": [
            0.5
          ],
          "description": "Background brightness level, must be between -1 and 1"
        }
      },
      "description": "Background configuration for the theme.",
      "additionalProperties": false
    },
    "rounded_corners": {
      "enum": [
        "none",
        "small",
        "large"
      ],
      "type": "string",
      "title": "Rounded Corners",
      "examples": [
        "small"
      ],
      "description": "Border radius setting. Must be 'none', 'small', or 'large'"
    },
    "has_transparent_button": {
      "type": "boolean",
      "title": "Has Transparent Button",
      "examples": [
        false
      ],
      "description": "Whether the button should be transparent"
    }
  }
}
```

**Output schema:**
```json
{
  "type": "object",
  "$defs": {
    "ColorsModel": {
      "type": "object",
      "title": "ColorsModel",
      "required": [
        "answer",
        "background",
        "button",
        "question"
      ],
      "properties": {
        "answer": {
          "type": "string",
          "title": "Answer",
          "examples": [
            "#4FB0AE"
          ],
          "description": "Hex color code for answer text (e.g., '#4FB0AE')"
        },
        "button": {
          "type": "string",
          "title": "Button",
          "examples": [
            "#4FB0AE"
          ],
          "description": "Hex color code for button (e.g., '#4FB0AE')"
        },
        "question": {
          "type": "string",
          "title": "Question",
          "examples": [
            "#3D3D3D"
          ],
          "description": "Hex color code for question text (e.g., '#3D3D3D')"
        },
        "background": {
          "type": "string",
          "title": "Background",
          "examples": [
            "#FFFFFF"
          ],
          "description": "Hex color code for background (e.g., '#FFFFFF')"
        }
      },
      "description": "Color configuration for the theme."
    },
    "FieldsModel": {
      "type": "object",
      "title": "FieldsModel",
      "required": [
        "alignment",
        "font_size"
      ],
      "properties": {
        "alignment": {
          "enum": [
            "left",
            "center"
          ],
          "type": "string",
          "title": "Alignment",
          "examples": [
            "left"
          ],
          "description": "Text alignment for form fields. Must be 'left' or 'center'"
        },
        "font_size": {
          "enum": [
            "small",
            "medium",
            "large"
          ],
          "type": "string",
          "title": "Font Size",
          "examples": [
            "medium"
          ],
          "description": "Font size for form fields. Must be 'small', 'medium', or 'large'"
        }
      },
      "description": "Field layout configuration for the theme."
    },
    "BackgroundModel": {
      "type": "object",
      "title": "BackgroundModel",
      "required": [
        "href"
      ],
      "properties": {
        "href": {
          "type": "string",
          "title": "Href",
          "examples": [
            "https://example.com/image.jpg"
          ],
          "description": "URL of the background image"
        },
        "layout": {
          "enum": [
            "fullscreen",
            "repeat",
            "no-repeat"
          ],
          "type": "string",
          "title": "Layout",
          "examples": [
            "fullscreen"
          ],
          "description": "Background image layout. Must be 'fullscreen', 'repeat', or 'no-repeat'"
        },
        "brightness": {
          "type": "number",
          "title": "Brightness",
          "maximum": 1,
          "minimum": -1,
          "examples": [
            0.5
          ],
          "description": "Background brightness level, must be between -1 and 1"
        }
      },
      "description": "Background configuration for the theme."
    },
    "CreateThemeResponse": {
      "type": "object",
      "title": "CreateThemeResponse",
      "required": [
        "id"
      ],
      "properties": {
        "id": {
          "type": "string",
          "title": "Id",
          "description": "Unique identifier of the created theme"
        },
        "font": {
          "type": "string",
          "title": "Font",
          "description": "Font of the created theme"
        },
        "name": {
          "type": "string",
          "title": "Name",
          "description": "Name of the created theme"
        },
        "colors": {
          "type": "object",
          "title": "Colors",
          "required": [
            "answer",
            "background",
            "button",
            "question"
          ],
          "properties": {
            "answer": {
              "type": "string",
              "title": "Answer",
              "examples": [
                "#4FB0AE"
              ],
              "description": "Hex color code for answer text (e.g., '#4FB0AE')"
            },
            "button": {
              "type": "string",
              "title": "Button",
              "examples": [
                "#4FB0AE"
              ],
              "description": "Hex color code for button (e.g., '#4FB0AE')"
            },
            "question": {
              "type": "string",
              "title": "Question",
              "examples": [
                "#3D3D3D"
              ],
              "description": "Hex color code for question text (e.g., '#3D3D3D')"
            },
            "background": {
              "type": "string",
              "title": "Background",
              "examples": [
                "#FFFFFF"
              ],
              "description": "Hex color code for background (e.g., '#FFFFFF')"
            }
          },
          "description": "Color configuration of the created theme"
        },
        "fields": {
          "type": "object",
          "title": "Fields",
          "required": [
            "alignment",
            "font_size"
          ],
          "properties": {
            "alignment": {
              "enum": [
                "left",
                "center"
              ],
              "type": "string",
              "title": "Alignment",
              "examples": [
                "left"
              ],
              "description": "Text alignment for form fields. Must be 'left' or 'center'"
            },
            "font_size": {
              "enum": [
                "small",
                "medium",
                "large"
              ],
              "type": "string",
              "title": "Font Size",
              "examples": [
                "medium"
              ],
              "description": "Font size for form fields. Must be 'small', 'medium', or 'large'"
            }
          },
          "description": "Field configuration of the created theme"
        },
        "background": {
          "type": "object",
          "title": "Background",
          "required": [
            "href"
          ],
          "properties": {
            "href": {
              "type": "string",
              "title": "Href",
              "examples": [
                "https://example.com/image.jpg"
              ],
              "description": "URL of the background image"
            },
            "layout": {
              "enum": [
                "fullscreen",
                "repeat",
                "no-repeat"
              ],
              "type": "string",
              "title": "Layout",
              "examples": [
                "fullscreen"
              ],
              "description": "Background image layout. Must be 'fullscreen', 'repeat', or 'no-repeat'"
            },
            "brightness": {
              "type": "number",
              "title": "Brightness",
              "maximum": 1,
              "minimum": -1,
              "examples": [
                0.5
              ],
              "description": "Background brightness level, must be between -1 and 1"
            }
          },
          "description": "Background configuration of the created theme"
        },
        "visibility": {
          "type": "string",
          "title": "Visibility",
          "description": "Visibility setting of the theme"
        },
        "rounded_corners": {
          "type": "string",
          "title": "Rounded Corners",
          "description": "Border radius setting of the created theme"
        },
        "has_transparent_button": {
          "type": "boolean",
          "title": "Has Transparent Button",
          "description": "Button transparency setting of the created theme"
        }
      }
    }
  },
  "title": "CreateThemeResponseWrapper",
  "required": [
    "data",
    "successful"
  ],
  "properties": {
    "data": {
      "type": "object",
      "title": "Data",
      "required": [
        "id"
      ],
      "properties": {
        "id": {
          "type": "string",
          "title": "Id",
          "description": "Unique identifier of the created theme"
        },
        "font": {
          "type": "string",
          "title": "Font",
          "description": "Font of the created theme"
        },
        "name": {
          "type": "string",
          "title": "Name",
          "description": "Name of the created theme"
        },
        "colors": {
          "type": "object",
          "title": "Colors",
          "required": [
            "answer",
            "background",
            "button",
            "question"
          ],
          "properties": {
            "answer": {
              "type": "string",
              "title": "Answer",
              "examples": [
                "#4FB0AE"
              ],
              "description": "Hex color code for answer text (e.g., '#4FB0AE')"
            },
            "button": {
              "type": "string",
              "title": "Button",
              "examples": [
                "#4FB0AE"
              ],
              "description": "Hex color code for button (e.g., '#4FB0AE')"
            },
            "question": {
              "type": "string",
              "title": "Question",
              "examples": [
                "#3D3D3D"
              ],
              "description": "Hex color code for question text (e.g., '#3D3D3D')"
            },
            "background": {
              "type": "string",
              "title": "Background",
              "examples": [
                "#FFFFFF"
              ],
              "description": "Hex color code for background (e.g., '#FFFFFF')"
            }
          },
          "description": "Color configuration of the created theme"
        },
        "fields": {
          "type": "object",
          "title": "Fields",
          "required": [
            "alignment",
            "font_size"
          ],
          "properties": {
            "alignment": {
              "enum": [
                "left",
                "center"
              ],
              "type": "string",
              "title": "Alignment",
              "examples": [
                "left"
              ],
              "description": "Text alignment for form fields. Must be 'left' or 'center'"
            },
            "font_size": {
              "enum": [
                "small",
                "medium",
                "large"
              ],
              "type": "string",
              "title": "Font Size",
              "examples": [
                "medium"
              ],
              "description": "Font size for form fields. Must be 'small', 'medium', or 'large'"
            }
          },
          "description": "Field configuration of the created theme"
        },
        "background": {
          "type": "object",
          "title": "Background",
          "required": [
            "href"
          ],
          "properties": {
            "href": {
              "type": "string",
              "title": "Href",
              "examples": [
                "https://example.com/image.jpg"
              ],
              "description": "URL of the background image"
            },
            "layout": {
              "enum": [
                "fullscreen",
                "repeat",
                "no-repeat"
              ],
              "type": "string",
              "title": "Layout",
              "examples": [
                "fullscreen"
              ],
              "description": "Background image layout. Must be 'fullscreen', 'repeat', or 'no-repeat'"
            },
            "brightness": {
              "type": "number",
              "title": "Brightness",
              "maximum": 1,
              "minimum": -1,
              "examples": [
                0.5
              ],
              "description": "Background brightness level, must be between -1 and 1"
            }
          },
          "description": "Background configuration of the created theme"
        },
        "visibility": {
          "type": "string",
          "title": "Visibility",
          "description": "Visibility setting of the theme"
        },
        "rounded_corners": {
          "type": "string",
          "title": "Rounded Corners",
          "description": "Border radius setting of the created theme"
        },
        "has_transparent_button": {
          "type": "boolean",
          "title": "Has Transparent Button",
          "description": "Button transparency setting of the created theme"
        }
      },
      "description": "Data from the action execution"
    },
    "error": {
      "type": "string",
      "title": "Error",
      "description": "Error if any occurred during the execution of the action"
    },
    "successful": {
      "type": "boolean",
      "title": "Successful",
      "description": "Whether or not the action execution was successful or not"
    }
  }
}
```

## TYPEFORM_CREATE_WORKSPACE
Tool to create a new workspace in Typeform. Use when organizing forms into separate workspaces for teams or projects.

**Input schema:**
```json
{
  "type": "object",
  "title": "CreateWorkspaceRequest",
  "required": [
    "name"
  ],
  "properties": {
    "name": {
      "type": "string",
      "title": "Name",
      "examples": [
        "Marketing Team",
        "Product Development",
        "Customer Research"
      ],
      "description": "The name of the workspace to create"
    }
  }
}
```

**Output schema:**
```json
{
  "type": "object",
  "$defs": {
    "SelfLink": {
      "type": "object",
      "title": "SelfLink",
      "required": [
        "href"
      ],
      "properties": {
        "href": {
          "type": "string",
          "title": "Href",
          "description": "URL reference to the workspace resource"
        }
      }
    },
    "UserInfo": {
      "type": "object",
      "title": "UserInfo",
      "properties": {
        "id": {
          "type": "string",
          "title": "Id",
          "description": "User ID"
        },
        "name": {
          "type": "string",
          "title": "Name",
          "description": "User name"
        },
        "email": {
          "type": "string",
          "title": "Email",
          "description": "User email"
        }
      }
    },
    "FormsInfo": {
      "type": "object",
      "title": "FormsInfo",
      "properties": {
        "href": {
          "type": "string",
          "title": "Href",
          "description": "URL to list forms in this workspace"
        },
        "count": {
          "type": "integer",
          "title": "Count",
          "default": 0,
          "description": "Number of forms in the workspace"
        }
      }
    },
    "WorkspaceMember": {
      "type": "object",
      "title": "WorkspaceMember",
      "properties": {
        "id": {
          "type": "string",
          "title": "Id",
          "description": "Member ID"
        },
        "name": {
          "type": "string",
          "title": "Name",
          "description": "Member name"
        },
        "role": {
          "type": "string",
          "title": "Role",
          "description": "Member role"
        },
        "user": {
          "type": "object",
          "title": "User",
          "properties": {
            "id": {
              "type": "string",
              "title": "Id",
              "description": "User ID"
            },
            "name": {
              "type": "string",
              "title": "Name",
              "description": "User name"
            },
            "email": {
              "type": "string",
              "title": "Email",
              "description": "User email"
            }
          },
          "description": "User details"
        },
        "email": {
          "type": "string",
          "title": "Email",
          "description": "Member email"
        },
        "permissions": {
          "type": "array",
          "items": {
            "type": "string"
          },
          "title": "Permissions",
          "description": "List of permissions"
        },
        "account_member_id": {
          "type": "string",
          "title": "Account Member Id",
          "description": "Account member ID"
        }
      }
    },
    "CreateWorkspaceResponse": {
      "type": "object",
      "title": "CreateWorkspaceResponse",
      "required": [
        "id",
        "name"
      ],
      "properties": {
        "id": {
          "type": "string",
          "title": "Id",
          "description": "Unique identifier for the workspace"
        },
        "name": {
          "type": "string",
          "title": "Name",
          "description": "Name of the workspace"
        },
        "self": {
          "type": "object",
          "title": "Self",
          "required": [
            "href"
          ],
          "properties": {
            "href": {
              "type": "string",
              "title": "Href",
              "description": "URL reference to the workspace resource"
            }
          },
          "description": "Self reference link to the workspace"
        },
        "forms": {
          "type": "object",
          "title": "Forms",
          "properties": {
            "href": {
              "type": "string",
              "title": "Href",
              "description": "URL to list forms in this workspace"
            },
            "count": {
              "type": "integer",
              "title": "Count",
              "default": 0,
              "description": "Number of forms in the workspace"
            }
          },
          "description": "Forms count and link information for the workspace"
        },
        "shared": {
          "type": "boolean",
          "title": "Shared",
          "description": "Whether the workspace is shared"
        },
        "default": {
          "type": "boolean",
          "title": "Default",
          "description": "Whether this is the default workspace"
        },
        "members": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "WorkspaceMember",
            "properties": {
              "id": {
                "type": "string",
                "title": "Id",
                "description": "Member ID"
              },
              "name": {
                "type": "string",
                "title": "Name",
                "description": "Member name"
              },
              "role": {
                "type": "string",
                "title": "Role",
                "description": "Member role"
              },
              "user": {
                "type": "object",
                "title": "User",
                "properties": {
                  "id": {
                    "type": "string",
                    "title": "Id",
                    "description": "User ID"
                  },
                  "name": {
                    "type": "string",
                    "title": "Name",
                    "description": "User name"
                  },
                  "email": {
                    "type": "string",
                    "title": "Email",
                    "description": "User email"
                  }
                },
                "description": "User details"
              },
              "email": {
                "type": "string",
                "title": "Email",
                "description": "Member email"
              },
              "permissions": {
                "type": "array",
                "items": {
                  "type": "string"
                },
                "title": "Permissions",
                "description": "List of permissions"
              },
              "account_member_id": {
                "type": "string",
                "title": "Account Member Id",
                "description": "Account member ID"
              }
            }
          },
          "title": "Members",
          "description": "List of workspace members"
        },
        "account_id": {
          "type": "string",
          "title": "Account Id",
          "description": "Account ID associated with the workspace"
        }
      }
    }
  },
  "title": "CreateWorkspaceResponseWrapper",
  "required": [
    "data",
    "successful"
  ],
  "properties": {
    "data": {
      "type": "object",
      "title": "Data",
      "required": [
        "id",
        "name"
      ],
      "properties": {
        "id": {
          "type": "string",
          "title": "Id",
          "description": "Unique identifier for the workspace"
        },
        "name": {
          "type": "string",
          "title": "Name",
          "description": "Name of the workspace"
        },
        "self": {
          "type": "object",
          "title": "Self",
          "required": [
            "href"
          ],
          "properties": {
            "href": {
              "type": "string",
              "title": "Href",
              "description": "URL reference to the workspace resource"
            }
          },
          "description": "Self reference link to the workspace"
        },
        "forms": {
          "type": "object",
          "title": "Forms",
          "properties": {
            "href": {
              "type": "string",
              "title": "Href",
              "description": "URL to list forms in this workspace"
            },
            "count": {
              "type": "integer",
              "title": "Count",
              "default": 0,
              "description": "Number of forms in the workspace"
            }
          },
          "description": "Forms count and link information for the workspace"
        },
        "shared": {
          "type": "boolean",
          "title": "Shared",
          "description": "Whether the workspace is shared"
        },
        "default": {
          "type": "boolean",
          "title": "Default",
          "description": "Whether this is the default workspace"
        },
        "members": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "WorkspaceMember",
            "properties": {
              "id": {
                "type": "string",
                "title": "Id",
                "description": "Member ID"
              },
              "name": {
                "type": "string",
                "title": "Name",
                "description": "Member name"
              },
              "role": {
                "type": "string",
                "title": "Role",
                "description": "Member role"
              },
              "user": {
                "type": "object",
                "title": "User",
                "properties": {
                  "id": {
                    "type": "string",
                    "title": "Id",
                    "description": "User ID"
                  },
                  "name": {
                    "type": "string",
                    "title": "Name",
                    "description": "User name"
                  },
                  "email": {
                    "type": "string",
                    "title": "Email",
                    "description": "User email"
                  }
                },
                "description": "User details"
              },
              "email": {
                "type": "string",
                "title": "Email",
                "description": "Member email"
              },
              "permissions": {
                "type": "array",
                "items": {
                  "type": "string"
                },
                "title": "Permissions",
                "description": "List of permissions"
              },
              "account_member_id": {
                "type": "string",
                "title": "Account Member Id",
                "description": "Account member ID"
              }
            }
          },
          "title": "Members",
          "description": "List of workspace members"
        },
        "account_id": {
          "type": "string",
          "title": "Account Id",
          "description": "Account ID associated with the workspace"
        }
      },
      "description": "Data from the action execution"
    },
    "error": {
      "type": "string",
      "title": "Error",
      "description": "Error if any occurred during the execution of the action"
    },
    "successful": {
      "type": "boolean",
      "title": "Successful",
      "description": "Whether or not the action execution was successful or not"
    }
  }
}
```

## TYPEFORM_DELETE_FORM
Tool to permanently delete a Typeform and all of its responses. Use when you need to remove a form completely from the account.

**Input schema:**
```json
{
  "type": "object",
  "title": "TypeformDeleteFormRequest",
  "required": [
    "form_id"
  ],
  "properties": {
    "form_id": {
      "type": "string",
      "title": "Form Id",
      "examples": [
        "Eu7aUntt"
      ],
      "description": "Unique form identifier found in the form URL"
    }
  }
}
```

**Output schema:**
```json
{
  "type": "object",
  "$defs": {
    "TypeformDeleteFormResponse": {
      "type": "object",
      "title": "TypeformDeleteFormResponse",
      "required": [
        "success",
        "message"
      ],
      "properties": {
        "message": {
          "type": "string",
          "title": "Message",
          "description": "Status message about the deletion operation"
        },
        "success": {
          "type": "boolean",
          "title": "Success",
          "description": "Indicates whether the form was successfully deleted"
        }
      }
    }
  },
  "title": "TypeformDeleteFormResponseWrapper",
  "required": [
    "data",
    "successful"
  ],
  "properties": {
    "data": {
      "type": "object",
      "title": "Data",
      "required": [
        "success",
        "message"
      ],
      "properties": {
        "message": {
          "type": "string",
          "title": "Message",
          "description": "Status message about the deletion operation"
        },
        "success": {
          "type": "boolean",
          "title": "Success",
          "description": "Indicates whether the form was successfully deleted"
        }
      },
      "description": "Data from the action execution"
    },
    "error": {
      "type": "string",
      "title": "Error",
      "description": "Error if any occurred during the execution of the action"
    },
    "successful": {
      "type": "boolean",
      "title": "Successful",
      "description": "Whether or not the action execution was successful or not"
    }
  }
}
```

## TYPEFORM_DELETE_IMAGE
Tool to delete an image from your Typeform account. Use when you need to remove an image that is no longer needed. Returns a success status once the image has been deleted (204 No Content).

**Input schema:**
```json
{
  "type": "object",
  "title": "DeleteImageRequest",
  "required": [
    "image_id"
  ],
  "properties": {
    "image_id": {
      "type": "string",
      "title": "Image Id",
      "examples": [
        "zMTupVAd3fzt"
      ],
      "description": "The unique identifier for the image to remove"
    }
  }
}
```

**Output schema:**
```json
{
  "type": "object",
  "$defs": {
    "DeleteImageResponse": {
      "type": "object",
      "title": "DeleteImageResponse",
      "required": [
        "success",
        "message"
      ],
      "properties": {
        "message": {
          "type": "string",
          "title": "Message",
          "description": "Status message about the deletion"
        },
        "success": {
          "type": "boolean",
          "title": "Success",
          "description": "Whether the image was successfully deleted"
        }
      }
    }
  },
  "title": "DeleteImageResponseWrapper",
  "required": [
    "data",
    "successful"
  ],
  "properties": {
    "data": {
      "type": "object",
      "title": "Data",
      "required": [
        "success",
        "message"
      ],
      "properties": {
        "message": {
          "type": "string",
          "title": "Message",
          "description": "Status message about the deletion"
        },
        "success": {
          "type": "boolean",
          "title": "Success",
          "description": "Whether the image was successfully deleted"
        }
      },
      "description": "Data from the action execution"
    },
    "error": {
      "type": "string",
      "title": "Error",
      "description": "Error if any occurred during the execution of the action"
    },
    "successful": {
      "type": "boolean",
      "title": "Successful",
      "description": "Whether or not the action execution was successful or not"
    }
  }
}
```

## TYPEFORM_DELETE_RESPONSES
Tool to delete specific responses from a Typeform by response IDs. Use when you need to remove response data from a form. Deletion is asynchronous - a 200 status means the deletion request was registered, not that deletion is complete. Maximum 1000 response IDs can be deleted per request.

**Input schema:**
```json
{
  "type": "object",
  "title": "DeleteResponsesRequest",
  "required": [
    "form_id",
    "included_response_ids"
  ],
  "properties": {
    "form_id": {
      "type": "string",
      "title": "Form Id",
      "examples": [
        "CoZt0LNp"
      ],
      "description": "Unique form identifier"
    },
    "included_response_ids": {
      "type": "string",
      "title": "Included Response Ids",
      "examples": [
        "test_response_id_123",
        "id1,id2,id3"
      ],
      "description": "Comma-separated list of response IDs to delete (max 1000 IDs). Example: 'id1,id2,id3'"
    }
  }
}
```

**Output schema:**
```json
{
  "type": "object",
  "$defs": {
    "DeleteResponsesResponse": {
      "type": "object",
      "title": "DeleteResponsesResponse",
      "properties": {
        "status": {
          "type": "string",
          "title": "Status",
          "description": "HTTP status code as string (typically '200')"
        },
        "description": {
          "type": "string",
          "title": "Description",
          "description": "Description of the deletion status. Deletion is asynchronous, 200 indicates registration not completion"
        }
      }
    }
  },
  "title": "DeleteResponsesResponseWrapper",
  "required": [
    "data",
    "successful"
  ],
  "properties": {
    "data": {
      "type": "object",
      "title": "Data",
      "properties": {
        "status": {
          "type": "string",
          "title": "Status",
          "description": "HTTP status code as string (typically '200')"
        },
        "description": {
          "type": "string",
          "title": "Description",
          "description": "Description of the deletion status. Deletion is asynchronous, 200 indicates registration not completion"
        }
      },
      "description": "Data from the action execution"
    },
    "error": {
      "type": "string",
      "title": "Error",
      "description": "Error if any occurred during the execution of the action"
    },
    "successful": {
      "type": "boolean",
      "title": "Successful",
      "description": "Whether or not the action execution was successful or not"
    }
  }
}
```

## TYPEFORM_DELETE_THEME
Tool to delete a theme from your Typeform account. Use when you need to permanently remove a theme. This operation cannot be undone.

**Input schema:**
```json
{
  "type": "object",
  "title": "TypeformDeleteThemeRequest",
  "required": [
    "theme_id"
  ],
  "properties": {
    "theme_id": {
      "type": "string",
      "title": "Theme Id",
      "examples": [
        "mQHasBnn",
        "abc123"
      ],
      "description": "Unique theme identifier to delete"
    }
  },
  "description": "Request parameters to delete a theme."
}
```

**Output schema:**
```json
{
  "type": "object",
  "$defs": {
    "TypeformDeleteThemeResponse": {
      "type": "object",
      "title": "TypeformDeleteThemeResponse",
      "properties": {
        "success": {
          "type": "boolean",
          "title": "Success",
          "default": true,
          "description": "Indicates the theme was deleted successfully"
        }
      },
      "description": "Response schema for theme deletion. The API returns 204 No Content on success."
    }
  },
  "title": "TypeformDeleteThemeResponseWrapper",
  "required": [
    "data",
    "successful"
  ],
  "properties": {
    "data": {
      "type": "object",
      "title": "Data",
      "properties": {
        "success": {
          "type": "boolean",
          "title": "Success",
          "default": true,
          "description": "Indicates the theme was deleted successfully"
        }
      },
      "description": "Data from the action execution"
    },
    "error": {
      "type": "string",
      "title": "Error",
      "description": "Error if any occurred during the execution of the action"
    },
    "successful": {
      "type": "boolean",
      "title": "Successful",
      "description": "Whether or not the action execution was successful or not"
    }
  }
}
```

## TYPEFORM_DELETE_WEBHOOK
Tool to delete a webhook configuration from a Typeform form. Use when you need to remove a webhook from a specific form. The operation returns 204 No Content on success and 404 if the webhook is not found.

**Input schema:**
```json
{
  "type": "object",
  "title": "TypeformDeleteWebhookRequest",
  "required": [
    "form_id",
    "tag"
  ],
  "properties": {
    "tag": {
      "type": "string",
      "title": "Tag",
      "examples": [
        "test_webhook_delete",
        "my_webhook"
      ],
      "description": "Unique webhook name to delete"
    },
    "form_id": {
      "type": "string",
      "title": "Form Id",
      "examples": [
        "CoZt0LNp",
        "u6nXL7"
      ],
      "description": "Unique form identifier"
    }
  },
  "description": "Request parameters to delete a webhook from a form."
}
```

**Output schema:**
```json
{
  "type": "object",
  "$defs": {
    "TypeformDeleteWebhookResponse": {
      "type": "object",
      "title": "TypeformDeleteWebhookResponse",
      "properties": {
        "success": {
          "type": "boolean",
          "title": "Success",
          "default": true,
          "description": "Indicates the webhook was successfully deleted"
        }
      },
      "description": "Response schema for webhook deletion. The API returns 204 No Content on success."
    }
  },
  "title": "TypeformDeleteWebhookResponseWrapper",
  "required": [
    "data",
    "successful"
  ],
  "properties": {
    "data": {
      "type": "object",
      "title": "Data",
      "properties": {
        "success": {
          "type": "boolean",
          "title": "Success",
          "default": true,
          "description": "Indicates the webhook was successfully deleted"
        }
      },
      "description": "Data from the action execution"
    },
    "error": {
      "type": "string",
      "title": "Error",
      "description": "Error if any occurred during the execution of the action"
    },
    "successful": {
      "type": "boolean",
      "title": "Successful",
      "description": "Whether or not the action execution was successful or not"
    }
  }
}
```

## TYPEFORM_DELETE_WORKSPACE
Tool to delete a workspace from your Typeform account. Use when you need to remove a workspace. Note: The default 'My Workspace' cannot be deleted, and workspaces containing forms cannot be deleted (will return an error).

**Input schema:**
```json
{
  "type": "object",
  "title": "DeleteWorkspaceRequest",
  "required": [
    "workspace_id"
  ],
  "properties": {
    "workspace_id": {
      "type": "string",
      "title": "Workspace Id",
      "examples": [
        "ucdZbu"
      ],
      "description": "Unique workspace identifier. Note: Default 'My Workspace' cannot be deleted, and workspaces containing forms cannot be deleted."
    }
  }
}
```

**Output schema:**
```json
{
  "type": "object",
  "$defs": {
    "DeleteWorkspaceResponse": {
      "type": "object",
      "title": "DeleteWorkspaceResponse",
      "properties": {
        "message": {
          "type": "string",
          "title": "Message",
          "default": "Workspace deleted successfully",
          "description": "Status message for the deletion operation"
        },
        "success": {
          "type": "boolean",
          "title": "Success",
          "default": true,
          "description": "Indicates successful deletion of the workspace"
        }
      }
    }
  },
  "title": "DeleteWorkspaceResponseWrapper",
  "required": [
    "data",
    "successful"
  ],
  "properties": {
    "data": {
      "type": "object",
      "title": "Data",
      "properties": {
        "message": {
          "type": "string",
          "title": "Message",
          "default": "Workspace deleted successfully",
          "description": "Status message for the deletion operation"
        },
        "success": {
          "type": "boolean",
          "title": "Success",
          "default": true,
          "description": "Indicates successful deletion of the workspace"
        }
      },
      "description": "Data from the action execution"
    },
    "error": {
      "type": "string",
      "title": "Error",
      "description": "Error if any occurred during the execution of the action"
    },
    "successful": {
      "type": "boolean",
      "title": "Successful",
      "description": "Whether or not the action execution was successful or not"
    }
  }
}
```

## TYPEFORM_GET_ABOUT_ME
Get information about the owner account in Typeform.

**Input schema:**
```json
{
  "type": "object",
  "title": "GetAboutMeRequest",
  "properties": {}
}
```

**Output schema:**
```json
{
  "type": "object",
  "$defs": {
    "GetAboutMeResponse": {
      "type": "object",
      "title": "GetAboutMeResponse",
      "required": [
        "owner_info"
      ],
      "properties": {
        "owner_info": {
          "type": "object",
          "title": "Owner Info",
          "description": "Information about the owner account",
          "additionalProperties": true
        }
      }
    }
  },
  "title": "GetAboutMeResponseWrapper",
  "required": [
    "data",
    "successful"
  ],
  "properties": {
    "data": {
      "type": "object",
      "title": "Data",
      "required": [
        "owner_info"
      ],
      "properties": {
        "owner_info": {
          "type": "object",
          "title": "Owner Info",
          "description": "Information about the owner account",
          "additionalProperties": true
        }
      },
      "description": "Data from the action execution"
    },
    "error": {
      "type": "string",
      "title": "Error",
      "description": "Error if any occurred during the execution of the action"
    },
    "successful": {
      "type": "boolean",
      "title": "Successful",
      "description": "Whether or not the action execution was successful or not"
    }
  }
}
```

## TYPEFORM_GET_ALL_RESPONSE_FILES
Tool to retrieve a compressed archive containing all files that respondents uploaded for a specified form. Use when you need to download all file uploads from a Typeform form as a ZIP archive.

**Input schema:**
```json
{
  "type": "object",
  "title": "GetAllResponseFilesRequest",
  "required": [
    "form_id"
  ],
  "properties": {
    "form_id": {
      "type": "string",
      "title": "Form Id",
      "examples": [
        "CoZt0LNp"
      ],
      "description": "Unique identifier of the form to download response files for"
    }
  }
}
```

**Output schema:**
```json
{
  "type": "object",
  "$defs": {
    "FileDownloadable": {
      "type": "object",
      "title": "FileDownloadable",
      "required": [
        "name",
        "mimetype",
        "s3url"
      ],
      "properties": {
        "name": {
          "type": "string",
          "title": "Name",
          "description": "Name of the file"
        },
        "s3url": {
          "type": "string",
          "title": "S3Url",
          "description": "S3 URL of the downloaded file."
        },
        "mimetype": {
          "type": "string",
          "title": "Mimetype",
          "description": "Mime type of the file."
        }
      },
      "file_downloadable": true
    },
    "GetAllResponseFilesResponse": {
      "type": "object",
      "title": "GetAllResponseFilesResponse",
      "properties": {
        "content": {
          "type": "object",
          "title": "Content",
          "required": [
            "name",
            "mimetype",
            "s3url"
          ],
          "properties": {
            "name": {
              "type": "string",
              "title": "Name",
              "description": "Name of the file"
            },
            "s3url": {
              "type": "string",
              "title": "S3Url",
              "description": "S3 URL of the downloaded file."
            },
            "mimetype": {
              "type": "string",
              "title": "Mimetype",
              "description": "Mime type of the file."
            }
          },
          "file_downloadable": true,
          "description": "ZIP archive containing all files uploaded by respondents for the specified form. None if no files are available."
        },
        "message": {
          "type": "string",
          "title": "Message",
          "description": "Status message indicating the result of the request"
        }
      }
    }
  },
  "title": "GetAllResponseFilesResponseWrapper",
  "required": [
    "data",
    "successful"
  ],
  "properties": {
    "data": {
      "type": "object",
      "title": "Data",
      "properties": {
        "content": {
          "type": "object",
          "title": "Content",
          "required": [
            "name",
            "mimetype",
            "s3url"
          ],
          "properties": {
            "name": {
              "type": "string",
              "title": "Name",
              "description": "Name of the file"
            },
            "s3url": {
              "type": "string",
              "title": "S3Url",
              "description": "S3 URL of the downloaded file."
            },
            "mimetype": {
              "type": "string",
              "title": "Mimetype",
              "description": "Mime type of the file."
            }
          },
          "file_downloadable": true,
          "description": "ZIP archive containing all files uploaded by respondents for the specified form. None if no files are available."
        },
        "message": {
          "type": "string",
          "title": "Message",
          "description": "Status message indicating the result of the request"
        }
      },
      "description": "Data from the action execution"
    },
    "error": {
      "type": "string",
      "title": "Error",
      "description": "Error if any occurred during the execution of the action"
    },
    "successful": {
      "type": "boolean",
      "title": "Successful",
      "description": "Whether or not the action execution was successful or not"
    }
  }
}
```

## TYPEFORM_GET_BACKGROUND_BY_SIZE
Tool to retrieve a background image by size from Typeform. Use when you need to get a background image in a specific size (default, tablet, mobile, or thumbnail). Images are scaled and cropped from top-left alignment to fill the screen properly.

**Input schema:**
```json
{
  "type": "object",
  "title": "TypeformGetBackgroundBySizeRequest",
  "required": [
    "image_id",
    "size"
  ],
  "properties": {
    "size": {
      "enum": [
        "default",
        "tablet",
        "mobile",
        "thumbnail"
      ],
      "type": "string",
      "title": "Size",
      "examples": [
        "default"
      ],
      "description": "Dimension preset for the background image. default: scaled to fit 1680x1050px, tablet: scaled to fit 1024x768px, mobile: scaled to fit 460x320px, thumbnail: scaled to fit 80x50px"
    },
    "image_id": {
      "type": "string",
      "title": "Image Id",
      "examples": [
        "YY93X8ZdXCC3"
      ],
      "description": "Unique identifier for the image resource"
    }
  }
}
```

**Output schema:**
```json
{
  "type": "object",
  "$defs": {
    "TypeformGetBackgroundBySizeResponse": {
      "type": "object",
      "title": "TypeformGetBackgroundBySizeResponse",
      "properties": {
        "id": {
          "type": "string",
          "title": "Id",
          "description": "Unique identifier for the image"
        },
        "src": {
          "type": "string",
          "title": "Src",
          "description": "URL of the background image"
        },
        "width": {
          "type": "integer",
          "title": "Width",
          "description": "Width of the background image in pixels"
        },
        "height": {
          "type": "integer",
          "title": "Height",
          "description": "Height of the background image in pixels"
        },
        "avg_color": {
          "type": "string",
          "title": "Avg Color",
          "description": "Average color of the image in hex format"
        },
        "file_name": {
          "type": "string",
          "title": "File Name",
          "description": "Name of the image file"
        },
        "has_alpha": {
          "type": "boolean",
          "title": "Has Alpha",
          "description": "Whether the image has an alpha channel for transparency"
        },
        "media_type": {
          "type": "string",
          "title": "Media Type",
          "description": "Media type of the image (image/gif, image/jpeg, or image/png)"
        }
      }
    }
  },
  "title": "TypeformGetBackgroundBySizeResponseWrapper",
  "required": [
    "data",
    "successful"
  ],
  "properties": {
    "data": {
      "type": "object",
      "title": "Data",
      "properties": {
        "id": {
          "type": "string",
          "title": "Id",
          "description": "Unique identifier for the image"
        },
        "src": {
          "type": "string",
          "title": "Src",
          "description": "URL of the background image"
        },
        "width": {
          "type": "integer",
          "title": "Width",
          "description": "Width of the background image in pixels"
        },
        "height": {
          "type": "integer",
          "title": "Height",
          "description": "Height of the background image in pixels"
        },
        "avg_color": {
          "type": "string",
          "title": "Avg Color",
          "description": "Average color of the image in hex format"
        },
        "file_name": {
          "type": "string",
          "title": "File Name",
          "description": "Name of the image file"
        },
        "has_alpha": {
          "type": "boolean",
          "title": "Has Alpha",
          "description": "Whether the image has an alpha channel for transparency"
        },
        "media_type": {
          "type": "string",
          "title": "Media Type",
          "description": "Media type of the image (image/gif, image/jpeg, or image/png)"
        }
      },
      "description": "Data from the action execution"
    },
    "error": {
      "type": "string",
      "title": "Error",
      "description": "Error if any occurred during the execution of the action"
    },
    "successful": {
      "type": "boolean",
      "title": "Successful",
      "description": "Whether or not the action execution was successful or not"
    }
  }
}
```

## TYPEFORM_GET_CHOICE_IMAGE_BY_SIZE
Tool to retrieve a choice image by size from Typeform. Use when you need to download images used in picture_choice question options at specific sizes.

**Input schema:**
```json
{
  "type": "object",
  "title": "TypeformGetChoiceImageBySizeRequest",
  "required": [
    "image_id",
    "size"
  ],
  "properties": {
    "size": {
      "enum": [
        "default",
        "thumbnail",
        "supersize",
        "supermobile",
        "supersizefit"
      ],
      "type": "string",
      "title": "Size",
      "examples": [
        "default"
      ],
      "description": "Image size to retrieve. Options: 'default' (scaled to fit 230x230px), 'thumbnail' (cropped to 80x80px), 'supersize' (cropped to 310x233px), 'supermobile' (cropped to 238x164px), 'supersizefit' (scaled to fit 310x233px)"
    },
    "image_id": {
      "type": "string",
      "title": "Image Id",
      "examples": [
        "YY93X8ZdXCC3"
      ],
      "description": "Unique ID for the image to retrieve"
    }
  }
}
```

**Output schema:**
```json
{
  "type": "object",
  "$defs": {
    "TypeformGetChoiceImageBySizeResponse": {
      "type": "object",
      "title": "TypeformGetChoiceImageBySizeResponse",
      "properties": {
        "id": {
          "type": "string",
          "title": "Id",
          "description": "Unique identifier for the image"
        },
        "src": {
          "type": "string",
          "title": "Src",
          "description": "URL of the choice image at the requested size"
        },
        "width": {
          "type": "integer",
          "title": "Width",
          "description": "Width of the image in pixels"
        },
        "height": {
          "type": "integer",
          "title": "Height",
          "description": "Height of the image in pixels"
        },
        "avg_color": {
          "type": "string",
          "title": "Avg Color",
          "description": "Average color of the image in hexadecimal format"
        },
        "file_name": {
          "type": "string",
          "title": "File Name",
          "description": "Name of the image file"
        },
        "has_alpha": {
          "type": "boolean",
          "title": "Has Alpha",
          "description": "Whether the image has an alpha channel (transparency)"
        },
        "media_type": {
          "type": "string",
          "title": "Media Type",
          "description": "MIME type of the image (image/gif, image/jpeg, or image/png)"
        }
      }
    }
  },
  "title": "TypeformGetChoiceImageBySizeResponseWrapper",
  "required": [
    "data",
    "successful"
  ],
  "properties": {
    "data": {
      "type": "object",
      "title": "Data",
      "properties": {
        "id": {
          "type": "string",
          "title": "Id",
          "description": "Unique identifier for the image"
        },
        "src": {
          "type": "string",
          "title": "Src",
          "description": "URL of the choice image at the requested size"
        },
        "width": {
          "type": "integer",
          "title": "Width",
          "description": "Width of the image in pixels"
        },
        "height": {
          "type": "integer",
          "title": "Height",
          "description": "Height of the image in pixels"
        },
        "avg_color": {
          "type": "string",
          "title": "Avg Color",
          "description": "Average color of the image in hexadecimal format"
        },
        "file_name": {
          "type": "string",
          "title": "File Name",
          "description": "Name of the image file"
        },
        "has_alpha": {
          "type": "boolean",
          "title": "Has Alpha",
          "description": "Whether the image has an alpha channel (transparency)"
        },
        "media_type": {
          "type": "string",
          "title": "Media Type",
          "description": "MIME type of the image (image/gif, image/jpeg, or image/png)"
        }
      },
      "description": "Data from the action execution"
    },
    "error": {
      "type": "string",
      "title": "Error",
      "description": "Error if any occurred during the execution of the action"
    },
    "successful": {
      "type": "boolean",
      "title": "Successful",
      "description": "Whether or not the action execution was successful or not"
    }
  }
}
```

## TYPEFORM_GET_FORM
Tool to retrieve a specific form's complete configuration including fields, logic, settings, and theme. Use when you need to get detailed information about a Typeform form.

**Input schema:**
```json
{
  "type": "object",
  "title": "TypeformGetFormRequest",
  "required": [
    "form_id"
  ],
  "properties": {
    "form_id": {
      "type": "string",
      "title": "Form Id",
      "examples": [
        "CoZt0LNp"
      ],
      "description": "Unique form identifier found in the form URL"
    }
  }
}
```

**Output schema:**
```json
{
  "type": "object",
  "$defs": {
    "TypeformGetFormResponse": {
      "type": "object",
      "title": "TypeformGetFormResponse",
      "properties": {
        "id": {
          "type": "string",
          "title": "Id",
          "description": "Unique identifier of the form"
        },
        "meta": {
          "type": "object",
          "title": "Meta",
          "description": "Metadata information",
          "additionalProperties": true
        },
        "links": {
          "type": "object",
          "title": "Links",
          "description": "Related links",
          "additionalProperties": true
        },
        "logic": {
          "type": "array",
          "items": {
            "type": "object",
            "additionalProperties": true
          },
          "title": "Logic",
          "description": "Logic jumps configuration"
        },
        "theme": {
          "type": "object",
          "title": "Theme",
          "description": "Theme configuration",
          "additionalProperties": true
        },
        "title": {
          "type": "string",
          "title": "Title",
          "description": "Title of the form"
        },
        "fields": {
          "type": "array",
          "items": {
            "type": "object",
            "additionalProperties": true
          },
          "title": "Fields",
          "description": "List of form fields with their configurations"
        },
        "hidden": {
          "type": "array",
          "items": {
            "type": "string"
          },
          "title": "Hidden",
          "description": "List of hidden fields"
        },
        "captcha": {
          "type": "boolean",
          "title": "Captcha",
          "description": "Whether CAPTCHA is enabled"
        },
        "language": {
          "type": "string",
          "title": "Language",
          "description": "Language code of the form"
        },
        "settings": {
          "type": "object",
          "title": "Settings",
          "description": "Form settings",
          "additionalProperties": true
        },
        "variables": {
          "type": "object",
          "title": "Variables",
          "description": "Form variables",
          "additionalProperties": true
        },
        "workspace": {
          "type": "object",
          "title": "Workspace",
          "description": "Workspace information",
          "additionalProperties": true
        },
        "cui_settings": {
          "type": "object",
          "title": "Cui Settings",
          "description": "Conversational UI settings",
          "additionalProperties": true
        },
        "welcome_screens": {
          "type": "array",
          "items": {
            "type": "object",
            "additionalProperties": true
          },
          "title": "Welcome Screens",
          "description": "Welcome screens configuration"
        },
        "thankyou_screens": {
          "type": "array",
          "items": {
            "type": "object",
            "additionalProperties": true
          },
          "title": "Thankyou Screens",
          "description": "Thank you screens configuration"
        },
        "duplicate_prevention": {
          "type": "object",
          "title": "Duplicate Prevention",
          "description": "Duplicate prevention settings",
          "additionalProperties": true
        }
      }
    }
  },
  "title": "TypeformGetFormResponseWrapper",
  "required": [
    "data",
    "successful"
  ],
  "properties": {
    "data": {
      "type": "object",
      "title": "Data",
      "properties": {
        "id": {
          "type": "string",
          "title": "Id",
          "description": "Unique identifier of the form"
        },
        "meta": {
          "type": "object",
          "title": "Meta",
          "description": "Metadata information",
          "additionalProperties": true
        },
        "links": {
          "type": "object",
          "title": "Links",
          "description": "Related links",
          "additionalProperties": true
        },
        "logic": {
          "type": "array",
          "items": {
            "type": "object",
            "additionalProperties": true
          },
          "title": "Logic",
          "description": "Logic jumps configuration"
        },
        "theme": {
          "type": "object",
          "title": "Theme",
          "description": "Theme configuration",
          "additionalProperties": true
        },
        "title": {
          "type": "string",
          "title": "Title",
          "description": "Title of the form"
        },
        "fields": {
          "type": "array",
          "items": {
            "type": "object",
            "additionalProperties": true
          },
          "title": "Fields",
          "description": "List of form fields with their configurations"
        },
        "hidden": {
          "type": "array",
          "items": {
            "type": "string"
          },
          "title": "Hidden",
          "description": "List of hidden fields"
        },
        "captcha": {
          "type": "boolean",
          "title": "Captcha",
          "description": "Whether CAPTCHA is enabled"
        },
        "language": {
          "type": "string",
          "title": "Language",
          "description": "Language code of the form"
        },
        "settings": {
          "type": "object",
          "title": "Settings",
          "description": "Form settings",
          "additionalProperties": true
        },
        "variables": {
          "type": "object",
          "title": "Variables",
          "description": "Form variables",
          "additionalProperties": true
        },
        "workspace": {
          "type": "object",
          "title": "Workspace",
          "description": "Workspace information",
          "additionalProperties": true
        },
        "cui_settings": {
          "type": "object",
          "title": "Cui Settings",
          "description": "Conversational UI settings",
          "additionalProperties": true
        },
        "welcome_screens": {
          "type": "array",
          "items": {
            "type": "object",
            "additionalProperties": true
          },
          "title": "Welcome Screens",
          "description": "Welcome screens configuration"
        },
        "thankyou_screens": {
          "type": "array",
          "items": {
            "type": "object",
            "additionalProperties": true
          },
          "title": "Thankyou Screens",
          "description": "Thank you screens configuration"
        },
        "duplicate_prevention": {
          "type": "object",
          "title": "Duplicate Prevention",
          "description": "Duplicate prevention settings",
          "additionalProperties": true
        }
      },
      "description": "Data from the action execution"
    },
    "error": {
      "type": "string",
      "title": "Error",
      "description": "Error if any occurred during the execution of the action"
    },
    "successful": {
      "type": "boolean",
      "title": "Successful",
      "description": "Whether or not the action execution was successful or not"
    }
  }
}
```

## TYPEFORM_GET_FORM_MESSAGES
Tool to retrieve custom messages for a Typeform including button labels, error messages, and UI text. Use when you need to get the current message configuration for a form.

**Input schema:**
```json
{
  "type": "object",
  "title": "GetFormMessagesRequest",
  "required": [
    "form_id"
  ],
  "properties": {
    "form_id": {
      "type": "string",
      "title": "Form Id",
      "examples": [
        "CoZt0LNp",
        "Y78g1cmS"
      ],
      "description": "Unique form identifier found in the form URL"
    }
  }
}
```

**Output schema:**
```json
{
  "type": "object",
  "$defs": {
    "Block": {
      "type": "object",
      "title": "Block",
      "properties": {
        "shortText": {
          "type": "object",
          "title": "Short Text",
          "properties": {
            "placeholder": {
              "type": "string",
              "title": "Placeholder",
              "description": "Placeholder text for short text input fields"
            }
          },
          "description": "Short text field configuration"
        }
      }
    },
    "Label": {
      "type": "object",
      "title": "Label",
      "properties": {
        "no": {
          "type": "object",
          "title": "No",
          "properties": {
            "key": {
              "type": "string",
              "title": "Key",
              "description": "Keyboard shortcut key"
            },
            "value": {
              "type": "string",
              "title": "Value",
              "description": "Display text value"
            }
          },
          "description": "No option configuration"
        },
        "yes": {
          "type": "object",
          "title": "Yes",
          "properties": {
            "key": {
              "type": "string",
              "title": "Key",
              "description": "Keyboard shortcut key"
            },
            "value": {
              "type": "string",
              "title": "Value",
              "description": "Display text value"
            }
          },
          "description": "Yes option configuration"
        },
        "error": {
          "type": "object",
          "title": "Error",
          "properties": {
            "required": {
              "type": "string",
              "title": "Required",
              "description": "Required field error message"
            },
            "mustAccept": {
              "type": "string",
              "title": "Must Accept",
              "description": "Private form error message"
            },
            "uploadSize": {
              "type": "string",
              "title": "Upload Size",
              "description": "File too big error message"
            },
            "urlNotValid": {
              "type": "string",
              "title": "Url Not Valid",
              "description": "Invalid URL error message"
            },
            "minSelection": {
              "type": "string",
              "title": "Min Selection",
              "description": "Incomplete fields error message"
            },
            "requiredSelection": {
              "type": "string",
              "title": "Required Selection",
              "description": "Required selection error message"
            }
          },
          "description": "Error messages"
        },
        "other": {
          "type": "string",
          "title": "Other",
          "description": "Other answer option text"
        },
        "button": {
          "type": "object",
          "title": "Button",
          "properties": {
            "submit": {
              "type": "string",
              "title": "Submit",
              "description": "Submit button text"
            },
            "upload": {
              "type": "string",
              "title": "Upload",
              "description": "File upload button text"
            },
            "default": {
              "type": "string",
              "title": "Default",
              "description": "Default button text"
            },
            "uploadCoverDrop": {
              "type": "string",
              "title": "Upload Cover Drop",
              "description": "File upload dragging action message"
            },
            "uploadCoverUpload": {
              "type": "string",
              "title": "Upload Cover Upload",
              "description": "File upload processing message"
            }
          },
          "description": "Button text messages"
        },
        "dropdown": {
          "type": "object",
          "title": "Dropdown",
          "properties": {
            "noSuggestions": {
              "type": "string",
              "title": "No Suggestions",
              "description": "No suggestions found for dropdown fields message"
            }
          },
          "description": "Dropdown field messages"
        },
        "progress": {
          "type": "object",
          "title": "Progress",
          "properties": {
            "percent": {
              "type": "string",
              "title": "Percent",
              "description": "Completion percentage message"
            },
            "proportion": {
              "type": "string",
              "title": "Proportion",
              "description": "Completion proportion message"
            }
          },
          "description": "Progress indicator messages"
        },
        "buttonHint": {
          "type": "object",
          "title": "Button Hint",
          "properties": {
            "default": {
              "type": "string",
              "title": "Default",
              "description": "Default tooltip button hint"
            },
            "longtext": {
              "type": "string",
              "title": "Longtext",
              "description": "Tooltip button hint for long text blocks"
            }
          },
          "description": "Button hint/tooltip messages"
        },
        "buttonNoAnswer": {
          "type": "object",
          "title": "Button No Answer",
          "properties": {
            "default": {
              "type": "string",
              "title": "Default",
              "description": "Text for continue without answering button"
            }
          },
          "description": "No answer button messages"
        }
      }
    },
    "LabelError": {
      "type": "object",
      "title": "LabelError",
      "properties": {
        "required": {
          "type": "string",
          "title": "Required",
          "description": "Required field error message"
        },
        "mustAccept": {
          "type": "string",
          "title": "Must Accept",
          "description": "Private form error message"
        },
        "uploadSize": {
          "type": "string",
          "title": "Upload Size",
          "description": "File too big error message"
        },
        "urlNotValid": {
          "type": "string",
          "title": "Url Not Valid",
          "description": "Invalid URL error message"
        },
        "minSelection": {
          "type": "string",
          "title": "Min Selection",
          "description": "Incomplete fields error message"
        },
        "requiredSelection": {
          "type": "string",
          "title": "Required Selection",
          "description": "Required selection error message"
        }
      }
    },
    "LabelYesNo": {
      "type": "object",
      "title": "LabelYesNo",
      "properties": {
        "key": {
          "type": "string",
          "title": "Key",
          "description": "Keyboard shortcut key"
        },
        "value": {
          "type": "string",
          "title": "Value",
          "description": "Display text value"
        }
      }
    },
    "LabelButton": {
      "type": "object",
      "title": "LabelButton",
      "properties": {
        "submit": {
          "type": "string",
          "title": "Submit",
          "description": "Submit button text"
        },
        "upload": {
          "type": "string",
          "title": "Upload",
          "description": "File upload button text"
        },
        "default": {
          "type": "string",
          "title": "Default",
          "description": "Default button text"
        },
        "uploadCoverDrop": {
          "type": "string",
          "title": "Upload Cover Drop",
          "description": "File upload dragging action message"
        },
        "uploadCoverUpload": {
          "type": "string",
          "title": "Upload Cover Upload",
          "description": "File upload processing message"
        }
      }
    },
    "LabelDropdown": {
      "type": "object",
      "title": "LabelDropdown",
      "properties": {
        "noSuggestions": {
          "type": "string",
          "title": "No Suggestions",
          "description": "No suggestions found for dropdown fields message"
        }
      }
    },
    "LabelProgress": {
      "type": "object",
      "title": "LabelProgress",
      "properties": {
        "percent": {
          "type": "string",
          "title": "Percent",
          "description": "Completion percentage message"
        },
        "proportion": {
          "type": "string",
          "title": "Proportion",
          "description": "Completion proportion message"
        }
      }
    },
    "BlockShortText": {
      "type": "object",
      "title": "BlockShortText",
      "properties": {
        "placeholder": {
          "type": "string",
          "title": "Placeholder",
          "description": "Placeholder text for short text input fields"
        }
      }
    },
    "LabelButtonHint": {
      "type": "object",
      "title": "LabelButtonHint",
      "properties": {
        "default": {
          "type": "string",
          "title": "Default",
          "description": "Default tooltip button hint"
        },
        "longtext": {
          "type": "string",
          "title": "Longtext",
          "description": "Tooltip button hint for long text blocks"
        }
      }
    },
    "LabelButtonNoAnswer": {
      "type": "object",
      "title": "LabelButtonNoAnswer",
      "properties": {
        "default": {
          "type": "string",
          "title": "Default",
          "description": "Text for continue without answering button"
        }
      }
    },
    "GetFormMessagesResponse": {
      "type": "object",
      "title": "GetFormMessagesResponse",
      "properties": {
        "block": {
          "type": "object",
          "title": "Block",
          "properties": {
            "shortText": {
              "type": "object",
              "title": "Short Text",
              "properties": {
                "placeholder": {
                  "type": "string",
                  "title": "Placeholder",
                  "description": "Placeholder text for short text input fields"
                }
              },
              "description": "Short text field configuration"
            }
          },
          "description": "Block-level configuration messages"
        },
        "label": {
          "type": "object",
          "title": "Label",
          "properties": {
            "no": {
              "type": "object",
              "title": "No",
              "properties": {
                "key": {
                  "type": "string",
                  "title": "Key",
                  "description": "Keyboard shortcut key"
                },
                "value": {
                  "type": "string",
                  "title": "Value",
                  "description": "Display text value"
                }
              },
              "description": "No option configuration"
            },
            "yes": {
              "type": "object",
              "title": "Yes",
              "properties": {
                "key": {
                  "type": "string",
                  "title": "Key",
                  "description": "Keyboard shortcut key"
                },
                "value": {
                  "type": "string",
                  "title": "Value",
                  "description": "Display text value"
                }
              },
              "description": "Yes option configuration"
            },
            "error": {
              "type": "object",
              "title": "Error",
              "properties": {
                "required": {
                  "type": "string",
                  "title": "Required",
                  "description": "Required field error message"
                },
                "mustAccept": {
                  "type": "string",
                  "title": "Must Accept",
                  "description": "Private form error message"
                },
                "uploadSize": {
                  "type": "string",
                  "title": "Upload Size",
                  "description": "File too big error message"
                },
                "urlNotValid": {
                  "type": "string",
                  "title": "Url Not Valid",
                  "description": "Invalid URL error message"
                },
                "minSelection": {
                  "type": "string",
                  "title": "Min Selection",
                  "description": "Incomplete fields error message"
                },
                "requiredSelection": {
                  "type": "string",
                  "title": "Required Selection",
                  "description": "Required selection error message"
                }
              },
              "description": "Error messages"
            },
            "other": {
              "type": "string",
              "title": "Other",
              "description": "Other answer option text"
            },
            "button": {
              "type": "object",
              "title": "Button",
              "properties": {
                "submit": {
                  "type": "string",
                  "title": "Submit",
                  "description": "Submit button text"
                },
                "upload": {
                  "type": "string",
                  "title": "Upload",
                  "description": "File upload button text"
                },
                "default": {
                  "type": "string",
                  "title": "Default",
                  "description": "Default button text"
                },
                "uploadCoverDrop": {
                  "type": "string",
                  "title": "Upload Cover Drop",
                  "description": "File upload dragging action message"
                },
                "uploadCoverUpload": {
                  "type": "string",
                  "title": "Upload Cover Upload",
                  "description": "File upload processing message"
                }
              },
              "description": "Button text messages"
            },
            "dropdown": {
              "type": "object",
              "title": "Dropdown",
              "properties": {
                "noSuggestions": {
                  "type": "string",
                  "title": "No Suggestions",
                  "description": "No suggestions found for dropdown fields message"
                }
              },
              "description": "Dropdown field messages"
            },
            "progress": {
              "type": "object",
              "title": "Progress",
              "properties": {
                "percent": {
                  "type": "string",
                  "title": "Percent",
                  "description": "Completion percentage message"
                },
                "proportion": {
                  "type": "string",
                  "title": "Proportion",
                  "description": "Completion proportion message"
                }
              },
              "description": "Progress indicator messages"
            },
            "buttonHint": {
              "type": "object",
              "title": "Button Hint",
              "properties": {
                "default": {
                  "type": "string",
                  "title": "Default",
                  "description": "Default tooltip button hint"
                },
                "longtext": {
                  "type": "string",
                  "title": "Longtext",
                  "description": "Tooltip button hint for long text blocks"
                }
              },
              "description": "Button hint/tooltip messages"
            },
            "buttonNoAnswer": {
              "type": "object",
              "title": "Button No Answer",
              "properties": {
                "default": {
                  "type": "string",
                  "title": "Default",
                  "description": "Text for continue without answering button"
                }
              },
              "description": "No answer button messages"
            }
          },
          "description": "Label messages for form UI elements"
        }
      }
    }
  },
  "title": "GetFormMessagesResponseWrapper",
  "required": [
    "data",
    "successful"
  ],
  "properties": {
    "data": {
      "type": "object",
      "title": "Data",
      "properties": {
        "block": {
          "type": "object",
          "title": "Block",
          "properties": {
            "shortText": {
              "type": "object",
              "title": "Short Text",
              "properties": {
                "placeholder": {
                  "type": "string",
                  "title": "Placeholder",
                  "description": "Placeholder text for short text input fields"
                }
              },
              "description": "Short text field configuration"
            }
          },
          "description": "Block-level configuration messages"
        },
        "label": {
          "type": "object",
          "title": "Label",
          "properties": {
            "no": {
              "type": "object",
              "title": "No",
              "properties": {
                "key": {
                  "type": "string",
                  "title": "Key",
                  "description": "Keyboard shortcut key"
                },
                "value": {
                  "type": "string",
                  "title": "Value",
                  "description": "Display text value"
                }
              },
              "description": "No option configuration"
            },
            "yes": {
              "type": "object",
              "title": "Yes",
              "properties": {
                "key": {
                  "type": "string",
                  "title": "Key",
                  "description": "Keyboard shortcut key"
                },
                "value": {
                  "type": "string",
                  "title": "Value",
                  "description": "Display text value"
                }
              },
              "description": "Yes option configuration"
            },
            "error": {
              "type": "object",
              "title": "Error",
              "properties": {
                "required": {
                  "type": "string",
                  "title": "Required",
                  "description": "Required field error message"
                },
                "mustAccept": {
                  "type": "string",
                  "title": "Must Accept",
                  "description": "Private form error message"
                },
                "uploadSize": {
                  "type": "string",
                  "title": "Upload Size",
                  "description": "File too big error message"
                },
                "urlNotValid": {
                  "type": "string",
                  "title": "Url Not Valid",
                  "description": "Invalid URL error message"
                },
                "minSelection": {
                  "type": "string",
                  "title": "Min Selection",
                  "description": "Incomplete fields error message"
                },
                "requiredSelection": {
                  "type": "string",
                  "title": "Required Selection",
                  "description": "Required selection error message"
                }
              },
              "description": "Error messages"
            },
            "other": {
              "type": "string",
              "title": "Other",
              "description": "Other answer option text"
            },
            "button": {
              "type": "object",
              "title": "Button",
              "properties": {
                "submit": {
                  "type": "string",
                  "title": "Submit",
                  "description": "Submit button text"
                },
                "upload": {
                  "type": "string",
                  "title": "Upload",
                  "description": "File upload button text"
                },
                "default": {
                  "type": "string",
                  "title": "Default",
                  "description": "Default button text"
                },
                "uploadCoverDrop": {
                  "type": "string",
                  "title": "Upload Cover Drop",
                  "description": "File upload dragging action message"
                },
                "uploadCoverUpload": {
                  "type": "string",
                  "title": "Upload Cover Upload",
                  "description": "File upload processing message"
                }
              },
              "description": "Button text messages"
            },
            "dropdown": {
              "type": "object",
              "title": "Dropdown",
              "properties": {
                "noSuggestions": {
                  "type": "string",
                  "title": "No Suggestions",
                  "description": "No suggestions found for dropdown fields message"
                }
              },
              "description": "Dropdown field messages"
            },
            "progress": {
              "type": "object",
              "title": "Progress",
              "properties": {
                "percent": {
                  "type": "string",
                  "title": "Percent",
                  "description": "Completion percentage message"
                },
                "proportion": {
                  "type": "string",
                  "title": "Proportion",
                  "description": "Completion proportion message"
                }
              },
              "description": "Progress indicator messages"
            },
            "buttonHint": {
              "type": "object",
              "title": "Button Hint",
              "properties": {
                "default": {
                  "type": "string",
                  "title": "Default",
                  "description": "Default tooltip button hint"
                },
                "longtext": {
                  "type": "string",
                  "title": "Longtext",
                  "description": "Tooltip button hint for long text blocks"
                }
              },
              "description": "Button hint/tooltip messages"
            },
            "buttonNoAnswer": {
              "type": "object",
              "title": "Button No Answer",
              "properties": {
                "default": {
                  "type": "string",
                  "title": "Default",
                  "description": "Text for continue without answering button"
                }
              },
              "description": "No answer button messages"
            }
          },
          "description": "Label messages for form UI elements"
        }
      },
      "description": "Data from the action execution"
    },
    "error": {
      "type": "string",
      "title": "Error",
      "description": "Error if any occurred during the execution of the action"
    },
    "successful": {
      "type": "boolean",
      "title": "Successful",
      "description": "Whether or not the action execution was successful or not"
    }
  }
}
```

## TYPEFORM_GET_FORM_RESPONSES
Tool to retrieve form responses from Typeform with filtering by date, pagination, search, and response type. Use when you need to get responses for a specific form including timestamps of when users landed on and submitted the form. Note: Recent responses may take up to 30 minutes to appear.

**Input schema:**
```json
{
  "type": "object",
  "title": "GetFormResponsesRequest",
  "required": [
    "form_id"
  ],
  "properties": {
    "sort": {
      "type": "string",
      "title": "Sort",
      "description": "Sort format: {fieldID},{asc|desc}. Example: 'field_123,asc'"
    },
    "after": {
      "type": "string",
      "title": "After",
      "description": "Pagination token for responses after this point"
    },
    "query": {
      "type": "string",
      "title": "Query",
      "description": "Search string matched against all response fields"
    },
    "since": {
      "type": "string",
      "title": "Since",
      "description": "Filter responses from timestamp (ISO 8601 format like '2023-01-01T00:00:00Z' or Unix seconds)"
    },
    "until": {
      "type": "string",
      "title": "Until",
      "description": "Filter responses until timestamp (ISO 8601 format like '2023-12-31T23:59:59Z' or Unix seconds)"
    },
    "before": {
      "type": "string",
      "title": "Before",
      "description": "Pagination token for responses before this point"
    },
    "fields": {
      "type": "array",
      "items": {
        "type": "string"
      },
      "title": "Fields",
      "description": "Limit displayed fields in answers section. Provide field IDs."
    },
    "form_id": {
      "type": "string",
      "title": "Form Id",
      "examples": [
        "Y78g1cmS"
      ],
      "description": "Unique form identifier"
    },
    "page_size": {
      "type": "integer",
      "title": "Page Size",
      "maximum": 1000,
      "minimum": 1,
      "description": "Maximum responses per request (default: 25, max: 1000)"
    },
    "response_type": {
      "type": "array",
      "items": {
        "type": "string"
      },
      "title": "Response Type",
      "description": "Filter by type: 'started', 'partial', or 'completed'. Can specify multiple values."
    },
    "answered_fields": {
      "type": "array",
      "items": {
        "type": "string"
      },
      "title": "Answered Fields",
      "description": "Filter responses containing specified field IDs"
    },
    "excluded_response_ids": {
      "type": "string",
      "title": "Excluded Response Ids",
      "description": "Comma-separated response IDs to exclude"
    },
    "included_response_ids": {
      "type": "string",
      "title": "Included Response Ids",
      "description": "Comma-separated response IDs to include"
    }
  }
}
```

**Output schema:**
```json
{
  "type": "object",
  "$defs": {
    "Answer": {
      "type": "object",
      "title": "Answer",
      "required": [
        "field",
        "type"
      ],
      "properties": {
        "url": {
          "type": "string",
          "title": "Url",
          "description": "URL answer"
        },
        "date": {
          "type": "string",
          "title": "Date",
          "description": "Date answer"
        },
        "text": {
          "type": "string",
          "title": "Text",
          "description": "Text answer"
        },
        "type": {
          "type": "string",
          "title": "Type",
          "description": "Answer type (text, email, number, boolean, date, choice, choices, file_url, url, payment, phone_number, multi_format)"
        },
        "email": {
          "type": "string",
          "title": "Email",
          "description": "Email answer"
        },
        "field": {
          "type": "object",
          "title": "Field",
          "required": [
            "id",
            "type"
          ],
          "properties": {
            "id": {
              "type": "string",
              "title": "Id",
              "description": "Field ID"
            },
            "ref": {
              "type": "string",
              "title": "Ref",
              "description": "Field reference"
            },
            "type": {
              "type": "string",
              "title": "Type",
              "description": "Field type"
            }
          },
          "description": "Field information"
        },
        "choice": {
          "type": "object",
          "title": "Choice",
          "properties": {
            "id": {
              "type": "string",
              "title": "Id",
              "description": "Choice ID"
            },
            "ref": {
              "type": "string",
              "title": "Ref",
              "description": "Choice reference"
            },
            "label": {
              "type": "string",
              "title": "Label",
              "description": "Choice label"
            },
            "other": {
              "type": "string",
              "title": "Other",
              "description": "Custom text for 'Other' option"
            }
          },
          "description": "Single choice answer"
        },
        "number": {
          "type": "number",
          "title": "Number",
          "description": "Numeric answer"
        },
        "boolean": {
          "type": "boolean",
          "title": "Boolean",
          "description": "Boolean answer"
        },
        "choices": {
          "type": "object",
          "title": "Choices",
          "properties": {
            "ids": {
              "type": "array",
              "items": {
                "type": "string"
              },
              "title": "Ids",
              "description": "Selected choice IDs"
            },
            "refs": {
              "type": "array",
              "items": {
                "type": "string"
              },
              "title": "Refs",
              "description": "Selected choice references"
            },
            "other": {
              "type": "string",
              "title": "Other",
              "description": "Custom text for 'Other' option"
            },
            "labels": {
              "type": "array",
              "items": {
                "type": "string"
              },
              "title": "Labels",
              "description": "Selected choice labels"
            }
          },
          "description": "Multiple choice answer"
        },
        "payment": {
          "type": "object",
          "title": "Payment",
          "description": "Payment details",
          "additionalProperties": true
        },
        "file_url": {
          "type": "string",
          "title": "File Url",
          "description": "File URL answer"
        },
        "multi_format": {
          "type": "object",
          "title": "Multi Format",
          "description": "Multi-format answer (audio/video)",
          "additionalProperties": true
        },
        "phone_number": {
          "type": "string",
          "title": "Phone Number",
          "description": "Phone number answer"
        }
      },
      "description": "Answer to a form field"
    },
    "Variable": {
      "type": "object",
      "title": "Variable",
      "required": [
        "key",
        "type"
      ],
      "properties": {
        "key": {
          "type": "string",
          "title": "Key",
          "description": "Variable key"
        },
        "text": {
          "type": "string",
          "title": "Text",
          "description": "Text value"
        },
        "type": {
          "type": "string",
          "title": "Type",
          "description": "Variable type (text or number)"
        },
        "number": {
          "type": "number",
          "title": "Number",
          "description": "Numeric value"
        }
      },
      "description": "Form variable"
    },
    "AnswerField": {
      "type": "object",
      "title": "AnswerField",
      "required": [
        "id",
        "type"
      ],
      "properties": {
        "id": {
          "type": "string",
          "title": "Id",
          "description": "Field ID"
        },
        "ref": {
          "type": "string",
          "title": "Ref",
          "description": "Field reference"
        },
        "type": {
          "type": "string",
          "title": "Type",
          "description": "Field type"
        }
      },
      "description": "Field information in an answer"
    },
    "ChoiceAnswer": {
      "type": "object",
      "title": "ChoiceAnswer",
      "properties": {
        "id": {
          "type": "string",
          "title": "Id",
          "description": "Choice ID"
        },
        "ref": {
          "type": "string",
          "title": "Ref",
          "description": "Choice reference"
        },
        "label": {
          "type": "string",
          "title": "Label",
          "description": "Choice label"
        },
        "other": {
          "type": "string",
          "title": "Other",
          "description": "Custom text for 'Other' option"
        }
      },
      "description": "Single choice answer"
    },
    "ResponseItem": {
      "type": "object",
      "title": "ResponseItem",
      "properties": {
        "token": {
          "type": "string",
          "title": "Token",
          "description": "Response token"
        },
        "hidden": {
          "type": "object",
          "title": "Hidden",
          "description": "Hidden fields with dynamic keys and values",
          "additionalProperties": true
        },
        "answers": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "Answer",
            "required": [
              "field",
              "type"
            ],
            "properties": {
              "url": {
                "type": "string",
                "title": "Url",
                "description": "URL answer"
              },
              "date": {
                "type": "string",
                "title": "Date",
                "description": "Date answer"
              },
              "text": {
                "type": "string",
                "title": "Text",
                "description": "Text answer"
              },
              "type": {
                "type": "string",
                "title": "Type",
                "description": "Answer type (text, email, number, boolean, date, choice, choices, file_url, url, payment, phone_number, multi_format)"
              },
              "email": {
                "type": "string",
                "title": "Email",
                "description": "Email answer"
              },
              "field": {
                "type": "object",
                "title": "Field",
                "required": [
                  "id",
                  "type"
                ],
                "properties": {
                  "id": {
                    "type": "string",
                    "title": "Id",
                    "description": "Field ID"
                  },
                  "ref": {
                    "type": "string",
                    "title": "Ref",
                    "description": "Field reference"
                  },
                  "type": {
                    "type": "string",
                    "title": "Type",
                    "description": "Field type"
                  }
                },
                "description": "Field information"
              },
              "choice": {
                "type": "object",
                "title": "Choice",
                "properties": {
                  "id": {
                    "type": "string",
                    "title": "Id",
                    "description": "Choice ID"
                  },
                  "ref": {
                    "type": "string",
                    "title": "Ref",
                    "description": "Choice reference"
                  },
                  "label": {
                    "type": "string",
                    "title": "Label",
                    "description": "Choice label"
                  },
                  "other": {
                    "type": "string",
                    "title": "Other",
                    "description": "Custom text for 'Other' option"
                  }
                },
                "description": "Single choice answer"
              },
              "number": {
                "type": "number",
                "title": "Number",
                "description": "Numeric answer"
              },
              "boolean": {
                "type": "boolean",
                "title": "Boolean",
                "description": "Boolean answer"
              },
              "choices": {
                "type": "object",
                "title": "Choices",
                "properties": {
                  "ids": {
                    "type": "array",
                    "items": {
                      "type": "string"
                    },
                    "title": "Ids",
                    "description": "Selected choice IDs"
                  },
                  "refs": {
                    "type": "array",
                    "items": {
                      "type": "string"
                    },
                    "title": "Refs",
                    "description": "Selected choice references"
                  },
                  "other": {
                    "type": "string",
                    "title": "Other",
                    "description": "Custom text for 'Other' option"
                  },
                  "labels": {
                    "type": "array",
                    "items": {
                      "type": "string"
                    },
                    "title": "Labels",
                    "description": "Selected choice labels"
                  }
                },
                "description": "Multiple choice answer"
              },
              "payment": {
                "type": "object",
                "title": "Payment",
                "description": "Payment details",
                "additionalProperties": true
              },
              "file_url": {
                "type": "string",
                "title": "File Url",
                "description": "File URL answer"
              },
              "multi_format": {
                "type": "object",
                "title": "Multi Format",
                "description": "Multi-format answer (audio/video)",
                "additionalProperties": true
              },
              "phone_number": {
                "type": "string",
                "title": "Phone Number",
                "description": "Phone number answer"
              }
            },
            "description": "Answer to a form field"
          },
          "title": "Answers",
          "description": "Array of answers provided in the response"
        },
        "metadata": {
          "type": "object",
          "title": "Metadata",
          "properties": {
            "browser": {
              "type": "string",
              "title": "Browser",
              "description": "Browser used"
            },
            "referer": {
              "type": "string",
              "title": "Referer",
              "description": "Referer URL"
            },
            "platform": {
              "type": "string",
              "title": "Platform",
              "description": "Platform/OS used"
            },
            "network_id": {
              "type": "string",
              "title": "Network Id",
              "description": "Network identifier"
            },
            "user_agent": {
              "type": "string",
              "title": "User Agent",
              "description": "User agent string"
            }
          },
          "description": "Response metadata"
        },
        "landed_at": {
          "type": "string",
          "title": "Landed At",
          "description": "ISO 8601 timestamp when user landed on the form"
        },
        "variables": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "Variable",
            "required": [
              "key",
              "type"
            ],
            "properties": {
              "key": {
                "type": "string",
                "title": "Key",
                "description": "Variable key"
              },
              "text": {
                "type": "string",
                "title": "Text",
                "description": "Text value"
              },
              "type": {
                "type": "string",
                "title": "Type",
                "description": "Variable type (text or number)"
              },
              "number": {
                "type": "number",
                "title": "Number",
                "description": "Numeric value"
              }
            },
            "description": "Form variable"
          },
          "title": "Variables",
          "description": "Form variables"
        },
        "calculated": {
          "type": "object",
          "title": "Calculated",
          "properties": {
            "score": {
              "type": "number",
              "title": "Score",
              "description": "Calculated score"
            }
          },
          "description": "Calculated values like score"
        },
        "response_id": {
          "type": "string",
          "title": "Response Id",
          "description": "Unique response identifier"
        },
        "submitted_at": {
          "type": "string",
          "title": "Submitted At",
          "description": "ISO 8601 timestamp when user submitted the form"
        }
      }
    },
    "ChoicesAnswer": {
      "type": "object",
      "title": "ChoicesAnswer",
      "properties": {
        "ids": {
          "type": "array",
          "items": {
            "type": "string"
          },
          "title": "Ids",
          "description": "Selected choice IDs"
        },
        "refs": {
          "type": "array",
          "items": {
            "type": "string"
          },
          "title": "Refs",
          "description": "Selected choice references"
        },
        "other": {
          "type": "string",
          "title": "Other",
          "description": "Custom text for 'Other' option"
        },
        "labels": {
          "type": "array",
          "items": {
            "type": "string"
          },
          "title": "Labels",
          "description": "Selected choice labels"
        }
      },
      "description": "Multiple choice answer"
    },
    "ResponseMetadata": {
      "type": "object",
      "title": "ResponseMetadata",
      "properties": {
        "browser": {
          "type": "string",
          "title": "Browser",
          "description": "Browser used"
        },
        "referer": {
          "type": "string",
          "title": "Referer",
          "description": "Referer URL"
        },
        "platform": {
          "type": "string",
          "title": "Platform",
          "description": "Platform/OS used"
        },
        "network_id": {
          "type": "string",
          "title": "Network Id",
          "description": "Network identifier"
        },
        "user_agent": {
          "type": "string",
          "title": "User Agent",
          "description": "User agent string"
        }
      },
      "description": "Metadata about how the response was submitted"
    },
    "CalculatedResponse": {
      "type": "object",
      "title": "CalculatedResponse",
      "properties": {
        "score": {
          "type": "number",
          "title": "Score",
          "description": "Calculated score"
        }
      }
    },
    "GetFormResponsesResponse": {
      "type": "object",
      "title": "GetFormResponsesResponse",
      "properties": {
        "items": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "ResponseItem",
            "properties": {
              "token": {
                "type": "string",
                "title": "Token",
                "description": "Response token"
              },
              "hidden": {
                "type": "object",
                "title": "Hidden",
                "description": "Hidden fields with dynamic keys and values",
                "additionalProperties": true
              },
              "answers": {
                "type": "array",
                "items": {
                  "type": "object",
                  "title": "Answer",
                  "required": [
                    "field",
                    "type"
                  ],
                  "properties": {
                    "url": {
                      "type": "string",
                      "title": "Url",
                      "description": "URL answer"
                    },
                    "date": {
                      "type": "string",
                      "title": "Date",
                      "description": "Date answer"
                    },
                    "text": {
                      "type": "string",
                      "title": "Text",
                      "description": "Text answer"
                    },
                    "type": {
                      "type": "string",
                      "title": "Type",
                      "description": "Answer type (text, email, number, boolean, date, choice, choices, file_url, url, payment, phone_number, multi_format)"
                    },
                    "email": {
                      "type": "string",
                      "title": "Email",
                      "description": "Email answer"
                    },
                    "field": {
                      "type": "object",
                      "title": "Field",
                      "required": [
                        "id",
                        "type"
                      ],
                      "properties": {
                        "id": {
                          "type": "string",
                          "title": "Id",
                          "description": "Field ID"
                        },
                        "ref": {
                          "type": "string",
                          "title": "Ref",
                          "description": "Field reference"
                        },
                        "type": {
                          "type": "string",
                          "title": "Type",
                          "description": "Field type"
                        }
                      },
                      "description": "Field information"
                    },
                    "choice": {
                      "type": "object",
                      "title": "Choice",
                      "properties": {
                        "id": {
                          "type": "string",
                          "title": "Id",
                          "description": "Choice ID"
                        },
                        "ref": {
                          "type": "string",
                          "title": "Ref",
                          "description": "Choice reference"
                        },
                        "label": {
                          "type": "string",
                          "title": "Label",
                          "description": "Choice label"
                        },
                        "other": {
                          "type": "string",
                          "title": "Other",
                          "description": "Custom text for 'Other' option"
                        }
                      },
                      "description": "Single choice answer"
                    },
                    "number": {
                      "type": "number",
                      "title": "Number",
                      "description": "Numeric answer"
                    },
                    "boolean": {
                      "type": "boolean",
                      "title": "Boolean",
                      "description": "Boolean answer"
                    },
                    "choices": {
                      "type": "object",
                      "title": "Choices",
                      "properties": {
                        "ids": {
                          "type": "array",
                          "items": {
                            "type": "string"
                          },
                          "title": "Ids",
                          "description": "Selected choice IDs"
                        },
                        "refs": {
                          "type": "array",
                          "items": {
                            "type": "string"
                          },
                          "title": "Refs",
                          "description": "Selected choice references"
                        },
                        "other": {
                          "type": "string",
                          "title": "Other",
                          "description": "Custom text for 'Other' option"
                        },
                        "labels": {
                          "type": "array",
                          "items": {
                            "type": "string"
                          },
                          "title": "Labels",
                          "description": "Selected choice labels"
                        }
                      },
                      "description": "Multiple choice answer"
                    },
                    "payment": {
                      "type": "object",
                      "title": "Payment",
                      "description": "Payment details",
                      "additionalProperties": true
                    },
                    "file_url": {
                      "type": "string",
                      "title": "File Url",
                      "description": "File URL answer"
                    },
                    "multi_format": {
                      "type": "object",
                      "title": "Multi Format",
                      "description": "Multi-format answer (audio/video)",
                      "additionalProperties": true
                    },
                    "phone_number": {
                      "type": "string",
                      "title": "Phone Number",
                      "description": "Phone number answer"
                    }
                  },
                  "description": "Answer to a form field"
                },
                "title": "Answers",
                "description": "Array of answers provided in the response"
              },
              "metadata": {
                "type": "object",
                "title": "Metadata",
                "properties": {
                  "browser": {
                    "type": "string",
                    "title": "Browser",
                    "description": "Browser used"
                  },
                  "referer": {
                    "type": "string",
                    "title": "Referer",
                    "description": "Referer URL"
                  },
                  "platform": {
                    "type": "string",
                    "title": "Platform",
                    "description": "Platform/OS used"
                  },
                  "network_id": {
                    "type": "string",
                    "title": "Network Id",
                    "description": "Network identifier"
                  },
                  "user_agent": {
                    "type": "string",
                    "title": "User Agent",
                    "description": "User agent string"
                  }
                },
                "description": "Response metadata"
              },
              "landed_at": {
                "type": "string",
                "title": "Landed At",
                "description": "ISO 8601 timestamp when user landed on the form"
              },
              "variables": {
                "type": "array",
                "items": {
                  "type": "object",
                  "title": "Variable",
                  "required": [
                    "key",
                    "type"
                  ],
                  "properties": {
                    "key": {
                      "type": "string",
                      "title": "Key",
                      "description": "Variable key"
                    },
                    "text": {
                      "type": "string",
                      "title": "Text",
                      "description": "Text value"
                    },
                    "type": {
                      "type": "string",
                      "title": "Type",
                      "description": "Variable type (text or number)"
                    },
                    "number": {
                      "type": "number",
                      "title": "Number",
                      "description": "Numeric value"
                    }
                  },
                  "description": "Form variable"
                },
                "title": "Variables",
                "description": "Form variables"
              },
              "calculated": {
                "type": "object",
                "title": "Calculated",
                "properties": {
                  "score": {
                    "type": "number",
                    "title": "Score",
                    "description": "Calculated score"
                  }
                },
                "description": "Calculated values like score"
              },
              "response_id": {
                "type": "string",
                "title": "Response Id",
                "description": "Unique response identifier"
              },
              "submitted_at": {
                "type": "string",
                "title": "Submitted At",
                "description": "ISO 8601 timestamp when user submitted the form"
              }
            }
          },
          "title": "Items",
          "description": "List of form responses"
        },
        "page_count": {
          "type": "integer",
          "title": "Page Count",
          "description": "Number of pages"
        },
        "total_items": {
          "type": "integer",
          "title": "Total Items",
          "description": "Total number of responses"
        }
      }
    }
  },
  "title": "GetFormResponsesResponseWrapper",
  "required": [
    "data",
    "successful"
  ],
  "properties": {
    "data": {
      "type": "object",
      "title": "Data",
      "properties": {
        "items": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "ResponseItem",
            "properties": {
              "token": {
                "type": "string",
                "title": "Token",
                "description": "Response token"
              },
              "hidden": {
                "type": "object",
                "title": "Hidden",
                "description": "Hidden fields with dynamic keys and values",
                "additionalProperties": true
              },
              "answers": {
                "type": "array",
                "items": {
                  "type": "object",
                  "title": "Answer",
                  "required": [
                    "field",
                    "type"
                  ],
                  "properties": {
                    "url": {
                      "type": "string",
                      "title": "Url",
                      "description": "URL answer"
                    },
                    "date": {
                      "type": "string",
                      "title": "Date",
                      "description": "Date answer"
                    },
                    "text": {
                      "type": "string",
                      "title": "Text",
                      "description": "Text answer"
                    },
                    "type": {
                      "type": "string",
                      "title": "Type",
                      "description": "Answer type (text, email, number, boolean, date, choice, choices, file_url, url, payment, phone_number, multi_format)"
                    },
                    "email": {
                      "type": "string",
                      "title": "Email",
                      "description": "Email answer"
                    },
                    "field": {
                      "type": "object",
                      "title": "Field",
                      "required": [
                        "id",
                        "type"
                      ],
                      "properties": {
                        "id": {
                          "type": "string",
                          "title": "Id",
                          "description": "Field ID"
                        },
                        "ref": {
                          "type": "string",
                          "title": "Ref",
                          "description": "Field reference"
                        },
                        "type": {
                          "type": "string",
                          "title": "Type",
                          "description": "Field type"
                        }
                      },
                      "description": "Field information"
                    },
                    "choice": {
                      "type": "object",
                      "title": "Choice",
                      "properties": {
                        "id": {
                          "type": "string",
                          "title": "Id",
                          "description": "Choice ID"
                        },
                        "ref": {
                          "type": "string",
                          "title": "Ref",
                          "description": "Choice reference"
                        },
                        "label": {
                          "type": "string",
                          "title": "Label",
                          "description": "Choice label"
                        },
                        "other": {
                          "type": "string",
                          "title": "Other",
                          "description": "Custom text for 'Other' option"
                        }
                      },
                      "description": "Single choice answer"
                    },
                    "number": {
                      "type": "number",
                      "title": "Number",
                      "description": "Numeric answer"
                    },
                    "boolean": {
                      "type": "boolean",
                      "title": "Boolean",
                      "description": "Boolean answer"
                    },
                    "choices": {
                      "type": "object",
                      "title": "Choices",
                      "properties": {
                        "ids": {
                          "type": "array",
                          "items": {
                            "type": "string"
                          },
                          "title": "Ids",
                          "description": "Selected choice IDs"
                        },
                        "refs": {
                          "type": "array",
                          "items": {
                            "type": "string"
                          },
                          "title": "Refs",
                          "description": "Selected choice references"
                        },
                        "other": {
                          "type": "string",
                          "title": "Other",
                          "description": "Custom text for 'Other' option"
                        },
                        "labels": {
                          "type": "array",
                          "items": {
                            "type": "string"
                          },
                          "title": "Labels",
                          "description": "Selected choice labels"
                        }
                      },
                      "description": "Multiple choice answer"
                    },
                    "payment": {
                      "type": "object",
                      "title": "Payment",
                      "description": "Payment details",
                      "additionalProperties": true
                    },
                    "file_url": {
                      "type": "string",
                      "title": "File Url",
                      "description": "File URL answer"
                    },
                    "multi_format": {
                      "type": "object",
                      "title": "Multi Format",
                      "description": "Multi-format answer (audio/video)",
                      "additionalProperties": true
                    },
                    "phone_number": {
                      "type": "string",
                      "title": "Phone Number",
                      "description": "Phone number answer"
                    }
                  },
                  "description": "Answer to a form field"
                },
                "title": "Answers",
                "description": "Array of answers provided in the response"
              },
              "metadata": {
                "type": "object",
                "title": "Metadata",
                "properties": {
                  "browser": {
                    "type": "string",
                    "title": "Browser",
                    "description": "Browser used"
                  },
                  "referer": {
                    "type": "string",
                    "title": "Referer",
                    "description": "Referer URL"
                  },
                  "platform": {
                    "type": "string",
                    "title": "Platform",
                    "description": "Platform/OS used"
                  },
                  "network_id": {
                    "type": "string",
                    "title": "Network Id",
                    "description": "Network identifier"
                  },
                  "user_agent": {
                    "type": "string",
                    "title": "User Agent",
                    "description": "User agent string"
                  }
                },
                "description": "Response metadata"
              },
              "landed_at": {
                "type": "string",
                "title": "Landed At",
                "description": "ISO 8601 timestamp when user landed on the form"
              },
              "variables": {
                "type": "array",
                "items": {
                  "type": "object",
                  "title": "Variable",
                  "required": [
                    "key",
                    "type"
                  ],
                  "properties": {
                    "key": {
                      "type": "string",
                      "title": "Key",
                      "description": "Variable key"
                    },
                    "text": {
                      "type": "string",
                      "title": "Text",
                      "description": "Text value"
                    },
                    "type": {
                      "type": "string",
                      "title": "Type",
                      "description": "Variable type (text or number)"
                    },
                    "number": {
                      "type": "number",
                      "title": "Number",
                      "description": "Numeric value"
                    }
                  },
                  "description": "Form variable"
                },
                "title": "Variables",
                "description": "Form variables"
              },
              "calculated": {
                "type": "object",
                "title": "Calculated",
                "properties": {
                  "score": {
                    "type": "number",
                    "title": "Score",
                    "description": "Calculated score"
                  }
                },
                "description": "Calculated values like score"
              },
              "response_id": {
                "type": "string",
                "title": "Response Id",
                "description": "Unique response identifier"
              },
              "submitted_at": {
                "type": "string",
                "title": "Submitted At",
                "description": "ISO 8601 timestamp when user submitted the form"
              }
            }
          },
          "title": "Items",
          "description": "List of form responses"
        },
        "page_count": {
          "type": "integer",
          "title": "Page Count",
          "description": "Number of pages"
        },
        "total_items": {
          "type": "integer",
          "title": "Total Items",
          "description": "Total number of responses"
        }
      },
      "description": "Data from the action execution"
    },
    "error": {
      "type": "string",
      "title": "Error",
      "description": "Error if any occurred during the execution of the action"
    },
    "successful": {
      "type": "boolean",
      "title": "Successful",
      "description": "Whether or not the action execution was successful or not"
    }
  }
}
```

## TYPEFORM_GET_IMAGE_BY_SIZE
Tool to retrieve an image in a specific size from Typeform. Use when you need to get a Typeform image optimized for different display contexts (default for desktop, mobile for mobile devices, or thumbnail for previews).

**Input schema:**
```json
{
  "type": "object",
  "title": "GetImageBySizeRequest",
  "required": [
    "image_id",
    "size"
  ],
  "properties": {
    "size": {
      "enum": [
        "default",
        "mobile",
        "thumbnail"
      ],
      "type": "string",
      "title": "Size",
      "examples": [
        "default"
      ],
      "description": "The desired image dimension. Options: 'default' (800px width), 'mobile' (460px width), or 'thumbnail' (80px\u00d750px cropped)"
    },
    "image_id": {
      "type": "string",
      "title": "Image Id",
      "examples": [
        "YY93X8ZdXCC3"
      ],
      "description": "Unique identifier for the image to retrieve"
    }
  }
}
```

**Output schema:**
```json
{
  "type": "object",
  "$defs": {
    "GetImageBySizeResponse": {
      "type": "object",
      "title": "GetImageBySizeResponse",
      "properties": {
        "id": {
          "type": "string",
          "title": "Id",
          "description": "Unique identifier for the image"
        },
        "src": {
          "type": "string",
          "title": "Src",
          "description": "URL of the image at the requested size"
        },
        "width": {
          "type": "integer",
          "title": "Width",
          "description": "Width of the image in pixels"
        },
        "height": {
          "type": "integer",
          "title": "Height",
          "description": "Height of the image in pixels"
        },
        "avg_color": {
          "type": "string",
          "title": "Avg Color",
          "description": "Average color of the image in hexadecimal format"
        },
        "file_name": {
          "type": "string",
          "title": "File Name",
          "description": "Name of the image file"
        },
        "has_alpha": {
          "type": "boolean",
          "title": "Has Alpha",
          "description": "Whether the image has an alpha channel (transparency)"
        },
        "media_type": {
          "type": "string",
          "title": "Media Type",
          "description": "MIME type of the image (image/gif, image/jpeg, or image/png)"
        }
      }
    }
  },
  "title": "GetImageBySizeResponseWrapper",
  "required": [
    "data",
    "successful"
  ],
  "properties": {
    "data": {
      "type": "object",
      "title": "Data",
      "properties": {
        "id": {
          "type": "string",
          "title": "Id",
          "description": "Unique identifier for the image"
        },
        "src": {
          "type": "string",
          "title": "Src",
          "description": "URL of the image at the requested size"
        },
        "width": {
          "type": "integer",
          "title": "Width",
          "description": "Width of the image in pixels"
        },
        "height": {
          "type": "integer",
          "title": "Height",
          "description": "Height of the image in pixels"
        },
        "avg_color": {
          "type": "string",
          "title": "Avg Color",
          "description": "Average color of the image in hexadecimal format"
        },
        "file_name": {
          "type": "string",
          "title": "File Name",
          "description": "Name of the image file"
        },
        "has_alpha": {
          "type": "boolean",
          "title": "Has Alpha",
          "description": "Whether the image has an alpha channel (transparency)"
        },
        "media_type": {
          "type": "string",
          "title": "Media Type",
          "description": "MIME type of the image (image/gif, image/jpeg, or image/png)"
        }
      },
      "description": "Data from the action execution"
    },
    "error": {
      "type": "string",
      "title": "Error",
      "description": "Error if any occurred during the execution of the action"
    },
    "successful": {
      "type": "boolean",
      "title": "Successful",
      "description": "Whether or not the action execution was successful or not"
    }
  }
}
```

## TYPEFORM_GET_THEME
Tool to retrieve a specific theme's configuration including colors, fonts, and layout settings. Use when you need to get the design settings of a Typeform theme.

**Input schema:**
```json
{
  "type": "object",
  "title": "GetThemeRequest",
  "required": [
    "theme_id"
  ],
  "properties": {
    "theme_id": {
      "type": "string",
      "title": "Theme Id",
      "examples": [
        "qHWOQ7"
      ],
      "description": "Unique ID for the theme"
    }
  }
}
```

**Output schema:**
```json
{
  "type": "object",
  "$defs": {
    "ThemeColors": {
      "type": "object",
      "title": "ThemeColors",
      "properties": {
        "answer": {
          "type": "string",
          "title": "Answer",
          "description": "Color for answers"
        },
        "button": {
          "type": "string",
          "title": "Button",
          "description": "Button color"
        },
        "question": {
          "type": "string",
          "title": "Question",
          "description": "Color for questions"
        },
        "background": {
          "type": "string",
          "title": "Background",
          "description": "Background color"
        }
      }
    },
    "ThemeBackground": {
      "type": "object",
      "title": "ThemeBackground",
      "properties": {
        "href": {
          "type": "string",
          "title": "Href",
          "description": "URL of the background image"
        },
        "layout": {
          "type": "string",
          "title": "Layout",
          "description": "Layout style of the background"
        },
        "brightness": {
          "type": "number",
          "title": "Brightness",
          "description": "Brightness level of the background"
        }
      }
    },
    "GetThemeResponse": {
      "type": "object",
      "title": "GetThemeResponse",
      "properties": {
        "id": {
          "type": "string",
          "title": "Id",
          "description": "Unique ID of the theme"
        },
        "font": {
          "type": "string",
          "title": "Font",
          "description": "Font family used in the theme"
        },
        "name": {
          "type": "string",
          "title": "Name",
          "description": "Name of the theme"
        },
        "colors": {
          "type": "object",
          "title": "Colors",
          "properties": {
            "answer": {
              "type": "string",
              "title": "Answer",
              "description": "Color for answers"
            },
            "button": {
              "type": "string",
              "title": "Button",
              "description": "Button color"
            },
            "question": {
              "type": "string",
              "title": "Question",
              "description": "Color for questions"
            },
            "background": {
              "type": "string",
              "title": "Background",
              "description": "Background color"
            }
          },
          "description": "Color scheme configuration"
        },
        "fields": {
          "type": "object",
          "title": "Fields",
          "description": "Field-specific styling configuration",
          "additionalProperties": true
        },
        "screens": {
          "type": "object",
          "title": "Screens",
          "description": "Screen-specific styling configuration",
          "additionalProperties": true
        },
        "background": {
          "type": "object",
          "title": "Background",
          "properties": {
            "href": {
              "type": "string",
              "title": "Href",
              "description": "URL of the background image"
            },
            "layout": {
              "type": "string",
              "title": "Layout",
              "description": "Layout style of the background"
            },
            "brightness": {
              "type": "number",
              "title": "Brightness",
              "description": "Brightness level of the background"
            }
          },
          "description": "Background configuration"
        },
        "visibility": {
          "enum": [
            "public",
            "private"
          ],
          "type": "string",
          "title": "Visibility",
          "description": "Visibility setting of the theme"
        },
        "rounded_corners": {
          "type": "string",
          "title": "Rounded Corners",
          "description": "Rounded corners setting"
        },
        "has_transparent_button": {
          "type": "boolean",
          "title": "Has Transparent Button",
          "description": "Whether the button is transparent"
        }
      }
    }
  },
  "title": "GetThemeResponseWrapper",
  "required": [
    "data",
    "successful"
  ],
  "properties": {
    "data": {
      "type": "object",
      "title": "Data",
      "properties": {
        "id": {
          "type": "string",
          "title": "Id",
          "description": "Unique ID of the theme"
        },
        "font": {
          "type": "string",
          "title": "Font",
          "description": "Font family used in the theme"
        },
        "name": {
          "type": "string",
          "title": "Name",
          "description": "Name of the theme"
        },
        "colors": {
          "type": "object",
          "title": "Colors",
          "properties": {
            "answer": {
              "type": "string",
              "title": "Answer",
              "description": "Color for answers"
            },
            "button": {
              "type": "string",
              "title": "Button",
              "description": "Button color"
            },
            "question": {
              "type": "string",
              "title": "Question",
              "description": "Color for questions"
            },
            "background": {
              "type": "string",
              "title": "Background",
              "description": "Background color"
            }
          },
          "description": "Color scheme configuration"
        },
        "fields": {
          "type": "object",
          "title": "Fields",
          "description": "Field-specific styling configuration",
          "additionalProperties": true
        },
        "screens": {
          "type": "object",
          "title": "Screens",
          "description": "Screen-specific styling configuration",
          "additionalProperties": true
        },
        "background": {
          "type": "object",
          "title": "Background",
          "properties": {
            "href": {
              "type": "string",
              "title": "Href",
              "description": "URL of the background image"
            },
            "layout": {
              "type": "string",
              "title": "Layout",
              "description": "Layout style of the background"
            },
            "brightness": {
              "type": "number",
              "title": "Brightness",
              "description": "Brightness level of the background"
            }
          },
          "description": "Background configuration"
        },
        "visibility": {
          "enum": [
            "public",
            "private"
          ],
          "type": "string",
          "title": "Visibility",
          "description": "Visibility setting of the theme"
        },
        "rounded_corners": {
          "type": "string",
          "title": "Rounded Corners",
          "description": "Rounded corners setting"
        },
        "has_transparent_button": {
          "type": "boolean",
          "title": "Has Transparent Button",
          "description": "Whether the button is transparent"
        }
      },
      "description": "Data from the action execution"
    },
    "error": {
      "type": "string",
      "title": "Error",
      "description": "Error if any occurred during the execution of the action"
    },
    "successful": {
      "type": "boolean",
      "title": "Successful",
      "description": "Whether or not the action execution was successful or not"
    }
  }
}
```

## TYPEFORM_GET_WEBHOOK
Tool to retrieve a single webhook by specifying both the form ID and webhook tag. Use when you need to get details about a specific webhook configuration.

**Input schema:**
```json
{
  "type": "object",
  "title": "TypeformGetWebhookRequest",
  "required": [
    "form_id",
    "tag"
  ],
  "properties": {
    "tag": {
      "type": "string",
      "title": "Tag",
      "examples": [
        "test_webhook_retrieve"
      ],
      "description": "Unique name assigned to the webhook"
    },
    "form_id": {
      "type": "string",
      "title": "Form Id",
      "examples": [
        "CoZt0LNp"
      ],
      "description": "Unique form identifier"
    }
  }
}
```

**Output schema:**
```json
{
  "type": "object",
  "$defs": {
    "TypeformGetWebhookResponse": {
      "type": "object",
      "title": "TypeformGetWebhookResponse",
      "properties": {
        "id": {
          "type": "string",
          "title": "Id",
          "description": "Unique webhook identifier"
        },
        "tag": {
          "type": "string",
          "title": "Tag",
          "description": "Unique name assigned to the webhook"
        },
        "url": {
          "type": "string",
          "title": "Url",
          "description": "Webhook URL that receives notifications"
        },
        "secret": {
          "type": "string",
          "title": "Secret",
          "description": "HMAC SHA256 signing key for payload verification"
        },
        "enabled": {
          "type": "boolean",
          "title": "Enabled",
          "description": "Whether the webhook is enabled"
        },
        "form_id": {
          "type": "string",
          "title": "Form Id",
          "description": "Form identifier the webhook belongs to"
        },
        "created_at": {
          "type": "string",
          "title": "Created At",
          "description": "When the webhook was created in ISO 8601 format"
        },
        "updated_at": {
          "type": "string",
          "title": "Updated At",
          "description": "When the webhook was last updated in ISO 8601 format"
        },
        "verify_ssl": {
          "type": "boolean",
          "title": "Verify Ssl",
          "description": "Whether to verify SSL certificates"
        },
        "event_types": {
          "type": "object",
          "title": "Event Types",
          "description": "Event types webhook subscribes to",
          "additionalProperties": true
        }
      }
    }
  },
  "title": "TypeformGetWebhookResponseWrapper",
  "required": [
    "data",
    "successful"
  ],
  "properties": {
    "data": {
      "type": "object",
      "title": "Data",
      "properties": {
        "id": {
          "type": "string",
          "title": "Id",
          "description": "Unique webhook identifier"
        },
        "tag": {
          "type": "string",
          "title": "Tag",
          "description": "Unique name assigned to the webhook"
        },
        "url": {
          "type": "string",
          "title": "Url",
          "description": "Webhook URL that receives notifications"
        },
        "secret": {
          "type": "string",
          "title": "Secret",
          "description": "HMAC SHA256 signing key for payload verification"
        },
        "enabled": {
          "type": "boolean",
          "title": "Enabled",
          "description": "Whether the webhook is enabled"
        },
        "form_id": {
          "type": "string",
          "title": "Form Id",
          "description": "Form identifier the webhook belongs to"
        },
        "created_at": {
          "type": "string",
          "title": "Created At",
          "description": "When the webhook was created in ISO 8601 format"
        },
        "updated_at": {
          "type": "string",
          "title": "Updated At",
          "description": "When the webhook was last updated in ISO 8601 format"
        },
        "verify_ssl": {
          "type": "boolean",
          "title": "Verify Ssl",
          "description": "Whether to verify SSL certificates"
        },
        "event_types": {
          "type": "object",
          "title": "Event Types",
          "description": "Event types webhook subscribes to",
          "additionalProperties": true
        }
      },
      "description": "Data from the action execution"
    },
    "error": {
      "type": "string",
      "title": "Error",
      "description": "Error if any occurred during the execution of the action"
    },
    "successful": {
      "type": "boolean",
      "title": "Successful",
      "description": "Whether or not the action execution was successful or not"
    }
  }
}
```

## TYPEFORM_GET_WORKSPACE
Tool to retrieve detailed information about a specific workspace including its name, forms, and team members. Use when you need to get workspace details or check member access.

**Input schema:**
```json
{
  "type": "object",
  "title": "GetWorkspaceRequest",
  "required": [
    "workspace_id"
  ],
  "properties": {
    "workspace_id": {
      "type": "string",
      "title": "Workspace Id",
      "examples": [
        "dZMAWB",
        "ucdZbu"
      ],
      "description": "Unique identifier for the workspace to retrieve"
    }
  }
}
```

**Output schema:**
```json
{
  "type": "object",
  "$defs": {
    "WorkspaceMember": {
      "type": "object",
      "title": "WorkspaceMember",
      "properties": {
        "name": {
          "type": "string",
          "title": "Name",
          "description": "Full name of the workspace member"
        },
        "role": {
          "type": "string",
          "title": "Role",
          "description": "Role of the member in the workspace (e.g., 'admin', 'member')"
        },
        "email": {
          "type": "string",
          "title": "Email",
          "description": "Email address of the workspace member"
        }
      }
    },
    "WorkspaceFormsInfo": {
      "type": "object",
      "title": "WorkspaceFormsInfo",
      "properties": {
        "href": {
          "type": "string",
          "title": "Href",
          "description": "API URL for accessing forms in this workspace"
        },
        "count": {
          "type": "integer",
          "title": "Count",
          "description": "Number of forms in this workspace"
        }
      }
    },
    "GetWorkspaceResponse": {
      "type": "object",
      "title": "GetWorkspaceResponse",
      "required": [
        "id",
        "name"
      ],
      "properties": {
        "id": {
          "type": "string",
          "title": "Id",
          "description": "Unique identifier for the workspace"
        },
        "href": {
          "type": "string",
          "title": "Href",
          "description": "API URL for accessing this workspace"
        },
        "name": {
          "type": "string",
          "title": "Name",
          "description": "Name of the workspace"
        },
        "forms": {
          "type": "object",
          "title": "Forms",
          "properties": {
            "href": {
              "type": "string",
              "title": "Href",
              "description": "API URL for accessing forms in this workspace"
            },
            "count": {
              "type": "integer",
              "title": "Count",
              "description": "Number of forms in this workspace"
            }
          },
          "description": "Information about forms in this workspace"
        },
        "members": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "WorkspaceMember",
            "properties": {
              "name": {
                "type": "string",
                "title": "Name",
                "description": "Full name of the workspace member"
              },
              "role": {
                "type": "string",
                "title": "Role",
                "description": "Role of the member in the workspace (e.g., 'admin', 'member')"
              },
              "email": {
                "type": "string",
                "title": "Email",
                "description": "Email address of the workspace member"
              }
            }
          },
          "title": "Members",
          "description": "List of team members with access to this workspace"
        }
      }
    }
  },
  "title": "GetWorkspaceResponseWrapper",
  "required": [
    "data",
    "successful"
  ],
  "properties": {
    "data": {
      "type": "object",
      "title": "Data",
      "required": [
        "id",
        "name"
      ],
      "properties": {
        "id": {
          "type": "string",
          "title": "Id",
          "description": "Unique identifier for the workspace"
        },
        "href": {
          "type": "string",
          "title": "Href",
          "description": "API URL for accessing this workspace"
        },
        "name": {
          "type": "string",
          "title": "Name",
          "description": "Name of the workspace"
        },
        "forms": {
          "type": "object",
          "title": "Forms",
          "properties": {
            "href": {
              "type": "string",
              "title": "Href",
              "description": "API URL for accessing forms in this workspace"
            },
            "count": {
              "type": "integer",
              "title": "Count",
              "description": "Number of forms in this workspace"
            }
          },
          "description": "Information about forms in this workspace"
        },
        "members": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "WorkspaceMember",
            "properties": {
              "name": {
                "type": "string",
                "title": "Name",
                "description": "Full name of the workspace member"
              },
              "role": {
                "type": "string",
                "title": "Role",
                "description": "Role of the member in the workspace (e.g., 'admin', 'member')"
              },
              "email": {
                "type": "string",
                "title": "Email",
                "description": "Email address of the workspace member"
              }
            }
          },
          "title": "Members",
          "description": "List of team members with access to this workspace"
        }
      },
      "description": "Data from the action execution"
    },
    "error": {
      "type": "string",
      "title": "Error",
      "description": "Error if any occurred during the execution of the action"
    },
    "successful": {
      "type": "boolean",
      "title": "Successful",
      "description": "Whether or not the action execution was successful or not"
    }
  }
}
```

## TYPEFORM_LIST_FORMS
Tool to retrieve a list of all forms in your Typeform account with filtering, pagination, and sorting options. Use when you need to list, search, or browse forms across workspaces. Supports filtering by search terms, workspace, and sorting by creation or modification date.

**Input schema:**
```json
{
  "type": "object",
  "title": "TypeformListFormsRequest",
  "properties": {
    "page": {
      "type": "integer",
      "title": "Page",
      "minimum": 1,
      "examples": [
        1,
        2
      ],
      "description": "Page number for pagination (default: 1)"
    },
    "search": {
      "type": "string",
      "title": "Search",
      "examples": [
        "customer feedback",
        "survey"
      ],
      "description": "Filters results containing the specified string in form titles or descriptions"
    },
    "sort_by": {
      "enum": [
        "created_at",
        "last_updated_at"
      ],
      "type": "string",
      "title": "Sort By",
      "description": "Field to sort results by: 'created_at' for creation date or 'last_updated_at' for last modification date"
    },
    "order_by": {
      "enum": [
        "asc",
        "desc"
      ],
      "type": "string",
      "title": "Order By",
      "description": "Sort order: 'asc' for ascending or 'desc' for descending"
    },
    "page_size": {
      "type": "integer",
      "title": "Page Size",
      "maximum": 200,
      "minimum": 1,
      "examples": [
        10,
        50,
        100
      ],
      "description": "Number of results per page (default: 10, maximum: 200)"
    },
    "workspace_id": {
      "type": "string",
      "title": "Workspace Id",
      "examples": [
        "wrk_abc123"
      ],
      "description": "Filter forms by workspace ID to retrieve forms from a specific workspace"
    }
  }
}
```

**Output schema:**
```json
{
  "type": "object",
  "$defs": {
    "FormItem": {
      "type": "object",
      "title": "FormItem",
      "properties": {
        "id": {
          "type": "string",
          "title": "Id",
          "description": "Unique form identifier"
        },
        "theme": {
          "type": "object",
          "title": "Theme",
          "properties": {
            "href": {
              "type": "string",
              "title": "Href",
              "description": "URL reference to the form theme"
            }
          },
          "description": "Form theme information"
        },
        "title": {
          "type": "string",
          "title": "Title",
          "description": "Form title/name"
        },
        "_links": {
          "type": "object",
          "title": " Links",
          "properties": {
            "self": {
              "type": "object",
              "title": "Self",
              "description": "Self link containing href to the form resource",
              "additionalProperties": true
            },
            "display": {
              "type": "string",
              "title": "Display",
              "description": "URL to display the form"
            },
            "responses": {
              "type": "string",
              "title": "Responses",
              "description": "URL to retrieve form responses"
            }
          },
          "description": "Related resource links"
        },
        "settings": {
          "type": "object",
          "title": "Settings",
          "properties": {
            "is_public": {
              "type": "boolean",
              "title": "Is Public",
              "description": "Whether the form is publicly accessible"
            }
          },
          "description": "Form settings including visibility"
        },
        "created_at": {
          "type": "string",
          "title": "Created At",
          "description": "Creation timestamp in ISO 8601 format"
        },
        "last_updated_at": {
          "type": "string",
          "title": "Last Updated At",
          "description": "Last modification timestamp in ISO 8601 format"
        }
      }
    },
    "FormLinks": {
      "type": "object",
      "title": "FormLinks",
      "properties": {
        "self": {
          "type": "object",
          "title": "Self",
          "description": "Self link containing href to the form resource",
          "additionalProperties": true
        },
        "display": {
          "type": "string",
          "title": "Display",
          "description": "URL to display the form"
        },
        "responses": {
          "type": "string",
          "title": "Responses",
          "description": "URL to retrieve form responses"
        }
      }
    },
    "FormTheme": {
      "type": "object",
      "title": "FormTheme",
      "properties": {
        "href": {
          "type": "string",
          "title": "Href",
          "description": "URL reference to the form theme"
        }
      }
    },
    "FormSettings": {
      "type": "object",
      "title": "FormSettings",
      "properties": {
        "is_public": {
          "type": "boolean",
          "title": "Is Public",
          "description": "Whether the form is publicly accessible"
        }
      }
    },
    "TypeformListFormsResponse": {
      "type": "object",
      "title": "TypeformListFormsResponse",
      "properties": {
        "items": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "FormItem",
            "properties": {
              "id": {
                "type": "string",
                "title": "Id",
                "description": "Unique form identifier"
              },
              "theme": {
                "type": "object",
                "title": "Theme",
                "properties": {
                  "href": {
                    "type": "string",
                    "title": "Href",
                    "description": "URL reference to the form theme"
                  }
                },
                "description": "Form theme information"
              },
              "title": {
                "type": "string",
                "title": "Title",
                "description": "Form title/name"
              },
              "_links": {
                "type": "object",
                "title": " Links",
                "properties": {
                  "self": {
                    "type": "object",
                    "title": "Self",
                    "description": "Self link containing href to the form resource",
                    "additionalProperties": true
                  },
                  "display": {
                    "type": "string",
                    "title": "Display",
                    "description": "URL to display the form"
                  },
                  "responses": {
                    "type": "string",
                    "title": "Responses",
                    "description": "URL to retrieve form responses"
                  }
                },
                "description": "Related resource links"
              },
              "settings": {
                "type": "object",
                "title": "Settings",
                "properties": {
                  "is_public": {
                    "type": "boolean",
                    "title": "Is Public",
                    "description": "Whether the form is publicly accessible"
                  }
                },
                "description": "Form settings including visibility"
              },
              "created_at": {
                "type": "string",
                "title": "Created At",
                "description": "Creation timestamp in ISO 8601 format"
              },
              "last_updated_at": {
                "type": "string",
                "title": "Last Updated At",
                "description": "Last modification timestamp in ISO 8601 format"
              }
            }
          },
          "title": "Items",
          "description": "List of forms returned in this page"
        },
        "page_count": {
          "type": "integer",
          "title": "Page Count",
          "description": "Total number of pages available"
        },
        "total_items": {
          "type": "integer",
          "title": "Total Items",
          "description": "Total number of forms in the collection"
        }
      }
    }
  },
  "title": "TypeformListFormsResponseWrapper",
  "required": [
    "data",
    "successful"
  ],
  "properties": {
    "data": {
      "type": "object",
      "title": "Data",
      "properties": {
        "items": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "FormItem",
            "properties": {
              "id": {
                "type": "string",
                "title": "Id",
                "description": "Unique form identifier"
              },
              "theme": {
                "type": "object",
                "title": "Theme",
                "properties": {
                  "href": {
                    "type": "string",
                    "title": "Href",
                    "description": "URL reference to the form theme"
                  }
                },
                "description": "Form theme information"
              },
              "title": {
                "type": "string",
                "title": "Title",
                "description": "Form title/name"
              },
              "_links": {
                "type": "object",
                "title": " Links",
                "properties": {
                  "self": {
                    "type": "object",
                    "title": "Self",
                    "description": "Self link containing href to the form resource",
                    "additionalProperties": true
                  },
                  "display": {
                    "type": "string",
                    "title": "Display",
                    "description": "URL to display the form"
                  },
                  "responses": {
                    "type": "string",
                    "title": "Responses",
                    "description": "URL to retrieve form responses"
                  }
                },
                "description": "Related resource links"
              },
              "settings": {
                "type": "object",
                "title": "Settings",
                "properties": {
                  "is_public": {
                    "type": "boolean",
                    "title": "Is Public",
                    "description": "Whether the form is publicly accessible"
                  }
                },
                "description": "Form settings including visibility"
              },
              "created_at": {
                "type": "string",
                "title": "Created At",
                "description": "Creation timestamp in ISO 8601 format"
              },
              "last_updated_at": {
                "type": "string",
                "title": "Last Updated At",
                "description": "Last modification timestamp in ISO 8601 format"
              }
            }
          },
          "title": "Items",
          "description": "List of forms returned in this page"
        },
        "page_count": {
          "type": "integer",
          "title": "Page Count",
          "description": "Total number of pages available"
        },
        "total_items": {
          "type": "integer",
          "title": "Total Items",
          "description": "Total number of forms in the collection"
        }
      },
      "description": "Data from the action execution"
    },
    "error": {
      "type": "string",
      "title": "Error",
      "description": "Error if any occurred during the execution of the action"
    },
    "successful": {
      "type": "boolean",
      "title": "Successful",
      "description": "Whether or not the action execution was successful or not"
    }
  }
}
```

## TYPEFORM_LIST_IMAGES
Tool to retrieve all images in your Typeform account in reverse-chronological order. Use when you need to list or browse available images.

**Input schema:**
```json
{
  "type": "object",
  "title": "TypeformListImagesRequest",
  "properties": {}
}
```

**Output schema:**
```json
{
  "type": "object",
  "$defs": {
    "ImageItem": {
      "type": "object",
      "title": "ImageItem",
      "properties": {
        "id": {
          "type": "string",
          "title": "Id",
          "description": "Unique identifier for the image"
        },
        "src": {
          "type": "string",
          "title": "Src",
          "description": "Source URL of the image"
        },
        "file_name": {
          "type": "string",
          "title": "File Name",
          "description": "Name of the image file"
        }
      }
    },
    "TypeformListImagesResponse": {
      "type": "object",
      "title": "TypeformListImagesResponse",
      "properties": {
        "images": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "ImageItem",
            "properties": {
              "id": {
                "type": "string",
                "title": "Id",
                "description": "Unique identifier for the image"
              },
              "src": {
                "type": "string",
                "title": "Src",
                "description": "Source URL of the image"
              },
              "file_name": {
                "type": "string",
                "title": "File Name",
                "description": "Name of the image file"
              }
            }
          },
          "title": "Images",
          "description": "List of images in reverse-chronological order"
        }
      }
    }
  },
  "title": "TypeformListImagesResponseWrapper",
  "required": [
    "data",
    "successful"
  ],
  "properties": {
    "data": {
      "type": "object",
      "title": "Data",
      "properties": {
        "images": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "ImageItem",
            "properties": {
              "id": {
                "type": "string",
                "title": "Id",
                "description": "Unique identifier for the image"
              },
              "src": {
                "type": "string",
                "title": "Src",
                "description": "Source URL of the image"
              },
              "file_name": {
                "type": "string",
                "title": "File Name",
                "description": "Name of the image file"
              }
            }
          },
          "title": "Images",
          "description": "List of images in reverse-chronological order"
        }
      },
      "description": "Data from the action execution"
    },
    "error": {
      "type": "string",
      "title": "Error",
      "description": "Error if any occurred during the execution of the action"
    },
    "successful": {
      "type": "boolean",
      "title": "Successful",
      "description": "Whether or not the action execution was successful or not"
    }
  }
}
```

## TYPEFORM_LIST_THEMES
Tool to retrieve a paginated list of themes in your Typeform account. Use when you need to access available themes for form styling. Returns both public and private themes with their styling configurations.

**Input schema:**
```json
{
  "type": "object",
  "title": "TypeformListThemesRequest",
  "properties": {
    "page": {
      "type": "integer",
      "title": "Page",
      "minimum": 1,
      "examples": [
        1,
        2,
        3
      ],
      "description": "Page number to retrieve (default: 1)"
    },
    "page_size": {
      "type": "integer",
      "title": "Page Size",
      "maximum": 200,
      "minimum": 1,
      "examples": [
        10,
        50,
        200
      ],
      "description": "Number of results per page, maximum 200 (default: 10)"
    }
  }
}
```

**Output schema:**
```json
{
  "type": "object",
  "$defs": {
    "ThemeItem": {
      "type": "object",
      "title": "ThemeItem",
      "properties": {
        "id": {
          "type": "string",
          "title": "Id",
          "description": "Unique theme identifier"
        },
        "font": {
          "type": "string",
          "title": "Font",
          "description": "Font family used in the theme"
        },
        "name": {
          "type": "string",
          "title": "Name",
          "description": "Theme name"
        },
        "colors": {
          "type": "object",
          "title": "Colors",
          "properties": {
            "answer": {
              "type": "string",
              "title": "Answer",
              "description": "Answer text color"
            },
            "button": {
              "type": "string",
              "title": "Button",
              "description": "Button color"
            },
            "question": {
              "type": "string",
              "title": "Question",
              "description": "Question text color"
            },
            "background": {
              "type": "string",
              "title": "Background",
              "description": "Background color"
            }
          },
          "description": "Color scheme for the theme"
        },
        "fields": {
          "type": "object",
          "title": "Fields",
          "description": "Field-specific styling",
          "additionalProperties": {
            "anyOf": [
              {
                "type": "string"
              },
              {
                "type": "boolean"
              },
              {
                "type": "integer"
              }
            ]
          }
        },
        "screens": {
          "type": "object",
          "title": "Screens",
          "description": "Screen-specific styling",
          "additionalProperties": {
            "anyOf": [
              {
                "type": "string"
              },
              {
                "type": "boolean"
              },
              {
                "type": "integer"
              }
            ]
          }
        },
        "background": {
          "type": "object",
          "title": "Background",
          "description": "Background configuration",
          "additionalProperties": {
            "anyOf": [
              {
                "type": "string"
              },
              {
                "type": "integer"
              }
            ]
          }
        },
        "visibility": {
          "type": "string",
          "title": "Visibility",
          "description": "Theme visibility: public or private"
        },
        "rounded_corners": {
          "type": "string",
          "title": "Rounded Corners",
          "description": "Border radius setting"
        },
        "has_transparent_button": {
          "type": "boolean",
          "title": "Has Transparent Button",
          "description": "Whether buttons are transparent"
        }
      }
    },
    "ThemeColors": {
      "type": "object",
      "title": "ThemeColors",
      "properties": {
        "answer": {
          "type": "string",
          "title": "Answer",
          "description": "Answer text color"
        },
        "button": {
          "type": "string",
          "title": "Button",
          "description": "Button color"
        },
        "question": {
          "type": "string",
          "title": "Question",
          "description": "Question text color"
        },
        "background": {
          "type": "string",
          "title": "Background",
          "description": "Background color"
        }
      }
    },
    "TypeformListThemesResponse": {
      "type": "object",
      "title": "TypeformListThemesResponse",
      "properties": {
        "items": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "ThemeItem",
            "properties": {
              "id": {
                "type": "string",
                "title": "Id",
                "description": "Unique theme identifier"
              },
              "font": {
                "type": "string",
                "title": "Font",
                "description": "Font family used in the theme"
              },
              "name": {
                "type": "string",
                "title": "Name",
                "description": "Theme name"
              },
              "colors": {
                "type": "object",
                "title": "Colors",
                "properties": {
                  "answer": {
                    "type": "string",
                    "title": "Answer",
                    "description": "Answer text color"
                  },
                  "button": {
                    "type": "string",
                    "title": "Button",
                    "description": "Button color"
                  },
                  "question": {
                    "type": "string",
                    "title": "Question",
                    "description": "Question text color"
                  },
                  "background": {
                    "type": "string",
                    "title": "Background",
                    "description": "Background color"
                  }
                },
                "description": "Color scheme for the theme"
              },
              "fields": {
                "type": "object",
                "title": "Fields",
                "description": "Field-specific styling",
                "additionalProperties": {
                  "anyOf": [
                    {
                      "type": "string"
                    },
                    {
                      "type": "boolean"
                    },
                    {
                      "type": "integer"
                    }
                  ]
                }
              },
              "screens": {
                "type": "object",
                "title": "Screens",
                "description": "Screen-specific styling",
                "additionalProperties": {
                  "anyOf": [
                    {
                      "type": "string"
                    },
                    {
                      "type": "boolean"
                    },
                    {
                      "type": "integer"
                    }
                  ]
                }
              },
              "background": {
                "type": "object",
                "title": "Background",
                "description": "Background configuration",
                "additionalProperties": {
                  "anyOf": [
                    {
                      "type": "string"
                    },
                    {
                      "type": "integer"
                    }
                  ]
                }
              },
              "visibility": {
                "type": "string",
                "title": "Visibility",
                "description": "Theme visibility: public or private"
              },
              "rounded_corners": {
                "type": "string",
                "title": "Rounded Corners",
                "description": "Border radius setting"
              },
              "has_transparent_button": {
                "type": "boolean",
                "title": "Has Transparent Button",
                "description": "Whether buttons are transparent"
              }
            }
          },
          "title": "Items",
          "description": "List of theme objects"
        },
        "page_count": {
          "type": "integer",
          "title": "Page Count",
          "description": "Total number of pages available"
        },
        "total_items": {
          "type": "integer",
          "title": "Total Items",
          "description": "Total number of themes in the collection"
        }
      }
    }
  },
  "title": "TypeformListThemesResponseWrapper",
  "required": [
    "data",
    "successful"
  ],
  "properties": {
    "data": {
      "type": "object",
      "title": "Data",
      "properties": {
        "items": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "ThemeItem",
            "properties": {
              "id": {
                "type": "string",
                "title": "Id",
                "description": "Unique theme identifier"
              },
              "font": {
                "type": "string",
                "title": "Font",
                "description": "Font family used in the theme"
              },
              "name": {
                "type": "string",
                "title": "Name",
                "description": "Theme name"
              },
              "colors": {
                "type": "object",
                "title": "Colors",
                "properties": {
                  "answer": {
                    "type": "string",
                    "title": "Answer",
                    "description": "Answer text color"
                  },
                  "button": {
                    "type": "string",
                    "title": "Button",
                    "description": "Button color"
                  },
                  "question": {
                    "type": "string",
                    "title": "Question",
                    "description": "Question text color"
                  },
                  "background": {
                    "type": "string",
                    "title": "Background",
                    "description": "Background color"
                  }
                },
                "description": "Color scheme for the theme"
              },
              "fields": {
                "type": "object",
                "title": "Fields",
                "description": "Field-specific styling",
                "additionalProperties": {
                  "anyOf": [
                    {
                      "type": "string"
                    },
                    {
                      "type": "boolean"
                    },
                    {
                      "type": "integer"
                    }
                  ]
                }
              },
              "screens": {
                "type": "object",
                "title": "Screens",
                "description": "Screen-specific styling",
                "additionalProperties": {
                  "anyOf": [
                    {
                      "type": "string"
                    },
                    {
                      "type": "boolean"
                    },
                    {
                      "type": "integer"
                    }
                  ]
                }
              },
              "background": {
                "type": "object",
                "title": "Background",
                "description": "Background configuration",
                "additionalProperties": {
                  "anyOf": [
                    {
                      "type": "string"
                    },
                    {
                      "type": "integer"
                    }
                  ]
                }
              },
              "visibility": {
                "type": "string",
                "title": "Visibility",
                "description": "Theme visibility: public or private"
              },
              "rounded_corners": {
                "type": "string",
                "title": "Rounded Corners",
                "description": "Border radius setting"
              },
              "has_transparent_button": {
                "type": "boolean",
                "title": "Has Transparent Button",
                "description": "Whether buttons are transparent"
              }
            }
          },
          "title": "Items",
          "description": "List of theme objects"
        },
        "page_count": {
          "type": "integer",
          "title": "Page Count",
          "description": "Total number of pages available"
        },
        "total_items": {
          "type": "integer",
          "title": "Total Items",
          "description": "Total number of themes in the collection"
        }
      },
      "description": "Data from the action execution"
    },
    "error": {
      "type": "string",
      "title": "Error",
      "description": "Error if any occurred during the execution of the action"
    },
    "successful": {
      "type": "boolean",
      "title": "Successful",
      "description": "Whether or not the action execution was successful or not"
    }
  }
}
```

## TYPEFORM_LIST_WEBHOOKS
Tool to retrieve all webhooks associated with a specified typeform. Use when you need to view webhook configurations for a form. Returns webhook IDs, URLs, enabled status, event types, and timestamps.

**Input schema:**
```json
{
  "type": "object",
  "title": "TypeformListWebhooksRequest",
  "required": [
    "form_id"
  ],
  "properties": {
    "form_id": {
      "type": "string",
      "title": "Form Id",
      "examples": [
        "CoZt0LNp"
      ],
      "description": "Unique form identifier for which to retrieve webhooks"
    }
  }
}
```

**Output schema:**
```json
{
  "type": "object",
  "$defs": {
    "Webhook": {
      "type": "object",
      "title": "Webhook",
      "required": [
        "id",
        "tag",
        "url",
        "enabled",
        "form_id",
        "created_at",
        "updated_at"
      ],
      "properties": {
        "id": {
          "type": "string",
          "title": "Id",
          "description": "Unique webhook identifier"
        },
        "tag": {
          "type": "string",
          "title": "Tag",
          "description": "Tag associated with the webhook"
        },
        "url": {
          "type": "string",
          "title": "Url",
          "description": "URL where webhook events are sent"
        },
        "enabled": {
          "type": "boolean",
          "title": "Enabled",
          "description": "Whether the webhook is currently enabled"
        },
        "form_id": {
          "type": "string",
          "title": "Form Id",
          "description": "Form identifier this webhook is associated with"
        },
        "created_at": {
          "type": "string",
          "title": "Created At",
          "description": "ISO 8601 timestamp when webhook was created"
        },
        "updated_at": {
          "type": "string",
          "title": "Updated At",
          "description": "ISO 8601 timestamp when webhook was last updated"
        },
        "verify_ssl": {
          "type": "boolean",
          "title": "Verify Ssl",
          "description": "Whether SSL verification is enabled for the webhook URL"
        },
        "event_types": {
          "type": "object",
          "title": "Event Types",
          "description": "Event types that trigger this webhook",
          "additionalProperties": {
            "type": "boolean"
          }
        }
      },
      "description": "Individual webhook configuration"
    },
    "TypeformListWebhooksResponse": {
      "type": "object",
      "title": "TypeformListWebhooksResponse",
      "required": [
        "webhooks"
      ],
      "properties": {
        "webhooks": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "Webhook",
            "required": [
              "id",
              "tag",
              "url",
              "enabled",
              "form_id",
              "created_at",
              "updated_at"
            ],
            "properties": {
              "id": {
                "type": "string",
                "title": "Id",
                "description": "Unique webhook identifier"
              },
              "tag": {
                "type": "string",
                "title": "Tag",
                "description": "Tag associated with the webhook"
              },
              "url": {
                "type": "string",
                "title": "Url",
                "description": "URL where webhook events are sent"
              },
              "enabled": {
                "type": "boolean",
                "title": "Enabled",
                "description": "Whether the webhook is currently enabled"
              },
              "form_id": {
                "type": "string",
                "title": "Form Id",
                "description": "Form identifier this webhook is associated with"
              },
              "created_at": {
                "type": "string",
                "title": "Created At",
                "description": "ISO 8601 timestamp when webhook was created"
              },
              "updated_at": {
                "type": "string",
                "title": "Updated At",
                "description": "ISO 8601 timestamp when webhook was last updated"
              },
              "verify_ssl": {
                "type": "boolean",
                "title": "Verify Ssl",
                "description": "Whether SSL verification is enabled for the webhook URL"
              },
              "event_types": {
                "type": "object",
                "title": "Event Types",
                "description": "Event types that trigger this webhook",
                "additionalProperties": {
                  "type": "boolean"
                }
              }
            },
            "description": "Individual webhook configuration"
          },
          "title": "Webhooks",
          "description": "List of all webhooks configured for the form"
        }
      },
      "description": "Response containing all webhooks for the specified form"
    }
  },
  "title": "TypeformListWebhooksResponseWrapper",
  "required": [
    "data",
    "successful"
  ],
  "properties": {
    "data": {
      "type": "object",
      "title": "Data",
      "required": [
        "webhooks"
      ],
      "properties": {
        "webhooks": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "Webhook",
            "required": [
              "id",
              "tag",
              "url",
              "enabled",
              "form_id",
              "created_at",
              "updated_at"
            ],
            "properties": {
              "id": {
                "type": "string",
                "title": "Id",
                "description": "Unique webhook identifier"
              },
              "tag": {
                "type": "string",
                "title": "Tag",
                "description": "Tag associated with the webhook"
              },
              "url": {
                "type": "string",
                "title": "Url",
                "description": "URL where webhook events are sent"
              },
              "enabled": {
                "type": "boolean",
                "title": "Enabled",
                "description": "Whether the webhook is currently enabled"
              },
              "form_id": {
                "type": "string",
                "title": "Form Id",
                "description": "Form identifier this webhook is associated with"
              },
              "created_at": {
                "type": "string",
                "title": "Created At",
                "description": "ISO 8601 timestamp when webhook was created"
              },
              "updated_at": {
                "type": "string",
                "title": "Updated At",
                "description": "ISO 8601 timestamp when webhook was last updated"
              },
              "verify_ssl": {
                "type": "boolean",
                "title": "Verify Ssl",
                "description": "Whether SSL verification is enabled for the webhook URL"
              },
              "event_types": {
                "type": "object",
                "title": "Event Types",
                "description": "Event types that trigger this webhook",
                "additionalProperties": {
                  "type": "boolean"
                }
              }
            },
            "description": "Individual webhook configuration"
          },
          "title": "Webhooks",
          "description": "List of all webhooks configured for the form"
        }
      },
      "description": "Data from the action execution"
    },
    "error": {
      "type": "string",
      "title": "Error",
      "description": "Error if any occurred during the execution of the action"
    },
    "successful": {
      "type": "boolean",
      "title": "Successful",
      "description": "Whether or not the action execution was successful or not"
    }
  }
}
```

## TYPEFORM_LIST_WORKSPACES
Tool to retrieve all workspaces in a Typeform account with their IDs, names, form counts, and members. Use when you need to list available workspaces or search for specific workspaces by name.

**Input schema:**
```json
{
  "type": "object",
  "title": "TypeformListWorkspacesRequest",
  "properties": {
    "page": {
      "type": "integer",
      "title": "Page",
      "minimum": 1,
      "examples": [
        1,
        2
      ],
      "description": "Page number for pagination. Default is 1."
    },
    "search": {
      "type": "string",
      "title": "Search",
      "examples": [
        "Marketing",
        "Sales Team"
      ],
      "description": "Search term to filter workspaces by name. Only workspaces matching this search term will be returned."
    },
    "page_size": {
      "type": "integer",
      "title": "Page Size",
      "maximum": 200,
      "minimum": 1,
      "examples": [
        10,
        50,
        200
      ],
      "description": "Number of items per page. Default is 10, maximum is 200."
    }
  }
}
```

**Output schema:**
```json
{
  "type": "object",
  "$defs": {
    "WorkspaceItem": {
      "type": "object",
      "title": "WorkspaceItem",
      "required": [
        "id",
        "name"
      ],
      "properties": {
        "id": {
          "type": "string",
          "title": "Id",
          "description": "Unique identifier for the workspace"
        },
        "href": {
          "type": "string",
          "title": "Href",
          "description": "API URL for accessing this workspace"
        },
        "name": {
          "type": "string",
          "title": "Name",
          "description": "Name of the workspace"
        },
        "forms": {
          "type": "object",
          "title": "Forms",
          "properties": {
            "count": {
              "type": "integer",
              "title": "Count",
              "description": "Number of forms in this workspace"
            }
          },
          "description": "Information about forms in this workspace"
        },
        "members": {
          "type": "array",
          "items": {
            "type": "object",
            "additionalProperties": true
          },
          "title": "Members",
          "description": "List of members in this workspace"
        }
      }
    },
    "WorkspaceFormsInfo": {
      "type": "object",
      "title": "WorkspaceFormsInfo",
      "properties": {
        "count": {
          "type": "integer",
          "title": "Count",
          "description": "Number of forms in this workspace"
        }
      }
    },
    "TypeformListWorkspacesResponse": {
      "type": "object",
      "title": "TypeformListWorkspacesResponse",
      "required": [
        "workspaces"
      ],
      "properties": {
        "workspaces": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "WorkspaceItem",
            "required": [
              "id",
              "name"
            ],
            "properties": {
              "id": {
                "type": "string",
                "title": "Id",
                "description": "Unique identifier for the workspace"
              },
              "href": {
                "type": "string",
                "title": "Href",
                "description": "API URL for accessing this workspace"
              },
              "name": {
                "type": "string",
                "title": "Name",
                "description": "Name of the workspace"
              },
              "forms": {
                "type": "object",
                "title": "Forms",
                "properties": {
                  "count": {
                    "type": "integer",
                    "title": "Count",
                    "description": "Number of forms in this workspace"
                  }
                },
                "description": "Information about forms in this workspace"
              },
              "members": {
                "type": "array",
                "items": {
                  "type": "object",
                  "additionalProperties": true
                },
                "title": "Members",
                "description": "List of members in this workspace"
              }
            }
          },
          "title": "Workspaces",
          "description": "List of workspaces in the Typeform account"
        }
      }
    }
  },
  "title": "TypeformListWorkspacesResponseWrapper",
  "required": [
    "data",
    "successful"
  ],
  "properties": {
    "data": {
      "type": "object",
      "title": "Data",
      "required": [
        "workspaces"
      ],
      "properties": {
        "workspaces": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "WorkspaceItem",
            "required": [
              "id",
              "name"
            ],
            "properties": {
              "id": {
                "type": "string",
                "title": "Id",
                "description": "Unique identifier for the workspace"
              },
              "href": {
                "type": "string",
                "title": "Href",
                "description": "API URL for accessing this workspace"
              },
              "name": {
                "type": "string",
                "title": "Name",
                "description": "Name of the workspace"
              },
              "forms": {
                "type": "object",
                "title": "Forms",
                "properties": {
                  "count": {
                    "type": "integer",
                    "title": "Count",
                    "description": "Number of forms in this workspace"
                  }
                },
                "description": "Information about forms in this workspace"
              },
              "members": {
                "type": "array",
                "items": {
                  "type": "object",
                  "additionalProperties": true
                },
                "title": "Members",
                "description": "List of members in this workspace"
              }
            }
          },
          "title": "Workspaces",
          "description": "List of workspaces in the Typeform account"
        }
      },
      "description": "Data from the action execution"
    },
    "error": {
      "type": "string",
      "title": "Error",
      "description": "Error if any occurred during the execution of the action"
    },
    "successful": {
      "type": "boolean",
      "title": "Successful",
      "description": "Whether or not the action execution was successful or not"
    }
  }
}
```

## TYPEFORM_PATCH_FORM
Tool to partially update a Typeform using JSON Patch operations. Use when you need to modify specific fields without replacing the entire form. Supports updating title, settings, theme, workspace, and other form properties.

**Input schema:**
```json
{
  "type": "object",
  "title": "TypeformPatchFormRequest",
  "required": [
    "form_id",
    "operations"
  ],
  "properties": {
    "form_id": {
      "type": "string",
      "title": "Form Id",
      "examples": [
        "Y78g1cmS",
        "u6nXL7"
      ],
      "description": "Unique form identifier found in the form URL"
    },
    "operations": {
      "type": "array",
      "items": {
        "type": "object",
        "title": "PatchOperation",
        "required": [
          "op",
          "path"
        ],
        "properties": {
          "op": {
            "enum": [
              "add",
              "remove",
              "replace"
            ],
            "type": "string",
            "title": "Op",
            "examples": [
              "replace"
            ],
            "description": "Operation type: 'add' to add a new field, 'remove' to delete a field, or 'replace' to update an existing field"
          },
          "path": {
            "type": "string",
            "title": "Path",
            "examples": [
              "/title",
              "/settings/is_public",
              "/theme/href"
            ],
            "description": "JSON path to the field to modify (e.g., '/title' for form title, '/settings/is_public' for privacy setting, '/fields/0/title' for first field title)"
          },
          "value": {
            "anyOf": [
              {
                "type": "string"
              },
              {
                "type": "integer"
              },
              {
                "type": "number"
              },
              {
                "type": "boolean"
              },
              {
                "type": "object",
                "additionalProperties": true
              },
              {
                "type": "array",
                "items": {}
              }
            ],
            "title": "Value",
            "examples": [
              "Updated Form Title",
              true,
              "https://api.typeform.com/themes/abc123"
            ],
            "description": "New value for the field. Required for 'add' and 'replace' operations, omitted for 'remove' operations. Can be string, number, boolean, object, or array depending on the field being updated"
          }
        },
        "description": "Represents a single JSON Patch operation"
      },
      "title": "Operations",
      "examples": [
        [
          {
            "op": "replace",
            "path": "/title",
            "value": "Updated Test Form"
          }
        ],
        [
          {
            "op": "replace",
            "path": "/title",
            "value": "New Title"
          },
          {
            "op": "replace",
            "path": "/settings/is_public",
            "value": false
          }
        ]
      ],
      "minItems": 1,
      "description": "List of JSON Patch operations to apply to the form. Each operation specifies an action (add/remove/replace), a path to the field, and optionally a value"
    }
  }
}
```

**Output schema:**
```json
{
  "type": "object",
  "$defs": {
    "TypeformPatchFormResponse": {
      "type": "object",
      "title": "TypeformPatchFormResponse",
      "required": [
        "success",
        "message"
      ],
      "properties": {
        "message": {
          "type": "string",
          "title": "Message",
          "description": "Status message about the update operation"
        },
        "success": {
          "type": "boolean",
          "title": "Success",
          "description": "Indicates whether the form was successfully updated"
        }
      }
    }
  },
  "title": "TypeformPatchFormResponseWrapper",
  "required": [
    "data",
    "successful"
  ],
  "properties": {
    "data": {
      "type": "object",
      "title": "Data",
      "required": [
        "success",
        "message"
      ],
      "properties": {
        "message": {
          "type": "string",
          "title": "Message",
          "description": "Status message about the update operation"
        },
        "success": {
          "type": "boolean",
          "title": "Success",
          "description": "Indicates whether the form was successfully updated"
        }
      },
      "description": "Data from the action execution"
    },
    "error": {
      "type": "string",
      "title": "Error",
      "description": "Error if any occurred during the execution of the action"
    },
    "successful": {
      "type": "boolean",
      "title": "Successful",
      "description": "Whether or not the action execution was successful or not"
    }
  }
}
```

## TYPEFORM_PATCH_THEME
Tool to partially update a Typeform theme by ID. Updates only the specified properties while leaving other theme settings unchanged. Each provided field must be complete (e.g., if updating colors, all color subfields must be provided). Cannot modify Typeform's public built-in themes.

**Input schema:**
```json
{
  "type": "object",
  "title": "PatchThemeRequest",
  "required": [
    "theme_id"
  ],
  "properties": {
    "font": {
      "type": "string",
      "title": "Font",
      "examples": [
        "Arial",
        "Georgia"
      ],
      "description": "Font family for the theme. Must be a valid Typeform font option."
    },
    "name": {
      "type": "string",
      "title": "Name",
      "examples": [
        "Updated Test Theme",
        "My Custom Theme"
      ],
      "description": "Name for the theme"
    },
    "colors": {
      "type": "object",
      "title": "ColorsObject",
      "required": [
        "answer",
        "background",
        "button",
        "question"
      ],
      "properties": {
        "answer": {
          "type": "string",
          "title": "Answer",
          "examples": [
            "#800000",
            "#FF5733"
          ],
          "description": "Hexadecimal color code for answers (e.g., '#800000')"
        },
        "button": {
          "type": "string",
          "title": "Button",
          "examples": [
            "#808080",
            "#4CAF50"
          ],
          "description": "Hexadecimal color code for buttons (e.g., '#808080')"
        },
        "question": {
          "type": "string",
          "title": "Question",
          "examples": [
            "#000000",
            "#333333"
          ],
          "description": "Hexadecimal color code for questions (e.g., '#000000')"
        },
        "background": {
          "type": "string",
          "title": "Background",
          "examples": [
            "#FFFFFF",
            "#F0F0F0"
          ],
          "description": "Hexadecimal color code for background (e.g., '#FFFFFF')"
        }
      },
      "description": "Colors configuration for the theme.",
      "additionalProperties": false
    },
    "fields": {
      "type": "object",
      "title": "FieldsScreensObject",
      "properties": {
        "alignment": {
          "enum": [
            "left",
            "center"
          ],
          "type": "string",
          "title": "Alignment",
          "examples": [
            "center"
          ],
          "description": "Text alignment"
        },
        "font_size": {
          "enum": [
            "small",
            "medium",
            "large"
          ],
          "type": "string",
          "title": "Font Size",
          "examples": [
            "medium"
          ],
          "description": "Font size option"
        }
      },
      "description": "Configuration for fields or screens alignment and font size.",
      "additionalProperties": false
    },
    "screens": {
      "type": "object",
      "title": "FieldsScreensObject",
      "properties": {
        "alignment": {
          "enum": [
            "left",
            "center"
          ],
          "type": "string",
          "title": "Alignment",
          "examples": [
            "center"
          ],
          "description": "Text alignment"
        },
        "font_size": {
          "enum": [
            "small",
            "medium",
            "large"
          ],
          "type": "string",
          "title": "Font Size",
          "examples": [
            "medium"
          ],
          "description": "Font size option"
        }
      },
      "description": "Configuration for fields or screens alignment and font size.",
      "additionalProperties": false
    },
    "theme_id": {
      "type": "string",
      "title": "Theme Id",
      "examples": [
        "DlvKunmZ",
        "abc123"
      ],
      "description": "Unique ID for the theme to update"
    },
    "background": {
      "type": "object",
      "title": "BackgroundObject",
      "properties": {
        "href": {
          "type": "string",
          "title": "Href",
          "examples": [
            "https://example.com/image.jpg"
          ],
          "description": "URL of the background image"
        },
        "layout": {
          "enum": [
            "fullscreen",
            "repeat",
            "no-repeat"
          ],
          "type": "string",
          "title": "Layout",
          "examples": [
            "fullscreen"
          ],
          "description": "Background image layout style"
        },
        "brightness": {
          "type": "number",
          "title": "Brightness",
          "maximum": 1,
          "minimum": -1,
          "examples": [
            0.5,
            -0.3
          ],
          "description": "Brightness level from -1 to 1"
        }
      },
      "description": "Background configuration for the theme.",
      "additionalProperties": false
    },
    "rounded_corners": {
      "enum": [
        "none",
        "small",
        "large"
      ],
      "type": "string",
      "title": "Rounded Corners",
      "examples": [
        "small"
      ],
      "description": "Rounded corners setting for the theme"
    },
    "has_transparent_button": {
      "type": "boolean",
      "title": "Has Transparent Button",
      "examples": [
        true,
        false
      ],
      "description": "Whether the button should be transparent"
    }
  }
}
```

**Output schema:**
```json
{
  "type": "object",
  "$defs": {
    "PatchThemeResponse": {
      "type": "object",
      "title": "PatchThemeResponse",
      "required": [
        "id",
        "name",
        "visibility",
        "has_transparent_button",
        "rounded_corners"
      ],
      "properties": {
        "id": {
          "type": "string",
          "title": "Id",
          "description": "Unique theme identifier"
        },
        "font": {
          "type": "string",
          "title": "Font",
          "description": "Typography selection"
        },
        "name": {
          "type": "string",
          "title": "Name",
          "description": "Theme name"
        },
        "colors": {
          "type": "object",
          "title": "Colors",
          "required": [
            "answer",
            "background",
            "button",
            "question"
          ],
          "properties": {
            "answer": {
              "type": "string",
              "title": "Answer",
              "description": "Hexadecimal color code for answers"
            },
            "button": {
              "type": "string",
              "title": "Button",
              "description": "Hexadecimal color code for buttons"
            },
            "question": {
              "type": "string",
              "title": "Question",
              "description": "Hexadecimal color code for questions"
            },
            "background": {
              "type": "string",
              "title": "Background",
              "description": "Hexadecimal color code for background"
            }
          },
          "description": "Colors configuration"
        },
        "fields": {
          "type": "object",
          "title": "Fields",
          "properties": {
            "alignment": {
              "type": "string",
              "title": "Alignment",
              "description": "Text alignment"
            },
            "font_size": {
              "type": "string",
              "title": "Font Size",
              "description": "Font size option"
            }
          },
          "description": "Fields configuration"
        },
        "screens": {
          "type": "object",
          "title": "Screens",
          "properties": {
            "alignment": {
              "type": "string",
              "title": "Alignment",
              "description": "Text alignment"
            },
            "font_size": {
              "type": "string",
              "title": "Font Size",
              "description": "Font size option"
            }
          },
          "description": "Screens configuration"
        },
        "background": {
          "type": "object",
          "title": "Background",
          "properties": {
            "href": {
              "type": "string",
              "title": "Href",
              "description": "URL of the background image"
            },
            "layout": {
              "type": "string",
              "title": "Layout",
              "description": "Background image layout style"
            },
            "brightness": {
              "type": "number",
              "title": "Brightness",
              "description": "Brightness level from -1 to 1"
            }
          },
          "description": "Background configuration"
        },
        "visibility": {
          "type": "string",
          "title": "Visibility",
          "description": "Theme visibility: 'public' or 'private'"
        },
        "rounded_corners": {
          "type": "string",
          "title": "Rounded Corners",
          "description": "Border radius style"
        },
        "has_transparent_button": {
          "type": "boolean",
          "title": "Has Transparent Button",
          "description": "Button transparency setting"
        }
      },
      "description": "Response containing the complete updated theme object."
    },
    "ColorsResponseObject": {
      "type": "object",
      "title": "ColorsResponseObject",
      "required": [
        "answer",
        "background",
        "button",
        "question"
      ],
      "properties": {
        "answer": {
          "type": "string",
          "title": "Answer",
          "description": "Hexadecimal color code for answers"
        },
        "button": {
          "type": "string",
          "title": "Button",
          "description": "Hexadecimal color code for buttons"
        },
        "question": {
          "type": "string",
          "title": "Question",
          "description": "Hexadecimal color code for questions"
        },
        "background": {
          "type": "string",
          "title": "Background",
          "description": "Hexadecimal color code for background"
        }
      },
      "description": "Colors configuration in the response."
    },
    "BackgroundResponseObject": {
      "type": "object",
      "title": "BackgroundResponseObject",
      "properties": {
        "href": {
          "type": "string",
          "title": "Href",
          "description": "URL of the background image"
        },
        "layout": {
          "type": "string",
          "title": "Layout",
          "description": "Background image layout style"
        },
        "brightness": {
          "type": "number",
          "title": "Brightness",
          "description": "Brightness level from -1 to 1"
        }
      },
      "description": "Background configuration in the response."
    },
    "FieldsScreensResponseObject": {
      "type": "object",
      "title": "FieldsScreensResponseObject",
      "properties": {
        "alignment": {
          "type": "string",
          "title": "Alignment",
          "description": "Text alignment"
        },
        "font_size": {
          "type": "string",
          "title": "Font Size",
          "description": "Font size option"
        }
      },
      "description": "Configuration for fields or screens in the response."
    }
  },
  "title": "PatchThemeResponseWrapper",
  "required": [
    "data",
    "successful"
  ],
  "properties": {
    "data": {
      "type": "object",
      "title": "Data",
      "required": [
        "id",
        "name",
        "visibility",
        "has_transparent_button",
        "rounded_corners"
      ],
      "properties": {
        "id": {
          "type": "string",
          "title": "Id",
          "description": "Unique theme identifier"
        },
        "font": {
          "type": "string",
          "title": "Font",
          "description": "Typography selection"
        },
        "name": {
          "type": "string",
          "title": "Name",
          "description": "Theme name"
        },
        "colors": {
          "type": "object",
          "title": "Colors",
          "required": [
            "answer",
            "background",
            "button",
            "question"
          ],
          "properties": {
            "answer": {
              "type": "string",
              "title": "Answer",
              "description": "Hexadecimal color code for answers"
            },
            "button": {
              "type": "string",
              "title": "Button",
              "description": "Hexadecimal color code for buttons"
            },
            "question": {
              "type": "string",
              "title": "Question",
              "description": "Hexadecimal color code for questions"
            },
            "background": {
              "type": "string",
              "title": "Background",
              "description": "Hexadecimal color code for background"
            }
          },
          "description": "Colors configuration"
        },
        "fields": {
          "type": "object",
          "title": "Fields",
          "properties": {
            "alignment": {
              "type": "string",
              "title": "Alignment",
              "description": "Text alignment"
            },
            "font_size": {
              "type": "string",
              "title": "Font Size",
              "description": "Font size option"
            }
          },
          "description": "Fields configuration"
        },
        "screens": {
          "type": "object",
          "title": "Screens",
          "properties": {
            "alignment": {
              "type": "string",
              "title": "Alignment",
              "description": "Text alignment"
            },
            "font_size": {
              "type": "string",
              "title": "Font Size",
              "description": "Font size option"
            }
          },
          "description": "Screens configuration"
        },
        "background": {
          "type": "object",
          "title": "Background",
          "properties": {
            "href": {
              "type": "string",
              "title": "Href",
              "description": "URL of the background image"
            },
            "layout": {
              "type": "string",
              "title": "Layout",
              "description": "Background image layout style"
            },
            "brightness": {
              "type": "number",
              "title": "Brightness",
              "description": "Brightness level from -1 to 1"
            }
          },
          "description": "Background configuration"
        },
        "visibility": {
          "type": "string",
          "title": "Visibility",
          "description": "Theme visibility: 'public' or 'private'"
        },
        "rounded_corners": {
          "type": "string",
          "title": "Rounded Corners",
          "description": "Border radius style"
        },
        "has_transparent_button": {
          "type": "boolean",
          "title": "Has Transparent Button",
          "description": "Button transparency setting"
        }
      },
      "description": "Data from the action execution"
    },
    "error": {
      "type": "string",
      "title": "Error",
      "description": "Error if any occurred during the execution of the action"
    },
    "successful": {
      "type": "boolean",
      "title": "Successful",
      "description": "Whether or not the action execution was successful or not"
    }
  }
}
```

## TYPEFORM_UPDATE_FORM
Tool to update an existing Typeform by completely replacing its configuration. PUT request overwrites the entire form - any fields not included will be deleted along with their response data. Always retrieve the form first using Get Form, modify the desired properties, then send the complete updated form definition.

**Input schema:**
```json
{
  "type": "object",
  "title": "TypeformUpdateFormRequest",
  "required": [
    "form_id"
  ],
  "properties": {
    "type": {
      "type": "string",
      "title": "Type",
      "examples": [
        "quiz",
        "form"
      ],
      "description": "Form type category such as 'quiz', 'classification', 'score', 'branching', etc."
    },
    "logic": {
      "type": "array",
      "items": {
        "type": "object",
        "additionalProperties": true
      },
      "title": "Logic",
      "description": "Array of logic jump objects for conditional branching. Each contains: type (field), ref (field reference), and actions (array with action, condition, and details)."
    },
    "theme": {
      "type": "object",
      "title": "Theme",
      "description": "Theme object containing 'href' field with theme URL to apply design styling to the form.",
      "additionalProperties": true
    },
    "title": {
      "type": "string",
      "title": "Title",
      "examples": [
        "Customer Feedback Form"
      ],
      "description": "The form's title/name"
    },
    "fields": {
      "type": "array",
      "items": {
        "type": "object",
        "additionalProperties": true
      },
      "title": "Fields",
      "description": "Array of form field objects defining questions and inputs. Each field must have: ref (unique reference), title (question text), type (field type like short_text, email, multiple_choice, etc.), properties (field-specific config), and optionally validations and attachments. Include all existing fields with their original 'id' values to preserve them."
    },
    "hidden": {
      "type": "array",
      "items": {
        "type": "string"
      },
      "title": "Hidden",
      "description": "Array of hidden field variable names for passing data via URL parameters."
    },
    "form_id": {
      "type": "string",
      "title": "Form Id",
      "examples": [
        "Y78g1cmS"
      ],
      "description": "Unique form identifier to update"
    },
    "settings": {
      "type": "object",
      "title": "Settings",
      "description": "Form settings object including language, is_public, progress_bar, show_progress_bar, show_typeform_branding, autosave_progress, hide_navigation, captcha, redirect_after_submit_url, meta (with allow_indexing, description, image), and tracking properties.",
      "additionalProperties": true
    },
    "variables": {
      "type": "object",
      "title": "Variables",
      "description": "Variables object for tracking score, price, or enrichment calculations.",
      "additionalProperties": true
    },
    "workspace": {
      "type": "object",
      "title": "Workspace",
      "description": "Workspace object containing 'href' field with workspace URL. If not specified, form remains in current workspace.",
      "additionalProperties": true
    },
    "welcome_screens": {
      "type": "array",
      "items": {
        "type": "object",
        "additionalProperties": true
      },
      "title": "Welcome Screens",
      "description": "Array of welcome screen objects shown before the form. Each contains: ref, title, properties, and optionally attachment."
    },
    "thankyou_screens": {
      "type": "array",
      "items": {
        "type": "object",
        "additionalProperties": true
      },
      "title": "Thankyou Screens",
      "description": "Array of thank you screen objects shown after form completion. Each contains: ref, title, type, properties (show_button, share_icons, button_mode, button_text), and optionally attachment."
    }
  }
}
```

**Output schema:**
```json
{
  "type": "object",
  "$defs": {
    "Choice": {
      "type": "object",
      "title": "Choice",
      "required": [
        "label"
      ],
      "properties": {
        "id": {
          "type": "string",
          "title": "Id",
          "description": "Unique identifier for the choice"
        },
        "ref": {
          "type": "string",
          "title": "Ref",
          "description": "Unique reference for the choice"
        },
        "label": {
          "type": "string",
          "title": "Label",
          "description": "Choice label text"
        },
        "attachment": {
          "type": "object",
          "title": "Attachment",
          "required": [
            "type",
            "href"
          ],
          "properties": {
            "href": {
              "type": "string",
              "title": "Href",
              "description": "URL to the attachment resource"
            },
            "type": {
              "type": "string",
              "title": "Type",
              "description": "Attachment type (image or video)"
            },
            "scale": {
              "type": "number",
              "title": "Scale",
              "description": "Scale of the attachment (0.4, 0.6, 0.8, or 1)"
            },
            "properties": {
              "type": "object",
              "title": "Properties",
              "properties": {
                "description": {
                  "type": "string",
                  "title": "Description",
                  "description": "Attachment description"
                }
              },
              "description": "Attachment properties"
            }
          },
          "description": "Attachment object"
        }
      },
      "description": "Choice option for choice-based fields"
    },
    "FormField": {
      "type": "object",
      "title": "FormField",
      "required": [
        "ref",
        "title",
        "type"
      ],
      "properties": {
        "id": {
          "type": "string",
          "title": "Id",
          "description": "Unique identifier"
        },
        "ref": {
          "type": "string",
          "title": "Ref",
          "description": "Unique reference string"
        },
        "type": {
          "type": "string",
          "title": "Type",
          "description": "Field type (short_text, email, multiple_choice, etc.)"
        },
        "title": {
          "type": "string",
          "title": "Title",
          "description": "Field title/question text"
        },
        "attachment": {
          "type": "object",
          "title": "Attachment",
          "required": [
            "type",
            "href"
          ],
          "properties": {
            "href": {
              "type": "string",
              "title": "Href",
              "description": "URL to the attachment resource"
            },
            "type": {
              "type": "string",
              "title": "Type",
              "description": "Attachment type (image or video)"
            },
            "scale": {
              "type": "number",
              "title": "Scale",
              "description": "Scale of the attachment (0.4, 0.6, 0.8, or 1)"
            },
            "properties": {
              "type": "object",
              "title": "Properties",
              "properties": {
                "description": {
                  "type": "string",
                  "title": "Description",
                  "description": "Attachment description"
                }
              },
              "description": "Attachment properties"
            }
          },
          "description": "Attachment object"
        },
        "properties": {
          "type": "object",
          "title": "Properties",
          "properties": {
            "shape": {
              "type": "string",
              "title": "Shape",
              "description": "Shape for rating fields"
            },
            "steps": {
              "type": "integer",
              "title": "Steps",
              "description": "Number of steps (5-11)"
            },
            "fields": {
              "type": "array",
              "items": {
                "type": "object",
                "additionalProperties": true
              },
              "title": "Fields",
              "description": "Nested fields for group/matrix/contact_info"
            },
            "labels": {
              "type": "object",
              "title": "Labels",
              "description": "Labels (left, right, center)",
              "additionalProperties": {
                "type": "string"
              }
            },
            "choices": {
              "type": "array",
              "items": {
                "type": "object",
                "title": "Choice",
                "required": [
                  "label"
                ],
                "properties": {
                  "id": {
                    "type": "string",
                    "title": "Id",
                    "description": "Unique identifier for the choice"
                  },
                  "ref": {
                    "type": "string",
                    "title": "Ref",
                    "description": "Unique reference for the choice"
                  },
                  "label": {
                    "type": "string",
                    "title": "Label",
                    "description": "Choice label text"
                  },
                  "attachment": {
                    "type": "object",
                    "title": "Attachment",
                    "required": [
                      "type",
                      "href"
                    ],
                    "properties": {
                      "href": {
                        "type": "string",
                        "title": "Href",
                        "description": "URL to the attachment resource"
                      },
                      "type": {
                        "type": "string",
                        "title": "Type",
                        "description": "Attachment type (image or video)"
                      },
                      "scale": {
                        "type": "number",
                        "title": "Scale",
                        "description": "Scale of the attachment (0.4, 0.6, 0.8, or 1)"
                      },
                      "properties": {
                        "type": "object",
                        "title": "Properties",
                        "properties": {
                          "description": {
                            "type": "string",
                            "title": "Description",
                            "description": "Attachment description"
                          }
                        },
                        "description": "Attachment properties"
                      }
                    },
                    "description": "Attachment object"
                  }
                },
                "description": "Choice option for choice-based fields"
              },
              "title": "Choices",
              "description": "List of choices"
            },
            "currency": {
              "type": "string",
              "title": "Currency",
              "description": "Currency code"
            },
            "randomize": {
              "type": "boolean",
              "title": "Randomize",
              "description": "Whether to randomize choice order"
            },
            "separator": {
              "type": "string",
              "title": "Separator",
              "description": "Date separator (/, -, .)"
            },
            "structure": {
              "type": "string",
              "title": "Structure",
              "description": "Date structure (DDMMYYYY, MMDDYYYY, YYYYMMDD)"
            },
            "hide_marks": {
              "type": "boolean",
              "title": "Hide Marks",
              "description": "Whether to hide marks"
            },
            "supersized": {
              "type": "boolean",
              "title": "Supersized",
              "description": "Whether to use supersized"
            },
            "button_text": {
              "type": "string",
              "title": "Button Text",
              "description": "Button text"
            },
            "description": {
              "type": "string",
              "title": "Description",
              "description": "Field description"
            },
            "show_labels": {
              "type": "boolean",
              "title": "Show Labels",
              "description": "Whether to show labels"
            },
            "start_at_one": {
              "type": "boolean",
              "title": "Start At One",
              "description": "Whether to start at one"
            },
            "allow_other_choice": {
              "type": "boolean",
              "title": "Allow Other Choice",
              "description": "Whether to allow 'Other' choice"
            },
            "alphabetical_order": {
              "type": "boolean",
              "title": "Alphabetical Order",
              "description": "Whether to sort alphabetically"
            },
            "vertical_alignment": {
              "type": "boolean",
              "title": "Vertical Alignment",
              "description": "Whether to use vertical alignment"
            },
            "allow_multiple_selection": {
              "type": "boolean",
              "title": "Allow Multiple Selection",
              "description": "Whether multiple selections are allowed"
            }
          },
          "description": "Field properties"
        },
        "validations": {
          "type": "object",
          "title": "Validations",
          "properties": {
            "required": {
              "type": "boolean",
              "title": "Required",
              "description": "Whether the field is required"
            },
            "max_value": {
              "type": "number",
              "title": "Max Value",
              "description": "Maximum value"
            },
            "min_value": {
              "type": "number",
              "title": "Min Value",
              "description": "Minimum value"
            },
            "max_length": {
              "type": "integer",
              "title": "Max Length",
              "description": "Maximum length"
            },
            "max_selection": {
              "type": "integer",
              "title": "Max Selection",
              "description": "Maximum selection count"
            },
            "min_selection": {
              "type": "integer",
              "title": "Min Selection",
              "description": "Minimum selection count"
            }
          },
          "description": "Validation rules"
        }
      },
      "description": "Form field object"
    },
    "LogicJump": {
      "type": "object",
      "title": "LogicJump",
      "required": [
        "type",
        "ref",
        "actions"
      ],
      "properties": {
        "ref": {
          "type": "string",
          "title": "Ref",
          "description": "Reference to field or hidden variable"
        },
        "type": {
          "type": "string",
          "title": "Type",
          "description": "Logic type (field or hidden)"
        },
        "actions": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "LogicAction",
            "required": [
              "action",
              "condition"
            ],
            "properties": {
              "action": {
                "type": "string",
                "title": "Action",
                "description": "Action type (jump, add, subtract, multiply, divide, set)"
              },
              "details": {
                "type": "object",
                "title": "Details",
                "properties": {
                  "to": {
                    "type": "object",
                    "title": "To",
                    "description": "Jump target",
                    "additionalProperties": true
                  },
                  "value": {
                    "type": "object",
                    "title": "Value",
                    "description": "Value to set",
                    "additionalProperties": true
                  },
                  "target": {
                    "type": "object",
                    "title": "Target",
                    "description": "Target for variable operations",
                    "additionalProperties": true
                  }
                },
                "description": "Action details"
              },
              "condition": {
                "type": "object",
                "title": "Condition",
                "required": [
                  "op",
                  "vars"
                ],
                "properties": {
                  "op": {
                    "type": "string",
                    "title": "Op",
                    "description": "Operator (is, is_not, equal, greater_than, contains, etc.)"
                  },
                  "vars": {
                    "type": "array",
                    "items": {
                      "type": "object",
                      "title": "LogicConditionVar",
                      "required": [
                        "type",
                        "value"
                      ],
                      "properties": {
                        "type": {
                          "type": "string",
                          "title": "Type",
                          "description": "Variable type (field, hidden, variable, constant, choice)"
                        },
                        "value": {
                          "title": "Value",
                          "description": "Variable value"
                        }
                      },
                      "description": "Variable in logic condition"
                    },
                    "title": "Vars",
                    "description": "List of variables in the condition"
                  }
                },
                "description": "Condition to evaluate"
              }
            },
            "description": "Action to take when condition is met"
          },
          "title": "Actions",
          "description": "List of actions to execute"
        }
      },
      "description": "Logic jump object for conditional branching"
    },
    "Attachment": {
      "type": "object",
      "title": "Attachment",
      "required": [
        "type",
        "href"
      ],
      "properties": {
        "href": {
          "type": "string",
          "title": "Href",
          "description": "URL to the attachment resource"
        },
        "type": {
          "type": "string",
          "title": "Type",
          "description": "Attachment type (image or video)"
        },
        "scale": {
          "type": "number",
          "title": "Scale",
          "description": "Scale of the attachment (0.4, 0.6, 0.8, or 1)"
        },
        "properties": {
          "type": "object",
          "title": "Properties",
          "properties": {
            "description": {
              "type": "string",
              "title": "Description",
              "description": "Attachment description"
            }
          },
          "description": "Attachment properties"
        }
      },
      "description": "Attachment object for fields and screens"
    },
    "LogicAction": {
      "type": "object",
      "title": "LogicAction",
      "required": [
        "action",
        "condition"
      ],
      "properties": {
        "action": {
          "type": "string",
          "title": "Action",
          "description": "Action type (jump, add, subtract, multiply, divide, set)"
        },
        "details": {
          "type": "object",
          "title": "Details",
          "properties": {
            "to": {
              "type": "object",
              "title": "To",
              "description": "Jump target",
              "additionalProperties": true
            },
            "value": {
              "type": "object",
              "title": "Value",
              "description": "Value to set",
              "additionalProperties": true
            },
            "target": {
              "type": "object",
              "title": "Target",
              "description": "Target for variable operations",
              "additionalProperties": true
            }
          },
          "description": "Action details"
        },
        "condition": {
          "type": "object",
          "title": "Condition",
          "required": [
            "op",
            "vars"
          ],
          "properties": {
            "op": {
              "type": "string",
              "title": "Op",
              "description": "Operator (is, is_not, equal, greater_than, contains, etc.)"
            },
            "vars": {
              "type": "array",
              "items": {
                "type": "object",
                "title": "LogicConditionVar",
                "required": [
                  "type",
                  "value"
                ],
                "properties": {
                  "type": {
                    "type": "string",
                    "title": "Type",
                    "description": "Variable type (field, hidden, variable, constant, choice)"
                  },
                  "value": {
                    "title": "Value",
                    "description": "Variable value"
                  }
                },
                "description": "Variable in logic condition"
              },
              "title": "Vars",
              "description": "List of variables in the condition"
            }
          },
          "description": "Condition to evaluate"
        }
      },
      "description": "Action to take when condition is met"
    },
    "FormSettings": {
      "type": "object",
      "title": "FormSettings",
      "properties": {
        "meta": {
          "type": "object",
          "title": "Meta",
          "properties": {
            "image": {
              "type": "object",
              "title": "Image",
              "description": "Meta image with href",
              "additionalProperties": {
                "type": "string"
              }
            },
            "title": {
              "type": "string",
              "title": "Title",
              "description": "Meta title"
            },
            "description": {
              "type": "string",
              "title": "Description",
              "description": "Meta description"
            },
            "allow_indexing": {
              "type": "boolean",
              "title": "Allow Indexing",
              "description": "Whether to allow search engine indexing"
            },
            "facebook_pixel": {
              "type": "string",
              "title": "Facebook Pixel",
              "description": "Facebook Pixel tracking ID"
            },
            "google_analytics": {
              "type": "string",
              "title": "Google Analytics",
              "description": "Google Analytics tracking ID"
            },
            "google_tag_manager": {
              "type": "string",
              "title": "Google Tag Manager",
              "description": "Google Tag Manager ID"
            },
            "redirect_after_submit_url": {
              "type": "string",
              "title": "Redirect After Submit Url",
              "description": "URL to redirect to after form submission"
            }
          },
          "description": "Metadata settings"
        },
        "captcha": {
          "type": "boolean",
          "title": "Captcha",
          "description": "Whether captcha is enabled"
        },
        "is_trial": {
          "type": "boolean",
          "title": "Is Trial",
          "description": "Whether the form is in trial mode"
        },
        "language": {
          "type": "string",
          "title": "Language",
          "description": "Language code (e.g., en, es)"
        },
        "is_public": {
          "type": "boolean",
          "title": "Is Public",
          "description": "Whether the form is publicly accessible"
        },
        "progress_bar": {
          "type": "string",
          "title": "Progress Bar",
          "description": "Progress bar style (proportion or percentage)"
        },
        "auto_translate": {
          "type": "boolean",
          "title": "Auto Translate",
          "description": "Whether to enable automatic translation"
        },
        "hide_navigation": {
          "type": "boolean",
          "title": "Hide Navigation",
          "description": "Whether to hide navigation buttons"
        },
        "autosave_progress": {
          "type": "boolean",
          "title": "Autosave Progress",
          "description": "Whether to auto-save respondent progress"
        },
        "show_progress_bar": {
          "type": "boolean",
          "title": "Show Progress Bar",
          "description": "Whether to display the progress bar"
        },
        "are_uploads_public": {
          "type": "boolean",
          "title": "Are Uploads Public",
          "description": "Whether file uploads are publicly accessible"
        },
        "show_cookie_consent": {
          "type": "boolean",
          "title": "Show Cookie Consent",
          "description": "Whether to show cookie consent banner"
        },
        "free_form_navigation": {
          "type": "boolean",
          "title": "Free Form Navigation",
          "description": "Whether to allow free-form navigation"
        },
        "show_question_number": {
          "type": "boolean",
          "title": "Show Question Number",
          "description": "Whether to show question numbers"
        },
        "pro_subdomain_enabled": {
          "type": "boolean",
          "title": "Pro Subdomain Enabled",
          "description": "Whether pro subdomain is enabled"
        },
        "show_time_to_complete": {
          "type": "boolean",
          "title": "Show Time To Complete",
          "description": "Whether to show estimated completion time"
        },
        "show_typeform_branding": {
          "type": "boolean",
          "title": "Show Typeform Branding",
          "description": "Whether to show Typeform branding"
        },
        "use_lead_qualification": {
          "type": "boolean",
          "title": "Use Lead Qualification",
          "description": "Whether to use lead qualification"
        },
        "show_key_hint_on_choices": {
          "type": "boolean",
          "title": "Show Key Hint On Choices",
          "description": "Whether to show keyboard hints on choices"
        },
        "show_number_of_submissions": {
          "type": "boolean",
          "title": "Show Number Of Submissions",
          "description": "Whether to show number of submissions"
        },
        "partial_responses_to_all_integrations": {
          "type": "boolean",
          "title": "Partial Responses To All Integrations",
          "description": "Whether to send partial responses to all integrations"
        }
      },
      "description": "Form settings object"
    },
    "LinksResponse": {
      "type": "object",
      "title": "LinksResponse",
      "properties": {
        "edit": {
          "type": "string",
          "title": "Edit",
          "description": "URI to edit form"
        },
        "json": {
          "type": "string",
          "title": "Json",
          "description": "URI for JSON export"
        },
        "self": {
          "type": "string",
          "title": "Self",
          "description": "URI for API access"
        },
        "display": {
          "type": "string",
          "title": "Display",
          "description": "URI to display the form"
        },
        "results": {
          "type": "string",
          "title": "Results",
          "description": "URI for results"
        },
        "responses": {
          "type": "string",
          "title": "Responses",
          "description": "URI for form responses"
        }
      },
      "description": "Form links object"
    },
    "ThemeResponse": {
      "type": "object",
      "title": "ThemeResponse",
      "required": [
        "href"
      ],
      "properties": {
        "href": {
          "type": "string",
          "title": "Href",
          "description": "URL reference to the theme"
        }
      },
      "description": "Theme reference object"
    },
    "WelcomeScreen": {
      "type": "object",
      "title": "WelcomeScreen",
      "required": [
        "ref",
        "title"
      ],
      "properties": {
        "id": {
          "type": "string",
          "title": "Id",
          "description": "Unique identifier"
        },
        "ref": {
          "type": "string",
          "title": "Ref",
          "description": "Unique reference string"
        },
        "title": {
          "type": "string",
          "title": "Title",
          "description": "Welcome screen title"
        },
        "attachment": {
          "type": "object",
          "title": "Attachment",
          "required": [
            "type",
            "href"
          ],
          "properties": {
            "href": {
              "type": "string",
              "title": "Href",
              "description": "URL to the attachment resource"
            },
            "type": {
              "type": "string",
              "title": "Type",
              "description": "Attachment type (image or video)"
            },
            "scale": {
              "type": "number",
              "title": "Scale",
              "description": "Scale of the attachment (0.4, 0.6, 0.8, or 1)"
            },
            "properties": {
              "type": "object",
              "title": "Properties",
              "properties": {
                "description": {
                  "type": "string",
                  "title": "Description",
                  "description": "Attachment description"
                }
              },
              "description": "Attachment properties"
            }
          },
          "description": "Attachment object"
        },
        "properties": {
          "type": "object",
          "title": "Properties",
          "properties": {
            "button_text": {
              "type": "string",
              "title": "Button Text",
              "description": "Button text"
            },
            "description": {
              "type": "string",
              "title": "Description",
              "description": "Welcome screen description"
            },
            "show_button": {
              "type": "boolean",
              "title": "Show Button",
              "description": "Whether to show the button"
            }
          },
          "description": "Welcome screen properties"
        }
      },
      "description": "Welcome screen object"
    },
    "LogicCondition": {
      "type": "object",
      "title": "LogicCondition",
      "required": [
        "op",
        "vars"
      ],
      "properties": {
        "op": {
          "type": "string",
          "title": "Op",
          "description": "Operator (is, is_not, equal, greater_than, contains, etc.)"
        },
        "vars": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "LogicConditionVar",
            "required": [
              "type",
              "value"
            ],
            "properties": {
              "type": {
                "type": "string",
                "title": "Type",
                "description": "Variable type (field, hidden, variable, constant, choice)"
              },
              "value": {
                "title": "Value",
                "description": "Variable value"
              }
            },
            "description": "Variable in logic condition"
          },
          "title": "Vars",
          "description": "List of variables in the condition"
        }
      },
      "description": "Condition for logic jump"
    },
    "ThankYouScreen": {
      "type": "object",
      "title": "ThankYouScreen",
      "required": [
        "ref",
        "title"
      ],
      "properties": {
        "id": {
          "type": "string",
          "title": "Id",
          "description": "Unique identifier"
        },
        "ref": {
          "type": "string",
          "title": "Ref",
          "description": "Unique reference string"
        },
        "type": {
          "type": "string",
          "title": "Type",
          "description": "Screen type (thankyou_screen or url_redirect)"
        },
        "title": {
          "type": "string",
          "title": "Title",
          "description": "Thank you screen title"
        },
        "attachment": {
          "type": "object",
          "title": "Attachment",
          "required": [
            "type",
            "href"
          ],
          "properties": {
            "href": {
              "type": "string",
              "title": "Href",
              "description": "URL to the attachment resource"
            },
            "type": {
              "type": "string",
              "title": "Type",
              "description": "Attachment type (image or video)"
            },
            "scale": {
              "type": "number",
              "title": "Scale",
              "description": "Scale of the attachment (0.4, 0.6, 0.8, or 1)"
            },
            "properties": {
              "type": "object",
              "title": "Properties",
              "properties": {
                "description": {
                  "type": "string",
                  "title": "Description",
                  "description": "Attachment description"
                }
              },
              "description": "Attachment properties"
            }
          },
          "description": "Attachment object"
        },
        "properties": {
          "type": "object",
          "title": "Properties",
          "properties": {
            "button_mode": {
              "type": "string",
              "title": "Button Mode",
              "description": "Button mode (reload, default_redirect, or redirect)"
            },
            "button_text": {
              "type": "string",
              "title": "Button Text",
              "description": "Button text"
            },
            "share_icons": {
              "type": "boolean",
              "title": "Share Icons",
              "description": "Whether to show share icons"
            },
            "show_button": {
              "type": "boolean",
              "title": "Show Button",
              "description": "Whether to show the button"
            },
            "redirect_url": {
              "type": "string",
              "title": "Redirect Url",
              "description": "Redirect URL"
            }
          },
          "description": "Thank you screen properties"
        }
      },
      "description": "Thank you screen object"
    },
    "FieldProperties": {
      "type": "object",
      "title": "FieldProperties",
      "properties": {
        "shape": {
          "type": "string",
          "title": "Shape",
          "description": "Shape for rating fields"
        },
        "steps": {
          "type": "integer",
          "title": "Steps",
          "description": "Number of steps (5-11)"
        },
        "fields": {
          "type": "array",
          "items": {
            "type": "object",
            "additionalProperties": true
          },
          "title": "Fields",
          "description": "Nested fields for group/matrix/contact_info"
        },
        "labels": {
          "type": "object",
          "title": "Labels",
          "description": "Labels (left, right, center)",
          "additionalProperties": {
            "type": "string"
          }
        },
        "choices": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "Choice",
            "required": [
              "label"
            ],
            "properties": {
              "id": {
                "type": "string",
                "title": "Id",
                "description": "Unique identifier for the choice"
              },
              "ref": {
                "type": "string",
                "title": "Ref",
                "description": "Unique reference for the choice"
              },
              "label": {
                "type": "string",
                "title": "Label",
                "description": "Choice label text"
              },
              "attachment": {
                "type": "object",
                "title": "Attachment",
                "required": [
                  "type",
                  "href"
                ],
                "properties": {
                  "href": {
                    "type": "string",
                    "title": "Href",
                    "description": "URL to the attachment resource"
                  },
                  "type": {
                    "type": "string",
                    "title": "Type",
                    "description": "Attachment type (image or video)"
                  },
                  "scale": {
                    "type": "number",
                    "title": "Scale",
                    "description": "Scale of the attachment (0.4, 0.6, 0.8, or 1)"
                  },
                  "properties": {
                    "type": "object",
                    "title": "Properties",
                    "properties": {
                      "description": {
                        "type": "string",
                        "title": "Description",
                        "description": "Attachment description"
                      }
                    },
                    "description": "Attachment properties"
                  }
                },
                "description": "Attachment object"
              }
            },
            "description": "Choice option for choice-based fields"
          },
          "title": "Choices",
          "description": "List of choices"
        },
        "currency": {
          "type": "string",
          "title": "Currency",
          "description": "Currency code"
        },
        "randomize": {
          "type": "boolean",
          "title": "Randomize",
          "description": "Whether to randomize choice order"
        },
        "separator": {
          "type": "string",
          "title": "Separator",
          "description": "Date separator (/, -, .)"
        },
        "structure": {
          "type": "string",
          "title": "Structure",
          "description": "Date structure (DDMMYYYY, MMDDYYYY, YYYYMMDD)"
        },
        "hide_marks": {
          "type": "boolean",
          "title": "Hide Marks",
          "description": "Whether to hide marks"
        },
        "supersized": {
          "type": "boolean",
          "title": "Supersized",
          "description": "Whether to use supersized"
        },
        "button_text": {
          "type": "string",
          "title": "Button Text",
          "description": "Button text"
        },
        "description": {
          "type": "string",
          "title": "Description",
          "description": "Field description"
        },
        "show_labels": {
          "type": "boolean",
          "title": "Show Labels",
          "description": "Whether to show labels"
        },
        "start_at_one": {
          "type": "boolean",
          "title": "Start At One",
          "description": "Whether to start at one"
        },
        "allow_other_choice": {
          "type": "boolean",
          "title": "Allow Other Choice",
          "description": "Whether to allow 'Other' choice"
        },
        "alphabetical_order": {
          "type": "boolean",
          "title": "Alphabetical Order",
          "description": "Whether to sort alphabetically"
        },
        "vertical_alignment": {
          "type": "boolean",
          "title": "Vertical Alignment",
          "description": "Whether to use vertical alignment"
        },
        "allow_multiple_selection": {
          "type": "boolean",
          "title": "Allow Multiple Selection",
          "description": "Whether multiple selections are allowed"
        }
      },
      "description": "Field properties (varies by field type)"
    },
    "FieldValidations": {
      "type": "object",
      "title": "FieldValidations",
      "properties": {
        "required": {
          "type": "boolean",
          "title": "Required",
          "description": "Whether the field is required"
        },
        "max_value": {
          "type": "number",
          "title": "Max Value",
          "description": "Maximum value"
        },
        "min_value": {
          "type": "number",
          "title": "Min Value",
          "description": "Minimum value"
        },
        "max_length": {
          "type": "integer",
          "title": "Max Length",
          "description": "Maximum length"
        },
        "max_selection": {
          "type": "integer",
          "title": "Max Selection",
          "description": "Maximum selection count"
        },
        "min_selection": {
          "type": "integer",
          "title": "Min Selection",
          "description": "Minimum selection count"
        }
      },
      "description": "Field validation rules"
    },
    "LogicConditionVar": {
      "type": "object",
      "title": "LogicConditionVar",
      "required": [
        "type",
        "value"
      ],
      "properties": {
        "type": {
          "type": "string",
          "title": "Type",
          "description": "Variable type (field, hidden, variable, constant, choice)"
        },
        "value": {
          "title": "Value",
          "description": "Variable value"
        }
      },
      "description": "Variable in logic condition"
    },
    "WorkspaceResponse": {
      "type": "object",
      "title": "WorkspaceResponse",
      "required": [
        "href"
      ],
      "properties": {
        "href": {
          "type": "string",
          "title": "Href",
          "description": "URL reference to the workspace"
        }
      },
      "description": "Workspace reference object"
    },
    "LogicActionDetails": {
      "type": "object",
      "title": "LogicActionDetails",
      "properties": {
        "to": {
          "type": "object",
          "title": "To",
          "description": "Jump target",
          "additionalProperties": true
        },
        "value": {
          "type": "object",
          "title": "Value",
          "description": "Value to set",
          "additionalProperties": true
        },
        "target": {
          "type": "object",
          "title": "Target",
          "description": "Target for variable operations",
          "additionalProperties": true
        }
      },
      "description": "Details for logic action"
    },
    "AttachmentProperties": {
      "type": "object",
      "title": "AttachmentProperties",
      "properties": {
        "description": {
          "type": "string",
          "title": "Description",
          "description": "Attachment description"
        }
      },
      "description": "Attachment properties"
    },
    "FormSettingsMetadata": {
      "type": "object",
      "title": "FormSettingsMetadata",
      "properties": {
        "image": {
          "type": "object",
          "title": "Image",
          "description": "Meta image with href",
          "additionalProperties": {
            "type": "string"
          }
        },
        "title": {
          "type": "string",
          "title": "Title",
          "description": "Meta title"
        },
        "description": {
          "type": "string",
          "title": "Description",
          "description": "Meta description"
        },
        "allow_indexing": {
          "type": "boolean",
          "title": "Allow Indexing",
          "description": "Whether to allow search engine indexing"
        },
        "facebook_pixel": {
          "type": "string",
          "title": "Facebook Pixel",
          "description": "Facebook Pixel tracking ID"
        },
        "google_analytics": {
          "type": "string",
          "title": "Google Analytics",
          "description": "Google Analytics tracking ID"
        },
        "google_tag_manager": {
          "type": "string",
          "title": "Google Tag Manager",
          "description": "Google Tag Manager ID"
        },
        "redirect_after_submit_url": {
          "type": "string",
          "title": "Redirect After Submit Url",
          "description": "URL to redirect to after form submission"
        }
      },
      "description": "Metadata settings for a form"
    },
    "WelcomeScreenProperties": {
      "type": "object",
      "title": "WelcomeScreenProperties",
      "properties": {
        "button_text": {
          "type": "string",
          "title": "Button Text",
          "description": "Button text"
        },
        "description": {
          "type": "string",
          "title": "Description",
          "description": "Welcome screen description"
        },
        "show_button": {
          "type": "boolean",
          "title": "Show Button",
          "description": "Whether to show the button"
        }
      },
      "description": "Welcome screen properties"
    },
    "ThankYouScreenProperties": {
      "type": "object",
      "title": "ThankYouScreenProperties",
      "properties": {
        "button_mode": {
          "type": "string",
          "title": "Button Mode",
          "description": "Button mode (reload, default_redirect, or redirect)"
        },
        "button_text": {
          "type": "string",
          "title": "Button Text",
          "description": "Button text"
        },
        "share_icons": {
          "type": "boolean",
          "title": "Share Icons",
          "description": "Whether to show share icons"
        },
        "show_button": {
          "type": "boolean",
          "title": "Show Button",
          "description": "Whether to show the button"
        },
        "redirect_url": {
          "type": "string",
          "title": "Redirect Url",
          "description": "Redirect URL"
        }
      },
      "description": "Thank you screen properties"
    },
    "TypeformUpdateFormResponse": {
      "type": "object",
      "title": "TypeformUpdateFormResponse",
      "properties": {
        "id": {
          "type": "string",
          "title": "Id",
          "description": "Unique identifier of the updated form"
        },
        "type": {
          "type": "string",
          "title": "Type",
          "description": "Form type category"
        },
        "logic": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "LogicJump",
            "required": [
              "type",
              "ref",
              "actions"
            ],
            "properties": {
              "ref": {
                "type": "string",
                "title": "Ref",
                "description": "Reference to field or hidden variable"
              },
              "type": {
                "type": "string",
                "title": "Type",
                "description": "Logic type (field or hidden)"
              },
              "actions": {
                "type": "array",
                "items": {
                  "type": "object",
                  "title": "LogicAction",
                  "required": [
                    "action",
                    "condition"
                  ],
                  "properties": {
                    "action": {
                      "type": "string",
                      "title": "Action",
                      "description": "Action type (jump, add, subtract, multiply, divide, set)"
                    },
                    "details": {
                      "type": "object",
                      "title": "Details",
                      "properties": {
                        "to": {
                          "type": "object",
                          "title": "To",
                          "description": "Jump target",
                          "additionalProperties": true
                        },
                        "value": {
                          "type": "object",
                          "title": "Value",
                          "description": "Value to set",
                          "additionalProperties": true
                        },
                        "target": {
                          "type": "object",
                          "title": "Target",
                          "description": "Target for variable operations",
                          "additionalProperties": true
                        }
                      },
                      "description": "Action details"
                    },
                    "condition": {
                      "type": "object",
                      "title": "Condition",
                      "required": [
                        "op",
                        "vars"
                      ],
                      "properties": {
                        "op": {
                          "type": "string",
                          "title": "Op",
                          "description": "Operator (is, is_not, equal, greater_than, contains, etc.)"
                        },
                        "vars": {
                          "type": "array",
                          "items": {
                            "type": "object",
                            "title": "LogicConditionVar",
                            "required": [
                              "type",
                              "value"
                            ],
                            "properties": {
                              "type": {
                                "type": "string",
                                "title": "Type",
                                "description": "Variable type (field, hidden, variable, constant, choice)"
                              },
                              "value": {
                                "title": "Value",
                                "description": "Variable value"
                              }
                            },
                            "description": "Variable in logic condition"
                          },
                          "title": "Vars",
                          "description": "List of variables in the condition"
                        }
                      },
                      "description": "Condition to evaluate"
                    }
                  },
                  "description": "Action to take when condition is met"
                },
                "title": "Actions",
                "description": "List of actions to execute"
              }
            },
            "description": "Logic jump object for conditional branching"
          },
          "title": "Logic",
          "description": "Logic jumps configuration"
        },
        "theme": {
          "type": "object",
          "title": "Theme",
          "required": [
            "href"
          ],
          "properties": {
            "href": {
              "type": "string",
              "title": "Href",
              "description": "URL reference to the theme"
            }
          },
          "description": "Theme configuration"
        },
        "title": {
          "type": "string",
          "title": "Title",
          "description": "Title of the form"
        },
        "_links": {
          "type": "object",
          "title": " Links",
          "properties": {
            "edit": {
              "type": "string",
              "title": "Edit",
              "description": "URI to edit form"
            },
            "json": {
              "type": "string",
              "title": "Json",
              "description": "URI for JSON export"
            },
            "self": {
              "type": "string",
              "title": "Self",
              "description": "URI for API access"
            },
            "display": {
              "type": "string",
              "title": "Display",
              "description": "URI to display the form"
            },
            "results": {
              "type": "string",
              "title": "Results",
              "description": "URI for results"
            },
            "responses": {
              "type": "string",
              "title": "Responses",
              "description": "URI for form responses"
            }
          },
          "description": "Related links"
        },
        "fields": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "FormField",
            "required": [
              "ref",
              "title",
              "type"
            ],
            "properties": {
              "id": {
                "type": "string",
                "title": "Id",
                "description": "Unique identifier"
              },
              "ref": {
                "type": "string",
                "title": "Ref",
                "description": "Unique reference string"
              },
              "type": {
                "type": "string",
                "title": "Type",
                "description": "Field type (short_text, email, multiple_choice, etc.)"
              },
              "title": {
                "type": "string",
                "title": "Title",
                "description": "Field title/question text"
              },
              "attachment": {
                "type": "object",
                "title": "Attachment",
                "required": [
                  "type",
                  "href"
                ],
                "properties": {
                  "href": {
                    "type": "string",
                    "title": "Href",
                    "description": "URL to the attachment resource"
                  },
                  "type": {
                    "type": "string",
                    "title": "Type",
                    "description": "Attachment type (image or video)"
                  },
                  "scale": {
                    "type": "number",
                    "title": "Scale",
                    "description": "Scale of the attachment (0.4, 0.6, 0.8, or 1)"
                  },
                  "properties": {
                    "type": "object",
                    "title": "Properties",
                    "properties": {
                      "description": {
                        "type": "string",
                        "title": "Description",
                        "description": "Attachment description"
                      }
                    },
                    "description": "Attachment properties"
                  }
                },
                "description": "Attachment object"
              },
              "properties": {
                "type": "object",
                "title": "Properties",
                "properties": {
                  "shape": {
                    "type": "string",
                    "title": "Shape",
                    "description": "Shape for rating fields"
                  },
                  "steps": {
                    "type": "integer",
                    "title": "Steps",
                    "description": "Number of steps (5-11)"
                  },
                  "fields": {
                    "type": "array",
                    "items": {
                      "type": "object",
                      "additionalProperties": true
                    },
                    "title": "Fields",
                    "description": "Nested fields for group/matrix/contact_info"
                  },
                  "labels": {
                    "type": "object",
                    "title": "Labels",
                    "description": "Labels (left, right, center)",
                    "additionalProperties": {
                      "type": "string"
                    }
                  },
                  "choices": {
                    "type": "array",
                    "items": {
                      "type": "object",
                      "title": "Choice",
                      "required": [
                        "label"
                      ],
                      "properties": {
                        "id": {
                          "type": "string",
                          "title": "Id",
                          "description": "Unique identifier for the choice"
                        },
                        "ref": {
                          "type": "string",
                          "title": "Ref",
                          "description": "Unique reference for the choice"
                        },
                        "label": {
                          "type": "string",
                          "title": "Label",
                          "description": "Choice label text"
                        },
                        "attachment": {
                          "type": "object",
                          "title": "Attachment",
                          "required": [
                            "type",
                            "href"
                          ],
                          "properties": {
                            "href": {
                              "type": "string",
                              "title": "Href",
                              "description": "URL to the attachment resource"
                            },
                            "type": {
                              "type": "string",
                              "title": "Type",
                              "description": "Attachment type (image or video)"
                            },
                            "scale": {
                              "type": "number",
                              "title": "Scale",
                              "description": "Scale of the attachment (0.4, 0.6, 0.8, or 1)"
                            },
                            "properties": {
                              "type": "object",
                              "title": "Properties",
                              "properties": {
                                "description": {
                                  "type": "string",
                                  "title": "Description",
                                  "description": "Attachment description"
                                }
                              },
                              "description": "Attachment properties"
                            }
                          },
                          "description": "Attachment object"
                        }
                      },
                      "description": "Choice option for choice-based fields"
                    },
                    "title": "Choices",
                    "description": "List of choices"
                  },
                  "currency": {
                    "type": "string",
                    "title": "Currency",
                    "description": "Currency code"
                  },
                  "randomize": {
                    "type": "boolean",
                    "title": "Randomize",
                    "description": "Whether to randomize choice order"
                  },
                  "separator": {
                    "type": "string",
                    "title": "Separator",
                    "description": "Date separator (/, -, .)"
                  },
                  "structure": {
                    "type": "string",
                    "title": "Structure",
                    "description": "Date structure (DDMMYYYY, MMDDYYYY, YYYYMMDD)"
                  },
                  "hide_marks": {
                    "type": "boolean",
                    "title": "Hide Marks",
                    "description": "Whether to hide marks"
                  },
                  "supersized": {
                    "type": "boolean",
                    "title": "Supersized",
                    "description": "Whether to use supersized"
                  },
                  "button_text": {
                    "type": "string",
                    "title": "Button Text",
                    "description": "Button text"
                  },
                  "description": {
                    "type": "string",
                    "title": "Description",
                    "description": "Field description"
                  },
                  "show_labels": {
                    "type": "boolean",
                    "title": "Show Labels",
                    "description": "Whether to show labels"
                  },
                  "start_at_one": {
                    "type": "boolean",
                    "title": "Start At One",
                    "description": "Whether to start at one"
                  },
                  "allow_other_choice": {
                    "type": "boolean",
                    "title": "Allow Other Choice",
                    "description": "Whether to allow 'Other' choice"
                  },
                  "alphabetical_order": {
                    "type": "boolean",
                    "title": "Alphabetical Order",
                    "description": "Whether to sort alphabetically"
                  },
                  "vertical_alignment": {
                    "type": "boolean",
                    "title": "Vertical Alignment",
                    "description": "Whether to use vertical alignment"
                  },
                  "allow_multiple_selection": {
                    "type": "boolean",
                    "title": "Allow Multiple Selection",
                    "description": "Whether multiple selections are allowed"
                  }
                },
                "description": "Field properties"
              },
              "validations": {
                "type": "object",
                "title": "Validations",
                "properties": {
                  "required": {
                    "type": "boolean",
                    "title": "Required",
                    "description": "Whether the field is required"
                  },
                  "max_value": {
                    "type": "number",
                    "title": "Max Value",
                    "description": "Maximum value"
                  },
                  "min_value": {
                    "type": "number",
                    "title": "Min Value",
                    "description": "Minimum value"
                  },
                  "max_length": {
                    "type": "integer",
                    "title": "Max Length",
                    "description": "Maximum length"
                  },
                  "max_selection": {
                    "type": "integer",
                    "title": "Max Selection",
                    "description": "Maximum selection count"
                  },
                  "min_selection": {
                    "type": "integer",
                    "title": "Min Selection",
                    "description": "Minimum selection count"
                  }
                },
                "description": "Validation rules"
              }
            },
            "description": "Form field object"
          },
          "title": "Fields",
          "description": "List of form fields with their configurations"
        },
        "hidden": {
          "type": "array",
          "items": {
            "type": "string"
          },
          "title": "Hidden",
          "description": "List of hidden field variable names"
        },
        "language": {
          "type": "string",
          "title": "Language",
          "description": "Language code of the form"
        },
        "settings": {
          "type": "object",
          "title": "Settings",
          "properties": {
            "meta": {
              "type": "object",
              "title": "Meta",
              "properties": {
                "image": {
                  "type": "object",
                  "title": "Image",
                  "description": "Meta image with href",
                  "additionalProperties": {
                    "type": "string"
                  }
                },
                "title": {
                  "type": "string",
                  "title": "Title",
                  "description": "Meta title"
                },
                "description": {
                  "type": "string",
                  "title": "Description",
                  "description": "Meta description"
                },
                "allow_indexing": {
                  "type": "boolean",
                  "title": "Allow Indexing",
                  "description": "Whether to allow search engine indexing"
                },
                "facebook_pixel": {
                  "type": "string",
                  "title": "Facebook Pixel",
                  "description": "Facebook Pixel tracking ID"
                },
                "google_analytics": {
                  "type": "string",
                  "title": "Google Analytics",
                  "description": "Google Analytics tracking ID"
                },
                "google_tag_manager": {
                  "type": "string",
                  "title": "Google Tag Manager",
                  "description": "Google Tag Manager ID"
                },
                "redirect_after_submit_url": {
                  "type": "string",
                  "title": "Redirect After Submit Url",
                  "description": "URL to redirect to after form submission"
                }
              },
              "description": "Metadata settings"
            },
            "captcha": {
              "type": "boolean",
              "title": "Captcha",
              "description": "Whether captcha is enabled"
            },
            "is_trial": {
              "type": "boolean",
              "title": "Is Trial",
              "description": "Whether the form is in trial mode"
            },
            "language": {
              "type": "string",
              "title": "Language",
              "description": "Language code (e.g., en, es)"
            },
            "is_public": {
              "type": "boolean",
              "title": "Is Public",
              "description": "Whether the form is publicly accessible"
            },
            "progress_bar": {
              "type": "string",
              "title": "Progress Bar",
              "description": "Progress bar style (proportion or percentage)"
            },
            "auto_translate": {
              "type": "boolean",
              "title": "Auto Translate",
              "description": "Whether to enable automatic translation"
            },
            "hide_navigation": {
              "type": "boolean",
              "title": "Hide Navigation",
              "description": "Whether to hide navigation buttons"
            },
            "autosave_progress": {
              "type": "boolean",
              "title": "Autosave Progress",
              "description": "Whether to auto-save respondent progress"
            },
            "show_progress_bar": {
              "type": "boolean",
              "title": "Show Progress Bar",
              "description": "Whether to display the progress bar"
            },
            "are_uploads_public": {
              "type": "boolean",
              "title": "Are Uploads Public",
              "description": "Whether file uploads are publicly accessible"
            },
            "show_cookie_consent": {
              "type": "boolean",
              "title": "Show Cookie Consent",
              "description": "Whether to show cookie consent banner"
            },
            "free_form_navigation": {
              "type": "boolean",
              "title": "Free Form Navigation",
              "description": "Whether to allow free-form navigation"
            },
            "show_question_number": {
              "type": "boolean",
              "title": "Show Question Number",
              "description": "Whether to show question numbers"
            },
            "pro_subdomain_enabled": {
              "type": "boolean",
              "title": "Pro Subdomain Enabled",
              "description": "Whether pro subdomain is enabled"
            },
            "show_time_to_complete": {
              "type": "boolean",
              "title": "Show Time To Complete",
              "description": "Whether to show estimated completion time"
            },
            "show_typeform_branding": {
              "type": "boolean",
              "title": "Show Typeform Branding",
              "description": "Whether to show Typeform branding"
            },
            "use_lead_qualification": {
              "type": "boolean",
              "title": "Use Lead Qualification",
              "description": "Whether to use lead qualification"
            },
            "show_key_hint_on_choices": {
              "type": "boolean",
              "title": "Show Key Hint On Choices",
              "description": "Whether to show keyboard hints on choices"
            },
            "show_number_of_submissions": {
              "type": "boolean",
              "title": "Show Number Of Submissions",
              "description": "Whether to show number of submissions"
            },
            "partial_responses_to_all_integrations": {
              "type": "boolean",
              "title": "Partial Responses To All Integrations",
              "description": "Whether to send partial responses to all integrations"
            }
          },
          "description": "Form settings"
        },
        "variables": {
          "type": "object",
          "title": "Variables",
          "description": "Form variables (dynamic key-value pairs for score, price, or custom variables)",
          "additionalProperties": true
        },
        "workspace": {
          "type": "object",
          "title": "Workspace",
          "required": [
            "href"
          ],
          "properties": {
            "href": {
              "type": "string",
              "title": "Href",
              "description": "URL reference to the workspace"
            }
          },
          "description": "Workspace information"
        },
        "welcome_screens": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "WelcomeScreen",
            "required": [
              "ref",
              "title"
            ],
            "properties": {
              "id": {
                "type": "string",
                "title": "Id",
                "description": "Unique identifier"
              },
              "ref": {
                "type": "string",
                "title": "Ref",
                "description": "Unique reference string"
              },
              "title": {
                "type": "string",
                "title": "Title",
                "description": "Welcome screen title"
              },
              "attachment": {
                "type": "object",
                "title": "Attachment",
                "required": [
                  "type",
                  "href"
                ],
                "properties": {
                  "href": {
                    "type": "string",
                    "title": "Href",
                    "description": "URL to the attachment resource"
                  },
                  "type": {
                    "type": "string",
                    "title": "Type",
                    "description": "Attachment type (image or video)"
                  },
                  "scale": {
                    "type": "number",
                    "title": "Scale",
                    "description": "Scale of the attachment (0.4, 0.6, 0.8, or 1)"
                  },
                  "properties": {
                    "type": "object",
                    "title": "Properties",
                    "properties": {
                      "description": {
                        "type": "string",
                        "title": "Description",
                        "description": "Attachment description"
                      }
                    },
                    "description": "Attachment properties"
                  }
                },
                "description": "Attachment object"
              },
              "properties": {
                "type": "object",
                "title": "Properties",
                "properties": {
                  "button_text": {
                    "type": "string",
                    "title": "Button Text",
                    "description": "Button text"
                  },
                  "description": {
                    "type": "string",
                    "title": "Description",
                    "description": "Welcome screen description"
                  },
                  "show_button": {
                    "type": "boolean",
                    "title": "Show Button",
                    "description": "Whether to show the button"
                  }
                },
                "description": "Welcome screen properties"
              }
            },
            "description": "Welcome screen object"
          },
          "title": "Welcome Screens",
          "description": "Welcome screens configuration"
        },
        "thankyou_screens": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "ThankYouScreen",
            "required": [
              "ref",
              "title"
            ],
            "properties": {
              "id": {
                "type": "string",
                "title": "Id",
                "description": "Unique identifier"
              },
              "ref": {
                "type": "string",
                "title": "Ref",
                "description": "Unique reference string"
              },
              "type": {
                "type": "string",
                "title": "Type",
                "description": "Screen type (thankyou_screen or url_redirect)"
              },
              "title": {
                "type": "string",
                "title": "Title",
                "description": "Thank you screen title"
              },
              "attachment": {
                "type": "object",
                "title": "Attachment",
                "required": [
                  "type",
                  "href"
                ],
                "properties": {
                  "href": {
                    "type": "string",
                    "title": "Href",
                    "description": "URL to the attachment resource"
                  },
                  "type": {
                    "type": "string",
                    "title": "Type",
                    "description": "Attachment type (image or video)"
                  },
                  "scale": {
                    "type": "number",
                    "title": "Scale",
                    "description": "Scale of the attachment (0.4, 0.6, 0.8, or 1)"
                  },
                  "properties": {
                    "type": "object",
                    "title": "Properties",
                    "properties": {
                      "description": {
                        "type": "string",
                        "title": "Description",
                        "description": "Attachment description"
                      }
                    },
                    "description": "Attachment properties"
                  }
                },
                "description": "Attachment object"
              },
              "properties": {
                "type": "object",
                "title": "Properties",
                "properties": {
                  "button_mode": {
                    "type": "string",
                    "title": "Button Mode",
                    "description": "Button mode (reload, default_redirect, or redirect)"
                  },
                  "button_text": {
                    "type": "string",
                    "title": "Button Text",
                    "description": "Button text"
                  },
                  "share_icons": {
                    "type": "boolean",
                    "title": "Share Icons",
                    "description": "Whether to show share icons"
                  },
                  "show_button": {
                    "type": "boolean",
                    "title": "Show Button",
                    "description": "Whether to show the button"
                  },
                  "redirect_url": {
                    "type": "string",
                    "title": "Redirect Url",
                    "description": "Redirect URL"
                  }
                },
                "description": "Thank you screen properties"
              }
            },
            "description": "Thank you screen object"
          },
          "title": "Thankyou Screens",
          "description": "Thank you screens configuration"
        }
      }
    }
  },
  "title": "TypeformUpdateFormResponseWrapper",
  "required": [
    "data",
    "successful"
  ],
  "properties": {
    "data": {
      "type": "object",
      "title": "Data",
      "properties": {
        "id": {
          "type": "string",
          "title": "Id",
          "description": "Unique identifier of the updated form"
        },
        "type": {
          "type": "string",
          "title": "Type",
          "description": "Form type category"
        },
        "logic": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "LogicJump",
            "required": [
              "type",
              "ref",
              "actions"
            ],
            "properties": {
              "ref": {
                "type": "string",
                "title": "Ref",
                "description": "Reference to field or hidden variable"
              },
              "type": {
                "type": "string",
                "title": "Type",
                "description": "Logic type (field or hidden)"
              },
              "actions": {
                "type": "array",
                "items": {
                  "type": "object",
                  "title": "LogicAction",
                  "required": [
                    "action",
                    "condition"
                  ],
                  "properties": {
                    "action": {
                      "type": "string",
                      "title": "Action",
                      "description": "Action type (jump, add, subtract, multiply, divide, set)"
                    },
                    "details": {
                      "type": "object",
                      "title": "Details",
                      "properties": {
                        "to": {
                          "type": "object",
                          "title": "To",
                          "description": "Jump target",
                          "additionalProperties": true
                        },
                        "value": {
                          "type": "object",
                          "title": "Value",
                          "description": "Value to set",
                          "additionalProperties": true
                        },
                        "target": {
                          "type": "object",
                          "title": "Target",
                          "description": "Target for variable operations",
                          "additionalProperties": true
                        }
                      },
                      "description": "Action details"
                    },
                    "condition": {
                      "type": "object",
                      "title": "Condition",
                      "required": [
                        "op",
                        "vars"
                      ],
                      "properties": {
                        "op": {
                          "type": "string",
                          "title": "Op",
                          "description": "Operator (is, is_not, equal, greater_than, contains, etc.)"
                        },
                        "vars": {
                          "type": "array",
                          "items": {
                            "type": "object",
                            "title": "LogicConditionVar",
                            "required": [
                              "type",
                              "value"
                            ],
                            "properties": {
                              "type": {
                                "type": "string",
                                "title": "Type",
                                "description": "Variable type (field, hidden, variable, constant, choice)"
                              },
                              "value": {
                                "title": "Value",
                                "description": "Variable value"
                              }
                            },
                            "description": "Variable in logic condition"
                          },
                          "title": "Vars",
                          "description": "List of variables in the condition"
                        }
                      },
                      "description": "Condition to evaluate"
                    }
                  },
                  "description": "Action to take when condition is met"
                },
                "title": "Actions",
                "description": "List of actions to execute"
              }
            },
            "description": "Logic jump object for conditional branching"
          },
          "title": "Logic",
          "description": "Logic jumps configuration"
        },
        "theme": {
          "type": "object",
          "title": "Theme",
          "required": [
            "href"
          ],
          "properties": {
            "href": {
              "type": "string",
              "title": "Href",
              "description": "URL reference to the theme"
            }
          },
          "description": "Theme configuration"
        },
        "title": {
          "type": "string",
          "title": "Title",
          "description": "Title of the form"
        },
        "_links": {
          "type": "object",
          "title": " Links",
          "properties": {
            "edit": {
              "type": "string",
              "title": "Edit",
              "description": "URI to edit form"
            },
            "json": {
              "type": "string",
              "title": "Json",
              "description": "URI for JSON export"
            },
            "self": {
              "type": "string",
              "title": "Self",
              "description": "URI for API access"
            },
            "display": {
              "type": "string",
              "title": "Display",
              "description": "URI to display the form"
            },
            "results": {
              "type": "string",
              "title": "Results",
              "description": "URI for results"
            },
            "responses": {
              "type": "string",
              "title": "Responses",
              "description": "URI for form responses"
            }
          },
          "description": "Related links"
        },
        "fields": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "FormField",
            "required": [
              "ref",
              "title",
              "type"
            ],
            "properties": {
              "id": {
                "type": "string",
                "title": "Id",
                "description": "Unique identifier"
              },
              "ref": {
                "type": "string",
                "title": "Ref",
                "description": "Unique reference string"
              },
              "type": {
                "type": "string",
                "title": "Type",
                "description": "Field type (short_text, email, multiple_choice, etc.)"
              },
              "title": {
                "type": "string",
                "title": "Title",
                "description": "Field title/question text"
              },
              "attachment": {
                "type": "object",
                "title": "Attachment",
                "required": [
                  "type",
                  "href"
                ],
                "properties": {
                  "href": {
                    "type": "string",
                    "title": "Href",
                    "description": "URL to the attachment resource"
                  },
                  "type": {
                    "type": "string",
                    "title": "Type",
                    "description": "Attachment type (image or video)"
                  },
                  "scale": {
                    "type": "number",
                    "title": "Scale",
                    "description": "Scale of the attachment (0.4, 0.6, 0.8, or 1)"
                  },
                  "properties": {
                    "type": "object",
                    "title": "Properties",
                    "properties": {
                      "description": {
                        "type": "string",
                        "title": "Description",
                        "description": "Attachment description"
                      }
                    },
                    "description": "Attachment properties"
                  }
                },
                "description": "Attachment object"
              },
              "properties": {
                "type": "object",
                "title": "Properties",
                "properties": {
                  "shape": {
                    "type": "string",
                    "title": "Shape",
                    "description": "Shape for rating fields"
                  },
                  "steps": {
                    "type": "integer",
                    "title": "Steps",
                    "description": "Number of steps (5-11)"
                  },
                  "fields": {
                    "type": "array",
                    "items": {
                      "type": "object",
                      "additionalProperties": true
                    },
                    "title": "Fields",
                    "description": "Nested fields for group/matrix/contact_info"
                  },
                  "labels": {
                    "type": "object",
                    "title": "Labels",
                    "description": "Labels (left, right, center)",
                    "additionalProperties": {
                      "type": "string"
                    }
                  },
                  "choices": {
                    "type": "array",
                    "items": {
                      "type": "object",
                      "title": "Choice",
                      "required": [
                        "label"
                      ],
                      "properties": {
                        "id": {
                          "type": "string",
                          "title": "Id",
                          "description": "Unique identifier for the choice"
                        },
                        "ref": {
                          "type": "string",
                          "title": "Ref",
                          "description": "Unique reference for the choice"
                        },
                        "label": {
                          "type": "string",
                          "title": "Label",
                          "description": "Choice label text"
                        },
                        "attachment": {
                          "type": "object",
                          "title": "Attachment",
                          "required": [
                            "type",
                            "href"
                          ],
                          "properties": {
                            "href": {
                              "type": "string",
                              "title": "Href",
                              "description": "URL to the attachment resource"
                            },
                            "type": {
                              "type": "string",
                              "title": "Type",
                              "description": "Attachment type (image or video)"
                            },
                            "scale": {
                              "type": "number",
                              "title": "Scale",
                              "description": "Scale of the attachment (0.4, 0.6, 0.8, or 1)"
                            },
                            "properties": {
                              "type": "object",
                              "title": "Properties",
                              "properties": {
                                "description": {
                                  "type": "string",
                                  "title": "Description",
                                  "description": "Attachment description"
                                }
                              },
                              "description": "Attachment properties"
                            }
                          },
                          "description": "Attachment object"
                        }
                      },
                      "description": "Choice option for choice-based fields"
                    },
                    "title": "Choices",
                    "description": "List of choices"
                  },
                  "currency": {
                    "type": "string",
                    "title": "Currency",
                    "description": "Currency code"
                  },
                  "randomize": {
                    "type": "boolean",
                    "title": "Randomize",
                    "description": "Whether to randomize choice order"
                  },
                  "separator": {
                    "type": "string",
                    "title": "Separator",
                    "description": "Date separator (/, -, .)"
                  },
                  "structure": {
                    "type": "string",
                    "title": "Structure",
                    "description": "Date structure (DDMMYYYY, MMDDYYYY, YYYYMMDD)"
                  },
                  "hide_marks": {
                    "type": "boolean",
                    "title": "Hide Marks",
                    "description": "Whether to hide marks"
                  },
                  "supersized": {
                    "type": "boolean",
                    "title": "Supersized",
                    "description": "Whether to use supersized"
                  },
                  "button_text": {
                    "type": "string",
                    "title": "Button Text",
                    "description": "Button text"
                  },
                  "description": {
                    "type": "string",
                    "title": "Description",
                    "description": "Field description"
                  },
                  "show_labels": {
                    "type": "boolean",
                    "title": "Show Labels",
                    "description": "Whether to show labels"
                  },
                  "start_at_one": {
                    "type": "boolean",
                    "title": "Start At One",
                    "description": "Whether to start at one"
                  },
                  "allow_other_choice": {
                    "type": "boolean",
                    "title": "Allow Other Choice",
                    "description": "Whether to allow 'Other' choice"
                  },
                  "alphabetical_order": {
                    "type": "boolean",
                    "title": "Alphabetical Order",
                    "description": "Whether to sort alphabetically"
                  },
                  "vertical_alignment": {
                    "type": "boolean",
                    "title": "Vertical Alignment",
                    "description": "Whether to use vertical alignment"
                  },
                  "allow_multiple_selection": {
                    "type": "boolean",
                    "title": "Allow Multiple Selection",
                    "description": "Whether multiple selections are allowed"
                  }
                },
                "description": "Field properties"
              },
              "validations": {
                "type": "object",
                "title": "Validations",
                "properties": {
                  "required": {
                    "type": "boolean",
                    "title": "Required",
                    "description": "Whether the field is required"
                  },
                  "max_value": {
                    "type": "number",
                    "title": "Max Value",
                    "description": "Maximum value"
                  },
                  "min_value": {
                    "type": "number",
                    "title": "Min Value",
                    "description": "Minimum value"
                  },
                  "max_length": {
                    "type": "integer",
                    "title": "Max Length",
                    "description": "Maximum length"
                  },
                  "max_selection": {
                    "type": "integer",
                    "title": "Max Selection",
                    "description": "Maximum selection count"
                  },
                  "min_selection": {
                    "type": "integer",
                    "title": "Min Selection",
                    "description": "Minimum selection count"
                  }
                },
                "description": "Validation rules"
              }
            },
            "description": "Form field object"
          },
          "title": "Fields",
          "description": "List of form fields with their configurations"
        },
        "hidden": {
          "type": "array",
          "items": {
            "type": "string"
          },
          "title": "Hidden",
          "description": "List of hidden field variable names"
        },
        "language": {
          "type": "string",
          "title": "Language",
          "description": "Language code of the form"
        },
        "settings": {
          "type": "object",
          "title": "Settings",
          "properties": {
            "meta": {
              "type": "object",
              "title": "Meta",
              "properties": {
                "image": {
                  "type": "object",
                  "title": "Image",
                  "description": "Meta image with href",
                  "additionalProperties": {
                    "type": "string"
                  }
                },
                "title": {
                  "type": "string",
                  "title": "Title",
                  "description": "Meta title"
                },
                "description": {
                  "type": "string",
                  "title": "Description",
                  "description": "Meta description"
                },
                "allow_indexing": {
                  "type": "boolean",
                  "title": "Allow Indexing",
                  "description": "Whether to allow search engine indexing"
                },
                "facebook_pixel": {
                  "type": "string",
                  "title": "Facebook Pixel",
                  "description": "Facebook Pixel tracking ID"
                },
                "google_analytics": {
                  "type": "string",
                  "title": "Google Analytics",
                  "description": "Google Analytics tracking ID"
                },
                "google_tag_manager": {
                  "type": "string",
                  "title": "Google Tag Manager",
                  "description": "Google Tag Manager ID"
                },
                "redirect_after_submit_url": {
                  "type": "string",
                  "title": "Redirect After Submit Url",
                  "description": "URL to redirect to after form submission"
                }
              },
              "description": "Metadata settings"
            },
            "captcha": {
              "type": "boolean",
              "title": "Captcha",
              "description": "Whether captcha is enabled"
            },
            "is_trial": {
              "type": "boolean",
              "title": "Is Trial",
              "description": "Whether the form is in trial mode"
            },
            "language": {
              "type": "string",
              "title": "Language",
              "description": "Language code (e.g., en, es)"
            },
            "is_public": {
              "type": "boolean",
              "title": "Is Public",
              "description": "Whether the form is publicly accessible"
            },
            "progress_bar": {
              "type": "string",
              "title": "Progress Bar",
              "description": "Progress bar style (proportion or percentage)"
            },
            "auto_translate": {
              "type": "boolean",
              "title": "Auto Translate",
              "description": "Whether to enable automatic translation"
            },
            "hide_navigation": {
              "type": "boolean",
              "title": "Hide Navigation",
              "description": "Whether to hide navigation buttons"
            },
            "autosave_progress": {
              "type": "boolean",
              "title": "Autosave Progress",
              "description": "Whether to auto-save respondent progress"
            },
            "show_progress_bar": {
              "type": "boolean",
              "title": "Show Progress Bar",
              "description": "Whether to display the progress bar"
            },
            "are_uploads_public": {
              "type": "boolean",
              "title": "Are Uploads Public",
              "description": "Whether file uploads are publicly accessible"
            },
            "show_cookie_consent": {
              "type": "boolean",
              "title": "Show Cookie Consent",
              "description": "Whether to show cookie consent banner"
            },
            "free_form_navigation": {
              "type": "boolean",
              "title": "Free Form Navigation",
              "description": "Whether to allow free-form navigation"
            },
            "show_question_number": {
              "type": "boolean",
              "title": "Show Question Number",
              "description": "Whether to show question numbers"
            },
            "pro_subdomain_enabled": {
              "type": "boolean",
              "title": "Pro Subdomain Enabled",
              "description": "Whether pro subdomain is enabled"
            },
            "show_time_to_complete": {
              "type": "boolean",
              "title": "Show Time To Complete",
              "description": "Whether to show estimated completion time"
            },
            "show_typeform_branding": {
              "type": "boolean",
              "title": "Show Typeform Branding",
              "description": "Whether to show Typeform branding"
            },
            "use_lead_qualification": {
              "type": "boolean",
              "title": "Use Lead Qualification",
              "description": "Whether to use lead qualification"
            },
            "show_key_hint_on_choices": {
              "type": "boolean",
              "title": "Show Key Hint On Choices",
              "description": "Whether to show keyboard hints on choices"
            },
            "show_number_of_submissions": {
              "type": "boolean",
              "title": "Show Number Of Submissions",
              "description": "Whether to show number of submissions"
            },
            "partial_responses_to_all_integrations": {
              "type": "boolean",
              "title": "Partial Responses To All Integrations",
              "description": "Whether to send partial responses to all integrations"
            }
          },
          "description": "Form settings"
        },
        "variables": {
          "type": "object",
          "title": "Variables",
          "description": "Form variables (dynamic key-value pairs for score, price, or custom variables)",
          "additionalProperties": true
        },
        "workspace": {
          "type": "object",
          "title": "Workspace",
          "required": [
            "href"
          ],
          "properties": {
            "href": {
              "type": "string",
              "title": "Href",
              "description": "URL reference to the workspace"
            }
          },
          "description": "Workspace information"
        },
        "welcome_screens": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "WelcomeScreen",
            "required": [
              "ref",
              "title"
            ],
            "properties": {
              "id": {
                "type": "string",
                "title": "Id",
                "description": "Unique identifier"
              },
              "ref": {
                "type": "string",
                "title": "Ref",
                "description": "Unique reference string"
              },
              "title": {
                "type": "string",
                "title": "Title",
                "description": "Welcome screen title"
              },
              "attachment": {
                "type": "object",
                "title": "Attachment",
                "required": [
                  "type",
                  "href"
                ],
                "properties": {
                  "href": {
                    "type": "string",
                    "title": "Href",
                    "description": "URL to the attachment resource"
                  },
                  "type": {
                    "type": "string",
                    "title": "Type",
                    "description": "Attachment type (image or video)"
                  },
                  "scale": {
                    "type": "number",
                    "title": "Scale",
                    "description": "Scale of the attachment (0.4, 0.6, 0.8, or 1)"
                  },
                  "properties": {
                    "type": "object",
                    "title": "Properties",
                    "properties": {
                      "description": {
                        "type": "string",
                        "title": "Description",
                        "description": "Attachment description"
                      }
                    },
                    "description": "Attachment properties"
                  }
                },
                "description": "Attachment object"
              },
              "properties": {
                "type": "object",
                "title": "Properties",
                "properties": {
                  "button_text": {
                    "type": "string",
                    "title": "Button Text",
                    "description": "Button text"
                  },
                  "description": {
                    "type": "string",
                    "title": "Description",
                    "description": "Welcome screen description"
                  },
                  "show_button": {
                    "type": "boolean",
                    "title": "Show Button",
                    "description": "Whether to show the button"
                  }
                },
                "description": "Welcome screen properties"
              }
            },
            "description": "Welcome screen object"
          },
          "title": "Welcome Screens",
          "description": "Welcome screens configuration"
        },
        "thankyou_screens": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "ThankYouScreen",
            "required": [
              "ref",
              "title"
            ],
            "properties": {
              "id": {
                "type": "string",
                "title": "Id",
                "description": "Unique identifier"
              },
              "ref": {
                "type": "string",
                "title": "Ref",
                "description": "Unique reference string"
              },
              "type": {
                "type": "string",
                "title": "Type",
                "description": "Screen type (thankyou_screen or url_redirect)"
              },
              "title": {
                "type": "string",
                "title": "Title",
                "description": "Thank you screen title"
              },
              "attachment": {
                "type": "object",
                "title": "Attachment",
                "required": [
                  "type",
                  "href"
                ],
                "properties": {
                  "href": {
                    "type": "string",
                    "title": "Href",
                    "description": "URL to the attachment resource"
                  },
                  "type": {
                    "type": "string",
                    "title": "Type",
                    "description": "Attachment type (image or video)"
                  },
                  "scale": {
                    "type": "number",
                    "title": "Scale",
                    "description": "Scale of the attachment (0.4, 0.6, 0.8, or 1)"
                  },
                  "properties": {
                    "type": "object",
                    "title": "Properties",
                    "properties": {
                      "description": {
                        "type": "string",
                        "title": "Description",
                        "description": "Attachment description"
                      }
                    },
                    "description": "Attachment properties"
                  }
                },
                "description": "Attachment object"
              },
              "properties": {
                "type": "object",
                "title": "Properties",
                "properties": {
                  "button_mode": {
                    "type": "string",
                    "title": "Button Mode",
                    "description": "Button mode (reload, default_redirect, or redirect)"
                  },
                  "button_text": {
                    "type": "string",
                    "title": "Button Text",
                    "description": "Button text"
                  },
                  "share_icons": {
                    "type": "boolean",
                    "title": "Share Icons",
                    "description": "Whether to show share icons"
                  },
                  "show_button": {
                    "type": "boolean",
                    "title": "Show Button",
                    "description": "Whether to show the button"
                  },
                  "redirect_url": {
                    "type": "string",
                    "title": "Redirect Url",
                    "description": "Redirect URL"
                  }
                },
                "description": "Thank you screen properties"
              }
            },
            "description": "Thank you screen object"
          },
          "title": "Thankyou Screens",
          "description": "Thank you screens configuration"
        }
      },
      "description": "Data from the action execution"
    },
    "error": {
      "type": "string",
      "title": "Error",
      "description": "Error if any occurred during the execution of the action"
    },
    "successful": {
      "type": "boolean",
      "title": "Successful",
      "description": "Whether or not the action execution was successful or not"
    }
  }
}
```

## TYPEFORM_UPDATE_FORM_MESSAGES
Tool to update custom messages for form UI elements like buttons, errors, and placeholders in Typeform. Use when you need to customize the text displayed to form respondents.

**Input schema:**
```json
{
  "type": "object",
  "title": "UpdateFormMessagesRequest",
  "required": [
    "form_id"
  ],
  "properties": {
    "form_id": {
      "type": "string",
      "title": "Form Id",
      "examples": [
        "Y78g1cmS"
      ],
      "description": "Unique form identifier"
    },
    "label_button_submit": {
      "type": "string",
      "title": "Label Button Submit",
      "examples": [
        "Submit Form",
        "Send"
      ],
      "maxLength": 100,
      "description": "Text for the submit button (max 100 characters). This is the final button to submit the form."
    },
    "label_error_required": {
      "type": "string",
      "title": "Label Error Required",
      "examples": [
        "This field is required",
        "Please answer this question"
      ],
      "maxLength": 64,
      "description": "Error message shown when a required field is empty (max 64 characters)."
    },
    "label_buttonHint_default": {
      "type": "string",
      "title": "Label Button Hint Default",
      "examples": [
        "Click to continue"
      ],
      "maxLength": 28,
      "description": "Tooltip text for the continue button (max 28 characters). Use this to provide hints about the button's function."
    },
    "block_shortText_placeholder": {
      "type": "string",
      "title": "Block Short Text Placeholder",
      "examples": [
        "Type your answer here",
        "Enter text"
      ],
      "maxLength": 100,
      "description": "Placeholder text for short text input fields (max 100 characters)."
    },
    "label_buttonNoAnswer_default": {
      "type": "string",
      "title": "Label Button No Answer Default",
      "examples": [
        "Skip this question"
      ],
      "maxLength": 100,
      "description": "Text for the 'Continue without answering' button (max 100 characters). Shown when a question is optional."
    }
  }
}
```

**Output schema:**
```json
{
  "type": "object",
  "$defs": {
    "UpdateFormMessagesResponse": {
      "type": "object",
      "title": "UpdateFormMessagesResponse",
      "required": [
        "success",
        "message"
      ],
      "properties": {
        "message": {
          "type": "string",
          "title": "Message",
          "description": "Success message describing the operation result."
        },
        "success": {
          "type": "boolean",
          "title": "Success",
          "description": "Whether the messages were successfully updated. Always true if no error was raised."
        }
      }
    }
  },
  "title": "UpdateFormMessagesResponseWrapper",
  "required": [
    "data",
    "successful"
  ],
  "properties": {
    "data": {
      "type": "object",
      "title": "Data",
      "required": [
        "success",
        "message"
      ],
      "properties": {
        "message": {
          "type": "string",
          "title": "Message",
          "description": "Success message describing the operation result."
        },
        "success": {
          "type": "boolean",
          "title": "Success",
          "description": "Whether the messages were successfully updated. Always true if no error was raised."
        }
      },
      "description": "Data from the action execution"
    },
    "error": {
      "type": "string",
      "title": "Error",
      "description": "Error if any occurred during the execution of the action"
    },
    "successful": {
      "type": "boolean",
      "title": "Successful",
      "description": "Whether or not the action execution was successful or not"
    }
  }
}
```

## TYPEFORM_UPDATE_THEME
Tool to update a theme's complete definition in Typeform. Use when you need to update all aspects of a theme including colors, fonts, and visual properties. This is a full update (PUT) operation that requires name, font, and colors to be provided. For partial updates, use PATCH instead.

**Input schema:**
```json
{
  "type": "object",
  "title": "UpdateThemeRequest",
  "required": [
    "theme_id",
    "name",
    "font",
    "colors"
  ],
  "properties": {
    "font": {
      "type": "string",
      "title": "Font",
      "examples": [
        "Helvetica",
        "Arial",
        "Georgia"
      ],
      "description": "Font family for the theme (required for PUT requests)"
    },
    "name": {
      "type": "string",
      "title": "Name",
      "examples": [
        "Updated Test Theme"
      ],
      "description": "Updated theme name"
    },
    "colors": {
      "type": "object",
      "title": "Colors",
      "required": [
        "question",
        "answer",
        "button",
        "background"
      ],
      "properties": {
        "answer": {
          "type": "string",
          "title": "Answer",
          "examples": [
            "#FF6B6B"
          ],
          "description": "Hexadecimal color code for answers"
        },
        "button": {
          "type": "string",
          "title": "Button",
          "examples": [
            "#FF6B6B"
          ],
          "description": "Hexadecimal color code for buttons"
        },
        "question": {
          "type": "string",
          "title": "Question",
          "examples": [
            "#333333"
          ],
          "description": "Hexadecimal color code for questions"
        },
        "background": {
          "type": "string",
          "title": "Background",
          "examples": [
            "#F5F5F5"
          ],
          "description": "Hexadecimal color code for background"
        }
      },
      "description": "Updated color palette with question, answer, button, and background colors",
      "additionalProperties": false
    },
    "fields": {
      "type": "object",
      "title": "ThemeFields",
      "properties": {
        "font": {
          "type": "string",
          "title": "Font",
          "examples": [
            "Helvetica"
          ],
          "description": "Font family name"
        },
        "alignment": {
          "type": "string",
          "title": "Alignment",
          "examples": [
            "left"
          ],
          "description": "Field alignment: left or center"
        },
        "font_size": {
          "type": "string",
          "title": "Font Size",
          "examples": [
            "medium"
          ],
          "description": "Font size: small, medium, or large"
        }
      },
      "description": "Field settings for the theme",
      "additionalProperties": false
    },
    "screens": {
      "type": "object",
      "title": "ThemeScreens",
      "properties": {
        "alignment": {
          "type": "string",
          "title": "Alignment",
          "examples": [
            "center"
          ],
          "description": "Screen alignment: left or center"
        },
        "font_size": {
          "type": "string",
          "title": "Font Size",
          "examples": [
            "large"
          ],
          "description": "Font size: small, medium, or large"
        }
      },
      "description": "Screen settings for the theme",
      "additionalProperties": false
    },
    "theme_id": {
      "type": "string",
      "title": "Theme Id",
      "examples": [
        "Gym4Ntp6"
      ],
      "description": "Unique identifier for the theme to update"
    },
    "background": {
      "type": "object",
      "title": "ThemeBackground",
      "properties": {
        "href": {
          "type": "string",
          "title": "Href",
          "examples": [
            "https://images.typeform.com/images/abc123"
          ],
          "description": "Background image URL"
        },
        "layout": {
          "type": "string",
          "title": "Layout",
          "examples": [
            "fullscreen"
          ],
          "description": "Background layout style: fullscreen, repeat, or no-repeat"
        },
        "brightness": {
          "type": "number",
          "title": "Brightness",
          "maximum": 1,
          "minimum": -1,
          "examples": [
            0.5
          ],
          "description": "Brightness level from -1 to 1"
        }
      },
      "description": "Background settings for the theme",
      "additionalProperties": false
    },
    "rounded_corners": {
      "type": "string",
      "title": "Rounded Corners",
      "examples": [
        "small"
      ],
      "description": "Border radius style: none, small, or large"
    },
    "has_transparent_button": {
      "type": "boolean",
      "title": "Has Transparent Button",
      "examples": [
        false
      ],
      "description": "Whether buttons should be transparent"
    }
  }
}
```

**Output schema:**
```json
{
  "type": "object",
  "$defs": {
    "UpdateThemeResponse": {
      "type": "object",
      "title": "UpdateThemeResponse",
      "required": [
        "id",
        "name",
        "colors"
      ],
      "properties": {
        "id": {
          "type": "string",
          "title": "Id",
          "description": "Unique identifier of the theme"
        },
        "name": {
          "type": "string",
          "title": "Name",
          "description": "Theme name"
        },
        "colors": {
          "type": "object",
          "title": "Colors",
          "required": [
            "question",
            "answer",
            "button",
            "background"
          ],
          "properties": {
            "answer": {
              "type": "string",
              "title": "Answer",
              "description": "Color code for answers"
            },
            "button": {
              "type": "string",
              "title": "Button",
              "description": "Color code for buttons"
            },
            "question": {
              "type": "string",
              "title": "Question",
              "description": "Color code for questions"
            },
            "background": {
              "type": "string",
              "title": "Background",
              "description": "Color code for background"
            }
          },
          "description": "Color palette"
        },
        "fields": {
          "type": "object",
          "title": "Fields",
          "properties": {
            "font": {
              "type": "string",
              "title": "Font",
              "description": "Font family"
            },
            "alignment": {
              "type": "string",
              "title": "Alignment",
              "description": "Field alignment"
            },
            "font_size": {
              "type": "string",
              "title": "Font Size",
              "description": "Font size"
            }
          },
          "description": "Field settings"
        },
        "screens": {
          "type": "object",
          "title": "Screens",
          "properties": {
            "alignment": {
              "type": "string",
              "title": "Alignment",
              "description": "Screen alignment"
            },
            "font_size": {
              "type": "string",
              "title": "Font Size",
              "description": "Font size"
            }
          },
          "description": "Screen settings"
        },
        "background": {
          "type": "object",
          "title": "Background",
          "properties": {
            "href": {
              "type": "string",
              "title": "Href",
              "description": "Background image URL"
            },
            "layout": {
              "type": "string",
              "title": "Layout",
              "description": "Background layout style"
            },
            "brightness": {
              "type": "number",
              "title": "Brightness",
              "description": "Brightness level from -1 to 1"
            }
          },
          "description": "Background settings"
        },
        "visibility": {
          "type": "string",
          "title": "Visibility",
          "description": "Theme visibility: public or private"
        },
        "rounded_corners": {
          "type": "string",
          "title": "Rounded Corners",
          "description": "Border radius style"
        },
        "has_transparent_button": {
          "type": "boolean",
          "title": "Has Transparent Button",
          "description": "Whether buttons are transparent"
        }
      }
    },
    "UpdateThemeResponseColors": {
      "type": "object",
      "title": "UpdateThemeResponseColors",
      "required": [
        "question",
        "answer",
        "button",
        "background"
      ],
      "properties": {
        "answer": {
          "type": "string",
          "title": "Answer",
          "description": "Color code for answers"
        },
        "button": {
          "type": "string",
          "title": "Button",
          "description": "Color code for buttons"
        },
        "question": {
          "type": "string",
          "title": "Question",
          "description": "Color code for questions"
        },
        "background": {
          "type": "string",
          "title": "Background",
          "description": "Color code for background"
        }
      },
      "description": "Color palette in the response"
    },
    "UpdateThemeResponseFields": {
      "type": "object",
      "title": "UpdateThemeResponseFields",
      "properties": {
        "font": {
          "type": "string",
          "title": "Font",
          "description": "Font family"
        },
        "alignment": {
          "type": "string",
          "title": "Alignment",
          "description": "Field alignment"
        },
        "font_size": {
          "type": "string",
          "title": "Font Size",
          "description": "Font size"
        }
      },
      "description": "Field settings in the response"
    },
    "UpdateThemeResponseScreens": {
      "type": "object",
      "title": "UpdateThemeResponseScreens",
      "properties": {
        "alignment": {
          "type": "string",
          "title": "Alignment",
          "description": "Screen alignment"
        },
        "font_size": {
          "type": "string",
          "title": "Font Size",
          "description": "Font size"
        }
      },
      "description": "Screen settings in the response"
    },
    "UpdateThemeResponseBackground": {
      "type": "object",
      "title": "UpdateThemeResponseBackground",
      "properties": {
        "href": {
          "type": "string",
          "title": "Href",
          "description": "Background image URL"
        },
        "layout": {
          "type": "string",
          "title": "Layout",
          "description": "Background layout style"
        },
        "brightness": {
          "type": "number",
          "title": "Brightness",
          "description": "Brightness level from -1 to 1"
        }
      },
      "description": "Background settings in the response"
    }
  },
  "title": "UpdateThemeResponseWrapper",
  "required": [
    "data",
    "successful"
  ],
  "properties": {
    "data": {
      "type": "object",
      "title": "Data",
      "required": [
        "id",
        "name",
        "colors"
      ],
      "properties": {
        "id": {
          "type": "string",
          "title": "Id",
          "description": "Unique identifier of the theme"
        },
        "name": {
          "type": "string",
          "title": "Name",
          "description": "Theme name"
        },
        "colors": {
          "type": "object",
          "title": "Colors",
          "required": [
            "question",
            "answer",
            "button",
            "background"
          ],
          "properties": {
            "answer": {
              "type": "string",
              "title": "Answer",
              "description": "Color code for answers"
            },
            "button": {
              "type": "string",
              "title": "Button",
              "description": "Color code for buttons"
            },
            "question": {
              "type": "string",
              "title": "Question",
              "description": "Color code for questions"
            },
            "background": {
              "type": "string",
              "title": "Background",
              "description": "Color code for background"
            }
          },
          "description": "Color palette"
        },
        "fields": {
          "type": "object",
          "title": "Fields",
          "properties": {
            "font": {
              "type": "string",
              "title": "Font",
              "description": "Font family"
            },
            "alignment": {
              "type": "string",
              "title": "Alignment",
              "description": "Field alignment"
            },
            "font_size": {
              "type": "string",
              "title": "Font Size",
              "description": "Font size"
            }
          },
          "description": "Field settings"
        },
        "screens": {
          "type": "object",
          "title": "Screens",
          "properties": {
            "alignment": {
              "type": "string",
              "title": "Alignment",
              "description": "Screen alignment"
            },
            "font_size": {
              "type": "string",
              "title": "Font Size",
              "description": "Font size"
            }
          },
          "description": "Screen settings"
        },
        "background": {
          "type": "object",
          "title": "Background",
          "properties": {
            "href": {
              "type": "string",
              "title": "Href",
              "description": "Background image URL"
            },
            "layout": {
              "type": "string",
              "title": "Layout",
              "description": "Background layout style"
            },
            "brightness": {
              "type": "number",
              "title": "Brightness",
              "description": "Brightness level from -1 to 1"
            }
          },
          "description": "Background settings"
        },
        "visibility": {
          "type": "string",
          "title": "Visibility",
          "description": "Theme visibility: public or private"
        },
        "rounded_corners": {
          "type": "string",
          "title": "Rounded Corners",
          "description": "Border radius style"
        },
        "has_transparent_button": {
          "type": "boolean",
          "title": "Has Transparent Button",
          "description": "Whether buttons are transparent"
        }
      },
      "description": "Data from the action execution"
    },
    "error": {
      "type": "string",
      "title": "Error",
      "description": "Error if any occurred during the execution of the action"
    },
    "successful": {
      "type": "boolean",
      "title": "Successful",
      "description": "Whether or not the action execution was successful or not"
    }
  }
}
```

## TYPEFORM_UPDATE_WORKSPACE
Tool to update a workspace's name or manage team member access (add/remove members) in Typeform. Use when you need to rename a workspace or modify its member list using JSON Patch operations.

**Input schema:**
```json
{
  "type": "object",
  "title": "UpdateWorkspaceRequest",
  "required": [
    "workspace_id",
    "operations"
  ],
  "properties": {
    "operations": {
      "type": "array",
      "items": {
        "type": "object",
        "title": "PatchOperation",
        "required": [
          "op",
          "path"
        ],
        "properties": {
          "op": {
            "enum": [
              "replace",
              "add",
              "remove"
            ],
            "type": "string",
            "title": "Op",
            "examples": [
              "replace",
              "add",
              "remove"
            ],
            "description": "Operation type: 'replace' for updating name, 'add' for adding members, 'remove' for removing members"
          },
          "path": {
            "type": "string",
            "title": "Path",
            "examples": [
              "/name",
              "/members"
            ],
            "description": "Property path to modify. Valid values: '/name' for workspace name, '/members' for team members"
          },
          "value": {
            "type": "string",
            "title": "Value",
            "examples": [
              "Updated Workspace Name",
              "user@example.com"
            ],
            "description": "New value for replace/add operations. For 'replace' with '/name', provide the new workspace name. For 'add' with '/members', provide the member email. Not used for 'remove' operations."
          }
        }
      },
      "title": "Operations",
      "examples": [
        [
          {
            "op": "replace",
            "path": "/name",
            "value": "Updated Workspace Name"
          }
        ],
        [
          {
            "op": "add",
            "path": "/members",
            "value": "user@example.com"
          }
        ],
        [
          {
            "op": "remove",
            "path": "/members",
            "value": "user@example.com"
          }
        ]
      ],
      "minItems": 1,
      "description": "List of patch operations to apply to the workspace. Each operation modifies a specific property."
    },
    "workspace_id": {
      "type": "string",
      "title": "Workspace Id",
      "examples": [
        "dZMAWB",
        "ucdZbu"
      ],
      "description": "Unique workspace identifier"
    }
  }
}
```

**Output schema:**
```json
{
  "type": "object",
  "$defs": {
    "WorkspaceSelf": {
      "type": "object",
      "title": "WorkspaceSelf",
      "properties": {
        "href": {
          "type": "string",
          "title": "Href",
          "description": "Link to the workspace"
        }
      }
    },
    "WorkspaceForms": {
      "type": "object",
      "title": "WorkspaceForms",
      "properties": {
        "href": {
          "type": "string",
          "title": "Href",
          "description": "Link to typeforms in the workspace"
        },
        "count": {
          "type": "integer",
          "title": "Count",
          "description": "Number of typeforms in the workspace"
        }
      }
    },
    "WorkspaceMember": {
      "type": "object",
      "title": "WorkspaceMember",
      "properties": {
        "name": {
          "type": "string",
          "title": "Name",
          "description": "Member name"
        },
        "role": {
          "enum": [
            "owner",
            "member"
          ],
          "type": "string",
          "title": "Role",
          "description": "Role assignment (owner or member)"
        },
        "email": {
          "type": "string",
          "title": "Email",
          "description": "Member email address"
        }
      }
    },
    "UpdateWorkspaceResponse": {
      "type": "object",
      "title": "UpdateWorkspaceResponse",
      "properties": {
        "id": {
          "type": "string",
          "title": "Id",
          "description": "Unique identifier for the workspace"
        },
        "name": {
          "type": "string",
          "title": "Name",
          "description": "Name of the workspace"
        },
        "self": {
          "type": "object",
          "title": "Self",
          "properties": {
            "href": {
              "type": "string",
              "title": "Href",
              "description": "Link to the workspace"
            }
          },
          "description": "Workspace reference link"
        },
        "forms": {
          "type": "object",
          "title": "Forms",
          "properties": {
            "href": {
              "type": "string",
              "title": "Href",
              "description": "Link to typeforms in the workspace"
            },
            "count": {
              "type": "integer",
              "title": "Count",
              "description": "Number of typeforms in the workspace"
            }
          },
          "description": "Forms information for the workspace"
        },
        "shared": {
          "type": "boolean",
          "title": "Shared",
          "description": "Indicates team sharing status"
        },
        "members": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "WorkspaceMember",
            "properties": {
              "name": {
                "type": "string",
                "title": "Name",
                "description": "Member name"
              },
              "role": {
                "enum": [
                  "owner",
                  "member"
                ],
                "type": "string",
                "title": "Role",
                "description": "Role assignment (owner or member)"
              },
              "email": {
                "type": "string",
                "title": "Email",
                "description": "Member email address"
              }
            }
          },
          "title": "Members",
          "description": "Team member details"
        },
        "account_id": {
          "type": "string",
          "title": "Account Id",
          "description": "ID in the ULID format of the account where workspace belongs to"
        }
      }
    }
  },
  "title": "UpdateWorkspaceResponseWrapper",
  "required": [
    "data",
    "successful"
  ],
  "properties": {
    "data": {
      "type": "object",
      "title": "Data",
      "properties": {
        "id": {
          "type": "string",
          "title": "Id",
          "description": "Unique identifier for the workspace"
        },
        "name": {
          "type": "string",
          "title": "Name",
          "description": "Name of the workspace"
        },
        "self": {
          "type": "object",
          "title": "Self",
          "properties": {
            "href": {
              "type": "string",
              "title": "Href",
              "description": "Link to the workspace"
            }
          },
          "description": "Workspace reference link"
        },
        "forms": {
          "type": "object",
          "title": "Forms",
          "properties": {
            "href": {
              "type": "string",
              "title": "Href",
              "description": "Link to typeforms in the workspace"
            },
            "count": {
              "type": "integer",
              "title": "Count",
              "description": "Number of typeforms in the workspace"
            }
          },
          "description": "Forms information for the workspace"
        },
        "shared": {
          "type": "boolean",
          "title": "Shared",
          "description": "Indicates team sharing status"
        },
        "members": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "WorkspaceMember",
            "properties": {
              "name": {
                "type": "string",
                "title": "Name",
                "description": "Member name"
              },
              "role": {
                "enum": [
                  "owner",
                  "member"
                ],
                "type": "string",
                "title": "Role",
                "description": "Role assignment (owner or member)"
              },
              "email": {
                "type": "string",
                "title": "Email",
                "description": "Member email address"
              }
            }
          },
          "title": "Members",
          "description": "Team member details"
        },
        "account_id": {
          "type": "string",
          "title": "Account Id",
          "description": "ID in the ULID format of the account where workspace belongs to"
        }
      },
      "description": "Data from the action execution"
    },
    "error": {
      "type": "string",
      "title": "Error",
      "description": "Error if any occurred during the execution of the action"
    },
    "successful": {
      "type": "boolean",
      "title": "Successful",
      "description": "Whether or not the action execution was successful or not"
    }
  }
}
```

## TYPEFORM_UPLOAD_VIDEO
Initiate a video upload to Typeform by obtaining a signed upload URL. Use this action to prepare for uploading a video file to a specific form field. After receiving the upload_url, use it to upload the actual video file via a PUT request.

**Input schema:**
```json
{
  "type": "object",
  "title": "TypeformUploadVideoRequest",
  "required": [
    "form_id",
    "field_id",
    "language"
  ],
  "properties": {
    "form_id": {
      "type": "string",
      "title": "Form Id",
      "examples": [
        "Y78g1cmS"
      ],
      "description": "Unique form identifier where the video will be attached"
    },
    "field_id": {
      "type": "string",
      "title": "Field Id",
      "examples": [
        "test_field"
      ],
      "description": "Field ID where the video media belongs within the form"
    },
    "language": {
      "type": "string",
      "title": "Language",
      "examples": [
        "en",
        "es",
        "fr"
      ],
      "description": "ISO 639-1 format language code for automatic transcription (e.g., 'en' for English, 'es' for Spanish)"
    }
  }
}
```

**Output schema:**
```json
{
  "type": "object",
  "$defs": {
    "TypeformUploadVideoResponse": {
      "type": "object",
      "title": "TypeformUploadVideoResponse",
      "required": [
        "id",
        "upload_url",
        "transcode_status"
      ],
      "properties": {
        "id": {
          "type": "string",
          "title": "Id",
          "description": "Unique media file identifier"
        },
        "upload_url": {
          "type": "string",
          "title": "Upload Url",
          "description": "Temporary signed URL for uploading video file via PUT request"
        },
        "transcode_status": {
          "type": "string",
          "title": "Transcode Status",
          "description": "Current transcoding status of the video"
        }
      }
    }
  },
  "title": "TypeformUploadVideoResponseWrapper",
  "required": [
    "data",
    "successful"
  ],
  "properties": {
    "data": {
      "type": "object",
      "title": "Data",
      "required": [
        "id",
        "upload_url",
        "transcode_status"
      ],
      "properties": {
        "id": {
          "type": "string",
          "title": "Id",
          "description": "Unique media file identifier"
        },
        "upload_url": {
          "type": "string",
          "title": "Upload Url",
          "description": "Temporary signed URL for uploading video file via PUT request"
        },
        "transcode_status": {
          "type": "string",
          "title": "Transcode Status",
          "description": "Current transcoding status of the video"
        }
      },
      "description": "Data from the action execution"
    },
    "error": {
      "type": "string",
      "title": "Error",
      "description": "Error if any occurred during the execution of the action"
    },
    "successful": {
      "type": "boolean",
      "title": "Successful",
      "description": "Whether or not the action execution was successful or not"
    }
  }
}
```
