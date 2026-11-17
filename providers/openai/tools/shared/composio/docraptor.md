# docraptor

## DOCRAPTOR_CREATE_ASYNC_DOC
Tool to create documents asynchronously from HTML content. Use when generating PDF, XLS, or XLSX documents and you need to poll for completion status or use a callback URL for notification. Returns a response containing an `id` field — store this value and pass it to DOCRAPTOR_GET_ASYNC_DOC_STATUS to poll for completion, then to DOCRAPTOR_GET_ASYNC_DOC to download the finished document.

**Input schema:**
```json
{
  "type": "object",
  "title": "CreateAsyncDocRequest",
  "required": [
    "name",
    "document_type"
  ],
  "properties": {
    "tag": {
      "type": "string",
      "title": "Tag",
      "examples": [
        "customer-123",
        "report-v2"
      ],
      "description": "Custom metadata for storage and tracking."
    },
    "help": {
      "type": "boolean",
      "title": "Help",
      "default": false,
      "description": "Request support assistance with this document."
    },
    "name": {
      "type": "string",
      "title": "Name",
      "examples": [
        "invoice-12345",
        "monthly-report"
      ],
      "description": "Identifier for the document."
    },
    "test": {
      "type": "boolean",
      "title": "Test",
      "default": true,
      "description": "Enable test mode which adds a watermark to the document."
    },
    "strict": {
      "enum": [
        "html",
        "none"
      ],
      "type": "string",
      "title": "Strict",
      "description": "Validation mode - must be one of: html, none."
    },
    "pipeline": {
      "type": "string",
      "title": "Pipeline",
      "description": "Specific DocRaptor Pipeline version to use."
    },
    "referrer": {
      "type": "string",
      "title": "Referrer",
      "description": "HTTP referrer header value to use when fetching assets."
    },
    "javascript": {
      "type": "boolean",
      "title": "Javascript",
      "default": false,
      "description": "Enable DocRaptor JavaScript parsing."
    },
    "callback_url": {
      "type": "string",
      "title": "Callback Url",
      "examples": [
        "https://example.com/webhook/docraptor"
      ],
      "description": "POST endpoint URL for completion notification."
    },
    "document_url": {
      "type": "string",
      "title": "Document Url",
      "examples": [
        "https://example.com/document.html"
      ],
      "description": "URL to fetch HTML content from. Alternative to document_content."
    },
    "document_type": {
      "enum": [
        "pdf",
        "xls",
        "xlsx"
      ],
      "type": "string",
      "title": "Document Type",
      "examples": [
        "pdf"
      ],
      "description": "Document format - must be one of: pdf, xls, xlsx."
    },
    "prince_options": {
      "type": "object",
      "title": "PrinceOptions",
      "properties": {
        "debug": {
          "type": "boolean",
          "title": "Debug",
          "description": "Enable Prince debug mode for troubleshooting."
        },
        "input": {
          "enum": [
            "html",
            "xml",
            "auto"
          ],
          "type": "string",
          "title": "Input",
          "description": "Input format - must be one of: html, xml, auto (default: html)."
        },
        "media": {
          "type": "string",
          "title": "Media",
          "examples": [
            "print",
            "screen"
          ],
          "description": "CSS media type to use (defaults to 'print')."
        },
        "baseurl": {
          "type": "string",
          "title": "Baseurl",
          "description": "Set the base URL for resolving relative asset paths."
        },
        "css_dpi": {
          "type": "integer",
          "title": "Css Dpi",
          "description": "DPI value to use when rendering CSS."
        },
        "encrypt": {
          "type": "boolean",
          "title": "Encrypt",
          "description": "Encrypt the PDF output."
        },
        "profile": {
          "type": "string",
          "title": "Profile",
          "examples": [
            "PDF/A-1b",
            "PDF/X-3"
          ],
          "description": "PDF profile specification (e.g., PDF/A, PDF/X)."
        },
        "insecure": {
          "type": "boolean",
          "title": "Insecure",
          "description": "Disable SSL certificate verification."
        },
        "key_bits": {
          "enum": [
            40,
            128
          ],
          "type": "integer",
          "title": "Key Bits",
          "description": "Encryption key length - must be one of: 40, 128."
        },
        "http_user": {
          "type": "string",
          "title": "Http User",
          "description": "Username for HTTP authentication when fetching assets."
        },
        "pdf_title": {
          "type": "string",
          "title": "Pdf Title",
          "description": "Document title to embed in PDF metadata."
        },
        "http_proxy": {
          "type": "string",
          "title": "Http Proxy",
          "description": "HTTP proxy server to use for asset requests."
        },
        "javascript": {
          "type": "boolean",
          "title": "Javascript",
          "description": "Enable PrinceXML JavaScript processing."
        },
        "no_network": {
          "type": "boolean",
          "title": "No Network",
          "description": "Disable all network access during rendering."
        },
        "no_compress": {
          "type": "boolean",
          "title": "No Compress",
          "description": "Disable PDF compression."
        },
        "no_xinclude": {
          "type": "boolean",
          "title": "No Xinclude",
          "description": "Disable XML inclusion processing."
        },
        "http_timeout": {
          "type": "integer",
          "title": "Http Timeout",
          "description": "HTTP request timeout in seconds."
        },
        "disallow_copy": {
          "type": "boolean",
          "title": "Disallow Copy",
          "description": "Prevent copying content from the PDF."
        },
        "http_password": {
          "type": "string",
          "title": "Http Password",
          "description": "Password for HTTP authentication when fetching assets."
        },
        "user_password": {
          "type": "string",
          "title": "User Password",
          "description": "Password required to open the PDF."
        },
        "disallow_print": {
          "type": "boolean",
          "title": "Disallow Print",
          "description": "Prevent printing of the PDF."
        },
        "no_embed_fonts": {
          "type": "boolean",
          "title": "No Embed Fonts",
          "description": "Disable font embedding in PDF output."
        },
        "owner_password": {
          "type": "string",
          "title": "Owner Password",
          "description": "Password required to modify PDF permissions."
        },
        "disallow_modify": {
          "type": "boolean",
          "title": "Disallow Modify",
          "description": "Prevent modification of the PDF."
        },
        "no_author_style": {
          "type": "boolean",
          "title": "No Author Style",
          "description": "Ignore author stylesheets in the HTML."
        },
        "no_subset_fonts": {
          "type": "boolean",
          "title": "No Subset Fonts",
          "description": "Disable font subsetting in PDF output."
        },
        "no_default_style": {
          "type": "boolean",
          "title": "No Default Style",
          "description": "Ignore default browser stylesheets."
        },
        "disallow_annotate": {
          "type": "boolean",
          "title": "Disallow Annotate",
          "description": "Prevent annotation of the PDF."
        },
        "no_parallel_downloads": {
          "type": "boolean",
          "title": "No Parallel Downloads",
          "description": "Disable parallel fetching of assets during PDF creation."
        }
      },
      "description": "Advanced rendering configuration options for PrinceXML.",
      "additionalProperties": false
    },
    "document_content": {
      "type": "string",
      "title": "Document Content",
      "examples": [
        "<html><body><h1>Hello World</h1></body></html>"
      ],
      "description": "HTML content to transform. Required unless document_url is provided. Mutually exclusive with `document_url` \u2014 supplying both causes a validation failure."
    },
    "hosted_expires_at": {
      "type": "string",
      "title": "Hosted Expires At",
      "examples": [
        "2024-12-31T23:59:59Z"
      ],
      "description": "ISO 8601 datetime when hosted document expires."
    },
    "hosted_download_limit": {
      "type": "integer",
      "title": "Hosted Download Limit",
      "description": "Maximum number of downloads allowed for hosted document."
    },
    "ignore_resource_errors": {
      "type": "boolean",
      "title": "Ignore Resource Errors",
      "default": true,
      "description": "Continue processing if asset loading fails."
    },
    "ignore_console_messages": {
      "type": "boolean",
      "title": "Ignore Console Messages",
      "default": false,
      "description": "Prevent console.log from interrupting rendering."
    }
  },
  "description": "Request model for creating a document asynchronously."
}
```

