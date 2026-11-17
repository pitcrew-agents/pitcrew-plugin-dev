# webex

## WEBEX_CREATE_TEAM
Creates a new Webex team and automatically adds the authenticated user as a member. Teams are used to organize and group multiple rooms (spaces) under a common umbrella. Use this when you need to create a collaborative workspace for a project, department, or any group that needs multiple related discussion spaces. Note: The creator is automatically added as a team member and can manage team memberships. Use the Team Memberships API to add additional members after creation.

**Input schema:**
```json
{
  "type": "object",
  "title": "CreateTeamRequest",
  "required": [
    "name"
  ],
  "properties": {
    "name": {
      "type": "string",
      "title": "Name",
      "examples": [
        "Marketing Team 2024",
        "Engineering - Cloud Platform"
      ],
      "description": "A user-friendly name for the team. Must be non-empty. Can include letters, numbers, spaces, and special characters."
    },
    "description": {
      "type": "string",
      "title": "Description",
      "examples": [
        "Team for coordinating Project X deliverables and milestones",
        "Cross-functional team focused on customer success initiatives"
      ],
      "description": "A detailed description of the team's purpose and scope. Optional field that helps team members understand the team's objectives."
    }
  },
  "description": "Request model for creating a Webex team."
}
```

**Output schema:**
```json
{
  "type": "object",
  "$defs": {
    "CreateTeamResponse": {
      "type": "object",
      "title": "CreateTeamResponse",
      "required": [
        "id",
        "name",
        "creatorId",
        "created"
      ],
      "properties": {
        "id": {
          "type": "string",
          "title": "Id",
          "description": "Unique identifier for the team."
        },
        "name": {
          "type": "string",
          "title": "Name",
          "description": "The name of the team."
        },
        "created": {
          "type": "string",
          "title": "Created",
          "description": "ISO 8601 timestamp when the team was created."
        },
        "creatorId": {
          "type": "string",
          "title": "Creator Id",
          "description": "Unique identifier of the person who created the team."
        },
        "description": {
          "type": "string",
          "title": "Description",
          "description": "A description of the team."
        }
      },
      "description": "Response model for the created Webex team."
    }
  },
  "title": "CreateTeamResponseWrapper",
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
        "creatorId",
        "created"
      ],
      "properties": {
        "id": {
          "type": "string",
          "title": "Id",
          "description": "Unique identifier for the team."
        },
        "name": {
          "type": "string",
          "title": "Name",
          "description": "The name of the team."
        },
        "created": {
          "type": "string",
          "title": "Created",
          "description": "ISO 8601 timestamp when the team was created."
        },
        "creatorId": {
          "type": "string",
          "title": "Creator Id",
          "description": "Unique identifier of the person who created the team."
        },
        "description": {
          "type": "string",
          "title": "Description",
          "description": "A description of the team."
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

## WEBEX_GET_TEAM_DETAILS
Tool to retrieve details for a specific team by teamId. Use when you need full metadata of a team before performing team-related operations.

**Input schema:**
```json
{
  "type": "object",
  "title": "MessagingGetTeamDetailsRequest",
  "required": [
    "teamId"
  ],
  "properties": {
    "teamId": {
      "type": "string",
      "title": "Team Id",
      "examples": [
        "Y2lzY29zcGFyazovL3VzL1RFQU0vMTIzNDU2Nzg5MGFiY2Rl"
      ],
      "description": "The unique identifier for the team."
    }
  },
  "description": "Request model for retrieving details of a Webex team."
}
```

**Output schema:**
```json
{
  "type": "object",
  "$defs": {
    "MessagingGetTeamDetailsResponse": {
      "type": "object",
      "title": "MessagingGetTeamDetailsResponse",
      "required": [
        "id",
        "name",
        "creatorId",
        "created"
      ],
      "properties": {
        "id": {
          "type": "string",
          "title": "Id",
          "description": "The team's unique ID."
        },
        "name": {
          "type": "string",
          "title": "Name",
          "description": "The name of the team."
        },
        "created": {
          "type": "string",
          "title": "Created",
          "description": "ISO 8601 timestamp when the team was created."
        },
        "creatorId": {
          "type": "string",
          "title": "Creator Id",
          "description": "The unique identifier of the person who created the team."
        },
        "description": {
          "type": "string",
          "title": "Description",
          "description": "A description of the team."
        }
      },
      "description": "Response model for details of a Webex team."
    }
  },
  "title": "MessagingGetTeamDetailsResponseWrapper",
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
        "creatorId",
        "created"
      ],
      "properties": {
        "id": {
          "type": "string",
          "title": "Id",
          "description": "The team's unique ID."
        },
        "name": {
          "type": "string",
          "title": "Name",
          "description": "The name of the team."
        },
        "created": {
          "type": "string",
          "title": "Created",
          "description": "ISO 8601 timestamp when the team was created."
        },
        "creatorId": {
          "type": "string",
          "title": "Creator Id",
          "description": "The unique identifier of the person who created the team."
        },
        "description": {
          "type": "string",
          "title": "Description",
          "description": "A description of the team."
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

## WEBEX_LIST_TEAMS
Lists all teams the authenticated user belongs to. Teams are groups of people with shared rooms visible to all members. Use this when you need to find available teams, get team IDs for other operations, or discover which teams a user has access to. Results are ordered by creation date (newest first) and can be paginated using the max parameter.

**Input schema:**
```json
{
  "type": "object",
  "title": "MessagingListTeamsRequest",
  "properties": {
    "max": {
      "type": "integer",
      "title": "Max",
      "minimum": 1,
      "examples": [
        50
      ],
      "description": "Maximum number of teams to return per page. Must be at least 1. Default is 100 if not specified."
    }
  },
  "description": "Request parameters to filter which teams to list."
}
```

**Output schema:**
```json
{
  "type": "object",
  "$defs": {
    "TeamItem": {
      "type": "object",
      "title": "TeamItem",
      "required": [
        "id",
        "name",
        "creatorId",
        "created"
      ],
      "properties": {
        "id": {
          "type": "string",
          "title": "Id",
          "description": "Unique identifier for the team."
        },
        "name": {
          "type": "string",
          "title": "Name",
          "description": "A user-friendly name for the team."
        },
        "created": {
          "type": "string",
          "title": "Created",
          "description": "ISO8601 timestamp when the team was created."
        },
        "creatorId": {
          "type": "string",
          "title": "Creator Id",
          "description": "The ID of the person who created the team."
        },
        "description": {
          "type": "string",
          "title": "Description",
          "description": "The team's description."
        }
      },
      "description": "A single team object."
    },
    "MessagingListTeamsResponse": {
      "type": "object",
      "title": "MessagingListTeamsResponse",
      "required": [
        "items"
      ],
      "properties": {
        "items": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "TeamItem",
            "required": [
              "id",
              "name",
              "creatorId",
              "created"
            ],
            "properties": {
              "id": {
                "type": "string",
                "title": "Id",
                "description": "Unique identifier for the team."
              },
              "name": {
                "type": "string",
                "title": "Name",
                "description": "A user-friendly name for the team."
              },
              "created": {
                "type": "string",
                "title": "Created",
                "description": "ISO8601 timestamp when the team was created."
              },
              "creatorId": {
                "type": "string",
                "title": "Creator Id",
                "description": "The ID of the person who created the team."
              },
              "description": {
                "type": "string",
                "title": "Description",
                "description": "The team's description."
              }
            },
            "description": "A single team object."
          },
          "title": "Items",
          "description": "Array of team objects the authenticated user belongs to, ordered by creation date (most recent first)."
        }
      },
      "description": "Response schema for listing teams. Contains a list of teams the authenticated user is a member of."
    }
  },
  "title": "MessagingListTeamsResponseWrapper",
  "required": [
    "data",
    "successful"
  ],
  "properties": {
    "data": {
      "type": "object",
      "title": "Data",
      "required": [
        "items"
      ],
      "properties": {
        "items": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "TeamItem",
            "required": [
              "id",
              "name",
              "creatorId",
              "created"
            ],
            "properties": {
              "id": {
                "type": "string",
                "title": "Id",
                "description": "Unique identifier for the team."
              },
              "name": {
                "type": "string",
                "title": "Name",
                "description": "A user-friendly name for the team."
              },
              "created": {
                "type": "string",
                "title": "Created",
                "description": "ISO8601 timestamp when the team was created."
              },
              "creatorId": {
                "type": "string",
                "title": "Creator Id",
                "description": "The ID of the person who created the team."
              },
              "description": {
                "type": "string",
                "title": "Description",
                "description": "The team's description."
              }
            },
            "description": "A single team object."
          },
          "title": "Items",
          "description": "Array of team objects the authenticated user belongs to, ordered by creation date (most recent first)."
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

## WEBEX_LIST_WEBHOOKS
Lists all webhooks registered for the authenticated user or organization. Supports optional filtering by maximum results and ownership type (creator vs org-wide).

**Input schema:**
```json
{
  "type": "object",
  "title": "ListWebhooksRequest",
  "properties": {
    "max": {
      "type": "integer",
      "title": "Max",
      "minimum": 1,
      "examples": [
        100
      ],
      "description": "Maximum number of webhooks to return"
    },
    "ownedBy": {
      "enum": [
        "creator",
        "org"
      ],
      "type": "string",
      "title": "Owned By",
      "examples": [
        "creator",
        "org"
      ],
      "description": "Filter webhooks by ownership: 'creator' for user-owned, 'org' for org-wide"
    }
  },
  "description": "Request parameters to filter which webhooks to list."
}
```

**Output schema:**
```json
{
  "type": "object",
  "$defs": {
    "WebhookItem": {
      "type": "object",
      "title": "WebhookItem",
      "required": [
        "id",
        "name",
        "targetUrl",
        "resource",
        "event",
        "status",
        "created",
        "ownedBy",
        "orgId",
        "createdBy"
      ],
      "properties": {
        "id": {
          "type": "string",
          "title": "Id",
          "description": "Unique identifier for the webhook"
        },
        "name": {
          "type": "string",
          "title": "Name",
          "description": "Webhook name"
        },
        "appId": {
          "type": "string",
          "title": "App Id",
          "description": "Integration application ID"
        },
        "event": {
          "type": "string",
          "title": "Event",
          "description": "Event that triggers the webhook"
        },
        "orgId": {
          "type": "string",
          "title": "Org Id",
          "description": "Organization ID"
        },
        "filter": {
          "type": "string",
          "title": "Filter",
          "description": "Filter expression for events"
        },
        "secret": {
          "type": "string",
          "title": "Secret",
          "description": "Secret for securing webhook payloads"
        },
        "status": {
          "type": "string",
          "title": "Status",
          "description": "Webhook status, e.g., 'active'"
        },
        "actorId": {
          "type": "string",
          "title": "Actor Id",
          "description": "Person ID of creator"
        },
        "created": {
          "type": "string",
          "title": "Created",
          "description": "ISO 8601 timestamp when created"
        },
        "ownedBy": {
          "type": "string",
          "title": "Owned By",
          "description": "Ownership: 'creator' or 'org'"
        },
        "resource": {
          "type": "string",
          "title": "Resource",
          "description": "Resource monitored by the webhook"
        },
        "createdBy": {
          "type": "string",
          "title": "Created By",
          "description": "Person ID who created the webhook"
        },
        "targetUrl": {
          "type": "string",
          "title": "Target Url",
          "description": "URL that receives POST requests for this webhook"
        }
      },
      "description": "A single webhook object."
    },
    "ListWebhooksResponse": {
      "type": "object",
      "title": "ListWebhooksResponse",
      "required": [
        "items"
      ],
      "properties": {
        "items": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "WebhookItem",
            "required": [
              "id",
              "name",
              "targetUrl",
              "resource",
              "event",
              "status",
              "created",
              "ownedBy",
              "orgId",
              "createdBy"
            ],
            "properties": {
              "id": {
                "type": "string",
                "title": "Id",
                "description": "Unique identifier for the webhook"
              },
              "name": {
                "type": "string",
                "title": "Name",
                "description": "Webhook name"
              },
              "appId": {
                "type": "string",
                "title": "App Id",
                "description": "Integration application ID"
              },
              "event": {
                "type": "string",
                "title": "Event",
                "description": "Event that triggers the webhook"
              },
              "orgId": {
                "type": "string",
                "title": "Org Id",
                "description": "Organization ID"
              },
              "filter": {
                "type": "string",
                "title": "Filter",
                "description": "Filter expression for events"
              },
              "secret": {
                "type": "string",
                "title": "Secret",
                "description": "Secret for securing webhook payloads"
              },
              "status": {
                "type": "string",
                "title": "Status",
                "description": "Webhook status, e.g., 'active'"
              },
              "actorId": {
                "type": "string",
                "title": "Actor Id",
                "description": "Person ID of creator"
              },
              "created": {
                "type": "string",
                "title": "Created",
                "description": "ISO 8601 timestamp when created"
              },
              "ownedBy": {
                "type": "string",
                "title": "Owned By",
                "description": "Ownership: 'creator' or 'org'"
              },
              "resource": {
                "type": "string",
                "title": "Resource",
                "description": "Resource monitored by the webhook"
              },
              "createdBy": {
                "type": "string",
                "title": "Created By",
                "description": "Person ID who created the webhook"
              },
              "targetUrl": {
                "type": "string",
                "title": "Target Url",
                "description": "URL that receives POST requests for this webhook"
              }
            },
            "description": "A single webhook object."
          },
          "title": "Items",
          "description": "List of webhook objects matching request filters"
        }
      },
      "description": "Response schema for listing webhooks."
    }
  },
  "title": "ListWebhooksResponseWrapper",
  "required": [
    "data",
    "successful"
  ],
  "properties": {
    "data": {
      "type": "object",
      "title": "Data",
      "required": [
        "items"
      ],
      "properties": {
        "items": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "WebhookItem",
            "required": [
              "id",
              "name",
              "targetUrl",
              "resource",
              "event",
              "status",
              "created",
              "ownedBy",
              "orgId",
              "createdBy"
            ],
            "properties": {
              "id": {
                "type": "string",
                "title": "Id",
                "description": "Unique identifier for the webhook"
              },
              "name": {
                "type": "string",
                "title": "Name",
                "description": "Webhook name"
              },
              "appId": {
                "type": "string",
                "title": "App Id",
                "description": "Integration application ID"
              },
              "event": {
                "type": "string",
                "title": "Event",
                "description": "Event that triggers the webhook"
              },
              "orgId": {
                "type": "string",
                "title": "Org Id",
                "description": "Organization ID"
              },
              "filter": {
                "type": "string",
                "title": "Filter",
                "description": "Filter expression for events"
              },
              "secret": {
                "type": "string",
                "title": "Secret",
                "description": "Secret for securing webhook payloads"
              },
              "status": {
                "type": "string",
                "title": "Status",
                "description": "Webhook status, e.g., 'active'"
              },
              "actorId": {
                "type": "string",
                "title": "Actor Id",
                "description": "Person ID of creator"
              },
              "created": {
                "type": "string",
                "title": "Created",
                "description": "ISO 8601 timestamp when created"
              },
              "ownedBy": {
                "type": "string",
                "title": "Owned By",
                "description": "Ownership: 'creator' or 'org'"
              },
              "resource": {
                "type": "string",
                "title": "Resource",
                "description": "Resource monitored by the webhook"
              },
              "createdBy": {
                "type": "string",
                "title": "Created By",
                "description": "Person ID who created the webhook"
              },
              "targetUrl": {
                "type": "string",
                "title": "Target Url",
                "description": "URL that receives POST requests for this webhook"
              }
            },
            "description": "A single webhook object."
          },
          "title": "Items",
          "description": "List of webhook objects matching request filters"
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

## WEBEX_MESSAGING_CREATE_MESSAGE
Tool to post a message to a Webex room or person. Use when you have a target roomId or private recipient and want to send text, markdown, files, or card attachments.

**Input schema:**
```json
{
  "type": "object",
  "title": "MessagingCreateMessageRequest",
  "properties": {
    "text": {
      "type": "string",
      "title": "Text",
      "examples": [
        "Hello, world!"
      ],
      "description": "Plain-text message content. Maximum 7439 bytes."
    },
    "files": {
      "type": "array",
      "items": {
        "type": "string"
      },
      "title": "Files",
      "examples": [
        [
          "https://example.com/image.png"
        ]
      ],
      "description": "List of public URLs for file attachments. Note: Webex API accepts a list but only one file per message is supported."
    },
    "roomId": {
      "type": "string",
      "title": "Room Id",
      "examples": [
        "Y2lzY29zcGFyazovL3VzL1JPT00vZjU1YWRkZTAtYmE4YS0xMWViLWI4ZTUtYzFjYWQzZTVhY2Jk"
      ],
      "description": "The room ID to post the message in. Required if sending to a room."
    },
    "markdown": {
      "type": "string",
      "title": "Markdown",
      "examples": [
        "**Bold** and _italic_ [link](https://example.com)"
      ],
      "description": "Markdown-formatted message content. Maximum 7439 bytes. When both text and markdown are provided, markdown takes precedence for clients that support it."
    },
    "parentId": {
      "type": "string",
      "title": "Parent Id",
      "examples": [
        "Y2lzY29zcGFyazovL3VzL01FU1NBR0UvMTIzNDU2Nzg5LWFiY2QtMTFlYi1iOGU1LWMxY2FkM2U1YWNiZA"
      ],
      "description": "The parent message ID to reply to, creating a threaded response."
    },
    "toPersonId": {
      "type": "string",
      "title": "To Person Id",
      "examples": [
        "Y2lzY29zcGFyazovL3VzL1BFT1BMRS8xMjM0NTY3ODktYWJjZC0xMWViLWI4ZTUtYzFjYWQzZTVhY2Jk"
      ],
      "description": "The person ID for sending a private 1:1 message. Mutually exclusive with roomId."
    },
    "attachments": {
      "type": "array",
      "items": {
        "type": "object",
        "additionalProperties": true
      },
      "title": "Attachments",
      "examples": [
        [
          {
            "content": {
              "body": [
                {
                  "text": "Card content",
                  "type": "TextBlock"
                }
              ],
              "type": "AdaptiveCard",
              "version": "1.2"
            },
            "contentType": "application/vnd.microsoft.card.adaptive"
          }
        ]
      ],
      "description": "Content attachments such as Adaptive Cards. Only one card attachment per message is supported."
    },
    "toPersonEmail": {
      "type": "string",
      "title": "To Person Email",
      "examples": [
        "alice@example.com"
      ],
      "description": "The email address of the person for a private 1:1 message. Mutually exclusive with roomId."
    }
  },
  "description": "Request parameters for posting a message to a Webex room or person.\nNote: One of roomId, toPersonId, or toPersonEmail is required."
}
```

**Output schema:**
```json
{
  "type": "object",
  "$defs": {
    "MessagingCreateMessageResponse": {
      "type": "object",
      "title": "MessagingCreateMessageResponse",
      "required": [
        "id"
      ],
      "properties": {
        "id": {
          "type": "string",
          "title": "Id",
          "description": "Unique identifier for the message."
        },
        "html": {
          "type": "string",
          "title": "Html",
          "description": "HTML representation of the message, automatically generated from markdown."
        },
        "text": {
          "type": "string",
          "title": "Text",
          "description": "Plain-text representation of the message content."
        },
        "files": {
          "type": "array",
          "items": {
            "type": "string"
          },
          "title": "Files",
          "description": "URLs of any attached files."
        },
        "roomId": {
          "type": "string",
          "title": "Room Id",
          "description": "The room ID where the message was posted."
        },
        "created": {
          "type": "string",
          "title": "Created",
          "description": "ISO 8601 timestamp when the message was created."
        },
        "markdown": {
          "type": "string",
          "title": "Markdown",
          "description": "Markdown-formatted message content if provided in request."
        },
        "parentId": {
          "type": "string",
          "title": "Parent Id",
          "description": "The parent message ID if this is a threaded reply."
        },
        "personId": {
          "type": "string",
          "title": "Person Id",
          "description": "ID of the person who posted the message."
        },
        "roomType": {
          "type": "string",
          "title": "Room Type",
          "description": "Type of the room: 'group' or 'direct'."
        },
        "attachments": {
          "type": "array",
          "items": {
            "type": "object",
            "additionalProperties": true
          },
          "title": "Attachments",
          "description": "Content attachments (cards) included in the message."
        },
        "personEmail": {
          "type": "string",
          "title": "Person Email",
          "description": "Email of the person who posted the message."
        }
      },
      "description": "Response schema for a created Webex message."
    }
  },
  "title": "MessagingCreateMessageResponseWrapper",
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
          "description": "Unique identifier for the message."
        },
        "html": {
          "type": "string",
          "title": "Html",
          "description": "HTML representation of the message, automatically generated from markdown."
        },
        "text": {
          "type": "string",
          "title": "Text",
          "description": "Plain-text representation of the message content."
        },
        "files": {
          "type": "array",
          "items": {
            "type": "string"
          },
          "title": "Files",
          "description": "URLs of any attached files."
        },
        "roomId": {
          "type": "string",
          "title": "Room Id",
          "description": "The room ID where the message was posted."
        },
        "created": {
          "type": "string",
          "title": "Created",
          "description": "ISO 8601 timestamp when the message was created."
        },
        "markdown": {
          "type": "string",
          "title": "Markdown",
          "description": "Markdown-formatted message content if provided in request."
        },
        "parentId": {
          "type": "string",
          "title": "Parent Id",
          "description": "The parent message ID if this is a threaded reply."
        },
        "personId": {
          "type": "string",
          "title": "Person Id",
          "description": "ID of the person who posted the message."
        },
        "roomType": {
          "type": "string",
          "title": "Room Type",
          "description": "Type of the room: 'group' or 'direct'."
        },
        "attachments": {
          "type": "array",
          "items": {
            "type": "object",
            "additionalProperties": true
          },
          "title": "Attachments",
          "description": "Content attachments (cards) included in the message."
        },
        "personEmail": {
          "type": "string",
          "title": "Person Email",
          "description": "Email of the person who posted the message."
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

## WEBEX_MESSAGING_CREATE_ROOM
Creates a new Webex room for team collaboration. The authenticated user is automatically added as a member. Use this to create group rooms for team discussions or associate rooms with existing teams. To create a 1:1 room, use the Create Message action with toPersonId/toPersonEmail instead. Note: Team rooms cannot be moved after creation. Bots cannot simultaneously create and classify rooms.

**Input schema:**
```json
{
  "type": "object",
  "title": "MessagingCreateRoomRequest",
  "required": [
    "title"
  ],
  "properties": {
    "title": {
      "type": "string",
      "title": "Title",
      "examples": [
        "My Project Room"
      ],
      "description": "A user-friendly name for the room. This will be displayed as the room's title."
    },
    "teamId": {
      "type": "string",
      "title": "Team Id",
      "examples": [
        "Y2lzY29zcGFyazovL3VzL1RFQU0vMTIzNDU2Nzg5MGFiY2Rl"
      ],
      "description": "The ID for the team with which this room is associated. If specified, the room will be created as part of the team. Team rooms cannot be moved after creation."
    },
    "isLocked": {
      "type": "boolean",
      "title": "Is Locked",
      "description": "Set the space as moderated/locked. When true, only moderators can post messages. Must be true if isAnnouncementOnly is true."
    },
    "isPublic": {
      "type": "boolean",
      "title": "Is Public",
      "description": "The room is public and therefore discoverable within the org. Anyone can find and join the room. When true, the description field must be filled in."
    },
    "description": {
      "type": "string",
      "title": "Description",
      "examples": [
        "This room is for discussing Project X deliverables"
      ],
      "description": "The description of the space. Required when isPublic is true."
    },
    "classificationId": {
      "type": "string",
      "title": "Classification Id",
      "examples": [
        "Y2lzY29zcGFyazovL3VzL0NMQVNTSUZJQ0FUSU9OLzEyMzQ1Njc4OTBhYmNkZQ"
      ],
      "description": "The ID of the space classification to apply during room creation. Note: Bots cannot simultaneously create and classify rooms."
    },
    "isAnnouncementOnly": {
      "type": "boolean",
      "title": "Is Announcement Only",
      "description": "Sets the space into announcement mode. Only moderators can post messages. The space must be locked (isLocked=true) for this to work."
    }
  },
  "description": "Request model for creating a Webex room."
}
```

**Output schema:**
```json
{
  "type": "object",
  "$defs": {
    "MessagingCreateRoomResponse": {
      "type": "object",
      "title": "MessagingCreateRoomResponse",
      "required": [
        "id",
        "title",
        "type"
      ],
      "properties": {
        "id": {
          "type": "string",
          "title": "Id",
          "description": "Unique identifier for the room."
        },
        "type": {
          "type": "string",
          "title": "Type",
          "description": "The room type. Possible values: 'direct' (1:1 room) or 'group' (group room)."
        },
        "title": {
          "type": "string",
          "title": "Title",
          "description": "The user-friendly name of the room."
        },
        "teamId": {
          "type": "string",
          "title": "Team Id",
          "description": "The ID of the team with which this room is associated."
        },
        "created": {
          "type": "string",
          "title": "Created",
          "description": "The date and time the room was created in ISO 8601 format."
        },
        "ownerId": {
          "type": "string",
          "title": "Owner Id",
          "description": "The ID of the organization that owns this room."
        },
        "isLocked": {
          "type": "boolean",
          "title": "Is Locked",
          "description": "Whether the room is moderated/locked. When true, only moderators can post messages."
        },
        "isPublic": {
          "type": "boolean",
          "title": "Is Public",
          "description": "Whether the room is public and discoverable within the organization."
        },
        "creatorId": {
          "type": "string",
          "title": "Creator Id",
          "description": "The ID of the person who created the room."
        },
        "isReadOnly": {
          "type": "boolean",
          "title": "Is Read Only",
          "description": "Whether the room is read only (set by compliance officers)."
        },
        "madePublic": {
          "type": "string",
          "title": "Made Public",
          "description": "The date and time when the room was made public in ISO 8601 format."
        },
        "description": {
          "type": "string",
          "title": "Description",
          "description": "The description of the room."
        },
        "lastActivity": {
          "type": "string",
          "title": "Last Activity",
          "description": "The date and time of the last activity in the room in ISO 8601 format."
        },
        "classificationId": {
          "type": "string",
          "title": "Classification Id",
          "description": "The ID of the space classification applied to the room."
        },
        "isAnnouncementOnly": {
          "type": "boolean",
          "title": "Is Announcement Only",
          "description": "Whether the room is in announcement-only mode. When true, only moderators can post."
        }
      },
      "description": "Response model for the created room."
    }
  },
  "title": "MessagingCreateRoomResponseWrapper",
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
        "title",
        "type"
      ],
      "properties": {
        "id": {
          "type": "string",
          "title": "Id",
          "description": "Unique identifier for the room."
        },
        "type": {
          "type": "string",
          "title": "Type",
          "description": "The room type. Possible values: 'direct' (1:1 room) or 'group' (group room)."
        },
        "title": {
          "type": "string",
          "title": "Title",
          "description": "The user-friendly name of the room."
        },
        "teamId": {
          "type": "string",
          "title": "Team Id",
          "description": "The ID of the team with which this room is associated."
        },
        "created": {
          "type": "string",
          "title": "Created",
          "description": "The date and time the room was created in ISO 8601 format."
        },
        "ownerId": {
          "type": "string",
          "title": "Owner Id",
          "description": "The ID of the organization that owns this room."
        },
        "isLocked": {
          "type": "boolean",
          "title": "Is Locked",
          "description": "Whether the room is moderated/locked. When true, only moderators can post messages."
        },
        "isPublic": {
          "type": "boolean",
          "title": "Is Public",
          "description": "Whether the room is public and discoverable within the organization."
        },
        "creatorId": {
          "type": "string",
          "title": "Creator Id",
          "description": "The ID of the person who created the room."
        },
        "isReadOnly": {
          "type": "boolean",
          "title": "Is Read Only",
          "description": "Whether the room is read only (set by compliance officers)."
        },
        "madePublic": {
          "type": "string",
          "title": "Made Public",
          "description": "The date and time when the room was made public in ISO 8601 format."
        },
        "description": {
          "type": "string",
          "title": "Description",
          "description": "The description of the room."
        },
        "lastActivity": {
          "type": "string",
          "title": "Last Activity",
          "description": "The date and time of the last activity in the room in ISO 8601 format."
        },
        "classificationId": {
          "type": "string",
          "title": "Classification Id",
          "description": "The ID of the space classification applied to the room."
        },
        "isAnnouncementOnly": {
          "type": "boolean",
          "title": "Is Announcement Only",
          "description": "Whether the room is in announcement-only mode. When true, only moderators can post."
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

## WEBEX_MESSAGING_CREATE_TEAM_MEMBERSHIP
Tool to add a person to a Webex team by personId or personEmail. Use when granting a user access to a team; requires teamId and one of personId or personEmail.

**Input schema:**
```json
{
  "type": "object",
  "title": "MessagingCreateTeamMembershipRequest",
  "required": [
    "teamId"
  ],
  "properties": {
    "teamId": {
      "type": "string",
      "title": "Team Id",
      "examples": [
        "Y2lzY29zcGFyazovL3VzL1RFQU0vMTIzNDU2Nzg5MGFiY2Rl"
      ],
      "description": "The team ID to add the person to."
    },
    "personId": {
      "type": "string",
      "title": "Person Id",
      "examples": [
        "Y2lzY29zcGFyazovL3VzL1BFTlNJT04vZTdiY2NiODAtODUzMC0xMWU2LWJkZjgtOGFjYjI5Y2JkMjhj"
      ],
      "description": "The person ID to add. Required if personEmail is not provided."
    },
    "isModerator": {
      "type": "boolean",
      "title": "Is Moderator",
      "default": false,
      "description": "Set to true to make the person a team moderator."
    },
    "personEmail": {
      "type": "string",
      "title": "Person Email",
      "examples": [
        "alice@example.com"
      ],
      "description": "The email address of the person to add. Required if personId is not provided."
    }
  },
  "description": "Request schema for adding a person to a Webex team by personId or personEmail.\nOne of personId or personEmail is required."
}
```

**Output schema:**
```json
{
  "type": "object",
  "$defs": {
    "MessagingCreateTeamMembershipResponse": {
      "type": "object",
      "title": "MessagingCreateTeamMembershipResponse",
      "required": [
        "id",
        "teamId",
        "personId",
        "personEmail",
        "isModerator",
        "created"
      ],
      "properties": {
        "id": {
          "type": "string",
          "title": "Id",
          "description": "Unique identifier for the team membership."
        },
        "teamId": {
          "type": "string",
          "title": "Team Id",
          "description": "The team ID."
        },
        "created": {
          "type": "string",
          "title": "Created",
          "description": "ISO 8601 timestamp when the membership was created."
        },
        "personId": {
          "type": "string",
          "title": "Person Id",
          "description": "The person ID."
        },
        "isModerator": {
          "type": "boolean",
          "title": "Is Moderator",
          "description": "Whether the person is a team moderator."
        },
        "personEmail": {
          "type": "string",
          "title": "Person Email",
          "description": "The person's email address."
        },
        "personOrgId": {
          "type": "string",
          "title": "Person Org Id",
          "description": "The person's organization ID."
        },
        "personDisplayName": {
          "type": "string",
          "title": "Person Display Name",
          "description": "The person's display name."
        }
      },
      "description": "Response schema for a created team membership."
    }
  },
  "title": "MessagingCreateTeamMembershipResponseWrapper",
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
        "teamId",
        "personId",
        "personEmail",
        "isModerator",
        "created"
      ],
      "properties": {
        "id": {
          "type": "string",
          "title": "Id",
          "description": "Unique identifier for the team membership."
        },
        "teamId": {
          "type": "string",
          "title": "Team Id",
          "description": "The team ID."
        },
        "created": {
          "type": "string",
          "title": "Created",
          "description": "ISO 8601 timestamp when the membership was created."
        },
        "personId": {
          "type": "string",
          "title": "Person Id",
          "description": "The person ID."
        },
        "isModerator": {
          "type": "boolean",
          "title": "Is Moderator",
          "description": "Whether the person is a team moderator."
        },
        "personEmail": {
          "type": "string",
          "title": "Person Email",
          "description": "The person's email address."
        },
        "personOrgId": {
          "type": "string",
          "title": "Person Org Id",
          "description": "The person's organization ID."
        },
        "personDisplayName": {
          "type": "string",
          "title": "Person Display Name",
          "description": "The person's display name."
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

## WEBEX_MESSAGING_DELETE_MEMBERSHIP
Tool to delete a Webex membership by its unique identifier. Use when you need to remove a member from a space after confirming the membership exists. Example: "Delete the membership with ID Y2lzY29zcGFjMDczNzA2Njg0ZDliY2YxNDE4NDQyYzQ5NDQzOTExYTk4".

**Input schema:**
```json
{
  "type": "object",
  "title": "MessagingDeleteMembershipRequest",
  "required": [
    "membershipId"
  ],
  "properties": {
    "membershipId": {
      "type": "string",
      "title": "Membership Id",
      "examples": [
        "Y2lzY29zcGFjMDczNzA2Njg0ZDliY2YxNDE4NDQyYzQ5NDQzOTExYTk4"
      ],
      "description": "Unique identifier for the membership to delete"
    }
  },
  "description": "Request schema for `MessagingDeleteMembership`."
}
```

**Output schema:**
```json
{
  "type": "object",
  "$defs": {
    "MessagingDeleteMembershipResponse": {
      "type": "object",
      "title": "MessagingDeleteMembershipResponse",
      "required": [
        "success"
      ],
      "properties": {
        "success": {
          "type": "boolean",
          "title": "Success",
          "description": "Indicates if the membership was deleted successfully"
        }
      },
      "description": "Response schema for `MessagingDeleteMembership`."
    }
  },
  "title": "MessagingDeleteMembershipResponseWrapper",
  "required": [
    "data",
    "successful"
  ],
  "properties": {
    "data": {
      "type": "object",
      "title": "Data",
      "required": [
        "success"
      ],
      "properties": {
        "success": {
          "type": "boolean",
          "title": "Success",
          "description": "Indicates if the membership was deleted successfully"
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

## WEBEX_MESSAGING_DELETE_MESSAGE
Tool to delete a Webex message by its unique identifier. Use after confirming the messageId to remove unintended or obsolete messages. Example: "Delete the message with ID Y2lzY29zcGFyazovL21lc3NhZ2UvYWJjMTIzNDU2Nzg5".

**Input schema:**
```json
{
  "type": "object",
  "title": "MessagingDeleteMessageRequest",
  "required": [
    "messageId"
  ],
  "properties": {
    "messageId": {
      "type": "string",
      "title": "Message Id",
      "examples": [
        "Y2lzY29zcGFyazovL21lc3NhZ2UvYWJjMTIzNDU2Nzg5"
      ],
      "description": "Unique identifier for the message to delete"
    }
  },
  "description": "Request schema for `MessagingDeleteMessage`."
}
```

**Output schema:**
```json
{
  "type": "object",
  "$defs": {
    "MessagingDeleteMessageResponse": {
      "type": "object",
      "title": "MessagingDeleteMessageResponse",
      "required": [
        "success"
      ],
      "properties": {
        "success": {
          "type": "boolean",
          "title": "Success",
          "description": "Indicates if the message was deleted successfully"
        }
      },
      "description": "Response schema for `MessagingDeleteMessage`."
    }
  },
  "title": "MessagingDeleteMessageResponseWrapper",
  "required": [
    "data",
    "successful"
  ],
  "properties": {
    "data": {
      "type": "object",
      "title": "Data",
      "required": [
        "success"
      ],
      "properties": {
        "success": {
          "type": "boolean",
          "title": "Success",
          "description": "Indicates if the message was deleted successfully"
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

## WEBEX_MESSAGING_DELETE_ROOM
Deletes a Webex room by its ID. Deleted rooms cannot be recovered. Note: Non-moderators will be removed from the room instead of deleting it (as a safety measure). Rooms that are part of a team will be archived instead of deleted. Use this when you need to permanently remove a room or leave a room.

**Input schema:**
```json
{
  "type": "object",
  "title": "MessagingDeleteRoomRequest",
  "required": [
    "roomId"
  ],
  "properties": {
    "roomId": {
      "type": "string",
      "title": "Room Id",
      "examples": [
        "Y2lzY29zcGFyazovL3VzL1JPT00vMTIzNDU2Nzg5MGFiY2Rl"
      ],
      "description": "The unique identifier for the room to delete. Note: Non-moderators will be removed from the room instead of deleting it. Team rooms will be archived instead of deleted."
    }
  },
  "description": "Request schema for `MessagingDeleteRoom`."
}
```

**Output schema:**
```json
{
  "type": "object",
  "$defs": {
    "MessagingDeleteRoomResponse": {
      "type": "object",
      "title": "MessagingDeleteRoomResponse",
      "required": [
        "success"
      ],
      "properties": {
        "success": {
          "type": "boolean",
          "title": "Success",
          "description": "Indicates if the room was deleted successfully"
        }
      },
      "description": "Response schema for `MessagingDeleteRoom`."
    }
  },
  "title": "MessagingDeleteRoomResponseWrapper",
  "required": [
    "data",
    "successful"
  ],
  "properties": {
    "data": {
      "type": "object",
      "title": "Data",
      "required": [
        "success"
      ],
      "properties": {
        "success": {
          "type": "boolean",
          "title": "Success",
          "description": "Indicates if the room was deleted successfully"
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

## WEBEX_MESSAGING_GET_MEMBERSHIP_DETAILS
Tool to retrieve details for a specific membership. Use when you need metadata for a membership by its ID.

**Input schema:**
```json
{
  "type": "object",
  "title": "MessagingGetMembershipDetailsRequest",
  "required": [
    "membershipId"
  ],
  "properties": {
    "membershipId": {
      "type": "string",
      "title": "Membership Id",
      "examples": [
        "Y2lzY29zcGFyazovL21FTUJFUlNISXAvYTliYmFjZC1lN2IzLTQwOTUtYTc3YS0yZTJhNzI3ZjQyMzY="
      ],
      "description": "The unique identifier for the membership."
    }
  },
  "description": "Request model for retrieving details of a Webex membership by its unique identifier."
}
```

**Output schema:**
```json
{
  "type": "object",
  "$defs": {
    "MessagingGetMembershipDetailsResponse": {
      "type": "object",
      "title": "MessagingGetMembershipDetailsResponse",
      "required": [
        "id",
        "roomId",
        "roomType",
        "personId",
        "personEmail",
        "personDisplayName",
        "personOrgId",
        "isModerator",
        "isMonitor",
        "created"
      ],
      "properties": {
        "id": {
          "type": "string",
          "title": "Id",
          "description": "The unique identifier for the membership."
        },
        "roomId": {
          "type": "string",
          "title": "Room Id",
          "description": "The unique identifier for the room."
        },
        "created": {
          "type": "string",
          "title": "Created",
          "description": "ISO 8601 timestamp when the membership was created."
        },
        "personId": {
          "type": "string",
          "title": "Person Id",
          "description": "The unique identifier for the person assigned to the membership."
        },
        "roomType": {
          "type": "string",
          "title": "Room Type",
          "description": "Type of room: 'direct' for 1:1 rooms or 'group' for group rooms."
        },
        "isMonitor": {
          "type": "boolean",
          "title": "Is Monitor",
          "description": "Whether the person is a monitoring bot (deprecated)."
        },
        "isModerator": {
          "type": "boolean",
          "title": "Is Moderator",
          "description": "Whether the person is a moderator of the room."
        },
        "personEmail": {
          "type": "string",
          "title": "Person Email",
          "description": "The email address of the person assigned to the membership."
        },
        "personOrgId": {
          "type": "string",
          "title": "Person Org Id",
          "description": "The organization ID of the person."
        },
        "isRoomHidden": {
          "type": "boolean",
          "title": "Is Room Hidden",
          "description": "Whether the direct type room is hidden in Webex clients. Only present for direct rooms."
        },
        "personDisplayName": {
          "type": "string",
          "title": "Person Display Name",
          "description": "The display name of the person assigned to the membership."
        }
      },
      "description": "Response model for details of a Webex membership."
    }
  },
  "title": "MessagingGetMembershipDetailsResponseWrapper",
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
        "roomId",
        "roomType",
        "personId",
        "personEmail",
        "personDisplayName",
        "personOrgId",
        "isModerator",
        "isMonitor",
        "created"
      ],
      "properties": {
        "id": {
          "type": "string",
          "title": "Id",
          "description": "The unique identifier for the membership."
        },
        "roomId": {
          "type": "string",
          "title": "Room Id",
          "description": "The unique identifier for the room."
        },
        "created": {
          "type": "string",
          "title": "Created",
          "description": "ISO 8601 timestamp when the membership was created."
        },
        "personId": {
          "type": "string",
          "title": "Person Id",
          "description": "The unique identifier for the person assigned to the membership."
        },
        "roomType": {
          "type": "string",
          "title": "Room Type",
          "description": "Type of room: 'direct' for 1:1 rooms or 'group' for group rooms."
        },
        "isMonitor": {
          "type": "boolean",
          "title": "Is Monitor",
          "description": "Whether the person is a monitoring bot (deprecated)."
        },
        "isModerator": {
          "type": "boolean",
          "title": "Is Moderator",
          "description": "Whether the person is a moderator of the room."
        },
        "personEmail": {
          "type": "string",
          "title": "Person Email",
          "description": "The email address of the person assigned to the membership."
        },
        "personOrgId": {
          "type": "string",
          "title": "Person Org Id",
          "description": "The organization ID of the person."
        },
        "isRoomHidden": {
          "type": "boolean",
          "title": "Is Room Hidden",
          "description": "Whether the direct type room is hidden in Webex clients. Only present for direct rooms."
        },
        "personDisplayName": {
          "type": "string",
          "title": "Person Display Name",
          "description": "The display name of the person assigned to the membership."
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

## WEBEX_MESSAGING_GET_MESSAGE_DETAILS
Tool to retrieve details for a specific message. Use when you need full content and metadata by message ID.

**Input schema:**
```json
{
  "type": "object",
  "title": "MessagingGetMessageDetailsRequest",
  "required": [
    "messageId"
  ],
  "properties": {
    "messageId": {
      "type": "string",
      "title": "Message Id",
      "examples": [
        "Y2lzY29zcGFyazovL3VzL01FU1NBR0UvZjlhYmJjZC1lN2IzLTQwOTUtYTc3YS0yZTJhNzI3ZjQyMzY"
      ],
      "description": "The unique identifier for the message."
    }
  },
  "description": "Request model for retrieving details of a Webex message by its unique identifier."
}
```

**Output schema:**
```json
{
  "type": "object",
  "$defs": {
    "MessageAttachment": {
      "type": "object",
      "title": "MessageAttachment",
      "required": [
        "contentType",
        "content"
      ],
      "properties": {
        "content": {
          "type": "object",
          "title": "Content",
          "description": "The attachment content, typically an Adaptive Card JSON object.",
          "additionalProperties": true
        },
        "contentType": {
          "type": "string",
          "title": "Content Type",
          "description": "The MIME type of the attachment (e.g., 'application/vnd.microsoft.card.adaptive')."
        }
      },
      "description": "Represents a content attachment (e.g., Adaptive Card) in a Webex message."
    },
    "MessagingGetMessageDetailsResponse": {
      "type": "object",
      "title": "MessagingGetMessageDetailsResponse",
      "required": [
        "id",
        "roomId",
        "roomType",
        "personId",
        "personEmail",
        "created"
      ],
      "properties": {
        "id": {
          "type": "string",
          "title": "Id",
          "description": "The unique identifier for the message."
        },
        "html": {
          "type": "string",
          "title": "Html",
          "description": "The HTML-rendered content of the message (read-only)."
        },
        "text": {
          "type": "string",
          "title": "Text",
          "description": "The plain text content of the message."
        },
        "files": {
          "type": "array",
          "items": {
            "type": "string"
          },
          "title": "Files",
          "description": "URLs of files attached to the message."
        },
        "roomId": {
          "type": "string",
          "title": "Room Id",
          "description": "The unique identifier for the room."
        },
        "created": {
          "type": "string",
          "title": "Created",
          "description": "ISO 8601 timestamp when the message was created."
        },
        "updated": {
          "type": "string",
          "title": "Updated",
          "description": "ISO 8601 timestamp when the message was last edited."
        },
        "markdown": {
          "type": "string",
          "title": "Markdown",
          "description": "The Markdown-formatted content of the message."
        },
        "parentId": {
          "type": "string",
          "title": "Parent Id",
          "description": "The unique identifier for the parent message if this is a threaded reply."
        },
        "personId": {
          "type": "string",
          "title": "Person Id",
          "description": "The unique identifier for the person who sent the message."
        },
        "roomType": {
          "enum": [
            "group",
            "direct"
          ],
          "type": "string",
          "title": "Room Type",
          "description": "The type of room (e.g., 'group' or 'direct')."
        },
        "toPersonId": {
          "type": "string",
          "title": "To Person Id",
          "description": "The unique identifier for the recipient in a 1:1 message."
        },
        "attachments": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "MessageAttachment",
            "required": [
              "contentType",
              "content"
            ],
            "properties": {
              "content": {
                "type": "object",
                "title": "Content",
                "description": "The attachment content, typically an Adaptive Card JSON object.",
                "additionalProperties": true
              },
              "contentType": {
                "type": "string",
                "title": "Content Type",
                "description": "The MIME type of the attachment (e.g., 'application/vnd.microsoft.card.adaptive')."
              }
            },
            "description": "Represents a content attachment (e.g., Adaptive Card) in a Webex message."
          },
          "title": "Attachments",
          "description": "Content attachments (e.g., Adaptive Cards) included in the message."
        },
        "isVoiceClip": {
          "type": "boolean",
          "title": "Is Voice Clip",
          "description": "Indicates whether the message is a voice clip."
        },
        "personEmail": {
          "type": "string",
          "title": "Person Email",
          "description": "The email address of the person who sent the message."
        },
        "toPersonEmail": {
          "type": "string",
          "title": "To Person Email",
          "description": "The email address of the recipient in a 1:1 message."
        },
        "mentionedGroups": {
          "type": "array",
          "items": {
            "type": "string"
          },
          "title": "Mentioned Groups",
          "description": "List of group IDs mentioned in the message."
        },
        "mentionedPeople": {
          "type": "array",
          "items": {
            "type": "string"
          },
          "title": "Mentioned People",
          "description": "List of person IDs mentioned in the message."
        }
      },
      "description": "Response model for details of a Webex message."
    }
  },
  "title": "MessagingGetMessageDetailsResponseWrapper",
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
        "roomId",
        "roomType",
        "personId",
        "personEmail",
        "created"
      ],
      "properties": {
        "id": {
          "type": "string",
          "title": "Id",
          "description": "The unique identifier for the message."
        },
        "html": {
          "type": "string",
          "title": "Html",
          "description": "The HTML-rendered content of the message (read-only)."
        },
        "text": {
          "type": "string",
          "title": "Text",
          "description": "The plain text content of the message."
        },
        "files": {
          "type": "array",
          "items": {
            "type": "string"
          },
          "title": "Files",
          "description": "URLs of files attached to the message."
        },
        "roomId": {
          "type": "string",
          "title": "Room Id",
          "description": "The unique identifier for the room."
        },
        "created": {
          "type": "string",
          "title": "Created",
          "description": "ISO 8601 timestamp when the message was created."
        },
        "updated": {
          "type": "string",
          "title": "Updated",
          "description": "ISO 8601 timestamp when the message was last edited."
        },
        "markdown": {
          "type": "string",
          "title": "Markdown",
          "description": "The Markdown-formatted content of the message."
        },
        "parentId": {
          "type": "string",
          "title": "Parent Id",
          "description": "The unique identifier for the parent message if this is a threaded reply."
        },
        "personId": {
          "type": "string",
          "title": "Person Id",
          "description": "The unique identifier for the person who sent the message."
        },
        "roomType": {
          "enum": [
            "group",
            "direct"
          ],
          "type": "string",
          "title": "Room Type",
          "description": "The type of room (e.g., 'group' or 'direct')."
        },
        "toPersonId": {
          "type": "string",
          "title": "To Person Id",
          "description": "The unique identifier for the recipient in a 1:1 message."
        },
        "attachments": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "MessageAttachment",
            "required": [
              "contentType",
              "content"
            ],
            "properties": {
              "content": {
                "type": "object",
                "title": "Content",
                "description": "The attachment content, typically an Adaptive Card JSON object.",
                "additionalProperties": true
              },
              "contentType": {
                "type": "string",
                "title": "Content Type",
                "description": "The MIME type of the attachment (e.g., 'application/vnd.microsoft.card.adaptive')."
              }
            },
            "description": "Represents a content attachment (e.g., Adaptive Card) in a Webex message."
          },
          "title": "Attachments",
          "description": "Content attachments (e.g., Adaptive Cards) included in the message."
        },
        "isVoiceClip": {
          "type": "boolean",
          "title": "Is Voice Clip",
          "description": "Indicates whether the message is a voice clip."
        },
        "personEmail": {
          "type": "string",
          "title": "Person Email",
          "description": "The email address of the person who sent the message."
        },
        "toPersonEmail": {
          "type": "string",
          "title": "To Person Email",
          "description": "The email address of the recipient in a 1:1 message."
        },
        "mentionedGroups": {
          "type": "array",
          "items": {
            "type": "string"
          },
          "title": "Mentioned Groups",
          "description": "List of group IDs mentioned in the message."
        },
        "mentionedPeople": {
          "type": "array",
          "items": {
            "type": "string"
          },
          "title": "Mentioned People",
          "description": "List of person IDs mentioned in the message."
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

## WEBEX_MESSAGING_GET_TEAM_MEMBERSHIP_DETAILS
Tool to retrieve details for a specific team membership. Use when you need metadata for a team membership by its ID.

**Input schema:**
```json
{
  "type": "object",
  "title": "MessagingGetTeamMembershipDetailsRequest",
  "required": [
    "membershipId"
  ],
  "properties": {
    "membershipId": {
      "type": "string",
      "title": "Membership Id",
      "examples": [
        "Y2lzY29zcGFyazovL3RlYW1NZW1iZXJzL2Y5OWFjM2I3LWE4NTgtNGI2ZC05OGM3LWIyYzE2ZjE5M2I1Yg"
      ],
      "description": "The unique identifier for the team membership."
    }
  },
  "description": "Request model for retrieving details of a Webex team membership by its unique identifier."
}
```

**Output schema:**
```json
{
  "type": "object",
  "$defs": {
    "MessagingGetTeamMembershipDetailsResponse": {
      "type": "object",
      "title": "MessagingGetTeamMembershipDetailsResponse",
      "required": [
        "id",
        "teamId",
        "personId",
        "personEmail",
        "personDisplayName",
        "personOrgId",
        "isModerator",
        "created"
      ],
      "properties": {
        "id": {
          "type": "string",
          "title": "Id",
          "description": "The unique identifier for the team membership."
        },
        "teamId": {
          "type": "string",
          "title": "Team Id",
          "description": "The unique identifier for the team."
        },
        "created": {
          "type": "string",
          "title": "Created",
          "description": "ISO 8601 timestamp when the team membership was created."
        },
        "personId": {
          "type": "string",
          "title": "Person Id",
          "description": "The unique identifier for the person in the membership."
        },
        "isModerator": {
          "type": "boolean",
          "title": "Is Moderator",
          "description": "True if the person is a moderator of the team."
        },
        "personEmail": {
          "type": "string",
          "title": "Person Email",
          "description": "The email address of the person in the membership."
        },
        "personOrgId": {
          "type": "string",
          "title": "Person Org Id",
          "description": "The unique identifier for the organization of the person."
        },
        "personDisplayName": {
          "type": "string",
          "title": "Person Display Name",
          "description": "The display name of the person in the membership."
        }
      },
      "description": "Response model for details of a Webex team membership."
    }
  },
  "title": "MessagingGetTeamMembershipDetailsResponseWrapper",
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
        "teamId",
        "personId",
        "personEmail",
        "personDisplayName",
        "personOrgId",
        "isModerator",
        "created"
      ],
      "properties": {
        "id": {
          "type": "string",
          "title": "Id",
          "description": "The unique identifier for the team membership."
        },
        "teamId": {
          "type": "string",
          "title": "Team Id",
          "description": "The unique identifier for the team."
        },
        "created": {
          "type": "string",
          "title": "Created",
          "description": "ISO 8601 timestamp when the team membership was created."
        },
        "personId": {
          "type": "string",
          "title": "Person Id",
          "description": "The unique identifier for the person in the membership."
        },
        "isModerator": {
          "type": "boolean",
          "title": "Is Moderator",
          "description": "True if the person is a moderator of the team."
        },
        "personEmail": {
          "type": "string",
          "title": "Person Email",
          "description": "The email address of the person in the membership."
        },
        "personOrgId": {
          "type": "string",
          "title": "Person Org Id",
          "description": "The unique identifier for the organization of the person."
        },
        "personDisplayName": {
          "type": "string",
          "title": "Person Display Name",
          "description": "The display name of the person in the membership."
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

## WEBEX_MESSAGING_LIST_MEMBERSHIPS
List memberships in Webex rooms. When called without parameters, returns memberships for all rooms the authenticated user belongs to. Use roomId to list all members of a specific room. Use personId or personEmail with roomId to check if a specific person is a member of a room. Supports filtering by teamId and limiting results with max parameter.

**Input schema:**
```json
{
  "type": "object",
  "title": "MessagingListMembershipsRequest",
  "properties": {
    "max": {
      "type": "integer",
      "title": "Max",
      "minimum": 1,
      "examples": [
        50
      ],
      "description": "Limit the maximum number of membership records returned."
    },
    "roomId": {
      "type": "string",
      "title": "Room Id",
      "description": "Filter memberships by the Webex room ID. Lists all members of the specified room."
    },
    "teamId": {
      "type": "string",
      "title": "Team Id",
      "description": "Filter memberships associated with a specific team ID."
    },
    "personId": {
      "type": "string",
      "title": "Person Id",
      "description": "Filter memberships by the Webex person ID. Note: Requires roomId parameter to be specified (unless you are a Compliance Officer)."
    },
    "personEmail": {
      "type": "string",
      "title": "Person Email",
      "description": "Filter memberships by the member's email address. Note: Requires roomId parameter to be specified (unless you are a Compliance Officer)."
    }
  },
  "description": "Request parameters to filter which memberships to list."
}
```

**Output schema:**
```json
{
  "type": "object",
  "$defs": {
    "MembershipItem": {
      "type": "object",
      "title": "MembershipItem",
      "required": [
        "id",
        "roomId",
        "personId",
        "personEmail",
        "personDisplayName",
        "personOrgId",
        "isModerator",
        "isMonitor",
        "created"
      ],
      "properties": {
        "id": {
          "type": "string",
          "title": "Id",
          "description": "Unique identifier for the membership."
        },
        "roomId": {
          "type": "string",
          "title": "Room Id",
          "description": "ID of the room associated with the membership."
        },
        "created": {
          "type": "string",
          "title": "Created",
          "description": "Timestamp when the membership was created in ISO 8601 format."
        },
        "personId": {
          "type": "string",
          "title": "Person Id",
          "description": "ID of the person in the membership."
        },
        "roomType": {
          "type": "string",
          "title": "Room Type",
          "description": "Type of room: 'direct' for 1:1 spaces or 'group' for group spaces."
        },
        "isMonitor": {
          "type": "boolean",
          "title": "Is Monitor",
          "description": "True if the person is monitoring the room."
        },
        "isModerator": {
          "type": "boolean",
          "title": "Is Moderator",
          "description": "True if the person is a room moderator."
        },
        "personEmail": {
          "type": "string",
          "title": "Person Email",
          "description": "Email address of the person in the membership."
        },
        "personOrgId": {
          "type": "string",
          "title": "Person Org Id",
          "description": "Organization ID of the person."
        },
        "isRoomHidden": {
          "type": "boolean",
          "title": "Is Room Hidden",
          "description": "True if the room is hidden in the Webex client for direct rooms."
        },
        "personDisplayName": {
          "type": "string",
          "title": "Person Display Name",
          "description": "Display name of the person."
        }
      },
      "description": "A single room membership record."
    },
    "MessagingListMembershipsResponse": {
      "type": "object",
      "title": "MessagingListMembershipsResponse",
      "required": [
        "items"
      ],
      "properties": {
        "items": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "MembershipItem",
            "required": [
              "id",
              "roomId",
              "personId",
              "personEmail",
              "personDisplayName",
              "personOrgId",
              "isModerator",
              "isMonitor",
              "created"
            ],
            "properties": {
              "id": {
                "type": "string",
                "title": "Id",
                "description": "Unique identifier for the membership."
              },
              "roomId": {
                "type": "string",
                "title": "Room Id",
                "description": "ID of the room associated with the membership."
              },
              "created": {
                "type": "string",
                "title": "Created",
                "description": "Timestamp when the membership was created in ISO 8601 format."
              },
              "personId": {
                "type": "string",
                "title": "Person Id",
                "description": "ID of the person in the membership."
              },
              "roomType": {
                "type": "string",
                "title": "Room Type",
                "description": "Type of room: 'direct' for 1:1 spaces or 'group' for group spaces."
              },
              "isMonitor": {
                "type": "boolean",
                "title": "Is Monitor",
                "description": "True if the person is monitoring the room."
              },
              "isModerator": {
                "type": "boolean",
                "title": "Is Moderator",
                "description": "True if the person is a room moderator."
              },
              "personEmail": {
                "type": "string",
                "title": "Person Email",
                "description": "Email address of the person in the membership."
              },
              "personOrgId": {
                "type": "string",
                "title": "Person Org Id",
                "description": "Organization ID of the person."
              },
              "isRoomHidden": {
                "type": "boolean",
                "title": "Is Room Hidden",
                "description": "True if the room is hidden in the Webex client for direct rooms."
              },
              "personDisplayName": {
                "type": "string",
                "title": "Person Display Name",
                "description": "Display name of the person."
              }
            },
            "description": "A single room membership record."
          },
          "title": "Items",
          "description": "List of membership objects matching the request filters."
        }
      },
      "description": "Response schema for listing memberships."
    }
  },
  "title": "MessagingListMembershipsResponseWrapper",
  "required": [
    "data",
    "successful"
  ],
  "properties": {
    "data": {
      "type": "object",
      "title": "Data",
      "required": [
        "items"
      ],
      "properties": {
        "items": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "MembershipItem",
            "required": [
              "id",
              "roomId",
              "personId",
              "personEmail",
              "personDisplayName",
              "personOrgId",
              "isModerator",
              "isMonitor",
              "created"
            ],
            "properties": {
              "id": {
                "type": "string",
                "title": "Id",
                "description": "Unique identifier for the membership."
              },
              "roomId": {
                "type": "string",
                "title": "Room Id",
                "description": "ID of the room associated with the membership."
              },
              "created": {
                "type": "string",
                "title": "Created",
                "description": "Timestamp when the membership was created in ISO 8601 format."
              },
              "personId": {
                "type": "string",
                "title": "Person Id",
                "description": "ID of the person in the membership."
              },
              "roomType": {
                "type": "string",
                "title": "Room Type",
                "description": "Type of room: 'direct' for 1:1 spaces or 'group' for group spaces."
              },
              "isMonitor": {
                "type": "boolean",
                "title": "Is Monitor",
                "description": "True if the person is monitoring the room."
              },
              "isModerator": {
                "type": "boolean",
                "title": "Is Moderator",
                "description": "True if the person is a room moderator."
              },
              "personEmail": {
                "type": "string",
                "title": "Person Email",
                "description": "Email address of the person in the membership."
              },
              "personOrgId": {
                "type": "string",
                "title": "Person Org Id",
                "description": "Organization ID of the person."
              },
              "isRoomHidden": {
                "type": "boolean",
                "title": "Is Room Hidden",
                "description": "True if the room is hidden in the Webex client for direct rooms."
              },
              "personDisplayName": {
                "type": "string",
                "title": "Person Display Name",
                "description": "Display name of the person."
              }
            },
            "description": "A single room membership record."
          },
          "title": "Items",
          "description": "List of membership objects matching the request filters."
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

## WEBEX_MESSAGING_LIST_MESSAGES
Tool to list messages in a room. Use when you need to retrieve chat history filtered by room, time window, or mentions.

**Input schema:**
```json
{
  "type": "object",
  "title": "MessagingListMessagesRequest",
  "required": [
    "roomId"
  ],
  "properties": {
    "max": {
      "type": "integer",
      "title": "Max",
      "minimum": 1,
      "description": "Maximum number of messages to return per request."
    },
    "before": {
      "type": "string",
      "title": "Before",
      "description": "Filter messages sent before a specific ISO8601 timestamp."
    },
    "roomId": {
      "type": "string",
      "title": "Room Id",
      "description": "Unique identifier for the room to list messages from."
    },
    "parentId": {
      "type": "string",
      "title": "Parent Id",
      "description": "Filter messages that are replies to a specific message ID."
    },
    "beforeMessage": {
      "type": "string",
      "title": "Before Message",
      "description": "Filter messages sent before a specific message, by its ID."
    },
    "mentionedPeople": {
      "type": "array",
      "items": {
        "type": "string"
      },
      "title": "Mentioned People",
      "description": "Filter messages where the caller is mentioned; use 'me' or person IDs."
    }
  },
  "description": "Request parameters to filter which messages to list in a room."
}
```

**Output schema:**
```json
{
  "type": "object",
  "$defs": {
    "MessageItem": {
      "type": "object",
      "title": "MessageItem",
      "required": [
        "id",
        "roomId",
        "roomType",
        "personId",
        "personEmail",
        "created"
      ],
      "properties": {
        "id": {
          "type": "string",
          "title": "Id",
          "description": "Unique identifier for the message."
        },
        "html": {
          "type": "string",
          "title": "Html",
          "description": "HTML representation of the message content."
        },
        "text": {
          "type": "string",
          "title": "Text",
          "description": "Plain text content of the message."
        },
        "roomId": {
          "type": "string",
          "title": "Room Id",
          "description": "Unique identifier for the room containing the message."
        },
        "created": {
          "type": "string",
          "title": "Created",
          "description": "ISO8601 timestamp when the message was created."
        },
        "markdown": {
          "type": "string",
          "title": "Markdown",
          "description": "Markdown content of the message."
        },
        "parentId": {
          "type": "string",
          "title": "Parent Id",
          "description": "ID of the parent message if this message is a reply."
        },
        "personId": {
          "type": "string",
          "title": "Person Id",
          "description": "Unique identifier of the person who sent the message."
        },
        "roomType": {
          "enum": [
            "direct",
            "group"
          ],
          "type": "string",
          "title": "Room Type",
          "description": "Type of room: 'direct' or 'group'."
        },
        "attachments": {
          "type": "array",
          "items": {
            "type": "object",
            "additionalProperties": true
          },
          "title": "Attachments",
          "description": "List of content attachments (e.g., adaptive cards) included in the message."
        },
        "personEmail": {
          "type": "string",
          "title": "Person Email",
          "description": "Email address of the person who sent the message."
        },
        "mentionedPeople": {
          "type": "array",
          "items": {
            "type": "string"
          },
          "title": "Mentioned People",
          "description": "List of person IDs mentioned in the message."
        }
      },
      "description": "A single message object returned by the list messages API."
    },
    "MessagingListMessagesResponse": {
      "type": "object",
      "title": "MessagingListMessagesResponse",
      "required": [
        "items"
      ],
      "properties": {
        "items": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "MessageItem",
            "required": [
              "id",
              "roomId",
              "roomType",
              "personId",
              "personEmail",
              "created"
            ],
            "properties": {
              "id": {
                "type": "string",
                "title": "Id",
                "description": "Unique identifier for the message."
              },
              "html": {
                "type": "string",
                "title": "Html",
                "description": "HTML representation of the message content."
              },
              "text": {
                "type": "string",
                "title": "Text",
                "description": "Plain text content of the message."
              },
              "roomId": {
                "type": "string",
                "title": "Room Id",
                "description": "Unique identifier for the room containing the message."
              },
              "created": {
                "type": "string",
                "title": "Created",
                "description": "ISO8601 timestamp when the message was created."
              },
              "markdown": {
                "type": "string",
                "title": "Markdown",
                "description": "Markdown content of the message."
              },
              "parentId": {
                "type": "string",
                "title": "Parent Id",
                "description": "ID of the parent message if this message is a reply."
              },
              "personId": {
                "type": "string",
                "title": "Person Id",
                "description": "Unique identifier of the person who sent the message."
              },
              "roomType": {
                "enum": [
                  "direct",
                  "group"
                ],
                "type": "string",
                "title": "Room Type",
                "description": "Type of room: 'direct' or 'group'."
              },
              "attachments": {
                "type": "array",
                "items": {
                  "type": "object",
                  "additionalProperties": true
                },
                "title": "Attachments",
                "description": "List of content attachments (e.g., adaptive cards) included in the message."
              },
              "personEmail": {
                "type": "string",
                "title": "Person Email",
                "description": "Email address of the person who sent the message."
              },
              "mentionedPeople": {
                "type": "array",
                "items": {
                  "type": "string"
                },
                "title": "Mentioned People",
                "description": "List of person IDs mentioned in the message."
              }
            },
            "description": "A single message object returned by the list messages API."
          },
          "title": "Items",
          "description": "List of message objects matching the request filters."
        }
      },
      "description": "Response schema for listing messages in a room."
    }
  },
  "title": "MessagingListMessagesResponseWrapper",
  "required": [
    "data",
    "successful"
  ],
  "properties": {
    "data": {
      "type": "object",
      "title": "Data",
      "required": [
        "items"
      ],
      "properties": {
        "items": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "MessageItem",
            "required": [
              "id",
              "roomId",
              "roomType",
              "personId",
              "personEmail",
              "created"
            ],
            "properties": {
              "id": {
                "type": "string",
                "title": "Id",
                "description": "Unique identifier for the message."
              },
              "html": {
                "type": "string",
                "title": "Html",
                "description": "HTML representation of the message content."
              },
              "text": {
                "type": "string",
                "title": "Text",
                "description": "Plain text content of the message."
              },
              "roomId": {
                "type": "string",
                "title": "Room Id",
                "description": "Unique identifier for the room containing the message."
              },
              "created": {
                "type": "string",
                "title": "Created",
                "description": "ISO8601 timestamp when the message was created."
              },
              "markdown": {
                "type": "string",
                "title": "Markdown",
                "description": "Markdown content of the message."
              },
              "parentId": {
                "type": "string",
                "title": "Parent Id",
                "description": "ID of the parent message if this message is a reply."
              },
              "personId": {
                "type": "string",
                "title": "Person Id",
                "description": "Unique identifier of the person who sent the message."
              },
              "roomType": {
                "enum": [
                  "direct",
                  "group"
                ],
                "type": "string",
                "title": "Room Type",
                "description": "Type of room: 'direct' or 'group'."
              },
              "attachments": {
                "type": "array",
                "items": {
                  "type": "object",
                  "additionalProperties": true
                },
                "title": "Attachments",
                "description": "List of content attachments (e.g., adaptive cards) included in the message."
              },
              "personEmail": {
                "type": "string",
                "title": "Person Email",
                "description": "Email address of the person who sent the message."
              },
              "mentionedPeople": {
                "type": "array",
                "items": {
                  "type": "string"
                },
                "title": "Mentioned People",
                "description": "List of person IDs mentioned in the message."
              }
            },
            "description": "A single message object returned by the list messages API."
          },
          "title": "Items",
          "description": "List of message objects matching the request filters."
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

## WEBEX_MESSAGING_LIST_ROOMS
Tool to list rooms the authenticated user belongs to. Use after authentication when needing to retrieve spaces filtered by team, type, or sorted. Example: "List my group rooms sorted by last activity."

**Input schema:**
```json
{
  "type": "object",
  "title": "MessagingListRoomsRequest",
  "properties": {
    "to": {
      "type": "string",
      "title": "To",
      "examples": [
        "2022-10-11T17:00:00.000Z"
      ],
      "description": "Filters rooms made public before this ISO 8601 timestamp. Used with orgPublicSpaces."
    },
    "max": {
      "type": "integer",
      "title": "Max",
      "maximum": 1000,
      "minimum": 1,
      "examples": [
        20
      ],
      "description": "Maximum number of rooms to return (1-1000). Default is 100."
    },
    "from": {
      "type": "string",
      "title": "From",
      "examples": [
        "2022-10-10T17:00:00.000Z"
      ],
      "description": "Filters rooms made public after this ISO 8601 timestamp. Used with orgPublicSpaces."
    },
    "type": {
      "enum": [
        "direct",
        "group"
      ],
      "type": "string",
      "title": "Type",
      "examples": [
        "group"
      ],
      "description": "Filter rooms by type: 'direct' (1:1) or 'group'. Cannot be set in combination with orgPublicSpaces."
    },
    "sortBy": {
      "enum": [
        "id",
        "lastactivity",
        "created"
      ],
      "type": "string",
      "title": "Sort By",
      "examples": [
        "lastactivity"
      ],
      "description": "Sort results by 'id', 'lastactivity' (recent activity), or 'created' (creation date). Cannot be set in combination with orgPublicSpaces."
    },
    "teamId": {
      "type": "string",
      "title": "Team Id",
      "examples": [
        "Y2lzY29zcGFyazovL3VzL1RFQU0vMTIzNDU2Nzg5MGFiY2Rl"
      ],
      "description": "Limit rooms to those associated with a specific team by ID. Cannot be set in combination with orgPublicSpaces."
    },
    "orgPublicSpaces": {
      "type": "boolean",
      "title": "Org Public Spaces",
      "examples": [
        true
      ],
      "description": "Shows the organization's public spaces (both joined and unjoined). When set, results are sorted by madePublic timestamp. Cannot be combined with teamId, type, or sortBy."
    }
  },
  "description": "Request parameters to filter which rooms to list."
}
```

**Output schema:**
```json
{
  "type": "object",
  "$defs": {
    "RoomItem": {
      "type": "object",
      "title": "RoomItem",
      "required": [
        "id",
        "title",
        "type",
        "isLocked",
        "lastActivity",
        "creatorId",
        "created"
      ],
      "properties": {
        "id": {
          "type": "string",
          "title": "Id",
          "description": "Unique identifier for the room."
        },
        "type": {
          "enum": [
            "direct",
            "group"
          ],
          "type": "string",
          "title": "Type",
          "description": "Type of the room."
        },
        "title": {
          "type": "string",
          "title": "Title",
          "description": "Title of the room."
        },
        "teamId": {
          "type": "string",
          "title": "Team Id",
          "description": "Team ID associated with the room, if any."
        },
        "created": {
          "type": "string",
          "title": "Created",
          "description": "ISO 8601 timestamp when the room was created."
        },
        "ownerId": {
          "type": "string",
          "title": "Owner Id",
          "description": "Organization ID that owns the room."
        },
        "isLocked": {
          "type": "boolean",
          "title": "Is Locked",
          "description": "Whether the room is locked."
        },
        "isPublic": {
          "type": "boolean",
          "title": "Is Public",
          "description": "Whether the room is publicly discoverable."
        },
        "creatorId": {
          "type": "string",
          "title": "Creator Id",
          "description": "ID of the user who created the room."
        },
        "isReadOnly": {
          "type": "boolean",
          "title": "Is Read Only",
          "description": "Whether the room is in read-only mode."
        },
        "madePublic": {
          "type": "string",
          "title": "Made Public",
          "description": "ISO 8601 timestamp when the room was made public."
        },
        "description": {
          "type": "string",
          "title": "Description",
          "description": "Description text for the room."
        },
        "lastActivity": {
          "type": "string",
          "title": "Last Activity",
          "description": "ISO 8601 timestamp of last activity in the room."
        },
        "classificationId": {
          "type": "string",
          "title": "Classification Id",
          "description": "Space classification identifier."
        },
        "isAnnouncementOnly": {
          "type": "boolean",
          "title": "Is Announcement Only",
          "description": "Whether the room is in announcement-only mode."
        }
      },
      "description": "Represents a single Webex room (space)."
    },
    "MessagingListRoomsResponse": {
      "type": "object",
      "title": "MessagingListRoomsResponse",
      "required": [
        "items"
      ],
      "properties": {
        "items": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "RoomItem",
            "required": [
              "id",
              "title",
              "type",
              "isLocked",
              "lastActivity",
              "creatorId",
              "created"
            ],
            "properties": {
              "id": {
                "type": "string",
                "title": "Id",
                "description": "Unique identifier for the room."
              },
              "type": {
                "enum": [
                  "direct",
                  "group"
                ],
                "type": "string",
                "title": "Type",
                "description": "Type of the room."
              },
              "title": {
                "type": "string",
                "title": "Title",
                "description": "Title of the room."
              },
              "teamId": {
                "type": "string",
                "title": "Team Id",
                "description": "Team ID associated with the room, if any."
              },
              "created": {
                "type": "string",
                "title": "Created",
                "description": "ISO 8601 timestamp when the room was created."
              },
              "ownerId": {
                "type": "string",
                "title": "Owner Id",
                "description": "Organization ID that owns the room."
              },
              "isLocked": {
                "type": "boolean",
                "title": "Is Locked",
                "description": "Whether the room is locked."
              },
              "isPublic": {
                "type": "boolean",
                "title": "Is Public",
                "description": "Whether the room is publicly discoverable."
              },
              "creatorId": {
                "type": "string",
                "title": "Creator Id",
                "description": "ID of the user who created the room."
              },
              "isReadOnly": {
                "type": "boolean",
                "title": "Is Read Only",
                "description": "Whether the room is in read-only mode."
              },
              "madePublic": {
                "type": "string",
                "title": "Made Public",
                "description": "ISO 8601 timestamp when the room was made public."
              },
              "description": {
                "type": "string",
                "title": "Description",
                "description": "Description text for the room."
              },
              "lastActivity": {
                "type": "string",
                "title": "Last Activity",
                "description": "ISO 8601 timestamp of last activity in the room."
              },
              "classificationId": {
                "type": "string",
                "title": "Classification Id",
                "description": "Space classification identifier."
              },
              "isAnnouncementOnly": {
                "type": "boolean",
                "title": "Is Announcement Only",
                "description": "Whether the room is in announcement-only mode."
              }
            },
            "description": "Represents a single Webex room (space)."
          },
          "title": "Items",
          "description": "List of room objects matching the request filters."
        }
      },
      "description": "Response model for listing rooms."
    }
  },
  "title": "MessagingListRoomsResponseWrapper",
  "required": [
    "data",
    "successful"
  ],
  "properties": {
    "data": {
      "type": "object",
      "title": "Data",
      "required": [
        "items"
      ],
      "properties": {
        "items": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "RoomItem",
            "required": [
              "id",
              "title",
              "type",
              "isLocked",
              "lastActivity",
              "creatorId",
              "created"
            ],
            "properties": {
              "id": {
                "type": "string",
                "title": "Id",
                "description": "Unique identifier for the room."
              },
              "type": {
                "enum": [
                  "direct",
                  "group"
                ],
                "type": "string",
                "title": "Type",
                "description": "Type of the room."
              },
              "title": {
                "type": "string",
                "title": "Title",
                "description": "Title of the room."
              },
              "teamId": {
                "type": "string",
                "title": "Team Id",
                "description": "Team ID associated with the room, if any."
              },
              "created": {
                "type": "string",
                "title": "Created",
                "description": "ISO 8601 timestamp when the room was created."
              },
              "ownerId": {
                "type": "string",
                "title": "Owner Id",
                "description": "Organization ID that owns the room."
              },
              "isLocked": {
                "type": "boolean",
                "title": "Is Locked",
                "description": "Whether the room is locked."
              },
              "isPublic": {
                "type": "boolean",
                "title": "Is Public",
                "description": "Whether the room is publicly discoverable."
              },
              "creatorId": {
                "type": "string",
                "title": "Creator Id",
                "description": "ID of the user who created the room."
              },
              "isReadOnly": {
                "type": "boolean",
                "title": "Is Read Only",
                "description": "Whether the room is in read-only mode."
              },
              "madePublic": {
                "type": "string",
                "title": "Made Public",
                "description": "ISO 8601 timestamp when the room was made public."
              },
              "description": {
                "type": "string",
                "title": "Description",
                "description": "Description text for the room."
              },
              "lastActivity": {
                "type": "string",
                "title": "Last Activity",
                "description": "ISO 8601 timestamp of last activity in the room."
              },
              "classificationId": {
                "type": "string",
                "title": "Classification Id",
                "description": "Space classification identifier."
              },
              "isAnnouncementOnly": {
                "type": "boolean",
                "title": "Is Announcement Only",
                "description": "Whether the room is in announcement-only mode."
              }
            },
            "description": "Represents a single Webex room (space)."
          },
          "title": "Items",
          "description": "List of room objects matching the request filters."
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

## WEBEX_MESSAGING_LIST_TEAM_MEMBERSHIPS
Tool to list all memberships for a specific team. Use when you need to retrieve all members of a team, including their roles (moderator status). Requires a valid teamId.

**Input schema:**
```json
{
  "type": "object",
  "title": "MessagingListTeamMembershipsRequest",
  "required": [
    "teamId"
  ],
  "properties": {
    "max": {
      "type": "integer",
      "title": "Max",
      "minimum": 1,
      "examples": [
        50
      ],
      "description": "Limit the maximum number of team membership records returned. Default is 100."
    },
    "teamId": {
      "type": "string",
      "title": "Team Id",
      "examples": [
        "Y2lzY29zcGFyazovL3VzL1RFQU0vMTIzNDU2Nzg5MGFiY2Rl"
      ],
      "description": "The team ID for which to list memberships. Required."
    }
  },
  "description": "Request parameters to list team memberships for a specific team."
}
```

**Output schema:**
```json
{
  "type": "object",
  "$defs": {
    "TeamMembershipItem": {
      "type": "object",
      "title": "TeamMembershipItem",
      "required": [
        "id",
        "teamId",
        "personId",
        "personEmail",
        "personDisplayName",
        "personOrgId",
        "isModerator",
        "created"
      ],
      "properties": {
        "id": {
          "type": "string",
          "title": "Id",
          "description": "Unique identifier for the membership."
        },
        "teamId": {
          "type": "string",
          "title": "Team Id",
          "description": "ID of the team associated with the membership."
        },
        "created": {
          "type": "string",
          "title": "Created",
          "description": "Timestamp when the membership was created in ISO 8601 format."
        },
        "personId": {
          "type": "string",
          "title": "Person Id",
          "description": "ID of the person in the membership."
        },
        "isMonitor": {
          "type": "boolean",
          "title": "Is Monitor",
          "description": "True if the person is monitoring the team."
        },
        "isModerator": {
          "type": "boolean",
          "title": "Is Moderator",
          "description": "True if the person is a team moderator."
        },
        "personEmail": {
          "type": "string",
          "title": "Person Email",
          "description": "Email address of the person in the membership."
        },
        "personOrgId": {
          "type": "string",
          "title": "Person Org Id",
          "description": "Organization ID of the person."
        },
        "personDisplayName": {
          "type": "string",
          "title": "Person Display Name",
          "description": "Display name of the person."
        }
      },
      "description": "A single team membership record."
    },
    "MessagingListTeamMembershipsResponse": {
      "type": "object",
      "title": "MessagingListTeamMembershipsResponse",
      "required": [
        "items"
      ],
      "properties": {
        "items": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "TeamMembershipItem",
            "required": [
              "id",
              "teamId",
              "personId",
              "personEmail",
              "personDisplayName",
              "personOrgId",
              "isModerator",
              "created"
            ],
            "properties": {
              "id": {
                "type": "string",
                "title": "Id",
                "description": "Unique identifier for the membership."
              },
              "teamId": {
                "type": "string",
                "title": "Team Id",
                "description": "ID of the team associated with the membership."
              },
              "created": {
                "type": "string",
                "title": "Created",
                "description": "Timestamp when the membership was created in ISO 8601 format."
              },
              "personId": {
                "type": "string",
                "title": "Person Id",
                "description": "ID of the person in the membership."
              },
              "isMonitor": {
                "type": "boolean",
                "title": "Is Monitor",
                "description": "True if the person is monitoring the team."
              },
              "isModerator": {
                "type": "boolean",
                "title": "Is Moderator",
                "description": "True if the person is a team moderator."
              },
              "personEmail": {
                "type": "string",
                "title": "Person Email",
                "description": "Email address of the person in the membership."
              },
              "personOrgId": {
                "type": "string",
                "title": "Person Org Id",
                "description": "Organization ID of the person."
              },
              "personDisplayName": {
                "type": "string",
                "title": "Person Display Name",
                "description": "Display name of the person."
              }
            },
            "description": "A single team membership record."
          },
          "title": "Items",
          "description": "List of team membership objects matching the request filters."
        }
      },
      "description": "Response schema for listing team memberships."
    }
  },
  "title": "MessagingListTeamMembershipsResponseWrapper",
  "required": [
    "data",
    "successful"
  ],
  "properties": {
    "data": {
      "type": "object",
      "title": "Data",
      "required": [
        "items"
      ],
      "properties": {
        "items": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "TeamMembershipItem",
            "required": [
              "id",
              "teamId",
              "personId",
              "personEmail",
              "personDisplayName",
              "personOrgId",
              "isModerator",
              "created"
            ],
            "properties": {
              "id": {
                "type": "string",
                "title": "Id",
                "description": "Unique identifier for the membership."
              },
              "teamId": {
                "type": "string",
                "title": "Team Id",
                "description": "ID of the team associated with the membership."
              },
              "created": {
                "type": "string",
                "title": "Created",
                "description": "Timestamp when the membership was created in ISO 8601 format."
              },
              "personId": {
                "type": "string",
                "title": "Person Id",
                "description": "ID of the person in the membership."
              },
              "isMonitor": {
                "type": "boolean",
                "title": "Is Monitor",
                "description": "True if the person is monitoring the team."
              },
              "isModerator": {
                "type": "boolean",
                "title": "Is Moderator",
                "description": "True if the person is a team moderator."
              },
              "personEmail": {
                "type": "string",
                "title": "Person Email",
                "description": "Email address of the person in the membership."
              },
              "personOrgId": {
                "type": "string",
                "title": "Person Org Id",
                "description": "Organization ID of the person."
              },
              "personDisplayName": {
                "type": "string",
                "title": "Person Display Name",
                "description": "Display name of the person."
              }
            },
            "description": "A single team membership record."
          },
          "title": "Items",
          "description": "List of team membership objects matching the request filters."
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

## WEBEX_PEOPLE_GET_PERSON
Retrieves detailed profile information for a specific person by their ID. Returns comprehensive user details including contact information, organizational data, presence status, and Webex Calling information. Use when you need full profile details for a known person ID. To find person IDs, use the List People action first.

**Input schema:**
```json
{
  "type": "object",
  "title": "PeopleGetPersonRequest",
  "required": [
    "personId"
  ],
  "properties": {
    "personId": {
      "type": "string",
      "title": "Person Id",
      "examples": [
        "Y2lzY29zcGFyazovL3VzL1BFT1BMRS8xMjM0NTY3ODkw"
      ],
      "description": "The unique identifier (ID) of the person to retrieve. This is a base64-encoded identifier that starts with 'Y2lzY29zcGFyazovL3VzL1BFT1BMRS8'. Obtain person IDs from the List People action."
    },
    "callingData": {
      "type": "boolean",
      "title": "Calling Data",
      "description": "Whether to include Webex Calling (BroadCloud) user details in the response. Set to true to retrieve calling-specific information like extensions and location IDs. Only applicable for users with a Webex Calling license. Default is false."
    }
  },
  "description": "Request model for retrieving details of a specific person by ID."
}
```

**Output schema:**
```json
{
  "type": "object",
  "$defs": {
    "Address": {
      "type": "object",
      "title": "Address",
      "properties": {
        "type": {
          "type": "string",
          "title": "Type",
          "description": "Type of address, e.g., 'work', 'home'."
        },
        "region": {
          "type": "string",
          "title": "Region",
          "description": "State or region."
        },
        "country": {
          "type": "string",
          "title": "Country",
          "description": "Country code."
        },
        "locality": {
          "type": "string",
          "title": "Locality",
          "description": "City or locality."
        },
        "postalCode": {
          "type": "string",
          "title": "Postal Code",
          "description": "Postal code."
        },
        "streetAddress": {
          "type": "string",
          "title": "Street Address",
          "description": "Street address."
        }
      }
    },
    "Manager": {
      "type": "object",
      "title": "Manager",
      "properties": {
        "id": {
          "type": "string",
          "title": "Id",
          "description": "Manager's person ID."
        },
        "displayName": {
          "type": "string",
          "title": "Display Name",
          "description": "Manager's display name."
        }
      }
    },
    "SipAddress": {
      "type": "object",
      "title": "SipAddress",
      "properties": {
        "type": {
          "type": "string",
          "title": "Type",
          "description": "Type of SIP address, e.g., 'personal', 'work'."
        },
        "address": {
          "type": "string",
          "title": "Address",
          "description": "The SIP address."
        }
      }
    },
    "PhoneNumber": {
      "type": "object",
      "title": "PhoneNumber",
      "properties": {
        "type": {
          "type": "string",
          "title": "Type",
          "description": "Type of phone number, e.g., 'work', 'mobile'."
        },
        "number": {
          "type": "string",
          "title": "Number",
          "description": "The phone number."
        }
      }
    },
    "PeopleGetPersonResponse": {
      "type": "object",
      "title": "PeopleGetPersonResponse",
      "required": [
        "id",
        "emails",
        "phoneNumbers"
      ],
      "properties": {
        "id": {
          "type": "string",
          "title": "Id",
          "description": "The person's unique identifier."
        },
        "type": {
          "type": "string",
          "title": "Type",
          "description": "Person type, e.g., 'person', 'bot', 'appuser'."
        },
        "orgId": {
          "type": "string",
          "title": "Org Id",
          "description": "Organization ID for the person."
        },
        "roles": {
          "type": "array",
          "items": {
            "type": "string"
          },
          "title": "Roles",
          "description": "List of roles for the person."
        },
        "title": {
          "type": "string",
          "title": "Title",
          "description": "The person's job title."
        },
        "avatar": {
          "type": "string",
          "title": "Avatar",
          "description": "URL to the person's avatar image."
        },
        "emails": {
          "type": "array",
          "items": {
            "type": "string"
          },
          "title": "Emails",
          "description": "List of the person's email addresses."
        },
        "status": {
          "type": "string",
          "title": "Status",
          "description": "The person's status."
        },
        "created": {
          "type": "string",
          "title": "Created",
          "description": "ISO 8601 timestamp when the person was created."
        },
        "manager": {
          "type": "object",
          "title": "Manager",
          "properties": {
            "id": {
              "type": "string",
              "title": "Id",
              "description": "Manager's person ID."
            },
            "displayName": {
              "type": "string",
              "title": "Display Name",
              "description": "Manager's display name."
            }
          },
          "description": "Manager information for the person."
        },
        "lastName": {
          "type": "string",
          "title": "Last Name",
          "description": "The person's last name."
        },
        "licenses": {
          "type": "array",
          "items": {
            "type": "string"
          },
          "title": "Licenses",
          "description": "List of licenses for the person."
        },
        "location": {
          "type": "string",
          "title": "Location",
          "description": "The person's location."
        },
        "nickName": {
          "type": "string",
          "title": "Nick Name",
          "description": "The person's nickname."
        },
        "siteUrls": {
          "type": "array",
          "items": {
            "type": "string"
          },
          "title": "Site Urls",
          "description": "List of site URLs for the person."
        },
        "timeZone": {
          "type": "string",
          "title": "Time Zone",
          "description": "The person's time zone, e.g., 'America/New_York'."
        },
        "userName": {
          "type": "string",
          "title": "User Name",
          "description": "The person's username for login."
        },
        "addresses": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "Address",
            "properties": {
              "type": {
                "type": "string",
                "title": "Type",
                "description": "Type of address, e.g., 'work', 'home'."
              },
              "region": {
                "type": "string",
                "title": "Region",
                "description": "State or region."
              },
              "country": {
                "type": "string",
                "title": "Country",
                "description": "Country code."
              },
              "locality": {
                "type": "string",
                "title": "Locality",
                "description": "City or locality."
              },
              "postalCode": {
                "type": "string",
                "title": "Postal Code",
                "description": "Postal code."
              },
              "streetAddress": {
                "type": "string",
                "title": "Street Address",
                "description": "Street address."
              }
            }
          },
          "title": "Addresses",
          "description": "List of the person's addresses."
        },
        "extension": {
          "type": "string",
          "title": "Extension",
          "description": "Webex Calling extension (requires Calling license)."
        },
        "firstName": {
          "type": "string",
          "title": "First Name",
          "description": "The person's first name."
        },
        "managerId": {
          "type": "string",
          "title": "Manager Id",
          "description": "Manager's person ID."
        },
        "department": {
          "type": "string",
          "title": "Department",
          "description": "The person's department."
        },
        "locationId": {
          "type": "string",
          "title": "Location Id",
          "description": "Location ID for Webex Calling users."
        },
        "displayName": {
          "type": "string",
          "title": "Display Name",
          "description": "The person's full name."
        },
        "lastActivity": {
          "type": "string",
          "title": "Last Activity",
          "description": "ISO 8601 timestamp of the person's last activity."
        },
        "lastModified": {
          "type": "string",
          "title": "Last Modified",
          "description": "ISO 8601 timestamp when the person was last modified."
        },
        "loginEnabled": {
          "type": "boolean",
          "title": "Login Enabled",
          "description": "True if the person can log in."
        },
        "phoneNumbers": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "PhoneNumber",
            "properties": {
              "type": {
                "type": "string",
                "title": "Type",
                "description": "Type of phone number, e.g., 'work', 'mobile'."
              },
              "number": {
                "type": "string",
                "title": "Number",
                "description": "The phone number."
              }
            }
          },
          "title": "Phone Numbers",
          "description": "List of the person's phone numbers."
        },
        "sipAddresses": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "SipAddress",
            "properties": {
              "type": {
                "type": "string",
                "title": "Type",
                "description": "Type of SIP address, e.g., 'personal', 'work'."
              },
              "address": {
                "type": "string",
                "title": "Address",
                "description": "The SIP address."
              }
            }
          },
          "title": "Sip Addresses",
          "description": "List of the person's SIP addresses."
        },
        "invitePending": {
          "type": "boolean",
          "title": "Invite Pending",
          "description": "True if the person has a pending invitation."
        }
      },
      "description": "Response model for retrieving details of a specific person."
    }
  },
  "title": "PeopleGetPersonResponseWrapper",
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
        "emails",
        "phoneNumbers"
      ],
      "properties": {
        "id": {
          "type": "string",
          "title": "Id",
          "description": "The person's unique identifier."
        },
        "type": {
          "type": "string",
          "title": "Type",
          "description": "Person type, e.g., 'person', 'bot', 'appuser'."
        },
        "orgId": {
          "type": "string",
          "title": "Org Id",
          "description": "Organization ID for the person."
        },
        "roles": {
          "type": "array",
          "items": {
            "type": "string"
          },
          "title": "Roles",
          "description": "List of roles for the person."
        },
        "title": {
          "type": "string",
          "title": "Title",
          "description": "The person's job title."
        },
        "avatar": {
          "type": "string",
          "title": "Avatar",
          "description": "URL to the person's avatar image."
        },
        "emails": {
          "type": "array",
          "items": {
            "type": "string"
          },
          "title": "Emails",
          "description": "List of the person's email addresses."
        },
        "status": {
          "type": "string",
          "title": "Status",
          "description": "The person's status."
        },
        "created": {
          "type": "string",
          "title": "Created",
          "description": "ISO 8601 timestamp when the person was created."
        },
        "manager": {
          "type": "object",
          "title": "Manager",
          "properties": {
            "id": {
              "type": "string",
              "title": "Id",
              "description": "Manager's person ID."
            },
            "displayName": {
              "type": "string",
              "title": "Display Name",
              "description": "Manager's display name."
            }
          },
          "description": "Manager information for the person."
        },
        "lastName": {
          "type": "string",
          "title": "Last Name",
          "description": "The person's last name."
        },
        "licenses": {
          "type": "array",
          "items": {
            "type": "string"
          },
          "title": "Licenses",
          "description": "List of licenses for the person."
        },
        "location": {
          "type": "string",
          "title": "Location",
          "description": "The person's location."
        },
        "nickName": {
          "type": "string",
          "title": "Nick Name",
          "description": "The person's nickname."
        },
        "siteUrls": {
          "type": "array",
          "items": {
            "type": "string"
          },
          "title": "Site Urls",
          "description": "List of site URLs for the person."
        },
        "timeZone": {
          "type": "string",
          "title": "Time Zone",
          "description": "The person's time zone, e.g., 'America/New_York'."
        },
        "userName": {
          "type": "string",
          "title": "User Name",
          "description": "The person's username for login."
        },
        "addresses": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "Address",
            "properties": {
              "type": {
                "type": "string",
                "title": "Type",
                "description": "Type of address, e.g., 'work', 'home'."
              },
              "region": {
                "type": "string",
                "title": "Region",
                "description": "State or region."
              },
              "country": {
                "type": "string",
                "title": "Country",
                "description": "Country code."
              },
              "locality": {
                "type": "string",
                "title": "Locality",
                "description": "City or locality."
              },
              "postalCode": {
                "type": "string",
                "title": "Postal Code",
                "description": "Postal code."
              },
              "streetAddress": {
                "type": "string",
                "title": "Street Address",
                "description": "Street address."
              }
            }
          },
          "title": "Addresses",
          "description": "List of the person's addresses."
        },
        "extension": {
          "type": "string",
          "title": "Extension",
          "description": "Webex Calling extension (requires Calling license)."
        },
        "firstName": {
          "type": "string",
          "title": "First Name",
          "description": "The person's first name."
        },
        "managerId": {
          "type": "string",
          "title": "Manager Id",
          "description": "Manager's person ID."
        },
        "department": {
          "type": "string",
          "title": "Department",
          "description": "The person's department."
        },
        "locationId": {
          "type": "string",
          "title": "Location Id",
          "description": "Location ID for Webex Calling users."
        },
        "displayName": {
          "type": "string",
          "title": "Display Name",
          "description": "The person's full name."
        },
        "lastActivity": {
          "type": "string",
          "title": "Last Activity",
          "description": "ISO 8601 timestamp of the person's last activity."
        },
        "lastModified": {
          "type": "string",
          "title": "Last Modified",
          "description": "ISO 8601 timestamp when the person was last modified."
        },
        "loginEnabled": {
          "type": "boolean",
          "title": "Login Enabled",
          "description": "True if the person can log in."
        },
        "phoneNumbers": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "PhoneNumber",
            "properties": {
              "type": {
                "type": "string",
                "title": "Type",
                "description": "Type of phone number, e.g., 'work', 'mobile'."
              },
              "number": {
                "type": "string",
                "title": "Number",
                "description": "The phone number."
              }
            }
          },
          "title": "Phone Numbers",
          "description": "List of the person's phone numbers."
        },
        "sipAddresses": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "SipAddress",
            "properties": {
              "type": {
                "type": "string",
                "title": "Type",
                "description": "Type of SIP address, e.g., 'personal', 'work'."
              },
              "address": {
                "type": "string",
                "title": "Address",
                "description": "The SIP address."
              }
            }
          },
          "title": "Sip Addresses",
          "description": "List of the person's SIP addresses."
        },
        "invitePending": {
          "type": "boolean",
          "title": "Invite Pending",
          "description": "True if the person has a pending invitation."
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

## WEBEX_PEOPLE_LIST_PEOPLE
Tool to list people in your organization. Use when you need to retrieve people filtered by email, display name, IDs, roles, or location.

**Input schema:**
```json
{
  "type": "object",
  "title": "PeopleListPeopleRequest",
  "properties": {
    "id": {
      "type": "string",
      "title": "Id",
      "examples": [
        "Y2lzY29zcGFyazovL3VzL1BFT1BMRS8wMTIzLGY2ZTY="
      ],
      "description": "List people by ID. Accepts up to 85 person IDs separated by commas."
    },
    "max": {
      "type": "integer",
      "title": "Max",
      "minimum": 1,
      "examples": [
        50
      ],
      "description": "Maximum number of people to return per request."
    },
    "email": {
      "type": "string",
      "title": "Email",
      "examples": [
        "alice@example.com"
      ],
      "description": "List people with this email address. For non-admin calls, either email or displayName is required."
    },
    "orgId": {
      "type": "string",
      "title": "Org Id",
      "examples": [
        "Y2lzY29zcGFyazovL3VzL09SR0FOSVpBVElPTj8="
      ],
      "description": "List people in this organization. Only admin users of another organization (such as partners) may use this parameter."
    },
    "roles": {
      "type": "string",
      "title": "Roles",
      "examples": [
        "ROLE_ID_1,ROLE_ID_2"
      ],
      "description": "List of role IDs separated by commas."
    },
    "locationId": {
      "type": "string",
      "title": "Location Id",
      "examples": [
        "LOCATION_ID_123"
      ],
      "description": "List people present in this location."
    },
    "callingData": {
      "type": "boolean",
      "title": "Calling Data",
      "examples": [
        true
      ],
      "description": "Include Webex Calling user details in the response. Default is false."
    },
    "displayName": {
      "type": "string",
      "title": "Display Name",
      "examples": [
        "Alice"
      ],
      "description": "List people whose name starts with this string. Note: This parameter may not work for consumer organizations. For non-admin calls, either displayName or email is required."
    }
  },
  "description": "Request parameters to filter which people to list."
}
```

**Output schema:**
```json
{
  "type": "object",
  "$defs": {
    "PersonItem": {
      "type": "object",
      "title": "PersonItem",
      "required": [
        "id",
        "emails"
      ],
      "properties": {
        "id": {
          "type": "string",
          "title": "Id",
          "description": "A unique identifier for the person."
        },
        "type": {
          "type": "string",
          "title": "Type",
          "description": "The type of person account, such as 'person' or 'bot'."
        },
        "orgId": {
          "type": "string",
          "title": "Org Id",
          "description": "The ID of the organization to which this person belongs."
        },
        "roles": {
          "type": "array",
          "items": {
            "type": "string"
          },
          "title": "Roles",
          "description": "An array of role IDs for the person."
        },
        "avatar": {
          "type": "string",
          "title": "Avatar",
          "description": "URL to the person's avatar in PNG format."
        },
        "emails": {
          "type": "array",
          "items": {
            "type": "string"
          },
          "title": "Emails",
          "description": "The email addresses of the person."
        },
        "status": {
          "type": "string",
          "title": "Status",
          "description": "The person's current presence status (e.g., 'active', 'inactive')."
        },
        "created": {
          "type": "string",
          "title": "Created",
          "description": "The date and time the person was created."
        },
        "lastName": {
          "type": "string",
          "title": "Last Name",
          "description": "The last name of the person."
        },
        "licenses": {
          "type": "array",
          "items": {
            "type": "string"
          },
          "title": "Licenses",
          "description": "An array of license IDs for the person."
        },
        "nickName": {
          "type": "string",
          "title": "Nick Name",
          "description": "The nickname of the person."
        },
        "timeZone": {
          "type": "string",
          "title": "Time Zone",
          "description": "The time zone of the person."
        },
        "userName": {
          "type": "string",
          "title": "User Name",
          "description": "The username of the person."
        },
        "addresses": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "AddressItem",
            "properties": {
              "type": {
                "type": "string",
                "title": "Type",
                "description": "Address type (e.g., 'work', 'home')."
              },
              "region": {
                "type": "string",
                "title": "Region",
                "description": "State or region."
              },
              "country": {
                "type": "string",
                "title": "Country",
                "description": "Country code."
              },
              "locality": {
                "type": "string",
                "title": "Locality",
                "description": "City or locality."
              },
              "postalCode": {
                "type": "string",
                "title": "Postal Code",
                "description": "Postal or ZIP code."
              },
              "streetAddress": {
                "type": "string",
                "title": "Street Address",
                "description": "Street address."
              }
            },
            "description": "Address information for a person."
          },
          "title": "Addresses",
          "description": "An array of address objects for the person."
        },
        "firstName": {
          "type": "string",
          "title": "First Name",
          "description": "The first name of the person."
        },
        "displayName": {
          "type": "string",
          "title": "Display Name",
          "description": "The full name of the person."
        },
        "lastActivity": {
          "type": "string",
          "title": "Last Activity",
          "description": "The date and time of the person's last activity."
        },
        "lastModified": {
          "type": "string",
          "title": "Last Modified",
          "description": "The date and time the person was last modified."
        },
        "phoneNumbers": {
          "type": "array",
          "items": {
            "type": "object",
            "additionalProperties": true
          },
          "title": "Phone Numbers",
          "description": "An array of phone number objects with type, value, and primary flag."
        }
      },
      "description": "A single person object in the list."
    },
    "AddressItem": {
      "type": "object",
      "title": "AddressItem",
      "properties": {
        "type": {
          "type": "string",
          "title": "Type",
          "description": "Address type (e.g., 'work', 'home')."
        },
        "region": {
          "type": "string",
          "title": "Region",
          "description": "State or region."
        },
        "country": {
          "type": "string",
          "title": "Country",
          "description": "Country code."
        },
        "locality": {
          "type": "string",
          "title": "Locality",
          "description": "City or locality."
        },
        "postalCode": {
          "type": "string",
          "title": "Postal Code",
          "description": "Postal or ZIP code."
        },
        "streetAddress": {
          "type": "string",
          "title": "Street Address",
          "description": "Street address."
        }
      },
      "description": "Address information for a person."
    },
    "PeopleListPeopleResponse": {
      "type": "object",
      "title": "PeopleListPeopleResponse",
      "required": [
        "items"
      ],
      "properties": {
        "items": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "PersonItem",
            "required": [
              "id",
              "emails"
            ],
            "properties": {
              "id": {
                "type": "string",
                "title": "Id",
                "description": "A unique identifier for the person."
              },
              "type": {
                "type": "string",
                "title": "Type",
                "description": "The type of person account, such as 'person' or 'bot'."
              },
              "orgId": {
                "type": "string",
                "title": "Org Id",
                "description": "The ID of the organization to which this person belongs."
              },
              "roles": {
                "type": "array",
                "items": {
                  "type": "string"
                },
                "title": "Roles",
                "description": "An array of role IDs for the person."
              },
              "avatar": {
                "type": "string",
                "title": "Avatar",
                "description": "URL to the person's avatar in PNG format."
              },
              "emails": {
                "type": "array",
                "items": {
                  "type": "string"
                },
                "title": "Emails",
                "description": "The email addresses of the person."
              },
              "status": {
                "type": "string",
                "title": "Status",
                "description": "The person's current presence status (e.g., 'active', 'inactive')."
              },
              "created": {
                "type": "string",
                "title": "Created",
                "description": "The date and time the person was created."
              },
              "lastName": {
                "type": "string",
                "title": "Last Name",
                "description": "The last name of the person."
              },
              "licenses": {
                "type": "array",
                "items": {
                  "type": "string"
                },
                "title": "Licenses",
                "description": "An array of license IDs for the person."
              },
              "nickName": {
                "type": "string",
                "title": "Nick Name",
                "description": "The nickname of the person."
              },
              "timeZone": {
                "type": "string",
                "title": "Time Zone",
                "description": "The time zone of the person."
              },
              "userName": {
                "type": "string",
                "title": "User Name",
                "description": "The username of the person."
              },
              "addresses": {
                "type": "array",
                "items": {
                  "type": "object",
                  "title": "AddressItem",
                  "properties": {
                    "type": {
                      "type": "string",
                      "title": "Type",
                      "description": "Address type (e.g., 'work', 'home')."
                    },
                    "region": {
                      "type": "string",
                      "title": "Region",
                      "description": "State or region."
                    },
                    "country": {
                      "type": "string",
                      "title": "Country",
                      "description": "Country code."
                    },
                    "locality": {
                      "type": "string",
                      "title": "Locality",
                      "description": "City or locality."
                    },
                    "postalCode": {
                      "type": "string",
                      "title": "Postal Code",
                      "description": "Postal or ZIP code."
                    },
                    "streetAddress": {
                      "type": "string",
                      "title": "Street Address",
                      "description": "Street address."
                    }
                  },
                  "description": "Address information for a person."
                },
                "title": "Addresses",
                "description": "An array of address objects for the person."
              },
              "firstName": {
                "type": "string",
                "title": "First Name",
                "description": "The first name of the person."
              },
              "displayName": {
                "type": "string",
                "title": "Display Name",
                "description": "The full name of the person."
              },
              "lastActivity": {
                "type": "string",
                "title": "Last Activity",
                "description": "The date and time of the person's last activity."
              },
              "lastModified": {
                "type": "string",
                "title": "Last Modified",
                "description": "The date and time the person was last modified."
              },
              "phoneNumbers": {
                "type": "array",
                "items": {
                  "type": "object",
                  "additionalProperties": true
                },
                "title": "Phone Numbers",
                "description": "An array of phone number objects with type, value, and primary flag."
              }
            },
            "description": "A single person object in the list."
          },
          "title": "Items",
          "description": "List of person objects matching the request filters."
        },
        "notFoundIds": {
          "type": "array",
          "items": {
            "type": "string"
          },
          "title": "Not Found Ids",
          "description": "List of person IDs that were not found (only present when querying by ID)."
        }
      },
      "description": "Response schema for listing people."
    }
  },
  "title": "PeopleListPeopleResponseWrapper",
  "required": [
    "data",
    "successful"
  ],
  "properties": {
    "data": {
      "type": "object",
      "title": "Data",
      "required": [
        "items"
      ],
      "properties": {
        "items": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "PersonItem",
            "required": [
              "id",
              "emails"
            ],
            "properties": {
              "id": {
                "type": "string",
                "title": "Id",
                "description": "A unique identifier for the person."
              },
              "type": {
                "type": "string",
                "title": "Type",
                "description": "The type of person account, such as 'person' or 'bot'."
              },
              "orgId": {
                "type": "string",
                "title": "Org Id",
                "description": "The ID of the organization to which this person belongs."
              },
              "roles": {
                "type": "array",
                "items": {
                  "type": "string"
                },
                "title": "Roles",
                "description": "An array of role IDs for the person."
              },
              "avatar": {
                "type": "string",
                "title": "Avatar",
                "description": "URL to the person's avatar in PNG format."
              },
              "emails": {
                "type": "array",
                "items": {
                  "type": "string"
                },
                "title": "Emails",
                "description": "The email addresses of the person."
              },
              "status": {
                "type": "string",
                "title": "Status",
                "description": "The person's current presence status (e.g., 'active', 'inactive')."
              },
              "created": {
                "type": "string",
                "title": "Created",
                "description": "The date and time the person was created."
              },
              "lastName": {
                "type": "string",
                "title": "Last Name",
                "description": "The last name of the person."
              },
              "licenses": {
                "type": "array",
                "items": {
                  "type": "string"
                },
                "title": "Licenses",
                "description": "An array of license IDs for the person."
              },
              "nickName": {
                "type": "string",
                "title": "Nick Name",
                "description": "The nickname of the person."
              },
              "timeZone": {
                "type": "string",
                "title": "Time Zone",
                "description": "The time zone of the person."
              },
              "userName": {
                "type": "string",
                "title": "User Name",
                "description": "The username of the person."
              },
              "addresses": {
                "type": "array",
                "items": {
                  "type": "object",
                  "title": "AddressItem",
                  "properties": {
                    "type": {
                      "type": "string",
                      "title": "Type",
                      "description": "Address type (e.g., 'work', 'home')."
                    },
                    "region": {
                      "type": "string",
                      "title": "Region",
                      "description": "State or region."
                    },
                    "country": {
                      "type": "string",
                      "title": "Country",
                      "description": "Country code."
                    },
                    "locality": {
                      "type": "string",
                      "title": "Locality",
                      "description": "City or locality."
                    },
                    "postalCode": {
                      "type": "string",
                      "title": "Postal Code",
                      "description": "Postal or ZIP code."
                    },
                    "streetAddress": {
                      "type": "string",
                      "title": "Street Address",
                      "description": "Street address."
                    }
                  },
                  "description": "Address information for a person."
                },
                "title": "Addresses",
                "description": "An array of address objects for the person."
              },
              "firstName": {
                "type": "string",
                "title": "First Name",
                "description": "The first name of the person."
              },
              "displayName": {
                "type": "string",
                "title": "Display Name",
                "description": "The full name of the person."
              },
              "lastActivity": {
                "type": "string",
                "title": "Last Activity",
                "description": "The date and time of the person's last activity."
              },
              "lastModified": {
                "type": "string",
                "title": "Last Modified",
                "description": "The date and time the person was last modified."
              },
              "phoneNumbers": {
                "type": "array",
                "items": {
                  "type": "object",
                  "additionalProperties": true
                },
                "title": "Phone Numbers",
                "description": "An array of phone number objects with type, value, and primary flag."
              }
            },
            "description": "A single person object in the list."
          },
          "title": "Items",
          "description": "List of person objects matching the request filters."
        },
        "notFoundIds": {
          "type": "array",
          "items": {
            "type": "string"
          },
          "title": "Not Found Ids",
          "description": "List of person IDs that were not found (only present when querying by ID)."
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

## WEBEX_ROOMS_GET_ROOM_DETAILS
Tool to retrieve details for a specific room. Use when you need full metadata of a room before posting messages or updating settings.

**Input schema:**
```json
{
  "type": "object",
  "title": "RoomsGetRoomDetailsRequest",
  "required": [
    "roomId"
  ],
  "properties": {
    "roomId": {
      "type": "string",
      "title": "Room Id",
      "examples": [
        "Y2lzY29zcGFyazovL3VzL1JPT00vMTIzNDU2Nzg5MGFiY2Rl"
      ],
      "description": "Unique identifier for the room."
    }
  },
  "description": "Request model for retrieving details of a Webex room."
}
```

**Output schema:**
```json
{
  "type": "object",
  "$defs": {
    "RoomsGetRoomDetailsResponse": {
      "type": "object",
      "title": "RoomsGetRoomDetailsResponse",
      "required": [
        "id",
        "title",
        "type",
        "isLocked"
      ],
      "properties": {
        "id": {
          "type": "string",
          "title": "Id",
          "description": "Unique identifier for the room."
        },
        "type": {
          "type": "string",
          "title": "Type",
          "description": "Type of the room (e.g., 'group' or 'direct')."
        },
        "title": {
          "type": "string",
          "title": "Title",
          "description": "Title of the room."
        },
        "teamId": {
          "type": "string",
          "title": "Team Id",
          "description": "ID of the team associated with the room, if applicable."
        },
        "created": {
          "type": "string",
          "title": "Created",
          "description": "ISO 8601 timestamp when the room was created."
        },
        "ownerId": {
          "type": "string",
          "title": "Owner Id",
          "description": "ID of the organization or person that owns the room."
        },
        "isLocked": {
          "type": "boolean",
          "title": "Is Locked",
          "description": "Whether the room is locked."
        },
        "isPublic": {
          "type": "boolean",
          "title": "Is Public",
          "description": "Whether the room is public."
        },
        "creatorId": {
          "type": "string",
          "title": "Creator Id",
          "description": "ID of the person who created the room."
        },
        "isArchived": {
          "type": "boolean",
          "title": "Is Archived",
          "description": "Whether the room is archived."
        },
        "isFavorite": {
          "type": "boolean",
          "title": "Is Favorite",
          "description": "Whether the room is marked as a favorite."
        },
        "isReadOnly": {
          "type": "boolean",
          "title": "Is Read Only",
          "description": "Whether the room is read-only."
        },
        "description": {
          "type": "string",
          "title": "Description",
          "description": "Description of the room."
        },
        "lastActivity": {
          "type": "string",
          "title": "Last Activity",
          "description": "ISO 8601 timestamp of the last activity in the room."
        },
        "lastSeenActivity": {
          "type": "string",
          "title": "Last Seen Activity",
          "description": "ISO 8601 timestamp when the user last saw activity in the room."
        },
        "isAnnouncementOnly": {
          "type": "boolean",
          "title": "Is Announcement Only",
          "description": "Whether the room is announcement-only."
        }
      },
      "description": "Response model for a Webex room's details."
    }
  },
  "title": "RoomsGetRoomDetailsResponseWrapper",
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
        "title",
        "type",
        "isLocked"
      ],
      "properties": {
        "id": {
          "type": "string",
          "title": "Id",
          "description": "Unique identifier for the room."
        },
        "type": {
          "type": "string",
          "title": "Type",
          "description": "Type of the room (e.g., 'group' or 'direct')."
        },
        "title": {
          "type": "string",
          "title": "Title",
          "description": "Title of the room."
        },
        "teamId": {
          "type": "string",
          "title": "Team Id",
          "description": "ID of the team associated with the room, if applicable."
        },
        "created": {
          "type": "string",
          "title": "Created",
          "description": "ISO 8601 timestamp when the room was created."
        },
        "ownerId": {
          "type": "string",
          "title": "Owner Id",
          "description": "ID of the organization or person that owns the room."
        },
        "isLocked": {
          "type": "boolean",
          "title": "Is Locked",
          "description": "Whether the room is locked."
        },
        "isPublic": {
          "type": "boolean",
          "title": "Is Public",
          "description": "Whether the room is public."
        },
        "creatorId": {
          "type": "string",
          "title": "Creator Id",
          "description": "ID of the person who created the room."
        },
        "isArchived": {
          "type": "boolean",
          "title": "Is Archived",
          "description": "Whether the room is archived."
        },
        "isFavorite": {
          "type": "boolean",
          "title": "Is Favorite",
          "description": "Whether the room is marked as a favorite."
        },
        "isReadOnly": {
          "type": "boolean",
          "title": "Is Read Only",
          "description": "Whether the room is read-only."
        },
        "description": {
          "type": "string",
          "title": "Description",
          "description": "Description of the room."
        },
        "lastActivity": {
          "type": "string",
          "title": "Last Activity",
          "description": "ISO 8601 timestamp of the last activity in the room."
        },
        "lastSeenActivity": {
          "type": "string",
          "title": "Last Seen Activity",
          "description": "ISO 8601 timestamp when the user last saw activity in the room."
        },
        "isAnnouncementOnly": {
          "type": "boolean",
          "title": "Is Announcement Only",
          "description": "Whether the room is announcement-only."
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

## WEBEX_UPDATE_MEMBERSHIP
Updates a Webex room membership by ID to change moderator or monitor status. Use this to grant or revoke moderator privileges, or to enable/disable room monitoring for a member. Note: Assigning moderator status requires special account permissions; operations may fail with 403 Forbidden if the authenticated user lacks the necessary entitlements.

**Input schema:**
```json
{
  "type": "object",
  "title": "MessagingUpdateMembershipRequest",
  "required": [
    "membershipId"
  ],
  "properties": {
    "isMonitor": {
      "type": "boolean",
      "title": "Is Monitor",
      "description": "Set to true to enable room monitoring for the user, or false to disable monitoring. Monitors can view room content without being active members."
    },
    "isModerator": {
      "type": "boolean",
      "title": "Is Moderator",
      "description": "Set to true to make the user a room moderator, or false to remove moderator status. Note: Requires special permissions to assign/remove moderators."
    },
    "membershipId": {
      "type": "string",
      "title": "Membership Id",
      "examples": [
        "Y2lzY29zcGFyazovL3VzL01FTUJFUlNISXAvMTIzNDU2Nzg5MGFiY2Rl"
      ],
      "description": "Unique identifier of the membership to update."
    }
  },
  "description": "Request model for updating a Webex membership's moderator or monitor status."
}
```

**Output schema:**
```json
{
  "type": "object",
  "$defs": {
    "MessagingUpdateMembershipResponse": {
      "type": "object",
      "title": "MessagingUpdateMembershipResponse",
      "required": [
        "id",
        "roomId",
        "personId",
        "personEmail",
        "isModerator",
        "isMonitor",
        "created"
      ],
      "properties": {
        "id": {
          "type": "string",
          "title": "Id",
          "description": "Unique identifier for the membership."
        },
        "roomId": {
          "type": "string",
          "title": "Room Id",
          "description": "ID of the room associated with the membership."
        },
        "created": {
          "type": "string",
          "title": "Created",
          "description": "ISO 8601 timestamp when the membership was created."
        },
        "personId": {
          "type": "string",
          "title": "Person Id",
          "description": "ID of the person in the membership."
        },
        "roomType": {
          "type": "string",
          "title": "Room Type",
          "description": "Type of the room (e.g., 'group', 'direct')."
        },
        "isMonitor": {
          "type": "boolean",
          "title": "Is Monitor",
          "description": "True if the person is monitoring the room."
        },
        "isModerator": {
          "type": "boolean",
          "title": "Is Moderator",
          "description": "True if the person is a room moderator."
        },
        "personEmail": {
          "type": "string",
          "title": "Person Email",
          "description": "Email address of the person in the membership."
        },
        "personOrgId": {
          "type": "string",
          "title": "Person Org Id",
          "description": "Organization ID of the person."
        },
        "isRoomHidden": {
          "type": "boolean",
          "title": "Is Room Hidden",
          "description": "True if the room is hidden in the user's room list."
        },
        "personDisplayName": {
          "type": "string",
          "title": "Person Display Name",
          "description": "Display name of the person."
        }
      },
      "description": "Response schema for the updated membership."
    }
  },
  "title": "MessagingUpdateMembershipResponseWrapper",
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
        "roomId",
        "personId",
        "personEmail",
        "isModerator",
        "isMonitor",
        "created"
      ],
      "properties": {
        "id": {
          "type": "string",
          "title": "Id",
          "description": "Unique identifier for the membership."
        },
        "roomId": {
          "type": "string",
          "title": "Room Id",
          "description": "ID of the room associated with the membership."
        },
        "created": {
          "type": "string",
          "title": "Created",
          "description": "ISO 8601 timestamp when the membership was created."
        },
        "personId": {
          "type": "string",
          "title": "Person Id",
          "description": "ID of the person in the membership."
        },
        "roomType": {
          "type": "string",
          "title": "Room Type",
          "description": "Type of the room (e.g., 'group', 'direct')."
        },
        "isMonitor": {
          "type": "boolean",
          "title": "Is Monitor",
          "description": "True if the person is monitoring the room."
        },
        "isModerator": {
          "type": "boolean",
          "title": "Is Moderator",
          "description": "True if the person is a room moderator."
        },
        "personEmail": {
          "type": "string",
          "title": "Person Email",
          "description": "Email address of the person in the membership."
        },
        "personOrgId": {
          "type": "string",
          "title": "Person Org Id",
          "description": "Organization ID of the person."
        },
        "isRoomHidden": {
          "type": "boolean",
          "title": "Is Room Hidden",
          "description": "True if the room is hidden in the user's room list."
        },
        "personDisplayName": {
          "type": "string",
          "title": "Person Display Name",
          "description": "Display name of the person."
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

## WEBEX_UPDATE_ROOM
Update a room's title, lock status, or team association. The title parameter is always required by the Webex API - if you're only updating isLocked or teamId, you must still provide the current room title.

**Input schema:**
```json
{
  "type": "object",
  "title": "MessagingUpdateRoomRequest",
  "required": [
    "roomId",
    "title"
  ],
  "properties": {
    "title": {
      "type": "string",
      "title": "Title",
      "examples": [
        "Project Discussion Room"
      ],
      "description": "User-friendly name for the room. Required by the Webex API even if you're only updating other fields - pass the current title if not changing it."
    },
    "roomId": {
      "type": "string",
      "title": "Room Id",
      "examples": [
        "Y2lzY29zcGFyazovL3VzL1JPT00vMTIzNDU2Nzg5MGFiY2Rl"
      ],
      "description": "Unique identifier of the room to update."
    },
    "teamId": {
      "type": "string",
      "title": "Team Id",
      "examples": [
        "Y2lzY29zcGFyazovL3VzL1RFQU0vMTIzNDU2Nzg5MGFiY2Rl"
      ],
      "description": "Team ID to associate the room with. Use to move the room under a different team."
    },
    "isLocked": {
      "type": "boolean",
      "title": "Is Locked",
      "description": "Lock the room to prevent new users from joining."
    }
  },
  "description": "Request model for updating a Webex room's details."
}
```

**Output schema:**
```json
{
  "type": "object",
  "$defs": {
    "MessagingUpdateRoomResponse": {
      "type": "object",
      "title": "MessagingUpdateRoomResponse",
      "required": [
        "id",
        "title",
        "type"
      ],
      "properties": {
        "id": {
          "type": "string",
          "title": "Id",
          "description": "Unique identifier for the room."
        },
        "type": {
          "type": "string",
          "title": "Type",
          "description": "Type of the room (e.g., 'group' or 'direct')."
        },
        "title": {
          "type": "string",
          "title": "Title",
          "description": "Title of the room."
        },
        "teamId": {
          "type": "string",
          "title": "Team Id",
          "description": "ID of the team associated with the room, if applicable."
        },
        "created": {
          "type": "string",
          "title": "Created",
          "description": "ISO 8601 timestamp when the room was created."
        },
        "isHidden": {
          "type": "boolean",
          "title": "Is Hidden",
          "description": "Whether the room is hidden."
        },
        "isLocked": {
          "type": "boolean",
          "title": "Is Locked",
          "description": "Whether the room is locked."
        },
        "isPublic": {
          "type": "boolean",
          "title": "Is Public",
          "description": "Whether the room is public."
        },
        "creatorId": {
          "type": "string",
          "title": "Creator Id",
          "description": "ID of the person who created the room."
        },
        "isArchived": {
          "type": "boolean",
          "title": "Is Archived",
          "description": "Whether the room is archived."
        },
        "isFavorite": {
          "type": "boolean",
          "title": "Is Favorite",
          "description": "Whether the room is marked as a favorite."
        },
        "isReadOnly": {
          "type": "boolean",
          "title": "Is Read Only",
          "description": "Whether the room is read-only."
        },
        "meetingUrl": {
          "type": "string",
          "title": "Meeting Url",
          "description": "Meeting URL of the room."
        },
        "sipAddress": {
          "type": "string",
          "title": "Sip Address",
          "description": "SIP address for the room."
        },
        "isModerated": {
          "type": "boolean",
          "title": "Is Moderated",
          "description": "Whether the room is moderated."
        },
        "lastActivity": {
          "type": "string",
          "title": "Last Activity",
          "description": "ISO 8601 timestamp of the last activity in the room."
        },
        "lastSeenActivity": {
          "type": "string",
          "title": "Last Seen Activity",
          "description": "ISO 8601 timestamp when the user last saw activity in the room."
        },
        "isAnnouncementOnly": {
          "type": "boolean",
          "title": "Is Announcement Only",
          "description": "Whether the room is announcement-only."
        }
      },
      "description": "Response model for the updated room."
    }
  },
  "title": "MessagingUpdateRoomResponseWrapper",
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
        "title",
        "type"
      ],
      "properties": {
        "id": {
          "type": "string",
          "title": "Id",
          "description": "Unique identifier for the room."
        },
        "type": {
          "type": "string",
          "title": "Type",
          "description": "Type of the room (e.g., 'group' or 'direct')."
        },
        "title": {
          "type": "string",
          "title": "Title",
          "description": "Title of the room."
        },
        "teamId": {
          "type": "string",
          "title": "Team Id",
          "description": "ID of the team associated with the room, if applicable."
        },
        "created": {
          "type": "string",
          "title": "Created",
          "description": "ISO 8601 timestamp when the room was created."
        },
        "isHidden": {
          "type": "boolean",
          "title": "Is Hidden",
          "description": "Whether the room is hidden."
        },
        "isLocked": {
          "type": "boolean",
          "title": "Is Locked",
          "description": "Whether the room is locked."
        },
        "isPublic": {
          "type": "boolean",
          "title": "Is Public",
          "description": "Whether the room is public."
        },
        "creatorId": {
          "type": "string",
          "title": "Creator Id",
          "description": "ID of the person who created the room."
        },
        "isArchived": {
          "type": "boolean",
          "title": "Is Archived",
          "description": "Whether the room is archived."
        },
        "isFavorite": {
          "type": "boolean",
          "title": "Is Favorite",
          "description": "Whether the room is marked as a favorite."
        },
        "isReadOnly": {
          "type": "boolean",
          "title": "Is Read Only",
          "description": "Whether the room is read-only."
        },
        "meetingUrl": {
          "type": "string",
          "title": "Meeting Url",
          "description": "Meeting URL of the room."
        },
        "sipAddress": {
          "type": "string",
          "title": "Sip Address",
          "description": "SIP address for the room."
        },
        "isModerated": {
          "type": "boolean",
          "title": "Is Moderated",
          "description": "Whether the room is moderated."
        },
        "lastActivity": {
          "type": "string",
          "title": "Last Activity",
          "description": "ISO 8601 timestamp of the last activity in the room."
        },
        "lastSeenActivity": {
          "type": "string",
          "title": "Last Seen Activity",
          "description": "ISO 8601 timestamp when the user last saw activity in the room."
        },
        "isAnnouncementOnly": {
          "type": "boolean",
          "title": "Is Announcement Only",
          "description": "Whether the room is announcement-only."
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

## WEBEX_UPDATE_TEAM
Tool to update a team's name by teamId. Use when you need to rename a Webex team. Example: "Change team 12345 name to 'Project X Team'".

**Input schema:**
```json
{
  "type": "object",
  "title": "MessagingUpdateTeamRequest",
  "required": [
    "teamId",
    "name"
  ],
  "properties": {
    "name": {
      "type": "string",
      "title": "Name",
      "examples": [
        "Engineering Team"
      ],
      "description": "New user-friendly name for the team."
    },
    "teamId": {
      "type": "string",
      "title": "Team Id",
      "examples": [
        "Y2lzY29zcGFyazovL3VzL1RFQU0vMTIzNDU2Nzg5MGFiY2Rl"
      ],
      "description": "Unique identifier of the team to update."
    }
  },
  "description": "Request model for updating a Webex team's details."
}
```

**Output schema:**
```json
{
  "type": "object",
  "$defs": {
    "MessagingUpdateTeamResponse": {
      "type": "object",
      "title": "MessagingUpdateTeamResponse",
      "required": [
        "id",
        "name",
        "created"
      ],
      "properties": {
        "id": {
          "type": "string",
          "title": "Id",
          "description": "Unique identifier for the team."
        },
        "name": {
          "type": "string",
          "title": "Name",
          "description": "Name of the team."
        },
        "created": {
          "type": "string",
          "title": "Created",
          "description": "ISO 8601 timestamp when the team was created."
        },
        "description": {
          "type": "string",
          "title": "Description",
          "description": "Description of the team."
        }
      },
      "description": "Response model for the updated Webex team."
    }
  },
  "title": "MessagingUpdateTeamResponseWrapper",
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
        "created"
      ],
      "properties": {
        "id": {
          "type": "string",
          "title": "Id",
          "description": "Unique identifier for the team."
        },
        "name": {
          "type": "string",
          "title": "Name",
          "description": "Name of the team."
        },
        "created": {
          "type": "string",
          "title": "Created",
          "description": "ISO 8601 timestamp when the team was created."
        },
        "description": {
          "type": "string",
          "title": "Description",
          "description": "Description of the team."
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

## WEBEX_WEBHOOKS_CREATE_WEBHOOK
Creates a Webex webhook to receive real-time event notifications via HTTP POST requests to your specified URL. Use this tool to register for automated notifications when resources (messages, rooms, memberships, meetings, etc.) are created, updated, deleted, or undergo other state changes. Webhooks enable event-driven integrations without polling. Important: The webhook will be automatically disabled if your target URL fails to respond with HTTP 2xx status codes 100 times within five minutes. Requires 'read' scope for the monitored resource type.

**Input schema:**
```json
{
  "type": "object",
  "title": "WebhooksCreateWebhookRequest",
  "required": [
    "name",
    "targetUrl",
    "resource",
    "event"
  ],
  "properties": {
    "name": {
      "type": "string",
      "title": "Name",
      "examples": [
        "MyWebhook"
      ],
      "description": "User-friendly name for the webhook."
    },
    "appId": {
      "type": "string",
      "title": "App Id",
      "description": "(Internal) Application ID associated with this webhook."
    },
    "event": {
      "enum": [
        "created",
        "updated",
        "deleted",
        "started",
        "ended",
        "joined",
        "left",
        "migrated",
        "authorized",
        "deauthorized",
        "statusChanged"
      ],
      "type": "string",
      "title": "Event",
      "description": "The event type that triggers the webhook. Supported events: created (object created), updated (object updated), deleted (object deleted), started (meeting started), ended (meeting ended), joined (participant joined), left (participant left), migrated (resource migrated), authorized (authorization granted), deauthorized (authorization revoked), statusChanged (status changed)."
    },
    "filter": {
      "type": "string",
      "title": "Filter",
      "examples": [
        "roomId=Y2lzY29zcGFyazovL3VzL1JPT00vMTIz",
        "hostEmail=user@example.com"
      ],
      "description": "Optional filter expression to scope webhook notifications to specific resources. For example, use 'roomId=<id>' to monitor a specific room, or 'hostEmail=<email>' for meetings hosted by a specific user. When using 'ownedBy=org' with filters like hostEmail, hostUserId, ownerEmail, or ownerId, this filter is required."
    },
    "secret": {
      "type": "string",
      "title": "Secret",
      "examples": [
        "mySuperSecretKey123"
      ],
      "description": "Optional secret used to generate an HMAC payload signature."
    },
    "ownedBy": {
      "enum": [
        "creator",
        "org"
      ],
      "type": "string",
      "title": "Owned By",
      "description": "Specifies webhook ownership level. Use 'creator' (default) for personal webhooks that deliver events only to the creating user, or 'org' for organization/admin-level webhooks that deliver events across the entire organization. Org-level webhooks are supported for resources like meetings, recordings, convergedRecordings, meetingParticipants, meetingTranscripts, rooms, and messaging."
    },
    "resource": {
      "enum": [
        "messages",
        "memberships",
        "rooms",
        "teams",
        "team_memberships",
        "meetings",
        "meetingRecordings",
        "meetingTranscripts",
        "attachmentActions",
        "dataSources",
        "recordings",
        "convergedRecordings",
        "meetingParticipants",
        "telephony_calls",
        "telephony_conference",
        "telephony_mwi",
        "uc_counters",
        "serviceApp",
        "adminBatchJobs"
      ],
      "type": "string",
      "title": "Resource",
      "description": "The Webex resource type to monitor for events. Supported resources include: messages, memberships, rooms, teams, team_memberships, meetings, recordings, convergedRecordings, meetingParticipants, meetingRecordings, meetingTranscripts, attachmentActions, dataSources, telephony_calls, telephony_conference, telephony_mwi, uc_counters, serviceApp, adminBatchJobs. Creating a webhook requires 'read' scope on the resource being monitored."
    },
    "targetUrl": {
      "type": "string",
      "title": "Target Url",
      "description": "The URL that will receive POST event notifications."
    }
  },
  "description": "Request parameters for creating a Webex webhook."
}
```

**Output schema:**
```json
{
  "type": "object",
  "$defs": {
    "WebhooksCreateWebhookResponse": {
      "type": "object",
      "title": "WebhooksCreateWebhookResponse",
      "required": [
        "id",
        "name",
        "targetUrl",
        "resource",
        "event",
        "status",
        "created",
        "createdBy"
      ],
      "properties": {
        "id": {
          "type": "string",
          "title": "Id",
          "description": "Unique identifier for the webhook."
        },
        "name": {
          "type": "string",
          "title": "Name",
          "description": "Name of the webhook."
        },
        "appId": {
          "type": "string",
          "title": "App Id",
          "description": "Application ID associated with the webhook."
        },
        "event": {
          "type": "string",
          "title": "Event",
          "description": "Event type subscribed by the webhook."
        },
        "orgId": {
          "type": "string",
          "title": "Org Id",
          "description": "Organization ID for the webhook."
        },
        "filter": {
          "type": "string",
          "title": "Filter",
          "description": "Filter expression applied for the webhook."
        },
        "secret": {
          "type": "string",
          "title": "Secret",
          "description": "Secret for payload signature."
        },
        "status": {
          "type": "string",
          "title": "Status",
          "description": "Status of the webhook (e.g., 'active')."
        },
        "created": {
          "type": "string",
          "title": "Created",
          "description": "ISO 8601 timestamp when the webhook was created."
        },
        "ownedBy": {
          "type": "string",
          "title": "Owned By",
          "description": "Ownership of the webhook."
        },
        "resource": {
          "type": "string",
          "title": "Resource",
          "description": "Resource type monitored by the webhook."
        },
        "createdBy": {
          "type": "string",
          "title": "Created By",
          "description": "User ID who created the webhook."
        },
        "targetUrl": {
          "type": "string",
          "title": "Target Url",
          "description": "The target URL for event notifications."
        }
      },
      "description": "Response schema for a created Webex webhook."
    }
  },
  "title": "WebhooksCreateWebhookResponseWrapper",
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
        "targetUrl",
        "resource",
        "event",
        "status",
        "created",
        "createdBy"
      ],
      "properties": {
        "id": {
          "type": "string",
          "title": "Id",
          "description": "Unique identifier for the webhook."
        },
        "name": {
          "type": "string",
          "title": "Name",
          "description": "Name of the webhook."
        },
        "appId": {
          "type": "string",
          "title": "App Id",
          "description": "Application ID associated with the webhook."
        },
        "event": {
          "type": "string",
          "title": "Event",
          "description": "Event type subscribed by the webhook."
        },
        "orgId": {
          "type": "string",
          "title": "Org Id",
          "description": "Organization ID for the webhook."
        },
        "filter": {
          "type": "string",
          "title": "Filter",
          "description": "Filter expression applied for the webhook."
        },
        "secret": {
          "type": "string",
          "title": "Secret",
          "description": "Secret for payload signature."
        },
        "status": {
          "type": "string",
          "title": "Status",
          "description": "Status of the webhook (e.g., 'active')."
        },
        "created": {
          "type": "string",
          "title": "Created",
          "description": "ISO 8601 timestamp when the webhook was created."
        },
        "ownedBy": {
          "type": "string",
          "title": "Owned By",
          "description": "Ownership of the webhook."
        },
        "resource": {
          "type": "string",
          "title": "Resource",
          "description": "Resource type monitored by the webhook."
        },
        "createdBy": {
          "type": "string",
          "title": "Created By",
          "description": "User ID who created the webhook."
        },
        "targetUrl": {
          "type": "string",
          "title": "Target Url",
          "description": "The target URL for event notifications."
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

## WEBEX_WEBHOOKS_DELETE_WEBHOOK
Tool to delete a specific webhook. Use when you need to remove an existing webhook by its ID after confirming the identifier.

**Input schema:**
```json
{
  "type": "object",
  "title": "WebhooksDeleteWebhookRequest",
  "required": [
    "webhookId"
  ],
  "properties": {
    "webhookId": {
      "type": "string",
      "title": "Webhook Id",
      "examples": [
        "5944d1e4-1101-4d33-8b47-f0f285d4882b"
      ],
      "description": "Unique identifier for the webhook to delete"
    }
  },
  "description": "Request schema for WebhooksDeleteWebhook."
}
```

**Output schema:**
```json
{
  "type": "object",
  "$defs": {
    "WebhooksDeleteWebhookResponse": {
      "type": "object",
      "title": "WebhooksDeleteWebhookResponse",
      "required": [
        "success"
      ],
      "properties": {
        "success": {
          "type": "boolean",
          "title": "Success",
          "description": "Indicates if the webhook was deleted successfully"
        }
      },
      "description": "Response schema for WebhooksDeleteWebhook."
    }
  },
  "title": "WebhooksDeleteWebhookResponseWrapper",
  "required": [
    "data",
    "successful"
  ],
  "properties": {
    "data": {
      "type": "object",
      "title": "Data",
      "required": [
        "success"
      ],
      "properties": {
        "success": {
          "type": "boolean",
          "title": "Success",
          "description": "Indicates if the webhook was deleted successfully"
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

## WEBEX_WEBHOOKS_GET_WEBHOOK
Retrieves detailed information about a specific Webex webhook by its ID. Use this action to: - Inspect a webhook's configuration (target URL, resource, event type, filters) - Verify webhook status (active/inactive) - Check webhook ownership and security settings (secret, ownedBy) - Get webhook metadata (creation date, creator, organization) The webhook must exist and be accessible with your current credentials. Returns 404 error if the webhook ID is invalid or you don't have permission to view it.

**Input schema:**
```json
{
  "type": "object",
  "title": "WebhooksGetWebhookRequest",
  "required": [
    "webhookId"
  ],
  "properties": {
    "webhookId": {
      "type": "string",
      "title": "Webhook Id",
      "examples": [
        "Y2lzY29zcGFyazovL3VybjpURUFNOnVzLXdlc3QtMl9yL1dFQkhPT0svNGMxODc4ODAtMTNmZC00OTQ3LWE4ZTctNzc1ZWJhNDdmYzI1"
      ],
      "description": "The unique identifier of the webhook to retrieve. This is the 'id' field returned when creating or listing webhooks. Typically a long base64-encoded string starting with 'Y2lzY29zcGFyazovL'."
    }
  },
  "description": "Request model for retrieving details for a specific webhook by ID."
}
```

**Output schema:**
```json
{
  "type": "object",
  "$defs": {
    "WebhooksGetWebhookResponse": {
      "type": "object",
      "title": "WebhooksGetWebhookResponse",
      "properties": {
        "id": {
          "type": "string",
          "title": "Id",
          "description": "The unique identifier for the webhook."
        },
        "name": {
          "type": "string",
          "title": "Name",
          "description": "A user-friendly name for the webhook."
        },
        "appId": {
          "type": "string",
          "title": "App Id",
          "description": "The application ID associated with the webhook."
        },
        "event": {
          "type": "string",
          "title": "Event",
          "description": "The event type for the webhook (e.g., 'created', 'updated', 'deleted')."
        },
        "orgId": {
          "type": "string",
          "title": "Org Id",
          "description": "The organization ID associated with the webhook."
        },
        "filter": {
          "type": "string",
          "title": "Filter",
          "description": "Optional filter that defines the webhook scope (e.g., 'roomId=...')."
        },
        "secret": {
          "type": "string",
          "title": "Secret",
          "description": "Optional secret used to generate payload signatures for webhook security."
        },
        "status": {
          "type": "string",
          "title": "Status",
          "description": "The status of the webhook (e.g., 'active', 'inactive')."
        },
        "created": {
          "type": "string",
          "title": "Created",
          "description": "The date and time the webhook was created in ISO 8601 format."
        },
        "ownedBy": {
          "type": "string",
          "title": "Owned By",
          "description": "Ownership of the webhook: 'creator' for user-owned or 'org' for organization-wide."
        },
        "resource": {
          "type": "string",
          "title": "Resource",
          "description": "The resource type for the webhook (e.g., 'messages', 'rooms', 'memberships')."
        },
        "createdBy": {
          "type": "string",
          "title": "Created By",
          "description": "The person ID of the user who created the webhook."
        },
        "targetUrl": {
          "type": "string",
          "title": "Target Url",
          "description": "The URL that receives POST requests for each event."
        }
      },
      "description": "Response model for details of a Webex webhook."
    }
  },
  "title": "WebhooksGetWebhookResponseWrapper",
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
          "description": "The unique identifier for the webhook."
        },
        "name": {
          "type": "string",
          "title": "Name",
          "description": "A user-friendly name for the webhook."
        },
        "appId": {
          "type": "string",
          "title": "App Id",
          "description": "The application ID associated with the webhook."
        },
        "event": {
          "type": "string",
          "title": "Event",
          "description": "The event type for the webhook (e.g., 'created', 'updated', 'deleted')."
        },
        "orgId": {
          "type": "string",
          "title": "Org Id",
          "description": "The organization ID associated with the webhook."
        },
        "filter": {
          "type": "string",
          "title": "Filter",
          "description": "Optional filter that defines the webhook scope (e.g., 'roomId=...')."
        },
        "secret": {
          "type": "string",
          "title": "Secret",
          "description": "Optional secret used to generate payload signatures for webhook security."
        },
        "status": {
          "type": "string",
          "title": "Status",
          "description": "The status of the webhook (e.g., 'active', 'inactive')."
        },
        "created": {
          "type": "string",
          "title": "Created",
          "description": "The date and time the webhook was created in ISO 8601 format."
        },
        "ownedBy": {
          "type": "string",
          "title": "Owned By",
          "description": "Ownership of the webhook: 'creator' for user-owned or 'org' for organization-wide."
        },
        "resource": {
          "type": "string",
          "title": "Resource",
          "description": "The resource type for the webhook (e.g., 'messages', 'rooms', 'memberships')."
        },
        "createdBy": {
          "type": "string",
          "title": "Created By",
          "description": "The person ID of the user who created the webhook."
        },
        "targetUrl": {
          "type": "string",
          "title": "Target Url",
          "description": "The URL that receives POST requests for each event."
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
