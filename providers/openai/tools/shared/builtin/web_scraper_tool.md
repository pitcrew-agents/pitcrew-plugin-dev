# web_scraper_tool

## scrape_url
**Input schema:**
```json
{
  "type": "object",
  "properties": {
    "url": {
      "type": "string",
      "description": "The URL to scrape. Can be HTML page, PDF, image, or any other content."
    },
    "include_links": {
      "type": "boolean",
      "description": "For HTML pages, whether to extract and return links found on the page.",
      "default": false
    },
    "all_links": {
      "type": "boolean",
      "description": "For HTML pages with include_links=True, whether to return all links (True) or limit to first 50 (False).",
      "default": false
    },
    "describe_images": {
      "type": "boolean",
      "description": "For images, whether to use a vision model to describe the image content.",
      "default": false
    },
    "image_prompt": {
      "type": "string",
      "description": "Custom prompt for image description. Default: \"Describe this image in detail.\""
    },
    "headers": {
      "type": "object",
      "description": "Optional HTTP headers as key-value pairs.",
      "additionalProperties": {
        "type": "string"
      }
    },
    "max_pdf_pages": {
      "type": "integer",
      "description": "Maximum number of PDF pages to extract text from.",
      "default": 50
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
      "description": "True if scraping succeeded"
    },
    "url": {
      "type": "string",
      "description": "Final URL after any redirects"
    },
    "content_type": {
      "type": "string",
      "description": "Detected MIME type of the content"
    },
    "content_category": {
      "type": "string",
      "enum": [
        "html",
        "pdf",
        "image",
        "text",
        "binary"
      ],
      "description": "Category of content detected"
    },
    "title": {
      "type": "string",
      "description": "Page title (for HTML pages)"
    },
    "description": {
      "type": "string",
      "description": "Meta description (for HTML pages)"
    },
    "content": {
      "type": "string",
      "description": "Extracted text content"
    },
    "char_count": {
      "type": "integer",
      "description": "Length of extracted content in characters"
    },
    "links": {
      "type": "array",
      "description": "Links found on the page (for HTML with include_links=True)",
      "items": {
        "type": "object",
        "properties": {
          "url": {
            "type": "string"
          },
          "text": {
            "type": "string"
          }
        }
      }
    },
    "page_count": {
      "type": "integer",
      "description": "Total number of pages (for PDF)"
    },
    "pages_extracted": {
      "type": "integer",
      "description": "Number of pages text was extracted from (for PDF)"
    },
    "metadata": {
      "type": "object",
      "description": "Document metadata (for PDF)",
      "additionalProperties": {
        "type": "string"
      }
    },
    "image_description": {
      "type": "string",
      "description": "Vision model description of the image (for images with describe_images=True)"
    },
    "file_size": {
      "type": "integer",
      "description": "Size of the content in bytes"
    },
    "status_code": {
      "type": "integer",
      "description": "HTTP status code"
    },
    "error": {
      "type": "string",
      "description": "Error message if scraping failed"
    }
  }
}
```