**Output schema:**
```json
{
  "type": "object",
  "$defs": {
    "CreateAsyncDocResponse": {
      "type": "object",
      "title": "CreateAsyncDocResponse",
      "required": [
        "status_id"
      ],
      "properties": {
        "status_id": {
          "type": "string",
          "title": "Status Id",
          "description": "Unique identifier for polling document status via the status API endpoint."
        }
      },
      "description": "Response model for async document creation."
    }
  },
  "title": "CreateAsyncDocResponseWrapper",
  "required": [
    "data",
    "successful"
  ],
  "properties": {
    "data": {
      "type": "object",
      "title": "Data",
      "required": [
        "status_id"
      ],
      "properties": {
        "status_id": {
          "type": "string",
          "title": "Status Id",
          "description": "Unique identifier for polling document status via the status API endpoint."
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

## DOCRAPTOR_CREATE_DOC
Tool to create a PDF or Excel document synchronously from HTML content or URL. Use when you need to generate a document file from HTML data. The document is returned immediately as a downloadable file. Either document_content or document_url must be provided, but not both.

**Input schema:**
```json
{
  "type": "object",
  "title": "DocraptorCreateDocRequest",
  "required": [
    "name",
    "document_type"
  ],
  "properties": {
    "tag": {
      "type": "string",
      "title": "Tag",
      "description": "A field for storing a small amount of metadata with this document."
    },
    "help": {
      "type": "boolean",
      "title": "Help",
      "description": "Request support help with this request if it succeeds (default: false)."
    },
    "name": {
      "type": "string",
      "title": "Name",
      "examples": [
        "my-document",
        "invoice-12345"
      ],
      "description": "A name for identifying your document."
    },
    "test": {
      "type": "boolean",
      "title": "Test",
      "default": true,
      "description": "Enable test mode for this document (adds watermark). Set to false for production documents."
    },
    "strict": {
      "enum": [
        "html",
        "none"
      ],
      "type": "string",
      "title": "Strict",
      "description": "HTML validation mode - none or html."
    },
    "pipeline": {
      "type": "string",
      "title": "Pipeline",
      "description": "Specify a specific version of the DocRaptor Pipeline."
    },
    "referrer": {
      "type": "string",
      "title": "Referrer",
      "description": "Set HTTP referrer when generating this document."
    },
    "javascript": {
      "type": "boolean",
      "title": "Javascript",
      "description": "Enable DocRaptor JavaScript parsing (default: false)."
    },
    "callback_url": {
      "type": "string",
      "title": "Callback Url",
      "description": "POST URL for async completion notifications."
    },
    "document_url": {
      "type": "string",
      "title": "Document Url",
      "examples": [
        "https://example.com/page-to-convert"
      ],
      "description": "The URL to fetch the HTML data to be transformed. Required if document_content is not provided. Mutually exclusive with document_content."
    },
    "document_type": {
      "enum": [
        "pdf",
        "xls",
        "xlsx"
      ],
      "type": "string",
      "title": "Document Type",
      "description": "Output format - pdf for PDF documents, xls for Excel 97-2003, or xlsx for modern Excel."
    },
    "prince_options": {
      "type": "object",
      "title": "PrinceOptions",
      "properties": {
        "debug": {
          "type": "boolean",
          "title": "Debug",
          "description": "Enable Prince debug mode."
        },
        "input": {
          "enum": [
            "html",
            "xml",
            "auto"
          ],
          "type": "string",
          "title": "Input",
          "description": "Format specification - html, xml, or auto (default: html)."
        },
        "media": {
          "type": "string",
          "title": "Media",
          "examples": [
            "print",
            "screen"
          ],
          "description": "CSS media type specification (default: print)."
        },
        "baseurl": {
          "type": "string",
          "title": "Baseurl",
          "description": "Set the baseurl for assets."
        },
        "css_dpi": {
          "type": "integer",
          "title": "Css Dpi",
          "description": "Set the DPI when rendering CSS."
        },
        "encrypt": {
          "type": "boolean",
          "title": "Encrypt",
          "description": "Encrypt PDF output."
        },
        "profile": {
          "type": "string",
          "title": "Profile",
          "description": "PDF profile specification (e.g., PDF/A-1b, PDF/X-1a)."
        },
        "version": {
          "type": "string",
          "title": "Version",
          "description": "Deprecated; use pipeline parameter instead."
        },
        "insecure": {
          "type": "boolean",
          "title": "Insecure",
          "description": "Disable SSL verification."
        },
        "key_bits": {
          "type": "integer",
          "title": "Key Bits",
          "examples": [
            40,
            128
          ],
          "description": "Encryption size - 40 or 128."
        },
        "http_user": {
          "type": "string",
          "title": "Http User",
          "description": "Set the user for HTTP authentication."
        },
        "pdf_title": {
          "type": "string",
          "title": "Pdf Title",
          "description": "Specify the PDF title, part of the document metadata."
        },
        "http_proxy": {
          "type": "string",
          "title": "Http Proxy",
          "description": "Set the HTTP proxy server."
        },
        "javascript": {
          "type": "boolean",
          "title": "Javascript",
          "description": "Enable PrinceXML JavaScript."
        },
        "no_network": {
          "type": "boolean",
          "title": "No Network",
          "description": "Disable network access."
        },
        "no_compress": {
          "type": "boolean",
          "title": "No Compress",
          "description": "Disable PDF compression."
        },
        "no_xinclude": {
          "type": "boolean",
          "title": "No Xinclude",
          "description": "Disable XML inclusion."
        },
        "http_timeout": {
          "type": "integer",
          "title": "Http Timeout",
          "description": "Set the HTTP request timeout in seconds."
        },
        "disallow_copy": {
          "type": "boolean",
          "title": "Disallow Copy",
          "description": "Disallow copying of this PDF."
        },
        "http_password": {
          "type": "string",
          "title": "Http Password",
          "description": "Set the password for HTTP authentication."
        },
        "user_password": {
          "type": "string",
          "title": "User Password",
          "description": "Set the PDF user password."
        },
        "disallow_print": {
          "type": "boolean",
          "title": "Disallow Print",
          "description": "Disallow printing of this PDF."
        },
        "no_embed_fonts": {
          "type": "boolean",
          "title": "No Embed Fonts",
          "description": "Disable font embedding in PDFs."
        },
        "owner_password": {
          "type": "string",
          "title": "Owner Password",
          "description": "Set the PDF owner password."
        },
        "disallow_modify": {
          "type": "boolean",
          "title": "Disallow Modify",
          "description": "Disallow modification of this PDF."
        },
        "no_author_style": {
          "type": "boolean",
          "title": "No Author Style",
          "description": "Ignore author stylesheets."
        },
        "no_subset_fonts": {
          "type": "boolean",
          "title": "No Subset Fonts",
          "description": "Disable font subsetting in PDFs."
        },
        "no_default_style": {
          "type": "boolean",
          "title": "No Default Style",
          "description": "Ignore default stylesheets."
        },
        "disallow_annotate": {
          "type": "boolean",
          "title": "Disallow Annotate",
          "description": "Disallow annotation of this PDF."
        },
        "no_parallel_downloads": {
          "type": "boolean",
          "title": "No Parallel Downloads",
          "description": "Disables parallel fetching of assets."
        }
      },
      "description": "Advanced rendering configuration options for PrinceXML engine.",
      "additionalProperties": false
    },
    "document_content": {
      "type": "string",
      "title": "Document Content",
      "examples": [
        "<html><body><h1>Hello World</h1></body></html>"
      ],
      "description": "The HTML data to be transformed into a document. Required if document_url is not provided. Mutually exclusive with document_url."
    },
    "hosted_expires_at": {
      "type": "string",
      "title": "Hosted Expires At",
      "examples": [
        "2024-12-31T23:59:59Z"
      ],
      "description": "ISO 8601 datetime when hosted document becomes unavailable."
    },
    "hosted_download_limit": {
      "type": "integer",
      "title": "Hosted Download Limit",
      "description": "Number of times a hosted document can be downloaded."
    },
    "ignore_resource_errors": {
      "type": "boolean",
      "title": "Ignore Resource Errors",
      "description": "Failed loading of images/javascripts/stylesheets/etc will not cause rendering to stop (default: true)."
    },
    "ignore_console_messages": {
      "type": "boolean",
      "title": "Ignore Console Messages",
      "description": "Prevent console.log from stopping document rendering (default: false)."
    }
  },
  "description": "Request parameters for creating a PDF or Excel document from HTML."
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
    "DocraptorCreateDocResponse": {
      "type": "object",
      "title": "DocraptorCreateDocResponse",
      "required": [
        "document"
      ],
      "properties": {
        "document": {
          "type": "object",
          "title": "Document",
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
          "description": "The generated PDF, XLS, or XLSX document file."
        }
      },
      "description": "Response containing the generated document file."
    }
  },
  "title": "DocraptorCreateDocResponseWrapper",
  "required": [
    "data",
    "successful"
  ],
  "properties": {
    "data": {
      "type": "object",
      "title": "Data",
      "required": [
        "document"
      ],
      "properties": {
        "document": {
          "type": "object",
          "title": "Document",
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
          "description": "The generated PDF, XLS, or XLSX document file."
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

## DOCRAPTOR_CREATE_DOCUMENT_FROM_REFERRER
Tool to convert webpages into documents using referrer-based authentication without an API key. Use when you need to generate PDFs or Excel files from registered domains without explicit API credentials.

**Input schema:**
```json
{
  "type": "object",
  "title": "CreateDocumentFromReferrerRequest",
  "properties": {
    "name": {
      "type": "string",
      "title": "Name",
      "examples": [
        "report.pdf",
        "spreadsheet.xls"
      ],
      "description": "Document filename to use for the generated file."
    },
    "type": {
      "enum": [
        "pdf",
        "xls"
      ],
      "type": "string",
      "title": "Type",
      "default": "pdf",
      "examples": [
        "pdf",
        "xls"
      ],
      "description": "Output format for the document. Choose 'pdf' for PDF documents or 'xls' for Excel spreadsheets."
    },
    "javascript": {
      "type": "boolean",
      "title": "Javascript",
      "examples": [
        true,
        false
      ],
      "description": "Enable JavaScript processing on the page before conversion. Set to true to execute JavaScript on the page."
    },
    "prince_option_media": {
      "type": "string",
      "title": "Prince Option Media",
      "examples": [
        "screen",
        "print"
      ],
      "description": "CSS media type to use for rendering, such as 'screen' or 'print'. This affects which stylesheets are applied."
    }
  },
  "description": "Request model for creating documents via referrer authentication."
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
    "CreateDocumentFromReferrerResponse": {
      "type": "object",
      "title": "CreateDocumentFromReferrerResponse",
      "required": [
        "content"
      ],
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
          "description": "The generated document file (PDF or Excel) as binary content."
        }
      },
      "description": "Response model containing the generated document file."
    }
  },
  "title": "CreateDocumentFromReferrerResponseWrapper",
  "required": [
    "data",
    "successful"
  ],
  "properties": {
    "data": {
      "type": "object",
      "title": "Data",
      "required": [
        "content"
      ],
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
          "description": "The generated document file (PDF or Excel) as binary content."
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

## DOCRAPTOR_CREATE_HOSTED_ASYNC_DOC
Tool to create a hosted document asynchronously. Use when you need to generate a PDF, XLS, or XLSX document and track its completion status via callback_url or the status API.

**Input schema:**
```json
{
  "type": "object",
  "title": "CreateHostedAsyncDocRequest",
  "required": [
    "name",
    "document_type"
  ],
  "properties": {
    "tag": {
      "type": "string",
      "title": "Tag",
      "description": "Small metadata storage field."
    },
    "help": {
      "type": "boolean",
      "title": "Help",
      "description": "Requests support assistance; defaults to false."
    },
    "name": {
      "type": "string",
      "title": "Name",
      "examples": [
        "test-hosted-async-doc"
      ],
      "description": "Identifier for the document."
    },
    "test": {
      "type": "boolean",
      "title": "Test",
      "description": "Enables test mode with watermark; defaults to true."
    },
    "strict": {
      "enum": [
        "html",
        "none"
      ],
      "type": "string",
      "title": "Strict",
      "description": "HTML validation - 'none' or 'html'."
    },
    "pipeline": {
      "type": "string",
      "title": "Pipeline",
      "description": "Specifies DocRaptor pipeline version."
    },
    "referrer": {
      "type": "string",
      "title": "Referrer",
      "description": "Sets HTTP referrer header."
    },
    "javascript": {
      "type": "boolean",
      "title": "Javascript",
      "description": "Enables DocRaptor JavaScript parsing; defaults to false."
    },
    "callback_url": {
      "type": "string",
      "title": "Callback Url",
      "description": "POST endpoint for async completion notifications."
    },
    "document_url": {
      "type": "string",
      "title": "Document Url",
      "examples": [
        "https://example.com/page.html"
      ],
      "description": "URL to fetch HTML content. Alternative to document_content."
    },
    "document_type": {
      "enum": [
        "pdf",
        "xls",
        "xlsx"
      ],
      "type": "string",
      "title": "Document Type",
      "examples": [
        "pdf"
      ],
      "description": "Type of output document - pdf, xls, or xlsx."
    },
    "prince_options": {
      "type": "object",
      "title": "PrinceOptions",
      "properties": {
        "debug": {
          "type": "boolean",
          "title": "Debug",
          "description": "Enable Prince debug mode."
        },
        "input": {
          "enum": [
            "html",
            "xml",
            "auto"
          ],
          "type": "string",
          "title": "Input",
          "description": "Input type; must be html, xml, or auto; defaults to 'html'."
        },
        "media": {
          "type": "string",
          "title": "Media",
          "description": "Specify the CSS media type; defaults to 'print'."
        },
        "baseurl": {
          "type": "string",
          "title": "Baseurl",
          "description": "Set the baseurl for assets."
        },
        "css_dpi": {
          "type": "integer",
          "title": "Css Dpi",
          "description": "DPI setting for CSS rendering."
        },
        "encrypt": {
          "type": "boolean",
          "title": "Encrypt",
          "description": "Encrypt PDF output."
        },
        "profile": {
          "type": "string",
          "title": "Profile",
          "description": "PDF profile specification."
        },
        "insecure": {
          "type": "boolean",
          "title": "Insecure",
          "description": "Disable SSL verification."
        },
        "key_bits": {
          "enum": [
            40,
            128
          ],
          "type": "integer",
          "title": "Key Bits",
          "description": "Encryption key bits; must be either 40 or 128."
        },
        "http_user": {
          "type": "string",
          "title": "Http User",
          "description": "Set the user for HTTP authentication."
        },
        "pdf_title": {
          "type": "string",
          "title": "Pdf Title",
          "description": "Specify the PDF title, part of the document's metadata."
        },
        "http_proxy": {
          "type": "string",
          "title": "Http Proxy",
          "description": "Set the HTTP proxy server."
        },
        "javascript": {
          "type": "boolean",
          "title": "Javascript",
          "description": "Enable PrinceXML JavaScript."
        },
        "no_network": {
          "type": "boolean",
          "title": "No Network",
          "description": "Disable network access."
        },
        "no_compress": {
          "type": "boolean",
          "title": "No Compress",
          "description": "Disable PDF compression."
        },
        "no_xinclude": {
          "type": "boolean",
          "title": "No Xinclude",
          "description": "Disable XML inclusion."
        },
        "http_timeout": {
          "type": "integer",
          "title": "Http Timeout",
          "description": "Set the HTTP request timeout in seconds."
        },
        "disallow_copy": {
          "type": "boolean",
          "title": "Disallow Copy",
          "description": "Disallow copying of this PDF."
        },
        "http_password": {
          "type": "string",
          "title": "Http Password",
          "description": "Set the password for HTTP authentication."
        },
        "user_password": {
          "type": "string",
          "title": "User Password",
          "description": "Set the PDF user password."
        },
        "disallow_print": {
          "type": "boolean",
          "title": "Disallow Print",
          "description": "Disallow printing of this PDF."
        },
        "no_embed_fonts": {
          "type": "boolean",
          "title": "No Embed Fonts",
          "description": "Disable font embedding in PDFs."
        },
        "owner_password": {
          "type": "string",
          "title": "Owner Password",
          "description": "Set the PDF owner password."
        },
        "disallow_modify": {
          "type": "boolean",
          "title": "Disallow Modify",
          "description": "Disallow modification of this PDF."
        },
        "no_author_style": {
          "type": "boolean",
          "title": "No Author Style",
          "description": "Ignore author stylesheets."
        },
        "no_subset_fonts": {
          "type": "boolean",
          "title": "No Subset Fonts",
          "description": "Disable font subsetting in PDFs."
        },
        "no_default_style": {
          "type": "boolean",
          "title": "No Default Style",
          "description": "Ignore default stylesheets."
        },
        "disallow_annotate": {
          "type": "boolean",
          "title": "Disallow Annotate",
          "description": "Disallow annotation of this PDF."
        },
        "no_parallel_downloads": {
          "type": "boolean",
          "title": "No Parallel Downloads",
          "description": "Disables parallel fetching of assets."
        }
      },
      "description": "Advanced rendering configuration options for PrinceXML.",
      "additionalProperties": false
    },
    "document_content": {
      "type": "string",
      "title": "Document Content",
      "examples": [
        "<html><body><h1>Hello World</h1></body></html>"
      ],
      "description": "HTML data for transformation. Required if document_url is not provided."
    },
    "hosted_expires_at": {
      "type": "string",
      "title": "Hosted Expires At",
      "description": "ISO 8601 datetime for document expiration."
    },
    "hosted_download_limit": {
      "type": "integer",
      "title": "Hosted Download Limit",
      "description": "Maximum download count for hosted docs."
    },
    "ignore_resource_errors": {
      "type": "boolean",
      "title": "Ignore Resource Errors",
      "description": "Continues rendering if assets fail; defaults to true."
    },
    "ignore_console_messages": {
      "type": "boolean",
      "title": "Ignore Console Messages",
      "description": "Prevents console.log interruptions; defaults to false."
    }
  },
  "description": "Request parameters for creating a hosted document asynchronously."
}
```

**Output schema:**
```json
{
  "type": "object",
  "$defs": {
    "CreateHostedAsyncDocResponse": {
      "type": "object",
      "title": "CreateHostedAsyncDocResponse",
      "required": [
        "status_id"
      ],
      "properties": {
        "status_id": {
          "type": "string",
          "title": "Status Id",
          "examples": [
            "abc123xyz"
          ],
          "description": "The identifier used to get the status of the document using the status API."
        }
      },
      "description": "Response schema for hosted async document creation."
    }
  },
  "title": "CreateHostedAsyncDocResponseWrapper",
  "required": [
    "data",
    "successful"
  ],
  "properties": {
    "data": {
      "type": "object",
      "title": "Data",
      "required": [
        "status_id"
      ],
      "properties": {
        "status_id": {
          "type": "string",
          "title": "Status Id",
          "examples": [
            "abc123xyz"
          ],
          "description": "The identifier used to get the status of the document using the status API."
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

## DOCRAPTOR_GET_ASYNC_DOC
Tool to download a completed asynchronous document using the download URL from status response. Use when you have a download_id and need to retrieve the generated document file.

**Input schema:**
```json
{
  "type": "object",
  "title": "GetAsyncDocRequest",
  "required": [
    "id"
  ],
  "properties": {
    "id": {
      "type": "string",
      "title": "Id",
      "examples": [
        "23ca69fe-3215-4b2d-a502-1c65007b7541"
      ],
      "description": "The download_id returned from an async status request or callback. Same id value returned by DOCRAPTOR_CREATE_ASYNC_DOC; use DOCRAPTOR_GET_ASYNC_DOC_STATUS to poll until complete before calling this tool."
    }
  },
  "description": "Request model for downloading a completed asynchronous document."
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
    "GetAsyncDocResponse": {
      "type": "object",
      "title": "GetAsyncDocResponse",
      "required": [
        "file"
      ],
      "properties": {
        "file": {
          "type": "object",
          "title": "File",
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
          "description": "Downloaded document file (PDF, XLS, or XLSX depending on original document_type)."
        }
      },
      "description": "Response model containing the downloaded document file."
    }
  },
  "title": "GetAsyncDocResponseWrapper",
  "required": [
    "data",
    "successful"
  ],
  "properties": {
    "data": {
      "type": "object",
      "title": "Data",
      "required": [
        "file"
      ],
      "properties": {
        "file": {
          "type": "object",
          "title": "File",
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
          "description": "Downloaded document file (PDF, XLS, or XLSX depending on original document_type)."
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

## DOCRAPTOR_GET_ASYNC_DOC_STATUS
Tool to check the status of an asynchronously created document. Use when monitoring progress of async documents by polling for completion status.

**Input schema:**
```json
{
  "type": "object",
  "title": "GetAsyncDocStatusRequest",
  "required": [
    "id"
  ],
  "properties": {
    "id": {
      "type": "string",
      "title": "Id",
      "examples": [
        "ae930e32-cac7-4cad-a630-eafb1de8edf7"
      ],
      "description": "The status_id returned when creating an asynchronous document. Returned by DOCRAPTOR_CREATE_ASYNC_DOC; store immediately as the same id is also required by DOCRAPTOR_GET_ASYNC_DOC to download the completed document."
    }
  },
  "description": "Request model for checking the status of an asynchronously created document."
}
```

**Output schema:**
```json
{
  "type": "object",
  "$defs": {
    "GetAsyncDocStatusResponse": {
      "type": "object",
      "title": "GetAsyncDocStatusResponse",
      "required": [
        "status"
      ],
      "properties": {
        "status": {
          "type": "string",
          "title": "Status",
          "description": "Current document state. Possible values: queued, working, completed, failed."
        },
        "message": {
          "type": "string",
          "title": "Message",
          "description": "Supplementary details or error information."
        },
        "download_id": {
          "type": "string",
          "title": "Download Id",
          "description": "Identifier for use with the download API. Only present when status is completed."
        },
        "download_url": {
          "type": "string",
          "title": "Download Url",
          "description": "Retrieval location for the finished document. Only present when status is completed."
        },
        "number_of_pages": {
          "type": "integer",
          "title": "Number Of Pages",
          "description": "Page count in PDF output. Only present when status is completed."
        },
        "validation_errors": {
          "type": "string",
          "title": "Validation Errors",
          "description": "Details about any validation issues."
        }
      },
      "description": "Response model containing the status and details of an asynchronous document."
    }
  },
  "title": "GetAsyncDocStatusResponseWrapper",
  "required": [
    "data",
    "successful"
  ],
  "properties": {
    "data": {
      "type": "object",
      "title": "Data",
      "required": [
        "status"
      ],
      "properties": {
        "status": {
          "type": "string",
          "title": "Status",
          "description": "Current document state. Possible values: queued, working, completed, failed."
        },
        "message": {
          "type": "string",
          "title": "Message",
          "description": "Supplementary details or error information."
        },
        "download_id": {
          "type": "string",
          "title": "Download Id",
          "description": "Identifier for use with the download API. Only present when status is completed."
        },
        "download_url": {
          "type": "string",
          "title": "Download Url",
          "description": "Retrieval location for the finished document. Only present when status is completed."
        },
        "number_of_pages": {
          "type": "integer",
          "title": "Number Of Pages",
          "description": "Page count in PDF output. Only present when status is completed."
        },
        "validation_errors": {
          "type": "string",
          "title": "Validation Errors",
          "description": "Details about any validation issues."
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

## DOCRAPTOR_LIST_DOCUMENTS_JSON
Tool to retrieve a paginated list of previously created documents with metadata in JSON format. Use when you need to see document creation history or query past documents.

**Input schema:**
```json
{
  "type": "object",
  "title": "ListDocumentsJsonRequest",
  "properties": {
    "page": {
      "type": "integer",
      "title": "Page",
      "default": 1,
      "minimum": 1,
      "examples": [
        1,
        2,
        3
      ],
      "description": "Specifies which page of results to return for pagination. Default is 1."
    },
    "per_page": {
      "type": "integer",
      "title": "Per Page",
      "default": 100,
      "minimum": 1,
      "examples": [
        10,
        50,
        100
      ],
      "description": "Number of documents per page to return. Default is 100."
    }
  },
  "description": "Request model for listing documents with pagination support."
}
```

**Output schema:**
```json
{
  "type": "object",
  "$defs": {
    "DocumentMetadata": {
      "type": "object",
      "title": "DocumentMetadata",
      "properties": {
        "id": {
          "type": "integer",
          "title": "Id",
          "description": "Unique document identifier."
        },
        "tag": {
          "type": "string",
          "title": "Tag",
          "description": "Custom tag associated with the document."
        },
        "name": {
          "type": "string",
          "title": "Name",
          "description": "Document name/filename."
        },
        "test": {
          "type": "boolean",
          "title": "Test",
          "description": "Whether the document was created in test mode."
        },
        "strict": {
          "type": "string",
          "title": "Strict",
          "description": "Validation mode used."
        },
        "success": {
          "type": "boolean",
          "title": "Success",
          "description": "Whether the document conversion was successful."
        },
        "async_mode": {
          "type": "boolean",
          "title": "Async Mode",
          "description": "Whether asynchronous processing was used."
        },
        "created_at": {
          "type": "string",
          "title": "Created At",
          "description": "Document creation timestamp."
        },
        "input_size": {
          "type": "integer",
          "title": "Input Size",
          "description": "Size of source HTML in bytes."
        },
        "ip_address": {
          "type": "string",
          "title": "Ip Address",
          "description": "IP address of the request origin."
        },
        "javascript": {
          "type": "boolean",
          "title": "Javascript",
          "description": "Whether JavaScript execution was enabled."
        },
        "output_size": {
          "type": "integer",
          "title": "Output Size",
          "description": "Size of generated document in bytes."
        },
        "document_url": {
          "type": "string",
          "title": "Document Url",
          "description": "Source URL that was converted."
        },
        "document_type": {
          "type": "string",
          "title": "Document Type",
          "description": "Type of document (e.g., 'pdf', 'excel')."
        },
        "generation_time": {
          "type": "number",
          "title": "Generation Time",
          "description": "Processing duration in seconds."
        }
      },
      "description": "Metadata for a single document."
    },
    "ListDocumentsJsonResponse": {
      "type": "object",
      "title": "ListDocumentsJsonResponse",
      "required": [
        "documents"
      ],
      "properties": {
        "documents": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "DocumentMetadata",
            "properties": {
              "id": {
                "type": "integer",
                "title": "Id",
                "description": "Unique document identifier."
              },
              "tag": {
                "type": "string",
                "title": "Tag",
                "description": "Custom tag associated with the document."
              },
              "name": {
                "type": "string",
                "title": "Name",
                "description": "Document name/filename."
              },
              "test": {
                "type": "boolean",
                "title": "Test",
                "description": "Whether the document was created in test mode."
              },
              "strict": {
                "type": "string",
                "title": "Strict",
                "description": "Validation mode used."
              },
              "success": {
                "type": "boolean",
                "title": "Success",
                "description": "Whether the document conversion was successful."
              },
              "async_mode": {
                "type": "boolean",
                "title": "Async Mode",
                "description": "Whether asynchronous processing was used."
              },
              "created_at": {
                "type": "string",
                "title": "Created At",
                "description": "Document creation timestamp."
              },
              "input_size": {
                "type": "integer",
                "title": "Input Size",
                "description": "Size of source HTML in bytes."
              },
              "ip_address": {
                "type": "string",
                "title": "Ip Address",
                "description": "IP address of the request origin."
              },
              "javascript": {
                "type": "boolean",
                "title": "Javascript",
                "description": "Whether JavaScript execution was enabled."
              },
              "output_size": {
                "type": "integer",
                "title": "Output Size",
                "description": "Size of generated document in bytes."
              },
              "document_url": {
                "type": "string",
                "title": "Document Url",
                "description": "Source URL that was converted."
              },
              "document_type": {
                "type": "string",
                "title": "Document Type",
                "description": "Type of document (e.g., 'pdf', 'excel')."
              },
              "generation_time": {
                "type": "number",
                "title": "Generation Time",
                "description": "Processing duration in seconds."
              }
            },
            "description": "Metadata for a single document."
          },
          "title": "Documents",
          "description": "List of document metadata objects ordered by creation date (most recent first)."
        }
      },
      "description": "Response model containing list of document metadata."
    }
  },
  "title": "ListDocumentsJsonResponseWrapper",
  "required": [
    "data",
    "successful"
  ],
  "properties": {
    "data": {
      "type": "object",
      "title": "Data",
      "required": [
        "documents"
      ],
      "properties": {
        "documents": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "DocumentMetadata",
            "properties": {
              "id": {
                "type": "integer",
                "title": "Id",
                "description": "Unique document identifier."
              },
              "tag": {
                "type": "string",
                "title": "Tag",
                "description": "Custom tag associated with the document."
              },
              "name": {
                "type": "string",
                "title": "Name",
                "description": "Document name/filename."
              },
              "test": {
                "type": "boolean",
                "title": "Test",
                "description": "Whether the document was created in test mode."
              },
              "strict": {
                "type": "string",
                "title": "Strict",
                "description": "Validation mode used."
              },
              "success": {
                "type": "boolean",
                "title": "Success",
                "description": "Whether the document conversion was successful."
              },
              "async_mode": {
                "type": "boolean",
                "title": "Async Mode",
                "description": "Whether asynchronous processing was used."
              },
              "created_at": {
                "type": "string",
                "title": "Created At",
                "description": "Document creation timestamp."
              },
              "input_size": {
                "type": "integer",
                "title": "Input Size",
                "description": "Size of source HTML in bytes."
              },
              "ip_address": {
                "type": "string",
                "title": "Ip Address",
                "description": "IP address of the request origin."
              },
              "javascript": {
                "type": "boolean",
                "title": "Javascript",
                "description": "Whether JavaScript execution was enabled."
              },
              "output_size": {
                "type": "integer",
                "title": "Output Size",
                "description": "Size of generated document in bytes."
              },
              "document_url": {
                "type": "string",
                "title": "Document Url",
                "description": "Source URL that was converted."
              },
              "document_type": {
                "type": "string",
                "title": "Document Type",
                "description": "Type of document (e.g., 'pdf', 'excel')."
              },
              "generation_time": {
                "type": "number",
                "title": "Generation Time",
                "description": "Processing duration in seconds."
              }
            },
            "description": "Metadata for a single document."
          },
          "title": "Documents",
          "description": "List of document metadata objects ordered by creation date (most recent first)."
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

## DOCRAPTOR_LIST_DOCUMENTS_XML
Tool to retrieve a paginated list of previously created documents with metadata in XML format. Use when you need to see document creation history or query past documents in XML format.

**Input schema:**
```json
{
  "type": "object",
  "title": "ListDocumentsXmlRequest",
  "properties": {
    "page": {
      "type": "integer",
      "title": "Page",
      "default": 1,
      "minimum": 1,
      "examples": [
        1,
        2,
        3
      ],
      "description": "Specifies which page of results to return for pagination. Default is 1."
    },
    "per_page": {
      "type": "integer",
      "title": "Per Page",
      "default": 100,
      "maximum": 100,
      "minimum": 1,
      "examples": [
        10,
        50,
        100
      ],
      "description": "Number of documents per page to return. Default is 100. Maximum is 100."
    }
  },
  "description": "Request model for listing documents with pagination support."
}
```

**Output schema:**
```json
{
  "type": "object",
  "$defs": {
    "DocumentMetadata": {
      "type": "object",
      "title": "DocumentMetadata",
      "properties": {
        "id": {
          "type": "integer",
          "title": "Id",
          "description": "Unique document identifier."
        },
        "tag": {
          "type": "string",
          "title": "Tag",
          "description": "Custom tag associated with the document."
        },
        "name": {
          "type": "string",
          "title": "Name",
          "description": "Document name/filename."
        },
        "test": {
          "type": "boolean",
          "title": "Test",
          "description": "Whether the document was created in test mode."
        },
        "strict": {
          "type": "string",
          "title": "Strict",
          "description": "Validation mode used."
        },
        "success": {
          "type": "boolean",
          "title": "Success",
          "description": "Whether the document conversion was successful."
        },
        "async_mode": {
          "type": "boolean",
          "title": "Async Mode",
          "description": "Whether asynchronous processing was used."
        },
        "created_at": {
          "type": "string",
          "title": "Created At",
          "description": "Document creation timestamp."
        },
        "input_size": {
          "type": "integer",
          "title": "Input Size",
          "description": "Size of source HTML in bytes."
        },
        "ip_address": {
          "type": "string",
          "title": "Ip Address",
          "description": "IP address of the request origin."
        },
        "javascript": {
          "type": "boolean",
          "title": "Javascript",
          "description": "Whether JavaScript execution was enabled."
        },
        "output_size": {
          "type": "integer",
          "title": "Output Size",
          "description": "Size of generated document in bytes."
        },
        "document_url": {
          "type": "string",
          "title": "Document Url",
          "description": "Source URL that was converted."
        },
        "document_type": {
          "type": "string",
          "title": "Document Type",
          "description": "Type of document (e.g., 'pdf', 'excel')."
        },
        "generation_time": {
          "type": "number",
          "title": "Generation Time",
          "description": "Processing duration in seconds."
        }
      },
      "description": "Metadata for a single document."
    },
    "ListDocumentsXmlResponse": {
      "type": "object",
      "title": "ListDocumentsXmlResponse",
      "required": [
        "documents"
      ],
      "properties": {
        "documents": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "DocumentMetadata",
            "properties": {
              "id": {
                "type": "integer",
                "title": "Id",
                "description": "Unique document identifier."
              },
              "tag": {
                "type": "string",
                "title": "Tag",
                "description": "Custom tag associated with the document."
              },
              "name": {
                "type": "string",
                "title": "Name",
                "description": "Document name/filename."
              },
              "test": {
                "type": "boolean",
                "title": "Test",
                "description": "Whether the document was created in test mode."
              },
              "strict": {
                "type": "string",
                "title": "Strict",
                "description": "Validation mode used."
              },
              "success": {
                "type": "boolean",
                "title": "Success",
                "description": "Whether the document conversion was successful."
              },
              "async_mode": {
                "type": "boolean",
                "title": "Async Mode",
                "description": "Whether asynchronous processing was used."
              },
              "created_at": {
                "type": "string",
                "title": "Created At",
                "description": "Document creation timestamp."
              },
              "input_size": {
                "type": "integer",
                "title": "Input Size",
                "description": "Size of source HTML in bytes."
              },
              "ip_address": {
                "type": "string",
                "title": "Ip Address",
                "description": "IP address of the request origin."
              },
              "javascript": {
                "type": "boolean",
                "title": "Javascript",
                "description": "Whether JavaScript execution was enabled."
              },
              "output_size": {
                "type": "integer",
                "title": "Output Size",
                "description": "Size of generated document in bytes."
              },
              "document_url": {
                "type": "string",
                "title": "Document Url",
                "description": "Source URL that was converted."
              },
              "document_type": {
                "type": "string",
                "title": "Document Type",
                "description": "Type of document (e.g., 'pdf', 'excel')."
              },
              "generation_time": {
                "type": "number",
                "title": "Generation Time",
                "description": "Processing duration in seconds."
              }
            },
            "description": "Metadata for a single document."
          },
          "title": "Documents",
          "description": "List of document metadata objects ordered by creation date (most recent first)."
        }
      },
      "description": "Response model containing list of document metadata."
    }
  },
  "title": "ListDocumentsXmlResponseWrapper",
  "required": [
    "data",
    "successful"
  ],
  "properties": {
    "data": {
      "type": "object",
      "title": "Data",
      "required": [
        "documents"
      ],
      "properties": {
        "documents": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "DocumentMetadata",
            "properties": {
              "id": {
                "type": "integer",
                "title": "Id",
                "description": "Unique document identifier."
              },
              "tag": {
                "type": "string",
                "title": "Tag",
                "description": "Custom tag associated with the document."
              },
              "name": {
                "type": "string",
                "title": "Name",
                "description": "Document name/filename."
              },
              "test": {
                "type": "boolean",
                "title": "Test",
                "description": "Whether the document was created in test mode."
              },
              "strict": {
                "type": "string",
                "title": "Strict",
                "description": "Validation mode used."
              },
              "success": {
                "type": "boolean",
                "title": "Success",
                "description": "Whether the document conversion was successful."
              },
              "async_mode": {
                "type": "boolean",
                "title": "Async Mode",
                "description": "Whether asynchronous processing was used."
              },
              "created_at": {
                "type": "string",
                "title": "Created At",
                "description": "Document creation timestamp."
              },
              "input_size": {
                "type": "integer",
                "title": "Input Size",
                "description": "Size of source HTML in bytes."
              },
              "ip_address": {
                "type": "string",
                "title": "Ip Address",
                "description": "IP address of the request origin."
              },
              "javascript": {
                "type": "boolean",
                "title": "Javascript",
                "description": "Whether JavaScript execution was enabled."
              },
              "output_size": {
                "type": "integer",
                "title": "Output Size",
                "description": "Size of generated document in bytes."
              },
              "document_url": {
                "type": "string",
                "title": "Document Url",
                "description": "Source URL that was converted."
              },
              "document_type": {
                "type": "string",
                "title": "Document Type",
                "description": "Type of document (e.g., 'pdf', 'excel')."
              },
              "generation_time": {
                "type": "number",
                "title": "Generation Time",
                "description": "Processing duration in seconds."
              }
            },
            "description": "Metadata for a single document."
          },
          "title": "Documents",
          "description": "List of document metadata objects ordered by creation date (most recent first)."
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

## DOCRAPTOR_LIST_IPS_JSON
Tool to get list of IP addresses that DocRaptor uses to download assets. Use when you need to know which IPs DocRaptor uses for asset downloading. Note: Using IPs for securing assets is not recommended as they can change without notice.

**Input schema:**
```json
{
  "type": "object",
  "title": "ListIpsJsonRequest",
  "properties": {},
  "description": "Request model for listing IP addresses. No parameters are required."
}
```

**Output schema:**
```json
{
  "type": "object",
  "$defs": {
    "ListIpsJsonResponse": {
      "type": "object",
      "title": "ListIpsJsonResponse",
      "required": [
        "ips"
      ],
      "properties": {
        "ips": {
          "type": "array",
          "items": {
            "type": "string"
          },
          "title": "Ips",
          "description": "List of IP addresses that DocRaptor uses to download assets."
        }
      },
      "description": "Response model containing list of IP addresses used by DocRaptor."
    }
  },
  "title": "ListIpsJsonResponseWrapper",
  "required": [
    "data",
    "successful"
  ],
  "properties": {
    "data": {
      "type": "object",
      "title": "Data",
      "required": [
        "ips"
      ],
      "properties": {
        "ips": {
          "type": "array",
          "items": {
            "type": "string"
          },
          "title": "Ips",
          "description": "List of IP addresses that DocRaptor uses to download assets."
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

## DOCRAPTOR_LIST_IPS_TEXT
Tool to retrieve a list of IP addresses that DocRaptor uses to download assets in plain text format. Use when you need to identify DocRaptor's IP addresses for network configuration or security purposes.

**Input schema:**
```json
{
  "type": "object",
  "title": "ListIpsTextRequest",
  "properties": {},
  "description": "Request model for retrieving DocRaptor IP addresses in plain text format.\nNo parameters are required."
}
```

**Output schema:**
```json
{
  "type": "object",
  "$defs": {
    "ListIpsTextResponse": {
      "type": "object",
      "title": "ListIpsTextResponse",
      "required": [
        "content"
      ],
      "properties": {
        "content": {
          "type": "string",
          "title": "Content",
          "description": "Plain text list of IP addresses that DocRaptor uses to download assets, with each IP address on a separate line."
        }
      },
      "description": "Response model containing DocRaptor IP addresses in plain text format."
    }
  },
  "title": "ListIpsTextResponseWrapper",
  "required": [
    "data",
    "successful"
  ],
  "properties": {
    "data": {
      "type": "object",
      "title": "Data",
      "required": [
        "content"
      ],
      "properties": {
        "content": {
          "type": "string",
          "title": "Content",
          "description": "Plain text list of IP addresses that DocRaptor uses to download assets, with each IP address on a separate line."
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
