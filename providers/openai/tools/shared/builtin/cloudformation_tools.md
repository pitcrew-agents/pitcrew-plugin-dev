# cloudformation_tools

## execute_aws_cloudformation
**Input schema:**
```json
{
  "type": "object",
  "properties": {
    "s3_key": {
      "type": "string",
      "description": "S3 object key of the CloudFormation template to deploy (e.g. 'cloudformation/my-stack.yaml' or 'templates/infra.json'). Either s3_key OR template_content is required (not both)."
    },
    "template_content": {
      "type": "string",
      "description": "Inline YAML or JSON CloudFormation template content. Either s3_key OR template_content is required (not both)."
    },
    "stack_name": {
      "type": "string",
      "description": "Name for the CloudFormation stack. Will be created if it doesn't exist, or updated if it already does."
    },
    "aws_region": {
      "type": "string",
      "description": "AWS region where the stack will be deployed (default: us-east-1).",
      "default": "us-east-1"
    },
    "parameters": {
      "type": "array",
      "description": "Optional CloudFormation parameter overrides.",
      "items": {
        "type": "object",
        "properties": {
          "ParameterKey": {
            "type": "string"
          },
          "ParameterValue": {
            "type": "string"
          }
        },
        "required": [
          "ParameterKey",
          "ParameterValue"
        ]
      }
    },
    "capabilities": {
      "type": "array",
      "description": "IAM capability flags required by the template. Common values: CAPABILITY_IAM, CAPABILITY_NAMED_IAM, CAPABILITY_AUTO_EXPAND. Defaults to ['CAPABILITY_IAM'].",
      "items": {
        "type": "string"
      },
      "default": [
        "CAPABILITY_IAM"
      ]
    },
    "timeout": {
      "type": "integer",
      "description": "Max seconds to wait for the deployment to complete (default 600).",
      "default": 600
    }
  },
  "required": [
    "stack_name"
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
      "description": "True if the CloudFormation deployment succeeded."
    },
    "report": {
      "type": "string",
      "description": "Human-readable deployment report including validation, events, and outputs."
    },
    "stack_name": {
      "type": "string"
    },
    "aws_region": {
      "type": "string"
    },
    "template_filename": {
      "type": "string"
    },
    "template_format": {
      "type": "string",
      "description": "Detected template format: 'json' or 'yaml'."
    },
    "resource_count": {
      "type": "integer",
      "description": "Number of resources defined in the template."
    },
    "deploy_exit_code": {
      "type": "integer"
    },
    "deploy_stdout": {
      "type": "string",
      "description": "Raw stdout from the aws cloudformation deploy command."
    },
    "validate_stdout": {
      "type": "string",
      "description": "Output from aws cloudformation validate-template."
    },
    "error": {
      "type": "string",
      "description": "Error message if the deployment failed."
    }
  }
}
```

## execute_cloudformation
**Input schema:**
```json
{
  "type": "object",
  "properties": {
    "s3_key": {
      "type": "string",
      "description": "S3 object key of the CloudFormation template to deploy (e.g. 'cloudformation/run123/my-stack_template.yaml'). Typically from generate_cloudformation's template_s3_path output."
    },
    "stack_name": {
      "type": "string",
      "description": "Name for the CloudFormation stack. Will be created if it doesn't exist, or updated if it already does."
    },
    "aws_region": {
      "type": "string",
      "description": "AWS region where the stack will be deployed (default: us-east-1).",
      "default": "us-east-1"
    },
    "parameters": {
      "type": "array",
      "description": "Optional CloudFormation parameter overrides.",
      "items": {
        "type": "object",
        "properties": {
          "ParameterKey": {
            "type": "string"
          },
          "ParameterValue": {
            "type": "string"
          }
        },
        "required": [
          "ParameterKey",
          "ParameterValue"
        ]
      }
    },
    "capabilities": {
      "type": "array",
      "description": "IAM capability flags required by the template. Common values: CAPABILITY_IAM, CAPABILITY_NAMED_IAM, CAPABILITY_AUTO_EXPAND. Defaults to ['CAPABILITY_IAM'].",
      "items": {
        "type": "string"
      },
      "default": [
        "CAPABILITY_IAM"
      ]
    },
    "timeout": {
      "type": "integer",
      "description": "Max seconds to wait for the deployment to complete (default 600).",
      "default": 600
    }
  },
  "required": [
    "s3_key",
    "stack_name"
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
      "description": "True if the CloudFormation deployment succeeded."
    },
    "report": {
      "type": "string",
      "description": "Human-readable deployment report including validation, events, and outputs."
    },
    "stack_name": {
      "type": "string"
    },
    "aws_region": {
      "type": "string"
    },
    "template_filename": {
      "type": "string"
    },
    "template_format": {
      "type": "string",
      "description": "Detected template format: 'json' or 'yaml'."
    },
    "resource_count": {
      "type": "integer",
      "description": "Number of resources defined in the template."
    },
    "deploy_exit_code": {
      "type": "integer"
    },
    "deploy_stdout": {
      "type": "string",
      "description": "Raw stdout from the aws cloudformation deploy command."
    },
    "validate_stdout": {
      "type": "string",
      "description": "Output from aws cloudformation validate-template."
    },
    "error": {
      "type": "string",
      "description": "Error message if the deployment failed."
    }
  }
}
```
