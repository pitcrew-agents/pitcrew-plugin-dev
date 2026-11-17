# cloudformation_generate_tool

## generate_cloudformation
**Input schema:**
```json
{
  "type": "object",
  "properties": {
    "intent": {
      "type": "string",
      "description": "Natural language description of the infrastructure to create (e.g., \"S3 bucket with versioning and public access blocked\", \"Lambda function triggered by S3 events\")"
    },
    "stack_name": {
      "type": "string",
      "description": "CloudFormation stack name (alphanumeric and hyphens only)",
      "default": "generated-stack"
    },
    "resource_types": {
      "type": "array",
      "items": {
        "type": "string"
      },
      "description": "Optional list of AWS resource types to include (e.g., [\"AWS::S3::Bucket\", \"AWS::IAM::Role\"])"
    }
  },
  "required": [
    "intent"
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
    "template_content": {
      "type": "string",
      "description": "Generated CloudFormation YAML/JSON"
    },
    "template_s3_path": {
      "type": "string",
      "description": "S3 path for the runner tool (use this in execute_cloudformation)"
    },
    "download_url": {
      "type": "string",
      "description": "Presigned URL for user download"
    },
    "validation": {
      "type": "object",
      "properties": {
        "valid": {
          "type": "boolean",
          "description": "Whether the template passed validation"
        },
        "errors": {
          "type": "array",
          "items": {
            "type": "string"
          },
          "description": "Validation error messages if any"
        }
      }
    },
    "stack_name": {
      "type": "string"
    },
    "error": {
      "type": "string",
      "description": "Error message if success is false"
    }
  }
}
```
