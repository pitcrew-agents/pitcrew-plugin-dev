# gmail

## GMAIL_ADD_LABEL_TO_EMAIL
Adds and/or removes specified Gmail labels for a message; ensure `message_id` and all `label_ids` are valid (use 'listLabels' for custom label IDs).

**Input schema:**
```json
{
  "type": "object",
  "title": "AddLabelToEmailRequest",
  "required": [
    "message_id"
  ],
  "properties": {
    "user_id": {
      "type": "string",
      "title": "User Id",
      "default": "me",
      "examples": [
        "me",
        "user@example.com"
      ],
      "description": "User's email address or 'me' for the authenticated user.",
      "human_parameter_name": "User ID",
      "human_parameter_description": "Provide the email address or identifier of the user whose mailbox you are accessing. Use 'me' if you want to access your own mailbox."
    },
    "message_id": {
      "type": "string",
      "title": "Message Id",
      "pattern": "^[0-9a-fA-F]+$",
      "examples": [
        "1a2b3c4d5e6f7890",
        "abcd1234efab5678"
      ],
      "description": "Immutable ID of the message to modify. Gmail message IDs are 15-16 character hexadecimal strings (e.g., '1a2b3c4d5e6f7890'). IMPORTANT: Do NOT use UUIDs (32-character strings like '093ca4662b214d5eba8f4ceeaad63433'), thread IDs, or internal system IDs - these will cause 'Invalid id value' errors. Obtain valid message IDs from: (1) 'GMAIL_FETCH_EMAILS' response 'messageId' field, (2) 'GMAIL_FETCH_MESSAGE_BY_THREAD_ID' response, or (3) 'GMAIL_LIST_THREADS' and then fetching thread messages.",
      "human_parameter_name": "Message ID",
      "human_parameter_description": "Enter the Gmail message ID (15-16 hex characters like '1a2b3c4d5e6f7890'). Get this from GMAIL_FETCH_EMAILS 'messageId' field. Do NOT use UUIDs or 32-character strings."
    },
    "add_label_ids": {
      "type": "array",
      "items": {
        "type": "string"
      },
      "title": "Add Label Ids",
      "default": [],
      "examples": [
        "STARRED",
        "IMPORTANT",
        "CATEGORY_UPDATES",
        "Label_1"
      ],
      "description": "IMPORTANT: Label IDs are NOT the same as label names shown in Gmail UI. MODIFIABLE SYSTEM LABELS (use these exact IDs): INBOX, SPAM, TRASH, UNREAD, STARRED, IMPORTANT, CATEGORY_PERSONAL, CATEGORY_SOCIAL, CATEGORY_PROMOTIONS, CATEGORY_UPDATES, CATEGORY_FORUMS. Note: 'UPDATES', 'SOCIAL', 'PROMOTIONS', 'FORUMS', 'PERSONAL' are INVALID - you must use the full CATEGORY_ prefix (e.g., 'CATEGORY_UPDATES' not 'UPDATES'). CUSTOM LABELS: You MUST call 'listLabels' action first to get the label ID (format: 'Label_<number>', e.g., 'Label_1', 'Label_123'). Do NOT use the label name displayed in Gmail UI - the API requires the ID, not the name. Example: if listLabels returns {\"id\": \"Label_5\", \"name\": \"Work Projects\"}, use 'Label_5' (NOT 'Work Projects'). IMMUTABLE LABELS (cannot be added or removed): SENT, DRAFT, and CHAT are system labels managed by Gmail and cannot be modified via the API. Attempting to use these will return 'Invalid label' errors. A label cannot appear in both add_label_ids and remove_label_ids. At least one of 'add_label_ids' or 'remove_label_ids' must be non-empty.",
      "human_parameter_name": "Label IDs to add",
      "human_parameter_description": "List the IDs of labels to add. Use exact system label IDs (e.g., 'CATEGORY_UPDATES' not 'UPDATES') or custom label IDs from listLabels (e.g., 'Label_1' not the label name). Note: SENT, DRAFT, and CHAT cannot be modified."
    },
    "remove_label_ids": {
      "type": "array",
      "items": {
        "type": "string"
      },
      "title": "Remove Label Ids",
      "default": [],
      "examples": [
        "UNREAD",
        "INBOX",
        "CATEGORY_UPDATES",
        "Label_1"
      ],
      "description": "IMPORTANT: Label IDs are NOT the same as label names shown in Gmail UI. MODIFIABLE SYSTEM LABELS (use these exact IDs): INBOX, SPAM, TRASH, UNREAD, STARRED, IMPORTANT, CATEGORY_PERSONAL, CATEGORY_SOCIAL, CATEGORY_PROMOTIONS, CATEGORY_UPDATES, CATEGORY_FORUMS. Note: 'UPDATES', 'SOCIAL', 'PROMOTIONS', 'FORUMS', 'PERSONAL' are INVALID - you must use the full CATEGORY_ prefix (e.g., 'CATEGORY_UPDATES' not 'UPDATES'). CUSTOM LABELS: You MUST call 'listLabels' action first to get the label ID (format: 'Label_<number>', e.g., 'Label_1', 'Label_123'). Do NOT use the label name displayed in Gmail UI - the API requires the ID, not the name. IMMUTABLE LABELS (cannot be added or removed): SENT, DRAFT, and CHAT are system labels managed by Gmail and cannot be modified via the API. Attempting to use these will return 'Invalid label' errors. Common operations: to mark as read, REMOVE 'UNREAD'; to archive, REMOVE 'INBOX'. A label cannot appear in both add_label_ids and remove_label_ids. At least one of 'add_label_ids' or 'remove_label_ids' must be non-empty.",
      "human_parameter_name": "Label IDs to remove",
      "human_parameter_description": "List the IDs of labels to remove. Use exact system label IDs (e.g., 'CATEGORY_UPDATES' not 'UPDATES') or custom label IDs from listLabels (e.g., 'Label_1' not the label name). To mark as read, remove 'UNREAD'. To archive, remove 'INBOX'. Note: SENT, DRAFT, and CHAT cannot be modified."
    }
  }
}
```

**Output schema:**
```json
{
  "type": "object",
  "$defs": {
    "GmailMessageResponse": {
      "type": "object",
      "title": "GmailMessageResponse",
      "properties": {
        "id": {
          "type": "string",
          "title": "Id",
          "description": "The immutable ID of the sent message."
        },
        "raw": {
          "type": "string",
          "title": "Raw",
          "description": "The entire email message in RFC 2822 format, base64url-encoded."
        },
        "payload": {
          "type": "object",
          "title": "Payload",
          "description": "The parsed email structure, including headers and body parts.",
          "additionalProperties": true
        },
        "snippet": {
          "type": "string",
          "title": "Snippet",
          "description": "A short extract of the message text."
        },
        "labelIds": {
          "type": "array",
          "items": {
            "type": "string"
          },
          "title": "Label Ids",
          "description": "List of IDs of labels applied to this message."
        },
        "threadId": {
          "type": "string",
          "title": "Thread Id",
          "description": "The ID of the thread the message belongs to."
        },
        "historyId": {
          "type": "string",
          "title": "History Id",
          "description": "The ID of the last history record that modified this message."
        },
        "display_url": {
          "type": "string",
          "title": "Display Url",
          "description": "Web UI link for this resource - set by each action's execute()."
        },
        "internalDate": {
          "type": "string",
          "title": "Internal Date",
          "description": "The internal timestamp of the message in milliseconds since epoch."
        },
        "sizeEstimate": {
          "type": "integer",
          "title": "Size Estimate",
          "description": "Estimated size of the message in bytes."
        }
      },
      "description": "Standard Gmail message response returned by Gmail API for sent messages.\nUsed by actions like send_email and send_draft."
    }
  },
  "title": "GmailMessageResponseWrapper",
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
          "description": "The immutable ID of the sent message."
        },
        "raw": {
          "type": "string",
          "title": "Raw",
          "description": "The entire email message in RFC 2822 format, base64url-encoded."
        },
        "payload": {
          "type": "object",
          "title": "Payload",
          "description": "The parsed email structure, including headers and body parts.",
          "additionalProperties": true
        },
        "snippet": {
          "type": "string",
          "title": "Snippet",
          "description": "A short extract of the message text."
        },
        "labelIds": {
          "type": "array",
          "items": {
            "type": "string"
          },
          "title": "Label Ids",
          "description": "List of IDs of labels applied to this message."
        },
        "threadId": {
          "type": "string",
          "title": "Thread Id",
          "description": "The ID of the thread the message belongs to."
        },
        "historyId": {
          "type": "string",
          "title": "History Id",
          "description": "The ID of the last history record that modified this message."
        },
        "display_url": {
          "type": "string",
          "title": "Display Url",
          "description": "Web UI link for this resource - set by each action's execute()."
        },
        "internalDate": {
          "type": "string",
          "title": "Internal Date",
          "description": "The internal timestamp of the message in milliseconds since epoch."
        },
        "sizeEstimate": {
          "type": "integer",
          "title": "Size Estimate",
          "description": "Estimated size of the message in bytes."
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

## GMAIL_BATCH_DELETE_MESSAGES
Tool to permanently delete multiple Gmail messages in bulk, bypassing Trash with no recovery possible. Use when you need to efficiently remove large numbers of emails (e.g., retention enforcement, mailbox hygiene). Use GMAIL_MOVE_TO_TRASH instead when reversibility may be needed. Always obtain explicit user confirmation and verify a sample of message IDs before executing. High-volume calls may trigger 429 rateLimitExceeded or 403 userRateLimitExceeded errors; apply exponential backoff.

**Input schema:**
```json
{
  "type": "object",
  "title": "BatchDeleteMessagesRequest",
  "required": [
    "messageIds"
  ],
  "properties": {
    "userId": {
      "type": "string",
      "title": "User Id",
      "default": "me",
      "examples": [
        "me",
        "user@example.com"
      ],
      "description": "User's email address or 'me' for the authenticated user.",
      "human_parameter_name": "User ID",
      "human_parameter_description": "The email address of the user whose messages you want to delete. Use 'me' to apply changes to your own account."
    },
    "messageIds": {
      "type": "array",
      "items": {
        "type": "string"
      },
      "title": "Message Ids",
      "examples": [
        [
          "18c5f5d1a2b3c4d5",
          "18c5f5d1a2b3c4d6"
        ]
      ],
      "minItems": 1,
      "description": "List of Gmail message IDs to delete. Each ID must be a 15-16 character hexadecimal string (e.g., '18c5f5d1a2b3c4d5'). Obtain IDs from actions like GMAIL_FETCH_EMAILS or GMAIL_LIST_THREADS - do not use human-readable descriptions.",
      "human_parameter_name": "Message IDs",
      "human_parameter_description": "The unique message IDs for the emails you wish to delete. Each ID is a 15-16 character hexadecimal string (like '18c5f5d1a2b3c4d5'). Get these IDs by first fetching or listing messages."
    }
  },
  "description": "Request model for bulk deletion of Gmail messages by ID."
}
```

**Output schema:**
```json
{
  "type": "object",
  "$defs": {
    "BatchDeleteMessagesResponse": {
      "type": "object",
      "title": "BatchDeleteMessagesResponse",
      "required": [
        "success",
        "message"
      ],
      "properties": {
        "message": {
          "type": "string",
          "title": "Message",
          "description": "Details about the deletion operation"
        },
        "success": {
          "type": "boolean",
          "title": "Success",
          "description": "Whether the bulk deletion was successful"
        },
        "display_url": {
          "type": "string",
          "title": "Display Url",
          "description": "Web UI link for this resource - clickable URL pointing to the Gmail web interface"
        }
      },
      "description": "Response schema for batch delete Gmail messages."
    }
  },
  "title": "BatchDeleteMessagesResponseWrapper",
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
          "description": "Details about the deletion operation"
        },
        "success": {
          "type": "boolean",
          "title": "Success",
          "description": "Whether the bulk deletion was successful"
        },
        "display_url": {
          "type": "string",
          "title": "Display Url",
          "description": "Web UI link for this resource - clickable URL pointing to the Gmail web interface"
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

## GMAIL_BATCH_MODIFY_MESSAGES
Modify labels on multiple Gmail messages in one efficient API call. Supports up to 1,000 messages per request for bulk operations like archiving, marking as read/unread, or applying custom labels. High-volume calls may return 429 rateLimitExceeded or 403 userRateLimitExceeded; apply exponential backoff.

**Input schema:**
```json
{
  "type": "object",
  "title": "BatchModifyMessagesRequest",
  "required": [
    "messageIds"
  ],
  "properties": {
    "userId": {
      "type": "string",
      "title": "User Id",
      "default": "me",
      "examples": [
        "me",
        "user@example.com"
      ],
      "description": "User's email address or 'me' for the authenticated user.",
      "human_parameter_name": "User ID",
      "human_parameter_description": "Indicate which user's mailbox you are trying to modify. Use 'me' for your own mailbox or provide a specific email address."
    },
    "messageIds": {
      "type": "array",
      "items": {
        "type": "string"
      },
      "title": "Message Ids",
      "examples": [
        [
          "18c5f5d1a2b3c4d5",
          "18c5f5d1a2b3c4d6"
        ],
        [
          "msg_id_1",
          "msg_id_2",
          "msg_id_3"
        ]
      ],
      "maxItems": 1000,
      "minItems": 1,
      "description": "List of message IDs to modify. Maximum 1,000 message IDs per request. Get message IDs from GMAIL_FETCH_EMAILS or GMAIL_LIST_THREADS actions. Accepts 'messageIds', 'ids', or 'message_ids' as the parameter name.",
      "human_parameter_name": "Message IDs",
      "human_parameter_description": "Provide the unique IDs of the messages you want to modify. You can collect these IDs from previous email fetch or list actions."
    },
    "addLabelIds": {
      "type": "array",
      "items": {
        "type": "string"
      },
      "title": "Add Label Ids",
      "examples": [
        [
          "INBOX",
          "STARRED"
        ],
        [
          "Label_1",
          "Label_25"
        ],
        [
          "IMPORTANT",
          "Label_10"
        ]
      ],
      "description": "List of label IDs to add to the messages. IMPORTANT: Use label IDs, NOT label display names. System labels use their name as ID: INBOX, STARRED, IMPORTANT, SENT, DRAFT, SPAM, TRASH, UNREAD, CATEGORY_PERSONAL, CATEGORY_SOCIAL, CATEGORY_PROMOTIONS, CATEGORY_UPDATES, CATEGORY_FORUMS. Custom labels MUST use their ID (format: 'Label_XXX', e.g., 'Label_1', 'Label_25'), NOT the display name (e.g., do NOT use 'Work' or 'Projects'). Call GMAIL_LIST_LABELS first to get the 'id' field for custom labels. At least one of add_label_ids or remove_label_ids must be provided. CONSTRAINT: Label IDs must NOT overlap with remove_label_ids - cannot add and remove the same label.",
      "human_parameter_name": "Label IDs to add",
      "human_parameter_description": "Specify the label IDs you want to add. For system labels use INBOX, STARRED, etc. For custom labels, first call GMAIL_LIST_LABELS to get the label ID (format: Label_XXX)."
    },
    "removeLabelIds": {
      "type": "array",
      "items": {
        "type": "string"
      },
      "title": "Remove Label Ids",
      "examples": [
        [
          "UNREAD"
        ],
        [
          "INBOX",
          "UNREAD"
        ],
        [
          "Label_1",
          "SPAM"
        ]
      ],
      "description": "List of label IDs to remove from the messages. IMPORTANT: Use label IDs, NOT label display names. System labels use their name as ID: INBOX, STARRED, IMPORTANT, SENT, SPAM, TRASH, UNREAD. Custom labels MUST use their ID (format: 'Label_XXX', e.g., 'Label_1', 'Label_25'), NOT the display name (e.g., do NOT use 'Work' or 'Projects'). Call GMAIL_LIST_LABELS first to get the 'id' field for custom labels. Common use cases: Remove 'UNREAD' to mark as read, remove 'INBOX' to archive. Note: 'DRAFT' cannot be removed - use GMAIL_DELETE_DRAFT instead. At least one of add_label_ids or remove_label_ids must be provided. CONSTRAINT: Label IDs must NOT overlap with add_label_ids - cannot add and remove the same label.",
      "human_parameter_name": "Label IDs to remove",
      "human_parameter_description": "Specify the label IDs you want to remove. For system labels use INBOX, UNREAD, etc. For custom labels, first call GMAIL_LIST_LABELS to get the label ID (format: Label_XXX). Note: DRAFT cannot be removed - use GMAIL_DELETE_DRAFT instead."
    }
  }
}
```

**Output schema:**
```json
{
  "type": "object",
  "$defs": {
    "BatchModifyMessagesResponse": {
      "type": "object",
      "title": "BatchModifyMessagesResponse",
      "required": [
        "success",
        "message"
      ],
      "properties": {
        "message": {
          "type": "string",
          "title": "Message",
          "description": "Status message"
        },
        "success": {
          "type": "boolean",
          "title": "Success",
          "description": "Whether the batch modification was successful"
        },
        "display_url": {
          "type": "string",
          "title": "Display Url",
          "description": "Web UI link for this resource - set by each action's execute()."
        }
      },
      "description": "Response schema for batch modify messages."
    }
  },
  "title": "BatchModifyMessagesResponseWrapper",
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
          "description": "Status message"
        },
        "success": {
          "type": "boolean",
          "title": "Success",
          "description": "Whether the batch modification was successful"
        },
        "display_url": {
          "type": "string",
          "title": "Display Url",
          "description": "Web UI link for this resource - set by each action's execute()."
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

## GMAIL_CREATE_EMAIL_DRAFT
Creates a Gmail email draft. While all fields are optional per the Gmail API, practical validation requires at least one of recipient_email, cc, or bcc and at least one of subject or body. Supports To/Cc/Bcc recipients, subject, plain/HTML body (ensure `is_html=True` for HTML), attachments, and threading. Returns a draft_id that must be used as-is with GMAIL_SEND_DRAFT — synthetic or stale IDs will fail. When creating a draft reply to an existing thread (thread_id provided), leave subject empty to stay in the same thread; setting a subject will create a NEW thread instead. HTTP 429 may occur on rapid creation/send sequences; apply exponential backoff.

**Input schema:**
```json
{
  "type": "object",
  "title": "CreateEmailDraftRequest",
  "properties": {
    "cc": {
      "type": "array",
      "items": {
        "type": "string"
      },
      "title": "Cc",
      "default": [],
      "examples": [
        [
          "cc.recipient1@example.com",
          "CC User <cc.recipient2@example.com>"
        ]
      ],
      "description": "Carbon Copy (CC) recipients' email addresses. Each must be a valid email address (e.g., 'user@example.com') or display name format (e.g., 'John Doe <user@example.com>'). Plain names without email addresses are NOT valid. Optional for drafts (recipients can be added later before sending)."
    },
    "bcc": {
      "type": "array",
      "items": {
        "type": "string"
      },
      "title": "Bcc",
      "default": [],
      "examples": [
        [
          "bcc.recipient@example.com",
          "BCC User <bcc.user@example.com>"
        ]
      ],
      "description": "Blind Carbon Copy (BCC) recipients' email addresses. Each must be a valid email address (e.g., 'user@example.com') or display name format (e.g., 'Bob Jones <user@example.com>'). Plain names without email addresses are NOT valid. Optional for drafts (recipients can be added later before sending)."
    },
    "body": {
      "type": "string",
      "title": "Body",
      "examples": [
        "Hello Team,\n\nPlease find the attached report for your review.\n\nBest regards,\nYour Name",
        "<h1>Meeting Confirmation</h1><p>This email confirms our meeting scheduled for next Tuesday.</p>"
      ],
      "description": "Email body content (plain text or HTML); `is_html` must be True if HTML. Optional - drafts can be created without a body and edited later before sending. Can also be provided as 'message_body'.",
      "human_parameter_name": "Email Body",
      "human_parameter_description": "Write the main content of your email here. This can be plain text or HTML, depending on your preference."
    },
    "is_html": {
      "type": "boolean",
      "title": "Is Html",
      "default": false,
      "examples": [
        true,
        false
      ],
      "description": "Set to True if `body` is already formatted HTML. When False, plain text newlines are auto-converted to <br/> tags. Both modes result in HTML email; this flag controls whether the body content is treated as raw HTML or plain text that gets HTML formatting applied.",
      "human_parameter_name": "Is HTML?",
      "human_parameter_description": "Set to True if your email body is already HTML. When False, plain text formatting (newlines, tabs) will be automatically converted to HTML for proper display."
    },
    "subject": {
      "type": "string",
      "title": "Subject",
      "examples": [
        "Project Update Q3",
        "Meeting Reminder"
      ],
      "description": "Email subject line. Optional - drafts can be created without a subject and edited later before sending. When creating a draft reply to an existing thread (thread_id provided), leave this empty to stay in the same thread. Setting a subject will create a NEW thread instead.",
      "human_parameter_name": "Subject",
      "human_parameter_description": "Enter the subject of your email. This helps the recipient understand what the email is about."
    },
    "user_id": {
      "type": "string",
      "title": "User Id",
      "default": "me",
      "examples": [
        "me",
        "user@example.com"
      ],
      "description": "User's email address or 'me' for the authenticated user.",
      "human_parameter_name": "User ID",
      "human_parameter_description": "Provide the user ID or the email address of the user. Use 'me' to refer to the currently authenticated user."
    },
    "thread_id": {
      "type": "string",
      "title": "Thread Id",
      "examples": [
        "17f45ec49a9c3f1b"
      ],
      "description": "ID of an existing Gmail thread to reply to; omit for new thread. If the thread ID is invalid or inaccessible, the draft will be created as a new thread instead of failing.",
      "human_parameter_name": "Thread ID",
      "human_parameter_description": "If you want to reply to an ongoing conversation, provide the thread ID here. Leave it blank for a new message."
    },
    "attachment": {
      "type": "object",
      "title": "FileUploadable",
      "required": [
        "name",
        "mimetype",
        "s3key"
      ],
      "properties": {
        "name": {
          "type": "string",
          "title": "Name",
          "examples": [
            "document.pdf",
            "image.jpg",
            "report.docx"
          ],
          "description": "The filename that will be used when uploading the file to the destination service"
        },
        "s3key": {
          "type": "string",
          "title": "S3Key",
          "examples": [
            "47563/gmail/GET_ATTACHMENT/response/12345"
          ],
          "description": "The S3 key of a publicly accessible file, typically returned from a previous download action that stored the file in S3. This key references an existing file that can be uploaded to another service."
        },
        "mimetype": {
          "type": "string",
          "title": "Mimetype",
          "examples": [
            "application/pdf",
            "image/jpeg",
            "application/vnd.openxmlformats-officedocument.wordprocessingml.document"
          ],
          "description": "The MIME type of the file"
        }
      },
      "description": "File to attach to the email. Must be a dict with fields: name (filename), mimetype (e.g., 'application/pdf'), and s3key (obtained from a prior upload/download response \u2014 local paths or guessed keys will fail). Total message size including base64-encoded attachments must be under 25 MB; use shareable links (e.g., Google Drive) for larger files.",
      "file_uploadable": true,
      "additionalProperties": false,
      "human_parameter_name": "Attachment",
      "human_parameter_description": "Upload any file you want to include with the email as an attachment."
    },
    "recipient_email": {
      "type": "string",
      "title": "Recipient Email",
      "examples": [
        "john.doe@example.com",
        "John Doe <john.doe@example.com>"
      ],
      "description": "Primary recipient's email address. Must be a valid email address (e.g., 'user@example.com') or display name format (e.g., 'John Doe <user@example.com>'). A plain name without an email address (e.g., 'John Doe') is NOT valid - the '@' symbol and domain are required. Optional for drafts (recipients can be added later before sending). Use extra_recipients if you want to send to multiple recipients."
    },
    "extra_recipients": {
      "type": "array",
      "items": {
        "type": "string"
      },
      "title": "Extra Recipients",
      "default": [],
      "examples": [
        [
          "jane.doe@example.com",
          "Jane Doe <jane.doe@example.com>"
        ]
      ],
      "description": "Additional 'To' recipients' email addresses (not Cc or Bcc). Each must be a valid email address (e.g., 'user@example.com'), display name format (e.g., 'Jane Doe <user@example.com>'), or 'me' for the authenticated user. Plain names without email addresses are NOT valid. Should only be used if recipient_email is also provided."
    }
  }
}
```

**Output schema:**
```json
{
  "type": "object",
  "$defs": {
    "GmailMessageResponse": {
      "type": "object",
      "title": "GmailMessageResponse",
      "properties": {
        "id": {
          "type": "string",
          "title": "Id",
          "description": "The immutable ID of the sent message."
        },
        "raw": {
          "type": "string",
          "title": "Raw",
          "description": "The entire email message in RFC 2822 format, base64url-encoded."
        },
        "payload": {
          "type": "object",
          "title": "Payload",
          "description": "The parsed email structure, including headers and body parts.",
          "additionalProperties": true
        },
        "snippet": {
          "type": "string",
          "title": "Snippet",
          "description": "A short extract of the message text."
        },
        "labelIds": {
          "type": "array",
          "items": {
            "type": "string"
          },
          "title": "Label Ids",
          "description": "List of IDs of labels applied to this message."
        },
        "threadId": {
          "type": "string",
          "title": "Thread Id",
          "description": "The ID of the thread the message belongs to."
        },
        "historyId": {
          "type": "string",
          "title": "History Id",
          "description": "The ID of the last history record that modified this message."
        },
        "display_url": {
          "type": "string",
          "title": "Display Url",
          "description": "Web UI link for this resource - set by each action's execute()."
        },
        "internalDate": {
          "type": "string",
          "title": "Internal Date",
          "description": "The internal timestamp of the message in milliseconds since epoch."
        },
        "sizeEstimate": {
          "type": "integer",
          "title": "Size Estimate",
          "description": "Estimated size of the message in bytes."
        }
      },
      "description": "Standard Gmail message response returned by Gmail API for sent messages.\nUsed by actions like send_email and send_draft."
    },
    "CreateEmailDraftResponse": {
      "type": "object",
      "title": "CreateEmailDraftResponse",
      "required": [
        "id",
        "message"
      ],
      "properties": {
        "id": {
          "type": "string",
          "title": "Id",
          "description": "Immutable ID of the draft."
        },
        "message": {
          "type": "object",
          "title": "Message",
          "properties": {
            "id": {
              "type": "string",
              "title": "Id",
              "description": "The immutable ID of the sent message."
            },
            "raw": {
              "type": "string",
              "title": "Raw",
              "description": "The entire email message in RFC 2822 format, base64url-encoded."
            },
            "payload": {
              "type": "object",
              "title": "Payload",
              "description": "The parsed email structure, including headers and body parts.",
              "additionalProperties": true
            },
            "snippet": {
              "type": "string",
              "title": "Snippet",
              "description": "A short extract of the message text."
            },
            "labelIds": {
              "type": "array",
              "items": {
                "type": "string"
              },
              "title": "Label Ids",
              "description": "List of IDs of labels applied to this message."
            },
            "threadId": {
              "type": "string",
              "title": "Thread Id",
              "description": "The ID of the thread the message belongs to."
            },
            "historyId": {
              "type": "string",
              "title": "History Id",
              "description": "The ID of the last history record that modified this message."
            },
            "display_url": {
              "type": "string",
              "title": "Display Url",
              "description": "Web UI link for this resource - set by each action's execute()."
            },
            "internalDate": {
              "type": "string",
              "title": "Internal Date",
              "description": "The internal timestamp of the message in milliseconds since epoch."
            },
            "sizeEstimate": {
              "type": "integer",
              "title": "Size Estimate",
              "description": "Estimated size of the message in bytes."
            }
          },
          "description": "The created draft message resource."
        },
        "display_url": {
          "type": "string",
          "title": "Display Url",
          "description": "URL to view the draft in Gmail."
        }
      }
    }
  },
  "title": "CreateEmailDraftResponseWrapper",
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
        "message"
      ],
      "properties": {
        "id": {
          "type": "string",
          "title": "Id",
          "description": "Immutable ID of the draft."
        },
        "message": {
          "type": "object",
          "title": "Message",
          "properties": {
            "id": {
              "type": "string",
              "title": "Id",
              "description": "The immutable ID of the sent message."
            },
            "raw": {
              "type": "string",
              "title": "Raw",
              "description": "The entire email message in RFC 2822 format, base64url-encoded."
            },
            "payload": {
              "type": "object",
              "title": "Payload",
              "description": "The parsed email structure, including headers and body parts.",
              "additionalProperties": true
            },
            "snippet": {
              "type": "string",
              "title": "Snippet",
              "description": "A short extract of the message text."
            },
            "labelIds": {
              "type": "array",
              "items": {
                "type": "string"
              },
              "title": "Label Ids",
              "description": "List of IDs of labels applied to this message."
            },
            "threadId": {
              "type": "string",
              "title": "Thread Id",
              "description": "The ID of the thread the message belongs to."
            },
            "historyId": {
              "type": "string",
              "title": "History Id",
              "description": "The ID of the last history record that modified this message."
            },
            "display_url": {
              "type": "string",
              "title": "Display Url",
              "description": "Web UI link for this resource - set by each action's execute()."
            },
            "internalDate": {
              "type": "string",
              "title": "Internal Date",
              "description": "The internal timestamp of the message in milliseconds since epoch."
            },
            "sizeEstimate": {
              "type": "integer",
              "title": "Size Estimate",
              "description": "Estimated size of the message in bytes."
            }
          },
          "description": "The created draft message resource."
        },
        "display_url": {
          "type": "string",
          "title": "Display Url",
          "description": "URL to view the draft in Gmail."
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

## GMAIL_CREATE_FILTER
Tool to create a new Gmail filter with specified criteria and actions. Use when the user wants to automatically organize incoming messages based on sender, subject, size, or other criteria. Note: you can only create a maximum of 1,000 filters per account.

**Input schema:**
```json
{
  "type": "object",
  "title": "CreateFilterRequest",
  "required": [
    "criteria",
    "action"
  ],
  "properties": {
    "action": {
      "type": "object",
      "title": "Action",
      "properties": {
        "forward": {
          "type": "string",
          "title": "Forward",
          "examples": [
            "forward@example.com"
          ],
          "description": "Email address that the message should be forwarded to."
        },
        "addLabelIds": {
          "type": "array",
          "items": {
            "type": "string"
          },
          "title": "Add Label Ids",
          "examples": [
            [
              "Label_1",
              "IMPORTANT"
            ]
          ],
          "description": "List of label IDs to add to the message."
        },
        "removeLabelIds": {
          "type": "array",
          "items": {
            "type": "string"
          },
          "title": "Remove Label Ids",
          "examples": [
            [
              "UNREAD",
              "INBOX"
            ]
          ],
          "description": "List of label IDs to remove from the message."
        }
      },
      "description": "REQUIRED. Action that the filter will perform on messages matching the criteria. At least one action field must be specified.",
      "additionalProperties": false
    },
    "user_id": {
      "type": "string",
      "title": "User Id",
      "default": "me",
      "examples": [
        "me",
        "user@example.com"
      ],
      "description": "The user's email address or the special value 'me' to indicate the authenticated user for whom the filter will be created."
    },
    "criteria": {
      "type": "object",
      "title": "Criteria",
      "properties": {
        "to": {
          "type": "string",
          "title": "To",
          "examples": [
            "recipient@example.com"
          ],
          "description": "The recipient's display name or email address. Includes recipients in the 'to', 'cc', and 'bcc' header fields. You can use simply the local part of the email address. For example, 'example' and 'example@' both match 'example@gmail.com'. This field is case-insensitive."
        },
        "from": {
          "type": "string",
          "title": "From",
          "examples": [
            "sender@example.com"
          ],
          "description": "The sender's display name or email address."
        },
        "size": {
          "type": "integer",
          "title": "Size",
          "examples": [
            1000000
          ],
          "description": "The size of the entire RFC822 message in bytes, including all headers and attachments."
        },
        "query": {
          "type": "string",
          "title": "Query",
          "examples": [
            "from:someuser@example.com is:unread"
          ],
          "description": "Only return messages matching the specified query. Supports the same query format as the Gmail search box. For example, 'from:someuser@example.com rfc822msgid: is:unread'."
        },
        "subject": {
          "type": "string",
          "title": "Subject",
          "examples": [
            "Important"
          ],
          "description": "Case-insensitive phrase found in the message's subject. Trailing and leading whitespace are trimmed and adjacent spaces are collapsed."
        },
        "excludeChats": {
          "type": "boolean",
          "title": "Exclude Chats",
          "examples": [
            true,
            false
          ],
          "description": "Whether the response should exclude chats."
        },
        "negatedQuery": {
          "type": "string",
          "title": "Negated Query",
          "examples": [
            "from:spam@example.com"
          ],
          "description": "Only return messages not matching the specified query. Supports the same query format as the Gmail search box."
        },
        "hasAttachment": {
          "type": "boolean",
          "title": "Has Attachment",
          "examples": [
            true,
            false
          ],
          "description": "Whether the message has any attachment."
        },
        "sizeComparison": {
          "enum": [
            "unspecified",
            "smaller",
            "larger"
          ],
          "type": "string",
          "title": "SizeComparison",
          "examples": [
            "larger",
            "smaller"
          ],
          "description": "How the message size should be compared to the size field."
        }
      },
      "description": "REQUIRED. Message matching criteria that determines which messages the filter will apply to. At least one criteria field must be specified.",
      "additionalProperties": false
    }
  }
}
```

**Output schema:**
```json
{
  "type": "object",
  "$defs": {
    "FilterAction": {
      "type": "object",
      "title": "FilterAction",
      "properties": {
        "forward": {
          "type": "string",
          "title": "Forward",
          "examples": [
            "forward@example.com"
          ],
          "description": "Email address that the message should be forwarded to."
        },
        "addLabelIds": {
          "type": "array",
          "items": {
            "type": "string"
          },
          "title": "Add Label Ids",
          "examples": [
            [
              "Label_1",
              "IMPORTANT"
            ]
          ],
          "description": "List of label IDs to add to the message."
        },
        "removeLabelIds": {
          "type": "array",
          "items": {
            "type": "string"
          },
          "title": "Remove Label Ids",
          "examples": [
            [
              "UNREAD",
              "INBOX"
            ]
          ],
          "description": "List of label IDs to remove from the message."
        }
      },
      "description": "Action that the filter performs on matched messages."
    },
    "FilterCriteria": {
      "type": "object",
      "title": "FilterCriteria",
      "properties": {
        "to": {
          "type": "string",
          "title": "To",
          "examples": [
            "recipient@example.com"
          ],
          "description": "The recipient's display name or email address. Includes recipients in the 'to', 'cc', and 'bcc' header fields. You can use simply the local part of the email address. For example, 'example' and 'example@' both match 'example@gmail.com'. This field is case-insensitive."
        },
        "from": {
          "type": "string",
          "title": "From",
          "examples": [
            "sender@example.com"
          ],
          "description": "The sender's display name or email address."
        },
        "size": {
          "type": "integer",
          "title": "Size",
          "examples": [
            1000000
          ],
          "description": "The size of the entire RFC822 message in bytes, including all headers and attachments."
        },
        "query": {
          "type": "string",
          "title": "Query",
          "examples": [
            "from:someuser@example.com is:unread"
          ],
          "description": "Only return messages matching the specified query. Supports the same query format as the Gmail search box. For example, 'from:someuser@example.com rfc822msgid: is:unread'."
        },
        "subject": {
          "type": "string",
          "title": "Subject",
          "examples": [
            "Important"
          ],
          "description": "Case-insensitive phrase found in the message's subject. Trailing and leading whitespace are trimmed and adjacent spaces are collapsed."
        },
        "excludeChats": {
          "type": "boolean",
          "title": "Exclude Chats",
          "examples": [
            true,
            false
          ],
          "description": "Whether the response should exclude chats."
        },
        "negatedQuery": {
          "type": "string",
          "title": "Negated Query",
          "examples": [
            "from:spam@example.com"
          ],
          "description": "Only return messages not matching the specified query. Supports the same query format as the Gmail search box."
        },
        "hasAttachment": {
          "type": "boolean",
          "title": "Has Attachment",
          "examples": [
            true,
            false
          ],
          "description": "Whether the message has any attachment."
        },
        "sizeComparison": {
          "enum": [
            "unspecified",
            "smaller",
            "larger"
          ],
          "type": "string",
          "title": "Size Comparison",
          "description": "How the message size in bytes should be in relation to the size field.",
          "examples": [
            "larger",
            "smaller"
          ]
        }
      },
      "description": "Message matching criteria for the filter."
    },
    "SizeComparison": {
      "enum": [
        "unspecified",
        "smaller",
        "larger"
      ],
      "type": "string",
      "title": "SizeComparison",
      "description": "How the message size should be compared to the size field."
    },
    "CreateFilterResponse": {
      "type": "object",
      "title": "CreateFilterResponse",
      "properties": {
        "id": {
          "type": "string",
          "title": "Id",
          "description": "The server assigned ID of the filter."
        },
        "action": {
          "type": "object",
          "title": "Action",
          "properties": {
            "forward": {
              "type": "string",
              "title": "Forward",
              "examples": [
                "forward@example.com"
              ],
              "description": "Email address that the message should be forwarded to."
            },
            "addLabelIds": {
              "type": "array",
              "items": {
                "type": "string"
              },
              "title": "Add Label Ids",
              "examples": [
                [
                  "Label_1",
                  "IMPORTANT"
                ]
              ],
              "description": "List of label IDs to add to the message."
            },
            "removeLabelIds": {
              "type": "array",
              "items": {
                "type": "string"
              },
              "title": "Remove Label Ids",
              "examples": [
                [
                  "UNREAD",
                  "INBOX"
                ]
              ],
              "description": "List of label IDs to remove from the message."
            }
          },
          "description": "Action that the filter performs."
        },
        "criteria": {
          "type": "object",
          "title": "Criteria",
          "properties": {
            "to": {
              "type": "string",
              "title": "To",
              "examples": [
                "recipient@example.com"
              ],
              "description": "The recipient's display name or email address. Includes recipients in the 'to', 'cc', and 'bcc' header fields. You can use simply the local part of the email address. For example, 'example' and 'example@' both match 'example@gmail.com'. This field is case-insensitive."
            },
            "from": {
              "type": "string",
              "title": "From",
              "examples": [
                "sender@example.com"
              ],
              "description": "The sender's display name or email address."
            },
            "size": {
              "type": "integer",
              "title": "Size",
              "examples": [
                1000000
              ],
              "description": "The size of the entire RFC822 message in bytes, including all headers and attachments."
            },
            "query": {
              "type": "string",
              "title": "Query",
              "examples": [
                "from:someuser@example.com is:unread"
              ],
              "description": "Only return messages matching the specified query. Supports the same query format as the Gmail search box. For example, 'from:someuser@example.com rfc822msgid: is:unread'."
            },
            "subject": {
              "type": "string",
              "title": "Subject",
              "examples": [
                "Important"
              ],
              "description": "Case-insensitive phrase found in the message's subject. Trailing and leading whitespace are trimmed and adjacent spaces are collapsed."
            },
            "excludeChats": {
              "type": "boolean",
              "title": "Exclude Chats",
              "examples": [
                true,
                false
              ],
              "description": "Whether the response should exclude chats."
            },
            "negatedQuery": {
              "type": "string",
              "title": "Negated Query",
              "examples": [
                "from:spam@example.com"
              ],
              "description": "Only return messages not matching the specified query. Supports the same query format as the Gmail search box."
            },
            "hasAttachment": {
              "type": "boolean",
              "title": "Has Attachment",
              "examples": [
                true,
                false
              ],
              "description": "Whether the message has any attachment."
            },
            "sizeComparison": {
              "enum": [
                "unspecified",
                "smaller",
                "larger"
              ],
              "type": "string",
              "title": "Size Comparison",
              "description": "How the message size in bytes should be in relation to the size field.",
              "examples": [
                "larger",
                "smaller"
              ]
            }
          },
          "description": "Matching criteria for the filter."
        }
      },
      "description": "Response from creating a Gmail filter."
    }
  },
  "title": "CreateFilterResponseWrapper",
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
          "description": "The server assigned ID of the filter."
        },
        "action": {
          "type": "object",
          "title": "Action",
          "properties": {
            "forward": {
              "type": "string",
              "title": "Forward",
              "examples": [
                "forward@example.com"
              ],
              "description": "Email address that the message should be forwarded to."
            },
            "addLabelIds": {
              "type": "array",
              "items": {
                "type": "string"
              },
              "title": "Add Label Ids",
              "examples": [
                [
                  "Label_1",
                  "IMPORTANT"
                ]
              ],
              "description": "List of label IDs to add to the message."
            },
            "removeLabelIds": {
              "type": "array",
              "items": {
                "type": "string"
              },
              "title": "Remove Label Ids",
              "examples": [
                [
                  "UNREAD",
                  "INBOX"
                ]
              ],
              "description": "List of label IDs to remove from the message."
            }
          },
          "description": "Action that the filter performs."
        },
        "criteria": {
          "type": "object",
          "title": "Criteria",
          "properties": {
            "to": {
              "type": "string",
              "title": "To",
              "examples": [
                "recipient@example.com"
              ],
              "description": "The recipient's display name or email address. Includes recipients in the 'to', 'cc', and 'bcc' header fields. You can use simply the local part of the email address. For example, 'example' and 'example@' both match 'example@gmail.com'. This field is case-insensitive."
            },
            "from": {
              "type": "string",
              "title": "From",
              "examples": [
                "sender@example.com"
              ],
              "description": "The sender's display name or email address."
            },
            "size": {
              "type": "integer",
              "title": "Size",
              "examples": [
                1000000
              ],
              "description": "The size of the entire RFC822 message in bytes, including all headers and attachments."
            },
            "query": {
              "type": "string",
              "title": "Query",
              "examples": [
                "from:someuser@example.com is:unread"
              ],
              "description": "Only return messages matching the specified query. Supports the same query format as the Gmail search box. For example, 'from:someuser@example.com rfc822msgid: is:unread'."
            },
            "subject": {
              "type": "string",
              "title": "Subject",
              "examples": [
                "Important"
              ],
              "description": "Case-insensitive phrase found in the message's subject. Trailing and leading whitespace are trimmed and adjacent spaces are collapsed."
            },
            "excludeChats": {
              "type": "boolean",
              "title": "Exclude Chats",
              "examples": [
                true,
                false
              ],
              "description": "Whether the response should exclude chats."
            },
            "negatedQuery": {
              "type": "string",
              "title": "Negated Query",
              "examples": [
                "from:spam@example.com"
              ],
              "description": "Only return messages not matching the specified query. Supports the same query format as the Gmail search box."
            },
            "hasAttachment": {
              "type": "boolean",
              "title": "Has Attachment",
              "examples": [
                true,
                false
              ],
              "description": "Whether the message has any attachment."
            },
            "sizeComparison": {
              "enum": [
                "unspecified",
                "smaller",
                "larger"
              ],
              "type": "string",
              "title": "Size Comparison",
              "description": "How the message size in bytes should be in relation to the size field.",
              "examples": [
                "larger",
                "smaller"
              ]
            }
          },
          "description": "Matching criteria for the filter."
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

## GMAIL_CREATE_LABEL
Creates a new label with a unique name in the specified user's Gmail account. Returns a labelId (e.g., 'Label_123') required for downstream tools like GMAIL_ADD_LABEL_TO_EMAIL, GMAIL_BATCH_MODIFY_MESSAGES, and GMAIL_MODIFY_THREAD_LABELS — those tools do not accept display names.

**Input schema:**
```json
{
  "type": "object",
  "title": "CreateLabelRequest",
  "required": [
    "label_name"
  ],
  "properties": {
    "user_id": {
      "type": "string",
      "title": "User Id",
      "default": "me",
      "examples": [
        "me",
        "user@example.com"
      ],
      "description": "The email address of the user in whose account the label will be created.",
      "human_parameter_name": "User ID",
      "human_parameter_description": "Provide the email address or identifier of the user for whom you want to create a label. Use 'me' to refer to your own account."
    },
    "label_name": {
      "type": "string",
      "title": "Label Name",
      "examples": [
        "Work",
        "Project Documents",
        "Receipts 2024",
        "Work/Projects",
        "Personal/Finance",
        "1. Action Items"
      ],
      "description": "REQUIRED. The name for the new label. Must be unique within the account, non-blank, maximum length 225 characters, cannot contain commas (','), not only whitespace, and must not be a reserved system label. Reserved English system labels include: Inbox, Starred, Important, Sent, Draft, Drafts, Spam, Trash, etc. Forward slashes ('/') are allowed and used to create hierarchical nested labels (e.g., 'Work/Projects', 'Personal/Finance'). When creating nested labels, any missing parent labels will be automatically created (similar to 'mkdir -p'). Periods ('.') are allowed and commonly used for numbering schemes (e.g., '1. Action Items', '2. Projects'). Note: 'name' is also accepted as an alias for this field. If a label with this name already exists, returns a 409 conflict; use GMAIL_LIST_LABELS to check existing labels and reuse the existing labelId, or use GMAIL_PATCH_LABEL to update it."
    },
    "text_color": {
      "enum": [
        "#000000",
        "#434343",
        "#666666",
        "#999999",
        "#cccccc",
        "#efefef",
        "#f3f3f3",
        "#ffffff",
        "#fb4c2f",
        "#ffad47",
        "#fad165",
        "#16a766",
        "#43d692",
        "#4a86e8",
        "#a479e2",
        "#f691b3",
        "#f6c5be",
        "#ffe6c7",
        "#fef1d1",
        "#b9e4d0",
        "#c6f3de",
        "#c9daf8",
        "#e4d7f5",
        "#fcdee8",
        "#efa093",
        "#ffd6a2",
        "#fce8b3",
        "#89d3b2",
        "#a0eac9",
        "#a4c2f4",
        "#d0bcf1",
        "#fbc8d9",
        "#e66550",
        "#ffbc6b",
        "#fcda83",
        "#44b984",
        "#68dfa9",
        "#6d9eeb",
        "#b694e8",
        "#f7a7c0",
        "#cc3a21",
        "#eaa041",
        "#f2c960",
        "#149e60",
        "#3dc789",
        "#3c78d8",
        "#8e63ce",
        "#e07798",
        "#ac2b16",
        "#cf8933",
        "#d5ae49",
        "#0b804b",
        "#2a9c68",
        "#285bac",
        "#653e9b",
        "#b65775",
        "#464646",
        "#e7e7e7",
        "#0d3472",
        "#b6cff5",
        "#0d3b44",
        "#98d7e4",
        "#3d188e",
        "#e3d7ff",
        "#711a36",
        "#fbd3e0",
        "#8a1c0a",
        "#f2b2a8",
        "#7a2e0b",
        "#ffc8af",
        "#7a4706",
        "#ffdeb5",
        "#594c05",
        "#fbe983",
        "#684e07",
        "#fdedc1",
        "#0b4f30",
        "#b3efd3",
        "#04502e",
        "#a2dcc1",
        "#c2c2c2",
        "#4986e7",
        "#2da2bb",
        "#b99aff",
        "#994a64",
        "#f691b2",
        "#ff7537",
        "#ffad46",
        "#662e37",
        "#cca6ac",
        "#094228",
        "#42d692",
        "#076239",
        "#16a765",
        "#1a764d",
        "#1c4587",
        "#41236d",
        "#822111",
        "#83334c",
        "#a46a21",
        "#aa8831",
        "#ebdbde"
      ],
      "type": "string",
      "title": "GmailLabelColor",
      "examples": [
        "BLACK",
        "WHITE",
        "YELLOW",
        "RED",
        "BLUE",
        "GREEN",
        "#000000",
        "#ffffff",
        "ROYAL_BLUE"
      ],
      "description": "Text color for the label. Gmail only accepts colors from a predefined palette of 102 specific hex values. Common color names like 'YELLOW', 'RED', 'BLUE', 'GREEN', 'ORANGE', 'PURPLE', 'PINK' are automatically mapped to the closest Gmail palette color. Provide either a common color name, a Gmail palette color name (e.g., 'BLACK', 'ROYAL_BLUE'), or exact hex value (e.g., '#000000', '#4a86e8'). If only text_color is provided without background_color, a complementary background color (white or black) will be auto-selected for optimal contrast. Full palette: https://developers.google.com/workspace/gmail/api/reference/rest/v1/users.labels#Color Must be supplied together with background_color \u2014 providing only one will cause a 400 error. The auto-selected complementary color behavior does not apply; both colors are required.",
      "human_parameter_name": "Text Color",
      "human_parameter_description": "Pick a color for the label text. Common names like 'YELLOW', 'RED', 'BLUE', 'GREEN' are automatically mapped to Gmail palette colors."
    },
    "background_color": {
      "enum": [
        "#000000",
        "#434343",
        "#666666",
        "#999999",
        "#cccccc",
        "#efefef",
        "#f3f3f3",
        "#ffffff",
        "#fb4c2f",
        "#ffad47",
        "#fad165",
        "#16a766",
        "#43d692",
        "#4a86e8",
        "#a479e2",
        "#f691b3",
        "#f6c5be",
        "#ffe6c7",
        "#fef1d1",
        "#b9e4d0",
        "#c6f3de",
        "#c9daf8",
        "#e4d7f5",
        "#fcdee8",
        "#efa093",
        "#ffd6a2",
        "#fce8b3",
        "#89d3b2",
        "#a0eac9",
        "#a4c2f4",
        "#d0bcf1",
        "#fbc8d9",
        "#e66550",
        "#ffbc6b",
        "#fcda83",
        "#44b984",
        "#68dfa9",
        "#6d9eeb",
        "#b694e8",
        "#f7a7c0",
        "#cc3a21",
        "#eaa041",
        "#f2c960",
        "#149e60",
        "#3dc789",
        "#3c78d8",
        "#8e63ce",
        "#e07798",
        "#ac2b16",
        "#cf8933",
        "#d5ae49",
        "#0b804b",
        "#2a9c68",
        "#285bac",
        "#653e9b",
        "#b65775",
        "#464646",
        "#e7e7e7",
        "#0d3472",
        "#b6cff5",
        "#0d3b44",
        "#98d7e4",
        "#3d188e",
        "#e3d7ff",
        "#711a36",
        "#fbd3e0",
        "#8a1c0a",
        "#f2b2a8",
        "#7a2e0b",
        "#ffc8af",
        "#7a4706",
        "#ffdeb5",
        "#594c05",
        "#fbe983",
        "#684e07",
        "#fdedc1",
        "#0b4f30",
        "#b3efd3",
        "#04502e",
        "#a2dcc1",
        "#c2c2c2",
        "#4986e7",
        "#2da2bb",
        "#b99aff",
        "#994a64",
        "#f691b2",
        "#ff7537",
        "#ffad46",
        "#662e37",
        "#cca6ac",
        "#094228",
        "#42d692",
        "#076239",
        "#16a765",
        "#1a764d",
        "#1c4587",
        "#41236d",
        "#822111",
        "#83334c",
        "#a46a21",
        "#aa8831",
        "#ebdbde"
      ],
      "type": "string",
      "title": "GmailLabelColor",
      "examples": [
        "YELLOW",
        "RED",
        "BLUE",
        "GREEN",
        "ROYAL_BLUE",
        "CARIBBEAN_GREEN",
        "#4a86e8",
        "#43d692"
      ],
      "description": "Background color for the label. Gmail only accepts colors from a predefined palette of 102 specific hex values. Common color names like 'YELLOW', 'RED', 'BLUE', 'GREEN', 'ORANGE', 'PURPLE', 'PINK' are automatically mapped to the closest Gmail palette color. Provide either a common color name, a Gmail palette color name (e.g., 'ROYAL_BLUE', 'CARIBBEAN_GREEN'), or exact hex value (e.g., '#4a86e8', '#43d692'). If only background_color is provided without text_color, a complementary text color (white or black) will be auto-selected for optimal contrast. Full palette: https://developers.google.com/workspace/gmail/api/reference/rest/v1/users.labels#Color Must be supplied together with text_color \u2014 providing only one will cause a 400 error. The auto-selected complementary color behavior does not apply; both colors are required.",
      "human_parameter_name": "Background Color",
      "human_parameter_description": "Choose a background color for your label. Common names like 'YELLOW', 'RED', 'BLUE', 'GREEN' are automatically mapped to Gmail palette colors."
    },
    "label_list_visibility": {
      "enum": [
        "labelShow",
        "labelShowIfUnread",
        "labelHide"
      ],
      "type": "string",
      "title": "Label List Visibility",
      "default": "labelShow",
      "examples": [
        "labelShow",
        "labelShowIfUnread",
        "labelHide"
      ],
      "description": "Controls how the label is displayed in the label list in the Gmail sidebar. Valid values: 'labelShow' (always show), 'labelShowIfUnread' (show only if unread messages), 'labelHide' (hide from list).",
      "human_parameter_name": "Label List Visibility",
      "human_parameter_description": "Select how you want the label to appear in the Gmail sidebar. You can show it all the time, show it only if there are unread messages, or hide it completely."
    },
    "message_list_visibility": {
      "enum": [
        "show",
        "hide"
      ],
      "type": "string",
      "title": "Message List Visibility",
      "default": "show",
      "examples": [
        "show",
        "hide"
      ],
      "description": "Controls how messages with this label are displayed in the message list. Valid values: 'show' or 'hide'. Note: These values are different from label_list_visibility - do NOT use 'labelShow' or 'labelHide' here.",
      "human_parameter_name": "Message List Visibility",
      "human_parameter_description": "Choose whether messages with this label should be visible in the message list or hidden away."
    }
  }
}
```

**Output schema:**
```json
{
  "type": "object",
  "$defs": {
    "Label": {
      "type": "object",
      "title": "Label",
      "required": [
        "id",
        "name"
      ],
      "properties": {
        "id": {
          "type": "string",
          "title": "Id",
          "description": "The immutable ID of the label."
        },
        "name": {
          "type": "string",
          "title": "Name",
          "description": "The display name of the label."
        },
        "type": {
          "type": "string",
          "title": "Type",
          "description": "The type of label (system or user)."
        },
        "color": {
          "type": "object",
          "title": "Color",
          "required": [
            "backgroundColor",
            "textColor"
          ],
          "properties": {
            "textColor": {
              "type": "string",
              "title": "Text Color",
              "description": "Hex code for the text color of the label."
            },
            "backgroundColor": {
              "type": "string",
              "title": "Background Color",
              "description": "Hex code for the background color of the label."
            }
          },
          "description": "Optional color settings for the label."
        },
        "display_url": {
          "type": "string",
          "title": "Display Url",
          "description": "Web UI link for this resource - set by each action's execute()."
        },
        "threadsTotal": {
          "type": "integer",
          "title": "Threads Total",
          "description": "The total number of threads with the label."
        },
        "messagesTotal": {
          "type": "integer",
          "title": "Messages Total",
          "description": "The total number of messages with the label."
        },
        "threadsUnread": {
          "type": "integer",
          "title": "Threads Unread",
          "description": "The number of unread threads with the label."
        },
        "messagesUnread": {
          "type": "integer",
          "title": "Messages Unread",
          "description": "The number of unread messages with the label."
        },
        "labelListVisibility": {
          "type": "string",
          "title": "Label List Visibility",
          "description": "Visibility of the label in the label list (e.g., 'labelShow' or 'labelHide')."
        },
        "messageListVisibility": {
          "type": "string",
          "title": "Message List Visibility",
          "description": "Visibility of messages with the label in the message list (e.g., 'show' or 'hide')."
        }
      }
    },
    "LabelColor": {
      "type": "object",
      "title": "LabelColor",
      "required": [
        "backgroundColor",
        "textColor"
      ],
      "properties": {
        "textColor": {
          "type": "string",
          "title": "Text Color",
          "description": "Hex code for the text color of the label."
        },
        "backgroundColor": {
          "type": "string",
          "title": "Background Color",
          "description": "Hex code for the background color of the label."
        }
      }
    }
  },
  "title": "LabelWrapper",
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
          "description": "The immutable ID of the label."
        },
        "name": {
          "type": "string",
          "title": "Name",
          "description": "The display name of the label."
        },
        "type": {
          "type": "string",
          "title": "Type",
          "description": "The type of label (system or user)."
        },
        "color": {
          "type": "object",
          "title": "Color",
          "required": [
            "backgroundColor",
            "textColor"
          ],
          "properties": {
            "textColor": {
              "type": "string",
              "title": "Text Color",
              "description": "Hex code for the text color of the label."
            },
            "backgroundColor": {
              "type": "string",
              "title": "Background Color",
              "description": "Hex code for the background color of the label."
            }
          },
          "description": "Optional color settings for the label."
        },
        "display_url": {
          "type": "string",
          "title": "Display Url",
          "description": "Web UI link for this resource - set by each action's execute()."
        },
        "threadsTotal": {
          "type": "integer",
          "title": "Threads Total",
          "description": "The total number of threads with the label."
        },
        "messagesTotal": {
          "type": "integer",
          "title": "Messages Total",
          "description": "The total number of messages with the label."
        },
        "threadsUnread": {
          "type": "integer",
          "title": "Threads Unread",
          "description": "The number of unread threads with the label."
        },
        "messagesUnread": {
          "type": "integer",
          "title": "Messages Unread",
          "description": "The number of unread messages with the label."
        },
        "labelListVisibility": {
          "type": "string",
          "title": "Label List Visibility",
          "description": "Visibility of the label in the label list (e.g., 'labelShow' or 'labelHide')."
        },
        "messageListVisibility": {
          "type": "string",
          "title": "Message List Visibility",
          "description": "Visibility of messages with the label in the message list (e.g., 'show' or 'hide')."
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

## GMAIL_CREATE_PROMPT_POST
Send a one-shot prompt to the Sanity Content Agent. Stateless one-shot prompt endpoint. No thread management or message persistence. Ideal for simple, single-turn interactions. Use when you need to send a single prompt and receive a response without maintaining conversation context.

**Input schema:**
```json
{
  "type": "object",
  "title": "CreatePromptPostRequest",
  "required": [
    "organizationId",
    "message"
  ],
  "properties": {
    "config": {
      "type": "object",
      "title": "Config",
      "description": "Agent configuration. Controls behavior, capabilities, and document access.",
      "additionalProperties": true
    },
    "format": {
      "enum": [
        "markdown",
        "directives"
      ],
      "type": "string",
      "title": "FormatType",
      "default": "markdown",
      "description": "Controls how directives in the response are formatted."
    },
    "message": {
      "type": "string",
      "title": "Message",
      "examples": [
        "Summarize my latest blog posts"
      ],
      "maxLength": 10000,
      "minLength": 1,
      "description": "The prompt message to send to the agent"
    },
    "instructions": {
      "type": "string",
      "title": "Instructions",
      "examples": [
        "Be concise and use bullet points"
      ],
      "description": "Custom instructions for the agent"
    },
    "organizationId": {
      "type": "string",
      "title": "Organization Id",
      "examples": [
        "abc123"
      ],
      "minLength": 1,
      "description": "Your Sanity organization ID"
    }
  },
  "description": "Request model for sending a one-shot prompt to the Sanity Content Agent.\nStateless endpoint - no thread management or message persistence.\nIdeal for simple, single-turn interactions."
}
```

**Output schema:**
```json
{
  "type": "object",
  "$defs": {
    "CreatePromptPostResponse": {
      "type": "object",
      "title": "CreatePromptPostResponse",
      "properties": {
        "text": {
          "type": "string",
          "title": "Text",
          "description": "The text content of the agent's response."
        },
        "usage": {
          "type": "object",
          "title": "Usage",
          "description": "Token usage statistics for the request.",
          "additionalProperties": {
            "type": "integer"
          }
        },
        "finishReason": {
          "type": "string",
          "title": "Finish Reason",
          "description": "The reason the model stopped generating (e.g., 'stop', 'length')."
        },
        "raw_response": {
          "type": "string",
          "title": "Raw Response",
          "description": "The raw response data from the API."
        }
      },
      "description": "Response model for the prompt endpoint."
    }
  },
  "title": "CreatePromptPostResponseWrapper",
  "required": [
    "data",
    "successful"
  ],
  "properties": {
    "data": {
      "type": "object",
      "title": "Data",
      "properties": {
        "text": {
          "type": "string",
          "title": "Text",
          "description": "The text content of the agent's response."
        },
        "usage": {
          "type": "object",
          "title": "Usage",
          "description": "Token usage statistics for the request.",
          "additionalProperties": {
            "type": "integer"
          }
        },
        "finishReason": {
          "type": "string",
          "title": "Finish Reason",
          "description": "The reason the model stopped generating (e.g., 'stop', 'length')."
        },
        "raw_response": {
          "type": "string",
          "title": "Raw Response",
          "description": "The raw response data from the API."
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

## GMAIL_DELETE_DRAFT
Permanently deletes a specific Gmail draft using its ID with no recovery possible; verify the correct `draft_id` and obtain explicit user confirmation before calling. Ensure the draft exists and the user has necessary permissions for the given `user_id`.

**Input schema:**
```json
{
  "type": "object",
  "title": "DeleteDraftRequest",
  "required": [
    "draft_id"
  ],
  "properties": {
    "user_id": {
      "type": "string",
      "title": "User Id",
      "default": "me",
      "examples": [
        "me",
        "user@example.com"
      ],
      "description": "User's email address or 'me' for the authenticated user; 'me' is recommended.",
      "human_parameter_name": "User ID",
      "human_parameter_description": "The email address of the user whose drafts you want to manage. Use 'me' to refer to the authenticated user."
    },
    "draft_id": {
      "type": "string",
      "title": "Draft Id",
      "examples": [
        "r-8388446164079304564",
        "r1234567890123456789"
      ],
      "description": "Immutable ID of the draft to delete. Must be obtained from GMAIL_LIST_DRAFTS or GMAIL_CREATE_EMAIL_DRAFT actions. Draft IDs typically have an 'r' prefix (e.g., 'r-1234567890' or 'r1234567890'). Draft IDs differ from message IDs used in GMAIL_BATCH_DELETE_MESSAGES \u2014 do not interchange. When multiple similar drafts exist, confirm the exact ID via GMAIL_LIST_DRAFTS before deleting.",
      "human_parameter_name": "Draft ID",
      "human_parameter_description": "The unique identifier for the draft you wish to delete. Obtain this ID from listing drafts (GMAIL_LIST_DRAFTS) or when creating a draft (GMAIL_CREATE_EMAIL_DRAFT)."
    }
  }
}
```

**Output schema:**
```json
{
  "type": "object",
  "$defs": {
    "DeleteDraftResponse": {
      "type": "object",
      "title": "DeleteDraftResponse",
      "required": [
        "success"
      ],
      "properties": {
        "success": {
          "type": "boolean",
          "title": "Success",
          "description": "Indicates whether the draft was successfully deleted."
        }
      }
    }
  },
  "title": "DeleteDraftResponseWrapper",
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
          "description": "Indicates whether the draft was successfully deleted."
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

## GMAIL_DELETE_FILTER
Tool to permanently delete a Gmail filter by its ID. Use when you need to remove an existing email filtering rule.

**Input schema:**
```json
{
  "type": "object",
  "title": "DeleteFilterRequest",
  "required": [
    "filter_id"
  ],
  "properties": {
    "user_id": {
      "type": "string",
      "title": "User Id",
      "default": "me",
      "examples": [
        "me",
        "user@example.com"
      ],
      "description": "User's email address or 'me' for the authenticated user."
    },
    "filter_id": {
      "type": "string",
      "title": "Filter Id",
      "examples": [
        "ANe1Bmhf1zE0KtM6340kAXudxukJADqVJ6jVVA",
        "ANe1BmjqK9vN_vH9dW1234567890"
      ],
      "description": "The ID of the filter to be deleted. Filter IDs can be obtained from GMAIL_LIST_FILTERS action."
    }
  }
}
```

**Output schema:**
```json
{
  "type": "object",
  "$defs": {
    "DeleteFilterResponse": {
      "type": "object",
      "title": "DeleteFilterResponse",
      "required": [
        "success"
      ],
      "properties": {
        "success": {
          "type": "boolean",
          "title": "Success",
          "description": "True if the filter was successfully deleted."
        }
      }
    }
  },
  "title": "DeleteFilterResponseWrapper",
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
          "description": "True if the filter was successfully deleted."
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

## GMAIL_DELETE_LABEL
Permanently DELETES a user-created Gmail label from the account (not from a message). WARNING: This action DELETES the label definition itself, removing it from all messages. System labels (INBOX, SENT, UNREAD, etc.) cannot be deleted. To add/remove labels from specific messages, use GMAIL_ADD_LABEL_TO_EMAIL action instead.

**Input schema:**
```json
{
  "type": "object",
  "title": "DeleteLabelRequest",
  "required": [
    "label_id"
  ],
  "properties": {
    "user_id": {
      "type": "string",
      "title": "User Id",
      "default": "me",
      "examples": [
        "me",
        "user@example.com"
      ],
      "description": "User's email address or 'me' for the authenticated user.",
      "human_parameter_name": "User ID",
      "human_parameter_description": "The email address of the user whose labels you want to manage. Use 'me' if you're accessing your own labels."
    },
    "label_id": {
      "type": "string",
      "title": "Label Id",
      "pattern": "^Label_.+$",
      "examples": [
        "Label_1",
        "Label_42"
      ],
      "description": "ID of the user-created label to be permanently DELETED from the account. Must be a custom label ID (format: 'Label_<id>' e.g., 'Label_1', 'Label_42'). System labels (INBOX, SENT, DRAFT, UNREAD, STARRED, IMPORTANT, SPAM, TRASH, CATEGORY_*, etc.) cannot be deleted. WARNING: This action permanently DELETES the label definition from your account - it does NOT remove a label from a message. To add/remove labels from messages, use GMAIL_ADD_LABEL_TO_EMAIL instead.",
      "human_parameter_name": "Label ID",
      "human_parameter_description": "The unique identifier of the custom label you wish to permanently DELETE from your Gmail account. System labels cannot be deleted. To remove a label from a message (e.g., mark as read), use GMAIL_ADD_LABEL_TO_EMAIL instead."
    }
  }
}
```

**Output schema:**
```json
{
  "type": "object",
  "$defs": {
    "DeleteLabelResponse": {
      "type": "object",
      "title": "DeleteLabelResponse",
      "required": [
        "success"
      ],
      "properties": {
        "success": {
          "type": "boolean",
          "title": "Success",
          "description": "True if the label was permanently deleted from the account."
        },
        "display_url": {
          "type": "string",
          "title": "Display Url",
          "description": "Web UI link to the Gmail labels settings page."
        }
      }
    }
  },
  "title": "DeleteLabelResponseWrapper",
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
          "description": "True if the label was permanently deleted from the account."
        },
        "display_url": {
          "type": "string",
          "title": "Display Url",
          "description": "Web UI link to the Gmail labels settings page."
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

## GMAIL_DELETE_MESSAGE
Permanently deletes a specific email message by its ID from a Gmail mailbox; for `user_id`, use 'me' for the authenticated user or an email address to which the authenticated user has delegated access.

**Input schema:**
```json
{
  "type": "object",
  "title": "DeleteMessageRequest",
  "required": [
    "message_id"
  ],
  "properties": {
    "user_id": {
      "type": "string",
      "title": "User Id",
      "default": "me",
      "examples": [
        "me",
        "user@example.com"
      ],
      "description": "User's email address. The special value 'me' refers to the authenticated user.",
      "human_parameter_name": "User ID",
      "human_parameter_description": "The email address or identifier of the user whose mailbox you want to access. Use 'me' to access your own mailbox."
    },
    "message_id": {
      "type": "string",
      "title": "Message Id",
      "examples": [
        "185120e4428ba8cf",
        "17a872b77b9e7a3b"
      ],
      "description": "Identifier of the email message to delete.",
      "human_parameter_name": "Message ID",
      "human_parameter_description": "The unique identifier of the email message you want to delete. You can find this ID from previous message searches or lists."
    }
  }
}
```

**Output schema:**
```json
{
  "type": "object",
  "$defs": {
    "DeleteMessageResponse": {
      "type": "object",
      "title": "DeleteMessageResponse",
      "required": [
        "success"
      ],
      "properties": {
        "success": {
          "type": "boolean",
          "title": "Success",
          "description": "Indicates whether the Gmail message deletion was successful"
        }
      }
    }
  },
  "title": "DeleteMessageResponseWrapper",
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
          "description": "Indicates whether the Gmail message deletion was successful"
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

## GMAIL_DELETE_THREAD
Tool to immediately and permanently delete a specified thread and all its messages. This operation cannot be undone. Use threads.trash instead for reversible deletion.

**Input schema:**
```json
{
  "type": "object",
  "title": "DeleteThreadRequest",
  "required": [
    "id"
  ],
  "properties": {
    "id": {
      "type": "string",
      "title": "Id",
      "examples": [
        "19c8e0ea407b9cf9",
        "18ea7715b619f09c"
      ],
      "description": "ID of the Thread to delete."
    },
    "user_id": {
      "type": "string",
      "title": "User Id",
      "default": "me",
      "examples": [
        "me",
        "user@example.com"
      ],
      "description": "User's email address. The special value 'me' refers to the authenticated user."
    }
  }
}
```

**Output schema:**
```json
{
  "type": "object",
  "$defs": {
    "DeleteThreadResponse": {
      "type": "object",
      "title": "DeleteThreadResponse",
      "required": [
        "success"
      ],
      "properties": {
        "success": {
          "type": "boolean",
          "title": "Success",
          "description": "Indicates whether the Gmail thread deletion was successful"
        }
      }
    }
  },
  "title": "DeleteThreadResponseWrapper",
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
          "description": "Indicates whether the Gmail thread deletion was successful"
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

## GMAIL_FETCH_EMAILS
Fetches a list of email messages from a Gmail account, supporting filtering, pagination, and optional full content retrieval. Results are NOT sorted by recency; sort by internalDate client-side. The messages field may be absent or empty (valid no-results state); always null-check before accessing messageId or threadId. Null-check subject and header fields before string operations. For large result sets, prefer ids_only=true or metadata-only listing, then hydrate via GMAIL_FETCH_MESSAGE_BY_MESSAGE_ID.

**Input schema:**
```json
{
  "type": "object",
  "title": "FetchEmailsRequest",
  "properties": {
    "query": {
      "type": "string",
      "title": "Query",
      "examples": [
        "from:john@example.com is:unread",
        "subject:meeting has:attachment",
        "after:2024/01/01 before:2024/02/01",
        "is:snoozed",
        "is:important OR is:starred",
        "label:work -label:spam"
      ],
      "description": "Gmail advanced search query (e.g., 'from:user subject:meeting'). Supported operators: 'from:', 'to:', 'subject:', 'label:', 'has:', 'is:', 'in:', 'category:', 'after:YYYY/MM/DD', 'before:YYYY/MM/DD', AND/OR/NOT. IMPORTANT - 'is:' vs 'label:' usage: Use 'is:' for special mail states: is:snoozed, is:unread, is:read, is:starred, is:important. Use 'label:' ONLY for user-created labels (e.g., 'label:work', 'label:projects'). Note: 'muted' may work with both 'is:muted' and 'label:muted' based on community reports. Common mistake: 'label:snoozed' is WRONG - use 'is:snoozed' instead. Use quotes for exact phrases. Omit for no query filter. after:/before: evaluate whole calendar days in UTC; before: is exclusive \u2014 adjust for local timezone to avoid off-by-one-day gaps.",
      "human_parameter_name": "Search query",
      "human_parameter_description": "Input a search term to filter your emails. Use 'is:' for special states (is:snoozed, is:unread, is:read, is:starred, is:important). Use 'label:' only for user-created labels (exception: 'muted' may work with both)."
    },
    "user_id": {
      "type": "string",
      "title": "User Id",
      "default": "me",
      "examples": [
        "me",
        "user@example.com"
      ],
      "description": "User's email address or 'me' for the authenticated user. Non-'me' addresses require domain-level delegation; without it, authentication or not-found errors result.",
      "human_parameter_name": "User ID",
      "human_parameter_description": "Provide the email address of the user whose mailbox you want to access. You can use 'me' to refer to your own mailbox."
    },
    "verbose": {
      "type": "boolean",
      "title": "Verbose",
      "default": true,
      "examples": [
        true,
        false
      ],
      "description": "If false, uses optimized concurrent metadata fetching for faster performance (~75% improvement). If true, uses standard detailed message fetching. When false, only essential fields (subject, sender, recipient, time, labels) are guaranteed. Body content and attachment details require verbose=true even when include_payload=true.",
      "human_parameter_name": "Verbose mode?",
      "human_parameter_description": "Select this to get detailed information for each email or to speed up the process and get just the basics."
    },
    "ids_only": {
      "type": "boolean",
      "title": "Ids Only",
      "default": false,
      "examples": [
        true,
        false
      ],
      "description": "If true, only returns message IDs from the list API without fetching individual message details. Fastest option for getting just message IDs and thread IDs.",
      "human_parameter_name": "IDs only?",
      "human_parameter_description": "Use this option if you just want the IDs of emails without loading their full details, making the request quicker."
    },
    "label_ids": {
      "type": "array",
      "items": {
        "type": "string"
      },
      "title": "Label Ids",
      "examples": [
        "INBOX",
        "UNREAD",
        "Label_123456"
      ],
      "description": "Filter by label IDs; only messages with all specified labels are returned (AND logic). Optional - omit or use empty list to fetch all messages without label filtering. System label IDs: 'INBOX', 'SPAM', 'TRASH', 'UNREAD', 'STARRED', 'IMPORTANT', 'CATEGORY_PRIMARY' (alias 'CATEGORY_PERSONAL'), 'CATEGORY_SOCIAL', 'CATEGORY_PROMOTIONS', 'CATEGORY_UPDATES', 'CATEGORY_FORUMS'. For custom/user-created labels, you MUST use the label ID (e.g., 'Label_123456'), NOT the display name. Use the 'listLabels' action to find label IDs for custom labels. Combining label_ids with label: in query applies AND logic across both, which can silently over-restrict results; use one strategy consistently.",
      "human_parameter_name": "Label IDs",
      "human_parameter_description": "List the label IDs to filter which messages to fetch. System labels (INBOX, SPAM, etc.) can be used directly by name. For custom labels, you must use the listLabels action first to get the label ID - do not use the label name you see in Gmail."
    },
    "page_token": {
      "type": "string",
      "title": "Page Token",
      "description": "Token for retrieving a specific page, obtained from a previous response's `nextPageToken`. Must be a valid opaque token string from a previous API response. Do not pass arbitrary values. Omit for the first page. Loop calls using nextPageToken until it is absent to avoid silently missing messages. resultSizeEstimate is approximate \u2014 do not use as a stopping condition.",
      "human_parameter_name": "Page token",
      "human_parameter_description": "If you've paginated results, use this token to get the next set of messages. Leave blank for the first page."
    },
    "max_results": {
      "type": "integer",
      "title": "Max Results",
      "default": 1,
      "maximum": 500,
      "minimum": 1,
      "examples": [
        "10",
        "100",
        "500"
      ],
      "description": "Maximum number of messages to retrieve per page. Default of 1 retrieves only a single message; set higher for practical use. Hard cap is 500 per page.",
      "human_parameter_name": "Maximum results",
      "human_parameter_description": "Specify how many email messages you want to retrieve in one request, from 1 to 500."
    },
    "include_payload": {
      "type": "boolean",
      "title": "Include Payload",
      "default": true,
      "examples": [
        true,
        false
      ],
      "description": "Set to true to include full message payload (headers, body, attachments); false for metadata only. payload may still be null even when true; use GMAIL_FETCH_MESSAGE_BY_MESSAGE_ID for guaranteed complete content. When payload is present, bodies are base64url-encoded in payload.parts; replace '-'\u2192'+' and '_'\u2192'/' and fix padding before decoding, and check both text/plain and text/html parts.",
      "human_parameter_name": "Include full payload?",
      "human_parameter_description": "Choose whether to get the full content of each email, including attachments and body, or just the essential metadata."
    },
    "include_spam_trash": {
      "type": "boolean",
      "title": "Include Spam Trash",
      "default": false,
      "examples": [
        true,
        false
      ],
      "description": "Set to true to include messages from 'SPAM' and 'TRASH'.",
      "human_parameter_name": "Include spam and trash?",
      "human_parameter_description": "Decide if you want to see emails that are normally filtered into your SPAM or TRASH folders."
    }
  }
}
```

**Output schema:**
```json
{
  "type": "object",
  "$defs": {
    "MessageBody": {
      "type": "object",
      "title": "MessageBody",
      "properties": {
        "to": {
          "type": "string",
          "title": "To",
          "description": "The recipient of the message"
        },
        "sender": {
          "type": "string",
          "title": "Sender",
          "description": "The sender of the message"
        },
        "payload": {
          "type": "object",
          "title": "Payload",
          "description": "The payload of the message",
          "additionalProperties": true
        },
        "preview": {
          "type": "object",
          "title": "Preview",
          "description": "The preview of the message",
          "additionalProperties": true
        },
        "subject": {
          "type": "string",
          "title": "Subject",
          "description": "The subject of the message"
        },
        "labelIds": {
          "type": "array",
          "items": {},
          "title": "Label Ids",
          "description": "The label IDs of the message"
        },
        "threadId": {
          "type": "string",
          "title": "Thread Id",
          "description": "The thread ID of the message"
        },
        "messageId": {
          "type": "string",
          "title": "Message Id",
          "description": "The message ID of the message"
        },
        "display_url": {
          "type": "string",
          "title": "Display Url",
          "description": "Web UI link for this resource - clickable URL pointing to the Gmail web interface"
        },
        "messageText": {
          "type": "string",
          "title": "Message Text",
          "description": "The text of the message"
        },
        "attachmentList": {
          "type": "array",
          "items": {},
          "title": "Attachment List",
          "description": "The list of attachments"
        },
        "messageTimestamp": {
          "type": "string",
          "title": "Message Timestamp",
          "description": "The timestamp of the message"
        }
      },
      "description": "This model represents the body a Gmail message."
    },
    "FetchEmailsResponse": {
      "type": "object",
      "title": "FetchEmailsResponse",
      "required": [
        "nextPageToken",
        "resultSizeEstimate",
        "messages"
      ],
      "properties": {
        "messages": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "MessageBody",
            "properties": {
              "to": {
                "type": "string",
                "title": "To",
                "description": "The recipient of the message"
              },
              "sender": {
                "type": "string",
                "title": "Sender",
                "description": "The sender of the message"
              },
              "payload": {
                "type": "object",
                "title": "Payload",
                "description": "The payload of the message",
                "additionalProperties": true
              },
              "preview": {
                "type": "object",
                "title": "Preview",
                "description": "The preview of the message",
                "additionalProperties": true
              },
              "subject": {
                "type": "string",
                "title": "Subject",
                "description": "The subject of the message"
              },
              "labelIds": {
                "type": "array",
                "items": {},
                "title": "Label Ids",
                "description": "The label IDs of the message"
              },
              "threadId": {
                "type": "string",
                "title": "Thread Id",
                "description": "The thread ID of the message"
              },
              "messageId": {
                "type": "string",
                "title": "Message Id",
                "description": "The message ID of the message"
              },
              "display_url": {
                "type": "string",
                "title": "Display Url",
                "description": "Web UI link for this resource - clickable URL pointing to the Gmail web interface"
              },
              "messageText": {
                "type": "string",
                "title": "Message Text",
                "description": "The text of the message"
              },
              "attachmentList": {
                "type": "array",
                "items": {},
                "title": "Attachment List",
                "description": "The list of attachments"
              },
              "messageTimestamp": {
                "type": "string",
                "title": "Message Timestamp",
                "description": "The timestamp of the message"
              }
            },
            "description": "This model represents the body a Gmail message."
          },
          "title": "Messages",
          "description": "List of retrieved email messages. Includes full content if `include_payload` was true, otherwise metadata."
        },
        "nextPageToken": {
          "type": "string",
          "title": "Next Page Token",
          "description": "Token for the next page of results; use in subsequent `page_token` request. Empty if no more results."
        },
        "resultSizeEstimate": {
          "type": "integer",
          "title": "Result Size Estimate",
          "description": "Estimated total messages matching the query (not just this page)."
        },
        "composio_execution_message": {
          "type": "string",
          "title": "Composio Execution Message",
          "description": "Helpful guidance message when search returns empty results. Contains hints about potential query issues like future dates, narrow time windows, or complex queries."
        }
      }
    }
  },
  "title": "FetchEmailsResponseWrapper",
  "required": [
    "data",
    "successful"
  ],
  "properties": {
    "data": {
      "type": "object",
      "title": "Data",
      "required": [
        "nextPageToken",
        "resultSizeEstimate",
        "messages"
      ],
      "properties": {
        "messages": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "MessageBody",
            "properties": {
              "to": {
                "type": "string",
                "title": "To",
                "description": "The recipient of the message"
              },
              "sender": {
                "type": "string",
                "title": "Sender",
                "description": "The sender of the message"
              },
              "payload": {
                "type": "object",
                "title": "Payload",
                "description": "The payload of the message",
                "additionalProperties": true
              },
              "preview": {
                "type": "object",
                "title": "Preview",
                "description": "The preview of the message",
                "additionalProperties": true
              },
              "subject": {
                "type": "string",
                "title": "Subject",
                "description": "The subject of the message"
              },
              "labelIds": {
                "type": "array",
                "items": {},
                "title": "Label Ids",
                "description": "The label IDs of the message"
              },
              "threadId": {
                "type": "string",
                "title": "Thread Id",
                "description": "The thread ID of the message"
              },
              "messageId": {
                "type": "string",
                "title": "Message Id",
                "description": "The message ID of the message"
              },
              "display_url": {
                "type": "string",
                "title": "Display Url",
                "description": "Web UI link for this resource - clickable URL pointing to the Gmail web interface"
              },
              "messageText": {
                "type": "string",
                "title": "Message Text",
                "description": "The text of the message"
              },
              "attachmentList": {
                "type": "array",
                "items": {},
                "title": "Attachment List",
                "description": "The list of attachments"
              },
              "messageTimestamp": {
                "type": "string",
                "title": "Message Timestamp",
                "description": "The timestamp of the message"
              }
            },
            "description": "This model represents the body a Gmail message."
          },
          "title": "Messages",
          "description": "List of retrieved email messages. Includes full content if `include_payload` was true, otherwise metadata."
        },
        "nextPageToken": {
          "type": "string",
          "title": "Next Page Token",
          "description": "Token for the next page of results; use in subsequent `page_token` request. Empty if no more results."
        },
        "resultSizeEstimate": {
          "type": "integer",
          "title": "Result Size Estimate",
          "description": "Estimated total messages matching the query (not just this page)."
        },
        "composio_execution_message": {
          "type": "string",
          "title": "Composio Execution Message",
          "description": "Helpful guidance message when search returns empty results. Contains hints about potential query issues like future dates, narrow time windows, or complex queries."
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

## GMAIL_FETCH_MESSAGE_BY_MESSAGE_ID
Fetches a specific email message by its ID, provided the `message_id` exists and is accessible to the authenticated `user_id`. Spam/trash messages are excluded unless upstream list/search calls used `include_spam_trash=true`. Use `internalDate` (milliseconds since epoch) rather than header `Date` for recency checks.

**Input schema:**
```json
{
  "type": "object",
  "title": "FetchMessageByMessageIdRequest",
  "required": [
    "message_id"
  ],
  "properties": {
    "format": {
      "type": "string",
      "title": "Format",
      "default": "full",
      "examples": [
        "minimal",
        "full",
        "raw",
        "metadata"
      ],
      "description": "Format for message content: 'minimal' (ID/labels), 'full' (complete data), 'raw' (base64url string), 'metadata' (ID/labels/headers). With 'full', body content is base64url-encoded; decode `payload.body.data` or inspect `payload.parts` for multipart messages, replacing `-`/`_` and adding padding before decoding.",
      "human_parameter_name": "Format",
      "human_parameter_description": "The way you want the email content to be formatted. Choose how much detail you want in the response."
    },
    "user_id": {
      "type": "string",
      "title": "User Id",
      "default": "me",
      "examples": [
        "user@example.com",
        "me"
      ],
      "description": "User's email address or 'me' for the authenticated user.",
      "human_parameter_name": "User ID",
      "human_parameter_description": "The email address or identifier of the user whose mailbox you want to access. Use 'me' to access your own mailbox."
    },
    "message_id": {
      "type": "string",
      "title": "Message Id",
      "examples": [
        "19b11732c1b578fd",
        "18c5e5b5f5d5e5b5",
        "1736ccf5d7b4d452"
      ],
      "minLength": 1,
      "description": "The Gmail API message ID (hexadecimal string, typically 15-16 characters like '19b11732c1b578fd'). Must be obtained from Gmail API responses (e.g., List Messages, Search Messages). Do NOT use email subjects, dates, sender names, or custom identifiers. Do NOT use `threadId` (use GMAIL_FETCH_MESSAGE_BY_THREAD_ID for threads), the Message-ID email header, or any fabricated value \u2014 only IDs from Gmail API list/search responses.",
      "human_parameter_name": "Message ID",
      "human_parameter_description": "The unique identifier of the email message you want to fetch. You'll use this ID to tell the system which specific email to retrieve."
    }
  }
}
```

**Output schema:**
```json
{
  "type": "object",
  "$defs": {
    "MessageBody": {
      "type": "object",
      "title": "MessageBody",
      "properties": {
        "to": {
          "type": "string",
          "title": "To",
          "description": "The recipient of the message"
        },
        "sender": {
          "type": "string",
          "title": "Sender",
          "description": "The sender of the message"
        },
        "payload": {
          "type": "object",
          "title": "Payload",
          "description": "The payload of the message",
          "additionalProperties": true
        },
        "preview": {
          "type": "object",
          "title": "Preview",
          "description": "The preview of the message",
          "additionalProperties": true
        },
        "subject": {
          "type": "string",
          "title": "Subject",
          "description": "The subject of the message"
        },
        "labelIds": {
          "type": "array",
          "items": {},
          "title": "Label Ids",
          "description": "The label IDs of the message"
        },
        "threadId": {
          "type": "string",
          "title": "Thread Id",
          "description": "The thread ID of the message"
        },
        "messageId": {
          "type": "string",
          "title": "Message Id",
          "description": "The message ID of the message"
        },
        "display_url": {
          "type": "string",
          "title": "Display Url",
          "description": "Web UI link for this resource - clickable URL pointing to the Gmail web interface"
        },
        "messageText": {
          "type": "string",
          "title": "Message Text",
          "description": "The text of the message"
        },
        "attachmentList": {
          "type": "array",
          "items": {},
          "title": "Attachment List",
          "description": "The list of attachments"
        },
        "messageTimestamp": {
          "type": "string",
          "title": "Message Timestamp",
          "description": "The timestamp of the message"
        }
      },
      "description": "This model represents the body a Gmail message."
    }
  },
  "title": "MessageBodyWrapper",
  "required": [
    "data",
    "successful"
  ],
  "properties": {
    "data": {
      "type": "object",
      "title": "Data",
      "properties": {
        "to": {
          "type": "string",
          "title": "To",
          "description": "The recipient of the message"
        },
        "sender": {
          "type": "string",
          "title": "Sender",
          "description": "The sender of the message"
        },
        "payload": {
          "type": "object",
          "title": "Payload",
          "description": "The payload of the message",
          "additionalProperties": true
        },
        "preview": {
          "type": "object",
          "title": "Preview",
          "description": "The preview of the message",
          "additionalProperties": true
        },
        "subject": {
          "type": "string",
          "title": "Subject",
          "description": "The subject of the message"
        },
        "labelIds": {
          "type": "array",
          "items": {},
          "title": "Label Ids",
          "description": "The label IDs of the message"
        },
        "threadId": {
          "type": "string",
          "title": "Thread Id",
          "description": "The thread ID of the message"
        },
        "messageId": {
          "type": "string",
          "title": "Message Id",
          "description": "The message ID of the message"
        },
        "display_url": {
          "type": "string",
          "title": "Display Url",
          "description": "Web UI link for this resource - clickable URL pointing to the Gmail web interface"
        },
        "messageText": {
          "type": "string",
          "title": "Message Text",
          "description": "The text of the message"
        },
        "attachmentList": {
          "type": "array",
          "items": {},
          "title": "Attachment List",
          "description": "The list of attachments"
        },
        "messageTimestamp": {
          "type": "string",
          "title": "Message Timestamp",
          "description": "The timestamp of the message"
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

## GMAIL_FETCH_MESSAGE_BY_THREAD_ID
Retrieves messages from a Gmail thread using its `thread_id`, where the thread must be accessible by the specified `user_id`. Returns a `messages` array; `thread_id` is not echoed in the response. Message order is not guaranteed — sort by `internalDate` to find oldest/newest. Check `labelIds` per message to filter drafts. Concurrent bulk calls may trigger 403 `userRateLimitExceeded` or 429; cap concurrency ~10 and use exponential backoff.

**Input schema:**
```json
{
  "type": "object",
  "title": "FetchMessageByThreadIdRequest",
  "required": [
    "thread_id"
  ],
  "properties": {
    "user_id": {
      "type": "string",
      "title": "User Id",
      "default": "me",
      "examples": [
        "me",
        "user@example.com"
      ],
      "description": "The email address of the user.",
      "human_parameter_name": "User ID",
      "human_parameter_description": "The email address or identifier of the user whose mailbox you want to access. Use 'me' to access your own mailbox."
    },
    "thread_id": {
      "type": "string",
      "title": "Thread Id",
      "examples": [
        "19bf77729bcb3a44",
        "msg-f:19bf77729bcb3a44"
      ],
      "description": "Hexadecimal thread ID from Gmail API (e.g., '19bf77729bcb3a44'). Obtain from GMAIL_LIST_THREADS or GMAIL_FETCH_EMAILS. Prefixes like 'msg-f:' or 'thread-f:' are auto-stripped. Legacy Gmail web UI IDs (e.g., 'FMfcgzQfBZdVqKZcSVBhqwWLKWCtDdWQ') are NOT supported - use the API thread ID instead. Deduplicate thread_ids before calling when multiple listed messages share the same threadId to avoid redundant calls.",
      "human_parameter_name": "Thread ID",
      "human_parameter_description": "The unique hexadecimal identifier of the email thread (e.g., '19bf77729bcb3a44'). Obtain this from GMAIL_LIST_THREADS or GMAIL_FETCH_EMAILS actions. Legacy Gmail web UI IDs are not supported."
    },
    "page_token": {
      "type": "string",
      "title": "Page Token",
      "default": "",
      "examples": [
        "CiAKGhIKJdealEffectivelyPageToken"
      ],
      "description": "Opaque page token for fetching a specific page of messages if results are paginated. Iterate calls by passing the returned `nextPageToken` until it is absent; stopping early will miss messages in long threads.",
      "human_parameter_name": "Page Token",
      "human_parameter_description": "Use this token to navigate to a specific set of messages if there are many. It helps in paginating through results."
    }
  }
}
```

**Output schema:**
```json
{
  "type": "object",
  "$defs": {
    "MessageBody": {
      "type": "object",
      "title": "MessageBody",
      "properties": {
        "to": {
          "type": "string",
          "title": "To",
          "description": "The recipient of the message"
        },
        "sender": {
          "type": "string",
          "title": "Sender",
          "description": "The sender of the message"
        },
        "payload": {
          "type": "object",
          "title": "Payload",
          "description": "The payload of the message",
          "additionalProperties": true
        },
        "preview": {
          "type": "object",
          "title": "Preview",
          "description": "The preview of the message",
          "additionalProperties": true
        },
        "subject": {
          "type": "string",
          "title": "Subject",
          "description": "The subject of the message"
        },
        "labelIds": {
          "type": "array",
          "items": {},
          "title": "Label Ids",
          "description": "The label IDs of the message"
        },
        "threadId": {
          "type": "string",
          "title": "Thread Id",
          "description": "The thread ID of the message"
        },
        "messageId": {
          "type": "string",
          "title": "Message Id",
          "description": "The message ID of the message"
        },
        "display_url": {
          "type": "string",
          "title": "Display Url",
          "description": "Web UI link for this resource - clickable URL pointing to the Gmail web interface"
        },
        "messageText": {
          "type": "string",
          "title": "Message Text",
          "description": "The text of the message"
        },
        "attachmentList": {
          "type": "array",
          "items": {},
          "title": "Attachment List",
          "description": "The list of attachments"
        },
        "messageTimestamp": {
          "type": "string",
          "title": "Message Timestamp",
          "description": "The timestamp of the message"
        }
      },
      "description": "This model represents the body a Gmail message."
    },
    "FetchMessageByThreadIdResponse": {
      "type": "object",
      "title": "FetchMessageByThreadIdResponse",
      "required": [
        "messages"
      ],
      "properties": {
        "messages": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "MessageBody",
            "properties": {
              "to": {
                "type": "string",
                "title": "To",
                "description": "The recipient of the message"
              },
              "sender": {
                "type": "string",
                "title": "Sender",
                "description": "The sender of the message"
              },
              "payload": {
                "type": "object",
                "title": "Payload",
                "description": "The payload of the message",
                "additionalProperties": true
              },
              "preview": {
                "type": "object",
                "title": "Preview",
                "description": "The preview of the message",
                "additionalProperties": true
              },
              "subject": {
                "type": "string",
                "title": "Subject",
                "description": "The subject of the message"
              },
              "labelIds": {
                "type": "array",
                "items": {},
                "title": "Label Ids",
                "description": "The label IDs of the message"
              },
              "threadId": {
                "type": "string",
                "title": "Thread Id",
                "description": "The thread ID of the message"
              },
              "messageId": {
                "type": "string",
                "title": "Message Id",
                "description": "The message ID of the message"
              },
              "display_url": {
                "type": "string",
                "title": "Display Url",
                "description": "Web UI link for this resource - clickable URL pointing to the Gmail web interface"
              },
              "messageText": {
                "type": "string",
                "title": "Message Text",
                "description": "The text of the message"
              },
              "attachmentList": {
                "type": "array",
                "items": {},
                "title": "Attachment List",
                "description": "The list of attachments"
              },
              "messageTimestamp": {
                "type": "string",
                "title": "Message Timestamp",
                "description": "The timestamp of the message"
              }
            },
            "description": "This model represents the body a Gmail message."
          },
          "title": "Messages",
          "description": "List of messages in the thread."
        },
        "threadId": {
          "type": "string",
          "title": "Thread Id",
          "description": "The ID of the thread."
        },
        "historyId": {
          "type": "string",
          "title": "History Id",
          "description": "The ID of the last history record that modified this thread."
        },
        "display_url": {
          "type": "string",
          "title": "Display Url",
          "description": "Web UI link to view this thread in Gmail."
        }
      }
    }
  },
  "title": "FetchMessageByThreadIdResponseWrapper",
  "required": [
    "data",
    "successful"
  ],
  "properties": {
    "data": {
      "type": "object",
      "title": "Data",
      "required": [
        "messages"
      ],
      "properties": {
        "messages": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "MessageBody",
            "properties": {
              "to": {
                "type": "string",
                "title": "To",
                "description": "The recipient of the message"
              },
              "sender": {
                "type": "string",
                "title": "Sender",
                "description": "The sender of the message"
              },
              "payload": {
                "type": "object",
                "title": "Payload",
                "description": "The payload of the message",
                "additionalProperties": true
              },
              "preview": {
                "type": "object",
                "title": "Preview",
                "description": "The preview of the message",
                "additionalProperties": true
              },
              "subject": {
                "type": "string",
                "title": "Subject",
                "description": "The subject of the message"
              },
              "labelIds": {
                "type": "array",
                "items": {},
                "title": "Label Ids",
                "description": "The label IDs of the message"
              },
              "threadId": {
                "type": "string",
                "title": "Thread Id",
                "description": "The thread ID of the message"
              },
              "messageId": {
                "type": "string",
                "title": "Message Id",
                "description": "The message ID of the message"
              },
              "display_url": {
                "type": "string",
                "title": "Display Url",
                "description": "Web UI link for this resource - clickable URL pointing to the Gmail web interface"
              },
              "messageText": {
                "type": "string",
                "title": "Message Text",
                "description": "The text of the message"
              },
              "attachmentList": {
                "type": "array",
                "items": {},
                "title": "Attachment List",
                "description": "The list of attachments"
              },
              "messageTimestamp": {
                "type": "string",
                "title": "Message Timestamp",
                "description": "The timestamp of the message"
              }
            },
            "description": "This model represents the body a Gmail message."
          },
          "title": "Messages",
          "description": "List of messages in the thread."
        },
        "threadId": {
          "type": "string",
          "title": "Thread Id",
          "description": "The ID of the thread."
        },
        "historyId": {
          "type": "string",
          "title": "History Id",
          "description": "The ID of the last history record that modified this thread."
        },
        "display_url": {
          "type": "string",
          "title": "Display Url",
          "description": "Web UI link to view this thread in Gmail."
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

## GMAIL_FORWARD_MESSAGE
Forward an existing Gmail message to specified recipients, preserving original body and attachments. Verify recipients and content before forwarding to avoid unintended exposure. Bulk forwarding may trigger 429/5xx rate limits; keep concurrency to 5–10 and apply backoff. Messages near Gmail's size limits may fail; reconstruct a smaller draft if needed.

**Input schema:**
```json
{
  "type": "object",
  "title": "ForwardMessageRequest",
  "required": [
    "message_id",
    "recipients"
  ],
  "properties": {
    "cc": {
      "type": "array",
      "items": {
        "type": "string"
      },
      "title": "Cc",
      "examples": [
        [
          "cc1@example.com",
          "cc2@example.com"
        ]
      ],
      "description": "List of email addresses to CC.",
      "human_parameter_name": "CC",
      "human_parameter_description": "Email addresses to include in the CC (carbon copy) field. This is optional."
    },
    "bcc": {
      "type": "array",
      "items": {
        "type": "string"
      },
      "title": "Bcc",
      "examples": [
        [
          "bcc1@example.com",
          "bcc2@example.com"
        ]
      ],
      "description": "List of email addresses to BCC.",
      "human_parameter_name": "BCC",
      "human_parameter_description": "Email addresses to include in the BCC (blind carbon copy) field. This is optional."
    },
    "user_id": {
      "type": "string",
      "title": "User Id",
      "default": "me",
      "examples": [
        "me",
        "user@example.com"
      ],
      "description": "User's email address or 'me' for the authenticated user.",
      "human_parameter_name": "User ID",
      "human_parameter_description": "The email address or identifier of the user whose mailbox you want to access. Use 'me' to access your own mailbox."
    },
    "message_id": {
      "type": "string",
      "title": "Message Id",
      "pattern": "^[0-9a-fA-F]+$",
      "examples": [
        "17f45ec49a9c3f1b"
      ],
      "maxLength": 20,
      "minLength": 10,
      "description": "Gmail message ID (hexadecimal string, e.g., '17f45ec49a9c3f1b'). Must contain only hex characters [0-9a-fA-F]. Obtain this from actions like 'List Messages' or 'Fetch Emails'.",
      "human_parameter_name": "Message ID",
      "human_parameter_description": "The unique identifier of the email message you want to forward. You can get this from a previous message search or list operation."
    },
    "recipients": {
      "type": "array",
      "items": {
        "type": "string"
      },
      "title": "Recipients",
      "examples": [
        [
          "john.doe@example.com",
          "jane.smith@example.com"
        ]
      ],
      "minItems": 1,
      "description": "List of email addresses to forward the message to.",
      "human_parameter_name": "Recipients",
      "human_parameter_description": "The email addresses of the people you want to send the forwarded message to. Provide at least one email address."
    },
    "additional_text": {
      "type": "string",
      "title": "Additional Text",
      "examples": [
        "Please see the forwarded message below."
      ],
      "description": "Optional additional text to include before the forwarded content.",
      "human_parameter_name": "Additional Text",
      "human_parameter_description": "Any extra message you want to include before the forwarded email content. This is optional."
    }
  }
}
```

**Output schema:**
```json
{
  "type": "object",
  "$defs": {
    "GmailMessageResponse": {
      "type": "object",
      "title": "GmailMessageResponse",
      "properties": {
        "id": {
          "type": "string",
          "title": "Id",
          "description": "The immutable ID of the sent message."
        },
        "raw": {
          "type": "string",
          "title": "Raw",
          "description": "The entire email message in RFC 2822 format, base64url-encoded."
        },
        "payload": {
          "type": "object",
          "title": "Payload",
          "description": "The parsed email structure, including headers and body parts.",
          "additionalProperties": true
        },
        "snippet": {
          "type": "string",
          "title": "Snippet",
          "description": "A short extract of the message text."
        },
        "labelIds": {
          "type": "array",
          "items": {
            "type": "string"
          },
          "title": "Label Ids",
          "description": "List of IDs of labels applied to this message."
        },
        "threadId": {
          "type": "string",
          "title": "Thread Id",
          "description": "The ID of the thread the message belongs to."
        },
        "historyId": {
          "type": "string",
          "title": "History Id",
          "description": "The ID of the last history record that modified this message."
        },
        "display_url": {
          "type": "string",
          "title": "Display Url",
          "description": "Web UI link for this resource - set by each action's execute()."
        },
        "internalDate": {
          "type": "string",
          "title": "Internal Date",
          "description": "The internal timestamp of the message in milliseconds since epoch."
        },
        "sizeEstimate": {
          "type": "integer",
          "title": "Size Estimate",
          "description": "Estimated size of the message in bytes."
        }
      },
      "description": "Standard Gmail message response returned by Gmail API for sent messages.\nUsed by actions like send_email and send_draft."
    }
  },
  "title": "GmailMessageResponseWrapper",
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
          "description": "The immutable ID of the sent message."
        },
        "raw": {
          "type": "string",
          "title": "Raw",
          "description": "The entire email message in RFC 2822 format, base64url-encoded."
        },
        "payload": {
          "type": "object",
          "title": "Payload",
          "description": "The parsed email structure, including headers and body parts.",
          "additionalProperties": true
        },
        "snippet": {
          "type": "string",
          "title": "Snippet",
          "description": "A short extract of the message text."
        },
        "labelIds": {
          "type": "array",
          "items": {
            "type": "string"
          },
          "title": "Label Ids",
          "description": "List of IDs of labels applied to this message."
        },
        "threadId": {
          "type": "string",
          "title": "Thread Id",
          "description": "The ID of the thread the message belongs to."
        },
        "historyId": {
          "type": "string",
          "title": "History Id",
          "description": "The ID of the last history record that modified this message."
        },
        "display_url": {
          "type": "string",
          "title": "Display Url",
          "description": "Web UI link for this resource - set by each action's execute()."
        },
        "internalDate": {
          "type": "string",
          "title": "Internal Date",
          "description": "The internal timestamp of the message in milliseconds since epoch."
        },
        "sizeEstimate": {
          "type": "integer",
          "title": "Size Estimate",
          "description": "Estimated size of the message in bytes."
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

## GMAIL_GET_ATTACHMENT
Retrieves a specific attachment by ID from a message in a user's Gmail mailbox, requiring valid message and attachment IDs. Returns base64url-encoded binary data (up to ~25 MB); the downloaded file location is at data.file.s3url (also exposes mimetype and name; no s3key). Attachments exceeding ~25 MB may be exposed as Google Drive links — use GOOGLEDRIVE_DOWNLOAD_FILE when a Drive file_id is present instead.

**Input schema:**
```json
{
  "type": "object",
  "title": "GetAttachmentRequest",
  "required": [
    "message_id",
    "attachment_id",
    "file_name"
  ],
  "properties": {
    "user_id": {
      "type": "string",
      "title": "User Id",
      "default": "me",
      "examples": [
        "me",
        "user@example.com"
      ],
      "description": "User's email address ('me' for authenticated user).",
      "human_parameter_name": "User ID",
      "human_parameter_description": "The email address or identifier of the user whose mailbox you want to access. Use 'me' to access your own mailbox."
    },
    "file_name": {
      "type": "string",
      "title": "File Name",
      "examples": [
        "invoice.pdf",
        "report.docx"
      ],
      "minLength": 1,
      "description": "Desired filename for the downloaded attachment. This is a required string field - do not pass null.",
      "human_parameter_name": "File Name",
      "human_parameter_description": "The name you want to give the file once it's downloaded. This helps you easily identify the attachment later."
    },
    "message_id": {
      "type": "string",
      "title": "Message Id",
      "examples": [
        "18exampleMessageId7f9"
      ],
      "minLength": 1,
      "description": "Immutable ID of the message containing the attachment. This is a required string field - do not pass null. Obtain the message_id from Gmail API responses (e.g., fetchEmails, listThreads).",
      "human_parameter_name": "Message ID",
      "human_parameter_description": "The unique identifier of the email message that contains the attachment you want to retrieve."
    },
    "attachment_id": {
      "type": "string",
      "title": "Attachment Id",
      "examples": [
        "ANGjdJ8sZ7example1234",
        "A_PART0.1_18exampleAttachmentId7f9"
      ],
      "minLength": 1,
      "description": "The internal Gmail attachment ID (NOT the filename). This is a system-generated token string like 'ANGjdJ8s...'. Obtain this ID from the 'attachmentId' field in the 'attachmentList' array returned by fetchEmails or fetchMessageByMessageId actions. Do NOT pass the filename (e.g., 'report.pdf'). Requires a fully hydrated message payload: call GMAIL_FETCH_MESSAGE_BY_MESSAGE_ID with format='full' to obtain valid attachment IDs \u2014 lightweight fetch modes may omit attachmentList entirely.",
      "human_parameter_name": "Attachment ID",
      "human_parameter_description": "The unique Gmail attachment ID token (NOT the filename). This is a system-generated ID string obtained from the 'attachmentId' field in message attachment lists. First fetch the email using fetchEmails or fetchMessageByMessageId to get the attachmentId, then use it here."
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
    "GetAttachmentResponse": {
      "type": "object",
      "title": "GetAttachmentResponse",
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
          "description": "Object containing metadata and URL for the retrieved attachment."
        },
        "display_url": {
          "type": "string",
          "title": "Display Url",
          "description": "Web UI link to the parent message containing this attachment."
        }
      }
    }
  },
  "title": "GetAttachmentResponseWrapper",
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
          "description": "Object containing metadata and URL for the retrieved attachment."
        },
        "display_url": {
          "type": "string",
          "title": "Display Url",
          "description": "Web UI link to the parent message containing this attachment."
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

## GMAIL_GET_AUTO_FORWARDING
Tool to get the auto-forwarding setting for the specified account. Use when you need to retrieve the current auto-forwarding configuration including enabled status, forwarding email address, and message disposition.

**Input schema:**
```json
{
  "type": "object",
  "title": "GetAutoForwardingRequest",
  "properties": {
    "user_id": {
      "type": "string",
      "title": "User Id",
      "default": "me",
      "examples": [
        "me",
        "user@example.com"
      ],
      "description": "The user's email address. The special value 'me' can be used to indicate the authenticated user."
    }
  }
}
```

**Output schema:**
```json
{
  "type": "object",
  "$defs": {
    "GetAutoForwardingResponse": {
      "type": "object",
      "title": "GetAutoForwardingResponse",
      "properties": {
        "enabled": {
          "type": "boolean",
          "title": "Enabled",
          "description": "Whether all incoming mail is automatically forwarded to another address."
        },
        "disposition": {
          "enum": [
            "dispositionUnspecified",
            "leaveInInbox",
            "archive",
            "trash",
            "markRead"
          ],
          "type": "string",
          "title": "Disposition",
          "description": "The state that a message should be left in after it has been forwarded. Possible values: 'dispositionUnspecified' (unspecified disposition), 'leaveInInbox' (leave the message in the INBOX), 'archive' (archive the message), 'trash' (move the message to the TRASH), 'markRead' (leave the message in the INBOX and mark it as read)."
        },
        "emailAddress": {
          "type": "string",
          "title": "Email Address",
          "description": "Email address to which all incoming messages are forwarded. This email address must be a verified member of the forwarding addresses."
        }
      },
      "description": "Auto-forwarding configuration for the Gmail account."
    }
  },
  "title": "GetAutoForwardingResponseWrapper",
  "required": [
    "data",
    "successful"
  ],
  "properties": {
    "data": {
      "type": "object",
      "title": "Data",
      "properties": {
        "enabled": {
          "type": "boolean",
          "title": "Enabled",
          "description": "Whether all incoming mail is automatically forwarded to another address."
        },
        "disposition": {
          "enum": [
            "dispositionUnspecified",
            "leaveInInbox",
            "archive",
            "trash",
            "markRead"
          ],
          "type": "string",
          "title": "Disposition",
          "description": "The state that a message should be left in after it has been forwarded. Possible values: 'dispositionUnspecified' (unspecified disposition), 'leaveInInbox' (leave the message in the INBOX), 'archive' (archive the message), 'trash' (move the message to the TRASH), 'markRead' (leave the message in the INBOX and mark it as read)."
        },
        "emailAddress": {
          "type": "string",
          "title": "Email Address",
          "description": "Email address to which all incoming messages are forwarded. This email address must be a verified member of the forwarding addresses."
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

## GMAIL_GET_CONTACTS
Fetches contacts (connections) for the authenticated Google account, allowing selection of specific data fields and pagination. Only covers saved contacts and 'Other Contacts'; email-header-only senders are out of scope. Contact records may have sparse data — handle missing fields gracefully. People API shares a per-user QPS quota; HTTP 429 requires exponential backoff (1s, 2s, 4s).

**Input schema:**
```json
{
  "type": "object",
  "title": "GetContactsRequest",
  "properties": {
    "page_token": {
      "type": "string",
      "title": "Page Token",
      "description": "Token to retrieve a specific page of results, obtained from 'nextPageToken' in a previous response. Repeat calls with each successive `nextPageToken` until it is absent \u2014 stopping early silently omits contacts.",
      "human_parameter_name": "Page Token",
      "human_parameter_description": "Use this token to fetch a specific page of results. It helps you navigate through large sets of contacts."
    },
    "person_fields": {
      "type": "string",
      "title": "Person Fields",
      "default": "emailAddresses,names,birthdays,genders",
      "examples": [
        "addresses",
        "ageRanges",
        "biographies",
        "birthdays",
        "coverPhotos",
        "emailAddresses",
        "events",
        "genders",
        "imClients",
        "interests",
        "locales",
        "memberships",
        "metadata",
        "names",
        "nicknames",
        "occupations",
        "organizations",
        "phoneNumbers",
        "photos",
        "relations",
        "residences",
        "sipAddresses",
        "skills",
        "urls",
        "userDefined"
      ],
      "description": "Comma-separated person fields to retrieve for each contact (e.g., 'names,emailAddresses').",
      "human_parameter_name": "Person Fields",
      "human_parameter_description": "List the fields you want to get for each contact, separated by commas. This helps you customize the information returned."
    },
    "resource_name": {
      "type": "string",
      "title": "Resource Name",
      "default": "people/me",
      "description": "Identifier for the person resource whose connections are listed; use 'people/me' for the authenticated user.",
      "human_parameter_name": "Resource Name",
      "human_parameter_description": "Provide the identifier for the person's resource. Use 'people/me' to access your own account."
    },
    "include_other_contacts": {
      "type": "boolean",
      "title": "Include Other Contacts",
      "default": true,
      "description": "Include 'Other Contacts' (interacted with but not explicitly saved) in addition to regular contacts. WARNING: 'Other Contacts' often have incomplete data - they may lack names, phone numbers, and other fields even when requested. These auto-generated contacts are created from email interactions and typically only have email addresses. Set to False if you need contacts with complete name information. When True, each contact will have a 'contactSource' field indicating its origin. When True, `person_fields` is restricted to `emailAddresses`, `names`, `phoneNumbers`, and `metadata` only \u2014 requesting other fields (e.g., `organizations`, `birthdays`) causes validation errors or silent omissions.",
      "human_parameter_name": "Include Other Contacts?",
      "human_parameter_description": "Decide whether to include contacts you've interacted with but haven't saved. WARNING: These contacts often only have email addresses and may lack names and other requested fields."
    }
  }
}
```

**Output schema:**
```json
{
  "type": "object",
  "$defs": {
    "Url": {
      "type": "object",
      "title": "Url",
      "properties": {
        "type": {
          "type": "string",
          "title": "Type",
          "description": "Type of the URL (e.g., blog, homepage)"
        },
        "value": {
          "type": "string",
          "title": "Value",
          "description": "The URL string"
        },
        "metadata": {
          "type": "object",
          "title": "Metadata",
          "properties": {
            "source": {
              "type": "object",
              "title": "Source",
              "properties": {
                "id": {
                  "type": "string",
                  "title": "Id",
                  "description": "Identifier of the source record"
                },
                "type": {
                  "type": "string",
                  "title": "Type",
                  "description": "Type of the source"
                }
              },
              "description": "Origin of the field data"
            },
            "primary": {
              "type": "boolean",
              "title": "Primary",
              "description": "Whether this field is marked as primary"
            },
            "sourcePrimary": {
              "type": "boolean",
              "title": "Source Primary",
              "description": "Whether this source is the primary source for the field"
            }
          },
          "description": "Metadata associated with the URL"
        },
        "formattedType": {
          "type": "string",
          "title": "Formatted Type",
          "description": "Formatted type of the URL"
        }
      },
      "description": "A URL record for a contact."
    },
    "Name": {
      "type": "object",
      "title": "Name",
      "properties": {
        "metadata": {
          "type": "object",
          "title": "Metadata",
          "properties": {
            "source": {
              "type": "object",
              "title": "Source",
              "properties": {
                "id": {
                  "type": "string",
                  "title": "Id",
                  "description": "Identifier of the source record"
                },
                "type": {
                  "type": "string",
                  "title": "Type",
                  "description": "Type of the source"
                }
              },
              "description": "Origin of the field data"
            },
            "primary": {
              "type": "boolean",
              "title": "Primary",
              "description": "Whether this field is marked as primary"
            },
            "sourcePrimary": {
              "type": "boolean",
              "title": "Source Primary",
              "description": "Whether this source is the primary source for the field"
            }
          },
          "description": "Metadata associated with the name field"
        },
        "givenName": {
          "type": "string",
          "title": "Given Name",
          "description": "Given (first) name"
        },
        "familyName": {
          "type": "string",
          "title": "Family Name",
          "description": "Family (last) name"
        },
        "displayName": {
          "type": "string",
          "title": "Display Name",
          "description": "Full display name"
        },
        "unstructuredName": {
          "type": "string",
          "title": "Unstructured Name",
          "description": "Unstructured name string"
        },
        "displayNameLastFirst": {
          "type": "string",
          "title": "Display Name Last First",
          "description": "Display name formatted as Last, First"
        }
      },
      "description": "A name record for a contact."
    },
    "Event": {
      "type": "object",
      "title": "Event",
      "properties": {
        "date": {
          "type": "object",
          "title": "Date",
          "description": "Date object with year, month, day fields",
          "additionalProperties": true
        },
        "type": {
          "type": "string",
          "title": "Type",
          "description": "Type of event (e.g., anniversary)"
        },
        "metadata": {
          "type": "object",
          "title": "Metadata",
          "properties": {
            "source": {
              "type": "object",
              "title": "Source",
              "properties": {
                "id": {
                  "type": "string",
                  "title": "Id",
                  "description": "Identifier of the source record"
                },
                "type": {
                  "type": "string",
                  "title": "Type",
                  "description": "Type of the source"
                }
              },
              "description": "Origin of the field data"
            },
            "primary": {
              "type": "boolean",
              "title": "Primary",
              "description": "Whether this field is marked as primary"
            },
            "sourcePrimary": {
              "type": "boolean",
              "title": "Source Primary",
              "description": "Whether this source is the primary source for the field"
            }
          },
          "description": "Metadata associated with the event"
        },
        "formattedType": {
          "type": "string",
          "title": "Formatted Type",
          "description": "Formatted type of the event"
        }
      },
      "description": "An event record for a contact (e.g., anniversary)."
    },
    "Gender": {
      "type": "object",
      "title": "Gender",
      "properties": {
        "value": {
          "type": "string",
          "title": "Value",
          "description": "Gender value"
        },
        "metadata": {
          "type": "object",
          "title": "Metadata",
          "properties": {
            "source": {
              "type": "object",
              "title": "Source",
              "properties": {
                "id": {
                  "type": "string",
                  "title": "Id",
                  "description": "Identifier of the source record"
                },
                "type": {
                  "type": "string",
                  "title": "Type",
                  "description": "Type of the source"
                }
              },
              "description": "Origin of the field data"
            },
            "primary": {
              "type": "boolean",
              "title": "Primary",
              "description": "Whether this field is marked as primary"
            },
            "sourcePrimary": {
              "type": "boolean",
              "title": "Source Primary",
              "description": "Whether this source is the primary source for the field"
            }
          },
          "description": "Metadata associated with the gender"
        },
        "formattedValue": {
          "type": "string",
          "title": "Formatted Value",
          "description": "Formatted gender value"
        }
      },
      "description": "A gender record for a contact."
    },
    "Source": {
      "type": "object",
      "title": "Source",
      "properties": {
        "id": {
          "type": "string",
          "title": "Id",
          "description": "Identifier of the source record"
        },
        "type": {
          "type": "string",
          "title": "Type",
          "description": "Type of the source"
        }
      },
      "description": "Origin of the field data."
    },
    "Address": {
      "type": "object",
      "title": "Address",
      "properties": {
        "city": {
          "type": "string",
          "title": "City",
          "description": "City"
        },
        "type": {
          "type": "string",
          "title": "Type",
          "description": "Type of address (e.g., home, work)"
        },
        "region": {
          "type": "string",
          "title": "Region",
          "description": "Region or state"
        },
        "country": {
          "type": "string",
          "title": "Country",
          "description": "Country"
        },
        "metadata": {
          "type": "object",
          "title": "Metadata",
          "properties": {
            "source": {
              "type": "object",
              "title": "Source",
              "properties": {
                "id": {
                  "type": "string",
                  "title": "Id",
                  "description": "Identifier of the source record"
                },
                "type": {
                  "type": "string",
                  "title": "Type",
                  "description": "Type of the source"
                }
              },
              "description": "Origin of the field data"
            },
            "primary": {
              "type": "boolean",
              "title": "Primary",
              "description": "Whether this field is marked as primary"
            },
            "sourcePrimary": {
              "type": "boolean",
              "title": "Source Primary",
              "description": "Whether this source is the primary source for the field"
            }
          },
          "description": "Metadata associated with the address"
        },
        "postalCode": {
          "type": "string",
          "title": "Postal Code",
          "description": "Postal code"
        },
        "countryCode": {
          "type": "string",
          "title": "Country Code",
          "description": "Country code"
        },
        "formattedType": {
          "type": "string",
          "title": "Formatted Type",
          "description": "Formatted type of the address"
        },
        "streetAddress": {
          "type": "string",
          "title": "Street Address",
          "description": "Street address"
        },
        "formattedValue": {
          "type": "string",
          "title": "Formatted Value",
          "description": "Formatted string of the address"
        }
      },
      "description": "An address record for a contact."
    },
    "Birthday": {
      "type": "object",
      "title": "Birthday",
      "properties": {
        "date": {
          "type": "object",
          "title": "Date",
          "description": "Date object with year, month, day fields",
          "additionalProperties": true
        },
        "text": {
          "type": "string",
          "title": "Text",
          "description": "Free-form text representation of the birthday"
        },
        "metadata": {
          "type": "object",
          "title": "Metadata",
          "properties": {
            "source": {
              "type": "object",
              "title": "Source",
              "properties": {
                "id": {
                  "type": "string",
                  "title": "Id",
                  "description": "Identifier of the source record"
                },
                "type": {
                  "type": "string",
                  "title": "Type",
                  "description": "Type of the source"
                }
              },
              "description": "Origin of the field data"
            },
            "primary": {
              "type": "boolean",
              "title": "Primary",
              "description": "Whether this field is marked as primary"
            },
            "sourcePrimary": {
              "type": "boolean",
              "title": "Source Primary",
              "description": "Whether this source is the primary source for the field"
            }
          },
          "description": "Metadata associated with the birthday"
        }
      },
      "description": "A birthday record for a contact."
    },
    "Relation": {
      "type": "object",
      "title": "Relation",
      "properties": {
        "type": {
          "type": "string",
          "title": "Type",
          "description": "Type of relation (e.g., spouse, parent)"
        },
        "person": {
          "type": "string",
          "title": "Person",
          "description": "Name of the related person"
        },
        "metadata": {
          "type": "object",
          "title": "Metadata",
          "properties": {
            "source": {
              "type": "object",
              "title": "Source",
              "properties": {
                "id": {
                  "type": "string",
                  "title": "Id",
                  "description": "Identifier of the source record"
                },
                "type": {
                  "type": "string",
                  "title": "Type",
                  "description": "Type of the source"
                }
              },
              "description": "Origin of the field data"
            },
            "primary": {
              "type": "boolean",
              "title": "Primary",
              "description": "Whether this field is marked as primary"
            },
            "sourcePrimary": {
              "type": "boolean",
              "title": "Source Primary",
              "description": "Whether this source is the primary source for the field"
            }
          },
          "description": "Metadata associated with the relation"
        },
        "formattedType": {
          "type": "string",
          "title": "Formatted Type",
          "description": "Formatted type of the relation"
        }
      },
      "description": "A relation record for a contact."
    },
    "Biography": {
      "type": "object",
      "title": "Biography",
      "properties": {
        "value": {
          "type": "string",
          "title": "Value",
          "description": "Biography text"
        },
        "metadata": {
          "type": "object",
          "title": "Metadata",
          "properties": {
            "source": {
              "type": "object",
              "title": "Source",
              "properties": {
                "id": {
                  "type": "string",
                  "title": "Id",
                  "description": "Identifier of the source record"
                },
                "type": {
                  "type": "string",
                  "title": "Type",
                  "description": "Type of the source"
                }
              },
              "description": "Origin of the field data"
            },
            "primary": {
              "type": "boolean",
              "title": "Primary",
              "description": "Whether this field is marked as primary"
            },
            "sourcePrimary": {
              "type": "boolean",
              "title": "Source Primary",
              "description": "Whether this source is the primary source for the field"
            }
          },
          "description": "Metadata associated with the biography"
        },
        "contentType": {
          "type": "string",
          "title": "Content Type",
          "description": "Content type of the biography (e.g., TEXT_PLAIN, TEXT_HTML)"
        }
      },
      "description": "A biography record for a contact."
    },
    "Connection": {
      "type": "object",
      "title": "Connection",
      "properties": {
        "etag": {
          "type": "string",
          "title": "Etag",
          "description": "Version tag for concurrency control"
        },
        "urls": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "Url",
            "properties": {
              "type": {
                "type": "string",
                "title": "Type",
                "description": "Type of the URL (e.g., blog, homepage)"
              },
              "value": {
                "type": "string",
                "title": "Value",
                "description": "The URL string"
              },
              "metadata": {
                "type": "object",
                "title": "Metadata",
                "properties": {
                  "source": {
                    "type": "object",
                    "title": "Source",
                    "properties": {
                      "id": {
                        "type": "string",
                        "title": "Id",
                        "description": "Identifier of the source record"
                      },
                      "type": {
                        "type": "string",
                        "title": "Type",
                        "description": "Type of the source"
                      }
                    },
                    "description": "Origin of the field data"
                  },
                  "primary": {
                    "type": "boolean",
                    "title": "Primary",
                    "description": "Whether this field is marked as primary"
                  },
                  "sourcePrimary": {
                    "type": "boolean",
                    "title": "Source Primary",
                    "description": "Whether this source is the primary source for the field"
                  }
                },
                "description": "Metadata associated with the URL"
              },
              "formattedType": {
                "type": "string",
                "title": "Formatted Type",
                "description": "Formatted type of the URL"
              }
            },
            "description": "A URL record for a contact."
          },
          "title": "Urls",
          "description": "List of the contact's URLs"
        },
        "names": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "Name",
            "properties": {
              "metadata": {
                "type": "object",
                "title": "Metadata",
                "properties": {
                  "source": {
                    "type": "object",
                    "title": "Source",
                    "properties": {
                      "id": {
                        "type": "string",
                        "title": "Id",
                        "description": "Identifier of the source record"
                      },
                      "type": {
                        "type": "string",
                        "title": "Type",
                        "description": "Type of the source"
                      }
                    },
                    "description": "Origin of the field data"
                  },
                  "primary": {
                    "type": "boolean",
                    "title": "Primary",
                    "description": "Whether this field is marked as primary"
                  },
                  "sourcePrimary": {
                    "type": "boolean",
                    "title": "Source Primary",
                    "description": "Whether this source is the primary source for the field"
                  }
                },
                "description": "Metadata associated with the name field"
              },
              "givenName": {
                "type": "string",
                "title": "Given Name",
                "description": "Given (first) name"
              },
              "familyName": {
                "type": "string",
                "title": "Family Name",
                "description": "Family (last) name"
              },
              "displayName": {
                "type": "string",
                "title": "Display Name",
                "description": "Full display name"
              },
              "unstructuredName": {
                "type": "string",
                "title": "Unstructured Name",
                "description": "Unstructured name string"
              },
              "displayNameLastFirst": {
                "type": "string",
                "title": "Display Name Last First",
                "description": "Display name formatted as Last, First"
              }
            },
            "description": "A name record for a contact."
          },
          "title": "Names",
          "description": "List of the contact's names"
        },
        "events": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "Event",
            "properties": {
              "date": {
                "type": "object",
                "title": "Date",
                "description": "Date object with year, month, day fields",
                "additionalProperties": true
              },
              "type": {
                "type": "string",
                "title": "Type",
                "description": "Type of event (e.g., anniversary)"
              },
              "metadata": {
                "type": "object",
                "title": "Metadata",
                "properties": {
                  "source": {
                    "type": "object",
                    "title": "Source",
                    "properties": {
                      "id": {
                        "type": "string",
                        "title": "Id",
                        "description": "Identifier of the source record"
                      },
                      "type": {
                        "type": "string",
                        "title": "Type",
                        "description": "Type of the source"
                      }
                    },
                    "description": "Origin of the field data"
                  },
                  "primary": {
                    "type": "boolean",
                    "title": "Primary",
                    "description": "Whether this field is marked as primary"
                  },
                  "sourcePrimary": {
                    "type": "boolean",
                    "title": "Source Primary",
                    "description": "Whether this source is the primary source for the field"
                  }
                },
                "description": "Metadata associated with the event"
              },
              "formattedType": {
                "type": "string",
                "title": "Formatted Type",
                "description": "Formatted type of the event"
              }
            },
            "description": "An event record for a contact (e.g., anniversary)."
          },
          "title": "Events",
          "description": "List of the contact's events (e.g., anniversaries)"
        },
        "photos": {
          "type": "array",
          "items": {
            "type": "object",
            "additionalProperties": true
          },
          "title": "Photos",
          "description": "List of the contact's photos"
        },
        "skills": {
          "type": "array",
          "items": {
            "type": "object",
            "additionalProperties": true
          },
          "title": "Skills",
          "description": "List of the contact's skills"
        },
        "genders": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "Gender",
            "properties": {
              "value": {
                "type": "string",
                "title": "Value",
                "description": "Gender value"
              },
              "metadata": {
                "type": "object",
                "title": "Metadata",
                "properties": {
                  "source": {
                    "type": "object",
                    "title": "Source",
                    "properties": {
                      "id": {
                        "type": "string",
                        "title": "Id",
                        "description": "Identifier of the source record"
                      },
                      "type": {
                        "type": "string",
                        "title": "Type",
                        "description": "Type of the source"
                      }
                    },
                    "description": "Origin of the field data"
                  },
                  "primary": {
                    "type": "boolean",
                    "title": "Primary",
                    "description": "Whether this field is marked as primary"
                  },
                  "sourcePrimary": {
                    "type": "boolean",
                    "title": "Source Primary",
                    "description": "Whether this source is the primary source for the field"
                  }
                },
                "description": "Metadata associated with the gender"
              },
              "formattedValue": {
                "type": "string",
                "title": "Formatted Value",
                "description": "Formatted gender value"
              }
            },
            "description": "A gender record for a contact."
          },
          "title": "Genders",
          "description": "List of the contact's genders"
        },
        "locales": {
          "type": "array",
          "items": {
            "type": "object",
            "additionalProperties": true
          },
          "title": "Locales",
          "description": "List of the contact's locale preferences"
        },
        "metadata": {
          "type": "object",
          "title": "Metadata",
          "description": "Metadata about the contact",
          "additionalProperties": true
        },
        "addresses": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "Address",
            "properties": {
              "city": {
                "type": "string",
                "title": "City",
                "description": "City"
              },
              "type": {
                "type": "string",
                "title": "Type",
                "description": "Type of address (e.g., home, work)"
              },
              "region": {
                "type": "string",
                "title": "Region",
                "description": "Region or state"
              },
              "country": {
                "type": "string",
                "title": "Country",
                "description": "Country"
              },
              "metadata": {
                "type": "object",
                "title": "Metadata",
                "properties": {
                  "source": {
                    "type": "object",
                    "title": "Source",
                    "properties": {
                      "id": {
                        "type": "string",
                        "title": "Id",
                        "description": "Identifier of the source record"
                      },
                      "type": {
                        "type": "string",
                        "title": "Type",
                        "description": "Type of the source"
                      }
                    },
                    "description": "Origin of the field data"
                  },
                  "primary": {
                    "type": "boolean",
                    "title": "Primary",
                    "description": "Whether this field is marked as primary"
                  },
                  "sourcePrimary": {
                    "type": "boolean",
                    "title": "Source Primary",
                    "description": "Whether this source is the primary source for the field"
                  }
                },
                "description": "Metadata associated with the address"
              },
              "postalCode": {
                "type": "string",
                "title": "Postal Code",
                "description": "Postal code"
              },
              "countryCode": {
                "type": "string",
                "title": "Country Code",
                "description": "Country code"
              },
              "formattedType": {
                "type": "string",
                "title": "Formatted Type",
                "description": "Formatted type of the address"
              },
              "streetAddress": {
                "type": "string",
                "title": "Street Address",
                "description": "Street address"
              },
              "formattedValue": {
                "type": "string",
                "title": "Formatted Value",
                "description": "Formatted string of the address"
              }
            },
            "description": "An address record for a contact."
          },
          "title": "Addresses",
          "description": "List of the contact's addresses"
        },
        "ageRanges": {
          "type": "array",
          "items": {
            "type": "object",
            "additionalProperties": true
          },
          "title": "Age Ranges",
          "description": "List of the contact's age ranges"
        },
        "birthdays": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "Birthday",
            "properties": {
              "date": {
                "type": "object",
                "title": "Date",
                "description": "Date object with year, month, day fields",
                "additionalProperties": true
              },
              "text": {
                "type": "string",
                "title": "Text",
                "description": "Free-form text representation of the birthday"
              },
              "metadata": {
                "type": "object",
                "title": "Metadata",
                "properties": {
                  "source": {
                    "type": "object",
                    "title": "Source",
                    "properties": {
                      "id": {
                        "type": "string",
                        "title": "Id",
                        "description": "Identifier of the source record"
                      },
                      "type": {
                        "type": "string",
                        "title": "Type",
                        "description": "Type of the source"
                      }
                    },
                    "description": "Origin of the field data"
                  },
                  "primary": {
                    "type": "boolean",
                    "title": "Primary",
                    "description": "Whether this field is marked as primary"
                  },
                  "sourcePrimary": {
                    "type": "boolean",
                    "title": "Source Primary",
                    "description": "Whether this source is the primary source for the field"
                  }
                },
                "description": "Metadata associated with the birthday"
              }
            },
            "description": "A birthday record for a contact."
          },
          "title": "Birthdays",
          "description": "List of the contact's birthdays"
        },
        "imClients": {
          "type": "array",
          "items": {
            "type": "object",
            "additionalProperties": true
          },
          "title": "Im Clients",
          "description": "List of the contact's IM clients"
        },
        "interests": {
          "type": "array",
          "items": {
            "type": "object",
            "additionalProperties": true
          },
          "title": "Interests",
          "description": "List of the contact's interests"
        },
        "nicknames": {
          "type": "array",
          "items": {
            "type": "object",
            "additionalProperties": true
          },
          "title": "Nicknames",
          "description": "List of the contact's nicknames"
        },
        "relations": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "Relation",
            "properties": {
              "type": {
                "type": "string",
                "title": "Type",
                "description": "Type of relation (e.g., spouse, parent)"
              },
              "person": {
                "type": "string",
                "title": "Person",
                "description": "Name of the related person"
              },
              "metadata": {
                "type": "object",
                "title": "Metadata",
                "properties": {
                  "source": {
                    "type": "object",
                    "title": "Source",
                    "properties": {
                      "id": {
                        "type": "string",
                        "title": "Id",
                        "description": "Identifier of the source record"
                      },
                      "type": {
                        "type": "string",
                        "title": "Type",
                        "description": "Type of the source"
                      }
                    },
                    "description": "Origin of the field data"
                  },
                  "primary": {
                    "type": "boolean",
                    "title": "Primary",
                    "description": "Whether this field is marked as primary"
                  },
                  "sourcePrimary": {
                    "type": "boolean",
                    "title": "Source Primary",
                    "description": "Whether this source is the primary source for the field"
                  }
                },
                "description": "Metadata associated with the relation"
              },
              "formattedType": {
                "type": "string",
                "title": "Formatted Type",
                "description": "Formatted type of the relation"
              }
            },
            "description": "A relation record for a contact."
          },
          "title": "Relations",
          "description": "List of the contact's relations"
        },
        "residences": {
          "type": "array",
          "items": {
            "type": "object",
            "additionalProperties": true
          },
          "title": "Residences",
          "description": "List of the contact's residences (deprecated)"
        },
        "biographies": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "Biography",
            "properties": {
              "value": {
                "type": "string",
                "title": "Value",
                "description": "Biography text"
              },
              "metadata": {
                "type": "object",
                "title": "Metadata",
                "properties": {
                  "source": {
                    "type": "object",
                    "title": "Source",
                    "properties": {
                      "id": {
                        "type": "string",
                        "title": "Id",
                        "description": "Identifier of the source record"
                      },
                      "type": {
                        "type": "string",
                        "title": "Type",
                        "description": "Type of the source"
                      }
                    },
                    "description": "Origin of the field data"
                  },
                  "primary": {
                    "type": "boolean",
                    "title": "Primary",
                    "description": "Whether this field is marked as primary"
                  },
                  "sourcePrimary": {
                    "type": "boolean",
                    "title": "Source Primary",
                    "description": "Whether this source is the primary source for the field"
                  }
                },
                "description": "Metadata associated with the biography"
              },
              "contentType": {
                "type": "string",
                "title": "Content Type",
                "description": "Content type of the biography (e.g., TEXT_PLAIN, TEXT_HTML)"
              }
            },
            "description": "A biography record for a contact."
          },
          "title": "Biographies",
          "description": "List of the contact's biographies"
        },
        "coverPhotos": {
          "type": "array",
          "items": {
            "type": "object",
            "additionalProperties": true
          },
          "title": "Cover Photos",
          "description": "List of the contact's cover photos"
        },
        "memberships": {
          "type": "array",
          "items": {
            "type": "object",
            "additionalProperties": true
          },
          "title": "Memberships",
          "description": "List of the contact's group memberships"
        },
        "occupations": {
          "type": "array",
          "items": {
            "type": "object",
            "additionalProperties": true
          },
          "title": "Occupations",
          "description": "List of the contact's occupations"
        },
        "userDefined": {
          "type": "array",
          "items": {
            "type": "object",
            "additionalProperties": true
          },
          "title": "User Defined",
          "description": "List of the contact's user-defined fields"
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
                "description": "Type of phone number (e.g., mobile, home, work)"
              },
              "value": {
                "type": "string",
                "title": "Value",
                "description": "The phone number string"
              },
              "metadata": {
                "type": "object",
                "title": "Metadata",
                "properties": {
                  "source": {
                    "type": "object",
                    "title": "Source",
                    "properties": {
                      "id": {
                        "type": "string",
                        "title": "Id",
                        "description": "Identifier of the source record"
                      },
                      "type": {
                        "type": "string",
                        "title": "Type",
                        "description": "Type of the source"
                      }
                    },
                    "description": "Origin of the field data"
                  },
                  "primary": {
                    "type": "boolean",
                    "title": "Primary",
                    "description": "Whether this field is marked as primary"
                  },
                  "sourcePrimary": {
                    "type": "boolean",
                    "title": "Source Primary",
                    "description": "Whether this source is the primary source for the field"
                  }
                },
                "description": "Metadata associated with the phone number"
              },
              "formattedType": {
                "type": "string",
                "title": "Formatted Type",
                "description": "Formatted type of the phone number"
              }
            },
            "description": "A phone number record for a contact."
          },
          "title": "Phone Numbers",
          "description": "List of the contact's phone numbers"
        },
        "resourceName": {
          "type": "string",
          "title": "Resource Name",
          "description": "Unique resource identifier for the contact"
        },
        "sipAddresses": {
          "type": "array",
          "items": {
            "type": "object",
            "additionalProperties": true
          },
          "title": "Sip Addresses",
          "description": "List of the contact's SIP addresses"
        },
        "contactSource": {
          "type": "string",
          "title": "Contact Source",
          "description": "Source of the contact: 'CONTACT' for regular contacts or 'OTHER_CONTACT' for auto-generated contacts from email interactions. OTHER_CONTACT entries often lack fields like names even when requested."
        },
        "organizations": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "Organization",
            "properties": {
              "name": {
                "type": "string",
                "title": "Name",
                "description": "Name of the organization"
              },
              "type": {
                "type": "string",
                "title": "Type",
                "description": "Type of organization (e.g., work, school)"
              },
              "title": {
                "type": "string",
                "title": "Title",
                "description": "Job title at the organization"
              },
              "metadata": {
                "type": "object",
                "title": "Metadata",
                "properties": {
                  "source": {
                    "type": "object",
                    "title": "Source",
                    "properties": {
                      "id": {
                        "type": "string",
                        "title": "Id",
                        "description": "Identifier of the source record"
                      },
                      "type": {
                        "type": "string",
                        "title": "Type",
                        "description": "Type of the source"
                      }
                    },
                    "description": "Origin of the field data"
                  },
                  "primary": {
                    "type": "boolean",
                    "title": "Primary",
                    "description": "Whether this field is marked as primary"
                  },
                  "sourcePrimary": {
                    "type": "boolean",
                    "title": "Source Primary",
                    "description": "Whether this source is the primary source for the field"
                  }
                },
                "description": "Metadata associated with the organization"
              },
              "department": {
                "type": "string",
                "title": "Department",
                "description": "Department within the organization"
              },
              "formattedType": {
                "type": "string",
                "title": "Formatted Type",
                "description": "Formatted type of the organization"
              }
            },
            "description": "An organization record for a contact."
          },
          "title": "Organizations",
          "description": "List of the contact's organizations"
        },
        "emailAddresses": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "EmailAddress",
            "required": [
              "value"
            ],
            "properties": {
              "value": {
                "type": "string",
                "title": "Value",
                "description": "The email address string"
              },
              "metadata": {
                "type": "object",
                "title": "Metadata",
                "properties": {
                  "source": {
                    "type": "object",
                    "title": "Source",
                    "properties": {
                      "id": {
                        "type": "string",
                        "title": "Id",
                        "description": "Identifier of the source record"
                      },
                      "type": {
                        "type": "string",
                        "title": "Type",
                        "description": "Type of the source"
                      }
                    },
                    "description": "Origin of the field data"
                  },
                  "primary": {
                    "type": "boolean",
                    "title": "Primary",
                    "description": "Whether this field is marked as primary"
                  },
                  "sourcePrimary": {
                    "type": "boolean",
                    "title": "Source Primary",
                    "description": "Whether this source is the primary source for the field"
                  }
                },
                "description": "Metadata associated with the email address"
              }
            },
            "description": "An email address record for a contact."
          },
          "title": "Email Addresses",
          "description": "List of the contact's email addresses"
        }
      },
      "description": "A single contact entry."
    },
    "PhoneNumber": {
      "type": "object",
      "title": "PhoneNumber",
      "properties": {
        "type": {
          "type": "string",
          "title": "Type",
          "description": "Type of phone number (e.g., mobile, home, work)"
        },
        "value": {
          "type": "string",
          "title": "Value",
          "description": "The phone number string"
        },
        "metadata": {
          "type": "object",
          "title": "Metadata",
          "properties": {
            "source": {
              "type": "object",
              "title": "Source",
              "properties": {
                "id": {
                  "type": "string",
                  "title": "Id",
                  "description": "Identifier of the source record"
                },
                "type": {
                  "type": "string",
                  "title": "Type",
                  "description": "Type of the source"
                }
              },
              "description": "Origin of the field data"
            },
            "primary": {
              "type": "boolean",
              "title": "Primary",
              "description": "Whether this field is marked as primary"
            },
            "sourcePrimary": {
              "type": "boolean",
              "title": "Source Primary",
              "description": "Whether this source is the primary source for the field"
            }
          },
          "description": "Metadata associated with the phone number"
        },
        "formattedType": {
          "type": "string",
          "title": "Formatted Type",
          "description": "Formatted type of the phone number"
        }
      },
      "description": "A phone number record for a contact."
    },
    "EmailAddress": {
      "type": "object",
      "title": "EmailAddress",
      "required": [
        "value"
      ],
      "properties": {
        "value": {
          "type": "string",
          "title": "Value",
          "description": "The email address string"
        },
        "metadata": {
          "type": "object",
          "title": "Metadata",
          "properties": {
            "source": {
              "type": "object",
              "title": "Source",
              "properties": {
                "id": {
                  "type": "string",
                  "title": "Id",
                  "description": "Identifier of the source record"
                },
                "type": {
                  "type": "string",
                  "title": "Type",
                  "description": "Type of the source"
                }
              },
              "description": "Origin of the field data"
            },
            "primary": {
              "type": "boolean",
              "title": "Primary",
              "description": "Whether this field is marked as primary"
            },
            "sourcePrimary": {
              "type": "boolean",
              "title": "Source Primary",
              "description": "Whether this source is the primary source for the field"
            }
          },
          "description": "Metadata associated with the email address"
        }
      },
      "description": "An email address record for a contact."
    },
    "Organization": {
      "type": "object",
      "title": "Organization",
      "properties": {
        "name": {
          "type": "string",
          "title": "Name",
          "description": "Name of the organization"
        },
        "type": {
          "type": "string",
          "title": "Type",
          "description": "Type of organization (e.g., work, school)"
        },
        "title": {
          "type": "string",
          "title": "Title",
          "description": "Job title at the organization"
        },
        "metadata": {
          "type": "object",
          "title": "Metadata",
          "properties": {
            "source": {
              "type": "object",
              "title": "Source",
              "properties": {
                "id": {
                  "type": "string",
                  "title": "Id",
                  "description": "Identifier of the source record"
                },
                "type": {
                  "type": "string",
                  "title": "Type",
                  "description": "Type of the source"
                }
              },
              "description": "Origin of the field data"
            },
            "primary": {
              "type": "boolean",
              "title": "Primary",
              "description": "Whether this field is marked as primary"
            },
            "sourcePrimary": {
              "type": "boolean",
              "title": "Source Primary",
              "description": "Whether this source is the primary source for the field"
            }
          },
          "description": "Metadata associated with the organization"
        },
        "department": {
          "type": "string",
          "title": "Department",
          "description": "Department within the organization"
        },
        "formattedType": {
          "type": "string",
          "title": "Formatted Type",
          "description": "Formatted type of the organization"
        }
      },
      "description": "An organization record for a contact."
    },
    "FieldMetadata": {
      "type": "object",
      "title": "FieldMetadata",
      "properties": {
        "source": {
          "type": "object",
          "title": "Source",
          "properties": {
            "id": {
              "type": "string",
              "title": "Id",
              "description": "Identifier of the source record"
            },
            "type": {
              "type": "string",
              "title": "Type",
              "description": "Type of the source"
            }
          },
          "description": "Origin of the field data"
        },
        "primary": {
          "type": "boolean",
          "title": "Primary",
          "description": "Whether this field is marked as primary"
        },
        "sourcePrimary": {
          "type": "boolean",
          "title": "Source Primary",
          "description": "Whether this source is the primary source for the field"
        }
      },
      "description": "Metadata about a contact field."
    },
    "GetContactsResponse": {
      "type": "object",
      "title": "GetContactsResponse",
      "properties": {
        "totalItems": {
          "type": "integer",
          "title": "Total Items",
          "default": 0,
          "description": "Total number of connections returned"
        },
        "connections": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "Connection",
            "properties": {
              "etag": {
                "type": "string",
                "title": "Etag",
                "description": "Version tag for concurrency control"
              },
              "urls": {
                "type": "array",
                "items": {
                  "type": "object",
                  "title": "Url",
                  "properties": {
                    "type": {
                      "type": "string",
                      "title": "Type",
                      "description": "Type of the URL (e.g., blog, homepage)"
                    },
                    "value": {
                      "type": "string",
                      "title": "Value",
                      "description": "The URL string"
                    },
                    "metadata": {
                      "type": "object",
                      "title": "Metadata",
                      "properties": {
                        "source": {
                          "type": "object",
                          "title": "Source",
                          "properties": {
                            "id": {
                              "type": "string",
                              "title": "Id",
                              "description": "Identifier of the source record"
                            },
                            "type": {
                              "type": "string",
                              "title": "Type",
                              "description": "Type of the source"
                            }
                          },
                          "description": "Origin of the field data"
                        },
                        "primary": {
                          "type": "boolean",
                          "title": "Primary",
                          "description": "Whether this field is marked as primary"
                        },
                        "sourcePrimary": {
                          "type": "boolean",
                          "title": "Source Primary",
                          "description": "Whether this source is the primary source for the field"
                        }
                      },
                      "description": "Metadata associated with the URL"
                    },
                    "formattedType": {
                      "type": "string",
                      "title": "Formatted Type",
                      "description": "Formatted type of the URL"
                    }
                  },
                  "description": "A URL record for a contact."
                },
                "title": "Urls",
                "description": "List of the contact's URLs"
              },
              "names": {
                "type": "array",
                "items": {
                  "type": "object",
                  "title": "Name",
                  "properties": {
                    "metadata": {
                      "type": "object",
                      "title": "Metadata",
                      "properties": {
                        "source": {
                          "type": "object",
                          "title": "Source",
                          "properties": {
                            "id": {
                              "type": "string",
                              "title": "Id",
                              "description": "Identifier of the source record"
                            },
                            "type": {
                              "type": "string",
                              "title": "Type",
                              "description": "Type of the source"
                            }
                          },
                          "description": "Origin of the field data"
                        },
                        "primary": {
                          "type": "boolean",
                          "title": "Primary",
                          "description": "Whether this field is marked as primary"
                        },
                        "sourcePrimary": {
                          "type": "boolean",
                          "title": "Source Primary",
                          "description": "Whether this source is the primary source for the field"
                        }
                      },
                      "description": "Metadata associated with the name field"
                    },
                    "givenName": {
                      "type": "string",
                      "title": "Given Name",
                      "description": "Given (first) name"
                    },
                    "familyName": {
                      "type": "string",
                      "title": "Family Name",
                      "description": "Family (last) name"
                    },
                    "displayName": {
                      "type": "string",
                      "title": "Display Name",
                      "description": "Full display name"
                    },
                    "unstructuredName": {
                      "type": "string",
                      "title": "Unstructured Name",
                      "description": "Unstructured name string"
                    },
                    "displayNameLastFirst": {
                      "type": "string",
                      "title": "Display Name Last First",
                      "description": "Display name formatted as Last, First"
                    }
                  },
                  "description": "A name record for a contact."
                },
                "title": "Names",
                "description": "List of the contact's names"
              },
              "events": {
                "type": "array",
                "items": {
                  "type": "object",
                  "title": "Event",
                  "properties": {
                    "date": {
                      "type": "object",
                      "title": "Date",
                      "description": "Date object with year, month, day fields",
                      "additionalProperties": true
                    },
                    "type": {
                      "type": "string",
                      "title": "Type",
                      "description": "Type of event (e.g., anniversary)"
                    },
                    "metadata": {
                      "type": "object",
                      "title": "Metadata",
                      "properties": {
                        "source": {
                          "type": "object",
                          "title": "Source",
                          "properties": {
                            "id": {
                              "type": "string",
                              "title": "Id",
                              "description": "Identifier of the source record"
                            },
                            "type": {
                              "type": "string",
                              "title": "Type",
                              "description": "Type of the source"
                            }
                          },
                          "description": "Origin of the field data"
                        },
                        "primary": {
                          "type": "boolean",
                          "title": "Primary",
                          "description": "Whether this field is marked as primary"
                        },
                        "sourcePrimary": {
                          "type": "boolean",
                          "title": "Source Primary",
                          "description": "Whether this source is the primary source for the field"
                        }
                      },
                      "description": "Metadata associated with the event"
                    },
                    "formattedType": {
                      "type": "string",
                      "title": "Formatted Type",
                      "description": "Formatted type of the event"
                    }
                  },
                  "description": "An event record for a contact (e.g., anniversary)."
                },
                "title": "Events",
                "description": "List of the contact's events (e.g., anniversaries)"
              },
              "photos": {
                "type": "array",
                "items": {
                  "type": "object",
                  "additionalProperties": true
                },
                "title": "Photos",
                "description": "List of the contact's photos"
              },
              "skills": {
                "type": "array",
                "items": {
                  "type": "object",
                  "additionalProperties": true
                },
                "title": "Skills",
                "description": "List of the contact's skills"
              },
              "genders": {
                "type": "array",
                "items": {
                  "type": "object",
                  "title": "Gender",
                  "properties": {
                    "value": {
                      "type": "string",
                      "title": "Value",
                      "description": "Gender value"
                    },
                    "metadata": {
                      "type": "object",
                      "title": "Metadata",
                      "properties": {
                        "source": {
                          "type": "object",
                          "title": "Source",
                          "properties": {
                            "id": {
                              "type": "string",
                              "title": "Id",
                              "description": "Identifier of the source record"
                            },
                            "type": {
                              "type": "string",
                              "title": "Type",
                              "description": "Type of the source"
                            }
                          },
                          "description": "Origin of the field data"
                        },
                        "primary": {
                          "type": "boolean",
                          "title": "Primary",
                          "description": "Whether this field is marked as primary"
                        },
                        "sourcePrimary": {
                          "type": "boolean",
                          "title": "Source Primary",
                          "description": "Whether this source is the primary source for the field"
                        }
                      },
                      "description": "Metadata associated with the gender"
                    },
                    "formattedValue": {
                      "type": "string",
                      "title": "Formatted Value",
                      "description": "Formatted gender value"
                    }
                  },
                  "description": "A gender record for a contact."
                },
                "title": "Genders",
                "description": "List of the contact's genders"
              },
              "locales": {
                "type": "array",
                "items": {
                  "type": "object",
                  "additionalProperties": true
                },
                "title": "Locales",
                "description": "List of the contact's locale preferences"
              },
              "metadata": {
                "type": "object",
                "title": "Metadata",
                "description": "Metadata about the contact",
                "additionalProperties": true
              },
              "addresses": {
                "type": "array",
                "items": {
                  "type": "object",
                  "title": "Address",
                  "properties": {
                    "city": {
                      "type": "string",
                      "title": "City",
                      "description": "City"
                    },
                    "type": {
                      "type": "string",
                      "title": "Type",
                      "description": "Type of address (e.g., home, work)"
                    },
                    "region": {
                      "type": "string",
                      "title": "Region",
                      "description": "Region or state"
                    },
                    "country": {
                      "type": "string",
                      "title": "Country",
                      "description": "Country"
                    },
                    "metadata": {
                      "type": "object",
                      "title": "Metadata",
                      "properties": {
                        "source": {
                          "type": "object",
                          "title": "Source",
                          "properties": {
                            "id": {
                              "type": "string",
                              "title": "Id",
                              "description": "Identifier of the source record"
                            },
                            "type": {
                              "type": "string",
                              "title": "Type",
                              "description": "Type of the source"
                            }
                          },
                          "description": "Origin of the field data"
                        },
                        "primary": {
                          "type": "boolean",
                          "title": "Primary",
                          "description": "Whether this field is marked as primary"
                        },
                        "sourcePrimary": {
                          "type": "boolean",
                          "title": "Source Primary",
                          "description": "Whether this source is the primary source for the field"
                        }
                      },
                      "description": "Metadata associated with the address"
                    },
                    "postalCode": {
                      "type": "string",
                      "title": "Postal Code",
                      "description": "Postal code"
                    },
                    "countryCode": {
                      "type": "string",
                      "title": "Country Code",
                      "description": "Country code"
                    },
                    "formattedType": {
                      "type": "string",
                      "title": "Formatted Type",
                      "description": "Formatted type of the address"
                    },
                    "streetAddress": {
                      "type": "string",
                      "title": "Street Address",
                      "description": "Street address"
                    },
                    "formattedValue": {
                      "type": "string",
                      "title": "Formatted Value",
                      "description": "Formatted string of the address"
                    }
                  },
                  "description": "An address record for a contact."
                },
                "title": "Addresses",
                "description": "List of the contact's addresses"
              },
              "ageRanges": {
                "type": "array",
                "items": {
                  "type": "object",
                  "additionalProperties": true
                },
                "title": "Age Ranges",
                "description": "List of the contact's age ranges"
              },
              "birthdays": {
                "type": "array",
                "items": {
                  "type": "object",
                  "title": "Birthday",
                  "properties": {
                    "date": {
                      "type": "object",
                      "title": "Date",
                      "description": "Date object with year, month, day fields",
                      "additionalProperties": true
                    },
                    "text": {
                      "type": "string",
                      "title": "Text",
                      "description": "Free-form text representation of the birthday"
                    },
                    "metadata": {
                      "type": "object",
                      "title": "Metadata",
                      "properties": {
                        "source": {
                          "type": "object",
                          "title": "Source",
                          "properties": {
                            "id": {
                              "type": "string",
                              "title": "Id",
                              "description": "Identifier of the source record"
                            },
                            "type": {
                              "type": "string",
                              "title": "Type",
                              "description": "Type of the source"
                            }
                          },
                          "description": "Origin of the field data"
                        },
                        "primary": {
                          "type": "boolean",
                          "title": "Primary",
                          "description": "Whether this field is marked as primary"
                        },
                        "sourcePrimary": {
                          "type": "boolean",
                          "title": "Source Primary",
                          "description": "Whether this source is the primary source for the field"
                        }
                      },
                      "description": "Metadata associated with the birthday"
                    }
                  },
                  "description": "A birthday record for a contact."
                },
                "title": "Birthdays",
                "description": "List of the contact's birthdays"
              },
              "imClients": {
                "type": "array",
                "items": {
                  "type": "object",
                  "additionalProperties": true
                },
                "title": "Im Clients",
                "description": "List of the contact's IM clients"
              },
              "interests": {
                "type": "array",
                "items": {
                  "type": "object",
                  "additionalProperties": true
                },
                "title": "Interests",
                "description": "List of the contact's interests"
              },
              "nicknames": {
                "type": "array",
                "items": {
                  "type": "object",
                  "additionalProperties": true
                },
                "title": "Nicknames",
                "description": "List of the contact's nicknames"
              },
              "relations": {
                "type": "array",
                "items": {
                  "type": "object",
                  "title": "Relation",
                  "properties": {
                    "type": {
                      "type": "string",
                      "title": "Type",
                      "description": "Type of relation (e.g., spouse, parent)"
                    },
                    "person": {
                      "type": "string",
                      "title": "Person",
                      "description": "Name of the related person"
                    },
                    "metadata": {
                      "type": "object",
                      "title": "Metadata",
                      "properties": {
                        "source": {
                          "type": "object",
                          "title": "Source",
                          "properties": {
                            "id": {
                              "type": "string",
                              "title": "Id",
                              "description": "Identifier of the source record"
                            },
                            "type": {
                              "type": "string",
                              "title": "Type",
                              "description": "Type of the source"
                            }
                          },
                          "description": "Origin of the field data"
                        },
                        "primary": {
                          "type": "boolean",
                          "title": "Primary",
                          "description": "Whether this field is marked as primary"
                        },
                        "sourcePrimary": {
                          "type": "boolean",
                          "title": "Source Primary",
                          "description": "Whether this source is the primary source for the field"
                        }
                      },
                      "description": "Metadata associated with the relation"
                    },
                    "formattedType": {
                      "type": "string",
                      "title": "Formatted Type",
                      "description": "Formatted type of the relation"
                    }
                  },
                  "description": "A relation record for a contact."
                },
                "title": "Relations",
                "description": "List of the contact's relations"
              },
              "residences": {
                "type": "array",
                "items": {
                  "type": "object",
                  "additionalProperties": true
                },
                "title": "Residences",
                "description": "List of the contact's residences (deprecated)"
              },
              "biographies": {
                "type": "array",
                "items": {
                  "type": "object",
                  "title": "Biography",
                  "properties": {
                    "value": {
                      "type": "string",
                      "title": "Value",
                      "description": "Biography text"
                    },
                    "metadata": {
                      "type": "object",
                      "title": "Metadata",
                      "properties": {
                        "source": {
                          "type": "object",
                          "title": "Source",
                          "properties": {
                            "id": {
                              "type": "string",
                              "title": "Id",
                              "description": "Identifier of the source record"
                            },
                            "type": {
                              "type": "string",
                              "title": "Type",
                              "description": "Type of the source"
                            }
                          },
                          "description": "Origin of the field data"
                        },
                        "primary": {
                          "type": "boolean",
                          "title": "Primary",
                          "description": "Whether this field is marked as primary"
                        },
                        "sourcePrimary": {
                          "type": "boolean",
                          "title": "Source Primary",
                          "description": "Whether this source is the primary source for the field"
                        }
                      },
                      "description": "Metadata associated with the biography"
                    },
                    "contentType": {
                      "type": "string",
                      "title": "Content Type",
                      "description": "Content type of the biography (e.g., TEXT_PLAIN, TEXT_HTML)"
                    }
                  },
                  "description": "A biography record for a contact."
                },
                "title": "Biographies",
                "description": "List of the contact's biographies"
              },
              "coverPhotos": {
                "type": "array",
                "items": {
                  "type": "object",
                  "additionalProperties": true
                },
                "title": "Cover Photos",
                "description": "List of the contact's cover photos"
              },
              "memberships": {
                "type": "array",
                "items": {
                  "type": "object",
                  "additionalProperties": true
                },
                "title": "Memberships",
                "description": "List of the contact's group memberships"
              },
              "occupations": {
                "type": "array",
                "items": {
                  "type": "object",
                  "additionalProperties": true
                },
                "title": "Occupations",
                "description": "List of the contact's occupations"
              },
              "userDefined": {
                "type": "array",
                "items": {
                  "type": "object",
                  "additionalProperties": true
                },
                "title": "User Defined",
                "description": "List of the contact's user-defined fields"
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
                      "description": "Type of phone number (e.g., mobile, home, work)"
                    },
                    "value": {
                      "type": "string",
                      "title": "Value",
                      "description": "The phone number string"
                    },
                    "metadata": {
                      "type": "object",
                      "title": "Metadata",
                      "properties": {
                        "source": {
                          "type": "object",
                          "title": "Source",
                          "properties": {
                            "id": {
                              "type": "string",
                              "title": "Id",
                              "description": "Identifier of the source record"
                            },
                            "type": {
                              "type": "string",
                              "title": "Type",
                              "description": "Type of the source"
                            }
                          },
                          "description": "Origin of the field data"
                        },
                        "primary": {
                          "type": "boolean",
                          "title": "Primary",
                          "description": "Whether this field is marked as primary"
                        },
                        "sourcePrimary": {
                          "type": "boolean",
                          "title": "Source Primary",
                          "description": "Whether this source is the primary source for the field"
                        }
                      },
                      "description": "Metadata associated with the phone number"
                    },
                    "formattedType": {
                      "type": "string",
                      "title": "Formatted Type",
                      "description": "Formatted type of the phone number"
                    }
                  },
                  "description": "A phone number record for a contact."
                },
                "title": "Phone Numbers",
                "description": "List of the contact's phone numbers"
              },
              "resourceName": {
                "type": "string",
                "title": "Resource Name",
                "description": "Unique resource identifier for the contact"
              },
              "sipAddresses": {
                "type": "array",
                "items": {
                  "type": "object",
                  "additionalProperties": true
                },
                "title": "Sip Addresses",
                "description": "List of the contact's SIP addresses"
              },
              "contactSource": {
                "type": "string",
                "title": "Contact Source",
                "description": "Source of the contact: 'CONTACT' for regular contacts or 'OTHER_CONTACT' for auto-generated contacts from email interactions. OTHER_CONTACT entries often lack fields like names even when requested."
              },
              "organizations": {
                "type": "array",
                "items": {
                  "type": "object",
                  "title": "Organization",
                  "properties": {
                    "name": {
                      "type": "string",
                      "title": "Name",
                      "description": "Name of the organization"
                    },
                    "type": {
                      "type": "string",
                      "title": "Type",
                      "description": "Type of organization (e.g., work, school)"
                    },
                    "title": {
                      "type": "string",
                      "title": "Title",
                      "description": "Job title at the organization"
                    },
                    "metadata": {
                      "type": "object",
                      "title": "Metadata",
                      "properties": {
                        "source": {
                          "type": "object",
                          "title": "Source",
                          "properties": {
                            "id": {
                              "type": "string",
                              "title": "Id",
                              "description": "Identifier of the source record"
                            },
                            "type": {
                              "type": "string",
                              "title": "Type",
                              "description": "Type of the source"
                            }
                          },
                          "description": "Origin of the field data"
                        },
                        "primary": {
                          "type": "boolean",
                          "title": "Primary",
                          "description": "Whether this field is marked as primary"
                        },
                        "sourcePrimary": {
                          "type": "boolean",
                          "title": "Source Primary",
                          "description": "Whether this source is the primary source for the field"
                        }
                      },
                      "description": "Metadata associated with the organization"
                    },
                    "department": {
                      "type": "string",
                      "title": "Department",
                      "description": "Department within the organization"
                    },
                    "formattedType": {
                      "type": "string",
                      "title": "Formatted Type",
                      "description": "Formatted type of the organization"
                    }
                  },
                  "description": "An organization record for a contact."
                },
                "title": "Organizations",
                "description": "List of the contact's organizations"
              },
              "emailAddresses": {
                "type": "array",
                "items": {
                  "type": "object",
                  "title": "EmailAddress",
                  "required": [
                    "value"
                  ],
                  "properties": {
                    "value": {
                      "type": "string",
                      "title": "Value",
                      "description": "The email address string"
                    },
                    "metadata": {
                      "type": "object",
                      "title": "Metadata",
                      "properties": {
                        "source": {
                          "type": "object",
                          "title": "Source",
                          "properties": {
                            "id": {
                              "type": "string",
                              "title": "Id",
                              "description": "Identifier of the source record"
                            },
                            "type": {
                              "type": "string",
                              "title": "Type",
                              "description": "Type of the source"
                            }
                          },
                          "description": "Origin of the field data"
                        },
                        "primary": {
                          "type": "boolean",
                          "title": "Primary",
                          "description": "Whether this field is marked as primary"
                        },
                        "sourcePrimary": {
                          "type": "boolean",
                          "title": "Source Primary",
                          "description": "Whether this source is the primary source for the field"
                        }
                      },
                      "description": "Metadata associated with the email address"
                    }
                  },
                  "description": "An email address record for a contact."
                },
                "title": "Email Addresses",
                "description": "List of the contact's email addresses"
              }
            },
            "description": "A single contact entry."
          },
          "title": "Connections",
          "default": [],
          "description": "List of contact entries"
        },
        "display_url": {
          "type": "string",
          "title": "Display Url",
          "description": "Web UI link for this resource - points to Google Contacts page."
        },
        "totalPeople": {
          "type": "integer",
          "title": "Total People",
          "default": 0,
          "description": "Total number of distinct people returned (deprecated, use totalItems)"
        },
        "nextPageToken": {
          "type": "string",
          "title": "Next Page Token",
          "description": "Token to retrieve the next page of results. Omitted if no more pages."
        },
        "otherContactsCount": {
          "type": "integer",
          "title": "Other Contacts Count",
          "default": 0,
          "description": "Number of contacts from 'Other Contacts' endpoint (may lack requested fields like names)."
        },
        "regularContactsCount": {
          "type": "integer",
          "title": "Regular Contacts Count",
          "default": 0,
          "description": "Number of contacts from regular contacts endpoint (fully support all requested fields)."
        },
        "composio_execution_message": {
          "type": "string",
          "title": "Composio Execution Message",
          "description": "Message explaining any modifications or important notes about the response."
        }
      },
      "description": "Response schema for GMAIL_GET_CONTACTS action."
    }
  },
  "title": "GetContactsResponseWrapper",
  "required": [
    "data",
    "successful"
  ],
  "properties": {
    "data": {
      "type": "object",
      "title": "Data",
      "properties": {
        "totalItems": {
          "type": "integer",
          "title": "Total Items",
          "default": 0,
          "description": "Total number of connections returned"
        },
        "connections": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "Connection",
            "properties": {
              "etag": {
                "type": "string",
                "title": "Etag",
                "description": "Version tag for concurrency control"
              },
              "urls": {
                "type": "array",
                "items": {
                  "type": "object",
                  "title": "Url",
                  "properties": {
                    "type": {
                      "type": "string",
                      "title": "Type",
                      "description": "Type of the URL (e.g., blog, homepage)"
                    },
                    "value": {
                      "type": "string",
                      "title": "Value",
                      "description": "The URL string"
                    },
                    "metadata": {
                      "type": "object",
                      "title": "Metadata",
                      "properties": {
                        "source": {
                          "type": "object",
                          "title": "Source",
                          "properties": {
                            "id": {
                              "type": "string",
                              "title": "Id",
                              "description": "Identifier of the source record"
                            },
                            "type": {
                              "type": "string",
                              "title": "Type",
                              "description": "Type of the source"
                            }
                          },
                          "description": "Origin of the field data"
                        },
                        "primary": {
                          "type": "boolean",
                          "title": "Primary",
                          "description": "Whether this field is marked as primary"
                        },
                        "sourcePrimary": {
                          "type": "boolean",
                          "title": "Source Primary",
                          "description": "Whether this source is the primary source for the field"
                        }
                      },
                      "description": "Metadata associated with the URL"
                    },
                    "formattedType": {
                      "type": "string",
                      "title": "Formatted Type",
                      "description": "Formatted type of the URL"
                    }
                  },
                  "description": "A URL record for a contact."
                },
                "title": "Urls",
                "description": "List of the contact's URLs"
              },
              "names": {
                "type": "array",
                "items": {
                  "type": "object",
                  "title": "Name",
                  "properties": {
                    "metadata": {
                      "type": "object",
                      "title": "Metadata",
                      "properties": {
                        "source": {
                          "type": "object",
                          "title": "Source",
                          "properties": {
                            "id": {
                              "type": "string",
                              "title": "Id",
                              "description": "Identifier of the source record"
                            },
                            "type": {
                              "type": "string",
                              "title": "Type",
                              "description": "Type of the source"
                            }
                          },
                          "description": "Origin of the field data"
                        },
                        "primary": {
                          "type": "boolean",
                          "title": "Primary",
                          "description": "Whether this field is marked as primary"
                        },
                        "sourcePrimary": {
                          "type": "boolean",
                          "title": "Source Primary",
                          "description": "Whether this source is the primary source for the field"
                        }
                      },
                      "description": "Metadata associated with the name field"
                    },
                    "givenName": {
                      "type": "string",
                      "title": "Given Name",
                      "description": "Given (first) name"
                    },
                    "familyName": {
                      "type": "string",
                      "title": "Family Name",
                      "description": "Family (last) name"
                    },
                    "displayName": {
                      "type": "string",
                      "title": "Display Name",
                      "description": "Full display name"
                    },
                    "unstructuredName": {
                      "type": "string",
                      "title": "Unstructured Name",
                      "description": "Unstructured name string"
                    },
                    "displayNameLastFirst": {
                      "type": "string",
                      "title": "Display Name Last First",
                      "description": "Display name formatted as Last, First"
                    }
                  },
                  "description": "A name record for a contact."
                },
                "title": "Names",
                "description": "List of the contact's names"
              },
              "events": {
                "type": "array",
                "items": {
                  "type": "object",
                  "title": "Event",
                  "properties": {
                    "date": {
                      "type": "object",
                      "title": "Date",
                      "description": "Date object with year, month, day fields",
                      "additionalProperties": true
                    },
                    "type": {
                      "type": "string",
                      "title": "Type",
                      "description": "Type of event (e.g., anniversary)"
                    },
                    "metadata": {
                      "type": "object",
                      "title": "Metadata",
                      "properties": {
                        "source": {
                          "type": "object",
                          "title": "Source",
                          "properties": {
                            "id": {
                              "type": "string",
                              "title": "Id",
                              "description": "Identifier of the source record"
                            },
                            "type": {
                              "type": "string",
                              "title": "Type",
                              "description": "Type of the source"
                            }
                          },
                          "description": "Origin of the field data"
                        },
                        "primary": {
                          "type": "boolean",
                          "title": "Primary",
                          "description": "Whether this field is marked as primary"
                        },
                        "sourcePrimary": {
                          "type": "boolean",
                          "title": "Source Primary",
                          "description": "Whether this source is the primary source for the field"
                        }
                      },
                      "description": "Metadata associated with the event"
                    },
                    "formattedType": {
                      "type": "string",
                      "title": "Formatted Type",
                      "description": "Formatted type of the event"
                    }
                  },
                  "description": "An event record for a contact (e.g., anniversary)."
                },
                "title": "Events",
                "description": "List of the contact's events (e.g., anniversaries)"
              },
              "photos": {
                "type": "array",
                "items": {
                  "type": "object",
                  "additionalProperties": true
                },
                "title": "Photos",
                "description": "List of the contact's photos"
              },
              "skills": {
                "type": "array",
                "items": {
                  "type": "object",
                  "additionalProperties": true
                },
                "title": "Skills",
                "description": "List of the contact's skills"
              },
              "genders": {
                "type": "array",
                "items": {
                  "type": "object",
                  "title": "Gender",
                  "properties": {
                    "value": {
                      "type": "string",
                      "title": "Value",
                      "description": "Gender value"
                    },
                    "metadata": {
                      "type": "object",
                      "title": "Metadata",
                      "properties": {
                        "source": {
                          "type": "object",
                          "title": "Source",
                          "properties": {
                            "id": {
                              "type": "string",
                              "title": "Id",
                              "description": "Identifier of the source record"
                            },
                            "type": {
                              "type": "string",
                              "title": "Type",
                              "description": "Type of the source"
                            }
                          },
                          "description": "Origin of the field data"
                        },
                        "primary": {
                          "type": "boolean",
                          "title": "Primary",
                          "description": "Whether this field is marked as primary"
                        },
                        "sourcePrimary": {
                          "type": "boolean",
                          "title": "Source Primary",
                          "description": "Whether this source is the primary source for the field"
                        }
                      },
                      "description": "Metadata associated with the gender"
                    },
                    "formattedValue": {
                      "type": "string",
                      "title": "Formatted Value",
                      "description": "Formatted gender value"
                    }
                  },
                  "description": "A gender record for a contact."
                },
                "title": "Genders",
                "description": "List of the contact's genders"
              },
              "locales": {
                "type": "array",
                "items": {
                  "type": "object",
                  "additionalProperties": true
                },
                "title": "Locales",
                "description": "List of the contact's locale preferences"
              },
              "metadata": {
                "type": "object",
                "title": "Metadata",
                "description": "Metadata about the contact",
                "additionalProperties": true
              },
              "addresses": {
                "type": "array",
                "items": {
                  "type": "object",
                  "title": "Address",
                  "properties": {
                    "city": {
                      "type": "string",
                      "title": "City",
                      "description": "City"
                    },
                    "type": {
                      "type": "string",
                      "title": "Type",
                      "description": "Type of address (e.g., home, work)"
                    },
                    "region": {
                      "type": "string",
                      "title": "Region",
                      "description": "Region or state"
                    },
                    "country": {
                      "type": "string",
                      "title": "Country",
                      "description": "Country"
                    },
                    "metadata": {
                      "type": "object",
                      "title": "Metadata",
                      "properties": {
                        "source": {
                          "type": "object",
                          "title": "Source",
                          "properties": {
                            "id": {
                              "type": "string",
                              "title": "Id",
                              "description": "Identifier of the source record"
                            },
                            "type": {
                              "type": "string",
                              "title": "Type",
                              "description": "Type of the source"
                            }
                          },
                          "description": "Origin of the field data"
                        },
                        "primary": {
                          "type": "boolean",
                          "title": "Primary",
                          "description": "Whether this field is marked as primary"
                        },
                        "sourcePrimary": {
                          "type": "boolean",
                          "title": "Source Primary",
                          "description": "Whether this source is the primary source for the field"
                        }
                      },
                      "description": "Metadata associated with the address"
                    },
                    "postalCode": {
                      "type": "string",
                      "title": "Postal Code",
                      "description": "Postal code"
                    },
                    "countryCode": {
                      "type": "string",
                      "title": "Country Code",
                      "description": "Country code"
                    },
                    "formattedType": {
                      "type": "string",
                      "title": "Formatted Type",
                      "description": "Formatted type of the address"
                    },
                    "streetAddress": {
                      "type": "string",
                      "title": "Street Address",
                      "description": "Street address"
                    },
                    "formattedValue": {
                      "type": "string",
                      "title": "Formatted Value",
                      "description": "Formatted string of the address"
                    }
                  },
                  "description": "An address record for a contact."
                },
                "title": "Addresses",
                "description": "List of the contact's addresses"
              },
              "ageRanges": {
                "type": "array",
                "items": {
                  "type": "object",
                  "additionalProperties": true
                },
                "title": "Age Ranges",
                "description": "List of the contact's age ranges"
              },
              "birthdays": {
                "type": "array",
                "items": {
                  "type": "object",
                  "title": "Birthday",
                  "properties": {
                    "date": {
                      "type": "object",
                      "title": "Date",
                      "description": "Date object with year, month, day fields",
                      "additionalProperties": true
                    },
                    "text": {
                      "type": "string",
                      "title": "Text",
                      "description": "Free-form text representation of the birthday"
                    },
                    "metadata": {
                      "type": "object",
                      "title": "Metadata",
                      "properties": {
                        "source": {
                          "type": "object",
                          "title": "Source",
                          "properties": {
                            "id": {
                              "type": "string",
                              "title": "Id",
                              "description": "Identifier of the source record"
                            },
                            "type": {
                              "type": "string",
                              "title": "Type",
                              "description": "Type of the source"
                            }
                          },
                          "description": "Origin of the field data"
                        },
                        "primary": {
                          "type": "boolean",
                          "title": "Primary",
                          "description": "Whether this field is marked as primary"
                        },
                        "sourcePrimary": {
                          "type": "boolean",
                          "title": "Source Primary",
                          "description": "Whether this source is the primary source for the field"
                        }
                      },
                      "description": "Metadata associated with the birthday"
                    }
                  },
                  "description": "A birthday record for a contact."
                },
                "title": "Birthdays",
                "description": "List of the contact's birthdays"
              },
              "imClients": {
                "type": "array",
                "items": {
                  "type": "object",
                  "additionalProperties": true
                },
                "title": "Im Clients",
                "description": "List of the contact's IM clients"
              },
              "interests": {
                "type": "array",
                "items": {
                  "type": "object",
                  "additionalProperties": true
                },
                "title": "Interests",
                "description": "List of the contact's interests"
              },
              "nicknames": {
                "type": "array",
                "items": {
                  "type": "object",
                  "additionalProperties": true
                },
                "title": "Nicknames",
                "description": "List of the contact's nicknames"
              },
              "relations": {
                "type": "array",
                "items": {
                  "type": "object",
                  "title": "Relation",
                  "properties": {
                    "type": {
                      "type": "string",
                      "title": "Type",
                      "description": "Type of relation (e.g., spouse, parent)"
                    },
                    "person": {
                      "type": "string",
                      "title": "Person",
                      "description": "Name of the related person"
                    },
                    "metadata": {
                      "type": "object",
                      "title": "Metadata",
                      "properties": {
                        "source": {
                          "type": "object",
                          "title": "Source",
                          "properties": {
                            "id": {
                              "type": "string",
                              "title": "Id",
                              "description": "Identifier of the source record"
                            },
                            "type": {
                              "type": "string",
                              "title": "Type",
                              "description": "Type of the source"
                            }
                          },
                          "description": "Origin of the field data"
                        },
                        "primary": {
                          "type": "boolean",
                          "title": "Primary",
                          "description": "Whether this field is marked as primary"
                        },
                        "sourcePrimary": {
                          "type": "boolean",
                          "title": "Source Primary",
                          "description": "Whether this source is the primary source for the field"
                        }
                      },
                      "description": "Metadata associated with the relation"
                    },
                    "formattedType": {
                      "type": "string",
                      "title": "Formatted Type",
                      "description": "Formatted type of the relation"
                    }
                  },
                  "description": "A relation record for a contact."
                },
                "title": "Relations",
                "description": "List of the contact's relations"
              },
              "residences": {
                "type": "array",
                "items": {
                  "type": "object",
                  "additionalProperties": true
                },
                "title": "Residences",
                "description": "List of the contact's residences (deprecated)"
              },
              "biographies": {
                "type": "array",
                "items": {
                  "type": "object",
                  "title": "Biography",
                  "properties": {
                    "value": {
                      "type": "string",
                      "title": "Value",
                      "description": "Biography text"
                    },
                    "metadata": {
                      "type": "object",
                      "title": "Metadata",
                      "properties": {
                        "source": {
                          "type": "object",
                          "title": "Source",
                          "properties": {
                            "id": {
                              "type": "string",
                              "title": "Id",
                              "description": "Identifier of the source record"
                            },
                            "type": {
                              "type": "string",
                              "title": "Type",
                              "description": "Type of the source"
                            }
                          },
                          "description": "Origin of the field data"
                        },
                        "primary": {
                          "type": "boolean",
                          "title": "Primary",
                          "description": "Whether this field is marked as primary"
                        },
                        "sourcePrimary": {
                          "type": "boolean",
                          "title": "Source Primary",
                          "description": "Whether this source is the primary source for the field"
                        }
                      },
                      "description": "Metadata associated with the biography"
                    },
                    "contentType": {
                      "type": "string",
                      "title": "Content Type",
                      "description": "Content type of the biography (e.g., TEXT_PLAIN, TEXT_HTML)"
                    }
                  },
                  "description": "A biography record for a contact."
                },
                "title": "Biographies",
                "description": "List of the contact's biographies"
              },
              "coverPhotos": {
                "type": "array",
                "items": {
                  "type": "object",
                  "additionalProperties": true
                },
                "title": "Cover Photos",
                "description": "List of the contact's cover photos"
              },
              "memberships": {
                "type": "array",
                "items": {
                  "type": "object",
                  "additionalProperties": true
                },
                "title": "Memberships",
                "description": "List of the contact's group memberships"
              },
              "occupations": {
                "type": "array",
                "items": {
                  "type": "object",
                  "additionalProperties": true
                },
                "title": "Occupations",
                "description": "List of the contact's occupations"
              },
              "userDefined": {
                "type": "array",
                "items": {
                  "type": "object",
                  "additionalProperties": true
                },
                "title": "User Defined",
                "description": "List of the contact's user-defined fields"
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
                      "description": "Type of phone number (e.g., mobile, home, work)"
                    },
                    "value": {
                      "type": "string",
                      "title": "Value",
                      "description": "The phone number string"
                    },
                    "metadata": {
                      "type": "object",
                      "title": "Metadata",
                      "properties": {
                        "source": {
                          "type": "object",
                          "title": "Source",
                          "properties": {
                            "id": {
                              "type": "string",
                              "title": "Id",
                              "description": "Identifier of the source record"
                            },
                            "type": {
                              "type": "string",
                              "title": "Type",
                              "description": "Type of the source"
                            }
                          },
                          "description": "Origin of the field data"
                        },
                        "primary": {
                          "type": "boolean",
                          "title": "Primary",
                          "description": "Whether this field is marked as primary"
                        },
                        "sourcePrimary": {
                          "type": "boolean",
                          "title": "Source Primary",
                          "description": "Whether this source is the primary source for the field"
                        }
                      },
                      "description": "Metadata associated with the phone number"
                    },
                    "formattedType": {
                      "type": "string",
                      "title": "Formatted Type",
                      "description": "Formatted type of the phone number"
                    }
                  },
                  "description": "A phone number record for a contact."
                },
                "title": "Phone Numbers",
                "description": "List of the contact's phone numbers"
              },
              "resourceName": {
                "type": "string",
                "title": "Resource Name",
                "description": "Unique resource identifier for the contact"
              },
              "sipAddresses": {
                "type": "array",
                "items": {
                  "type": "object",
                  "additionalProperties": true
                },
                "title": "Sip Addresses",
                "description": "List of the contact's SIP addresses"
              },
              "contactSource": {
                "type": "string",
                "title": "Contact Source",
                "description": "Source of the contact: 'CONTACT' for regular contacts or 'OTHER_CONTACT' for auto-generated contacts from email interactions. OTHER_CONTACT entries often lack fields like names even when requested."
              },
              "organizations": {
                "type": "array",
                "items": {
                  "type": "object",
                  "title": "Organization",
                  "properties": {
                    "name": {
                      "type": "string",
                      "title": "Name",
                      "description": "Name of the organization"
                    },
                    "type": {
                      "type": "string",
                      "title": "Type",
                      "description": "Type of organization (e.g., work, school)"
                    },
                    "title": {
                      "type": "string",
                      "title": "Title",
                      "description": "Job title at the organization"
                    },
                    "metadata": {
                      "type": "object",
                      "title": "Metadata",
                      "properties": {
                        "source": {
                          "type": "object",
                          "title": "Source",
                          "properties": {
                            "id": {
                              "type": "string",
                              "title": "Id",
                              "description": "Identifier of the source record"
                            },
                            "type": {
                              "type": "string",
                              "title": "Type",
                              "description": "Type of the source"
                            }
                          },
                          "description": "Origin of the field data"
                        },
                        "primary": {
                          "type": "boolean",
                          "title": "Primary",
                          "description": "Whether this field is marked as primary"
                        },
                        "sourcePrimary": {
                          "type": "boolean",
                          "title": "Source Primary",
                          "description": "Whether this source is the primary source for the field"
                        }
                      },
                      "description": "Metadata associated with the organization"
                    },
                    "department": {
                      "type": "string",
                      "title": "Department",
                      "description": "Department within the organization"
                    },
                    "formattedType": {
                      "type": "string",
                      "title": "Formatted Type",
                      "description": "Formatted type of the organization"
                    }
                  },
                  "description": "An organization record for a contact."
                },
                "title": "Organizations",
                "description": "List of the contact's organizations"
              },
              "emailAddresses": {
                "type": "array",
                "items": {
                  "type": "object",
                  "title": "EmailAddress",
                  "required": [
                    "value"
                  ],
                  "properties": {
                    "value": {
                      "type": "string",
                      "title": "Value",
                      "description": "The email address string"
                    },
                    "metadata": {
                      "type": "object",
                      "title": "Metadata",
                      "properties": {
                        "source": {
                          "type": "object",
                          "title": "Source",
                          "properties": {
                            "id": {
                              "type": "string",
                              "title": "Id",
                              "description": "Identifier of the source record"
                            },
                            "type": {
                              "type": "string",
                              "title": "Type",
                              "description": "Type of the source"
                            }
                          },
                          "description": "Origin of the field data"
                        },
                        "primary": {
                          "type": "boolean",
                          "title": "Primary",
                          "description": "Whether this field is marked as primary"
                        },
                        "sourcePrimary": {
                          "type": "boolean",
                          "title": "Source Primary",
                          "description": "Whether this source is the primary source for the field"
                        }
                      },
                      "description": "Metadata associated with the email address"
                    }
                  },
                  "description": "An email address record for a contact."
                },
                "title": "Email Addresses",
                "description": "List of the contact's email addresses"
              }
            },
            "description": "A single contact entry."
          },
          "title": "Connections",
          "default": [],
          "description": "List of contact entries"
        },
        "display_url": {
          "type": "string",
          "title": "Display Url",
          "description": "Web UI link for this resource - points to Google Contacts page."
        },
        "totalPeople": {
          "type": "integer",
          "title": "Total People",
          "default": 0,
          "description": "Total number of distinct people returned (deprecated, use totalItems)"
        },
        "nextPageToken": {
          "type": "string",
          "title": "Next Page Token",
          "description": "Token to retrieve the next page of results. Omitted if no more pages."
        },
        "otherContactsCount": {
          "type": "integer",
          "title": "Other Contacts Count",
          "default": 0,
          "description": "Number of contacts from 'Other Contacts' endpoint (may lack requested fields like names)."
        },
        "regularContactsCount": {
          "type": "integer",
          "title": "Regular Contacts Count",
          "default": 0,
          "description": "Number of contacts from regular contacts endpoint (fully support all requested fields)."
        },
        "composio_execution_message": {
          "type": "string",
          "title": "Composio Execution Message",
          "description": "Message explaining any modifications or important notes about the response."
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

## GMAIL_GET_DRAFT
Retrieves a single Gmail draft by its ID. Use this to fetch and inspect draft content before sending via GMAIL_SEND_DRAFT. The format parameter controls the level of detail returned.

**Input schema:**
```json
{
  "type": "object",
  "title": "GetDraftRequest",
  "required": [
    "draft_id"
  ],
  "properties": {
    "format": {
      "type": "string",
      "title": "Format",
      "default": "full",
      "examples": [
        "full",
        "metadata",
        "minimal",
        "raw"
      ],
      "description": "Format for the draft message: 'minimal' (ID/labels only), 'full' (complete data with parsed payload), 'raw' (base64url-encoded RFC 2822 format), 'metadata' (ID/labels/headers only)."
    },
    "user_id": {
      "type": "string",
      "title": "User Id",
      "default": "me",
      "examples": [
        "me",
        "user@example.com"
      ],
      "description": "The user's email address. The special value `me` can be used to indicate the authenticated user."
    },
    "draft_id": {
      "type": "string",
      "title": "Draft Id",
      "examples": [
        "r99885592323229922",
        "r-8388446164079304564"
      ],
      "description": "The ID of the draft to retrieve. Draft IDs are typically alphanumeric strings (e.g., 'r99885592323229922'). Use GMAIL_LIST_DRAFTS to retrieve valid draft IDs."
    }
  }
}
```

**Output schema:**
```json
{
  "type": "object",
  "$defs": {
    "DraftMessage": {
      "type": "object",
      "title": "DraftMessage",
      "properties": {
        "to": {
          "type": "string",
          "title": "To",
          "description": "The recipient (To header) of the draft message"
        },
        "raw": {
          "type": "string",
          "title": "Raw",
          "description": "The entire email message in RFC 2822 format, base64url-encoded (only present when format=raw)"
        },
        "sender": {
          "type": "string",
          "title": "Sender",
          "description": "The sender (From header) of the draft message"
        },
        "payload": {
          "type": "object",
          "title": "Payload",
          "description": "The MIME payload structure of the draft message",
          "additionalProperties": true
        },
        "preview": {
          "type": "object",
          "title": "Preview",
          "description": "A preview of the draft message with subject and body snippet",
          "additionalProperties": true
        },
        "subject": {
          "type": "string",
          "title": "Subject",
          "description": "The subject line of the draft message"
        },
        "labelIds": {
          "type": "array",
          "items": {
            "type": "string"
          },
          "title": "Label Ids",
          "description": "The label IDs applied to the draft message"
        },
        "threadId": {
          "type": "string",
          "title": "Thread Id",
          "description": "The thread ID of the draft message"
        },
        "messageId": {
          "type": "string",
          "title": "Message Id",
          "description": "The message ID of the draft message"
        },
        "messageText": {
          "type": "string",
          "title": "Message Text",
          "description": "The full text content of the draft message"
        },
        "attachmentList": {
          "type": "array",
          "items": {
            "type": "object",
            "additionalProperties": true
          },
          "title": "Attachment List",
          "description": "The list of attachments in the draft message"
        },
        "messageTimestamp": {
          "type": "string",
          "title": "Message Timestamp",
          "description": "The timestamp of the draft message in ISO-8601 format"
        }
      },
      "description": "The message content of the draft"
    },
    "GetDraftResponse": {
      "type": "object",
      "title": "GetDraftResponse",
      "required": [
        "id",
        "message"
      ],
      "properties": {
        "id": {
          "type": "string",
          "title": "Id",
          "description": "The immutable ID of the draft"
        },
        "message": {
          "type": "object",
          "title": "Message",
          "properties": {
            "to": {
              "type": "string",
              "title": "To",
              "description": "The recipient (To header) of the draft message"
            },
            "raw": {
              "type": "string",
              "title": "Raw",
              "description": "The entire email message in RFC 2822 format, base64url-encoded (only present when format=raw)"
            },
            "sender": {
              "type": "string",
              "title": "Sender",
              "description": "The sender (From header) of the draft message"
            },
            "payload": {
              "type": "object",
              "title": "Payload",
              "description": "The MIME payload structure of the draft message",
              "additionalProperties": true
            },
            "preview": {
              "type": "object",
              "title": "Preview",
              "description": "A preview of the draft message with subject and body snippet",
              "additionalProperties": true
            },
            "subject": {
              "type": "string",
              "title": "Subject",
              "description": "The subject line of the draft message"
            },
            "labelIds": {
              "type": "array",
              "items": {
                "type": "string"
              },
              "title": "Label Ids",
              "description": "The label IDs applied to the draft message"
            },
            "threadId": {
              "type": "string",
              "title": "Thread Id",
              "description": "The thread ID of the draft message"
            },
            "messageId": {
              "type": "string",
              "title": "Message Id",
              "description": "The message ID of the draft message"
            },
            "messageText": {
              "type": "string",
              "title": "Message Text",
              "description": "The full text content of the draft message"
            },
            "attachmentList": {
              "type": "array",
              "items": {
                "type": "object",
                "additionalProperties": true
              },
              "title": "Attachment List",
              "description": "The list of attachments in the draft message"
            },
            "messageTimestamp": {
              "type": "string",
              "title": "Message Timestamp",
              "description": "The timestamp of the draft message in ISO-8601 format"
            }
          },
          "description": "The message content of the draft"
        },
        "display_url": {
          "type": "string",
          "title": "Display Url",
          "description": "Web UI link to view this draft in Gmail"
        }
      },
      "description": "Response containing the draft details"
    }
  },
  "title": "GetDraftResponseWrapper",
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
        "message"
      ],
      "properties": {
        "id": {
          "type": "string",
          "title": "Id",
          "description": "The immutable ID of the draft"
        },
        "message": {
          "type": "object",
          "title": "Message",
          "properties": {
            "to": {
              "type": "string",
              "title": "To",
              "description": "The recipient (To header) of the draft message"
            },
            "raw": {
              "type": "string",
              "title": "Raw",
              "description": "The entire email message in RFC 2822 format, base64url-encoded (only present when format=raw)"
            },
            "sender": {
              "type": "string",
              "title": "Sender",
              "description": "The sender (From header) of the draft message"
            },
            "payload": {
              "type": "object",
              "title": "Payload",
              "description": "The MIME payload structure of the draft message",
              "additionalProperties": true
            },
            "preview": {
              "type": "object",
              "title": "Preview",
              "description": "A preview of the draft message with subject and body snippet",
              "additionalProperties": true
            },
            "subject": {
              "type": "string",
              "title": "Subject",
              "description": "The subject line of the draft message"
            },
            "labelIds": {
              "type": "array",
              "items": {
                "type": "string"
              },
              "title": "Label Ids",
              "description": "The label IDs applied to the draft message"
            },
            "threadId": {
              "type": "string",
              "title": "Thread Id",
              "description": "The thread ID of the draft message"
            },
            "messageId": {
              "type": "string",
              "title": "Message Id",
              "description": "The message ID of the draft message"
            },
            "messageText": {
              "type": "string",
              "title": "Message Text",
              "description": "The full text content of the draft message"
            },
            "attachmentList": {
              "type": "array",
              "items": {
                "type": "object",
                "additionalProperties": true
              },
              "title": "Attachment List",
              "description": "The list of attachments in the draft message"
            },
            "messageTimestamp": {
              "type": "string",
              "title": "Message Timestamp",
              "description": "The timestamp of the draft message in ISO-8601 format"
            }
          },
          "description": "The message content of the draft"
        },
        "display_url": {
          "type": "string",
          "title": "Display Url",
          "description": "Web UI link to view this draft in Gmail"
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

## GMAIL_GET_FILTER
Tool to retrieve a specific Gmail filter by its ID. Use when you need to inspect the criteria and actions of an existing filter.

**Input schema:**
```json
{
  "type": "object",
  "title": "GetFilterRequest",
  "required": [
    "id"
  ],
  "properties": {
    "id": {
      "type": "string",
      "title": "Id",
      "examples": [
        "ANe1BmjnwmKdVlXGMLeKsv98UJGFe82pUGCsVQ"
      ],
      "description": "The ID of the filter to be fetched."
    },
    "user_id": {
      "type": "string",
      "title": "User Id",
      "default": "me",
      "examples": [
        "me",
        "user@example.com"
      ],
      "description": "The user's email address or the special value 'me' to indicate the authenticated user."
    }
  }
}
```

**Output schema:**
```json
{
  "type": "object",
  "$defs": {
    "FilterAction": {
      "type": "object",
      "title": "FilterAction",
      "properties": {
        "forward": {
          "type": "string",
          "title": "Forward",
          "description": "Email address that the message should be forwarded to."
        },
        "addLabelIds": {
          "type": "array",
          "items": {
            "type": "string"
          },
          "title": "Add Label Ids",
          "description": "List of label IDs to add to the message."
        },
        "removeLabelIds": {
          "type": "array",
          "items": {
            "type": "string"
          },
          "title": "Remove Label Ids",
          "description": "List of label IDs to remove from the message."
        }
      },
      "description": "Action that the filter performs on matched messages."
    },
    "FilterCriteria": {
      "type": "object",
      "title": "FilterCriteria",
      "properties": {
        "to": {
          "type": "string",
          "title": "To",
          "description": "The recipient's display name or email address (includes to, cc, and bcc fields)."
        },
        "from": {
          "type": "string",
          "title": "From",
          "description": "The sender's display name or email address."
        },
        "size": {
          "type": "integer",
          "title": "Size",
          "description": "The size of the entire RFC822 message in bytes."
        },
        "query": {
          "type": "string",
          "title": "Query",
          "description": "Only return messages matching the specified query using Gmail search syntax."
        },
        "subject": {
          "type": "string",
          "title": "Subject",
          "description": "Case-insensitive phrase found in the message's subject."
        },
        "excludeChats": {
          "type": "boolean",
          "title": "Exclude Chats",
          "description": "Whether the response should exclude chats."
        },
        "negatedQuery": {
          "type": "string",
          "title": "Negated Query",
          "description": "Only return messages not matching the specified query."
        },
        "hasAttachment": {
          "type": "boolean",
          "title": "Has Attachment",
          "description": "Whether the message has any attachment."
        },
        "sizeComparison": {
          "type": "string",
          "title": "Size Comparison",
          "description": "How the message size should be compared to the size field. Values: unspecified, smaller, larger."
        }
      },
      "description": "Message matching criteria for the filter."
    },
    "GetFilterResponse": {
      "type": "object",
      "title": "GetFilterResponse",
      "properties": {
        "id": {
          "type": "string",
          "title": "Id",
          "description": "The server assigned ID of the filter."
        },
        "action": {
          "type": "object",
          "title": "Action",
          "properties": {
            "forward": {
              "type": "string",
              "title": "Forward",
              "description": "Email address that the message should be forwarded to."
            },
            "addLabelIds": {
              "type": "array",
              "items": {
                "type": "string"
              },
              "title": "Add Label Ids",
              "description": "List of label IDs to add to the message."
            },
            "removeLabelIds": {
              "type": "array",
              "items": {
                "type": "string"
              },
              "title": "Remove Label Ids",
              "description": "List of label IDs to remove from the message."
            }
          },
          "description": "Action that the filter performs."
        },
        "criteria": {
          "type": "object",
          "title": "Criteria",
          "properties": {
            "to": {
              "type": "string",
              "title": "To",
              "description": "The recipient's display name or email address (includes to, cc, and bcc fields)."
            },
            "from": {
              "type": "string",
              "title": "From",
              "description": "The sender's display name or email address."
            },
            "size": {
              "type": "integer",
              "title": "Size",
              "description": "The size of the entire RFC822 message in bytes."
            },
            "query": {
              "type": "string",
              "title": "Query",
              "description": "Only return messages matching the specified query using Gmail search syntax."
            },
            "subject": {
              "type": "string",
              "title": "Subject",
              "description": "Case-insensitive phrase found in the message's subject."
            },
            "excludeChats": {
              "type": "boolean",
              "title": "Exclude Chats",
              "description": "Whether the response should exclude chats."
            },
            "negatedQuery": {
              "type": "string",
              "title": "Negated Query",
              "description": "Only return messages not matching the specified query."
            },
            "hasAttachment": {
              "type": "boolean",
              "title": "Has Attachment",
              "description": "Whether the message has any attachment."
            },
            "sizeComparison": {
              "type": "string",
              "title": "Size Comparison",
              "description": "How the message size should be compared to the size field. Values: unspecified, smaller, larger."
            }
          },
          "description": "Matching criteria for the filter."
        }
      },
      "description": "A Gmail filter configuration."
    }
  },
  "title": "GetFilterResponseWrapper",
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
          "description": "The server assigned ID of the filter."
        },
        "action": {
          "type": "object",
          "title": "Action",
          "properties": {
            "forward": {
              "type": "string",
              "title": "Forward",
              "description": "Email address that the message should be forwarded to."
            },
            "addLabelIds": {
              "type": "array",
              "items": {
                "type": "string"
              },
              "title": "Add Label Ids",
              "description": "List of label IDs to add to the message."
            },
            "removeLabelIds": {
              "type": "array",
              "items": {
                "type": "string"
              },
              "title": "Remove Label Ids",
              "description": "List of label IDs to remove from the message."
            }
          },
          "description": "Action that the filter performs."
        },
        "criteria": {
          "type": "object",
          "title": "Criteria",
          "properties": {
            "to": {
              "type": "string",
              "title": "To",
              "description": "The recipient's display name or email address (includes to, cc, and bcc fields)."
            },
            "from": {
              "type": "string",
              "title": "From",
              "description": "The sender's display name or email address."
            },
            "size": {
              "type": "integer",
              "title": "Size",
              "description": "The size of the entire RFC822 message in bytes."
            },
            "query": {
              "type": "string",
              "title": "Query",
              "description": "Only return messages matching the specified query using Gmail search syntax."
            },
            "subject": {
              "type": "string",
              "title": "Subject",
              "description": "Case-insensitive phrase found in the message's subject."
            },
            "excludeChats": {
              "type": "boolean",
              "title": "Exclude Chats",
              "description": "Whether the response should exclude chats."
            },
            "negatedQuery": {
              "type": "string",
              "title": "Negated Query",
              "description": "Only return messages not matching the specified query."
            },
            "hasAttachment": {
              "type": "boolean",
              "title": "Has Attachment",
              "description": "Whether the message has any attachment."
            },
            "sizeComparison": {
              "type": "string",
              "title": "Size Comparison",
              "description": "How the message size should be compared to the size field. Values: unspecified, smaller, larger."
            }
          },
          "description": "Matching criteria for the filter."
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

## GMAIL_GET_LABEL
Gets details for a specified Gmail label. Use this to retrieve label information including name, type, visibility settings, message/thread counts, and color.

**Input schema:**
```json
{
  "type": "object",
  "title": "GetLabelRequest",
  "required": [
    "id"
  ],
  "properties": {
    "id": {
      "type": "string",
      "title": "Id",
      "examples": [
        "INBOX",
        "SENT",
        "Label_1",
        "Label_42"
      ],
      "description": "The ID of the label to retrieve. Can be a system label (e.g., INBOX, SENT, DRAFT, UNREAD, STARRED, SPAM, TRASH) or a user-created label ID (e.g., Label_1, Label_42)."
    },
    "user_id": {
      "type": "string",
      "title": "User Id",
      "default": "me",
      "examples": [
        "me",
        "user@example.com"
      ],
      "description": "The user's email address. The special value 'me' can be used to indicate the authenticated user."
    }
  }
}
```

**Output schema:**
```json
{
  "type": "object",
  "$defs": {
    "LabelColor": {
      "type": "object",
      "title": "LabelColor",
      "properties": {
        "textColor": {
          "type": "string",
          "title": "Text Color",
          "description": "The text color of the label, represented as hex string. Only predefined Gmail colors are allowed."
        },
        "backgroundColor": {
          "type": "string",
          "title": "Background Color",
          "description": "The background color represented as hex string #RRGGBB (e.g., #000000). Only predefined Gmail colors are allowed."
        }
      }
    },
    "GetLabelResponse": {
      "type": "object",
      "title": "GetLabelResponse",
      "required": [
        "id",
        "name"
      ],
      "properties": {
        "id": {
          "type": "string",
          "title": "Id",
          "description": "The immutable ID of the label."
        },
        "name": {
          "type": "string",
          "title": "Name",
          "description": "The display name of the label."
        },
        "type": {
          "type": "string",
          "title": "Type",
          "description": "The owner type for the label. Values: 'system' (cannot be modified/deleted) or 'user' (created by user)."
        },
        "color": {
          "type": "object",
          "title": "Color",
          "properties": {
            "textColor": {
              "type": "string",
              "title": "Text Color",
              "description": "The text color of the label, represented as hex string. Only predefined Gmail colors are allowed."
            },
            "backgroundColor": {
              "type": "string",
              "title": "Background Color",
              "description": "The background color represented as hex string #RRGGBB (e.g., #000000). Only predefined Gmail colors are allowed."
            }
          },
          "description": "The color settings for the label (user labels only)."
        },
        "display_url": {
          "type": "string",
          "title": "Display Url",
          "description": "Web UI link for this label - Gmail settings labels page or specific label view."
        },
        "threadsTotal": {
          "type": "integer",
          "title": "Threads Total",
          "description": "The total number of threads with the label."
        },
        "messagesTotal": {
          "type": "integer",
          "title": "Messages Total",
          "description": "The total number of messages with the label."
        },
        "threadsUnread": {
          "type": "integer",
          "title": "Threads Unread",
          "description": "The number of unread threads with the label."
        },
        "messagesUnread": {
          "type": "integer",
          "title": "Messages Unread",
          "description": "The number of unread messages with the label."
        },
        "labelListVisibility": {
          "type": "string",
          "title": "Label List Visibility",
          "description": "The visibility of the label in the label list in the Gmail web interface. Values: 'labelShow', 'labelShowIfUnread', or 'labelHide'."
        },
        "messageListVisibility": {
          "type": "string",
          "title": "Message List Visibility",
          "description": "The visibility of messages with this label in the message list in the Gmail web interface. Values: 'show' or 'hide'."
        }
      }
    }
  },
  "title": "GetLabelResponseWrapper",
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
          "description": "The immutable ID of the label."
        },
        "name": {
          "type": "string",
          "title": "Name",
          "description": "The display name of the label."
        },
        "type": {
          "type": "string",
          "title": "Type",
          "description": "The owner type for the label. Values: 'system' (cannot be modified/deleted) or 'user' (created by user)."
        },
        "color": {
          "type": "object",
          "title": "Color",
          "properties": {
            "textColor": {
              "type": "string",
              "title": "Text Color",
              "description": "The text color of the label, represented as hex string. Only predefined Gmail colors are allowed."
            },
            "backgroundColor": {
              "type": "string",
              "title": "Background Color",
              "description": "The background color represented as hex string #RRGGBB (e.g., #000000). Only predefined Gmail colors are allowed."
            }
          },
          "description": "The color settings for the label (user labels only)."
        },
        "display_url": {
          "type": "string",
          "title": "Display Url",
          "description": "Web UI link for this label - Gmail settings labels page or specific label view."
        },
        "threadsTotal": {
          "type": "integer",
          "title": "Threads Total",
          "description": "The total number of threads with the label."
        },
        "messagesTotal": {
          "type": "integer",
          "title": "Messages Total",
          "description": "The total number of messages with the label."
        },
        "threadsUnread": {
          "type": "integer",
          "title": "Threads Unread",
          "description": "The number of unread threads with the label."
        },
        "messagesUnread": {
          "type": "integer",
          "title": "Messages Unread",
          "description": "The number of unread messages with the label."
        },
        "labelListVisibility": {
          "type": "string",
          "title": "Label List Visibility",
          "description": "The visibility of the label in the label list in the Gmail web interface. Values: 'labelShow', 'labelShowIfUnread', or 'labelHide'."
        },
        "messageListVisibility": {
          "type": "string",
          "title": "Message List Visibility",
          "description": "The visibility of messages with this label in the message list in the Gmail web interface. Values: 'show' or 'hide'."
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

## GMAIL_GET_LANGUAGE_SETTINGS
Tool to retrieve the language settings for a Gmail user. Use when you need to determine the display language preference for the authenticated user or a specific Gmail account.

**Input schema:**
```json
{
  "type": "object",
  "title": "GetLanguageSettingsRequest",
  "properties": {
    "user_id": {
      "type": "string",
      "title": "User Id",
      "default": "me",
      "examples": [
        "me",
        "user@example.com"
      ],
      "description": "The email address of the Gmail user whose language settings are to be retrieved, or the special value 'me' to indicate the currently authenticated user."
    }
  }
}
```

**Output schema:**
```json
{
  "type": "object",
  "$defs": {
    "GetLanguageSettingsResponse": {
      "type": "object",
      "title": "GetLanguageSettingsResponse",
      "properties": {
        "display_url": {
          "type": "string",
          "title": "Display Url",
          "description": "Web UI link for this resource - set by each action's execute()."
        },
        "displayLanguage": {
          "type": "string",
          "title": "Display Language",
          "description": "The language to display Gmail in, formatted as an RFC 3066 Language Tag (for example en-GB, fr or ja). The supported languages correspond to the Language dropdown in Gmail settings."
        }
      },
      "description": "The user's Gmail language settings, including the display language formatted as an RFC 3066 Language Tag."
    }
  },
  "title": "GetLanguageSettingsResponseWrapper",
  "required": [
    "data",
    "successful"
  ],
  "properties": {
    "data": {
      "type": "object",
      "title": "Data",
      "properties": {
        "display_url": {
          "type": "string",
          "title": "Display Url",
          "description": "Web UI link for this resource - set by each action's execute()."
        },
        "displayLanguage": {
          "type": "string",
          "title": "Display Language",
          "description": "The language to display Gmail in, formatted as an RFC 3066 Language Tag (for example en-GB, fr or ja). The supported languages correspond to the Language dropdown in Gmail settings."
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

## GMAIL_GET_PEOPLE
Retrieves either a specific person's details (using `resource_name`) or lists 'Other Contacts' (if `other_contacts` is true), with `person_fields` specifying the data to return. Scope is limited to the authenticated user's own contacts and 'Other Contacts' history only.

**Input schema:**
```json
{
  "type": "object",
  "title": "GetPeopleRequest",
  "properties": {
    "sources": {
      "type": "array",
      "items": {
        "enum": [
          "READ_SOURCE_TYPE_CONTACT",
          "READ_SOURCE_TYPE_PROFILE"
        ],
        "type": "string",
        "title": "ReadSourceType",
        "description": "Source types for reading other contacts."
      },
      "title": "Sources",
      "default": [
        "READ_SOURCE_TYPE_CONTACT",
        "READ_SOURCE_TYPE_PROFILE"
      ],
      "minItems": 1,
      "description": "Source types to include when retrieving other contacts. READ_SOURCE_TYPE_CONTACT supports basic fields (emailAddresses, metadata, names, phoneNumbers, photos). READ_SOURCE_TYPE_PROFILE supports extended fields (birthdays, genders, organizations, etc.) but requires READ_SOURCE_TYPE_CONTACT to also be included. Applicable only when `other_contacts` is true.",
      "human_parameter_name": "Data Sources",
      "human_parameter_description": "Choose which types of contact information to retrieve. Contact source provides basic info, while Profile source adds extended details."
    },
    "page_size": {
      "type": "integer",
      "title": "Page Size",
      "default": 10,
      "maximum": 1000,
      "minimum": 1,
      "description": "The number of 'Other Contacts' to return per page. Applicable only when `other_contacts` is true.",
      "human_parameter_name": "Page Size",
      "human_parameter_description": "Indicate how many 'Other Contacts' you want to see in each response. You can choose between 1 and 1000."
    },
    "page_token": {
      "type": "string",
      "title": "Page Token",
      "default": "",
      "description": "An opaque token from a previous response to retrieve the next page of 'Other Contacts' results. Applicable only when `other_contacts` is true and paginating.",
      "human_parameter_name": "Page Token",
      "human_parameter_description": "Provide this token to continue fetching more contacts from where you left off."
    },
    "sync_token": {
      "type": "string",
      "title": "Sync Token",
      "default": "",
      "description": "A token from a previous 'Other Contacts' list call to retrieve only changes since the last sync; leave empty for an initial full sync. Applicable only when `other_contacts` is true.",
      "human_parameter_name": "Sync Token",
      "human_parameter_description": "Use this token to get updates from your last sync, so you only see new changes."
    },
    "person_fields": {
      "type": "string",
      "title": "Person Fields",
      "default": "emailAddresses,names,birthdays,genders",
      "examples": [
        "names,emailAddresses",
        "emailAddresses,names,birthdays,genders",
        "addresses,phoneNumbers,metadata"
      ],
      "description": "A comma-separated field mask to restrict which fields on the person (or persons) are returned. Consult the Google People API documentation for a comprehensive list of valid fields. Omitted fields are silently absent from the response \u2014 no error is raised. When `other_contacts` is true, only a restricted subset is valid (`emailAddresses`, `names`, `phoneNumbers`, `metadata`); extended fields like `organizations` or `birthdays` may cause validation errors or silent omissions in that mode.",
      "human_parameter_name": "Person Fields",
      "human_parameter_description": "Specify which details about the person you want to retrieve, such as their names or email addresses."
    },
    "resource_name": {
      "type": "string",
      "title": "Resource Name",
      "default": "people/me",
      "examples": [
        "people/me",
        "people/c12345678901234567890",
        "people/102345678901234567890"
      ],
      "description": "Resource name identifying the person for whom to retrieve information (like the authenticated user or a specific contact). Used only when `other_contacts` is false. Deleted or stale resource_names may return partial records with missing `emailAddresses`, `names`, or other fields.",
      "human_parameter_name": "Resource Name",
      "human_parameter_description": "The identifier for the person whose information you want to retrieve. You can use 'people/me' to refer to yourself."
    },
    "other_contacts": {
      "type": "boolean",
      "title": "Other Contacts",
      "default": false,
      "description": "If true, retrieves 'Other Contacts' (people interacted with but not explicitly saved), ignoring `resource_name` and enabling pagination/sync. If false, retrieves information for the single person specified by `resource_name`.",
      "human_parameter_name": "Retrieve Other Contacts?",
      "human_parameter_description": "Choose whether you want to get a list of people you've interacted with or just details about a specific person."
    }
  }
}
```

**Output schema:**
```json
{
  "type": "object",
  "$defs": {
    "GetPeopleResponse": {
      "type": "object",
      "title": "GetPeopleResponse",
      "properties": {
        "display_url": {
          "type": "string",
          "title": "Display Url",
          "description": "Web UI link for this resource - clickable URL pointing to the relevant Google Contacts page."
        },
        "people_data": {
          "type": "object",
          "title": "People Data",
          "default": {},
          "description": "Contains the person's data as requested, populated when `other_contacts` is false and a single person is fetched.",
          "additionalProperties": true
        },
        "other_contacts": {
          "type": "object",
          "title": "Other Contacts",
          "default": {},
          "description": "Contains the list of 'Other Contacts', potentially including tokens for pagination or future syncs. Populated when `other_contacts` is true.",
          "additionalProperties": true
        }
      }
    }
  },
  "title": "GetPeopleResponseWrapper",
  "required": [
    "data",
    "successful"
  ],
  "properties": {
    "data": {
      "type": "object",
      "title": "Data",
      "properties": {
        "display_url": {
          "type": "string",
          "title": "Display Url",
          "description": "Web UI link for this resource - clickable URL pointing to the relevant Google Contacts page."
        },
        "people_data": {
          "type": "object",
          "title": "People Data",
          "default": {},
          "description": "Contains the person's data as requested, populated when `other_contacts` is false and a single person is fetched.",
          "additionalProperties": true
        },
        "other_contacts": {
          "type": "object",
          "title": "Other Contacts",
          "default": {},
          "description": "Contains the list of 'Other Contacts', potentially including tokens for pagination or future syncs. Populated when `other_contacts` is true.",
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

## GMAIL_GET_PROFILE
Retrieves Gmail profile information (email address, aggregate messagesTotal/threadsTotal, historyId) for a user. messagesTotal counts individual emails; threadsTotal counts conversations; neither is per-label — use GMAIL_FETCH_EMAILS with label filters for label-specific counts. The returned historyId seeds incremental sync via GMAIL_LIST_HISTORY; if historyIdTooOld is returned, rescan with GMAIL_FETCH_EMAILS before resuming. Response may be wrapped under a top-level data field; unwrap before reading fields. A successful call confirms mailbox connectivity but not full mailbox access if granted scopes are narrow. Use the returned email address to dynamically identify the authenticated account rather than hard-coding it.

**Input schema:**
```json
{
  "type": "object",
  "title": "GetProfileRequest",
  "properties": {
    "user_id": {
      "type": "string",
      "title": "User Id",
      "default": "me",
      "examples": [
        "user@example.com",
        "me"
      ],
      "description": "The email address of the Gmail user whose profile is to be retrieved, or the special value 'me' to indicate the currently authenticated user. Prefer 'me' unless explicitly targeting another account; passing a raw email address that does not match the connected account may fail or access the wrong mailbox.",
      "human_parameter_name": "User ID",
      "human_parameter_description": "Provide the email address of the user whose profile you want to see. Use 'me' to view your own profile."
    }
  }
}
```

**Output schema:**
```json
{
  "type": "object",
  "$defs": {
    "GetProfileResponse": {
      "type": "object",
      "title": "GetProfileResponse",
      "required": [
        "emailAddress",
        "messagesTotal",
        "threadsTotal",
        "historyId"
      ],
      "properties": {
        "historyId": {
          "type": "string",
          "title": "History Id",
          "description": "The ID of the mailbox's current history record."
        },
        "display_url": {
          "type": "string",
          "title": "Display Url",
          "description": "Web UI link for this resource - set by each action's execute()."
        },
        "emailAddress": {
          "type": "string",
          "title": "Email Address",
          "description": "The user's primary email address."
        },
        "threadsTotal": {
          "type": "integer",
          "title": "Threads Total",
          "description": "The total number of threads in the mailbox."
        },
        "messagesTotal": {
          "type": "integer",
          "title": "Messages Total",
          "description": "The total number of messages in the mailbox."
        }
      },
      "description": "The user's Gmail profile information, including primary email address, total messages, total threads, and history ID."
    }
  },
  "title": "GetProfileResponseWrapper",
  "required": [
    "data",
    "successful"
  ],
  "properties": {
    "data": {
      "type": "object",
      "title": "Data",
      "required": [
        "emailAddress",
        "messagesTotal",
        "threadsTotal",
        "historyId"
      ],
      "properties": {
        "historyId": {
          "type": "string",
          "title": "History Id",
          "description": "The ID of the mailbox's current history record."
        },
        "display_url": {
          "type": "string",
          "title": "Display Url",
          "description": "Web UI link for this resource - set by each action's execute()."
        },
        "emailAddress": {
          "type": "string",
          "title": "Email Address",
          "description": "The user's primary email address."
        },
        "threadsTotal": {
          "type": "integer",
          "title": "Threads Total",
          "description": "The total number of threads in the mailbox."
        },
        "messagesTotal": {
          "type": "integer",
          "title": "Messages Total",
          "description": "The total number of messages in the mailbox."
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

## GMAIL_GET_VACATION_SETTINGS
Tool to retrieve vacation responder settings for a Gmail user. Use when you need to check if out-of-office auto-replies are configured and view their content.

**Input schema:**
```json
{
  "type": "object",
  "title": "GetVacationSettingsRequest",
  "properties": {
    "user_id": {
      "type": "string",
      "title": "User Id",
      "default": "me",
      "examples": [
        "me",
        "user@example.com"
      ],
      "description": "The email address of the Gmail user whose vacation settings are to be retrieved, or the special value 'me' to indicate the currently authenticated user."
    }
  }
}
```

**Output schema:**
```json
{
  "type": "object",
  "$defs": {
    "GetVacationSettingsResponse": {
      "type": "object",
      "title": "GetVacationSettingsResponse",
      "properties": {
        "endTime": {
          "type": "string",
          "title": "End Time",
          "description": "Epoch timestamp in milliseconds (int64 format) marking when auto-replies stop. Must follow startTime if both specified."
        },
        "startTime": {
          "type": "string",
          "title": "Start Time",
          "description": "Epoch timestamp in milliseconds (int64 format) marking when auto-replies begin. Must precede endTime if both specified."
        },
        "display_url": {
          "type": "string",
          "title": "Display Url",
          "description": "Web UI link for this resource - set by each action's execute()."
        },
        "enableAutoReply": {
          "type": "boolean",
          "title": "Enable Auto Reply",
          "description": "Controls whether Gmail sends automatic replies to incoming messages."
        },
        "responseSubject": {
          "type": "string",
          "title": "Response Subject",
          "description": "Optional text prepended to vacation response subject lines. Either this or responseBodyPlainText must be populated to activate auto-replies."
        },
        "responseBodyHtml": {
          "type": "string",
          "title": "Response Body Html",
          "description": "HTML-formatted vacation message. Takes priority over plain text; Gmail sanitizes content before storage."
        },
        "restrictToDomain": {
          "type": "boolean",
          "title": "Restrict To Domain",
          "description": "Determines if replies only go to recipients within the user's organization domain (Google Workspace feature)."
        },
        "restrictToContacts": {
          "type": "boolean",
          "title": "Restrict To Contacts",
          "description": "Determines if replies only go to contacts in the user's address book."
        },
        "responseBodyPlainText": {
          "type": "string",
          "title": "Response Body Plain Text",
          "description": "Unformatted text version of the vacation message. Takes secondary priority if HTML version exists."
        }
      },
      "description": "The user's Gmail vacation responder settings, including auto-reply configuration and message content."
    }
  },
  "title": "GetVacationSettingsResponseWrapper",
  "required": [
    "data",
    "successful"
  ],
  "properties": {
    "data": {
      "type": "object",
      "title": "Data",
      "properties": {
        "endTime": {
          "type": "string",
          "title": "End Time",
          "description": "Epoch timestamp in milliseconds (int64 format) marking when auto-replies stop. Must follow startTime if both specified."
        },
        "startTime": {
          "type": "string",
          "title": "Start Time",
          "description": "Epoch timestamp in milliseconds (int64 format) marking when auto-replies begin. Must precede endTime if both specified."
        },
        "display_url": {
          "type": "string",
          "title": "Display Url",
          "description": "Web UI link for this resource - set by each action's execute()."
        },
        "enableAutoReply": {
          "type": "boolean",
          "title": "Enable Auto Reply",
          "description": "Controls whether Gmail sends automatic replies to incoming messages."
        },
        "responseSubject": {
          "type": "string",
          "title": "Response Subject",
          "description": "Optional text prepended to vacation response subject lines. Either this or responseBodyPlainText must be populated to activate auto-replies."
        },
        "responseBodyHtml": {
          "type": "string",
          "title": "Response Body Html",
          "description": "HTML-formatted vacation message. Takes priority over plain text; Gmail sanitizes content before storage."
        },
        "restrictToDomain": {
          "type": "boolean",
          "title": "Restrict To Domain",
          "description": "Determines if replies only go to recipients within the user's organization domain (Google Workspace feature)."
        },
        "restrictToContacts": {
          "type": "boolean",
          "title": "Restrict To Contacts",
          "description": "Determines if replies only go to contacts in the user's address book."
        },
        "responseBodyPlainText": {
          "type": "string",
          "title": "Response Body Plain Text",
          "description": "Unformatted text version of the vacation message. Takes secondary priority if HTML version exists."
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

## GMAIL_IMPORT_MESSAGE
Tool to import a message into the user's mailbox with standard email delivery scanning and classification. Use when you need to add an existing email to a Gmail account without sending it through SMTP. This method doesn't perform SPF checks, so it might not work for some spam messages.

**Input schema:**
```json
{
  "type": "object",
  "title": "ImportMessageRequest",
  "required": [
    "raw"
  ],
  "properties": {
    "raw": {
      "type": "string",
      "title": "Raw",
      "examples": [
        "RnJvbTogdGVzdEBleGFtcGxlLmNvbQ0KVG86IHJlY2lwaWVudEBleGFtcGxlLmNvbQ0KU3ViamVjdDogVGVzdCBJbXBvcnQgTWVzc2FnZQ0KDQpUaGlzIGlzIGEgdGVzdCBlbWFpbCBtZXNzYWdlIGZvciBpbXBvcnRpbmcgdmlhIEdtYWlsIEFQSS4="
      ],
      "description": "The entire email message in RFC 2822 format, base64url-encoded. This is the raw email message to import into the mailbox."
    },
    "deleted": {
      "type": "boolean",
      "title": "Deleted",
      "description": "Mark the email as permanently deleted (not TRASH) and only visible in Google Vault to a Vault administrator. Only used for Google Workspace accounts."
    },
    "user_id": {
      "type": "string",
      "title": "User Id",
      "default": "me",
      "examples": [
        "me",
        "user@example.com"
      ],
      "description": "The user's email address. The special value 'me' can be used to indicate the authenticated user."
    },
    "never_mark_spam": {
      "type": "boolean",
      "title": "Never Mark Spam",
      "description": "Ignore the Gmail spam classifier decision and never mark this email as SPAM in the mailbox."
    },
    "internal_date_source": {
      "enum": [
        "receivedTime",
        "dateHeader"
      ],
      "type": "string",
      "title": "InternalDateSource",
      "examples": [
        "receivedTime",
        "dateHeader"
      ],
      "description": "Source for Gmail's internal date of the message."
    },
    "process_for_calendar": {
      "type": "boolean",
      "title": "Process For Calendar",
      "description": "Process calendar invites in the email and add any extracted meetings to the Google Calendar for this user."
    }
  }
}
```

**Output schema:**
```json
{
  "type": "object",
  "$defs": {
    "GmailMessageResponse": {
      "type": "object",
      "title": "GmailMessageResponse",
      "properties": {
        "id": {
          "type": "string",
          "title": "Id",
          "description": "The immutable ID of the sent message."
        },
        "raw": {
          "type": "string",
          "title": "Raw",
          "description": "The entire email message in RFC 2822 format, base64url-encoded."
        },
        "payload": {
          "type": "object",
          "title": "Payload",
          "description": "The parsed email structure, including headers and body parts.",
          "additionalProperties": true
        },
        "snippet": {
          "type": "string",
          "title": "Snippet",
          "description": "A short extract of the message text."
        },
        "labelIds": {
          "type": "array",
          "items": {
            "type": "string"
          },
          "title": "Label Ids",
          "description": "List of IDs of labels applied to this message."
        },
        "threadId": {
          "type": "string",
          "title": "Thread Id",
          "description": "The ID of the thread the message belongs to."
        },
        "historyId": {
          "type": "string",
          "title": "History Id",
          "description": "The ID of the last history record that modified this message."
        },
        "display_url": {
          "type": "string",
          "title": "Display Url",
          "description": "Web UI link for this resource - set by each action's execute()."
        },
        "internalDate": {
          "type": "string",
          "title": "Internal Date",
          "description": "The internal timestamp of the message in milliseconds since epoch."
        },
        "sizeEstimate": {
          "type": "integer",
          "title": "Size Estimate",
          "description": "Estimated size of the message in bytes."
        }
      },
      "description": "Standard Gmail message response returned by Gmail API for sent messages.\nUsed by actions like send_email and send_draft."
    }
  },
  "title": "GmailMessageResponseWrapper",
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
          "description": "The immutable ID of the sent message."
        },
        "raw": {
          "type": "string",
          "title": "Raw",
          "description": "The entire email message in RFC 2822 format, base64url-encoded."
        },
        "payload": {
          "type": "object",
          "title": "Payload",
          "description": "The parsed email structure, including headers and body parts.",
          "additionalProperties": true
        },
        "snippet": {
          "type": "string",
          "title": "Snippet",
          "description": "A short extract of the message text."
        },
        "labelIds": {
          "type": "array",
          "items": {
            "type": "string"
          },
          "title": "Label Ids",
          "description": "List of IDs of labels applied to this message."
        },
        "threadId": {
          "type": "string",
          "title": "Thread Id",
          "description": "The ID of the thread the message belongs to."
        },
        "historyId": {
          "type": "string",
          "title": "History Id",
          "description": "The ID of the last history record that modified this message."
        },
        "display_url": {
          "type": "string",
          "title": "Display Url",
          "description": "Web UI link for this resource - set by each action's execute()."
        },
        "internalDate": {
          "type": "string",
          "title": "Internal Date",
          "description": "The internal timestamp of the message in milliseconds since epoch."
        },
        "sizeEstimate": {
          "type": "integer",
          "title": "Size Estimate",
          "description": "Estimated size of the message in bytes."
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

## GMAIL_INSERT_MESSAGE
Tool to insert a message into the user's mailbox similar to IMAP APPEND. Use when you need to add an email directly to a mailbox bypassing most scanning and classification. This does not send a message.

**Input schema:**
```json
{
  "type": "object",
  "title": "InsertMessageRequest",
  "required": [
    "raw"
  ],
  "properties": {
    "raw": {
      "type": "string",
      "title": "Raw",
      "examples": [
        "RnJvbTogdGVzdEBleGFtcGxlLmNvbQ0KVG86IHRlc3RAZXhhbXBsZS5jb20NCkNvbnRlbnQtVHlwZTogdGV4dC9wbGFpbjsgY2hhcnNldD0idXRmLTgiDQpNSU1FLVZlcnNpb246IDEuMA0KU3ViamVjdDogVGVzdCBNZXNzYWdlDQoNCkhpLCB0aGlzIGlzIGEgdGVzdCBtZXNzYWdlLg=="
      ],
      "description": "The entire email message in RFC 2822 formatted and base64url encoded string. This is the raw message content that will be inserted into the mailbox."
    },
    "deleted": {
      "type": "boolean",
      "title": "Deleted",
      "description": "Mark the email as permanently deleted (not TRASH) and only visible in Google Vault to a Vault administrator. Only used for Google Workspace accounts."
    },
    "user_id": {
      "type": "string",
      "title": "User Id",
      "default": "me",
      "examples": [
        "me",
        "user@example.com"
      ],
      "description": "The user's email address. The special value 'me' can be used to indicate the authenticated user."
    },
    "internalDateSource": {
      "enum": [
        "receivedTime",
        "dateHeader"
      ],
      "type": "string",
      "title": "InternalDateSource",
      "description": "Source for Gmail's internal date of the message."
    }
  }
}
```

**Output schema:**
```json
{
  "type": "object",
  "$defs": {
    "GmailMessageResponse": {
      "type": "object",
      "title": "GmailMessageResponse",
      "properties": {
        "id": {
          "type": "string",
          "title": "Id",
          "description": "The immutable ID of the sent message."
        },
        "raw": {
          "type": "string",
          "title": "Raw",
          "description": "The entire email message in RFC 2822 format, base64url-encoded."
        },
        "payload": {
          "type": "object",
          "title": "Payload",
          "description": "The parsed email structure, including headers and body parts.",
          "additionalProperties": true
        },
        "snippet": {
          "type": "string",
          "title": "Snippet",
          "description": "A short extract of the message text."
        },
        "labelIds": {
          "type": "array",
          "items": {
            "type": "string"
          },
          "title": "Label Ids",
          "description": "List of IDs of labels applied to this message."
        },
        "threadId": {
          "type": "string",
          "title": "Thread Id",
          "description": "The ID of the thread the message belongs to."
        },
        "historyId": {
          "type": "string",
          "title": "History Id",
          "description": "The ID of the last history record that modified this message."
        },
        "display_url": {
          "type": "string",
          "title": "Display Url",
          "description": "Web UI link for this resource - set by each action's execute()."
        },
        "internalDate": {
          "type": "string",
          "title": "Internal Date",
          "description": "The internal timestamp of the message in milliseconds since epoch."
        },
        "sizeEstimate": {
          "type": "integer",
          "title": "Size Estimate",
          "description": "Estimated size of the message in bytes."
        }
      },
      "description": "Standard Gmail message response returned by Gmail API for sent messages.\nUsed by actions like send_email and send_draft."
    }
  },
  "title": "GmailMessageResponseWrapper",
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
          "description": "The immutable ID of the sent message."
        },
        "raw": {
          "type": "string",
          "title": "Raw",
          "description": "The entire email message in RFC 2822 format, base64url-encoded."
        },
        "payload": {
          "type": "object",
          "title": "Payload",
          "description": "The parsed email structure, including headers and body parts.",
          "additionalProperties": true
        },
        "snippet": {
          "type": "string",
          "title": "Snippet",
          "description": "A short extract of the message text."
        },
        "labelIds": {
          "type": "array",
          "items": {
            "type": "string"
          },
          "title": "Label Ids",
          "description": "List of IDs of labels applied to this message."
        },
        "threadId": {
          "type": "string",
          "title": "Thread Id",
          "description": "The ID of the thread the message belongs to."
        },
        "historyId": {
          "type": "string",
          "title": "History Id",
          "description": "The ID of the last history record that modified this message."
        },
        "display_url": {
          "type": "string",
          "title": "Display Url",
          "description": "Web UI link for this resource - set by each action's execute()."
        },
        "internalDate": {
          "type": "string",
          "title": "Internal Date",
          "description": "The internal timestamp of the message in milliseconds since epoch."
        },
        "sizeEstimate": {
          "type": "integer",
          "title": "Size Estimate",
          "description": "Estimated size of the message in bytes."
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

## GMAIL_LIST_CSE_IDENTITIES
Tool to list client-side encrypted identities for an authenticated user. Use when you need to retrieve CSE identity configurations including key pair associations.

**Input schema:**
```json
{
  "type": "object",
  "title": "ListCseIdentitiesRequest",
  "properties": {
    "user_id": {
      "type": "string",
      "title": "User Id",
      "default": "me",
      "examples": [
        "me",
        "user@example.com"
      ],
      "description": "The requester's primary email address. Use 'me' to indicate the authenticated user."
    },
    "page_size": {
      "type": "integer",
      "title": "Page Size",
      "minimum": 1,
      "examples": [
        20,
        50
      ],
      "description": "The number of identities to return. If not provided, the page size will default to 20 entries."
    },
    "page_token": {
      "type": "string",
      "title": "Page Token",
      "examples": [
        "ABCDEF123456"
      ],
      "description": "Pagination token indicating which page of identities to return."
    }
  }
}
```

**Output schema:**
```json
{
  "type": "object",
  "$defs": {
    "CseIdentity": {
      "type": "object",
      "title": "CseIdentity",
      "properties": {
        "emailAddress": {
          "type": "string",
          "title": "Email Address",
          "description": "The email address for the sending identity. Must be the primary email address of the authenticated user."
        },
        "primaryKeyPairId": {
          "type": "string",
          "title": "Primary Key Pair Id",
          "description": "If a key pair is associated, the ID of the key pair. This is a union field - either primaryKeyPairId or signAndEncryptKeyPairs can be populated, not both."
        },
        "signAndEncryptKeyPairs": {
          "type": "object",
          "title": "Sign And Encrypt Key Pairs",
          "properties": {
            "signingKeyPairId": {
              "type": "string",
              "title": "Signing Key Pair Id",
              "description": "The ID of the CseKeyPair that signs outgoing mail."
            },
            "encryptionKeyPairId": {
              "type": "string",
              "title": "Encryption Key Pair Id",
              "description": "The ID of the CseKeyPair that encrypts signed outgoing mail."
            }
          },
          "description": "Configuration for CSE identities using different key pairs for signing versus encryption. This is a union field - either primaryKeyPairId or signAndEncryptKeyPairs can be populated, not both."
        }
      }
    },
    "SignAndEncryptKeyPairs": {
      "type": "object",
      "title": "SignAndEncryptKeyPairs",
      "properties": {
        "signingKeyPairId": {
          "type": "string",
          "title": "Signing Key Pair Id",
          "description": "The ID of the CseKeyPair that signs outgoing mail."
        },
        "encryptionKeyPairId": {
          "type": "string",
          "title": "Encryption Key Pair Id",
          "description": "The ID of the CseKeyPair that encrypts signed outgoing mail."
        }
      }
    },
    "ListCseIdentitiesResponse": {
      "type": "object",
      "title": "ListCseIdentitiesResponse",
      "properties": {
        "display_url": {
          "type": "string",
          "title": "Display Url",
          "description": "Web UI link for this resource - set by each action's execute()."
        },
        "cseIdentities": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "CseIdentity",
            "properties": {
              "emailAddress": {
                "type": "string",
                "title": "Email Address",
                "description": "The email address for the sending identity. Must be the primary email address of the authenticated user."
              },
              "primaryKeyPairId": {
                "type": "string",
                "title": "Primary Key Pair Id",
                "description": "If a key pair is associated, the ID of the key pair. This is a union field - either primaryKeyPairId or signAndEncryptKeyPairs can be populated, not both."
              },
              "signAndEncryptKeyPairs": {
                "type": "object",
                "title": "Sign And Encrypt Key Pairs",
                "properties": {
                  "signingKeyPairId": {
                    "type": "string",
                    "title": "Signing Key Pair Id",
                    "description": "The ID of the CseKeyPair that signs outgoing mail."
                  },
                  "encryptionKeyPairId": {
                    "type": "string",
                    "title": "Encryption Key Pair Id",
                    "description": "The ID of the CseKeyPair that encrypts signed outgoing mail."
                  }
                },
                "description": "Configuration for CSE identities using different key pairs for signing versus encryption. This is a union field - either primaryKeyPairId or signAndEncryptKeyPairs can be populated, not both."
              }
            }
          },
          "title": "Cse Identities",
          "default": [],
          "description": "One page of the list of CSE identities configured for the user."
        },
        "nextPageToken": {
          "type": "string",
          "title": "Next Page Token",
          "description": "Pagination token to be passed to a subsequent identities.list call to retrieve the next page of identities. If this value is not returned or is empty, no further pages remain."
        }
      }
    }
  },
  "title": "ListCseIdentitiesResponseWrapper",
  "required": [
    "data",
    "successful"
  ],
  "properties": {
    "data": {
      "type": "object",
      "title": "Data",
      "properties": {
        "display_url": {
          "type": "string",
          "title": "Display Url",
          "description": "Web UI link for this resource - set by each action's execute()."
        },
        "cseIdentities": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "CseIdentity",
            "properties": {
              "emailAddress": {
                "type": "string",
                "title": "Email Address",
                "description": "The email address for the sending identity. Must be the primary email address of the authenticated user."
              },
              "primaryKeyPairId": {
                "type": "string",
                "title": "Primary Key Pair Id",
                "description": "If a key pair is associated, the ID of the key pair. This is a union field - either primaryKeyPairId or signAndEncryptKeyPairs can be populated, not both."
              },
              "signAndEncryptKeyPairs": {
                "type": "object",
                "title": "Sign And Encrypt Key Pairs",
                "properties": {
                  "signingKeyPairId": {
                    "type": "string",
                    "title": "Signing Key Pair Id",
                    "description": "The ID of the CseKeyPair that signs outgoing mail."
                  },
                  "encryptionKeyPairId": {
                    "type": "string",
                    "title": "Encryption Key Pair Id",
                    "description": "The ID of the CseKeyPair that encrypts signed outgoing mail."
                  }
                },
                "description": "Configuration for CSE identities using different key pairs for signing versus encryption. This is a union field - either primaryKeyPairId or signAndEncryptKeyPairs can be populated, not both."
              }
            }
          },
          "title": "Cse Identities",
          "default": [],
          "description": "One page of the list of CSE identities configured for the user."
        },
        "nextPageToken": {
          "type": "string",
          "title": "Next Page Token",
          "description": "Pagination token to be passed to a subsequent identities.list call to retrieve the next page of identities. If this value is not returned or is empty, no further pages remain."
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

## GMAIL_LIST_CSE_KEYPAIRS
Tool to list client-side encryption key pairs for an authenticated user. Use when you need to retrieve CSE keypair configurations including public keys and enablement states. Supports pagination for large result sets.

**Input schema:**
```json
{
  "type": "object",
  "title": "ListCseKeypairsRequest",
  "properties": {
    "user_id": {
      "type": "string",
      "title": "User Id",
      "default": "me",
      "examples": [
        "me",
        "user@example.com"
      ],
      "description": "The requester's primary email address. Use 'me' to indicate the authenticated user."
    },
    "page_size": {
      "type": "integer",
      "title": "Page Size",
      "minimum": 1,
      "examples": [
        20,
        50
      ],
      "description": "The number of key pairs to return per page. If not provided, the page size will default to 20 entries."
    },
    "page_token": {
      "type": "string",
      "title": "Page Token",
      "examples": [
        "ABCDEF123456"
      ],
      "description": "Pagination token indicating which page of key pairs to return. Omit to return the first page."
    }
  }
}
```

**Output schema:**
```json
{
  "type": "object",
  "$defs": {
    "CseKeyPair": {
      "type": "object",
      "title": "CseKeyPair",
      "properties": {
        "pem": {
          "type": "string",
          "title": "Pem",
          "description": "The public key and its certificate chain in PEM format."
        },
        "keyPairId": {
          "type": "string",
          "title": "Key Pair Id",
          "description": "Immutable identifier for the S/MIME key pair."
        },
        "disableTime": {
          "type": "string",
          "title": "Disable Time",
          "description": "Timestamp (RFC 3339 format) when the key pair transitioned from enabled to disabled."
        },
        "enablementState": {
          "enum": [
            "stateUnspecified",
            "enabled",
            "disabled"
          ],
          "type": "string",
          "title": "Enablement State",
          "description": "Current state of the key pair."
        },
        "privateKeyMetadata": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "PrivateKeyMetadata",
            "properties": {
              "kaclsKeyMetadata": {
                "type": "object",
                "title": "Kacls Key Metadata",
                "properties": {
                  "kaclsUri": {
                    "type": "string",
                    "title": "Kacls Uri",
                    "description": "The URI for the KACLS (Key Access Control List Service) server."
                  },
                  "kaclsData": {
                    "type": "string",
                    "title": "Kacls Data",
                    "description": "Opaque data generated and used by KACLS for key access control."
                  }
                },
                "description": "Metadata for KACLS (Key Access Control List Service) managed private keys."
              },
              "hardwareKeyMetadata": {
                "type": "object",
                "title": "Hardware Key Metadata",
                "properties": {
                  "description": {
                    "type": "string",
                    "title": "Description",
                    "description": "Description of the hardware key."
                  }
                },
                "description": "Metadata for hardware-backed private keys."
              },
              "privateKeyMetadataId": {
                "type": "string",
                "title": "Private Key Metadata Id",
                "description": "Immutable ID for the private key metadata instance."
              }
            }
          },
          "title": "Private Key Metadata",
          "default": [],
          "description": "Metadata instances for this key pair's private key variants."
        },
        "subjectEmailAddresses": {
          "type": "array",
          "items": {
            "type": "string"
          },
          "title": "Subject Email Addresses",
          "default": [],
          "description": "Email address identities specified on the leaf certificate."
        }
      }
    },
    "KaclsKeyMetadata": {
      "type": "object",
      "title": "KaclsKeyMetadata",
      "properties": {
        "kaclsUri": {
          "type": "string",
          "title": "Kacls Uri",
          "description": "The URI for the KACLS (Key Access Control List Service) server."
        },
        "kaclsData": {
          "type": "string",
          "title": "Kacls Data",
          "description": "Opaque data generated and used by KACLS for key access control."
        }
      }
    },
    "PrivateKeyMetadata": {
      "type": "object",
      "title": "PrivateKeyMetadata",
      "properties": {
        "kaclsKeyMetadata": {
          "type": "object",
          "title": "Kacls Key Metadata",
          "properties": {
            "kaclsUri": {
              "type": "string",
              "title": "Kacls Uri",
              "description": "The URI for the KACLS (Key Access Control List Service) server."
            },
            "kaclsData": {
              "type": "string",
              "title": "Kacls Data",
              "description": "Opaque data generated and used by KACLS for key access control."
            }
          },
          "description": "Metadata for KACLS (Key Access Control List Service) managed private keys."
        },
        "hardwareKeyMetadata": {
          "type": "object",
          "title": "Hardware Key Metadata",
          "properties": {
            "description": {
              "type": "string",
              "title": "Description",
              "description": "Description of the hardware key."
            }
          },
          "description": "Metadata for hardware-backed private keys."
        },
        "privateKeyMetadataId": {
          "type": "string",
          "title": "Private Key Metadata Id",
          "description": "Immutable ID for the private key metadata instance."
        }
      }
    },
    "HardwareKeyMetadata": {
      "type": "object",
      "title": "HardwareKeyMetadata",
      "properties": {
        "description": {
          "type": "string",
          "title": "Description",
          "description": "Description of the hardware key."
        }
      }
    },
    "ListCseKeypairsResponse": {
      "type": "object",
      "title": "ListCseKeypairsResponse",
      "properties": {
        "cseKeyPairs": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "CseKeyPair",
            "properties": {
              "pem": {
                "type": "string",
                "title": "Pem",
                "description": "The public key and its certificate chain in PEM format."
              },
              "keyPairId": {
                "type": "string",
                "title": "Key Pair Id",
                "description": "Immutable identifier for the S/MIME key pair."
              },
              "disableTime": {
                "type": "string",
                "title": "Disable Time",
                "description": "Timestamp (RFC 3339 format) when the key pair transitioned from enabled to disabled."
              },
              "enablementState": {
                "enum": [
                  "stateUnspecified",
                  "enabled",
                  "disabled"
                ],
                "type": "string",
                "title": "Enablement State",
                "description": "Current state of the key pair."
              },
              "privateKeyMetadata": {
                "type": "array",
                "items": {
                  "type": "object",
                  "title": "PrivateKeyMetadata",
                  "properties": {
                    "kaclsKeyMetadata": {
                      "type": "object",
                      "title": "Kacls Key Metadata",
                      "properties": {
                        "kaclsUri": {
                          "type": "string",
                          "title": "Kacls Uri",
                          "description": "The URI for the KACLS (Key Access Control List Service) server."
                        },
                        "kaclsData": {
                          "type": "string",
                          "title": "Kacls Data",
                          "description": "Opaque data generated and used by KACLS for key access control."
                        }
                      },
                      "description": "Metadata for KACLS (Key Access Control List Service) managed private keys."
                    },
                    "hardwareKeyMetadata": {
                      "type": "object",
                      "title": "Hardware Key Metadata",
                      "properties": {
                        "description": {
                          "type": "string",
                          "title": "Description",
                          "description": "Description of the hardware key."
                        }
                      },
                      "description": "Metadata for hardware-backed private keys."
                    },
                    "privateKeyMetadataId": {
                      "type": "string",
                      "title": "Private Key Metadata Id",
                      "description": "Immutable ID for the private key metadata instance."
                    }
                  }
                },
                "title": "Private Key Metadata",
                "default": [],
                "description": "Metadata instances for this key pair's private key variants."
              },
              "subjectEmailAddresses": {
                "type": "array",
                "items": {
                  "type": "string"
                },
                "title": "Subject Email Addresses",
                "default": [],
                "description": "Email address identities specified on the leaf certificate."
              }
            }
          },
          "title": "Cse Key Pairs",
          "default": [],
          "description": "One page of the list of CSE key pairs installed for the user."
        },
        "display_url": {
          "type": "string",
          "title": "Display Url",
          "description": "Web UI link for this resource. CSE key-pairs have no direct Gmail web UI equivalent."
        },
        "nextPageToken": {
          "type": "string",
          "title": "Next Page Token",
          "description": "Pagination token to be passed to a subsequent keypairs.list call to retrieve the next page. If this value is not returned or is empty, no further pages remain."
        }
      }
    }
  },
  "title": "ListCseKeypairsResponseWrapper",
  "required": [
    "data",
    "successful"
  ],
  "properties": {
    "data": {
      "type": "object",
      "title": "Data",
      "properties": {
        "cseKeyPairs": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "CseKeyPair",
            "properties": {
              "pem": {
                "type": "string",
                "title": "Pem",
                "description": "The public key and its certificate chain in PEM format."
              },
              "keyPairId": {
                "type": "string",
                "title": "Key Pair Id",
                "description": "Immutable identifier for the S/MIME key pair."
              },
              "disableTime": {
                "type": "string",
                "title": "Disable Time",
                "description": "Timestamp (RFC 3339 format) when the key pair transitioned from enabled to disabled."
              },
              "enablementState": {
                "enum": [
                  "stateUnspecified",
                  "enabled",
                  "disabled"
                ],
                "type": "string",
                "title": "Enablement State",
                "description": "Current state of the key pair."
              },
              "privateKeyMetadata": {
                "type": "array",
                "items": {
                  "type": "object",
                  "title": "PrivateKeyMetadata",
                  "properties": {
                    "kaclsKeyMetadata": {
                      "type": "object",
                      "title": "Kacls Key Metadata",
                      "properties": {
                        "kaclsUri": {
                          "type": "string",
                          "title": "Kacls Uri",
                          "description": "The URI for the KACLS (Key Access Control List Service) server."
                        },
                        "kaclsData": {
                          "type": "string",
                          "title": "Kacls Data",
                          "description": "Opaque data generated and used by KACLS for key access control."
                        }
                      },
                      "description": "Metadata for KACLS (Key Access Control List Service) managed private keys."
                    },
                    "hardwareKeyMetadata": {
                      "type": "object",
                      "title": "Hardware Key Metadata",
                      "properties": {
                        "description": {
                          "type": "string",
                          "title": "Description",
                          "description": "Description of the hardware key."
                        }
                      },
                      "description": "Metadata for hardware-backed private keys."
                    },
                    "privateKeyMetadataId": {
                      "type": "string",
                      "title": "Private Key Metadata Id",
                      "description": "Immutable ID for the private key metadata instance."
                    }
                  }
                },
                "title": "Private Key Metadata",
                "default": [],
                "description": "Metadata instances for this key pair's private key variants."
              },
              "subjectEmailAddresses": {
                "type": "array",
                "items": {
                  "type": "string"
                },
                "title": "Subject Email Addresses",
                "default": [],
                "description": "Email address identities specified on the leaf certificate."
              }
            }
          },
          "title": "Cse Key Pairs",
          "default": [],
          "description": "One page of the list of CSE key pairs installed for the user."
        },
        "display_url": {
          "type": "string",
          "title": "Display Url",
          "description": "Web UI link for this resource. CSE key-pairs have no direct Gmail web UI equivalent."
        },
        "nextPageToken": {
          "type": "string",
          "title": "Next Page Token",
          "description": "Pagination token to be passed to a subsequent keypairs.list call to retrieve the next page. If this value is not returned or is empty, no further pages remain."
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

## GMAIL_LIST_DRAFTS
Retrieves a paginated list of email drafts from a user's Gmail account. Use verbose=true to get full draft details including subject, body, sender, and timestamp. Draft ordering is non-guaranteed; iterate using page_token until it is absent to retrieve all drafts. Newly created drafts may not appear immediately. Rapid calls may trigger 403 userRateLimitExceeded or 429 errors; apply exponential backoff (1s, 2s, 4s) before retrying.

**Input schema:**
```json
{
  "type": "object",
  "title": "ListDraftsRequest",
  "properties": {
    "user_id": {
      "type": "string",
      "title": "User Id",
      "default": "me",
      "examples": [
        "me",
        "user@example.com"
      ],
      "description": "User's mailbox ID; use 'me' for the authenticated user.",
      "human_parameter_name": "User ID",
      "human_parameter_description": "The email address or identifier of the user whose mailbox you want to access. Use 'me' to access your own mailbox."
    },
    "verbose": {
      "type": "boolean",
      "title": "Verbose",
      "default": false,
      "examples": [
        true,
        false
      ],
      "description": "If true, fetches full draft details including subject, sender, recipient, body, and timestamp. If false, returns only draft IDs (faster). Increases response payload size; tune max_results accordingly. Use verbose=true before destructive operations to confirm draft identity by subject, recipient, and timestamp.",
      "human_parameter_name": "Verbose",
      "human_parameter_description": "Decide if you want detailed information about each draft or just the basic IDs. More details can help you see what\u2019s inside."
    },
    "page_token": {
      "type": "string",
      "title": "Page Token",
      "default": "",
      "examples": [
        "CiaKJDhWSE5UURE9PSIsImMiOiJhYmMxMjMifQ=="
      ],
      "description": "Token from a previous response to retrieve a specific page of drafts. Ordering is non-guaranteed; continue paginating until page_token is absent in the response to retrieve all drafts.",
      "human_parameter_name": "Page Token",
      "human_parameter_description": "Use this token to get the next page of draft results if you have more drafts to display."
    },
    "max_results": {
      "type": "integer",
      "title": "Max Results",
      "default": 1,
      "maximum": 500,
      "minimum": 1,
      "examples": [
        10,
        100,
        500
      ],
      "description": "Maximum number of drafts to return per page.",
      "human_parameter_name": "Max Results",
      "human_parameter_description": "Specify how many drafts you want to retrieve in one request. Choose between 1 and 500."
    }
  }
}
```

**Output schema:**
```json
{
  "type": "object",
  "$defs": {
    "DraftEntry": {
      "type": "object",
      "title": "DraftEntry",
      "required": [
        "id",
        "message"
      ],
      "properties": {
        "id": {
          "type": "string",
          "title": "Id",
          "description": "The unique identifier for the draft"
        },
        "message": {
          "type": "object",
          "title": "Message",
          "properties": {
            "to": {
              "type": "string",
              "title": "To",
              "description": "The To: header of the draft"
            },
            "sender": {
              "type": "string",
              "title": "Sender",
              "description": "The From: header of the draft"
            },
            "payload": {
              "type": "object",
              "title": "Payload",
              "description": "The MIME payload including headers and parts",
              "additionalProperties": true
            },
            "preview": {
              "type": "object",
              "title": "Preview",
              "properties": {
                "body": {
                  "type": "string",
                  "title": "Body",
                  "description": "The preview body text"
                },
                "subject": {
                  "type": "string",
                  "title": "Subject",
                  "description": "The preview subject line"
                }
              },
              "description": "A brief preview of the draft message"
            },
            "subject": {
              "type": "string",
              "title": "Subject",
              "description": "The Subject: header of the draft"
            },
            "labelIds": {
              "type": "array",
              "items": {
                "type": "string"
              },
              "title": "Label Ids",
              "description": "Gmail label IDs applied to the draft"
            },
            "threadId": {
              "type": "string",
              "title": "Thread Id",
              "description": "The Gmail thread ID containing the draft"
            },
            "messageId": {
              "type": "string",
              "title": "Message Id",
              "description": "The Gmail message ID of the draft"
            },
            "messageText": {
              "type": "string",
              "title": "Message Text",
              "description": "The full text content of the draft"
            },
            "attachmentList": {
              "type": "array",
              "items": {
                "type": "object",
                "additionalProperties": true
              },
              "title": "Attachment List",
              "description": "Attachments included in the draft message"
            },
            "messageTimestamp": {
              "type": "string",
              "title": "Message Timestamp",
              "description": "The ISO-8601 timestamp when the draft was last modified"
            }
          },
          "description": "Full message data of the draft"
        }
      },
      "description": "A draft entry with identifier and message"
    },
    "DraftMessage": {
      "type": "object",
      "title": "DraftMessage",
      "properties": {
        "to": {
          "type": "string",
          "title": "To",
          "description": "The To: header of the draft"
        },
        "sender": {
          "type": "string",
          "title": "Sender",
          "description": "The From: header of the draft"
        },
        "payload": {
          "type": "object",
          "title": "Payload",
          "description": "The MIME payload including headers and parts",
          "additionalProperties": true
        },
        "preview": {
          "type": "object",
          "title": "Preview",
          "properties": {
            "body": {
              "type": "string",
              "title": "Body",
              "description": "The preview body text"
            },
            "subject": {
              "type": "string",
              "title": "Subject",
              "description": "The preview subject line"
            }
          },
          "description": "A brief preview of the draft message"
        },
        "subject": {
          "type": "string",
          "title": "Subject",
          "description": "The Subject: header of the draft"
        },
        "labelIds": {
          "type": "array",
          "items": {
            "type": "string"
          },
          "title": "Label Ids",
          "description": "Gmail label IDs applied to the draft"
        },
        "threadId": {
          "type": "string",
          "title": "Thread Id",
          "description": "The Gmail thread ID containing the draft"
        },
        "messageId": {
          "type": "string",
          "title": "Message Id",
          "description": "The Gmail message ID of the draft"
        },
        "messageText": {
          "type": "string",
          "title": "Message Text",
          "description": "The full text content of the draft"
        },
        "attachmentList": {
          "type": "array",
          "items": {
            "type": "object",
            "additionalProperties": true
          },
          "title": "Attachment List",
          "description": "Attachments included in the draft message"
        },
        "messageTimestamp": {
          "type": "string",
          "title": "Message Timestamp",
          "description": "The ISO-8601 timestamp when the draft was last modified"
        }
      },
      "description": "The full message data of the draft"
    },
    "MessagePreview": {
      "type": "object",
      "title": "MessagePreview",
      "properties": {
        "body": {
          "type": "string",
          "title": "Body",
          "description": "The preview body text"
        },
        "subject": {
          "type": "string",
          "title": "Subject",
          "description": "The preview subject line"
        }
      },
      "description": "A brief preview of the draft message"
    },
    "ListDraftsResponse": {
      "type": "object",
      "title": "ListDraftsResponse",
      "required": [
        "drafts"
      ],
      "properties": {
        "drafts": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "DraftEntry",
            "required": [
              "id",
              "message"
            ],
            "properties": {
              "id": {
                "type": "string",
                "title": "Id",
                "description": "The unique identifier for the draft"
              },
              "message": {
                "type": "object",
                "title": "Message",
                "properties": {
                  "to": {
                    "type": "string",
                    "title": "To",
                    "description": "The To: header of the draft"
                  },
                  "sender": {
                    "type": "string",
                    "title": "Sender",
                    "description": "The From: header of the draft"
                  },
                  "payload": {
                    "type": "object",
                    "title": "Payload",
                    "description": "The MIME payload including headers and parts",
                    "additionalProperties": true
                  },
                  "preview": {
                    "type": "object",
                    "title": "Preview",
                    "properties": {
                      "body": {
                        "type": "string",
                        "title": "Body",
                        "description": "The preview body text"
                      },
                      "subject": {
                        "type": "string",
                        "title": "Subject",
                        "description": "The preview subject line"
                      }
                    },
                    "description": "A brief preview of the draft message"
                  },
                  "subject": {
                    "type": "string",
                    "title": "Subject",
                    "description": "The Subject: header of the draft"
                  },
                  "labelIds": {
                    "type": "array",
                    "items": {
                      "type": "string"
                    },
                    "title": "Label Ids",
                    "description": "Gmail label IDs applied to the draft"
                  },
                  "threadId": {
                    "type": "string",
                    "title": "Thread Id",
                    "description": "The Gmail thread ID containing the draft"
                  },
                  "messageId": {
                    "type": "string",
                    "title": "Message Id",
                    "description": "The Gmail message ID of the draft"
                  },
                  "messageText": {
                    "type": "string",
                    "title": "Message Text",
                    "description": "The full text content of the draft"
                  },
                  "attachmentList": {
                    "type": "array",
                    "items": {
                      "type": "object",
                      "additionalProperties": true
                    },
                    "title": "Attachment List",
                    "description": "Attachments included in the draft message"
                  },
                  "messageTimestamp": {
                    "type": "string",
                    "title": "Message Timestamp",
                    "description": "The ISO-8601 timestamp when the draft was last modified"
                  }
                },
                "description": "Full message data of the draft"
              }
            },
            "description": "A draft entry with identifier and message"
          },
          "title": "Drafts",
          "description": "A list of draft entries"
        },
        "display_url": {
          "type": "string",
          "title": "Display Url",
          "description": "Web UI link to Gmail drafts page"
        },
        "next_page_token": {
          "type": "string",
          "title": "Next Page Token",
          "description": "Token to retrieve the next page of drafts; empty if there are no more pages"
        }
      },
      "description": "A paginated list of draft entries"
    }
  },
  "title": "ListDraftsResponseWrapper",
  "required": [
    "data",
    "successful"
  ],
  "properties": {
    "data": {
      "type": "object",
      "title": "Data",
      "required": [
        "drafts"
      ],
      "properties": {
        "drafts": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "DraftEntry",
            "required": [
              "id",
              "message"
            ],
            "properties": {
              "id": {
                "type": "string",
                "title": "Id",
                "description": "The unique identifier for the draft"
              },
              "message": {
                "type": "object",
                "title": "Message",
                "properties": {
                  "to": {
                    "type": "string",
                    "title": "To",
                    "description": "The To: header of the draft"
                  },
                  "sender": {
                    "type": "string",
                    "title": "Sender",
                    "description": "The From: header of the draft"
                  },
                  "payload": {
                    "type": "object",
                    "title": "Payload",
                    "description": "The MIME payload including headers and parts",
                    "additionalProperties": true
                  },
                  "preview": {
                    "type": "object",
                    "title": "Preview",
                    "properties": {
                      "body": {
                        "type": "string",
                        "title": "Body",
                        "description": "The preview body text"
                      },
                      "subject": {
                        "type": "string",
                        "title": "Subject",
                        "description": "The preview subject line"
                      }
                    },
                    "description": "A brief preview of the draft message"
                  },
                  "subject": {
                    "type": "string",
                    "title": "Subject",
                    "description": "The Subject: header of the draft"
                  },
                  "labelIds": {
                    "type": "array",
                    "items": {
                      "type": "string"
                    },
                    "title": "Label Ids",
                    "description": "Gmail label IDs applied to the draft"
                  },
                  "threadId": {
                    "type": "string",
                    "title": "Thread Id",
                    "description": "The Gmail thread ID containing the draft"
                  },
                  "messageId": {
                    "type": "string",
                    "title": "Message Id",
                    "description": "The Gmail message ID of the draft"
                  },
                  "messageText": {
                    "type": "string",
                    "title": "Message Text",
                    "description": "The full text content of the draft"
                  },
                  "attachmentList": {
                    "type": "array",
                    "items": {
                      "type": "object",
                      "additionalProperties": true
                    },
                    "title": "Attachment List",
                    "description": "Attachments included in the draft message"
                  },
                  "messageTimestamp": {
                    "type": "string",
                    "title": "Message Timestamp",
                    "description": "The ISO-8601 timestamp when the draft was last modified"
                  }
                },
                "description": "Full message data of the draft"
              }
            },
            "description": "A draft entry with identifier and message"
          },
          "title": "Drafts",
          "description": "A list of draft entries"
        },
        "display_url": {
          "type": "string",
          "title": "Display Url",
          "description": "Web UI link to Gmail drafts page"
        },
        "next_page_token": {
          "type": "string",
          "title": "Next Page Token",
          "description": "Token to retrieve the next page of drafts; empty if there are no more pages"
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

## GMAIL_LIST_FILTERS
Tool to list all Gmail filters (rules) in the mailbox. Use for security audits to detect malicious filter rules or before creating new filters to avoid duplicates.

**Input schema:**
```json
{
  "type": "object",
  "title": "ListFiltersRequest",
  "properties": {
    "user_id": {
      "type": "string",
      "title": "User Id",
      "default": "me",
      "examples": [
        "me",
        "user@example.com"
      ],
      "description": "The user's email address or the special value 'me' to indicate the authenticated user whose filters will be retrieved."
    }
  }
}
```

**Output schema:**
```json
{
  "type": "object",
  "$defs": {
    "Filter": {
      "type": "object",
      "title": "Filter",
      "properties": {
        "id": {
          "type": "string",
          "title": "Id",
          "description": "The server assigned ID of the filter."
        },
        "action": {
          "type": "object",
          "title": "Action",
          "properties": {
            "forward": {
              "type": "string",
              "title": "Forward",
              "description": "Email address that the message should be forwarded to."
            },
            "addLabelIds": {
              "type": "array",
              "items": {
                "type": "string"
              },
              "title": "Add Label Ids",
              "description": "List of label IDs to add to the message."
            },
            "removeLabelIds": {
              "type": "array",
              "items": {
                "type": "string"
              },
              "title": "Remove Label Ids",
              "description": "List of label IDs to remove from the message."
            }
          },
          "description": "Action that the filter performs."
        },
        "criteria": {
          "type": "object",
          "title": "Criteria",
          "properties": {
            "to": {
              "type": "string",
              "title": "To",
              "description": "The recipient's display name or email address (includes to, cc, and bcc fields)."
            },
            "from": {
              "type": "string",
              "title": "From",
              "description": "The sender's display name or email address."
            },
            "size": {
              "type": "integer",
              "title": "Size",
              "description": "The size of the entire RFC822 message in bytes."
            },
            "query": {
              "type": "string",
              "title": "Query",
              "description": "Only return messages matching the specified query using Gmail search syntax."
            },
            "subject": {
              "type": "string",
              "title": "Subject",
              "description": "Case-insensitive phrase found in the message's subject."
            },
            "excludeChats": {
              "type": "boolean",
              "title": "Exclude Chats",
              "description": "Whether the response should exclude chats."
            },
            "negatedQuery": {
              "type": "string",
              "title": "Negated Query",
              "description": "Only return messages not matching the specified query."
            },
            "hasAttachment": {
              "type": "boolean",
              "title": "Has Attachment",
              "description": "Whether the message has any attachment."
            },
            "sizeComparison": {
              "type": "string",
              "title": "Size Comparison",
              "description": "How the message size should be compared to the size field. Values: smaller, larger."
            }
          },
          "description": "Matching criteria for the filter."
        }
      },
      "description": "A Gmail filter configuration."
    },
    "FilterAction": {
      "type": "object",
      "title": "FilterAction",
      "properties": {
        "forward": {
          "type": "string",
          "title": "Forward",
          "description": "Email address that the message should be forwarded to."
        },
        "addLabelIds": {
          "type": "array",
          "items": {
            "type": "string"
          },
          "title": "Add Label Ids",
          "description": "List of label IDs to add to the message."
        },
        "removeLabelIds": {
          "type": "array",
          "items": {
            "type": "string"
          },
          "title": "Remove Label Ids",
          "description": "List of label IDs to remove from the message."
        }
      },
      "description": "Action that the filter performs on matched messages."
    },
    "FilterCriteria": {
      "type": "object",
      "title": "FilterCriteria",
      "properties": {
        "to": {
          "type": "string",
          "title": "To",
          "description": "The recipient's display name or email address (includes to, cc, and bcc fields)."
        },
        "from": {
          "type": "string",
          "title": "From",
          "description": "The sender's display name or email address."
        },
        "size": {
          "type": "integer",
          "title": "Size",
          "description": "The size of the entire RFC822 message in bytes."
        },
        "query": {
          "type": "string",
          "title": "Query",
          "description": "Only return messages matching the specified query using Gmail search syntax."
        },
        "subject": {
          "type": "string",
          "title": "Subject",
          "description": "Case-insensitive phrase found in the message's subject."
        },
        "excludeChats": {
          "type": "boolean",
          "title": "Exclude Chats",
          "description": "Whether the response should exclude chats."
        },
        "negatedQuery": {
          "type": "string",
          "title": "Negated Query",
          "description": "Only return messages not matching the specified query."
        },
        "hasAttachment": {
          "type": "boolean",
          "title": "Has Attachment",
          "description": "Whether the message has any attachment."
        },
        "sizeComparison": {
          "type": "string",
          "title": "Size Comparison",
          "description": "How the message size should be compared to the size field. Values: smaller, larger."
        }
      },
      "description": "Message matching criteria for the filter."
    },
    "ListFiltersResponse": {
      "type": "object",
      "title": "ListFiltersResponse",
      "properties": {
        "filter": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "Filter",
            "properties": {
              "id": {
                "type": "string",
                "title": "Id",
                "description": "The server assigned ID of the filter."
              },
              "action": {
                "type": "object",
                "title": "Action",
                "properties": {
                  "forward": {
                    "type": "string",
                    "title": "Forward",
                    "description": "Email address that the message should be forwarded to."
                  },
                  "addLabelIds": {
                    "type": "array",
                    "items": {
                      "type": "string"
                    },
                    "title": "Add Label Ids",
                    "description": "List of label IDs to add to the message."
                  },
                  "removeLabelIds": {
                    "type": "array",
                    "items": {
                      "type": "string"
                    },
                    "title": "Remove Label Ids",
                    "description": "List of label IDs to remove from the message."
                  }
                },
                "description": "Action that the filter performs."
              },
              "criteria": {
                "type": "object",
                "title": "Criteria",
                "properties": {
                  "to": {
                    "type": "string",
                    "title": "To",
                    "description": "The recipient's display name or email address (includes to, cc, and bcc fields)."
                  },
                  "from": {
                    "type": "string",
                    "title": "From",
                    "description": "The sender's display name or email address."
                  },
                  "size": {
                    "type": "integer",
                    "title": "Size",
                    "description": "The size of the entire RFC822 message in bytes."
                  },
                  "query": {
                    "type": "string",
                    "title": "Query",
                    "description": "Only return messages matching the specified query using Gmail search syntax."
                  },
                  "subject": {
                    "type": "string",
                    "title": "Subject",
                    "description": "Case-insensitive phrase found in the message's subject."
                  },
                  "excludeChats": {
                    "type": "boolean",
                    "title": "Exclude Chats",
                    "description": "Whether the response should exclude chats."
                  },
                  "negatedQuery": {
                    "type": "string",
                    "title": "Negated Query",
                    "description": "Only return messages not matching the specified query."
                  },
                  "hasAttachment": {
                    "type": "boolean",
                    "title": "Has Attachment",
                    "description": "Whether the message has any attachment."
                  },
                  "sizeComparison": {
                    "type": "string",
                    "title": "Size Comparison",
                    "description": "How the message size should be compared to the size field. Values: smaller, larger."
                  }
                },
                "description": "Matching criteria for the filter."
              }
            },
            "description": "A Gmail filter configuration."
          },
          "title": "Filter",
          "description": "Array of filter objects configured for the user."
        },
        "display_url": {
          "type": "string",
          "title": "Display Url",
          "description": "Web UI link for this resource - set by each action's execute()."
        }
      },
      "description": "List of Gmail filters."
    }
  },
  "title": "ListFiltersResponseWrapper",
  "required": [
    "data",
    "successful"
  ],
  "properties": {
    "data": {
      "type": "object",
      "title": "Data",
      "properties": {
        "filter": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "Filter",
            "properties": {
              "id": {
                "type": "string",
                "title": "Id",
                "description": "The server assigned ID of the filter."
              },
              "action": {
                "type": "object",
                "title": "Action",
                "properties": {
                  "forward": {
                    "type": "string",
                    "title": "Forward",
                    "description": "Email address that the message should be forwarded to."
                  },
                  "addLabelIds": {
                    "type": "array",
                    "items": {
                      "type": "string"
                    },
                    "title": "Add Label Ids",
                    "description": "List of label IDs to add to the message."
                  },
                  "removeLabelIds": {
                    "type": "array",
                    "items": {
                      "type": "string"
                    },
                    "title": "Remove Label Ids",
                    "description": "List of label IDs to remove from the message."
                  }
                },
                "description": "Action that the filter performs."
              },
              "criteria": {
                "type": "object",
                "title": "Criteria",
                "properties": {
                  "to": {
                    "type": "string",
                    "title": "To",
                    "description": "The recipient's display name or email address (includes to, cc, and bcc fields)."
                  },
                  "from": {
                    "type": "string",
                    "title": "From",
                    "description": "The sender's display name or email address."
                  },
                  "size": {
                    "type": "integer",
                    "title": "Size",
                    "description": "The size of the entire RFC822 message in bytes."
                  },
                  "query": {
                    "type": "string",
                    "title": "Query",
                    "description": "Only return messages matching the specified query using Gmail search syntax."
                  },
                  "subject": {
                    "type": "string",
                    "title": "Subject",
                    "description": "Case-insensitive phrase found in the message's subject."
                  },
                  "excludeChats": {
                    "type": "boolean",
                    "title": "Exclude Chats",
                    "description": "Whether the response should exclude chats."
                  },
                  "negatedQuery": {
                    "type": "string",
                    "title": "Negated Query",
                    "description": "Only return messages not matching the specified query."
                  },
                  "hasAttachment": {
                    "type": "boolean",
                    "title": "Has Attachment",
                    "description": "Whether the message has any attachment."
                  },
                  "sizeComparison": {
                    "type": "string",
                    "title": "Size Comparison",
                    "description": "How the message size should be compared to the size field. Values: smaller, larger."
                  }
                },
                "description": "Matching criteria for the filter."
              }
            },
            "description": "A Gmail filter configuration."
          },
          "title": "Filter",
          "description": "Array of filter objects configured for the user."
        },
        "display_url": {
          "type": "string",
          "title": "Display Url",
          "description": "Web UI link for this resource - set by each action's execute()."
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

## GMAIL_LIST_FORWARDING_ADDRESSES
Tool to list all forwarding addresses for the specified Gmail account. Use when you need to retrieve the email addresses that are allowed to be used for forwarding messages.

**Input schema:**
```json
{
  "type": "object",
  "title": "ListForwardingAddressesRequest",
  "properties": {
    "user_id": {
      "type": "string",
      "title": "User Id",
      "default": "me",
      "examples": [
        "me",
        "user@example.com"
      ],
      "description": "The user's email address or the special value 'me' to indicate the authenticated user whose forwarding addresses will be retrieved."
    }
  }
}
```

**Output schema:**
```json
{
  "type": "object",
  "$defs": {
    "ForwardingAddress": {
      "type": "object",
      "title": "ForwardingAddress",
      "properties": {
        "forwardingEmail": {
          "type": "string",
          "title": "Forwarding Email",
          "description": "The email address to which messages can be forwarded."
        },
        "verificationStatus": {
          "type": "string",
          "title": "Verification Status",
          "description": "Verification status of the forwarding address. Values: verificationStatusUnspecified, accepted, pending."
        }
      },
      "description": "Settings for a forwarding address."
    },
    "ListForwardingAddressesResponse": {
      "type": "object",
      "title": "ListForwardingAddressesResponse",
      "properties": {
        "display_url": {
          "type": "string",
          "title": "Display Url",
          "description": "Web UI link to the Gmail forwarding settings page."
        },
        "forwardingAddresses": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "ForwardingAddress",
            "properties": {
              "forwardingEmail": {
                "type": "string",
                "title": "Forwarding Email",
                "description": "The email address to which messages can be forwarded."
              },
              "verificationStatus": {
                "type": "string",
                "title": "Verification Status",
                "description": "Verification status of the forwarding address. Values: verificationStatusUnspecified, accepted, pending."
              }
            },
            "description": "Settings for a forwarding address."
          },
          "title": "Forwarding Addresses",
          "description": "List of email addresses that may be used for forwarding."
        }
      },
      "description": "List of forwarding addresses configured for the account."
    }
  },
  "title": "ListForwardingAddressesResponseWrapper",
  "required": [
    "data",
    "successful"
  ],
  "properties": {
    "data": {
      "type": "object",
      "title": "Data",
      "properties": {
        "display_url": {
          "type": "string",
          "title": "Display Url",
          "description": "Web UI link to the Gmail forwarding settings page."
        },
        "forwardingAddresses": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "ForwardingAddress",
            "properties": {
              "forwardingEmail": {
                "type": "string",
                "title": "Forwarding Email",
                "description": "The email address to which messages can be forwarded."
              },
              "verificationStatus": {
                "type": "string",
                "title": "Verification Status",
                "description": "Verification status of the forwarding address. Values: verificationStatusUnspecified, accepted, pending."
              }
            },
            "description": "Settings for a forwarding address."
          },
          "title": "Forwarding Addresses",
          "description": "List of email addresses that may be used for forwarding."
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

## GMAIL_LIST_HISTORY
Tool to list Gmail mailbox change history since a known startHistoryId. Use for incremental mailbox syncs. Persist the latest historyId as a checkpoint across sessions; without it, incremental sync is unreliable. An empty history list in the response is valid and means no new changes occurred.

**Input schema:**
```json
{
  "type": "object",
  "title": "ListHistoryRequest",
  "required": [
    "start_history_id"
  ],
  "properties": {
    "user_id": {
      "type": "string",
      "title": "User Id",
      "default": "me",
      "examples": [
        "me",
        "user@example.com"
      ],
      "description": "The user's email address. Use 'me' to specify the authenticated user.",
      "human_parameter_name": "User ID",
      "human_parameter_description": "The email address or identifier of the user whose mailbox you want to access. Use 'me' to access your own mailbox."
    },
    "label_id": {
      "type": "string",
      "title": "Label Id",
      "examples": [
        "INBOX"
      ],
      "description": "Only return history records involving messages with this label ID.",
      "human_parameter_name": "Label ID",
      "human_parameter_description": "Filter records to include only those related to a specific label. This helps you focus on changes that matter to you."
    },
    "page_token": {
      "type": "string",
      "title": "Page Token",
      "examples": [
        "ABCDEF123456"
      ],
      "description": "Token to retrieve a specific page of results. If the response includes nextPageToken, loop requests using this parameter until no nextPageToken is returned; failing to paginate will silently miss changes.",
      "human_parameter_name": "Page Token",
      "human_parameter_description": "Use this token if you want to get a specific page of results. It helps in navigating through large sets of data."
    },
    "max_results": {
      "type": "integer",
      "title": "Max Results",
      "default": 100,
      "maximum": 500,
      "minimum": 1,
      "examples": [
        100,
        500
      ],
      "description": "Maximum number of history records to return. Default is 100; max is 500.",
      "human_parameter_name": "Max Results",
      "human_parameter_description": "Specify the maximum number of history records to fetch. This controls how much data you want to retrieve at one time."
    },
    "history_types": {
      "type": "array",
      "items": {
        "enum": [
          "messageAdded",
          "messageDeleted",
          "labelAdded",
          "labelRemoved"
        ],
        "type": "string"
      },
      "title": "History Types",
      "examples": [
        [
          "messageAdded",
          "labelRemoved"
        ]
      ],
      "description": "Filter by specific history types. Allowed values: messageAdded, messageDeleted, labelAdded, labelRemoved.",
      "human_parameter_name": "History Types",
      "human_parameter_description": "Select the types of changes you want to retrieve, like added or deleted messages. This helps refine your search results."
    },
    "start_history_id": {
      "type": "string",
      "title": "Start History Id",
      "examples": [
        "1234567890"
      ],
      "description": "Required. Returns history records after this ID. If the ID is invalid or too old, the API returns 404. Perform a full sync in that case. Should be a numeric string. On 404 (historyIdTooOld) or 400 (invalidArgument), recover by fetching a fresh historyId via GMAIL_GET_PROFILE, then perform a one-time full sync via GMAIL_FETCH_EMAILS before resuming incremental calls.",
      "human_parameter_name": "Start History ID",
      "human_parameter_description": "Provide the unique history ID to start retrieving records. This helps in fetching changes made after a specific point."
    }
  }
}
```

**Output schema:**
```json
{
  "type": "object",
  "$defs": {
    "LabelAdded": {
      "type": "object",
      "title": "LabelAdded",
      "required": [
        "message",
        "labelIds"
      ],
      "properties": {
        "message": {
          "type": "object",
          "title": "Message",
          "required": [
            "id",
            "threadId"
          ],
          "properties": {
            "id": {
              "type": "string",
              "title": "Id",
              "description": "The message ID of the changed message."
            },
            "threadId": {
              "type": "string",
              "title": "Thread Id",
              "description": "The thread ID of the changed message."
            }
          },
          "description": "The message that had labels added."
        },
        "labelIds": {
          "type": "array",
          "items": {
            "type": "string"
          },
          "title": "Label Ids",
          "description": "List of label IDs added to the message."
        }
      }
    },
    "LabelRemoved": {
      "type": "object",
      "title": "LabelRemoved",
      "required": [
        "message",
        "labelIds"
      ],
      "properties": {
        "message": {
          "type": "object",
          "title": "Message",
          "required": [
            "id",
            "threadId"
          ],
          "properties": {
            "id": {
              "type": "string",
              "title": "Id",
              "description": "The message ID of the changed message."
            },
            "threadId": {
              "type": "string",
              "title": "Thread Id",
              "description": "The thread ID of the changed message."
            }
          },
          "description": "The message that had labels removed."
        },
        "labelIds": {
          "type": "array",
          "items": {
            "type": "string"
          },
          "title": "Label Ids",
          "description": "List of label IDs removed from the message."
        }
      }
    },
    "MessageAdded": {
      "type": "object",
      "title": "MessageAdded",
      "required": [
        "message"
      ],
      "properties": {
        "message": {
          "type": "object",
          "title": "Message",
          "required": [
            "id",
            "threadId"
          ],
          "properties": {
            "id": {
              "type": "string",
              "title": "Id",
              "description": "The message ID of the changed message."
            },
            "threadId": {
              "type": "string",
              "title": "Thread Id",
              "description": "The thread ID of the changed message."
            }
          },
          "description": "The message that was added."
        }
      }
    },
    "HistoryRecord": {
      "type": "object",
      "title": "HistoryRecord",
      "required": [
        "id"
      ],
      "properties": {
        "id": {
          "type": "string",
          "title": "Id",
          "description": "Mailbox sequence ID for this history record."
        },
        "messages": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "HistoryMessage",
            "required": [
              "id",
              "threadId"
            ],
            "properties": {
              "id": {
                "type": "string",
                "title": "Id",
                "description": "The message ID of the changed message."
              },
              "threadId": {
                "type": "string",
                "title": "Thread Id",
                "description": "The thread ID of the changed message."
              }
            }
          },
          "title": "Messages",
          "description": "All messages changed in this record (shallow info)."
        },
        "labelsAdded": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "LabelAdded",
            "required": [
              "message",
              "labelIds"
            ],
            "properties": {
              "message": {
                "type": "object",
                "title": "Message",
                "required": [
                  "id",
                  "threadId"
                ],
                "properties": {
                  "id": {
                    "type": "string",
                    "title": "Id",
                    "description": "The message ID of the changed message."
                  },
                  "threadId": {
                    "type": "string",
                    "title": "Thread Id",
                    "description": "The thread ID of the changed message."
                  }
                },
                "description": "The message that had labels added."
              },
              "labelIds": {
                "type": "array",
                "items": {
                  "type": "string"
                },
                "title": "Label Ids",
                "description": "List of label IDs added to the message."
              }
            }
          },
          "title": "Labels Added",
          "description": "Labels added to messages in this history record."
        },
        "labelsRemoved": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "LabelRemoved",
            "required": [
              "message",
              "labelIds"
            ],
            "properties": {
              "message": {
                "type": "object",
                "title": "Message",
                "required": [
                  "id",
                  "threadId"
                ],
                "properties": {
                  "id": {
                    "type": "string",
                    "title": "Id",
                    "description": "The message ID of the changed message."
                  },
                  "threadId": {
                    "type": "string",
                    "title": "Thread Id",
                    "description": "The thread ID of the changed message."
                  }
                },
                "description": "The message that had labels removed."
              },
              "labelIds": {
                "type": "array",
                "items": {
                  "type": "string"
                },
                "title": "Label Ids",
                "description": "List of label IDs removed from the message."
              }
            }
          },
          "title": "Labels Removed",
          "description": "Labels removed from messages in this history record."
        },
        "messagesAdded": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "MessageAdded",
            "required": [
              "message"
            ],
            "properties": {
              "message": {
                "type": "object",
                "title": "Message",
                "required": [
                  "id",
                  "threadId"
                ],
                "properties": {
                  "id": {
                    "type": "string",
                    "title": "Id",
                    "description": "The message ID of the changed message."
                  },
                  "threadId": {
                    "type": "string",
                    "title": "Thread Id",
                    "description": "The thread ID of the changed message."
                  }
                },
                "description": "The message that was added."
              }
            }
          },
          "title": "Messages Added",
          "description": "Messages added in this history record."
        },
        "messagesDeleted": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "MessageDeleted",
            "required": [
              "message"
            ],
            "properties": {
              "message": {
                "type": "object",
                "title": "Message",
                "required": [
                  "id",
                  "threadId"
                ],
                "properties": {
                  "id": {
                    "type": "string",
                    "title": "Id",
                    "description": "The message ID of the changed message."
                  },
                  "threadId": {
                    "type": "string",
                    "title": "Thread Id",
                    "description": "The thread ID of the changed message."
                  }
                },
                "description": "The message that was deleted."
              }
            }
          },
          "title": "Messages Deleted",
          "description": "Messages deleted (not trashed) in this history record."
        }
      }
    },
    "HistoryMessage": {
      "type": "object",
      "title": "HistoryMessage",
      "required": [
        "id",
        "threadId"
      ],
      "properties": {
        "id": {
          "type": "string",
          "title": "Id",
          "description": "The message ID of the changed message."
        },
        "threadId": {
          "type": "string",
          "title": "Thread Id",
          "description": "The thread ID of the changed message."
        }
      }
    },
    "MessageDeleted": {
      "type": "object",
      "title": "MessageDeleted",
      "required": [
        "message"
      ],
      "properties": {
        "message": {
          "type": "object",
          "title": "Message",
          "required": [
            "id",
            "threadId"
          ],
          "properties": {
            "id": {
              "type": "string",
              "title": "Id",
              "description": "The message ID of the changed message."
            },
            "threadId": {
              "type": "string",
              "title": "Thread Id",
              "description": "The thread ID of the changed message."
            }
          },
          "description": "The message that was deleted."
        }
      }
    },
    "ListHistoryResponse": {
      "type": "object",
      "title": "ListHistoryResponse",
      "required": [
        "historyId"
      ],
      "properties": {
        "history": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "HistoryRecord",
            "required": [
              "id"
            ],
            "properties": {
              "id": {
                "type": "string",
                "title": "Id",
                "description": "Mailbox sequence ID for this history record."
              },
              "messages": {
                "type": "array",
                "items": {
                  "type": "object",
                  "title": "HistoryMessage",
                  "required": [
                    "id",
                    "threadId"
                  ],
                  "properties": {
                    "id": {
                      "type": "string",
                      "title": "Id",
                      "description": "The message ID of the changed message."
                    },
                    "threadId": {
                      "type": "string",
                      "title": "Thread Id",
                      "description": "The thread ID of the changed message."
                    }
                  }
                },
                "title": "Messages",
                "description": "All messages changed in this record (shallow info)."
              },
              "labelsAdded": {
                "type": "array",
                "items": {
                  "type": "object",
                  "title": "LabelAdded",
                  "required": [
                    "message",
                    "labelIds"
                  ],
                  "properties": {
                    "message": {
                      "type": "object",
                      "title": "Message",
                      "required": [
                        "id",
                        "threadId"
                      ],
                      "properties": {
                        "id": {
                          "type": "string",
                          "title": "Id",
                          "description": "The message ID of the changed message."
                        },
                        "threadId": {
                          "type": "string",
                          "title": "Thread Id",
                          "description": "The thread ID of the changed message."
                        }
                      },
                      "description": "The message that had labels added."
                    },
                    "labelIds": {
                      "type": "array",
                      "items": {
                        "type": "string"
                      },
                      "title": "Label Ids",
                      "description": "List of label IDs added to the message."
                    }
                  }
                },
                "title": "Labels Added",
                "description": "Labels added to messages in this history record."
              },
              "labelsRemoved": {
                "type": "array",
                "items": {
                  "type": "object",
                  "title": "LabelRemoved",
                  "required": [
                    "message",
                    "labelIds"
                  ],
                  "properties": {
                    "message": {
                      "type": "object",
                      "title": "Message",
                      "required": [
                        "id",
                        "threadId"
                      ],
                      "properties": {
                        "id": {
                          "type": "string",
                          "title": "Id",
                          "description": "The message ID of the changed message."
                        },
                        "threadId": {
                          "type": "string",
                          "title": "Thread Id",
                          "description": "The thread ID of the changed message."
                        }
                      },
                      "description": "The message that had labels removed."
                    },
                    "labelIds": {
                      "type": "array",
                      "items": {
                        "type": "string"
                      },
                      "title": "Label Ids",
                      "description": "List of label IDs removed from the message."
                    }
                  }
                },
                "title": "Labels Removed",
                "description": "Labels removed from messages in this history record."
              },
              "messagesAdded": {
                "type": "array",
                "items": {
                  "type": "object",
                  "title": "MessageAdded",
                  "required": [
                    "message"
                  ],
                  "properties": {
                    "message": {
                      "type": "object",
                      "title": "Message",
                      "required": [
                        "id",
                        "threadId"
                      ],
                      "properties": {
                        "id": {
                          "type": "string",
                          "title": "Id",
                          "description": "The message ID of the changed message."
                        },
                        "threadId": {
                          "type": "string",
                          "title": "Thread Id",
                          "description": "The thread ID of the changed message."
                        }
                      },
                      "description": "The message that was added."
                    }
                  }
                },
                "title": "Messages Added",
                "description": "Messages added in this history record."
              },
              "messagesDeleted": {
                "type": "array",
                "items": {
                  "type": "object",
                  "title": "MessageDeleted",
                  "required": [
                    "message"
                  ],
                  "properties": {
                    "message": {
                      "type": "object",
                      "title": "Message",
                      "required": [
                        "id",
                        "threadId"
                      ],
                      "properties": {
                        "id": {
                          "type": "string",
                          "title": "Id",
                          "description": "The message ID of the changed message."
                        },
                        "threadId": {
                          "type": "string",
                          "title": "Thread Id",
                          "description": "The thread ID of the changed message."
                        }
                      },
                      "description": "The message that was deleted."
                    }
                  }
                },
                "title": "Messages Deleted",
                "description": "Messages deleted (not trashed) in this history record."
              }
            }
          },
          "title": "History",
          "default": [],
          "description": "List of history records in chronological order. Empty if no changes since startHistoryId."
        },
        "historyId": {
          "type": "string",
          "title": "History Id",
          "description": "ID of the mailbox's current history record."
        },
        "display_url": {
          "type": "string",
          "title": "Display Url",
          "description": "Web UI link for this resource - set by each action's execute(). No direct Gmail web UI for history records."
        },
        "nextPageToken": {
          "type": "string",
          "title": "Next Page Token",
          "description": "Token for the next page of results."
        }
      }
    }
  },
  "title": "ListHistoryResponseWrapper",
  "required": [
    "data",
    "successful"
  ],
  "properties": {
    "data": {
      "type": "object",
      "title": "Data",
      "required": [
        "historyId"
      ],
      "properties": {
        "history": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "HistoryRecord",
            "required": [
              "id"
            ],
            "properties": {
              "id": {
                "type": "string",
                "title": "Id",
                "description": "Mailbox sequence ID for this history record."
              },
              "messages": {
                "type": "array",
                "items": {
                  "type": "object",
                  "title": "HistoryMessage",
                  "required": [
                    "id",
                    "threadId"
                  ],
                  "properties": {
                    "id": {
                      "type": "string",
                      "title": "Id",
                      "description": "The message ID of the changed message."
                    },
                    "threadId": {
                      "type": "string",
                      "title": "Thread Id",
                      "description": "The thread ID of the changed message."
                    }
                  }
                },
                "title": "Messages",
                "description": "All messages changed in this record (shallow info)."
              },
              "labelsAdded": {
                "type": "array",
                "items": {
                  "type": "object",
                  "title": "LabelAdded",
                  "required": [
                    "message",
                    "labelIds"
                  ],
                  "properties": {
                    "message": {
                      "type": "object",
                      "title": "Message",
                      "required": [
                        "id",
                        "threadId"
                      ],
                      "properties": {
                        "id": {
                          "type": "string",
                          "title": "Id",
                          "description": "The message ID of the changed message."
                        },
                        "threadId": {
                          "type": "string",
                          "title": "Thread Id",
                          "description": "The thread ID of the changed message."
                        }
                      },
                      "description": "The message that had labels added."
                    },
                    "labelIds": {
                      "type": "array",
                      "items": {
                        "type": "string"
                      },
                      "title": "Label Ids",
                      "description": "List of label IDs added to the message."
                    }
                  }
                },
                "title": "Labels Added",
                "description": "Labels added to messages in this history record."
              },
              "labelsRemoved": {
                "type": "array",
                "items": {
                  "type": "object",
                  "title": "LabelRemoved",
                  "required": [
                    "message",
                    "labelIds"
                  ],
                  "properties": {
                    "message": {
                      "type": "object",
                      "title": "Message",
                      "required": [
                        "id",
                        "threadId"
                      ],
                      "properties": {
                        "id": {
                          "type": "string",
                          "title": "Id",
                          "description": "The message ID of the changed message."
                        },
                        "threadId": {
                          "type": "string",
                          "title": "Thread Id",
                          "description": "The thread ID of the changed message."
                        }
                      },
                      "description": "The message that had labels removed."
                    },
                    "labelIds": {
                      "type": "array",
                      "items": {
                        "type": "string"
                      },
                      "title": "Label Ids",
                      "description": "List of label IDs removed from the message."
                    }
                  }
                },
                "title": "Labels Removed",
                "description": "Labels removed from messages in this history record."
              },
              "messagesAdded": {
                "type": "array",
                "items": {
                  "type": "object",
                  "title": "MessageAdded",
                  "required": [
                    "message"
                  ],
                  "properties": {
                    "message": {
                      "type": "object",
                      "title": "Message",
                      "required": [
                        "id",
                        "threadId"
                      ],
                      "properties": {
                        "id": {
                          "type": "string",
                          "title": "Id",
                          "description": "The message ID of the changed message."
                        },
                        "threadId": {
                          "type": "string",
                          "title": "Thread Id",
                          "description": "The thread ID of the changed message."
                        }
                      },
                      "description": "The message that was added."
                    }
                  }
                },
                "title": "Messages Added",
                "description": "Messages added in this history record."
              },
              "messagesDeleted": {
                "type": "array",
                "items": {
                  "type": "object",
                  "title": "MessageDeleted",
                  "required": [
                    "message"
                  ],
                  "properties": {
                    "message": {
                      "type": "object",
                      "title": "Message",
                      "required": [
                        "id",
                        "threadId"
                      ],
                      "properties": {
                        "id": {
                          "type": "string",
                          "title": "Id",
                          "description": "The message ID of the changed message."
                        },
                        "threadId": {
                          "type": "string",
                          "title": "Thread Id",
                          "description": "The thread ID of the changed message."
                        }
                      },
                      "description": "The message that was deleted."
                    }
                  }
                },
                "title": "Messages Deleted",
                "description": "Messages deleted (not trashed) in this history record."
              }
            }
          },
          "title": "History",
          "default": [],
          "description": "List of history records in chronological order. Empty if no changes since startHistoryId."
        },
        "historyId": {
          "type": "string",
          "title": "History Id",
          "description": "ID of the mailbox's current history record."
        },
        "display_url": {
          "type": "string",
          "title": "Display Url",
          "description": "Web UI link for this resource - set by each action's execute(). No direct Gmail web UI for history records."
        },
        "nextPageToken": {
          "type": "string",
          "title": "Next Page Token",
          "description": "Token for the next page of results."
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

## GMAIL_LIST_LABELS
Retrieves all system and user-created labels for a Gmail account in a single unpaginated response. Primary use: obtain internal label IDs (e.g., 'Label_123') required by other Gmail tools — display names cannot be used as label identifiers and cause silent failures or errors. System labels (INBOX, UNREAD, SPAM, TRASH, etc.) are case-sensitive and must be used exactly as returned; INBOX, SPAM, and TRASH are read-only and cannot be added/removed via label modification tools. The Gmail search 'label:' operator accepts display names, but label_ids parameters in tools like GMAIL_FETCH_EMAILS require internal IDs from this tool — mixing conventions yields zero results silently. Do not hardcode label IDs across sessions; refresh via this tool on conflict errors.

**Input schema:**
```json
{
  "type": "object",
  "title": "ListLabelsRequest",
  "properties": {
    "user_id": {
      "type": "string",
      "title": "User Id",
      "default": "me",
      "examples": [
        "me",
        "user@example.com"
      ],
      "description": "Identifies the Gmail account (owner's email or 'me' for authenticated user) for which labels will be listed.",
      "human_parameter_name": "User ID",
      "human_parameter_description": "Provide the email address or identifier of the Gmail account whose labels you want to list. Use 'me' to access your own account."
    },
    "include_details": {
      "type": "boolean",
      "title": "Include Details",
      "default": false,
      "examples": [
        true,
        false
      ],
      "description": "If true, fetches detailed info for each label including message/thread counts (messagesTotal, messagesUnread, threadsTotal, threadsUnread). This requires additional API calls and may be slower for accounts with many labels. If false (default), returns basic label info (id, name, type) which is faster. Counts are eventually consistent and may lag real-time mailbox state by a few seconds.",
      "human_parameter_name": "Include details",
      "human_parameter_description": "Set to true if you need message and thread counts for each label. Leave false for faster results with basic label info."
    }
  }
}
```

**Output schema:**
```json
{
  "type": "object",
  "$defs": {
    "Label": {
      "type": "object",
      "title": "Label",
      "required": [
        "id",
        "name"
      ],
      "properties": {
        "id": {
          "type": "string",
          "title": "Id",
          "description": "The immutable ID of the label."
        },
        "name": {
          "type": "string",
          "title": "Name",
          "description": "The display name of the label."
        },
        "type": {
          "type": "string",
          "title": "Type",
          "description": "The type of label (system or user)."
        },
        "color": {
          "type": "object",
          "title": "Color",
          "required": [
            "backgroundColor",
            "textColor"
          ],
          "properties": {
            "textColor": {
              "type": "string",
              "title": "Text Color",
              "description": "Hex code for the text color of the label."
            },
            "backgroundColor": {
              "type": "string",
              "title": "Background Color",
              "description": "Hex code for the background color of the label."
            }
          },
          "description": "Optional color settings for the label."
        },
        "display_url": {
          "type": "string",
          "title": "Display Url",
          "description": "Web UI link for this resource - set by each action's execute()."
        },
        "threadsTotal": {
          "type": "integer",
          "title": "Threads Total",
          "description": "The total number of threads with the label."
        },
        "messagesTotal": {
          "type": "integer",
          "title": "Messages Total",
          "description": "The total number of messages with the label."
        },
        "threadsUnread": {
          "type": "integer",
          "title": "Threads Unread",
          "description": "The number of unread threads with the label."
        },
        "messagesUnread": {
          "type": "integer",
          "title": "Messages Unread",
          "description": "The number of unread messages with the label."
        },
        "labelListVisibility": {
          "type": "string",
          "title": "Label List Visibility",
          "description": "Visibility of the label in the label list (e.g., 'labelShow' or 'labelHide')."
        },
        "messageListVisibility": {
          "type": "string",
          "title": "Message List Visibility",
          "description": "Visibility of messages with the label in the message list (e.g., 'show' or 'hide')."
        }
      }
    },
    "LabelColor": {
      "type": "object",
      "title": "LabelColor",
      "required": [
        "backgroundColor",
        "textColor"
      ],
      "properties": {
        "textColor": {
          "type": "string",
          "title": "Text Color",
          "description": "Hex code for the text color of the label."
        },
        "backgroundColor": {
          "type": "string",
          "title": "Background Color",
          "description": "Hex code for the background color of the label."
        }
      }
    },
    "ListLabelsResponse": {
      "type": "object",
      "title": "ListLabelsResponse",
      "required": [
        "labels"
      ],
      "properties": {
        "labels": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "Label",
            "required": [
              "id",
              "name"
            ],
            "properties": {
              "id": {
                "type": "string",
                "title": "Id",
                "description": "The immutable ID of the label."
              },
              "name": {
                "type": "string",
                "title": "Name",
                "description": "The display name of the label."
              },
              "type": {
                "type": "string",
                "title": "Type",
                "description": "The type of label (system or user)."
              },
              "color": {
                "type": "object",
                "title": "Color",
                "required": [
                  "backgroundColor",
                  "textColor"
                ],
                "properties": {
                  "textColor": {
                    "type": "string",
                    "title": "Text Color",
                    "description": "Hex code for the text color of the label."
                  },
                  "backgroundColor": {
                    "type": "string",
                    "title": "Background Color",
                    "description": "Hex code for the background color of the label."
                  }
                },
                "description": "Optional color settings for the label."
              },
              "display_url": {
                "type": "string",
                "title": "Display Url",
                "description": "Web UI link for this resource - set by each action's execute()."
              },
              "threadsTotal": {
                "type": "integer",
                "title": "Threads Total",
                "description": "The total number of threads with the label."
              },
              "messagesTotal": {
                "type": "integer",
                "title": "Messages Total",
                "description": "The total number of messages with the label."
              },
              "threadsUnread": {
                "type": "integer",
                "title": "Threads Unread",
                "description": "The number of unread threads with the label."
              },
              "messagesUnread": {
                "type": "integer",
                "title": "Messages Unread",
                "description": "The number of unread messages with the label."
              },
              "labelListVisibility": {
                "type": "string",
                "title": "Label List Visibility",
                "description": "Visibility of the label in the label list (e.g., 'labelShow' or 'labelHide')."
              },
              "messageListVisibility": {
                "type": "string",
                "title": "Message List Visibility",
                "description": "Visibility of messages with the label in the message list (e.g., 'show' or 'hide')."
              }
            }
          },
          "title": "Labels",
          "description": "A list of label objects in the user's mailbox."
        },
        "display_url": {
          "type": "string",
          "title": "Display Url",
          "description": "Web UI link for this resource \u2014 points to Gmail labels settings page."
        }
      }
    }
  },
  "title": "ListLabelsResponseWrapper",
  "required": [
    "data",
    "successful"
  ],
  "properties": {
    "data": {
      "type": "object",
      "title": "Data",
      "required": [
        "labels"
      ],
      "properties": {
        "labels": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "Label",
            "required": [
              "id",
              "name"
            ],
            "properties": {
              "id": {
                "type": "string",
                "title": "Id",
                "description": "The immutable ID of the label."
              },
              "name": {
                "type": "string",
                "title": "Name",
                "description": "The display name of the label."
              },
              "type": {
                "type": "string",
                "title": "Type",
                "description": "The type of label (system or user)."
              },
              "color": {
                "type": "object",
                "title": "Color",
                "required": [
                  "backgroundColor",
                  "textColor"
                ],
                "properties": {
                  "textColor": {
                    "type": "string",
                    "title": "Text Color",
                    "description": "Hex code for the text color of the label."
                  },
                  "backgroundColor": {
                    "type": "string",
                    "title": "Background Color",
                    "description": "Hex code for the background color of the label."
                  }
                },
                "description": "Optional color settings for the label."
              },
              "display_url": {
                "type": "string",
                "title": "Display Url",
                "description": "Web UI link for this resource - set by each action's execute()."
              },
              "threadsTotal": {
                "type": "integer",
                "title": "Threads Total",
                "description": "The total number of threads with the label."
              },
              "messagesTotal": {
                "type": "integer",
                "title": "Messages Total",
                "description": "The total number of messages with the label."
              },
              "threadsUnread": {
                "type": "integer",
                "title": "Threads Unread",
                "description": "The number of unread threads with the label."
              },
              "messagesUnread": {
                "type": "integer",
                "title": "Messages Unread",
                "description": "The number of unread messages with the label."
              },
              "labelListVisibility": {
                "type": "string",
                "title": "Label List Visibility",
                "description": "Visibility of the label in the label list (e.g., 'labelShow' or 'labelHide')."
              },
              "messageListVisibility": {
                "type": "string",
                "title": "Message List Visibility",
                "description": "Visibility of messages with the label in the message list (e.g., 'show' or 'hide')."
              }
            }
          },
          "title": "Labels",
          "description": "A list of label objects in the user's mailbox."
        },
        "display_url": {
          "type": "string",
          "title": "Display Url",
          "description": "Web UI link for this resource \u2014 points to Gmail labels settings page."
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

## GMAIL_LIST_MESSAGES
DEPRECATED: Use GMAIL_FETCH_EMAILS instead. Lists the messages in the user's mailbox. Use when you need to retrieve a list of email messages with optional filtering by labels or search query.

**Input schema:**
```json
{
  "type": "object",
  "title": "ListMessagesRequest",
  "properties": {
    "q": {
      "type": "string",
      "title": "Q",
      "examples": [
        "is:unread",
        "from:example@example.com",
        "subject:meeting"
      ],
      "description": "Only return messages matching the specified query. Supports the same query format as the Gmail search box. For example, 'from:someuser@example.com is:unread'. Cannot be used when accessing the API using the gmail.metadata scope."
    },
    "user_id": {
      "type": "string",
      "title": "User Id",
      "default": "me",
      "examples": [
        "me",
        "user@example.com"
      ],
      "description": "The user's email address or 'me' to specify the authenticated user."
    },
    "label_ids": {
      "type": "array",
      "items": {
        "type": "string"
      },
      "title": "Label Ids",
      "examples": [
        [
          "INBOX"
        ],
        [
          "UNREAD",
          "IMPORTANT"
        ]
      ],
      "description": "Only return messages with labels that match all of the specified label IDs. Messages in a thread might have labels that other messages in the same thread don't have."
    },
    "page_token": {
      "type": "string",
      "title": "Page Token",
      "examples": [
        "NextPageToken123"
      ],
      "description": "Page token to retrieve a specific page of results in the list."
    },
    "max_results": {
      "type": "integer",
      "title": "Max Results",
      "maximum": 500,
      "minimum": 1,
      "examples": [
        10,
        50,
        100
      ],
      "description": "Maximum number of messages to return. Defaults to 100. The maximum allowed value is 500."
    },
    "include_spam_trash": {
      "type": "boolean",
      "title": "Include Spam Trash",
      "examples": [
        true,
        false
      ],
      "description": "Include messages from SPAM and TRASH in the results. Default is false."
    }
  }
}
```

**Output schema:**
```json
{
  "type": "object",
  "$defs": {
    "Message": {
      "type": "object",
      "title": "Message",
      "required": [
        "id",
        "threadId"
      ],
      "properties": {
        "id": {
          "type": "string",
          "title": "Id",
          "description": "The immutable ID of the message."
        },
        "threadId": {
          "type": "string",
          "title": "Thread Id",
          "description": "The ID of the thread the message belongs to."
        }
      },
      "description": "Represents a minimal Gmail message with ID and thread ID."
    },
    "ListMessagesResponse": {
      "type": "object",
      "title": "ListMessagesResponse",
      "properties": {
        "messages": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "Message",
            "required": [
              "id",
              "threadId"
            ],
            "properties": {
              "id": {
                "type": "string",
                "title": "Id",
                "description": "The immutable ID of the message."
              },
              "threadId": {
                "type": "string",
                "title": "Thread Id",
                "description": "The ID of the thread the message belongs to."
              }
            },
            "description": "Represents a minimal Gmail message with ID and thread ID."
          },
          "title": "Messages",
          "description": "List of messages. Each message resource contains only an id and a threadId. Additional message details can be fetched using the messages.get method."
        },
        "nextPageToken": {
          "type": "string",
          "title": "Next Page Token",
          "description": "Token to retrieve the next page of results in the list."
        },
        "resultSizeEstimate": {
          "type": "integer",
          "title": "Result Size Estimate",
          "description": "Estimated total number of results."
        }
      }
    }
  },
  "title": "ListMessagesResponseWrapper",
  "required": [
    "data",
    "successful"
  ],
  "properties": {
    "data": {
      "type": "object",
      "title": "Data",
      "properties": {
        "messages": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "Message",
            "required": [
              "id",
              "threadId"
            ],
            "properties": {
              "id": {
                "type": "string",
                "title": "Id",
                "description": "The immutable ID of the message."
              },
              "threadId": {
                "type": "string",
                "title": "Thread Id",
                "description": "The ID of the thread the message belongs to."
              }
            },
            "description": "Represents a minimal Gmail message with ID and thread ID."
          },
          "title": "Messages",
          "description": "List of messages. Each message resource contains only an id and a threadId. Additional message details can be fetched using the messages.get method."
        },
        "nextPageToken": {
          "type": "string",
          "title": "Next Page Token",
          "description": "Token to retrieve the next page of results in the list."
        },
        "resultSizeEstimate": {
          "type": "integer",
          "title": "Result Size Estimate",
          "description": "Estimated total number of results."
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

## GMAIL_LIST_SEND_AS
Lists the send-as aliases for a Gmail account, including the primary address and custom 'from' aliases. Use when you need to retrieve available sending addresses for composing emails.

**Input schema:**
```json
{
  "type": "object",
  "title": "ListSendAsRequest",
  "properties": {
    "user_id": {
      "type": "string",
      "title": "User Id",
      "default": "me",
      "examples": [
        "me",
        "user@example.com"
      ],
      "description": "The user's email address or the special value 'me' to indicate the authenticated user whose send-as aliases will be retrieved."
    }
  }
}
```

**Output schema:**
```json
{
  "type": "object",
  "$defs": {
    "SendAs": {
      "type": "object",
      "title": "SendAs",
      "properties": {
        "smtpMsa": {
          "type": "object",
          "title": "Smtp Msa",
          "properties": {
            "host": {
              "type": "string",
              "title": "Host",
              "description": "The hostname of the SMTP service."
            },
            "port": {
              "type": "integer",
              "title": "Port",
              "description": "The port of the SMTP service."
            },
            "securityMode": {
              "type": "string",
              "title": "Security Mode",
              "description": "Protocol securing communication with SMTP service. Values: securityModeUnspecified, none, ssl, starttls."
            }
          },
          "description": "SMTP relay configuration for outbound mail routing."
        },
        "isDefault": {
          "type": "boolean",
          "title": "Is Default",
          "description": "Indicates if this is the default From address for composing messages or vacation replies."
        },
        "isPrimary": {
          "type": "boolean",
          "title": "Is Primary",
          "description": "Read-only indicator of whether this is the account's primary login address. Every Gmail account has exactly one primary address."
        },
        "signature": {
          "type": "string",
          "title": "Signature",
          "description": "Optional HTML signature appended to new emails composed with this alias in Gmail's web interface."
        },
        "displayName": {
          "type": "string",
          "title": "Display Name",
          "description": "Custom name appearing in the From header. Gmail populates this with the primary account name if left empty for custom addresses."
        },
        "sendAsEmail": {
          "type": "string",
          "title": "Send As Email",
          "description": "The email address that appears in the 'From:' header for mail sent using this alias."
        },
        "treatAsAlias": {
          "type": "boolean",
          "title": "Treat As Alias",
          "description": "Whether Gmail treats this address as an alias for the primary email. Applies only to custom from aliases."
        },
        "replyToAddress": {
          "type": "string",
          "title": "Reply To Address",
          "description": "Optional email included in Reply-To headers. Omitted if empty."
        },
        "verificationStatus": {
          "type": "string",
          "title": "Verification Status",
          "description": "Status indicating whether the address is verified. Values: verificationStatusUnspecified, accepted, pending."
        }
      },
      "description": "A send-as alias configuration."
    },
    "SmtpMsa": {
      "type": "object",
      "title": "SmtpMsa",
      "properties": {
        "host": {
          "type": "string",
          "title": "Host",
          "description": "The hostname of the SMTP service."
        },
        "port": {
          "type": "integer",
          "title": "Port",
          "description": "The port of the SMTP service."
        },
        "securityMode": {
          "type": "string",
          "title": "Security Mode",
          "description": "Protocol securing communication with SMTP service. Values: securityModeUnspecified, none, ssl, starttls."
        }
      },
      "description": "SMTP relay configuration for outbound mail routing."
    },
    "ListSendAsResponse": {
      "type": "object",
      "title": "ListSendAsResponse",
      "properties": {
        "sendAs": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "SendAs",
            "properties": {
              "smtpMsa": {
                "type": "object",
                "title": "Smtp Msa",
                "properties": {
                  "host": {
                    "type": "string",
                    "title": "Host",
                    "description": "The hostname of the SMTP service."
                  },
                  "port": {
                    "type": "integer",
                    "title": "Port",
                    "description": "The port of the SMTP service."
                  },
                  "securityMode": {
                    "type": "string",
                    "title": "Security Mode",
                    "description": "Protocol securing communication with SMTP service. Values: securityModeUnspecified, none, ssl, starttls."
                  }
                },
                "description": "SMTP relay configuration for outbound mail routing."
              },
              "isDefault": {
                "type": "boolean",
                "title": "Is Default",
                "description": "Indicates if this is the default From address for composing messages or vacation replies."
              },
              "isPrimary": {
                "type": "boolean",
                "title": "Is Primary",
                "description": "Read-only indicator of whether this is the account's primary login address. Every Gmail account has exactly one primary address."
              },
              "signature": {
                "type": "string",
                "title": "Signature",
                "description": "Optional HTML signature appended to new emails composed with this alias in Gmail's web interface."
              },
              "displayName": {
                "type": "string",
                "title": "Display Name",
                "description": "Custom name appearing in the From header. Gmail populates this with the primary account name if left empty for custom addresses."
              },
              "sendAsEmail": {
                "type": "string",
                "title": "Send As Email",
                "description": "The email address that appears in the 'From:' header for mail sent using this alias."
              },
              "treatAsAlias": {
                "type": "boolean",
                "title": "Treat As Alias",
                "description": "Whether Gmail treats this address as an alias for the primary email. Applies only to custom from aliases."
              },
              "replyToAddress": {
                "type": "string",
                "title": "Reply To Address",
                "description": "Optional email included in Reply-To headers. Omitted if empty."
              },
              "verificationStatus": {
                "type": "string",
                "title": "Verification Status",
                "description": "Status indicating whether the address is verified. Values: verificationStatusUnspecified, accepted, pending."
              }
            },
            "description": "A send-as alias configuration."
          },
          "title": "Send As",
          "description": "List of send-as aliases including the primary address and any custom 'from' aliases."
        },
        "display_url": {
          "type": "string",
          "title": "Display Url",
          "description": "Web UI link to the Gmail Accounts settings page where send-as aliases are managed."
        }
      },
      "description": "List of send-as aliases for the user."
    }
  },
  "title": "ListSendAsResponseWrapper",
  "required": [
    "data",
    "successful"
  ],
  "properties": {
    "data": {
      "type": "object",
      "title": "Data",
      "properties": {
        "sendAs": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "SendAs",
            "properties": {
              "smtpMsa": {
                "type": "object",
                "title": "Smtp Msa",
                "properties": {
                  "host": {
                    "type": "string",
                    "title": "Host",
                    "description": "The hostname of the SMTP service."
                  },
                  "port": {
                    "type": "integer",
                    "title": "Port",
                    "description": "The port of the SMTP service."
                  },
                  "securityMode": {
                    "type": "string",
                    "title": "Security Mode",
                    "description": "Protocol securing communication with SMTP service. Values: securityModeUnspecified, none, ssl, starttls."
                  }
                },
                "description": "SMTP relay configuration for outbound mail routing."
              },
              "isDefault": {
                "type": "boolean",
                "title": "Is Default",
                "description": "Indicates if this is the default From address for composing messages or vacation replies."
              },
              "isPrimary": {
                "type": "boolean",
                "title": "Is Primary",
                "description": "Read-only indicator of whether this is the account's primary login address. Every Gmail account has exactly one primary address."
              },
              "signature": {
                "type": "string",
                "title": "Signature",
                "description": "Optional HTML signature appended to new emails composed with this alias in Gmail's web interface."
              },
              "displayName": {
                "type": "string",
                "title": "Display Name",
                "description": "Custom name appearing in the From header. Gmail populates this with the primary account name if left empty for custom addresses."
              },
              "sendAsEmail": {
                "type": "string",
                "title": "Send As Email",
                "description": "The email address that appears in the 'From:' header for mail sent using this alias."
              },
              "treatAsAlias": {
                "type": "boolean",
                "title": "Treat As Alias",
                "description": "Whether Gmail treats this address as an alias for the primary email. Applies only to custom from aliases."
              },
              "replyToAddress": {
                "type": "string",
                "title": "Reply To Address",
                "description": "Optional email included in Reply-To headers. Omitted if empty."
              },
              "verificationStatus": {
                "type": "string",
                "title": "Verification Status",
                "description": "Status indicating whether the address is verified. Values: verificationStatusUnspecified, accepted, pending."
              }
            },
            "description": "A send-as alias configuration."
          },
          "title": "Send As",
          "description": "List of send-as aliases including the primary address and any custom 'from' aliases."
        },
        "display_url": {
          "type": "string",
          "title": "Display Url",
          "description": "Web UI link to the Gmail Accounts settings page where send-as aliases are managed."
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

## GMAIL_LIST_SMIME_INFO
Lists S/MIME configs for the specified send-as alias. Use when you need to retrieve all S/MIME certificate configurations associated with a specific send-as email address.

**Input schema:**
```json
{
  "type": "object",
  "title": "ListSmimeInfoRequest",
  "required": [
    "send_as_email"
  ],
  "properties": {
    "user_id": {
      "type": "string",
      "title": "User Id",
      "default": "me",
      "examples": [
        "me",
        "user@example.com"
      ],
      "description": "The user's email address. The special value 'me' can be used to indicate the authenticated user."
    },
    "send_as_email": {
      "type": "string",
      "title": "Send As Email",
      "examples": [
        "alias@example.com",
        "noreply@example.com"
      ],
      "description": "The email address that appears in the 'From:' header for mail sent using this alias."
    }
  }
}
```

**Output schema:**
```json
{
  "type": "object",
  "$defs": {
    "SmimeInfo": {
      "type": "object",
      "title": "SmimeInfo",
      "properties": {
        "id": {
          "type": "string",
          "title": "Id",
          "description": "The immutable ID for the SmimeInfo."
        },
        "pem": {
          "type": "string",
          "title": "Pem",
          "description": "PEM formatted X509 concatenated certificate string (standard base64 encoding)."
        },
        "issuerCn": {
          "type": "string",
          "title": "Issuer Cn",
          "description": "The S/MIME certificate issuer's common name."
        },
        "isDefault": {
          "type": "boolean",
          "title": "Is Default",
          "description": "Whether this SmimeInfo is the default one for this user's send-as address."
        },
        "expiration": {
          "type": "string",
          "title": "Expiration",
          "description": "When the certificate expires (in milliseconds since epoch)."
        },
        "encryptedKeyPassword": {
          "type": "string",
          "title": "Encrypted Key Password",
          "description": "Encrypted key password, when key is encrypted."
        }
      },
      "description": "S/MIME certificate configuration details."
    },
    "ListSmimeInfoResponse": {
      "type": "object",
      "title": "ListSmimeInfoResponse",
      "properties": {
        "smimeInfo": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "SmimeInfo",
            "properties": {
              "id": {
                "type": "string",
                "title": "Id",
                "description": "The immutable ID for the SmimeInfo."
              },
              "pem": {
                "type": "string",
                "title": "Pem",
                "description": "PEM formatted X509 concatenated certificate string (standard base64 encoding)."
              },
              "issuerCn": {
                "type": "string",
                "title": "Issuer Cn",
                "description": "The S/MIME certificate issuer's common name."
              },
              "isDefault": {
                "type": "boolean",
                "title": "Is Default",
                "description": "Whether this SmimeInfo is the default one for this user's send-as address."
              },
              "expiration": {
                "type": "string",
                "title": "Expiration",
                "description": "When the certificate expires (in milliseconds since epoch)."
              },
              "encryptedKeyPassword": {
                "type": "string",
                "title": "Encrypted Key Password",
                "description": "Encrypted key password, when key is encrypted."
              }
            },
            "description": "S/MIME certificate configuration details."
          },
          "title": "Smime Info",
          "description": "List of S/MIME certificate configurations for the specified send-as alias."
        },
        "display_url": {
          "type": "string",
          "title": "Display Url",
          "description": "Web UI link for this resource. None for S/MIME info as it has no direct Gmail web UI equivalent."
        },
        "smime_enabled": {
          "type": "boolean",
          "title": "Smime Enabled",
          "default": true,
          "description": "Indicates whether S/MIME feature is enabled for this account. If False, S/MIME requires Google Workspace Enterprise Plus, Education Standard/Plus, or Frontline Plus edition with S/MIME enabled by the administrator."
        }
      },
      "description": "Response containing list of S/MIME configurations."
    }
  },
  "title": "ListSmimeInfoResponseWrapper",
  "required": [
    "data",
    "successful"
  ],
  "properties": {
    "data": {
      "type": "object",
      "title": "Data",
      "properties": {
        "smimeInfo": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "SmimeInfo",
            "properties": {
              "id": {
                "type": "string",
                "title": "Id",
                "description": "The immutable ID for the SmimeInfo."
              },
              "pem": {
                "type": "string",
                "title": "Pem",
                "description": "PEM formatted X509 concatenated certificate string (standard base64 encoding)."
              },
              "issuerCn": {
                "type": "string",
                "title": "Issuer Cn",
                "description": "The S/MIME certificate issuer's common name."
              },
              "isDefault": {
                "type": "boolean",
                "title": "Is Default",
                "description": "Whether this SmimeInfo is the default one for this user's send-as address."
              },
              "expiration": {
                "type": "string",
                "title": "Expiration",
                "description": "When the certificate expires (in milliseconds since epoch)."
              },
              "encryptedKeyPassword": {
                "type": "string",
                "title": "Encrypted Key Password",
                "description": "Encrypted key password, when key is encrypted."
              }
            },
            "description": "S/MIME certificate configuration details."
          },
          "title": "Smime Info",
          "description": "List of S/MIME certificate configurations for the specified send-as alias."
        },
        "display_url": {
          "type": "string",
          "title": "Display Url",
          "description": "Web UI link for this resource. None for S/MIME info as it has no direct Gmail web UI equivalent."
        },
        "smime_enabled": {
          "type": "boolean",
          "title": "Smime Enabled",
          "default": true,
          "description": "Indicates whether S/MIME feature is enabled for this account. If False, S/MIME requires Google Workspace Enterprise Plus, Education Standard/Plus, or Frontline Plus edition with S/MIME enabled by the administrator."
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

## GMAIL_LIST_THREADS
Retrieves a list of email threads from a Gmail account, identified by `user_id` (email address or 'me'), supporting filtering and pagination. Spam and trash are excluded by default unless explicitly targeted via `label:spam` or `label:trash` in the query.

**Input schema:**
```json
{
  "type": "object",
  "title": "ListThreadsRequest",
  "properties": {
    "query": {
      "type": "string",
      "title": "Query",
      "default": "",
      "examples": [
        "is:unread",
        "from:john.doe@example.com",
        "subject:important"
      ],
      "description": "Filter for threads, using Gmail search query syntax (e.g., 'from:user@example.com is:unread'). Supported operators include `from:`, `to:`, `subject:`, `label:`, `is:unread`, `has:attachment`, `after:`, `before:`. Dates must use `YYYY/MM/DD` format; date operators are UTC-based. Exact subject phrases require quotes (e.g., `subject:'meeting notes'`).",
      "human_parameter_name": "Query",
      "human_parameter_description": "Use this field to search for specific threads based on criteria like sender or subject."
    },
    "user_id": {
      "type": "string",
      "title": "User Id",
      "default": "me",
      "examples": [
        "me",
        "user@example.com"
      ],
      "description": "The user's email address or 'me' to specify the authenticated Gmail account.",
      "human_parameter_name": "User ID",
      "human_parameter_description": "Provide the email address or 'me' to refer to your own Gmail account."
    },
    "verbose": {
      "type": "boolean",
      "title": "Verbose",
      "default": false,
      "examples": [
        true,
        false
      ],
      "description": "If false, returns threads with basic fields (id, snippet, historyId). If true, returns threads with complete message details including headers, body, attachments, and metadata for each message in the thread. Combining `verbose=true` with large `max_results` produces very large responses; keep `max_results` modest when verbose is enabled.",
      "human_parameter_name": "Verbose",
      "human_parameter_description": "Choose whether you want just the basic thread info or detailed message content."
    },
    "page_token": {
      "type": "string",
      "title": "Page Token",
      "default": "",
      "examples": [
        "abcPageToken123"
      ],
      "description": "Token from a previous response to retrieve a specific page of results; omit for the first page.",
      "human_parameter_name": "Page Token",
      "human_parameter_description": "If you're looking for more threads, use this token to get the next set of results."
    },
    "max_results": {
      "type": "integer",
      "title": "Max Results",
      "default": 10,
      "maximum": 500,
      "minimum": 1,
      "examples": [
        "10",
        "50",
        "100"
      ],
      "description": "Maximum number of threads to return. Hard cap is ~500 per call. For full mailbox coverage, loop using `nextPageToken` via `page_token` until absent.",
      "human_parameter_name": "Max Results",
      "human_parameter_description": "Specify how many threads you would like to see in the response, up to 500."
    }
  }
}
```

**Output schema:**
```json
{
  "type": "object",
  "$defs": {
    "Thread": {
      "type": "object",
      "title": "Thread",
      "required": [
        "id"
      ],
      "properties": {
        "id": {
          "type": "string",
          "title": "Id",
          "description": "Unique identifier of the thread."
        },
        "snippet": {
          "type": "string",
          "title": "Snippet",
          "description": "A short preview of the thread's message content."
        },
        "historyId": {
          "type": "string",
          "title": "History Id",
          "description": "ID of the last history record for the thread."
        }
      },
      "description": "Represents a Gmail thread with basic metadata."
    },
    "ListThreadsResponse": {
      "type": "object",
      "title": "ListThreadsResponse",
      "required": [
        "threads"
      ],
      "properties": {
        "threads": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "Thread",
            "required": [
              "id"
            ],
            "properties": {
              "id": {
                "type": "string",
                "title": "Id",
                "description": "Unique identifier of the thread."
              },
              "snippet": {
                "type": "string",
                "title": "Snippet",
                "description": "A short preview of the thread's message content."
              },
              "historyId": {
                "type": "string",
                "title": "History Id",
                "description": "ID of the last history record for the thread."
              }
            },
            "description": "Represents a Gmail thread with basic metadata."
          },
          "title": "Threads",
          "description": "List of email thread resources. Each thread contains an id, and may optionally include historyId and snippet depending on the request."
        },
        "nextPageToken": {
          "type": "string",
          "title": "Next Page Token",
          "description": "Token for the next page of results; if present, use as page_token in a subsequent request to fetch more threads."
        },
        "resultSizeEstimate": {
          "type": "integer",
          "title": "Result Size Estimate",
          "default": 0,
          "description": "Estimated total threads matching the query (not just this page)."
        }
      }
    }
  },
  "title": "ListThreadsResponseWrapper",
  "required": [
    "data",
    "successful"
  ],
  "properties": {
    "data": {
      "type": "object",
      "title": "Data",
      "required": [
        "threads"
      ],
      "properties": {
        "threads": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "Thread",
            "required": [
              "id"
            ],
            "properties": {
              "id": {
                "type": "string",
                "title": "Id",
                "description": "Unique identifier of the thread."
              },
              "snippet": {
                "type": "string",
                "title": "Snippet",
                "description": "A short preview of the thread's message content."
              },
              "historyId": {
                "type": "string",
                "title": "History Id",
                "description": "ID of the last history record for the thread."
              }
            },
            "description": "Represents a Gmail thread with basic metadata."
          },
          "title": "Threads",
          "description": "List of email thread resources. Each thread contains an id, and may optionally include historyId and snippet depending on the request."
        },
        "nextPageToken": {
          "type": "string",
          "title": "Next Page Token",
          "description": "Token for the next page of results; if present, use as page_token in a subsequent request to fetch more threads."
        },
        "resultSizeEstimate": {
          "type": "integer",
          "title": "Result Size Estimate",
          "default": 0,
          "description": "Estimated total threads matching the query (not just this page)."
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

## GMAIL_MODIFY_THREAD_LABELS
Adds or removes specified existing label IDs from a Gmail thread, affecting all its messages; ensure the thread ID is valid. To modify a single message only, use a message-level tool instead.

**Input schema:**
```json
{
  "type": "object",
  "title": "ModifyThreadLabelsRequest",
  "required": [
    "thread_id"
  ],
  "properties": {
    "user_id": {
      "type": "string",
      "title": "User Id",
      "default": "me",
      "examples": [
        "user@example.com",
        "me"
      ],
      "description": "User's email address or 'me' for the authenticated user.",
      "human_parameter_name": "User ID",
      "human_parameter_description": "The email address or identifier of the user whose mailbox you want to access. Use 'me' to access your own mailbox."
    },
    "thread_id": {
      "type": "string",
      "title": "Thread Id",
      "examples": [
        "18ea7715b619f09c"
      ],
      "description": "Immutable ID of the thread to modify.",
      "human_parameter_name": "Thread ID",
      "human_parameter_description": "The unique identifier of the thread you want to modify. Make sure this ID is valid for the operation."
    },
    "add_label_ids": {
      "type": "array",
      "items": {
        "type": "string"
      },
      "title": "Add Label Ids",
      "examples": [
        "STARRED",
        "INBOX",
        "Label_1"
      ],
      "description": "List of label IDs to add to the thread. Must be valid label IDs that exist in the user's account. System labels use uppercase names (e.g., 'INBOX', 'STARRED', 'IMPORTANT', 'UNREAD', 'SPAM', 'TRASH', 'SENT', 'DRAFT', 'CATEGORY_PERSONAL', 'CATEGORY_SOCIAL', 'CATEGORY_PROMOTIONS', 'CATEGORY_UPDATES', 'CATEGORY_FORUMS'). Custom labels use the format 'Label_N' (e.g., 'Label_1', 'Label_42'). Use GMAIL_LIST_LABELS to discover available label IDs. Accepts either a list or a JSON-encoded string. Note: If a label appears in both add_label_ids and remove_label_ids, the add operation takes priority. Use GMAIL_CREATE_LABEL first if the label does not yet exist, then supply its returned ID here.",
      "human_parameter_name": "Label IDs to add",
      "human_parameter_description": "Provide the labels you want to apply to the thread. Use GMAIL_LIST_LABELS to find valid label IDs."
    },
    "remove_label_ids": {
      "type": "array",
      "items": {
        "type": "string"
      },
      "title": "Remove Label Ids",
      "examples": [
        "IMPORTANT",
        "CATEGORY_UPDATES",
        "Label_1"
      ],
      "description": "List of label IDs to remove from the thread. Must be valid label IDs that exist in the user's account. System labels use uppercase names (e.g., 'INBOX', 'STARRED', 'IMPORTANT', 'UNREAD', 'SPAM', 'TRASH', 'SENT', 'DRAFT', 'CATEGORY_PERSONAL', 'CATEGORY_SOCIAL', 'CATEGORY_PROMOTIONS', 'CATEGORY_UPDATES', 'CATEGORY_FORUMS'). Custom labels use the format 'Label_N' (e.g., 'Label_1', 'Label_42'). Use GMAIL_LIST_LABELS to discover available label IDs. Accepts either a list or a JSON-encoded string. Note: Labels that appear in both add_label_ids and remove_label_ids will be automatically removed from this list (add takes priority).",
      "human_parameter_name": "Label IDs to remove",
      "human_parameter_description": "Specify the labels you want to remove from the thread. Use GMAIL_LIST_LABELS to find valid label IDs."
    }
  }
}
```

**Output schema:**
```json
{
  "type": "object",
  "$defs": {
    "ThreadResource": {
      "type": "object",
      "title": "ThreadResource",
      "required": [
        "id",
        "messages"
      ],
      "properties": {
        "id": {
          "type": "string",
          "title": "Id",
          "description": "The unique identifier of the thread"
        },
        "messages": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "GmailMessageResponse",
            "properties": {
              "id": {
                "type": "string",
                "title": "Id",
                "description": "The immutable ID of the sent message."
              },
              "raw": {
                "type": "string",
                "title": "Raw",
                "description": "The entire email message in RFC 2822 format, base64url-encoded."
              },
              "payload": {
                "type": "object",
                "title": "Payload",
                "description": "The parsed email structure, including headers and body parts.",
                "additionalProperties": true
              },
              "snippet": {
                "type": "string",
                "title": "Snippet",
                "description": "A short extract of the message text."
              },
              "labelIds": {
                "type": "array",
                "items": {
                  "type": "string"
                },
                "title": "Label Ids",
                "description": "List of IDs of labels applied to this message."
              },
              "threadId": {
                "type": "string",
                "title": "Thread Id",
                "description": "The ID of the thread the message belongs to."
              },
              "historyId": {
                "type": "string",
                "title": "History Id",
                "description": "The ID of the last history record that modified this message."
              },
              "display_url": {
                "type": "string",
                "title": "Display Url",
                "description": "Web UI link for this resource - set by each action's execute()."
              },
              "internalDate": {
                "type": "string",
                "title": "Internal Date",
                "description": "The internal timestamp of the message in milliseconds since epoch."
              },
              "sizeEstimate": {
                "type": "integer",
                "title": "Size Estimate",
                "description": "Estimated size of the message in bytes."
              }
            },
            "description": "Standard Gmail message response returned by Gmail API for sent messages.\nUsed by actions like send_email and send_draft."
          },
          "title": "Messages",
          "description": "Array of messages in the thread with updated label information"
        },
        "historyId": {
          "type": "string",
          "title": "History Id",
          "description": "The history identifier for the thread update, if provided"
        }
      },
      "description": "Details of the thread after label modification."
    },
    "GmailMessageResponse": {
      "type": "object",
      "title": "GmailMessageResponse",
      "properties": {
        "id": {
          "type": "string",
          "title": "Id",
          "description": "The immutable ID of the sent message."
        },
        "raw": {
          "type": "string",
          "title": "Raw",
          "description": "The entire email message in RFC 2822 format, base64url-encoded."
        },
        "payload": {
          "type": "object",
          "title": "Payload",
          "description": "The parsed email structure, including headers and body parts.",
          "additionalProperties": true
        },
        "snippet": {
          "type": "string",
          "title": "Snippet",
          "description": "A short extract of the message text."
        },
        "labelIds": {
          "type": "array",
          "items": {
            "type": "string"
          },
          "title": "Label Ids",
          "description": "List of IDs of labels applied to this message."
        },
        "threadId": {
          "type": "string",
          "title": "Thread Id",
          "description": "The ID of the thread the message belongs to."
        },
        "historyId": {
          "type": "string",
          "title": "History Id",
          "description": "The ID of the last history record that modified this message."
        },
        "display_url": {
          "type": "string",
          "title": "Display Url",
          "description": "Web UI link for this resource - set by each action's execute()."
        },
        "internalDate": {
          "type": "string",
          "title": "Internal Date",
          "description": "The internal timestamp of the message in milliseconds since epoch."
        },
        "sizeEstimate": {
          "type": "integer",
          "title": "Size Estimate",
          "description": "Estimated size of the message in bytes."
        }
      },
      "description": "Standard Gmail message response returned by Gmail API for sent messages.\nUsed by actions like send_email and send_draft."
    },
    "ModifyThreadLabelsResponse": {
      "type": "object",
      "title": "ModifyThreadLabelsResponse",
      "required": [
        "success"
      ],
      "properties": {
        "error": {
          "type": "string",
          "title": "Error",
          "description": "Error message if the operation failed"
        },
        "success": {
          "type": "boolean",
          "title": "Success",
          "description": "Indicates whether the labels were successfully modified on the thread."
        },
        "response": {
          "type": "object",
          "title": "Response",
          "required": [
            "id",
            "messages"
          ],
          "properties": {
            "id": {
              "type": "string",
              "title": "Id",
              "description": "The unique identifier of the thread"
            },
            "messages": {
              "type": "array",
              "items": {
                "type": "object",
                "title": "GmailMessageResponse",
                "properties": {
                  "id": {
                    "type": "string",
                    "title": "Id",
                    "description": "The immutable ID of the sent message."
                  },
                  "raw": {
                    "type": "string",
                    "title": "Raw",
                    "description": "The entire email message in RFC 2822 format, base64url-encoded."
                  },
                  "payload": {
                    "type": "object",
                    "title": "Payload",
                    "description": "The parsed email structure, including headers and body parts.",
                    "additionalProperties": true
                  },
                  "snippet": {
                    "type": "string",
                    "title": "Snippet",
                    "description": "A short extract of the message text."
                  },
                  "labelIds": {
                    "type": "array",
                    "items": {
                      "type": "string"
                    },
                    "title": "Label Ids",
                    "description": "List of IDs of labels applied to this message."
                  },
                  "threadId": {
                    "type": "string",
                    "title": "Thread Id",
                    "description": "The ID of the thread the message belongs to."
                  },
                  "historyId": {
                    "type": "string",
                    "title": "History Id",
                    "description": "The ID of the last history record that modified this message."
                  },
                  "display_url": {
                    "type": "string",
                    "title": "Display Url",
                    "description": "Web UI link for this resource - set by each action's execute()."
                  },
                  "internalDate": {
                    "type": "string",
                    "title": "Internal Date",
                    "description": "The internal timestamp of the message in milliseconds since epoch."
                  },
                  "sizeEstimate": {
                    "type": "integer",
                    "title": "Size Estimate",
                    "description": "Estimated size of the message in bytes."
                  }
                },
                "description": "Standard Gmail message response returned by Gmail API for sent messages.\nUsed by actions like send_email and send_draft."
              },
              "title": "Messages",
              "description": "Array of messages in the thread with updated label information"
            },
            "historyId": {
              "type": "string",
              "title": "History Id",
              "description": "The history identifier for the thread update, if provided"
            }
          },
          "description": "Details of the thread after label modification"
        },
        "display_url": {
          "type": "string",
          "title": "Display Url",
          "description": "Web UI link for this thread - clickable URL pointing to the Gmail web interface"
        },
        "composio_execution_message": {
          "type": "string",
          "title": "Composio Execution Message",
          "description": "Additional context about the execution result or any automatic adjustments made during execution."
        }
      }
    }
  },
  "title": "ModifyThreadLabelsResponseWrapper",
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
        "error": {
          "type": "string",
          "title": "Error",
          "description": "Error message if the operation failed"
        },
        "success": {
          "type": "boolean",
          "title": "Success",
          "description": "Indicates whether the labels were successfully modified on the thread."
        },
        "response": {
          "type": "object",
          "title": "Response",
          "required": [
            "id",
            "messages"
          ],
          "properties": {
            "id": {
              "type": "string",
              "title": "Id",
              "description": "The unique identifier of the thread"
            },
            "messages": {
              "type": "array",
              "items": {
                "type": "object",
                "title": "GmailMessageResponse",
                "properties": {
                  "id": {
                    "type": "string",
                    "title": "Id",
                    "description": "The immutable ID of the sent message."
                  },
                  "raw": {
                    "type": "string",
                    "title": "Raw",
                    "description": "The entire email message in RFC 2822 format, base64url-encoded."
                  },
                  "payload": {
                    "type": "object",
                    "title": "Payload",
                    "description": "The parsed email structure, including headers and body parts.",
                    "additionalProperties": true
                  },
                  "snippet": {
                    "type": "string",
                    "title": "Snippet",
                    "description": "A short extract of the message text."
                  },
                  "labelIds": {
                    "type": "array",
                    "items": {
                      "type": "string"
                    },
                    "title": "Label Ids",
                    "description": "List of IDs of labels applied to this message."
                  },
                  "threadId": {
                    "type": "string",
                    "title": "Thread Id",
                    "description": "The ID of the thread the message belongs to."
                  },
                  "historyId": {
                    "type": "string",
                    "title": "History Id",
                    "description": "The ID of the last history record that modified this message."
                  },
                  "display_url": {
                    "type": "string",
                    "title": "Display Url",
                    "description": "Web UI link for this resource - set by each action's execute()."
                  },
                  "internalDate": {
                    "type": "string",
                    "title": "Internal Date",
                    "description": "The internal timestamp of the message in milliseconds since epoch."
                  },
                  "sizeEstimate": {
                    "type": "integer",
                    "title": "Size Estimate",
                    "description": "Estimated size of the message in bytes."
                  }
                },
                "description": "Standard Gmail message response returned by Gmail API for sent messages.\nUsed by actions like send_email and send_draft."
              },
              "title": "Messages",
              "description": "Array of messages in the thread with updated label information"
            },
            "historyId": {
              "type": "string",
              "title": "History Id",
              "description": "The history identifier for the thread update, if provided"
            }
          },
          "description": "Details of the thread after label modification"
        },
        "display_url": {
          "type": "string",
          "title": "Display Url",
          "description": "Web UI link for this thread - clickable URL pointing to the Gmail web interface"
        },
        "composio_execution_message": {
          "type": "string",
          "title": "Composio Execution Message",
          "description": "Additional context about the execution result or any automatic adjustments made during execution."
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

## GMAIL_MOVE_THREAD_TO_TRASH
Moves the specified thread to the trash. Any messages that belong to the thread are also moved to the trash.

**Input schema:**
```json
{
  "type": "object",
  "title": "MoveThreadToTrashRequest",
  "required": [
    "thread_id"
  ],
  "properties": {
    "user_id": {
      "type": "string",
      "title": "User Id",
      "default": "me",
      "examples": [
        "me",
        "user@example.com"
      ],
      "description": "The user's email address. The special value 'me' can be used to indicate the authenticated user."
    },
    "thread_id": {
      "type": "string",
      "title": "Thread Id",
      "examples": [
        "19c8e0f136c69508"
      ],
      "description": "Required. The ID of the thread to trash. This moves all messages in the thread to trash."
    }
  }
}
```

**Output schema:**
```json
{
  "type": "object",
  "$defs": {
    "MessageInThread": {
      "type": "object",
      "title": "MessageInThread",
      "properties": {
        "id": {
          "type": "string",
          "title": "Id",
          "description": "The immutable ID of the message."
        },
        "raw": {
          "type": "string",
          "title": "Raw",
          "description": "The entire email message in an RFC 2822 formatted and base64url encoded string."
        },
        "payload": {
          "type": "object",
          "title": "Payload",
          "description": "The parsed email structure of the message body.",
          "additionalProperties": true
        },
        "snippet": {
          "type": "string",
          "title": "Snippet",
          "description": "A short part of the message text."
        },
        "labelIds": {
          "type": "array",
          "items": {
            "type": "string"
          },
          "title": "Label Ids",
          "description": "List of IDs of labels applied to this message."
        },
        "threadId": {
          "type": "string",
          "title": "Thread Id",
          "description": "The ID of the thread the message belongs to."
        },
        "historyId": {
          "type": "string",
          "title": "History Id",
          "description": "The ID of the last history record that modified this message."
        },
        "internalDate": {
          "type": "string",
          "title": "Internal Date",
          "description": "The internal message creation timestamp (epoch ms)."
        },
        "sizeEstimate": {
          "type": "integer",
          "title": "Size Estimate",
          "description": "Estimated size in bytes of the message."
        }
      },
      "description": "Represents a message within a thread."
    },
    "MoveThreadToTrashResponse": {
      "type": "object",
      "title": "MoveThreadToTrashResponse",
      "properties": {
        "id": {
          "type": "string",
          "title": "Id",
          "description": "The unique ID of the thread."
        },
        "snippet": {
          "type": "string",
          "title": "Snippet",
          "description": "A short part of the message text."
        },
        "messages": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "MessageInThread",
            "properties": {
              "id": {
                "type": "string",
                "title": "Id",
                "description": "The immutable ID of the message."
              },
              "raw": {
                "type": "string",
                "title": "Raw",
                "description": "The entire email message in an RFC 2822 formatted and base64url encoded string."
              },
              "payload": {
                "type": "object",
                "title": "Payload",
                "description": "The parsed email structure of the message body.",
                "additionalProperties": true
              },
              "snippet": {
                "type": "string",
                "title": "Snippet",
                "description": "A short part of the message text."
              },
              "labelIds": {
                "type": "array",
                "items": {
                  "type": "string"
                },
                "title": "Label Ids",
                "description": "List of IDs of labels applied to this message."
              },
              "threadId": {
                "type": "string",
                "title": "Thread Id",
                "description": "The ID of the thread the message belongs to."
              },
              "historyId": {
                "type": "string",
                "title": "History Id",
                "description": "The ID of the last history record that modified this message."
              },
              "internalDate": {
                "type": "string",
                "title": "Internal Date",
                "description": "The internal message creation timestamp (epoch ms)."
              },
              "sizeEstimate": {
                "type": "integer",
                "title": "Size Estimate",
                "description": "Estimated size in bytes of the message."
              }
            },
            "description": "Represents a message within a thread."
          },
          "title": "Messages",
          "description": "The list of messages in the thread."
        },
        "historyId": {
          "type": "string",
          "title": "History Id",
          "description": "The ID of the last history record that modified this thread."
        },
        "display_url": {
          "type": "string",
          "title": "Display Url",
          "description": "Web UI link for this resource - set by each action's execute()."
        }
      },
      "description": "Response from trashing a thread."
    }
  },
  "title": "MoveThreadToTrashResponseWrapper",
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
          "description": "The unique ID of the thread."
        },
        "snippet": {
          "type": "string",
          "title": "Snippet",
          "description": "A short part of the message text."
        },
        "messages": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "MessageInThread",
            "properties": {
              "id": {
                "type": "string",
                "title": "Id",
                "description": "The immutable ID of the message."
              },
              "raw": {
                "type": "string",
                "title": "Raw",
                "description": "The entire email message in an RFC 2822 formatted and base64url encoded string."
              },
              "payload": {
                "type": "object",
                "title": "Payload",
                "description": "The parsed email structure of the message body.",
                "additionalProperties": true
              },
              "snippet": {
                "type": "string",
                "title": "Snippet",
                "description": "A short part of the message text."
              },
              "labelIds": {
                "type": "array",
                "items": {
                  "type": "string"
                },
                "title": "Label Ids",
                "description": "List of IDs of labels applied to this message."
              },
              "threadId": {
                "type": "string",
                "title": "Thread Id",
                "description": "The ID of the thread the message belongs to."
              },
              "historyId": {
                "type": "string",
                "title": "History Id",
                "description": "The ID of the last history record that modified this message."
              },
              "internalDate": {
                "type": "string",
                "title": "Internal Date",
                "description": "The internal message creation timestamp (epoch ms)."
              },
              "sizeEstimate": {
                "type": "integer",
                "title": "Size Estimate",
                "description": "Estimated size in bytes of the message."
              }
            },
            "description": "Represents a message within a thread."
          },
          "title": "Messages",
          "description": "The list of messages in the thread."
        },
        "historyId": {
          "type": "string",
          "title": "History Id",
          "description": "The ID of the last history record that modified this thread."
        },
        "display_url": {
          "type": "string",
          "title": "Display Url",
          "description": "Web UI link for this resource - set by each action's execute()."
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

## GMAIL_MOVE_TO_TRASH
Moves an existing, non-deleted email message to the trash for the specified user. Trashed messages are recoverable and still count toward storage quota until purged. Prefer this over GMAIL_BATCH_DELETE_MESSAGES when recovery may be needed. For bulk operations, use GMAIL_BATCH_MODIFY_MESSAGES or GMAIL_BATCH_DELETE_MESSAGES instead of repeated calls to this tool.

**Input schema:**
```json
{
  "type": "object",
  "title": "MoveToTrashRequest",
  "required": [
    "message_id"
  ],
  "properties": {
    "user_id": {
      "type": "string",
      "title": "User Id",
      "default": "me",
      "examples": [
        "user@example.com",
        "me"
      ],
      "description": "User's email address or 'me' for the authenticated user.",
      "human_parameter_name": "User ID",
      "human_parameter_description": "Provide the email address or 'me' to specify whose mailbox to access."
    },
    "message_id": {
      "type": "string",
      "title": "Message Id",
      "pattern": "^[0-9a-fA-F]+$",
      "examples": [
        "1875f42779f726f2"
      ],
      "description": "Required. The unique identifier of the email message to move to trash. This is a hexadecimal string that can be obtained from listing or fetching emails. Verify the correct message via subject/snippet before trashing to avoid affecting unrelated conversations.",
      "human_parameter_name": "Message ID",
      "human_parameter_description": "This is the unique ID of the email you want to remove. This parameter is required and must be provided. Make sure it's correct to avoid errors."
    }
  }
}
```

**Output schema:**
```json
{
  "type": "object",
  "$defs": {
    "GmailMessageResponse": {
      "type": "object",
      "title": "GmailMessageResponse",
      "properties": {
        "id": {
          "type": "string",
          "title": "Id",
          "description": "The immutable ID of the sent message."
        },
        "raw": {
          "type": "string",
          "title": "Raw",
          "description": "The entire email message in RFC 2822 format, base64url-encoded."
        },
        "payload": {
          "type": "object",
          "title": "Payload",
          "description": "The parsed email structure, including headers and body parts.",
          "additionalProperties": true
        },
        "snippet": {
          "type": "string",
          "title": "Snippet",
          "description": "A short extract of the message text."
        },
        "labelIds": {
          "type": "array",
          "items": {
            "type": "string"
          },
          "title": "Label Ids",
          "description": "List of IDs of labels applied to this message."
        },
        "threadId": {
          "type": "string",
          "title": "Thread Id",
          "description": "The ID of the thread the message belongs to."
        },
        "historyId": {
          "type": "string",
          "title": "History Id",
          "description": "The ID of the last history record that modified this message."
        },
        "display_url": {
          "type": "string",
          "title": "Display Url",
          "description": "Web UI link for this resource - set by each action's execute()."
        },
        "internalDate": {
          "type": "string",
          "title": "Internal Date",
          "description": "The internal timestamp of the message in milliseconds since epoch."
        },
        "sizeEstimate": {
          "type": "integer",
          "title": "Size Estimate",
          "description": "Estimated size of the message in bytes."
        }
      },
      "description": "Standard Gmail message response returned by Gmail API for sent messages.\nUsed by actions like send_email and send_draft."
    }
  },
  "title": "GmailMessageResponseWrapper",
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
          "description": "The immutable ID of the sent message."
        },
        "raw": {
          "type": "string",
          "title": "Raw",
          "description": "The entire email message in RFC 2822 format, base64url-encoded."
        },
        "payload": {
          "type": "object",
          "title": "Payload",
          "description": "The parsed email structure, including headers and body parts.",
          "additionalProperties": true
        },
        "snippet": {
          "type": "string",
          "title": "Snippet",
          "description": "A short extract of the message text."
        },
        "labelIds": {
          "type": "array",
          "items": {
            "type": "string"
          },
          "title": "Label Ids",
          "description": "List of IDs of labels applied to this message."
        },
        "threadId": {
          "type": "string",
          "title": "Thread Id",
          "description": "The ID of the thread the message belongs to."
        },
        "historyId": {
          "type": "string",
          "title": "History Id",
          "description": "The ID of the last history record that modified this message."
        },
        "display_url": {
          "type": "string",
          "title": "Display Url",
          "description": "Web UI link for this resource - set by each action's execute()."
        },
        "internalDate": {
          "type": "string",
          "title": "Internal Date",
          "description": "The internal timestamp of the message in milliseconds since epoch."
        },
        "sizeEstimate": {
          "type": "integer",
          "title": "Size Estimate",
          "description": "Estimated size of the message in bytes."
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

## GMAIL_PATCH_LABEL
Patches the specified user-created label. System labels (e.g., INBOX, SENT, SPAM) cannot be modified and will be rejected.

**Input schema:**
```json
{
  "type": "object",
  "title": "PatchLabelRequest",
  "required": [
    "userId",
    "id"
  ],
  "properties": {
    "id": {
      "type": "string",
      "title": "Id",
      "examples": [
        "LABEL_123"
      ],
      "description": "The ID of the label to update.",
      "human_parameter_name": "Label ID",
      "human_parameter_description": "Enter the unique identifier of the label you want to update. This ID is crucial for specifying which label to modify."
    },
    "name": {
      "type": "string",
      "title": "Name",
      "examples": [
        "My Updated Label"
      ],
      "description": "The display name of the label. At least one of 'name', 'messageListVisibility', 'labelListVisibility', or 'color' must be provided. Must be non-empty, unique among user labels, and must not contain `,`, `/`, or `.`.",
      "human_parameter_name": "Label Display Name",
      "human_parameter_description": "Provide a new name for the label. This is how the label will appear in the user's email interface."
    },
    "color": {
      "type": "object",
      "title": "PatchLabelColor",
      "properties": {
        "textColor": {
          "type": "string",
          "title": "Text Color",
          "examples": [
            "#000000",
            "#434343",
            "#666666",
            "#ffffff"
          ],
          "description": "The text color of the label, represented as a hex string. Must be one of Gmail's predefined colors from the color palette. See: https://developers.google.com/workspace/gmail/api/guides/labels#color_palette",
          "human_parameter_name": "Text Color",
          "human_parameter_description": "Choose a hex color code for the label text from Gmail's predefined palette."
        },
        "backgroundColor": {
          "type": "string",
          "title": "Background Color",
          "examples": [
            "#ffffff",
            "#f3f3f3",
            "#efefef",
            "#cccccc"
          ],
          "description": "The background color of the label, represented as a hex string. Must be one of Gmail's predefined colors from the color palette. See: https://developers.google.com/workspace/gmail/api/guides/labels#color_palette",
          "human_parameter_name": "Background Color",
          "human_parameter_description": "Choose a hex color code for the label background from Gmail's predefined palette."
        }
      },
      "description": "The color to assign to the label. Color is only available for labels that have their `type` set to `user`. At least one of 'name', 'messageListVisibility', 'labelListVisibility', or 'color' must be provided. Must include both `backgroundColor` and `textColor` subfields; both values must come from Gmail's predefined color palette \u2014 arbitrary hex values or omitting either field causes a 400 error.",
      "additionalProperties": false,
      "human_parameter_name": "Label Color",
      "human_parameter_description": "Set the text and background colors for this label. Only works for user-created labels, not system labels."
    },
    "userId": {
      "type": "string",
      "title": "User Id",
      "examples": [
        "me",
        "user@example.com"
      ],
      "description": "The user's email address. The special value `me` can be used to indicate the authenticated user.",
      "human_parameter_name": "User Email Address",
      "human_parameter_description": "Provide the email address of the user whose label you want to modify. You can use 'me' to refer to yourself."
    },
    "labelListVisibility": {
      "enum": [
        "labelShow",
        "labelShowIfUnread",
        "labelHide"
      ],
      "type": "string",
      "title": "Label List Visibility",
      "examples": [
        "labelShow",
        "labelShowIfUnread",
        "labelHide"
      ],
      "description": "The visibility of the label in the label list in the Gmail web interface. At least one of 'name', 'messageListVisibility', 'labelListVisibility', or 'color' must be provided.",
      "human_parameter_name": "Label List Visibility",
      "human_parameter_description": "Select how this label should appear in the label list. Options include showing always, showing only if unread, or hiding."
    },
    "messageListVisibility": {
      "enum": [
        "show",
        "hide"
      ],
      "type": "string",
      "title": "Message List Visibility",
      "examples": [
        "show",
        "hide"
      ],
      "description": "The visibility of messages with this label in the message list in the Gmail web interface. At least one of 'name', 'messageListVisibility', 'labelListVisibility', or 'color' must be provided.",
      "human_parameter_name": "Message List Visibility",
      "human_parameter_description": "Choose whether messages under this label should be visible or hidden in the message list."
    }
  }
}
```

**Output schema:**
```json
{
  "type": "object",
  "$defs": {
    "LabelResponse": {
      "type": "object",
      "title": "GmailPatchLabelResponse",
      "required": [
        "id",
        "name",
        "messageListVisibility",
        "labelListVisibility",
        "type",
        "messagesTotal",
        "messagesUnread",
        "threadsTotal",
        "threadsUnread"
      ],
      "properties": {
        "id": {
          "type": "string",
          "title": "Id",
          "description": "The immutable ID of the label."
        },
        "name": {
          "type": "string",
          "title": "Name",
          "description": "The display name of the label."
        },
        "type": {
          "type": "string",
          "title": "Type",
          "description": "The owner type of the label. Allowed values: 'system', 'user'."
        },
        "color": {
          "type": "object",
          "title": "Color",
          "properties": {
            "textColor": {
              "type": "string",
              "title": "Text Color",
              "examples": [
                "#000000",
                "#434343",
                "#666666",
                "#ffffff"
              ],
              "description": "The text color of the label, represented as a hex string. Must be one of Gmail's predefined colors from the color palette. See: https://developers.google.com/workspace/gmail/api/guides/labels#color_palette",
              "human_parameter_name": "Text Color",
              "human_parameter_description": "Choose a hex color code for the label text from Gmail's predefined palette."
            },
            "backgroundColor": {
              "type": "string",
              "title": "Background Color",
              "examples": [
                "#ffffff",
                "#f3f3f3",
                "#efefef",
                "#cccccc"
              ],
              "description": "The background color of the label, represented as a hex string. Must be one of Gmail's predefined colors from the color palette. See: https://developers.google.com/workspace/gmail/api/guides/labels#color_palette",
              "human_parameter_name": "Background Color",
              "human_parameter_description": "Choose a hex color code for the label background from Gmail's predefined palette."
            }
          },
          "description": "The color representation for the label."
        },
        "display_url": {
          "type": "string",
          "title": "Display Url",
          "description": "Web UI link for this resource - clickable URL pointing to the Gmail web interface."
        },
        "threadsTotal": {
          "type": "integer",
          "title": "Threads Total",
          "description": "The total number of threads with this label."
        },
        "messagesTotal": {
          "type": "integer",
          "title": "Messages Total",
          "description": "The total number of messages with this label."
        },
        "threadsUnread": {
          "type": "integer",
          "title": "Threads Unread",
          "description": "The number of unread threads with this label."
        },
        "messagesUnread": {
          "type": "integer",
          "title": "Messages Unread",
          "description": "The number of unread messages with this label."
        },
        "labelListVisibility": {
          "type": "string",
          "title": "Label List Visibility",
          "description": "Visibility of the label in the Gmail web interface label list."
        },
        "messageListVisibility": {
          "type": "string",
          "title": "Message List Visibility",
          "description": "Visibility of messages under this label in the Gmail web interface message list."
        }
      },
      "description": "Response model for patching a Gmail label."
    },
    "PatchLabelColor": {
      "type": "object",
      "title": "PatchLabelColor",
      "properties": {
        "textColor": {
          "type": "string",
          "title": "Text Color",
          "examples": [
            "#000000",
            "#434343",
            "#666666",
            "#ffffff"
          ],
          "description": "The text color of the label, represented as a hex string. Must be one of Gmail's predefined colors from the color palette. See: https://developers.google.com/workspace/gmail/api/guides/labels#color_palette",
          "human_parameter_name": "Text Color",
          "human_parameter_description": "Choose a hex color code for the label text from Gmail's predefined palette."
        },
        "backgroundColor": {
          "type": "string",
          "title": "Background Color",
          "examples": [
            "#ffffff",
            "#f3f3f3",
            "#efefef",
            "#cccccc"
          ],
          "description": "The background color of the label, represented as a hex string. Must be one of Gmail's predefined colors from the color palette. See: https://developers.google.com/workspace/gmail/api/guides/labels#color_palette",
          "human_parameter_name": "Background Color",
          "human_parameter_description": "Choose a hex color code for the label background from Gmail's predefined palette."
        }
      }
    }
  },
  "title": "LabelResponseWrapper",
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
        "messageListVisibility",
        "labelListVisibility",
        "type",
        "messagesTotal",
        "messagesUnread",
        "threadsTotal",
        "threadsUnread"
      ],
      "properties": {
        "id": {
          "type": "string",
          "title": "Id",
          "description": "The immutable ID of the label."
        },
        "name": {
          "type": "string",
          "title": "Name",
          "description": "The display name of the label."
        },
        "type": {
          "type": "string",
          "title": "Type",
          "description": "The owner type of the label. Allowed values: 'system', 'user'."
        },
        "color": {
          "type": "object",
          "title": "Color",
          "properties": {
            "textColor": {
              "type": "string",
              "title": "Text Color",
              "examples": [
                "#000000",
                "#434343",
                "#666666",
                "#ffffff"
              ],
              "description": "The text color of the label, represented as a hex string. Must be one of Gmail's predefined colors from the color palette. See: https://developers.google.com/workspace/gmail/api/guides/labels#color_palette",
              "human_parameter_name": "Text Color",
              "human_parameter_description": "Choose a hex color code for the label text from Gmail's predefined palette."
            },
            "backgroundColor": {
              "type": "string",
              "title": "Background Color",
              "examples": [
                "#ffffff",
                "#f3f3f3",
                "#efefef",
                "#cccccc"
              ],
              "description": "The background color of the label, represented as a hex string. Must be one of Gmail's predefined colors from the color palette. See: https://developers.google.com/workspace/gmail/api/guides/labels#color_palette",
              "human_parameter_name": "Background Color",
              "human_parameter_description": "Choose a hex color code for the label background from Gmail's predefined palette."
            }
          },
          "description": "The color representation for the label."
        },
        "display_url": {
          "type": "string",
          "title": "Display Url",
          "description": "Web UI link for this resource - clickable URL pointing to the Gmail web interface."
        },
        "threadsTotal": {
          "type": "integer",
          "title": "Threads Total",
          "description": "The total number of threads with this label."
        },
        "messagesTotal": {
          "type": "integer",
          "title": "Messages Total",
          "description": "The total number of messages with this label."
        },
        "threadsUnread": {
          "type": "integer",
          "title": "Threads Unread",
          "description": "The number of unread threads with this label."
        },
        "messagesUnread": {
          "type": "integer",
          "title": "Messages Unread",
          "description": "The number of unread messages with this label."
        },
        "labelListVisibility": {
          "type": "string",
          "title": "Label List Visibility",
          "description": "Visibility of the label in the Gmail web interface label list."
        },
        "messageListVisibility": {
          "type": "string",
          "title": "Message List Visibility",
          "description": "Visibility of messages under this label in the Gmail web interface message list."
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

## GMAIL_PATCH_SEND_AS
Tool to patch the specified send-as alias for a Gmail user. Use when you need to update properties of an existing send-as email address such as display name, reply-to address, signature, default status, or SMTP configuration.

**Input schema:**
```json
{
  "type": "object",
  "title": "PatchSendAsRequest",
  "required": [
    "send_as_email"
  ],
  "properties": {
    "user_id": {
      "type": "string",
      "title": "User Id",
      "default": "me",
      "examples": [
        "me",
        "user@example.com"
      ],
      "description": "The user's email address or the special value 'me' to indicate the authenticated user."
    },
    "smtp_msa": {
      "type": "object",
      "title": "SmtpMsa",
      "required": [
        "host",
        "port",
        "securityMode"
      ],
      "properties": {
        "host": {
          "type": "string",
          "title": "Host",
          "examples": [
            "smtp.gmail.com",
            "smtp.example.com"
          ],
          "description": "The hostname of the SMTP service. Required when configuring SMTP."
        },
        "port": {
          "type": "integer",
          "title": "Port",
          "examples": [
            587,
            465,
            25
          ],
          "description": "The port of the SMTP service. Required when configuring SMTP."
        },
        "password": {
          "type": "string",
          "title": "Password",
          "description": "The password for SMTP authentication. This is write-only and never appears in responses."
        },
        "username": {
          "type": "string",
          "title": "Username",
          "examples": [
            "user@example.com"
          ],
          "description": "The username for SMTP authentication. This is write-only and never appears in responses."
        },
        "securityMode": {
          "enum": [
            "securityModeUnspecified",
            "none",
            "ssl",
            "starttls"
          ],
          "type": "string",
          "title": "Security Mode",
          "examples": [
            "starttls",
            "ssl"
          ],
          "description": "The protocol that will be used to secure communication with the SMTP service. Required when configuring SMTP."
        }
      },
      "description": "Configuration for SMTP relay service.",
      "additionalProperties": false
    },
    "signature": {
      "type": "string",
      "title": "Signature",
      "examples": [
        "<p>Best regards,<br>John Doe</p>"
      ],
      "description": "An optional HTML signature that is included in messages composed with this alias in the Gmail web UI. This signature is added to new emails only."
    },
    "is_default": {
      "type": "boolean",
      "title": "Is Default",
      "examples": [
        true
      ],
      "description": "Whether this address is selected as the default 'From:' address in situations such as composing a new message or sending a vacation auto-reply. Setting this to true will make other send-as addresses non-default. Only true can be written to this field."
    },
    "display_name": {
      "type": "string",
      "title": "Display Name",
      "examples": [
        "Composio Partnerships",
        "John Doe"
      ],
      "description": "A name that appears in the 'From:' header for mail sent using this alias. For custom 'from' addresses, when empty, Gmail will populate the 'From:' header with the name used for the primary address. If the admin has disabled name updates, requests to update this field for the primary login will silently fail."
    },
    "send_as_email": {
      "type": "string",
      "title": "Send As Email",
      "examples": [
        "alias@example.com",
        "partnerships@composio.dev"
      ],
      "description": "The send-as alias email address to update. This is the email address that appears in the 'From:' header."
    },
    "treat_as_alias": {
      "type": "boolean",
      "title": "Treat As Alias",
      "examples": [
        true,
        false
      ],
      "description": "Whether Gmail should treat this address as an alias for the user's primary email address. This setting only applies to custom 'from' aliases."
    },
    "reply_to_address": {
      "type": "string",
      "title": "Reply To Address",
      "examples": [
        "noreply@example.com",
        "support@example.com"
      ],
      "description": "An optional email address that is included in a 'Reply-To:' header for mail sent using this alias. If empty, Gmail will not generate a 'Reply-To:' header."
    }
  }
}
```

**Output schema:**
```json
{
  "type": "object",
  "$defs": {
    "SmtpMsaResponse": {
      "type": "object",
      "title": "SmtpMsaResponse",
      "required": [
        "host",
        "port"
      ],
      "properties": {
        "host": {
          "type": "string",
          "title": "Host",
          "description": "The hostname of the SMTP service."
        },
        "port": {
          "type": "integer",
          "title": "Port",
          "description": "The port of the SMTP service."
        },
        "securityMode": {
          "enum": [
            "securityModeUnspecified",
            "none",
            "ssl",
            "starttls"
          ],
          "type": "string",
          "title": "Security Mode",
          "description": "The protocol used to secure communication with the SMTP service."
        }
      },
      "description": "SMTP relay configuration in response."
    },
    "PatchSendAsResponse": {
      "type": "object",
      "title": "PatchSendAsResponse",
      "required": [
        "sendAsEmail"
      ],
      "properties": {
        "smtpMsa": {
          "type": "object",
          "title": "Smtp Msa",
          "required": [
            "host",
            "port"
          ],
          "properties": {
            "host": {
              "type": "string",
              "title": "Host",
              "description": "The hostname of the SMTP service."
            },
            "port": {
              "type": "integer",
              "title": "Port",
              "description": "The port of the SMTP service."
            },
            "securityMode": {
              "enum": [
                "securityModeUnspecified",
                "none",
                "ssl",
                "starttls"
              ],
              "type": "string",
              "title": "Security Mode",
              "description": "The protocol used to secure communication with the SMTP service."
            }
          },
          "description": "SMTP relay configuration."
        },
        "isDefault": {
          "type": "boolean",
          "title": "Is Default",
          "description": "Whether selected as default 'From:' address."
        },
        "isPrimary": {
          "type": "boolean",
          "title": "Is Primary",
          "description": "Whether this is the primary login address. Read-only."
        },
        "signature": {
          "type": "string",
          "title": "Signature",
          "description": "Optional HTML signature for composed messages."
        },
        "displayName": {
          "type": "string",
          "title": "Display Name",
          "description": "Name shown in 'From:' header."
        },
        "sendAsEmail": {
          "type": "string",
          "title": "Send As Email",
          "description": "The email address that appears in the 'From:' header for mail sent using this alias."
        },
        "treatAsAlias": {
          "type": "boolean",
          "title": "Treat As Alias",
          "description": "Whether Gmail treats this as an alias for the primary address."
        },
        "replyToAddress": {
          "type": "string",
          "title": "Reply To Address",
          "description": "Optional email for 'Reply-To:' header."
        },
        "verificationStatus": {
          "enum": [
            "verificationStatusUnspecified",
            "accepted",
            "pending"
          ],
          "type": "string",
          "title": "Verification Status",
          "description": "Address verification status. Read-only."
        }
      },
      "description": "Response containing the updated send-as alias configuration."
    }
  },
  "title": "PatchSendAsResponseWrapper",
  "required": [
    "data",
    "successful"
  ],
  "properties": {
    "data": {
      "type": "object",
      "title": "Data",
      "required": [
        "sendAsEmail"
      ],
      "properties": {
        "smtpMsa": {
          "type": "object",
          "title": "Smtp Msa",
          "required": [
            "host",
            "port"
          ],
          "properties": {
            "host": {
              "type": "string",
              "title": "Host",
              "description": "The hostname of the SMTP service."
            },
            "port": {
              "type": "integer",
              "title": "Port",
              "description": "The port of the SMTP service."
            },
            "securityMode": {
              "enum": [
                "securityModeUnspecified",
                "none",
                "ssl",
                "starttls"
              ],
              "type": "string",
              "title": "Security Mode",
              "description": "The protocol used to secure communication with the SMTP service."
            }
          },
          "description": "SMTP relay configuration."
        },
        "isDefault": {
          "type": "boolean",
          "title": "Is Default",
          "description": "Whether selected as default 'From:' address."
        },
        "isPrimary": {
          "type": "boolean",
          "title": "Is Primary",
          "description": "Whether this is the primary login address. Read-only."
        },
        "signature": {
          "type": "string",
          "title": "Signature",
          "description": "Optional HTML signature for composed messages."
        },
        "displayName": {
          "type": "string",
          "title": "Display Name",
          "description": "Name shown in 'From:' header."
        },
        "sendAsEmail": {
          "type": "string",
          "title": "Send As Email",
          "description": "The email address that appears in the 'From:' header for mail sent using this alias."
        },
        "treatAsAlias": {
          "type": "boolean",
          "title": "Treat As Alias",
          "description": "Whether Gmail treats this as an alias for the primary address."
        },
        "replyToAddress": {
          "type": "string",
          "title": "Reply To Address",
          "description": "Optional email for 'Reply-To:' header."
        },
        "verificationStatus": {
          "enum": [
            "verificationStatusUnspecified",
            "accepted",
            "pending"
          ],
          "type": "string",
          "title": "Verification Status",
          "description": "Address verification status. Read-only."
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

## GMAIL_REPLY_TO_THREAD
Sends a reply within a specific Gmail thread using the original thread's subject; do not provide a custom subject as it will start a new conversation instead of replying in-thread. Requires a valid `thread_id` and at least one of `recipient_email`, `cc`, or `bcc`. Supports attachments via the `attachment` parameter with `name`, `mimetype`, and `s3key` fields.

**Input schema:**
```json
{
  "type": "object",
  "title": "ReplyToThreadRequest",
  "required": [
    "thread_id"
  ],
  "properties": {
    "cc": {
      "type": "array",
      "items": {
        "type": "string"
      },
      "title": "Cc",
      "default": [],
      "examples": [
        [
          "cc.recipient1@example.com",
          "cc.recipient2@example.com"
        ]
      ],
      "description": "Carbon Copy (CC) recipients' email addresses in format 'user@domain.com'. Each address must include both username and domain separated by '@'. At least one of cc, bcc, or recipient_email must be provided.",
      "human_parameter_name": "CC Recipients",
      "human_parameter_description": "Email addresses for people you want to keep in the loop but not address directly. At least one recipient is necessary."
    },
    "bcc": {
      "type": "array",
      "items": {
        "type": "string"
      },
      "title": "Bcc",
      "default": [],
      "examples": [
        [
          "bcc.recipient@example.com"
        ]
      ],
      "description": "Blind Carbon Copy (BCC) recipients' email addresses in format 'user@domain.com'. Each address must include both username and domain separated by '@'. At least one of cc, bcc, or recipient_email must be provided.",
      "human_parameter_name": "BCC Recipients",
      "human_parameter_description": "Recipients who will receive your reply without others knowing their email addresses. At least one recipient is necessary."
    },
    "is_html": {
      "type": "boolean",
      "title": "Is Html",
      "default": false,
      "examples": [
        true,
        false
      ],
      "description": "Indicates if `message_body` is HTML; if True, body must be valid HTML, if False, body should not contain HTML tags. Mismatch causes recipients to see raw HTML tags as plain text.",
      "human_parameter_name": "Is HTML?",
      "human_parameter_description": "Specify whether your message body is in HTML format. Set to true if it contains HTML tags."
    },
    "user_id": {
      "type": "string",
      "title": "User Id",
      "default": "me",
      "examples": [
        "me",
        "user@example.com"
      ],
      "description": "Identifier for the user sending the reply; 'me' refers to the authenticated user.",
      "human_parameter_name": "User ID",
      "human_parameter_description": "The identifier for the user sending the reply. Use 'me' for your own account or provide your email address."
    },
    "thread_id": {
      "type": "string",
      "title": "Thread Id",
      "examples": [
        "169eefc8138e68ca",
        "msg-f:169eefc8138e68ca"
      ],
      "description": "Identifier of the Gmail thread for the reply. Must be a valid hexadecimal string, typically 15-16 characters long (e.g., '169eefc8138e68ca'). Prefixes like 'msg-f:' or 'thread-f:' are automatically stripped. Note: Format validation only checks the ID structure; the thread must also exist and be accessible in your Gmail account. Use GMAIL_LIST_THREADS or GMAIL_FETCH_EMAILS to retrieve valid thread IDs. Must be a threadId, not a messageId; passing a messageId can cause the reply to fail or start an unintended new thread."
    },
    "attachment": {
      "type": "object",
      "title": "FileUploadable",
      "required": [
        "name",
        "mimetype",
        "s3key"
      ],
      "properties": {
        "name": {
          "type": "string",
          "title": "Name",
          "examples": [
            "document.pdf",
            "image.jpg",
            "report.docx"
          ],
          "description": "The filename that will be used when uploading the file to the destination service"
        },
        "s3key": {
          "type": "string",
          "title": "S3Key",
          "examples": [
            "47563/gmail/GET_ATTACHMENT/response/12345"
          ],
          "description": "The S3 key of a publicly accessible file, typically returned from a previous download action that stored the file in S3. This key references an existing file that can be uploaded to another service."
        },
        "mimetype": {
          "type": "string",
          "title": "Mimetype",
          "examples": [
            "application/pdf",
            "image/jpeg",
            "application/vnd.openxmlformats-officedocument.wordprocessingml.document"
          ],
          "description": "The MIME type of the file"
        }
      },
      "description": "File to attach to the reply. Just Provide file path here Requires `name`, `mimetype`, and `s3key` fields; `s3key` must come from a prior upload/download response. Total message size including attachments must stay under 25 MB (400 badRequest if exceeded); use Drive links for large files.",
      "file_uploadable": true,
      "additionalProperties": false,
      "human_parameter_name": "Attachment",
      "human_parameter_description": "A file you want to attach to your reply. Simply provide the path to the file."
    },
    "message_body": {
      "type": "string",
      "title": "Message Body",
      "default": "",
      "examples": [
        "Dear Sir, Nice talking to you. Yours respectfully, John"
      ],
      "description": "Content of the reply message, either plain text or HTML.",
      "human_parameter_name": "Message Body",
      "human_parameter_description": "The actual message you want to send as a reply. It can be plain text or formatted in HTML."
    },
    "recipient_email": {
      "type": "string",
      "title": "Recipient Email",
      "examples": [
        "john@doe.com"
      ],
      "description": "Primary recipient's email address in format 'user@domain.com'. Must include both username and domain separated by '@'. Required if cc and bcc is not provided, else can be optional. Use extra_recipients if you want to send to multiple recipients.",
      "human_parameter_name": "Recipient Email",
      "human_parameter_description": "The email address of the main recipient for your reply. This is required unless you're using cc or bcc."
    },
    "extra_recipients": {
      "type": "array",
      "items": {
        "type": "string"
      },
      "title": "Extra Recipients",
      "default": [],
      "examples": [
        [
          "jane.doe@example.com",
          "another.person@example.com"
        ]
      ],
      "description": "Additional 'To' recipients' email addresses in format 'user@domain.com' (not Cc or Bcc). Each address must include both username and domain separated by '@'. Should only be used if recipient_email is also provided.",
      "human_parameter_name": "Additional Recipients",
      "human_parameter_description": "Any additional email addresses you want to include in the 'To' field for this reply."
    }
  }
}
```

**Output schema:**
```json
{
  "type": "object",
  "$defs": {
    "GmailMessageResponse": {
      "type": "object",
      "title": "GmailMessageResponse",
      "properties": {
        "id": {
          "type": "string",
          "title": "Id",
          "description": "The immutable ID of the sent message."
        },
        "raw": {
          "type": "string",
          "title": "Raw",
          "description": "The entire email message in RFC 2822 format, base64url-encoded."
        },
        "payload": {
          "type": "object",
          "title": "Payload",
          "description": "The parsed email structure, including headers and body parts.",
          "additionalProperties": true
        },
        "snippet": {
          "type": "string",
          "title": "Snippet",
          "description": "A short extract of the message text."
        },
        "labelIds": {
          "type": "array",
          "items": {
            "type": "string"
          },
          "title": "Label Ids",
          "description": "List of IDs of labels applied to this message."
        },
        "threadId": {
          "type": "string",
          "title": "Thread Id",
          "description": "The ID of the thread the message belongs to."
        },
        "historyId": {
          "type": "string",
          "title": "History Id",
          "description": "The ID of the last history record that modified this message."
        },
        "display_url": {
          "type": "string",
          "title": "Display Url",
          "description": "Web UI link for this resource - set by each action's execute()."
        },
        "internalDate": {
          "type": "string",
          "title": "Internal Date",
          "description": "The internal timestamp of the message in milliseconds since epoch."
        },
        "sizeEstimate": {
          "type": "integer",
          "title": "Size Estimate",
          "description": "Estimated size of the message in bytes."
        }
      },
      "description": "Standard Gmail message response returned by Gmail API for sent messages.\nUsed by actions like send_email and send_draft."
    }
  },
  "title": "GmailMessageResponseWrapper",
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
          "description": "The immutable ID of the sent message."
        },
        "raw": {
          "type": "string",
          "title": "Raw",
          "description": "The entire email message in RFC 2822 format, base64url-encoded."
        },
        "payload": {
          "type": "object",
          "title": "Payload",
          "description": "The parsed email structure, including headers and body parts.",
          "additionalProperties": true
        },
        "snippet": {
          "type": "string",
          "title": "Snippet",
          "description": "A short extract of the message text."
        },
        "labelIds": {
          "type": "array",
          "items": {
            "type": "string"
          },
          "title": "Label Ids",
          "description": "List of IDs of labels applied to this message."
        },
        "threadId": {
          "type": "string",
          "title": "Thread Id",
          "description": "The ID of the thread the message belongs to."
        },
        "historyId": {
          "type": "string",
          "title": "History Id",
          "description": "The ID of the last history record that modified this message."
        },
        "display_url": {
          "type": "string",
          "title": "Display Url",
          "description": "Web UI link for this resource - set by each action's execute()."
        },
        "internalDate": {
          "type": "string",
          "title": "Internal Date",
          "description": "The internal timestamp of the message in milliseconds since epoch."
        },
        "sizeEstimate": {
          "type": "integer",
          "title": "Size Estimate",
          "description": "Estimated size of the message in bytes."
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

## GMAIL_SEARCH_PEOPLE
Searches contacts by matching the query against names, nicknames, emails, phone numbers, and organizations, optionally including 'Other Contacts'. Only searches the authenticated user's contact directory — people existing solely in message headers won't appear; use GMAIL_FETCH_EMAILS for those. Results may be zero or multiple; never auto-select from ambiguous results. Results paginate via next_page_token; follow until empty and deduplicate by email. Many records lack emailAddresses or names even when requested — handle missing keys. Directory/organization policies may suppress entries.

**Input schema:**
```json
{
  "type": "object",
  "title": "SearchPeopleRequest",
  "required": [
    "query"
  ],
  "properties": {
    "query": {
      "type": "string",
      "title": "Query",
      "description": "Matches contact names, nicknames, email addresses, phone numbers, and organization fields.",
      "human_parameter_name": "Search Query",
      "human_parameter_description": "Provide the name, email, or phone number of the person you're looking for to help filter your search."
    },
    "pageSize": {
      "type": "integer",
      "title": "Page Size",
      "default": 10,
      "maximum": 30,
      "minimum": 0,
      "description": "Maximum results to return; values >30 are capped to 30 by the API.",
      "human_parameter_name": "Maximum Results",
      "human_parameter_description": "Specify how many results you want to see at once, up to 30 for efficiency."
    },
    "person_fields": {
      "type": "string",
      "title": "Person Fields",
      "default": "emailAddresses,metadata,names,phoneNumbers",
      "examples": [
        "addresses",
        "ageRanges",
        "biographies",
        "birthdays",
        "coverPhotos",
        "emailAddresses",
        "events",
        "genders",
        "imClients",
        "interests",
        "locales",
        "memberships",
        "metadata",
        "names",
        "nicknames",
        "occupations",
        "organizations",
        "phoneNumbers",
        "photos",
        "relations",
        "residences",
        "sipAddresses",
        "skills",
        "urls",
        "userDefined"
      ],
      "description": "Comma-separated fields to return (e.g., 'names,emailAddresses'). When 'other_contacts' is true, only 'emailAddresses', 'metadata', 'names', 'phoneNumbers' are allowed. For full field access including 'organizations', set 'other_contacts' to false.",
      "human_parameter_name": "Fields to Return",
      "human_parameter_description": "List the specific details you want returned about each person, like names and email addresses, to keep your results focused."
    },
    "other_contacts": {
      "type": "boolean",
      "title": "Other Contacts",
      "default": true,
      "description": "When True, searches both saved contacts and 'Other Contacts' (people you've interacted with but not explicitly saved). Note: This restricts person_fields to only 'emailAddresses', 'metadata', 'names', 'phoneNumbers'. When False, searches only saved contacts but allows all person_fields including 'organizations', 'addresses', etc.",
      "human_parameter_name": "Include Other Contacts?",
      "human_parameter_description": "Indicate whether to include people you've interacted with but haven't saved as contacts, allowing for a broader search."
    }
  }
}
```

**Output schema:**
```json
{
  "type": "object",
  "$defs": {
    "SearchPeopleResponse": {
      "type": "object",
      "title": "SearchPeopleResponse",
      "required": [
        "results"
      ],
      "properties": {
        "results": {
          "type": "array",
          "items": {
            "type": "object",
            "additionalProperties": true
          },
          "title": "Results",
          "description": "List of search results, each containing a person record"
        },
        "display_url": {
          "type": "string",
          "title": "Display Url",
          "description": "Web UI link for this resource - clickable URL pointing to the Google Contacts web interface"
        },
        "composio_execution_message": {
          "type": "string",
          "title": "Composio Execution Message",
          "description": "Informational message about any automatic adjustments made during execution"
        }
      }
    }
  },
  "title": "SearchPeopleResponseWrapper",
  "required": [
    "data",
    "successful"
  ],
  "properties": {
    "data": {
      "type": "object",
      "title": "Data",
      "required": [
        "results"
      ],
      "properties": {
        "results": {
          "type": "array",
          "items": {
            "type": "object",
            "additionalProperties": true
          },
          "title": "Results",
          "description": "List of search results, each containing a person record"
        },
        "display_url": {
          "type": "string",
          "title": "Display Url",
          "description": "Web UI link for this resource - clickable URL pointing to the Google Contacts web interface"
        },
        "composio_execution_message": {
          "type": "string",
          "title": "Composio Execution Message",
          "description": "Informational message about any automatic adjustments made during execution"
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

## GMAIL_SEND_DRAFT
Sends an existing draft email AS-IS to recipients already defined within the draft. IMPORTANT: This action does NOT accept recipient parameters (to, cc, bcc). The Gmail API's drafts/send endpoint sends drafts to whatever recipients are already set in the draft's To, Cc, and Bcc headers - it cannot add or override recipients. If the draft has no recipients, you must either: 1. Create a new draft with recipients using GMAIL_CREATE_EMAIL_DRAFT, then send it 2. Use GMAIL_SEND_EMAIL to send a new email directly with recipients. Send is immediate and irreversible — confirm recipients and content before calling. No scheduling support; trigger at the desired UTC time externally. Gmail enforces ~25 MB message size limit and daily send caps (~500 recipients/day personal, ~2,000/day Workspace).

**Input schema:**
```json
{
  "type": "object",
  "title": "SendDraftRequest",
  "required": [
    "draft_id"
  ],
  "properties": {
    "user_id": {
      "type": "string",
      "title": "User Id",
      "default": "me",
      "examples": [
        "me",
        "user@example.com"
      ],
      "description": "The user's email address. The special value `me` can be used to indicate the authenticated user.",
      "human_parameter_name": "User email address",
      "human_parameter_description": "The email address of the user sending the draft. Use 'me' to send from your own account."
    },
    "draft_id": {
      "type": "string",
      "title": "Draft Id",
      "examples": [
        "r99885592323229922"
      ],
      "description": "The ID of the draft to send. Draft IDs are typically alphanumeric strings (e.g., 'r99885592323229922'). Important: Do not confuse draft_id with message_id - they are different identifiers. Use GMAIL_LIST_DRAFTS to retrieve valid draft IDs, or GMAIL_CREATE_EMAIL_DRAFT to create a new draft and get its ID. IMPORTANT: The draft MUST already have recipients (To, Cc, or Bcc) set - this action cannot add or override recipients. If the draft has no recipients, first create a new draft with recipients using GMAIL_CREATE_EMAIL_DRAFT, or use GMAIL_SEND_EMAIL to send a new email directly.",
      "human_parameter_name": "Draft ID",
      "human_parameter_description": "The unique identifier of the draft you want to send. Must be a valid draft ID from an existing draft in the user's account."
    }
  }
}
```

**Output schema:**
```json
{
  "type": "object",
  "$defs": {
    "GmailMessageResponse": {
      "type": "object",
      "title": "GmailMessageResponse",
      "properties": {
        "id": {
          "type": "string",
          "title": "Id",
          "description": "The immutable ID of the sent message."
        },
        "raw": {
          "type": "string",
          "title": "Raw",
          "description": "The entire email message in RFC 2822 format, base64url-encoded."
        },
        "payload": {
          "type": "object",
          "title": "Payload",
          "description": "The parsed email structure, including headers and body parts.",
          "additionalProperties": true
        },
        "snippet": {
          "type": "string",
          "title": "Snippet",
          "description": "A short extract of the message text."
        },
        "labelIds": {
          "type": "array",
          "items": {
            "type": "string"
          },
          "title": "Label Ids",
          "description": "List of IDs of labels applied to this message."
        },
        "threadId": {
          "type": "string",
          "title": "Thread Id",
          "description": "The ID of the thread the message belongs to."
        },
        "historyId": {
          "type": "string",
          "title": "History Id",
          "description": "The ID of the last history record that modified this message."
        },
        "display_url": {
          "type": "string",
          "title": "Display Url",
          "description": "Web UI link for this resource - set by each action's execute()."
        },
        "internalDate": {
          "type": "string",
          "title": "Internal Date",
          "description": "The internal timestamp of the message in milliseconds since epoch."
        },
        "sizeEstimate": {
          "type": "integer",
          "title": "Size Estimate",
          "description": "Estimated size of the message in bytes."
        }
      },
      "description": "Standard Gmail message response returned by Gmail API for sent messages.\nUsed by actions like send_email and send_draft."
    }
  },
  "title": "GmailMessageResponseWrapper",
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
          "description": "The immutable ID of the sent message."
        },
        "raw": {
          "type": "string",
          "title": "Raw",
          "description": "The entire email message in RFC 2822 format, base64url-encoded."
        },
        "payload": {
          "type": "object",
          "title": "Payload",
          "description": "The parsed email structure, including headers and body parts.",
          "additionalProperties": true
        },
        "snippet": {
          "type": "string",
          "title": "Snippet",
          "description": "A short extract of the message text."
        },
        "labelIds": {
          "type": "array",
          "items": {
            "type": "string"
          },
          "title": "Label Ids",
          "description": "List of IDs of labels applied to this message."
        },
        "threadId": {
          "type": "string",
          "title": "Thread Id",
          "description": "The ID of the thread the message belongs to."
        },
        "historyId": {
          "type": "string",
          "title": "History Id",
          "description": "The ID of the last history record that modified this message."
        },
        "display_url": {
          "type": "string",
          "title": "Display Url",
          "description": "Web UI link for this resource - set by each action's execute()."
        },
        "internalDate": {
          "type": "string",
          "title": "Internal Date",
          "description": "The internal timestamp of the message in milliseconds since epoch."
        },
        "sizeEstimate": {
          "type": "integer",
          "title": "Size Estimate",
          "description": "Estimated size of the message in bytes."
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

## GMAIL_SEND_EMAIL
Sends an email via Gmail API using the authenticated user's Google profile display name. Sends immediately and is irreversible — confirm recipients, subject, body, and attachments before calling. At least one of 'to' (or 'recipient_email'), 'cc', or 'bcc' must be provided. At least one of subject or body must be provided. Requires `is_html=True` if the body contains HTML. All common file types including PNG, JPG, PDF, MP4, etc. are supported as attachments. Gmail API limits total message size to ~25 MB after base64 encoding. To reply in an existing thread, use GMAIL_REPLY_TO_THREAD instead. No scheduled send support; enforce timing externally.

**Input schema:**
```json
{
  "type": "object",
  "title": "SendEmailRequest",
  "properties": {
    "cc": {
      "type": "array",
      "items": {
        "type": "string"
      },
      "title": "Cc",
      "default": [],
      "examples": [
        [
          "manager@example.com",
          "teamlead@example.com"
        ]
      ],
      "description": "Carbon Copy (CC) recipients' email addresses. At least one of 'to'/'recipient_email', 'cc', or 'bcc' must be provided.",
      "human_parameter_name": "CC recipients' email addresses",
      "human_parameter_description": "Provide email addresses of people you want to inform about the email without them being the main recipient."
    },
    "bcc": {
      "type": "array",
      "items": {
        "type": "string"
      },
      "title": "Bcc",
      "default": [],
      "examples": [
        [
          "auditor@example.com"
        ]
      ],
      "description": "Blind Carbon Copy (BCC) recipients' email addresses. At least one of 'to'/'recipient_email', 'cc', or 'bcc' must be provided.",
      "human_parameter_name": "BCC recipients' email addresses",
      "human_parameter_description": "Enter email addresses of people you want to receive the email without the main recipients knowing."
    },
    "body": {
      "type": "string",
      "title": "Body",
      "examples": [
        "Hello team, let's discuss the project updates tomorrow.",
        "<h1>Welcome!</h1><p>Thank you for signing up.</p>",
        ""
      ],
      "description": "Email content (plain text or HTML). Either subject or body must be provided for the email to be sent. If HTML, `is_html` must be `True`.",
      "human_parameter_name": "Email content",
      "human_parameter_description": "Write the main message of your email here. It can be plain text or formatted HTML."
    },
    "is_html": {
      "type": "boolean",
      "title": "Is Html",
      "default": false,
      "description": "Set to `True` if the email body contains HTML tags.",
      "human_parameter_name": "Does the email body contain HTML?",
      "human_parameter_description": "Indicate whether the content of your email is formatted with HTML."
    },
    "subject": {
      "type": "string",
      "title": "Subject",
      "examples": [
        "Project Update Meeting",
        "Your Weekly Newsletter"
      ],
      "description": "Subject line of the email. Either subject or body must be provided for the email to be sent.",
      "human_parameter_name": "Email subject line",
      "human_parameter_description": "This is the title of your email that summarizes its content."
    },
    "user_id": {
      "type": "string",
      "title": "User Id",
      "default": "me",
      "examples": [
        "user@example.com",
        "me"
      ],
      "description": "User's email address; the literal 'me' refers to the authenticated user.",
      "human_parameter_name": "User ID",
      "human_parameter_description": "This is the email address of the user whose mailbox you want to access. You can use 'me' to refer to your own mailbox."
    },
    "attachment": {
      "type": "object",
      "title": "FileUploadable",
      "required": [
        "name",
        "mimetype",
        "s3key"
      ],
      "properties": {
        "name": {
          "type": "string",
          "title": "Name",
          "examples": [
            "document.pdf",
            "image.jpg",
            "report.docx"
          ],
          "description": "The filename that will be used when uploading the file to the destination service"
        },
        "s3key": {
          "type": "string",
          "title": "S3Key",
          "examples": [
            "47563/gmail/GET_ATTACHMENT/response/12345"
          ],
          "description": "The S3 key of a publicly accessible file, typically returned from a previous download action that stored the file in S3. This key references an existing file that can be uploaded to another service."
        },
        "mimetype": {
          "type": "string",
          "title": "Mimetype",
          "examples": [
            "application/pdf",
            "image/jpeg",
            "application/vnd.openxmlformats-officedocument.wordprocessingml.document"
          ],
          "description": "The MIME type of the file"
        }
      },
      "description": "File to attach. IMPORTANT: mimetype MUST contain a '/' separator - single words like 'pdf' or 'new' are invalid. Gmail API limits: total message size must not exceed ~25 MB after base64 encoding. Omit or set to null for no attachment. Empty attachment objects (with all fields empty/whitespace) are treated as no attachment. Must include valid name, mimetype (e.g., 'application/pdf'), and s3key obtained from a prior upload/download response \u2014 local paths or guessed keys cause 404 HeadObject errors.",
      "file_uploadable": true,
      "additionalProperties": false,
      "human_parameter_name": "File to attach",
      "human_parameter_description": "If you want to send a file with your email, provide it here. The mimetype must be in 'type/subtype' format (e.g., 'application/pdf' for PDFs, 'image/png' for PNG files). Make sure the file is not too large (recommended under 20 MB before encoding)."
    },
    "from_email": {
      "type": "string",
      "title": "From Email",
      "examples": [
        "alias@example.com",
        "marketing@company.com"
      ],
      "description": "Sender email address for the 'From' header. Use this to send from a verified alias configured in Gmail's 'Send mail as' settings. When not provided, the authenticated user's primary email address is used. The alias must be verified in Gmail settings before use.",
      "human_parameter_name": "Sender email address (alias)",
      "human_parameter_description": "Specify a 'Send mail as' alias email address to send from. Must be pre-configured and verified in Gmail settings. Leave empty to use your primary email."
    },
    "recipient_email": {
      "type": "string",
      "title": "Recipient Email",
      "examples": [
        "john@doe.com",
        "me"
      ],
      "description": "Primary recipient's email address. You can also use 'to' as an alias for this parameter. At least one of 'to'/'recipient_email', 'cc', or 'bcc' must be provided. Use extra_recipients if you want to send to multiple recipients. Use the special value 'me' to send to your own authenticated email address. Must be a full user@domain address; 'me' is not valid here and will fail.",
      "human_parameter_name": "Primary recipient's email address",
      "human_parameter_description": "Enter the main email address of the person you want to send the email to. Use 'me' to send to yourself."
    },
    "extra_recipients": {
      "type": "array",
      "items": {
        "type": "string"
      },
      "title": "Extra Recipients",
      "default": [],
      "examples": [
        [
          "jane.doe@example.com",
          "support@example.com"
        ]
      ],
      "description": "Additional 'To' recipients' email addresses (not Cc or Bcc). Should only be used if recipient_email is also provided.",
      "human_parameter_name": "Additional 'To' recipients' email addresses",
      "human_parameter_description": "List extra email addresses for other recipients you want to send the email to."
    }
  }
}
```

**Output schema:**
```json
{
  "type": "object",
  "$defs": {
    "GmailMessageResponse": {
      "type": "object",
      "title": "GmailMessageResponse",
      "properties": {
        "id": {
          "type": "string",
          "title": "Id",
          "description": "The immutable ID of the sent message."
        },
        "raw": {
          "type": "string",
          "title": "Raw",
          "description": "The entire email message in RFC 2822 format, base64url-encoded."
        },
        "payload": {
          "type": "object",
          "title": "Payload",
          "description": "The parsed email structure, including headers and body parts.",
          "additionalProperties": true
        },
        "snippet": {
          "type": "string",
          "title": "Snippet",
          "description": "A short extract of the message text."
        },
        "labelIds": {
          "type": "array",
          "items": {
            "type": "string"
          },
          "title": "Label Ids",
          "description": "List of IDs of labels applied to this message."
        },
        "threadId": {
          "type": "string",
          "title": "Thread Id",
          "description": "The ID of the thread the message belongs to."
        },
        "historyId": {
          "type": "string",
          "title": "History Id",
          "description": "The ID of the last history record that modified this message."
        },
        "display_url": {
          "type": "string",
          "title": "Display Url",
          "description": "Web UI link for this resource - set by each action's execute()."
        },
        "internalDate": {
          "type": "string",
          "title": "Internal Date",
          "description": "The internal timestamp of the message in milliseconds since epoch."
        },
        "sizeEstimate": {
          "type": "integer",
          "title": "Size Estimate",
          "description": "Estimated size of the message in bytes."
        }
      },
      "description": "Standard Gmail message response returned by Gmail API for sent messages.\nUsed by actions like send_email and send_draft."
    }
  },
  "title": "GmailMessageResponseWrapper",
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
          "description": "The immutable ID of the sent message."
        },
        "raw": {
          "type": "string",
          "title": "Raw",
          "description": "The entire email message in RFC 2822 format, base64url-encoded."
        },
        "payload": {
          "type": "object",
          "title": "Payload",
          "description": "The parsed email structure, including headers and body parts.",
          "additionalProperties": true
        },
        "snippet": {
          "type": "string",
          "title": "Snippet",
          "description": "A short extract of the message text."
        },
        "labelIds": {
          "type": "array",
          "items": {
            "type": "string"
          },
          "title": "Label Ids",
          "description": "List of IDs of labels applied to this message."
        },
        "threadId": {
          "type": "string",
          "title": "Thread Id",
          "description": "The ID of the thread the message belongs to."
        },
        "historyId": {
          "type": "string",
          "title": "History Id",
          "description": "The ID of the last history record that modified this message."
        },
        "display_url": {
          "type": "string",
          "title": "Display Url",
          "description": "Web UI link for this resource - set by each action's execute()."
        },
        "internalDate": {
          "type": "string",
          "title": "Internal Date",
          "description": "The internal timestamp of the message in milliseconds since epoch."
        },
        "sizeEstimate": {
          "type": "integer",
          "title": "Size Estimate",
          "description": "Estimated size of the message in bytes."
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

## GMAIL_SETTINGS_GET_IMAP
Retrieves the IMAP settings for a Gmail user account, including whether IMAP is enabled, auto-expunge behavior, expunge behavior, and maximum folder size.

**Input schema:**
```json
{
  "type": "object",
  "title": "SettingsGetImapRequest",
  "properties": {
    "user_id": {
      "type": "string",
      "title": "User Id",
      "default": "me",
      "examples": [
        "me",
        "user@example.com"
      ],
      "description": "The user's email address or the special value 'me' to indicate the authenticated user.",
      "human_parameter_name": "User ID",
      "human_parameter_description": "Provide the email address of the user whose IMAP settings you want to retrieve. Use 'me' to access your own settings."
    }
  }
}
```

**Output schema:**
```json
{
  "type": "object",
  "$defs": {
    "SettingsGetImapResponse": {
      "type": "object",
      "title": "SettingsGetImapResponse",
      "properties": {
        "enabled": {
          "type": "boolean",
          "title": "Enabled",
          "description": "Whether IMAP is enabled for the account."
        },
        "autoExpunge": {
          "type": "boolean",
          "title": "Auto Expunge",
          "description": "If true, Gmail will immediately expunge a message when it is marked as deleted in IMAP."
        },
        "display_url": {
          "type": "string",
          "title": "Display Url",
          "description": "Web UI link for this resource - clickable URL pointing to the Gmail IMAP settings page"
        },
        "maxFolderSize": {
          "type": "integer",
          "title": "Max Folder Size",
          "description": "An optional limit on the number of messages that an IMAP folder may contain. Legal values are 0, 1000, 2000, 5000 or 10000."
        },
        "expungeBehavior": {
          "enum": [
            "expungeBehaviorUnspecified",
            "archive",
            "trash",
            "deleteForever"
          ],
          "type": "string",
          "title": "Expunge Behavior",
          "description": "The action that will be executed on a message when it is marked as deleted and expunged from the last visible IMAP folder. Possible values: 'expungeBehaviorUnspecified' (Unspecified behavior), 'archive' (Archive messages marked as deleted), 'trash' (Move messages marked as deleted to the trash), 'deleteForever' (Immediately and permanently delete messages marked as deleted)."
        }
      },
      "description": "The IMAP settings for a Gmail user account."
    }
  },
  "title": "SettingsGetImapResponseWrapper",
  "required": [
    "data",
    "successful"
  ],
  "properties": {
    "data": {
      "type": "object",
      "title": "Data",
      "properties": {
        "enabled": {
          "type": "boolean",
          "title": "Enabled",
          "description": "Whether IMAP is enabled for the account."
        },
        "autoExpunge": {
          "type": "boolean",
          "title": "Auto Expunge",
          "description": "If true, Gmail will immediately expunge a message when it is marked as deleted in IMAP."
        },
        "display_url": {
          "type": "string",
          "title": "Display Url",
          "description": "Web UI link for this resource - clickable URL pointing to the Gmail IMAP settings page"
        },
        "maxFolderSize": {
          "type": "integer",
          "title": "Max Folder Size",
          "description": "An optional limit on the number of messages that an IMAP folder may contain. Legal values are 0, 1000, 2000, 5000 or 10000."
        },
        "expungeBehavior": {
          "enum": [
            "expungeBehaviorUnspecified",
            "archive",
            "trash",
            "deleteForever"
          ],
          "type": "string",
          "title": "Expunge Behavior",
          "description": "The action that will be executed on a message when it is marked as deleted and expunged from the last visible IMAP folder. Possible values: 'expungeBehaviorUnspecified' (Unspecified behavior), 'archive' (Archive messages marked as deleted), 'trash' (Move messages marked as deleted to the trash), 'deleteForever' (Immediately and permanently delete messages marked as deleted)."
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

## GMAIL_SETTINGS_GET_POP
Tool to retrieve POP settings for a Gmail account. Use when you need to check the current POP configuration including access window and message disposition.

**Input schema:**
```json
{
  "type": "object",
  "title": "GmailSettingsGetPopRequest",
  "properties": {
    "user_id": {
      "type": "string",
      "title": "User Id",
      "default": "me",
      "examples": [
        "me",
        "user@example.com"
      ],
      "description": "The user's email address. The special value 'me' can be used to indicate the authenticated user."
    }
  }
}
```

**Output schema:**
```json
{
  "type": "object",
  "$defs": {
    "GmailSettingsGetPopResponse": {
      "type": "object",
      "title": "GmailSettingsGetPopResponse",
      "properties": {
        "display_url": {
          "type": "string",
          "title": "Display Url",
          "description": "Web UI link for this resource - clickable URL pointing to the Gmail web interface"
        },
        "disposition": {
          "enum": [
            "dispositionUnspecified",
            "leaveInInbox",
            "archive",
            "trash",
            "markRead"
          ],
          "type": "string",
          "title": "Disposition",
          "description": "The action that will be executed on a message after it has been fetched via POP."
        },
        "accessWindow": {
          "enum": [
            "accessWindowUnspecified",
            "disabled",
            "fromNowOn",
            "allMail"
          ],
          "type": "string",
          "title": "Access Window",
          "description": "The range of messages which are accessible via POP."
        }
      },
      "description": "POP settings for a Gmail account."
    }
  },
  "title": "GmailSettingsGetPopResponseWrapper",
  "required": [
    "data",
    "successful"
  ],
  "properties": {
    "data": {
      "type": "object",
      "title": "Data",
      "properties": {
        "display_url": {
          "type": "string",
          "title": "Display Url",
          "description": "Web UI link for this resource - clickable URL pointing to the Gmail web interface"
        },
        "disposition": {
          "enum": [
            "dispositionUnspecified",
            "leaveInInbox",
            "archive",
            "trash",
            "markRead"
          ],
          "type": "string",
          "title": "Disposition",
          "description": "The action that will be executed on a message after it has been fetched via POP."
        },
        "accessWindow": {
          "enum": [
            "accessWindowUnspecified",
            "disabled",
            "fromNowOn",
            "allMail"
          ],
          "type": "string",
          "title": "Access Window",
          "description": "The range of messages which are accessible via POP."
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

## GMAIL_SETTINGS_SEND_AS_GET
Tool to retrieve a specific send-as alias configuration for a Gmail user. Use when you need to get details about a send-as email address including display name, signature, SMTP settings, and verification status. Fails with HTTP 404 if the specified address is not a member of the send-as collection.

**Input schema:**
```json
{
  "type": "object",
  "title": "GmailSettingsSendAsGetRequest",
  "required": [
    "send_as_email"
  ],
  "properties": {
    "user_id": {
      "type": "string",
      "title": "User Id",
      "default": "me",
      "examples": [
        "me",
        "user@example.com"
      ],
      "description": "The email address of the Gmail user whose send-as alias to retrieve, or the special value 'me' to indicate the authenticated user."
    },
    "send_as_email": {
      "type": "string",
      "title": "Send As Email",
      "examples": [
        "alias@example.com",
        "pranai@usefulagents.com"
      ],
      "description": "The send-as alias email address to retrieve. This is the email address that appears in the 'From:' header."
    }
  }
}
```

**Output schema:**
```json
{
  "type": "object",
  "$defs": {
    "SmtpMsa": {
      "type": "object",
      "title": "SmtpMsa",
      "required": [
        "host",
        "port",
        "securityMode"
      ],
      "properties": {
        "host": {
          "type": "string",
          "title": "Host",
          "description": "The hostname of the SMTP service."
        },
        "port": {
          "type": "integer",
          "title": "Port",
          "description": "The port of the SMTP service."
        },
        "password": {
          "type": "string",
          "title": "Password",
          "description": "SMTP authentication password (write-only, never appears in responses)."
        },
        "username": {
          "type": "string",
          "title": "Username",
          "description": "SMTP authentication username (write-only, never appears in responses)."
        },
        "securityMode": {
          "enum": [
            "securityModeUnspecified",
            "none",
            "ssl",
            "starttls"
          ],
          "type": "string",
          "title": "Security Mode",
          "description": "Protocol for securing SMTP communication."
        }
      },
      "description": "SMTP relay configuration for the send-as alias."
    },
    "GmailSettingsSendAsGetResponse": {
      "type": "object",
      "title": "GmailSettingsSendAsGetResponse",
      "required": [
        "sendAsEmail"
      ],
      "properties": {
        "smtpMsa": {
          "type": "object",
          "title": "Smtp Msa",
          "required": [
            "host",
            "port",
            "securityMode"
          ],
          "properties": {
            "host": {
              "type": "string",
              "title": "Host",
              "description": "The hostname of the SMTP service."
            },
            "port": {
              "type": "integer",
              "title": "Port",
              "description": "The port of the SMTP service."
            },
            "password": {
              "type": "string",
              "title": "Password",
              "description": "SMTP authentication password (write-only, never appears in responses)."
            },
            "username": {
              "type": "string",
              "title": "Username",
              "description": "SMTP authentication username (write-only, never appears in responses)."
            },
            "securityMode": {
              "enum": [
                "securityModeUnspecified",
                "none",
                "ssl",
                "starttls"
              ],
              "type": "string",
              "title": "Security Mode",
              "description": "Protocol for securing SMTP communication."
            }
          },
          "description": "SMTP relay configuration for sending mail through external SMTP server."
        },
        "isDefault": {
          "type": "boolean",
          "title": "Is Default",
          "description": "Whether selected as default 'From:' address."
        },
        "isPrimary": {
          "type": "boolean",
          "title": "Is Primary",
          "description": "Whether this is the primary login address. Read-only."
        },
        "signature": {
          "type": "string",
          "title": "Signature",
          "description": "Optional HTML signature for composed messages."
        },
        "displayName": {
          "type": "string",
          "title": "Display Name",
          "description": "Name shown in 'From:' header. Auto-populated for primary address if empty."
        },
        "sendAsEmail": {
          "type": "string",
          "title": "Send As Email",
          "description": "The email address that appears in the 'From:' header for mail sent using this alias."
        },
        "treatAsAlias": {
          "type": "boolean",
          "title": "Treat As Alias",
          "description": "Whether Gmail treats this as an alias for the primary address."
        },
        "replyToAddress": {
          "type": "string",
          "title": "Reply To Address",
          "description": "Optional email for 'Reply-To:' header."
        },
        "verificationStatus": {
          "enum": [
            "verificationStatusUnspecified",
            "accepted",
            "pending"
          ],
          "type": "string",
          "title": "Verification Status",
          "description": "Address verification status. Read-only."
        }
      },
      "description": "Response containing the send-as alias configuration."
    }
  },
  "title": "GmailSettingsSendAsGetResponseWrapper",
  "required": [
    "data",
    "successful"
  ],
  "properties": {
    "data": {
      "type": "object",
      "title": "Data",
      "required": [
        "sendAsEmail"
      ],
      "properties": {
        "smtpMsa": {
          "type": "object",
          "title": "Smtp Msa",
          "required": [
            "host",
            "port",
            "securityMode"
          ],
          "properties": {
            "host": {
              "type": "string",
              "title": "Host",
              "description": "The hostname of the SMTP service."
            },
            "port": {
              "type": "integer",
              "title": "Port",
              "description": "The port of the SMTP service."
            },
            "password": {
              "type": "string",
              "title": "Password",
              "description": "SMTP authentication password (write-only, never appears in responses)."
            },
            "username": {
              "type": "string",
              "title": "Username",
              "description": "SMTP authentication username (write-only, never appears in responses)."
            },
            "securityMode": {
              "enum": [
                "securityModeUnspecified",
                "none",
                "ssl",
                "starttls"
              ],
              "type": "string",
              "title": "Security Mode",
              "description": "Protocol for securing SMTP communication."
            }
          },
          "description": "SMTP relay configuration for sending mail through external SMTP server."
        },
        "isDefault": {
          "type": "boolean",
          "title": "Is Default",
          "description": "Whether selected as default 'From:' address."
        },
        "isPrimary": {
          "type": "boolean",
          "title": "Is Primary",
          "description": "Whether this is the primary login address. Read-only."
        },
        "signature": {
          "type": "string",
          "title": "Signature",
          "description": "Optional HTML signature for composed messages."
        },
        "displayName": {
          "type": "string",
          "title": "Display Name",
          "description": "Name shown in 'From:' header. Auto-populated for primary address if empty."
        },
        "sendAsEmail": {
          "type": "string",
          "title": "Send As Email",
          "description": "The email address that appears in the 'From:' header for mail sent using this alias."
        },
        "treatAsAlias": {
          "type": "boolean",
          "title": "Treat As Alias",
          "description": "Whether Gmail treats this as an alias for the primary address."
        },
        "replyToAddress": {
          "type": "string",
          "title": "Reply To Address",
          "description": "Optional email for 'Reply-To:' header."
        },
        "verificationStatus": {
          "enum": [
            "verificationStatusUnspecified",
            "accepted",
            "pending"
          ],
          "type": "string",
          "title": "Verification Status",
          "description": "Address verification status. Read-only."
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

## GMAIL_STOP_WATCH
Tool to stop receiving push notifications for a Gmail mailbox. Use when you need to disable watch notifications previously set up via the watch endpoint.

**Input schema:**
```json
{
  "type": "object",
  "title": "StopWatchRequest",
  "properties": {
    "user_id": {
      "type": "string",
      "title": "User Id",
      "default": "me",
      "examples": [
        "me",
        "user@example.com"
      ],
      "description": "The user's email address. The special value 'me' can be used to indicate the authenticated user."
    }
  }
}
```

**Output schema:**
```json
{
  "type": "object",
  "$defs": {
    "StopWatchResponse": {
      "type": "object",
      "title": "StopWatchResponse",
      "required": [
        "success"
      ],
      "properties": {
        "success": {
          "type": "boolean",
          "title": "Success",
          "description": "Indicates whether push notifications were successfully stopped for the mailbox."
        },
        "display_url": {
          "type": "string",
          "title": "Display Url",
          "description": "Web UI link for this resource - set by each action's execute()."
        }
      },
      "description": "Empty response indicating successful stop of push notifications."
    }
  },
  "title": "StopWatchResponseWrapper",
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
          "description": "Indicates whether push notifications were successfully stopped for the mailbox."
        },
        "display_url": {
          "type": "string",
          "title": "Display Url",
          "description": "Web UI link for this resource - set by each action's execute()."
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

## GMAIL_UNTRASH_MESSAGE
Tool to remove a message from trash in Gmail. Use when you need to restore a previously trashed email message.

**Input schema:**
```json
{
  "type": "object",
  "title": "UntrashMessageRequest",
  "required": [
    "message_id"
  ],
  "properties": {
    "user_id": {
      "type": "string",
      "title": "User Id",
      "default": "me",
      "examples": [
        "user@example.com",
        "me"
      ],
      "description": "User's email address or 'me' for the authenticated user."
    },
    "message_id": {
      "type": "string",
      "title": "Message Id",
      "pattern": "^[0-9a-fA-F]+$",
      "examples": [
        "1875f42779f726f2",
        "19c86b92a3e6ef0f"
      ],
      "description": "Required. The unique identifier of the email message to remove from trash. This is a hexadecimal string that can be obtained from listing or fetching emails."
    }
  }
}
```

**Output schema:**
```json
{
  "type": "object",
  "$defs": {
    "GmailMessageResponse": {
      "type": "object",
      "title": "GmailMessageResponse",
      "properties": {
        "id": {
          "type": "string",
          "title": "Id",
          "description": "The immutable ID of the sent message."
        },
        "raw": {
          "type": "string",
          "title": "Raw",
          "description": "The entire email message in RFC 2822 format, base64url-encoded."
        },
        "payload": {
          "type": "object",
          "title": "Payload",
          "description": "The parsed email structure, including headers and body parts.",
          "additionalProperties": true
        },
        "snippet": {
          "type": "string",
          "title": "Snippet",
          "description": "A short extract of the message text."
        },
        "labelIds": {
          "type": "array",
          "items": {
            "type": "string"
          },
          "title": "Label Ids",
          "description": "List of IDs of labels applied to this message."
        },
        "threadId": {
          "type": "string",
          "title": "Thread Id",
          "description": "The ID of the thread the message belongs to."
        },
        "historyId": {
          "type": "string",
          "title": "History Id",
          "description": "The ID of the last history record that modified this message."
        },
        "display_url": {
          "type": "string",
          "title": "Display Url",
          "description": "Web UI link for this resource - set by each action's execute()."
        },
        "internalDate": {
          "type": "string",
          "title": "Internal Date",
          "description": "The internal timestamp of the message in milliseconds since epoch."
        },
        "sizeEstimate": {
          "type": "integer",
          "title": "Size Estimate",
          "description": "Estimated size of the message in bytes."
        }
      },
      "description": "Standard Gmail message response returned by Gmail API for sent messages.\nUsed by actions like send_email and send_draft."
    }
  },
  "title": "GmailMessageResponseWrapper",
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
          "description": "The immutable ID of the sent message."
        },
        "raw": {
          "type": "string",
          "title": "Raw",
          "description": "The entire email message in RFC 2822 format, base64url-encoded."
        },
        "payload": {
          "type": "object",
          "title": "Payload",
          "description": "The parsed email structure, including headers and body parts.",
          "additionalProperties": true
        },
        "snippet": {
          "type": "string",
          "title": "Snippet",
          "description": "A short extract of the message text."
        },
        "labelIds": {
          "type": "array",
          "items": {
            "type": "string"
          },
          "title": "Label Ids",
          "description": "List of IDs of labels applied to this message."
        },
        "threadId": {
          "type": "string",
          "title": "Thread Id",
          "description": "The ID of the thread the message belongs to."
        },
        "historyId": {
          "type": "string",
          "title": "History Id",
          "description": "The ID of the last history record that modified this message."
        },
        "display_url": {
          "type": "string",
          "title": "Display Url",
          "description": "Web UI link for this resource - set by each action's execute()."
        },
        "internalDate": {
          "type": "string",
          "title": "Internal Date",
          "description": "The internal timestamp of the message in milliseconds since epoch."
        },
        "sizeEstimate": {
          "type": "integer",
          "title": "Size Estimate",
          "description": "Estimated size of the message in bytes."
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

## GMAIL_UNTRASH_THREAD
Tool to remove a thread from trash in Gmail. Use when you need to restore a deleted thread and its messages.

**Input schema:**
```json
{
  "type": "object",
  "title": "UntrashThreadRequest",
  "required": [
    "thread_id"
  ],
  "properties": {
    "user_id": {
      "type": "string",
      "title": "User Id",
      "default": "me",
      "examples": [
        "me",
        "user@example.com"
      ],
      "description": "The user's email address. The special value 'me' can be used to indicate the authenticated user."
    },
    "thread_id": {
      "type": "string",
      "title": "Thread Id",
      "examples": [
        "19c8e0e93a7aa8ba",
        "18ea7715b619f09c"
      ],
      "description": "The ID of the thread to remove from trash."
    }
  }
}
```

**Output schema:**
```json
{
  "type": "object",
  "$defs": {
    "MessageSummary": {
      "type": "object",
      "title": "MessageSummary",
      "properties": {
        "id": {
          "type": "string",
          "title": "Id",
          "description": "The unique ID of the message."
        },
        "labelIds": {
          "type": "array",
          "items": {
            "type": "string"
          },
          "title": "Label Ids",
          "description": "List of label IDs applied to this message."
        },
        "threadId": {
          "type": "string",
          "title": "Thread Id",
          "description": "The ID of the thread this message belongs to."
        }
      },
      "description": "Basic message information within a thread."
    },
    "UntrashThreadResponse": {
      "type": "object",
      "title": "UntrashThreadResponse",
      "properties": {
        "id": {
          "type": "string",
          "title": "Id",
          "description": "The unique ID of the thread."
        },
        "snippet": {
          "type": "string",
          "title": "Snippet",
          "description": "A short part of the message text."
        },
        "messages": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "MessageSummary",
            "properties": {
              "id": {
                "type": "string",
                "title": "Id",
                "description": "The unique ID of the message."
              },
              "labelIds": {
                "type": "array",
                "items": {
                  "type": "string"
                },
                "title": "Label Ids",
                "description": "List of label IDs applied to this message."
              },
              "threadId": {
                "type": "string",
                "title": "Thread Id",
                "description": "The ID of the thread this message belongs to."
              }
            },
            "description": "Basic message information within a thread."
          },
          "title": "Messages",
          "description": "The list of messages in the thread."
        },
        "historyId": {
          "type": "string",
          "title": "History Id",
          "description": "The ID of the last history record that modified this thread."
        },
        "display_url": {
          "type": "string",
          "title": "Display Url",
          "description": "Web UI link to view this thread in Gmail."
        }
      },
      "description": "Thread resource returned after untrashing."
    }
  },
  "title": "UntrashThreadResponseWrapper",
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
          "description": "The unique ID of the thread."
        },
        "snippet": {
          "type": "string",
          "title": "Snippet",
          "description": "A short part of the message text."
        },
        "messages": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "MessageSummary",
            "properties": {
              "id": {
                "type": "string",
                "title": "Id",
                "description": "The unique ID of the message."
              },
              "labelIds": {
                "type": "array",
                "items": {
                  "type": "string"
                },
                "title": "Label Ids",
                "description": "List of label IDs applied to this message."
              },
              "threadId": {
                "type": "string",
                "title": "Thread Id",
                "description": "The ID of the thread this message belongs to."
              }
            },
            "description": "Basic message information within a thread."
          },
          "title": "Messages",
          "description": "The list of messages in the thread."
        },
        "historyId": {
          "type": "string",
          "title": "History Id",
          "description": "The ID of the last history record that modified this thread."
        },
        "display_url": {
          "type": "string",
          "title": "Display Url",
          "description": "Web UI link to view this thread in Gmail."
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

## GMAIL_UPDATE_DRAFT
Updates (replaces) an existing Gmail draft's content in-place by draft ID. This action replaces the entire draft content with the new message - it does not patch individual fields. All fields are optional; if not provided, you should provide complete draft content to avoid data loss.

**Input schema:**
```json
{
  "type": "object",
  "title": "UpdateDraftRequest",
  "required": [
    "draft_id"
  ],
  "properties": {
    "cc": {
      "type": "array",
      "items": {
        "type": "string"
      },
      "title": "Cc",
      "default": [],
      "examples": [
        [
          "cc.recipient1@example.com",
          "CC User <cc.recipient2@example.com>"
        ]
      ],
      "description": "Carbon Copy (CC) recipients' email addresses. Each must be a valid email address or display name format."
    },
    "bcc": {
      "type": "array",
      "items": {
        "type": "string"
      },
      "title": "Bcc",
      "default": [],
      "examples": [
        [
          "bcc.recipient@example.com",
          "BCC User <bcc.user@example.com>"
        ]
      ],
      "description": "Blind Carbon Copy (BCC) recipients' email addresses. Each must be a valid email address or display name format."
    },
    "body": {
      "type": "string",
      "title": "Body",
      "examples": [
        "Hello Team,\n\nPlease find the attached report.\n\nBest regards",
        "<h1>Meeting Confirmation</h1><p>This confirms our meeting.</p>"
      ],
      "description": "Email body content (plain text or HTML); is_html must be True if HTML. If not provided, previous body is preserved. Can also be provided as 'message_body'."
    },
    "is_html": {
      "type": "boolean",
      "title": "Is Html",
      "default": false,
      "examples": [
        true,
        false
      ],
      "description": "Set to True if body is already formatted HTML. When False, plain text newlines are auto-converted to <br/> tags."
    },
    "subject": {
      "type": "string",
      "title": "Subject",
      "examples": [
        "Project Update Q3",
        "Meeting Reminder"
      ],
      "description": "Email subject line. If not provided, previous subject is preserved."
    },
    "user_id": {
      "type": "string",
      "title": "User Id",
      "default": "me",
      "examples": [
        "me",
        "user@example.com"
      ],
      "description": "User's email address or 'me' for the authenticated user."
    },
    "draft_id": {
      "type": "string",
      "title": "Draft Id",
      "examples": [
        "r-8388446164079304564",
        "r1234567890123456789"
      ],
      "description": "The ID of the draft to update. Must be a valid draft ID from GMAIL_LIST_DRAFTS or GMAIL_CREATE_EMAIL_DRAFT."
    },
    "thread_id": {
      "type": "string",
      "title": "Thread Id",
      "examples": [
        "17f45ec49a9c3f1b"
      ],
      "description": "ID of an existing Gmail thread. If provided, the draft will be part of this thread."
    },
    "attachment": {
      "type": "object",
      "title": "FileUploadable",
      "required": [
        "name",
        "mimetype",
        "s3key"
      ],
      "properties": {
        "name": {
          "type": "string",
          "title": "Name",
          "examples": [
            "document.pdf",
            "image.jpg",
            "report.docx"
          ],
          "description": "The filename that will be used when uploading the file to the destination service"
        },
        "s3key": {
          "type": "string",
          "title": "S3Key",
          "examples": [
            "47563/gmail/GET_ATTACHMENT/response/12345"
          ],
          "description": "The S3 key of a publicly accessible file, typically returned from a previous download action that stored the file in S3. This key references an existing file that can be uploaded to another service."
        },
        "mimetype": {
          "type": "string",
          "title": "Mimetype",
          "examples": [
            "application/pdf",
            "image/jpeg",
            "application/vnd.openxmlformats-officedocument.wordprocessingml.document"
          ],
          "description": "The MIME type of the file"
        }
      },
      "description": "File to attach to the draft. Replaces any existing attachments.",
      "file_uploadable": true,
      "additionalProperties": false
    },
    "recipient_email": {
      "type": "string",
      "title": "Recipient Email",
      "examples": [
        "john.doe@example.com",
        "John Doe <john.doe@example.com>"
      ],
      "description": "Primary recipient's email address. Must be a valid email address (e.g., 'user@example.com') or display name format (e.g., 'John Doe <user@example.com>'). Optional - if not provided, previous recipients are preserved."
    },
    "extra_recipients": {
      "type": "array",
      "items": {
        "type": "string"
      },
      "title": "Extra Recipients",
      "default": [],
      "examples": [
        [
          "jane.doe@example.com",
          "Jane Doe <jane.doe@example.com>"
        ]
      ],
      "description": "Additional 'To' recipients' email addresses. Each must be a valid email address or display name format. Should only be used if recipient_email is also provided."
    }
  }
}
```

**Output schema:**
```json
{
  "type": "object",
  "$defs": {
    "UpdateDraftResponse": {
      "type": "object",
      "title": "UpdateDraftResponse",
      "required": [
        "id",
        "message"
      ],
      "properties": {
        "id": {
          "type": "string",
          "title": "Id",
          "description": "Immutable ID of the draft."
        },
        "message": {
          "type": "object",
          "title": "Message",
          "description": "The updated draft message resource with id, threadId, and labelIds.",
          "additionalProperties": true
        },
        "display_url": {
          "type": "string",
          "title": "Display Url",
          "description": "Web UI link for this resource - clickable URL pointing to the Gmail web interface"
        }
      }
    }
  },
  "title": "UpdateDraftResponseWrapper",
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
        "message"
      ],
      "properties": {
        "id": {
          "type": "string",
          "title": "Id",
          "description": "Immutable ID of the draft."
        },
        "message": {
          "type": "object",
          "title": "Message",
          "description": "The updated draft message resource with id, threadId, and labelIds.",
          "additionalProperties": true
        },
        "display_url": {
          "type": "string",
          "title": "Display Url",
          "description": "Web UI link for this resource - clickable URL pointing to the Gmail web interface"
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

## GMAIL_UPDATE_IMAP_SETTINGS
Tool to update IMAP settings for a Gmail account. Use when you need to modify IMAP configuration such as enabling/disabling IMAP, setting auto-expunge behavior, or configuring folder size limits.

**Input schema:**
```json
{
  "type": "object",
  "title": "UpdateImapSettingsRequest",
  "properties": {
    "enabled": {
      "type": "boolean",
      "title": "Enabled",
      "description": "Whether IMAP is enabled for the account."
    },
    "user_id": {
      "type": "string",
      "title": "User Id",
      "default": "me",
      "examples": [
        "me",
        "user@example.com"
      ],
      "description": "The user's email address. The special value 'me' can be used to indicate the authenticated user."
    },
    "autoExpunge": {
      "type": "boolean",
      "title": "Auto Expunge",
      "description": "If this value is true, Gmail will immediately expunge a message when it is marked as deleted in IMAP. Otherwise, Gmail will wait for an update from the client before expunging messages marked as deleted."
    },
    "maxFolderSize": {
      "type": "integer",
      "title": "Max Folder Size",
      "description": "An optional limit on the number of messages that an IMAP folder may contain. Legal values are 0, 1000, 2000, 5000 or 10000. A value of zero is interpreted to mean that there is no limit."
    },
    "expungeBehavior": {
      "enum": [
        "expungeBehaviorUnspecified",
        "archive",
        "trash",
        "deleteForever"
      ],
      "type": "string",
      "title": "Expunge Behavior",
      "description": "The action that will be executed on a message when it is marked as deleted and expunged from the last visible IMAP folder. Possible values: 'expungeBehaviorUnspecified' (Unspecified behavior), 'archive' (Archive messages marked as deleted), 'trash' (Move messages marked as deleted to the trash), 'deleteForever' (Immediately and permanently delete messages marked as deleted)."
    }
  }
}
```

**Output schema:**
```json
{
  "type": "object",
  "$defs": {
    "UpdateImapSettingsResponse": {
      "type": "object",
      "title": "UpdateImapSettingsResponse",
      "properties": {
        "enabled": {
          "type": "boolean",
          "title": "Enabled",
          "description": "Whether IMAP is enabled for the account."
        },
        "autoExpunge": {
          "type": "boolean",
          "title": "Auto Expunge",
          "description": "If this value is true, Gmail will immediately expunge a message when it is marked as deleted in IMAP. Otherwise, Gmail will wait for an update from the client before expunging messages marked as deleted."
        },
        "maxFolderSize": {
          "type": "integer",
          "title": "Max Folder Size",
          "description": "An optional limit on the number of messages that an IMAP folder may contain. Legal values are 0, 1000, 2000, 5000 or 10000. A value of zero is interpreted to mean that there is no limit."
        },
        "expungeBehavior": {
          "enum": [
            "expungeBehaviorUnspecified",
            "archive",
            "trash",
            "deleteForever"
          ],
          "type": "string",
          "title": "Expunge Behavior",
          "description": "The action that will be executed on a message when it is marked as deleted and expunged from the last visible IMAP folder."
        }
      },
      "description": "The IMAP settings for a Gmail user account."
    }
  },
  "title": "UpdateImapSettingsResponseWrapper",
  "required": [
    "data",
    "successful"
  ],
  "properties": {
    "data": {
      "type": "object",
      "title": "Data",
      "properties": {
        "enabled": {
          "type": "boolean",
          "title": "Enabled",
          "description": "Whether IMAP is enabled for the account."
        },
        "autoExpunge": {
          "type": "boolean",
          "title": "Auto Expunge",
          "description": "If this value is true, Gmail will immediately expunge a message when it is marked as deleted in IMAP. Otherwise, Gmail will wait for an update from the client before expunging messages marked as deleted."
        },
        "maxFolderSize": {
          "type": "integer",
          "title": "Max Folder Size",
          "description": "An optional limit on the number of messages that an IMAP folder may contain. Legal values are 0, 1000, 2000, 5000 or 10000. A value of zero is interpreted to mean that there is no limit."
        },
        "expungeBehavior": {
          "enum": [
            "expungeBehaviorUnspecified",
            "archive",
            "trash",
            "deleteForever"
          ],
          "type": "string",
          "title": "Expunge Behavior",
          "description": "The action that will be executed on a message when it is marked as deleted and expunged from the last visible IMAP folder."
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

## GMAIL_UPDATE_LABEL
Tool to update the properties of an existing Gmail label. Use when you need to modify label name, visibility settings, or color.

**Input schema:**
```json
{
  "type": "object",
  "title": "UpdateLabelRequest",
  "required": [
    "id"
  ],
  "properties": {
    "id": {
      "type": "string",
      "title": "Id",
      "examples": [
        "Label_10",
        "Label_123"
      ],
      "description": "The ID of the label to update."
    },
    "name": {
      "type": "string",
      "title": "Name",
      "examples": [
        "Updated Label Name",
        "My Label"
      ],
      "description": "The display name of the label."
    },
    "color": {
      "type": "object",
      "title": "UpdateLabelColor",
      "properties": {
        "textColor": {
          "type": "string",
          "title": "Text Color",
          "examples": [
            "#000000",
            "#434343",
            "#666666",
            "#ffffff"
          ],
          "description": "The text color of the label, represented as hex string. This field is required in order to set the color of a label. Only predefined Gmail color values are allowed. See: https://developers.google.com/workspace/gmail/api/guides/labels#color_palette"
        },
        "backgroundColor": {
          "type": "string",
          "title": "Background Color",
          "examples": [
            "#ffffff",
            "#f3f3f3",
            "#efefef",
            "#cccccc"
          ],
          "description": "The background color represented as hex string #RRGGBB (ex #000000). This field is required in order to set the color of a label. Only predefined Gmail color values are allowed. See: https://developers.google.com/workspace/gmail/api/guides/labels#color_palette"
        }
      },
      "description": "Color settings for the label. Both backgroundColor and textColor must be provided together.",
      "additionalProperties": false
    },
    "userId": {
      "type": "string",
      "title": "User Id",
      "default": "me",
      "examples": [
        "me",
        "user@example.com"
      ],
      "description": "The user's email address. The special value `me` can be used to indicate the authenticated user."
    },
    "labelListVisibility": {
      "enum": [
        "labelShow",
        "labelShowIfUnread",
        "labelHide"
      ],
      "type": "string",
      "title": "LabelListVisibility",
      "examples": [
        "labelShow",
        "labelShowIfUnread",
        "labelHide"
      ],
      "description": "Visibility of the label in the label list (Gmail sidebar)."
    },
    "messageListVisibility": {
      "enum": [
        "show",
        "hide"
      ],
      "type": "string",
      "title": "MessageListVisibility",
      "examples": [
        "show",
        "hide"
      ],
      "description": "Visibility of messages with this label in the message list."
    }
  },
  "description": "Request model for updating a Gmail label."
}
```

**Output schema:**
```json
{
  "type": "object",
  "$defs": {
    "UpdateLabelResponse": {
      "type": "object",
      "title": "UpdateLabelResponse",
      "properties": {
        "id": {
          "type": "string",
          "title": "Id",
          "description": "The immutable ID of the label."
        },
        "name": {
          "type": "string",
          "title": "Name",
          "description": "The display name of the label."
        },
        "type": {
          "type": "string",
          "title": "Type",
          "description": "The owner type for the label. User labels are created by the user and can be modified and deleted by the user and can be applied to any message or thread. System labels are internally created and cannot be added, modified, or deleted."
        },
        "color": {
          "type": "object",
          "title": "Color",
          "properties": {
            "textColor": {
              "type": "string",
              "title": "Text Color",
              "description": "The text color of the label, represented as hex string."
            },
            "backgroundColor": {
              "type": "string",
              "title": "Background Color",
              "description": "The background color represented as hex string."
            }
          },
          "description": "The color representation for the label."
        },
        "display_url": {
          "type": "string",
          "title": "Display Url",
          "description": "Web UI link for this resource - clickable URL pointing to the Gmail label page"
        },
        "threadsTotal": {
          "type": "integer",
          "title": "Threads Total",
          "description": "The total number of threads with the label."
        },
        "messagesTotal": {
          "type": "integer",
          "title": "Messages Total",
          "description": "The total number of messages with the label."
        },
        "threadsUnread": {
          "type": "integer",
          "title": "Threads Unread",
          "description": "The number of unread threads with the label."
        },
        "messagesUnread": {
          "type": "integer",
          "title": "Messages Unread",
          "description": "The number of unread messages with the label."
        },
        "labelListVisibility": {
          "type": "string",
          "title": "Label List Visibility",
          "description": "The visibility of the label in the label list in the Gmail web interface."
        },
        "messageListVisibility": {
          "type": "string",
          "title": "Message List Visibility",
          "description": "The visibility of messages with this label in the message list in the Gmail web interface."
        }
      },
      "description": "Response model for updating a Gmail label."
    },
    "UpdateLabelResponseColor": {
      "type": "object",
      "title": "UpdateLabelResponseColor",
      "properties": {
        "textColor": {
          "type": "string",
          "title": "Text Color",
          "description": "The text color of the label, represented as hex string."
        },
        "backgroundColor": {
          "type": "string",
          "title": "Background Color",
          "description": "The background color represented as hex string."
        }
      },
      "description": "Color settings in the response."
    }
  },
  "title": "UpdateLabelResponseWrapper",
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
          "description": "The immutable ID of the label."
        },
        "name": {
          "type": "string",
          "title": "Name",
          "description": "The display name of the label."
        },
        "type": {
          "type": "string",
          "title": "Type",
          "description": "The owner type for the label. User labels are created by the user and can be modified and deleted by the user and can be applied to any message or thread. System labels are internally created and cannot be added, modified, or deleted."
        },
        "color": {
          "type": "object",
          "title": "Color",
          "properties": {
            "textColor": {
              "type": "string",
              "title": "Text Color",
              "description": "The text color of the label, represented as hex string."
            },
            "backgroundColor": {
              "type": "string",
              "title": "Background Color",
              "description": "The background color represented as hex string."
            }
          },
          "description": "The color representation for the label."
        },
        "display_url": {
          "type": "string",
          "title": "Display Url",
          "description": "Web UI link for this resource - clickable URL pointing to the Gmail label page"
        },
        "threadsTotal": {
          "type": "integer",
          "title": "Threads Total",
          "description": "The total number of threads with the label."
        },
        "messagesTotal": {
          "type": "integer",
          "title": "Messages Total",
          "description": "The total number of messages with the label."
        },
        "threadsUnread": {
          "type": "integer",
          "title": "Threads Unread",
          "description": "The number of unread threads with the label."
        },
        "messagesUnread": {
          "type": "integer",
          "title": "Messages Unread",
          "description": "The number of unread messages with the label."
        },
        "labelListVisibility": {
          "type": "string",
          "title": "Label List Visibility",
          "description": "The visibility of the label in the label list in the Gmail web interface."
        },
        "messageListVisibility": {
          "type": "string",
          "title": "Message List Visibility",
          "description": "The visibility of messages with this label in the message list in the Gmail web interface."
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

## GMAIL_UPDATE_LANGUAGE_SETTINGS
Tool to update the language settings for a Gmail user. Use when you need to change the display language preference for the authenticated user or a specific Gmail account. The returned displayLanguage may differ from the requested value if Gmail selects a close variant.

**Input schema:**
```json
{
  "type": "object",
  "title": "UpdateLanguageSettingsRequest",
  "required": [
    "displayLanguage"
  ],
  "properties": {
    "user_id": {
      "type": "string",
      "title": "User Id",
      "default": "me",
      "examples": [
        "me",
        "user@example.com"
      ],
      "description": "The email address of the Gmail user whose language settings are to be updated, or the special value 'me' to indicate the currently authenticated user."
    },
    "displayLanguage": {
      "type": "string",
      "title": "Display Language",
      "examples": [
        "en",
        "en-GB",
        "fr",
        "ja",
        "es",
        "de",
        "it",
        "pt-BR"
      ],
      "description": "The language to display Gmail in, formatted as an RFC 3066 Language Tag (e.g., 'en-GB' for British English, 'fr' for French, 'ja' for Japanese, 'es' for Spanish, 'de' for German, 'en' for English). The set of languages supported by Gmail evolves over time. Note: Gmail may save a close variant if the requested language is not directly supported. For example, if you request a regional variant that's not available, Gmail may save the base language instead."
    }
  }
}
```

**Output schema:**
```json
{
  "type": "object",
  "$defs": {
    "UpdateLanguageSettingsResponse": {
      "type": "object",
      "title": "UpdateLanguageSettingsResponse",
      "properties": {
        "displayLanguage": {
          "type": "string",
          "title": "Display Language",
          "description": "The language to display Gmail in, formatted as an RFC 3066 Language Tag (for example en-GB, fr or ja). This may differ from the requested value if Gmail chose a close variant that is better supported."
        }
      },
      "description": "The updated Gmail language settings. The displayLanguage returned may differ from the requested value if Gmail selected a close variant."
    }
  },
  "title": "UpdateLanguageSettingsResponseWrapper",
  "required": [
    "data",
    "successful"
  ],
  "properties": {
    "data": {
      "type": "object",
      "title": "Data",
      "properties": {
        "displayLanguage": {
          "type": "string",
          "title": "Display Language",
          "description": "The language to display Gmail in, formatted as an RFC 3066 Language Tag (for example en-GB, fr or ja). This may differ from the requested value if Gmail chose a close variant that is better supported."
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

## GMAIL_UPDATE_POP_SETTINGS
Tool to update POP settings for a Gmail account. Use when you need to configure POP access window or message disposition behavior.

**Input schema:**
```json
{
  "type": "object",
  "title": "UpdatePopSettingsRequest",
  "properties": {
    "user_id": {
      "type": "string",
      "title": "User Id",
      "default": "me",
      "examples": [
        "me",
        "user@example.com"
      ],
      "description": "The user's email address. The special value 'me' can be used to indicate the authenticated user."
    },
    "disposition": {
      "enum": [
        "dispositionUnspecified",
        "leaveInInbox",
        "archive",
        "trash",
        "markRead"
      ],
      "type": "string",
      "title": "Disposition",
      "examples": [
        "leaveInInbox",
        "archive"
      ],
      "description": "The action that will be executed on a message after it has been fetched via POP."
    },
    "accessWindow": {
      "enum": [
        "accessWindowUnspecified",
        "disabled",
        "fromNowOn",
        "allMail"
      ],
      "type": "string",
      "title": "AccessWindow",
      "examples": [
        "allMail",
        "fromNowOn"
      ],
      "description": "The range of messages which are accessible via POP."
    }
  }
}
```

**Output schema:**
```json
{
  "type": "object",
  "$defs": {
    "UpdatePopSettingsResponse": {
      "type": "object",
      "title": "UpdatePopSettingsResponse",
      "properties": {
        "disposition": {
          "type": "string",
          "title": "Disposition",
          "description": "The action that will be executed on a message after it has been fetched via POP."
        },
        "accessWindow": {
          "type": "string",
          "title": "Access Window",
          "description": "The range of messages which are accessible via POP."
        }
      },
      "description": "POP settings for a Gmail account."
    }
  },
  "title": "UpdatePopSettingsResponseWrapper",
  "required": [
    "data",
    "successful"
  ],
  "properties": {
    "data": {
      "type": "object",
      "title": "Data",
      "properties": {
        "disposition": {
          "type": "string",
          "title": "Disposition",
          "description": "The action that will be executed on a message after it has been fetched via POP."
        },
        "accessWindow": {
          "type": "string",
          "title": "Access Window",
          "description": "The range of messages which are accessible via POP."
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

## GMAIL_UPDATE_SEND_AS
Tool to update a send-as alias for a Gmail user. Use when you need to modify display name, signature, reply-to address, or SMTP settings for a send-as email address. Gmail sanitizes HTML signatures before saving. Addresses other than the primary can only be updated by service accounts with domain-wide authority.

**Input schema:**
```json
{
  "type": "object",
  "title": "UpdateSendAsRequest",
  "required": [
    "send_as_email"
  ],
  "properties": {
    "user_id": {
      "type": "string",
      "title": "User Id",
      "default": "me",
      "examples": [
        "me",
        "user@example.com"
      ],
      "description": "The email address of the Gmail user whose send-as alias to update, or the special value 'me' to indicate the authenticated user."
    },
    "smtp_msa": {
      "type": "object",
      "title": "SmtpMsa",
      "required": [
        "host",
        "port",
        "securityMode"
      ],
      "properties": {
        "host": {
          "type": "string",
          "title": "Host",
          "description": "The hostname of the SMTP service. Required when configuring SMTP."
        },
        "port": {
          "type": "integer",
          "title": "Port",
          "description": "The port of the SMTP service. Required when configuring SMTP."
        },
        "password": {
          "type": "string",
          "title": "Password",
          "description": "SMTP authentication password. Write-only field, never appears in responses."
        },
        "username": {
          "type": "string",
          "title": "Username",
          "description": "SMTP authentication username. Write-only field, never appears in responses."
        },
        "securityMode": {
          "enum": [
            "securityModeUnspecified",
            "none",
            "ssl",
            "starttls"
          ],
          "type": "string",
          "title": "Security Mode",
          "description": "Protocol for securing SMTP communication. Required when configuring SMTP."
        }
      },
      "description": "SMTP relay configuration for the send-as alias.",
      "additionalProperties": false
    },
    "signature": {
      "type": "string",
      "title": "Signature",
      "description": "Optional HTML signature for messages composed with this alias in Gmail web UI. Gmail sanitizes HTML before saving. Only added to new emails."
    },
    "is_default": {
      "type": "boolean",
      "title": "Is Default",
      "description": "Set to true to make this the default 'From:' address for composing messages and vacation auto-replies. Setting true makes the previous default false. Only legal writable value is true."
    },
    "display_name": {
      "type": "string",
      "title": "Display Name",
      "description": "Name to appear in 'From:' header. For custom from addresses, Gmail populates with primary account name if empty. Admin restrictions may silently fail updates to primary login name."
    },
    "send_as_email": {
      "type": "string",
      "title": "Send As Email",
      "examples": [
        "alias@example.com",
        "partnerships@composio.dev"
      ],
      "description": "The send-as alias email address to update. This is the email address that appears in the 'From:' header."
    },
    "treat_as_alias": {
      "type": "boolean",
      "title": "Treat As Alias",
      "description": "Whether Gmail treats this address as an alias for the user's primary email. Only applies to custom from aliases."
    },
    "reply_to_address": {
      "type": "string",
      "title": "Reply To Address",
      "description": "Optional email address for 'Reply-To:' header. Gmail omits header if empty."
    }
  }
}
```

**Output schema:**
```json
{
  "type": "object",
  "$defs": {
    "SmtpMsa": {
      "type": "object",
      "title": "SmtpMsa",
      "required": [
        "host",
        "port",
        "securityMode"
      ],
      "properties": {
        "host": {
          "type": "string",
          "title": "Host",
          "description": "The hostname of the SMTP service. Required when configuring SMTP."
        },
        "port": {
          "type": "integer",
          "title": "Port",
          "description": "The port of the SMTP service. Required when configuring SMTP."
        },
        "password": {
          "type": "string",
          "title": "Password",
          "description": "SMTP authentication password. Write-only field, never appears in responses."
        },
        "username": {
          "type": "string",
          "title": "Username",
          "description": "SMTP authentication username. Write-only field, never appears in responses."
        },
        "securityMode": {
          "enum": [
            "securityModeUnspecified",
            "none",
            "ssl",
            "starttls"
          ],
          "type": "string",
          "title": "Security Mode",
          "description": "Protocol for securing SMTP communication. Required when configuring SMTP."
        }
      },
      "description": "SMTP relay configuration for the send-as alias."
    },
    "UpdateSendAsResponse": {
      "type": "object",
      "title": "UpdateSendAsResponse",
      "required": [
        "sendAsEmail"
      ],
      "properties": {
        "smtpMsa": {
          "type": "object",
          "title": "Smtp Msa",
          "required": [
            "host",
            "port",
            "securityMode"
          ],
          "properties": {
            "host": {
              "type": "string",
              "title": "Host",
              "description": "The hostname of the SMTP service. Required when configuring SMTP."
            },
            "port": {
              "type": "integer",
              "title": "Port",
              "description": "The port of the SMTP service. Required when configuring SMTP."
            },
            "password": {
              "type": "string",
              "title": "Password",
              "description": "SMTP authentication password. Write-only field, never appears in responses."
            },
            "username": {
              "type": "string",
              "title": "Username",
              "description": "SMTP authentication username. Write-only field, never appears in responses."
            },
            "securityMode": {
              "enum": [
                "securityModeUnspecified",
                "none",
                "ssl",
                "starttls"
              ],
              "type": "string",
              "title": "Security Mode",
              "description": "Protocol for securing SMTP communication. Required when configuring SMTP."
            }
          },
          "description": "SMTP relay configuration for sending mail through external SMTP server."
        },
        "isDefault": {
          "type": "boolean",
          "title": "Is Default",
          "description": "Whether selected as default 'From:' address."
        },
        "isPrimary": {
          "type": "boolean",
          "title": "Is Primary",
          "description": "Whether this is the primary login address. Read-only."
        },
        "signature": {
          "type": "string",
          "title": "Signature",
          "description": "Optional HTML signature for composed messages."
        },
        "displayName": {
          "type": "string",
          "title": "Display Name",
          "description": "Name shown in 'From:' header. Auto-populated for primary address if empty."
        },
        "sendAsEmail": {
          "type": "string",
          "title": "Send As Email",
          "description": "The email address that appears in the 'From:' header for mail sent using this alias."
        },
        "treatAsAlias": {
          "type": "boolean",
          "title": "Treat As Alias",
          "description": "Whether Gmail treats this as an alias for the primary address."
        },
        "replyToAddress": {
          "type": "string",
          "title": "Reply To Address",
          "description": "Optional email for 'Reply-To:' header."
        },
        "verificationStatus": {
          "enum": [
            "verificationStatusUnspecified",
            "accepted",
            "pending"
          ],
          "type": "string",
          "title": "Verification Status",
          "description": "Address verification status. Read-only."
        }
      },
      "description": "Updated send-as alias configuration."
    }
  },
  "title": "UpdateSendAsResponseWrapper",
  "required": [
    "data",
    "successful"
  ],
  "properties": {
    "data": {
      "type": "object",
      "title": "Data",
      "required": [
        "sendAsEmail"
      ],
      "properties": {
        "smtpMsa": {
          "type": "object",
          "title": "Smtp Msa",
          "required": [
            "host",
            "port",
            "securityMode"
          ],
          "properties": {
            "host": {
              "type": "string",
              "title": "Host",
              "description": "The hostname of the SMTP service. Required when configuring SMTP."
            },
            "port": {
              "type": "integer",
              "title": "Port",
              "description": "The port of the SMTP service. Required when configuring SMTP."
            },
            "password": {
              "type": "string",
              "title": "Password",
              "description": "SMTP authentication password. Write-only field, never appears in responses."
            },
            "username": {
              "type": "string",
              "title": "Username",
              "description": "SMTP authentication username. Write-only field, never appears in responses."
            },
            "securityMode": {
              "enum": [
                "securityModeUnspecified",
                "none",
                "ssl",
                "starttls"
              ],
              "type": "string",
              "title": "Security Mode",
              "description": "Protocol for securing SMTP communication. Required when configuring SMTP."
            }
          },
          "description": "SMTP relay configuration for sending mail through external SMTP server."
        },
        "isDefault": {
          "type": "boolean",
          "title": "Is Default",
          "description": "Whether selected as default 'From:' address."
        },
        "isPrimary": {
          "type": "boolean",
          "title": "Is Primary",
          "description": "Whether this is the primary login address. Read-only."
        },
        "signature": {
          "type": "string",
          "title": "Signature",
          "description": "Optional HTML signature for composed messages."
        },
        "displayName": {
          "type": "string",
          "title": "Display Name",
          "description": "Name shown in 'From:' header. Auto-populated for primary address if empty."
        },
        "sendAsEmail": {
          "type": "string",
          "title": "Send As Email",
          "description": "The email address that appears in the 'From:' header for mail sent using this alias."
        },
        "treatAsAlias": {
          "type": "boolean",
          "title": "Treat As Alias",
          "description": "Whether Gmail treats this as an alias for the primary address."
        },
        "replyToAddress": {
          "type": "string",
          "title": "Reply To Address",
          "description": "Optional email for 'Reply-To:' header."
        },
        "verificationStatus": {
          "enum": [
            "verificationStatusUnspecified",
            "accepted",
            "pending"
          ],
          "type": "string",
          "title": "Verification Status",
          "description": "Address verification status. Read-only."
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

## GMAIL_UPDATE_USER_ATTRIBUTES_VALUES
Update user attribute values for a resource. Use this action to set or update custom attributes for a user within an organization or project. When setting a value for an attribute key that also exists in SAML, the Sanity value will take precedence and shadow the SAML value.

**Input schema:**
```json
{
  "type": "object",
  "title": "SanityUpdateUserAttributesValuesRequest",
  "required": [
    "resourceType",
    "resourceId",
    "userId",
    "attributes"
  ],
  "properties": {
    "userId": {
      "type": "string",
      "title": "User Id",
      "examples": [
        "test-user-456"
      ],
      "description": "The unique identifier of the user whose attributes to update."
    },
    "attributes": {
      "type": "object",
      "title": "Attributes",
      "examples": [
        {
          "role": "developer",
          "department": "engineering"
        }
      ],
      "description": "A dictionary of attribute key-value pairs to set for the user. Values can be strings, numbers, booleans, arrays, or nested objects. These will shadow any SAML values for the same keys.",
      "additionalProperties": {}
    },
    "resourceId": {
      "type": "string",
      "title": "Resource Id",
      "examples": [
        "test-org-123"
      ],
      "description": "The unique identifier of the resource. For organizations, this is the organization ID."
    },
    "resourceType": {
      "enum": [
        "organization",
        "project"
      ],
      "type": "string",
      "title": "Resource Type",
      "examples": [
        "organization"
      ],
      "description": "The type of resource that scopes the user attributes (e.g., 'organization' or 'project')."
    }
  },
  "description": "Request model for updating user attribute values."
}
```

**Output schema:**
```json
{
  "type": "object",
  "$defs": {
    "JsonValue": {},
    "UserAttribute": {
      "type": "object",
      "title": "UserAttribute",
      "required": [
        "key",
        "type"
      ],
      "properties": {
        "key": {
          "type": "string",
          "title": "Key",
          "description": "The attribute key."
        },
        "type": {
          "type": "string",
          "title": "Type",
          "description": "The attribute type (e.g., 'string', 'integer', 'boolean')."
        },
        "values": {
          "type": "object",
          "title": "Values",
          "description": "The attribute values from different sources (e.g., {'sanity': 'value', 'saml': 'value'}).",
          "additionalProperties": {}
        },
        "activeValue": {
          "title": "Active Value",
          "description": "The active value for this attribute."
        },
        "activeSource": {
          "type": "string",
          "title": "Active Source",
          "description": "The active source for the attribute value ('sanity' or 'saml')."
        }
      },
      "description": "A user attribute with its values from different sources."
    },
    "SanityUpdateUserAttributesValuesResponse": {
      "type": "object",
      "title": "SanityUpdateUserAttributesValuesResponse",
      "required": [
        "sanityUserId",
        "organizationId"
      ],
      "properties": {
        "updatedAt": {
          "type": "string",
          "title": "Updated At",
          "description": "ISO 8601 timestamp of when the attributes were updated."
        },
        "attributes": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "UserAttribute",
            "required": [
              "key",
              "type"
            ],
            "properties": {
              "key": {
                "type": "string",
                "title": "Key",
                "description": "The attribute key."
              },
              "type": {
                "type": "string",
                "title": "Type",
                "description": "The attribute type (e.g., 'string', 'integer', 'boolean')."
              },
              "values": {
                "type": "object",
                "title": "Values",
                "description": "The attribute values from different sources (e.g., {'sanity': 'value', 'saml': 'value'}).",
                "additionalProperties": {}
              },
              "activeValue": {
                "title": "Active Value",
                "description": "The active value for this attribute."
              },
              "activeSource": {
                "type": "string",
                "title": "Active Source",
                "description": "The active source for the attribute value ('sanity' or 'saml')."
              }
            },
            "description": "A user attribute with its values from different sources."
          },
          "title": "Attributes",
          "description": "The updated list of user attributes."
        },
        "sanityUserId": {
          "type": "string",
          "title": "Sanity User Id",
          "description": "The Sanity user ID."
        },
        "organizationId": {
          "type": "string",
          "title": "Organization Id",
          "description": "The unique identifier of the organization."
        }
      },
      "description": "Response model for user attribute values update."
    }
  },
  "title": "SanityUpdateUserAttributesValuesResponseWrapper",
  "required": [
    "data",
    "successful"
  ],
  "properties": {
    "data": {
      "type": "object",
      "title": "Data",
      "required": [
        "sanityUserId",
        "organizationId"
      ],
      "properties": {
        "updatedAt": {
          "type": "string",
          "title": "Updated At",
          "description": "ISO 8601 timestamp of when the attributes were updated."
        },
        "attributes": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "UserAttribute",
            "required": [
              "key",
              "type"
            ],
            "properties": {
              "key": {
                "type": "string",
                "title": "Key",
                "description": "The attribute key."
              },
              "type": {
                "type": "string",
                "title": "Type",
                "description": "The attribute type (e.g., 'string', 'integer', 'boolean')."
              },
              "values": {
                "type": "object",
                "title": "Values",
                "description": "The attribute values from different sources (e.g., {'sanity': 'value', 'saml': 'value'}).",
                "additionalProperties": {}
              },
              "activeValue": {
                "title": "Active Value",
                "description": "The active value for this attribute."
              },
              "activeSource": {
                "type": "string",
                "title": "Active Source",
                "description": "The active source for the attribute value ('sanity' or 'saml')."
              }
            },
            "description": "A user attribute with its values from different sources."
          },
          "title": "Attributes",
          "description": "The updated list of user attributes."
        },
        "sanityUserId": {
          "type": "string",
          "title": "Sanity User Id",
          "description": "The Sanity user ID."
        },
        "organizationId": {
          "type": "string",
          "title": "Organization Id",
          "description": "The unique identifier of the organization."
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

## GMAIL_UPDATE_VACATION_SETTINGS
Tool to update vacation responder settings for a Gmail user. Use when you need to configure out-of-office auto-replies.

**Input schema:**
```json
{
  "type": "object",
  "title": "UpdateVacationSettingsRequest",
  "properties": {
    "endTime": {
      "type": "string",
      "title": "End Time",
      "description": "An optional end time for sending auto-replies (epoch ms). When this is specified, Gmail will automatically reply only to messages that it receives before the end time. If both startTime and endTime are specified, startTime must precede endTime."
    },
    "user_id": {
      "type": "string",
      "title": "User Id",
      "default": "me",
      "examples": [
        "me",
        "user@example.com"
      ],
      "description": "The user's email address. The special value 'me' can be used to indicate the authenticated user."
    },
    "startTime": {
      "type": "string",
      "title": "Start Time",
      "description": "An optional start time for sending auto-replies (epoch ms). When this is specified, Gmail will automatically reply only to messages that it receives after the start time. If both startTime and endTime are specified, startTime must precede endTime."
    },
    "enableAutoReply": {
      "type": "boolean",
      "title": "Enable Auto Reply",
      "description": "Flag that controls whether Gmail automatically replies to messages."
    },
    "responseSubject": {
      "type": "string",
      "title": "Response Subject",
      "description": "Optional text to prepend to the subject line in vacation responses. In order to enable auto-replies, either the response subject or the response body must be nonempty."
    },
    "responseBodyHtml": {
      "type": "string",
      "title": "Response Body Html",
      "description": "Response body in HTML format. Gmail will sanitize the HTML before storing it. If both response_body_plain_text and response_body_html are specified, response_body_html will be used."
    },
    "restrictToDomain": {
      "type": "boolean",
      "title": "Restrict To Domain",
      "description": "Flag that determines whether responses are sent to recipients who are outside of the user's domain. This feature is only available for Google Workspace users."
    },
    "restrictToContacts": {
      "type": "boolean",
      "title": "Restrict To Contacts",
      "description": "Flag that determines whether responses are sent to recipients who are not in the user's list of contacts."
    },
    "responseBodyPlainText": {
      "type": "string",
      "title": "Response Body Plain Text",
      "description": "Response body in plain text format. If both response_body_plain_text and response_body_html are specified, response_body_html will be used."
    }
  }
}
```

**Output schema:**
```json
{
  "type": "object",
  "$defs": {
    "UpdateVacationSettingsResponse": {
      "type": "object",
      "title": "UpdateVacationSettingsResponse",
      "properties": {
        "endTime": {
          "type": "string",
          "title": "End Time",
          "description": "An optional end time for sending auto-replies (epoch ms)."
        },
        "startTime": {
          "type": "string",
          "title": "Start Time",
          "description": "An optional start time for sending auto-replies (epoch ms)."
        },
        "enableAutoReply": {
          "type": "boolean",
          "title": "Enable Auto Reply",
          "description": "Flag that controls whether Gmail automatically replies to messages."
        },
        "responseSubject": {
          "type": "string",
          "title": "Response Subject",
          "description": "Optional text to prepend to the subject line in vacation responses."
        },
        "responseBodyHtml": {
          "type": "string",
          "title": "Response Body Html",
          "description": "Response body in HTML format."
        },
        "restrictToDomain": {
          "type": "boolean",
          "title": "Restrict To Domain",
          "description": "Flag that determines whether responses are sent to recipients who are outside of the user's domain."
        },
        "restrictToContacts": {
          "type": "boolean",
          "title": "Restrict To Contacts",
          "description": "Flag that determines whether responses are sent to recipients who are not in the user's list of contacts."
        },
        "responseBodyPlainText": {
          "type": "string",
          "title": "Response Body Plain Text",
          "description": "Response body in plain text format."
        }
      },
      "description": "The updated vacation responder settings for the account."
    }
  },
  "title": "UpdateVacationSettingsResponseWrapper",
  "required": [
    "data",
    "successful"
  ],
  "properties": {
    "data": {
      "type": "object",
      "title": "Data",
      "properties": {
        "endTime": {
          "type": "string",
          "title": "End Time",
          "description": "An optional end time for sending auto-replies (epoch ms)."
        },
        "startTime": {
          "type": "string",
          "title": "Start Time",
          "description": "An optional start time for sending auto-replies (epoch ms)."
        },
        "enableAutoReply": {
          "type": "boolean",
          "title": "Enable Auto Reply",
          "description": "Flag that controls whether Gmail automatically replies to messages."
        },
        "responseSubject": {
          "type": "string",
          "title": "Response Subject",
          "description": "Optional text to prepend to the subject line in vacation responses."
        },
        "responseBodyHtml": {
          "type": "string",
          "title": "Response Body Html",
          "description": "Response body in HTML format."
        },
        "restrictToDomain": {
          "type": "boolean",
          "title": "Restrict To Domain",
          "description": "Flag that determines whether responses are sent to recipients who are outside of the user's domain."
        },
        "restrictToContacts": {
          "type": "boolean",
          "title": "Restrict To Contacts",
          "description": "Flag that determines whether responses are sent to recipients who are not in the user's list of contacts."
        },
        "responseBodyPlainText": {
          "type": "string",
          "title": "Response Body Plain Text",
          "description": "Response body in plain text format."
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
