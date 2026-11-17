# share_point

## SHARE_POINT_ADD_ATTACHMENT_TO_LIST_ITEM
Tool to add an attachment to a SharePoint list item. Use when you need to upload a binary file as an attachment to a specified list item.

**Input schema:**
```json
{
  "type": "object",
  "title": "AddAttachmentToListItemRequest",
  "required": [
    "list_title",
    "item_id",
    "file_name"
  ],
  "properties": {
    "item_id": {
      "type": "integer",
      "title": "Item Id",
      "minimum": 0,
      "examples": [
        1
      ],
      "description": "ID of the list item to which the file will be attached."
    },
    "file_name": {
      "type": "string",
      "title": "File Name",
      "examples": [
        "example.pdf"
      ],
      "description": "Name to assign to the attachment file in SharePoint."
    },
    "site_name": {
      "type": "string",
      "title": "Site Name",
      "description": "The subsite name to scope the request to (e.g., 'composio-test'). If omitted, the root site is used. When provided, the API base URL becomes https://{tenant}.sharepoint.com/sites/{site}."
    },
    "list_title": {
      "type": "string",
      "title": "List Title",
      "examples": [
        "Announcements"
      ],
      "description": "The display title of the SharePoint list containing the target item."
    },
    "content_text": {
      "type": "string",
      "title": "Content Text",
      "description": "Optional raw text content to upload (UTF-8 encoded). Use when not passing file_content."
    },
    "file_content": {
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
      "description": "File to attach. Alternatively, omit this and provide either 'content_text' for UTF-8 text or 'content_base64' for arbitrary bytes.",
      "file_uploadable": true,
      "additionalProperties": false
    },
    "content_base64": {
      "type": "string",
      "title": "Content Base64",
      "description": "Optional base64-encoded bytes to upload. Use for binary content when not passing file_content."
    }
  },
  "additionalProperties": false
}
```

**Output schema:**
```json
{
  "type": "object",
  "$defs": {
    "AddAttachmentToListItemResponse": {
      "type": "object",
      "title": "AddAttachmentToListItemResponse",
      "required": [
        "FileName",
        "ServerRelativeUrl"
      ],
      "properties": {
        "FileName": {
          "type": "string",
          "title": "File Name",
          "description": "Name of the attached file"
        },
        "FileNameAsPath": {
          "type": "object",
          "title": "File Name As Path",
          "description": "File name as path object with DecodedUrl",
          "additionalProperties": true
        },
        "ServerRelativeUrl": {
          "type": "string",
          "title": "Server Relative Url",
          "description": "Server-relative URL of the attachment (e.g., '/Lists/MyList/Attachments/1/file.pdf')"
        },
        "ServerRelativePath": {
          "type": "object",
          "title": "Server Relative Path",
          "description": "Server-relative path object with DecodedUrl",
          "additionalProperties": true
        }
      }
    }
  },
  "title": "AddAttachmentToListItemResponseWrapper",
  "required": [
    "data",
    "successful"
  ],
  "properties": {
    "data": {
      "type": "object",
      "title": "Data",
      "required": [
        "FileName",
        "ServerRelativeUrl"
      ],
      "properties": {
        "FileName": {
          "type": "string",
          "title": "File Name",
          "description": "Name of the attached file"
        },
        "FileNameAsPath": {
          "type": "object",
          "title": "File Name As Path",
          "description": "File name as path object with DecodedUrl",
          "additionalProperties": true
        },
        "ServerRelativeUrl": {
          "type": "string",
          "title": "Server Relative Url",
          "description": "Server-relative URL of the attachment (e.g., '/Lists/MyList/Attachments/1/file.pdf')"
        },
        "ServerRelativePath": {
          "type": "object",
          "title": "Server Relative Path",
          "description": "Server-relative path object with DecodedUrl",
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

## SHARE_POINT_ADD_FIELD_LINK_TO_CONTENT_TYPE
Tool to add a field link to a list content type. Use when you want to associate an existing list field with a content type.

**Input schema:**
```json
{
  "type": "object",
  "title": "AddFieldLinkToContentTypeRequest",
  "required": [
    "listid",
    "contenttypeid",
    "field_internal_name"
  ],
  "properties": {
    "hidden": {
      "type": "boolean",
      "title": "Hidden",
      "default": false,
      "description": "Whether the field link should be hidden in forms. Defaults to False."
    },
    "listid": {
      "type": "string",
      "title": "Listid",
      "examples": [
        "01234567-89ab-cdef-0123-456789abcdef"
      ],
      "description": "GUID of the SharePoint list in canonical format, e.g., '01234567-89ab-cdef-0123-456789abcdef'."
    },
    "required": {
      "type": "boolean",
      "title": "Required",
      "default": false,
      "description": "Whether the field link should be required. Defaults to False."
    },
    "site_name": {
      "type": "string",
      "title": "Site Name",
      "examples": [
        "composio-test"
      ],
      "description": "The subsite name to scope the request to (e.g., 'composio-test'). If omitted, the root site is used. When provided, the API base URL becomes https://{tenant}.sharepoint.com/sites/{site}."
    },
    "contenttypeid": {
      "type": "string",
      "title": "Contenttypeid",
      "examples": [
        "0x0100CC8BDE8AF72FC745A823106B7E8CD1FF"
      ],
      "description": "The content type ID (StringValue) within the list, e.g., '0x0100CC8BDE8AF72FC745A823106B7E8CD1FF'."
    },
    "field_internal_name": {
      "type": "string",
      "title": "Field Internal Name",
      "description": "The internal name of the existing field to link (e.g., 'Title')."
    }
  },
  "description": "Request parameters for adding a field link to a list content type."
}
```

**Output schema:**
```json
{
  "type": "object",
  "$defs": {
    "FieldLink": {
      "type": "object",
      "title": "FieldLink",
      "required": [
        "FieldInternalName",
        "Hidden",
        "Id",
        "Name",
        "Required"
      ],
      "properties": {
        "Id": {
          "type": "string",
          "title": "Id",
          "description": "The GUID of the field."
        },
        "Name": {
          "type": "string",
          "title": "Name",
          "description": "The display name of the field."
        },
        "Hidden": {
          "type": "boolean",
          "title": "Hidden",
          "description": "Whether the field link is hidden in forms."
        },
        "Required": {
          "type": "boolean",
          "title": "Required",
          "description": "Whether the field is required."
        },
        "FieldInternalName": {
          "type": "string",
          "title": "Field Internal Name",
          "description": "The internal name of the field linked to the content type."
        }
      },
      "description": "Represents a FieldLink in SharePoint."
    },
    "AddFieldLinkToContentTypeResponse": {
      "type": "object",
      "title": "AddFieldLinkToContentTypeResponse",
      "required": [
        "field_link"
      ],
      "properties": {
        "field_link": {
          "type": "object",
          "title": "Field Link",
          "required": [
            "FieldInternalName",
            "Hidden",
            "Id",
            "Name",
            "Required"
          ],
          "properties": {
            "Id": {
              "type": "string",
              "title": "Id",
              "description": "The GUID of the field."
            },
            "Name": {
              "type": "string",
              "title": "Name",
              "description": "The display name of the field."
            },
            "Hidden": {
              "type": "boolean",
              "title": "Hidden",
              "description": "Whether the field link is hidden in forms."
            },
            "Required": {
              "type": "boolean",
              "title": "Required",
              "description": "Whether the field is required."
            },
            "FieldInternalName": {
              "type": "string",
              "title": "Field Internal Name",
              "description": "The internal name of the field linked to the content type."
            }
          },
          "description": "The FieldLink object created by SharePoint."
        }
      },
      "description": "Response model for the created FieldLink object."
    }
  },
  "title": "AddFieldLinkToContentTypeResponseWrapper",
  "required": [
    "data",
    "successful"
  ],
  "properties": {
    "data": {
      "type": "object",
      "title": "Data",
      "required": [
        "field_link"
      ],
      "properties": {
        "field_link": {
          "type": "object",
          "title": "Field Link",
          "required": [
            "FieldInternalName",
            "Hidden",
            "Id",
            "Name",
            "Required"
          ],
          "properties": {
            "Id": {
              "type": "string",
              "title": "Id",
              "description": "The GUID of the field."
            },
            "Name": {
              "type": "string",
              "title": "Name",
              "description": "The display name of the field."
            },
            "Hidden": {
              "type": "boolean",
              "title": "Hidden",
              "description": "Whether the field link is hidden in forms."
            },
            "Required": {
              "type": "boolean",
              "title": "Required",
              "description": "Whether the field is required."
            },
            "FieldInternalName": {
              "type": "string",
              "title": "Field Internal Name",
              "description": "The internal name of the field linked to the content type."
            }
          },
          "description": "The FieldLink object created by SharePoint."
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

## SHARE_POINT_ADD_ROLE_ASSIGNMENT_TO_ITEM
Tool to add a role assignment to a list item. Use when granting specific permissions to a user or group after breaking inheritance if needed. This action is externally visible and permanently alters item permissions; obtain explicit human approval for the target item and `role_definition_id` before executing.

**Input schema:**
```json
{
  "type": "object",
  "title": "AddRoleAssignmentToItemRequest",
  "required": [
    "list_title",
    "item_id",
    "principal_id",
    "role_definition_id"
  ],
  "properties": {
    "item_id": {
      "type": "integer",
      "title": "Item Id",
      "minimum": 1,
      "examples": [
        1
      ],
      "description": "ID of the list item to which to add the role assignment."
    },
    "site_name": {
      "type": "string",
      "title": "Site Name",
      "examples": [
        "composio-test"
      ],
      "description": "The subsite name to scope the request to (e.g., 'composio-test'). If omitted, the root site is used. When provided, the API base URL becomes https://{tenant}.sharepoint.com/sites/{site}."
    },
    "list_title": {
      "type": "string",
      "title": "List Title",
      "examples": [
        "My Documents"
      ],
      "description": "Title of the SharePoint list containing the target item. Must exactly match the list's display name."
    },
    "principal_id": {
      "type": "integer",
      "title": "Principal Id",
      "minimum": 1,
      "examples": [
        15
      ],
      "description": "ID of the user or group to grant permissions."
    },
    "role_definition_id": {
      "type": "integer",
      "title": "Role Definition Id",
      "minimum": 1,
      "examples": [
        1073741827
      ],
      "description": "ID of the permission level (role definition) to assign."
    }
  },
  "additionalProperties": false
}
```

**Output schema:**
```json
{
  "type": "object",
  "$defs": {
    "AddRoleAssignmentToItemResponse": {
      "type": "object",
      "title": "AddRoleAssignmentToItemResponse",
      "required": [
        "message",
        "list_title",
        "item_id",
        "principal_id",
        "role_definition_id"
      ],
      "properties": {
        "item_id": {
          "type": "integer",
          "title": "Item Id",
          "description": "ID of the list item that was updated."
        },
        "message": {
          "type": "string",
          "title": "Message",
          "description": "Success message indicating the role assignment was added."
        },
        "list_title": {
          "type": "string",
          "title": "List Title",
          "description": "Title of the list where the permission was granted."
        },
        "principal_id": {
          "type": "integer",
          "title": "Principal Id",
          "description": "ID of the user or group granted permission."
        },
        "role_definition_id": {
          "type": "integer",
          "title": "Role Definition Id",
          "description": "ID of the permission level assigned."
        }
      }
    }
  },
  "title": "AddRoleAssignmentToItemResponseWrapper",
  "required": [
    "data",
    "successful"
  ],
  "properties": {
    "data": {
      "type": "object",
      "title": "Data",
      "required": [
        "message",
        "list_title",
        "item_id",
        "principal_id",
        "role_definition_id"
      ],
      "properties": {
        "item_id": {
          "type": "integer",
          "title": "Item Id",
          "description": "ID of the list item that was updated."
        },
        "message": {
          "type": "string",
          "title": "Message",
          "description": "Success message indicating the role assignment was added."
        },
        "list_title": {
          "type": "string",
          "title": "List Title",
          "description": "Title of the list where the permission was granted."
        },
        "principal_id": {
          "type": "integer",
          "title": "Principal Id",
          "description": "ID of the user or group granted permission."
        },
        "role_definition_id": {
          "type": "integer",
          "title": "Role Definition Id",
          "description": "ID of the permission level assigned."
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

## SHARE_POINT_ADD_ROLE_ASSIGNMENT_TO_LIST
Tool to add a role assignment to a SharePoint list. Requires the list to have broken role inheritance first via SHARE_POINT_BREAK_ROLE_INHERITANCE_ON_LIST; inheriting lists will reject unique role assignments. Use when granting permissions to a user or group on a specific list.

**Input schema:**
```json
{
  "type": "object",
  "title": "AddRoleAssignmentToListRequest",
  "required": [
    "list_title",
    "principal_id",
    "role_definition_id"
  ],
  "properties": {
    "site_name": {
      "type": "string",
      "title": "Site Name",
      "description": "The subsite name to scope the request to (e.g., 'composio-test'). If omitted, the root site is used. When provided, the API base URL becomes https://{tenant}.sharepoint.com/sites/{site}.",
      "human_parameter_name": "Site",
      "human_parameter_description": "Optional subsite name to scope the request to a specific subsite."
    },
    "list_title": {
      "type": "string",
      "title": "List Title",
      "minLength": 1,
      "description": "The title of the SharePoint list to grant permissions on.",
      "human_parameter_name": "List Title",
      "human_parameter_description": "Enter the exact title of the list where you want to assign the role."
    },
    "principal_id": {
      "type": "integer",
      "title": "Principal Id",
      "minimum": 1,
      "description": "The ID of the user or group principal to which the role will be assigned. Must be a site-collection-registered ID; use the Id returned by SHARE_POINT_ENSURE_USER to avoid invalid-principal errors.",
      "human_parameter_name": "Principal ID",
      "human_parameter_description": "The SharePoint ID of the user or group that is receiving the permission."
    },
    "role_definition_id": {
      "type": "integer",
      "title": "Role Definition Id",
      "minimum": 1,
      "description": "The ID of the role definition to assign (e.g., 1073741827 for Contribute).",
      "human_parameter_name": "Role Definition ID",
      "human_parameter_description": "The SharePoint role definition ID representing the permission level (e.g., 1073741827)."
    }
  }
}
```

**Output schema:**
```json
{
  "type": "object",
  "$defs": {
    "AddRoleAssignmentToListResponse": {
      "type": "object",
      "title": "AddRoleAssignmentToListResponse",
      "required": [
        "success",
        "status_code"
      ],
      "properties": {
        "success": {
          "type": "boolean",
          "title": "Success",
          "description": "Indicates if the role assignment was added successfully."
        },
        "status_code": {
          "type": "integer",
          "title": "Status Code",
          "description": "HTTP status code returned by the SharePoint API."
        }
      }
    }
  },
  "title": "AddRoleAssignmentToListResponseWrapper",
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
        "status_code"
      ],
      "properties": {
        "success": {
          "type": "boolean",
          "title": "Success",
          "description": "Indicates if the role assignment was added successfully."
        },
        "status_code": {
          "type": "integer",
          "title": "Status Code",
          "description": "HTTP status code returned by the SharePoint API."
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

## SHARE_POINT_BREAK_ROLE_INHERITANCE_ON_ITEM
Tool to break permission inheritance on a list item. Call this before adding new role assignments; adding assignments prior leaves the item still inheriting parent permissions, causing unexpected access behavior. Use when you need to uniquely set permissions on an item after copying or clearing parent assignments.

**Input schema:**
```json
{
  "type": "object",
  "title": "BreakRoleInheritanceOnItemRequest",
  "required": [
    "list_title",
    "item_id"
  ],
  "properties": {
    "item_id": {
      "type": "integer",
      "title": "Item Id",
      "description": "ID of the list item whose permissions inheritance will be broken",
      "human_parameter_name": "Item ID",
      "human_parameter_description": "The numeric ID of the list item whose permission inheritance you want to break."
    },
    "site_name": {
      "type": "string",
      "title": "Site Name",
      "description": "The subsite name to scope the request to (e.g., 'composio-test'). If omitted, the root site is used. When provided, the API base URL becomes https://{tenant}.sharepoint.com/sites/{site}.",
      "human_parameter_name": "Site",
      "human_parameter_description": "Optional subsite name. Leave empty for root site, or specify a subsite name like 'composio-test' to scope the operation to that subsite."
    },
    "list_title": {
      "type": "string",
      "title": "List Title",
      "description": "Title of the list containing the item Must be the exact display name as shown in SharePoint UI, not the URL segment or internal name.",
      "human_parameter_name": "List Title",
      "human_parameter_description": "The exact title of the SharePoint list that contains the item whose permissions inheritance you want to break."
    },
    "clear_subscopes": {
      "type": "boolean",
      "title": "Clear Subscopes",
      "default": false,
      "description": "Whether to clear unique permissions on any child scopes of the item",
      "human_parameter_name": "Clear Subscopes",
      "human_parameter_description": "Set to true to clear unique permissions on child securable objects so they inherit from this item."
    },
    "copy_role_assignments": {
      "type": "boolean",
      "title": "Copy Role Assignments",
      "default": true,
      "description": "Whether to copy existing parent role assignments to the item before breaking inheritance",
      "human_parameter_name": "Copy Role Assignments",
      "human_parameter_description": "Set to true to copy existing parent permissions to the item before breaking inheritance. Defaults to true as this is the most common scenario."
    }
  }
}
```

**Output schema:**
```json
{
  "type": "object",
  "$defs": {
    "BreakRoleInheritanceOnItemResponse": {
      "type": "object",
      "title": "BreakRoleInheritanceOnItemResponse",
      "required": [
        "message"
      ],
      "properties": {
        "message": {
          "type": "string",
          "title": "Message",
          "description": "Result message indicating success of breaking inheritance"
        }
      }
    }
  },
  "title": "BreakRoleInheritanceOnItemResponseWrapper",
  "required": [
    "data",
    "successful"
  ],
  "properties": {
    "data": {
      "type": "object",
      "title": "Data",
      "required": [
        "message"
      ],
      "properties": {
        "message": {
          "type": "string",
          "title": "Message",
          "description": "Result message indicating success of breaking inheritance"
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

## SHARE_POINT_BREAK_ROLE_INHERITANCE_ON_LIST
Breaks permission inheritance on a SharePoint list, allowing you to set unique permissions. When you break inheritance, you can choose to: - Copy parent permissions as a starting point (copy_role_assignments=true) - Start fresh with no inherited permissions (copy_role_assignments=false) - Clear unique permissions on child items to re-inherit from this list (clear_subscopes=true) Use this when you need to manage list-level permissions independently from the site. Must be called before SHARE_POINT_ADD_ROLE_ASSIGNMENT_TO_LIST, which fails on lists still inheriting from the parent site.

**Input schema:**
```json
{
  "type": "object",
  "title": "BreakRoleInheritanceOnListRequest",
  "required": [
    "list_title",
    "copy_role_assignments",
    "clear_subscopes"
  ],
  "properties": {
    "site_name": {
      "type": "string",
      "title": "Site Name",
      "description": "The subsite name to scope the request to (e.g., 'composio-test'). If omitted, the root site is used. When provided, the API base URL becomes https://{tenant}.sharepoint.com/sites/{site}.",
      "human_parameter_name": "Site",
      "human_parameter_description": "Enter the subsite name if you want to break role inheritance on a list in a subsite. Leave empty to use the root site."
    },
    "list_title": {
      "type": "string",
      "title": "List Title",
      "description": "The title of the SharePoint list to break permission inheritance on.",
      "human_parameter_name": "List Title",
      "human_parameter_description": "Enter the exact title of the SharePoint list where permission inheritance should be broken."
    },
    "clear_subscopes": {
      "type": "boolean",
      "title": "Clear Subscopes",
      "description": "Whether to reset unique permissions on child items (folders, documents) to inherit from this list. Set true to remove all item-level custom permissions and force inheritance from the list. Set false to preserve existing item-level unique permissions.",
      "human_parameter_name": "Clear Subscopes",
      "human_parameter_description": "Choose whether to reset item-level permissions to inherit from this list. True = remove item-level custom permissions and force inheritance from list. False = keep existing item-level unique permissions."
    },
    "copy_role_assignments": {
      "type": "boolean",
      "title": "Copy Role Assignments",
      "description": "Whether to copy parent permissions when breaking inheritance. Set true to start with a copy of the parent site's permissions (recommended for most cases). Set false to start with empty permissions where only the current user has access.",
      "human_parameter_name": "Copy Role Assignments",
      "human_parameter_description": "Choose whether to copy the parent site's permissions to this list. True = copy parent permissions as starting point (recommended). False = start with empty permissions (current user only)."
    }
  }
}
```

**Output schema:**
```json
{
  "type": "object",
  "$defs": {
    "BreakRoleInheritanceOnListResponse": {
      "type": "object",
      "title": "BreakRoleInheritanceOnListResponse",
      "required": [
        "message"
      ],
      "properties": {
        "message": {
          "type": "string",
          "title": "Message",
          "description": "Success message indicating the permission inheritance was broken successfully."
        }
      }
    }
  },
  "title": "BreakRoleInheritanceOnListResponseWrapper",
  "required": [
    "data",
    "successful"
  ],
  "properties": {
    "data": {
      "type": "object",
      "title": "Data",
      "required": [
        "message"
      ],
      "properties": {
        "message": {
          "type": "string",
          "title": "Message",
          "description": "Success message indicating the permission inheritance was broken successfully."
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

## SHARE_POINT_CHECK_IN_FILE
Tool to check in a file. Use after uploading or editing a document and you're ready to finalize changes.

**Input schema:**
```json
{
  "type": "object",
  "title": "CheckInFileRequest",
  "required": [
    "server_relative_path"
  ],
  "properties": {
    "comment": {
      "type": "string",
      "title": "Comment",
      "default": "",
      "examples": [
        "Initial check-in",
        "Updated document",
        ""
      ],
      "description": "Check-in comment to describe this version of the file. Defaults to empty string if not provided."
    },
    "site_name": {
      "type": "string",
      "title": "Site Name",
      "examples": [
        "composio-test",
        "team-site"
      ],
      "description": "The subsite name to scope the request to (e.g., 'composio-test'). If omitted, the root site is used. When provided, the API base URL becomes https://{tenant}.sharepoint.com/sites/{site}."
    },
    "checkintype": {
      "enum": [
        0,
        1,
        2
      ],
      "type": "integer",
      "title": "Checkintype",
      "default": 1,
      "examples": [
        0,
        1,
        2
      ],
      "description": "Check-in type: 0=MinorCheckIn (draft/minor version), 1=MajorCheckIn (published/major version), 2=OverwriteCheckIn (overwrite current version without creating new version). Defaults to 1 (Major version)."
    },
    "server_relative_path": {
      "type": "string",
      "title": "Server Relative Path",
      "examples": [
        "/Shared Documents/example.docx"
      ],
      "description": "Server-relative URL of the file to check in, including library and folders. E.g., '/Shared Documents/example.docx'."
    }
  }
}
```

**Output schema:**
```json
{
  "type": "object",
  "$defs": {
    "CheckInFileResponse": {
      "type": "object",
      "title": "CheckInFileResponse",
      "required": [
        "status",
        "message",
        "server_relative_path"
      ],
      "properties": {
        "status": {
          "type": "integer",
          "title": "Status",
          "description": "HTTP status code returned by SharePoint for the check-in operation. 200 or 204 indicates success."
        },
        "message": {
          "type": "string",
          "title": "Message",
          "description": "Success message confirming the file has been checked in."
        },
        "server_relative_path": {
          "type": "string",
          "title": "Server Relative Path",
          "description": "Server-relative path of the checked-in file."
        }
      }
    }
  },
  "title": "CheckInFileResponseWrapper",
  "required": [
    "data",
    "successful"
  ],
  "properties": {
    "data": {
      "type": "object",
      "title": "Data",
      "required": [
        "status",
        "message",
        "server_relative_path"
      ],
      "properties": {
        "status": {
          "type": "integer",
          "title": "Status",
          "description": "HTTP status code returned by SharePoint for the check-in operation. 200 or 204 indicates success."
        },
        "message": {
          "type": "string",
          "title": "Message",
          "description": "Success message confirming the file has been checked in."
        },
        "server_relative_path": {
          "type": "string",
          "title": "Server Relative Path",
          "description": "Server-relative path of the checked-in file."
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

## SHARE_POINT_CREATE_CONTENT_TYPE
Tool to create a new content type in SharePoint. Use when you need to define a custom content type with specific metadata structure for lists or libraries.

**Input schema:**
```json
{
  "type": "object",
  "title": "CreateContentTypeRequest",
  "required": [
    "name"
  ],
  "properties": {
    "id": {
      "type": "object",
      "title": "ContentTypeIdValue",
      "required": [
        "StringValue"
      ],
      "properties": {
        "StringValue": {
          "type": "string",
          "title": "String Value",
          "description": "String representation of the content type ID, e.g., '0x0101009189AB5D3D2647B580F011DA0AC70139'. Must be a valid SharePoint content type ID format."
        }
      },
      "description": "Model for the content type ID value object.",
      "additionalProperties": false
    },
    "name": {
      "type": "string",
      "title": "Name",
      "examples": [
        "TestContentType2",
        "Custom Document Type"
      ],
      "description": "The name of the content type to create."
    },
    "group": {
      "type": "string",
      "title": "Group",
      "examples": [
        "Custom Content Types",
        "Document Content Types"
      ],
      "description": "The group category for the content type, e.g., 'Custom Content Types', 'Document Content Types'."
    },
    "site_name": {
      "type": "string",
      "title": "Site Name",
      "examples": [
        "composio-test",
        "Finance",
        "HR"
      ],
      "description": "The subsite name to scope the request to (e.g., 'composio-test'). If omitted, the root site is used. When provided, the API base URL becomes https://{tenant}.sharepoint.com/sites/{site}."
    },
    "description": {
      "type": "string",
      "title": "Description",
      "examples": [
        "Another test content type",
        "Custom content type for documents"
      ],
      "description": "Description of the content type. Provides context about the purpose and usage of this content type."
    }
  },
  "description": "Request model for creating a new content type in SharePoint."
}
```

**Output schema:**
```json
{
  "type": "object",
  "$defs": {
    "CreatedContentTypeId": {
      "type": "object",
      "title": "CreatedContentTypeId",
      "required": [
        "StringValue"
      ],
      "properties": {
        "StringValue": {
          "type": "string",
          "title": "String Value",
          "description": "String representation of the created content type ID."
        }
      },
      "description": "Model for the created content type ID object in response."
    },
    "CreateContentTypeResponse": {
      "type": "object",
      "title": "CreateContentTypeResponse",
      "required": [
        "Id",
        "Name"
      ],
      "properties": {
        "Id": {
          "type": "object",
          "title": "Id",
          "required": [
            "StringValue"
          ],
          "properties": {
            "StringValue": {
              "type": "string",
              "title": "String Value",
              "description": "String representation of the created content type ID."
            }
          },
          "description": "The ID object of the created content type."
        },
        "Name": {
          "type": "string",
          "title": "Name",
          "description": "The name of the created content type."
        },
        "Group": {
          "type": "string",
          "title": "Group",
          "description": "The group category of the created content type."
        },
        "Hidden": {
          "type": "boolean",
          "title": "Hidden",
          "description": "Whether the content type is hidden from the user interface."
        },
        "Sealed": {
          "type": "boolean",
          "title": "Sealed",
          "description": "Whether the content type is sealed and cannot be customized."
        },
        "ReadOnly": {
          "type": "boolean",
          "title": "Read Only",
          "description": "Whether the content type is read-only."
        },
        "StringId": {
          "type": "string",
          "title": "String Id",
          "description": "String representation of the content type ID (convenience field)."
        },
        "Description": {
          "type": "string",
          "title": "Description",
          "description": "The description of the created content type."
        }
      },
      "description": "Response model for the created content type."
    }
  },
  "title": "CreateContentTypeResponseWrapper",
  "required": [
    "data",
    "successful"
  ],
  "properties": {
    "data": {
      "type": "object",
      "title": "Data",
      "required": [
        "Id",
        "Name"
      ],
      "properties": {
        "Id": {
          "type": "object",
          "title": "Id",
          "required": [
            "StringValue"
          ],
          "properties": {
            "StringValue": {
              "type": "string",
              "title": "String Value",
              "description": "String representation of the created content type ID."
            }
          },
          "description": "The ID object of the created content type."
        },
        "Name": {
          "type": "string",
          "title": "Name",
          "description": "The name of the created content type."
        },
        "Group": {
          "type": "string",
          "title": "Group",
          "description": "The group category of the created content type."
        },
        "Hidden": {
          "type": "boolean",
          "title": "Hidden",
          "description": "Whether the content type is hidden from the user interface."
        },
        "Sealed": {
          "type": "boolean",
          "title": "Sealed",
          "description": "Whether the content type is sealed and cannot be customized."
        },
        "ReadOnly": {
          "type": "boolean",
          "title": "Read Only",
          "description": "Whether the content type is read-only."
        },
        "StringId": {
          "type": "string",
          "title": "String Id",
          "description": "String representation of the content type ID (convenience field)."
        },
        "Description": {
          "type": "string",
          "title": "Description",
          "description": "The description of the created content type."
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

## SHARE_POINT_CREATE_DRIVE_ITEM_SHARING_LINK
Tool to create a sharing link for a drive item in SharePoint or OneDrive. Use when you need to generate a shareable link with specific permissions (view/edit/embed) and scope (anonymous/organization/users). The link can optionally include password protection and expiration date.

**Input schema:**
```json
{
  "type": "object",
  "title": "CreateDriveItemSharingLinkRequest",
  "required": [
    "drive_id",
    "driveItem_id",
    "type"
  ],
  "properties": {
    "type": {
      "enum": [
        "view",
        "edit",
        "embed"
      ],
      "type": "string",
      "title": "Type",
      "description": "The type of sharing link to create. 'view' creates read-only access, 'edit' creates read-write access, 'embed' creates embeddable link (OneDrive Personal only)."
    },
    "scope": {
      "enum": [
        "anonymous",
        "organization",
        "users"
      ],
      "type": "string",
      "title": "LinkScope",
      "description": "Scope of the sharing link."
    },
    "drive_id": {
      "type": "string",
      "title": "Drive Id",
      "examples": [
        "b!sAYRj4psj0qqpjB3OOHdglZBMF5Nk0xPnR4Fc4pfinI7DA8OPuKvSo4igDo7VyMV"
      ],
      "description": "The unique identifier of the drive containing the item."
    },
    "password": {
      "type": "string",
      "title": "Password",
      "description": "The password for the sharing link. Optional and OneDrive Personal only."
    },
    "driveItem_id": {
      "type": "string",
      "title": "Drive Item Id",
      "examples": [
        "01K67O4VQJ6LBMI64JF5FLHHIQ4OJP45SP"
      ],
      "description": "The unique identifier of the drive item to create a link for."
    },
    "expirationDateTime": {
      "type": "string",
      "title": "Expiration Date Time",
      "examples": [
        "2024-12-31T23:59:59Z"
      ],
      "description": "The expiration time of the sharing link in ISO 8601 format (yyyy-MM-ddTHH:mm:ssZ). If not specified, the link does not expire unless a default expiration policy is enforced."
    },
    "retainInheritedPermissions": {
      "type": "boolean",
      "title": "Retain Inherited Permissions",
      "description": "If true (default), any existing inherited permissions are retained on the shared item. If false, all existing permissions are removed when sharing for the first time."
    }
  },
  "description": "Request model for creating a sharing link for a drive item."
}
```

**Output schema:**
```json
{
  "type": "object",
  "$defs": {
    "SharingLink": {
      "type": "object",
      "title": "SharingLink",
      "properties": {
        "type": {
          "type": "string",
          "title": "Type",
          "description": "The type of the link (view, edit, or embed)"
        },
        "scope": {
          "type": "string",
          "title": "Scope",
          "description": "The scope of the link (anonymous, organization, or users)"
        },
        "webUrl": {
          "type": "string",
          "title": "Web Url",
          "description": "A URL that opens the item in the browser"
        },
        "webHtml": {
          "type": "string",
          "title": "Web Html",
          "description": "For embed links, the HTML code for an iframe element to embed the item"
        },
        "application": {
          "type": "object",
          "title": "Application",
          "properties": {
            "id": {
              "type": "string",
              "title": "Id",
              "description": "The unique identifier"
            },
            "displayName": {
              "type": "string",
              "title": "Display Name",
              "description": "The display name"
            }
          },
          "description": "The app the link is associated with"
        },
        "preventsDownload": {
          "type": "boolean",
          "title": "Prevents Download",
          "description": "If true, the user can only view the item on the web and cannot download contents"
        }
      },
      "description": "Information about the sharing link."
    },
    "IdentityInfo": {
      "type": "object",
      "title": "IdentityInfo",
      "properties": {
        "id": {
          "type": "string",
          "title": "Id",
          "description": "The unique identifier"
        },
        "displayName": {
          "type": "string",
          "title": "Display Name",
          "description": "The display name"
        }
      },
      "description": "Identity information for an application or user."
    },
    "CreateDriveItemSharingLinkResponse": {
      "type": "object",
      "title": "CreateDriveItemSharingLinkResponse",
      "properties": {
        "id": {
          "type": "string",
          "title": "Id",
          "description": "The unique identifier of the permission"
        },
        "link": {
          "type": "object",
          "title": "Link",
          "properties": {
            "type": {
              "type": "string",
              "title": "Type",
              "description": "The type of the link (view, edit, or embed)"
            },
            "scope": {
              "type": "string",
              "title": "Scope",
              "description": "The scope of the link (anonymous, organization, or users)"
            },
            "webUrl": {
              "type": "string",
              "title": "Web Url",
              "description": "A URL that opens the item in the browser"
            },
            "webHtml": {
              "type": "string",
              "title": "Web Html",
              "description": "For embed links, the HTML code for an iframe element to embed the item"
            },
            "application": {
              "type": "object",
              "title": "Application",
              "properties": {
                "id": {
                  "type": "string",
                  "title": "Id",
                  "description": "The unique identifier"
                },
                "displayName": {
                  "type": "string",
                  "title": "Display Name",
                  "description": "The display name"
                }
              },
              "description": "The app the link is associated with"
            },
            "preventsDownload": {
              "type": "boolean",
              "title": "Prevents Download",
              "description": "If true, the user can only view the item on the web and cannot download contents"
            }
          },
          "description": "The sharing link details"
        },
        "roles": {
          "type": "array",
          "items": {
            "type": "string"
          },
          "title": "Roles",
          "description": "The type of permission (e.g., read, write)"
        },
        "shareId": {
          "type": "string",
          "title": "Share Id",
          "description": "A unique token for accessing this shared item via the shares API"
        },
        "hasPassword": {
          "type": "boolean",
          "title": "Has Password",
          "description": "Indicates whether the link has a password set"
        },
        "expirationDateTime": {
          "type": "string",
          "title": "Expiration Date Time",
          "description": "The expiration time of the permission in ISO 8601 format"
        }
      },
      "description": "Response model containing the sharing link permission details."
    }
  },
  "title": "CreateDriveItemSharingLinkResponseWrapper",
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
          "description": "The unique identifier of the permission"
        },
        "link": {
          "type": "object",
          "title": "Link",
          "properties": {
            "type": {
              "type": "string",
              "title": "Type",
              "description": "The type of the link (view, edit, or embed)"
            },
            "scope": {
              "type": "string",
              "title": "Scope",
              "description": "The scope of the link (anonymous, organization, or users)"
            },
            "webUrl": {
              "type": "string",
              "title": "Web Url",
              "description": "A URL that opens the item in the browser"
            },
            "webHtml": {
              "type": "string",
              "title": "Web Html",
              "description": "For embed links, the HTML code for an iframe element to embed the item"
            },
            "application": {
              "type": "object",
              "title": "Application",
              "properties": {
                "id": {
                  "type": "string",
                  "title": "Id",
                  "description": "The unique identifier"
                },
                "displayName": {
                  "type": "string",
                  "title": "Display Name",
                  "description": "The display name"
                }
              },
              "description": "The app the link is associated with"
            },
            "preventsDownload": {
              "type": "boolean",
              "title": "Prevents Download",
              "description": "If true, the user can only view the item on the web and cannot download contents"
            }
          },
          "description": "The sharing link details"
        },
        "roles": {
          "type": "array",
          "items": {
            "type": "string"
          },
          "title": "Roles",
          "description": "The type of permission (e.g., read, write)"
        },
        "shareId": {
          "type": "string",
          "title": "Share Id",
          "description": "A unique token for accessing this shared item via the shares API"
        },
        "hasPassword": {
          "type": "boolean",
          "title": "Has Password",
          "description": "Indicates whether the link has a password set"
        },
        "expirationDateTime": {
          "type": "string",
          "title": "Expiration Date Time",
          "description": "The expiration time of the permission in ISO 8601 format"
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

## SHARE_POINT_CREATE_LIST_FIELD
Tool to create a new field (column) in a SharePoint list. Use when you need to programmatically add a column after confirming the list GUID.

**Input schema:**
```json
{
  "type": "object",
  "title": "CreateListFieldRequest",
  "required": [
    "list_guid",
    "title",
    "field_type_kind",
    "static_name"
  ],
  "properties": {
    "title": {
      "type": "string",
      "title": "Title",
      "examples": [
        "My Column"
      ],
      "description": "Display name of the new list field."
    },
    "required": {
      "type": "boolean",
      "title": "Required",
      "default": false,
      "description": "Whether the field is required (non-nullable)."
    },
    "list_guid": {
      "type": "string",
      "title": "List Guid",
      "examples": [
        "01234567-89ab-cdef-0123-456789abcdef"
      ],
      "description": "GUID of the SharePoint list where the new field will be created. Obtain via SHARE_POINT_SHAREPOINT_CREATE_LIST or SHARE_POINT_GET_LIST_BY_TITLE before calling this tool."
    },
    "site_name": {
      "type": "string",
      "title": "Site Name",
      "examples": [
        "composio-test"
      ],
      "description": "The subsite name to scope the request to (e.g., 'composio-test'). If omitted, the root site is used. When provided, the API base URL becomes https://{tenant}.sharepoint.com/sites/{site}."
    },
    "static_name": {
      "type": "string",
      "title": "Static Name",
      "examples": [
        "MyColumnInternal"
      ],
      "description": "Internal name of the field (no spaces)."
    },
    "field_type_kind": {
      "type": "integer",
      "title": "Field Type Kind",
      "minimum": 0,
      "examples": [
        2
      ],
      "description": "Numeric value from SP.FieldType enumeration specifying the type of the field. Common values: 1=Counter, 2=Text (single line), 3=Note (multiple lines), 6=Choice, 8=Boolean, 9=Number (decimal), 11=URL, 20=User."
    },
    "enforce_unique_values": {
      "type": "boolean",
      "title": "Enforce Unique Values",
      "default": false,
      "description": "Whether values in this field must be unique. Note: Fields with enforce_unique_values=True must be indexed (which is a separate operation not included in this action). If the field is not indexed, the API will return an error."
    }
  },
  "additionalProperties": false
}
```

**Output schema:**
```json
{
  "type": "object",
  "$defs": {
    "CreateListFieldResponse": {
      "type": "object",
      "title": "CreateListFieldResponse",
      "required": [
        "Title",
        "StaticName",
        "Id",
        "FieldTypeKind",
        "Required",
        "EnforceUniqueValues"
      ],
      "properties": {
        "Id": {
          "type": "string",
          "title": "Id",
          "description": "GUID of the created field."
        },
        "Title": {
          "type": "string",
          "title": "Title",
          "description": "Display name of the created field."
        },
        "Required": {
          "type": "boolean",
          "title": "Required",
          "description": "Indicates if the field is required."
        },
        "StaticName": {
          "type": "string",
          "title": "Static Name",
          "description": "Internal name of the created field."
        },
        "FieldTypeKind": {
          "type": "integer",
          "title": "Field Type Kind",
          "description": "Numeric SP.FieldType value of the created field."
        },
        "EnforceUniqueValues": {
          "type": "boolean",
          "title": "Enforce Unique Values",
          "description": "Indicates if the field enforces unique values."
        }
      }
    }
  },
  "title": "CreateListFieldResponseWrapper",
  "required": [
    "data",
    "successful"
  ],
  "properties": {
    "data": {
      "type": "object",
      "title": "Data",
      "required": [
        "Title",
        "StaticName",
        "Id",
        "FieldTypeKind",
        "Required",
        "EnforceUniqueValues"
      ],
      "properties": {
        "Id": {
          "type": "string",
          "title": "Id",
          "description": "GUID of the created field."
        },
        "Title": {
          "type": "string",
          "title": "Title",
          "description": "Display name of the created field."
        },
        "Required": {
          "type": "boolean",
          "title": "Required",
          "description": "Indicates if the field is required."
        },
        "StaticName": {
          "type": "string",
          "title": "Static Name",
          "description": "Internal name of the created field."
        },
        "FieldTypeKind": {
          "type": "integer",
          "title": "Field Type Kind",
          "description": "Numeric SP.FieldType value of the created field."
        },
        "EnforceUniqueValues": {
          "type": "boolean",
          "title": "Enforce Unique Values",
          "description": "Indicates if the field enforces unique values."
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

## SHARE_POINT_CREATE_LIST_ITEM_BY_ID
Tool to create a new item in a SharePoint list using the list's GUID. Use when you have the list GUID rather than the list title.

**Input schema:**
```json
{
  "type": "object",
  "title": "CreateListItemByIdRequest",
  "example": {
    "fields": {
      "Title": "New Task",
      "Description": "Task description"
    },
    "list_id": "a12e3d6e-9414-462d-bd53-cf06f3982ad3",
    "metadata_type": "SP.Data.TasksListItem"
  },
  "required": [
    "list_id",
    "metadata_type",
    "fields"
  ],
  "properties": {
    "fields": {
      "type": "object",
      "title": "Fields",
      "examples": [
        {
          "Title": "New Task",
          "Status": "Active"
        }
      ],
      "description": "Dictionary mapping internal field names to their values for the new list item. Example: {'Title': 'New Item', 'Description': 'Item details'}. At minimum, provide 'Title' field for most lists.",
      "additionalProperties": {
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
            "type": "null"
          }
        ]
      }
    },
    "list_id": {
      "type": "string",
      "title": "List Id",
      "pattern": "^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$",
      "examples": [
        "a12e3d6e-9414-462d-bd53-cf06f3982ad3"
      ],
      "description": "The unique identifier (GUID) of the SharePoint list where the item will be created. Format: '12345678-1234-1234-1234-123456789abc'"
    },
    "site_name": {
      "type": "string",
      "title": "Site Name",
      "examples": [
        "composio-test"
      ],
      "description": "The subsite name to scope the request to (e.g., 'composio-test'). If omitted, the root site is used. When provided, the API base URL becomes 'https://{tenant}.sharepoint.com/sites/{site}'."
    },
    "metadata_type": {
      "type": "string",
      "title": "Metadata Type",
      "examples": [
        "SP.Data.TasksListItem",
        "SP.Data.AbcListItem"
      ],
      "description": "The ListItemEntityTypeFullName required for __metadata.type in the request body. Format: 'SP.Data.{ListName}ListItem' (e.g., 'SP.Data.TasksListItem' or 'SP.Data.AbcListItem'). Use GET_LIST_ITEM_ENTITY_TYPE_FULL_NAME to retrieve this value if unknown."
    }
  },
  "description": "Request model for creating a SharePoint list item by list GUID.",
  "additionalProperties": false
}
```

**Output schema:**
```json
{
  "type": "object",
  "$defs": {
    "CreateListItemByIdResponse": {
      "type": "object",
      "title": "CreateListItemByIdResponse",
      "required": [
        "success",
        "item_id",
        "item_data",
        "message"
      ],
      "properties": {
        "item_id": {
          "type": "integer",
          "title": "Item Id",
          "description": "The numeric ID of the newly created list item."
        },
        "message": {
          "type": "string",
          "title": "Message",
          "description": "Success message describing the creation result."
        },
        "success": {
          "type": "boolean",
          "title": "Success",
          "description": "Indicates whether the item creation succeeded."
        },
        "item_data": {
          "type": "object",
          "title": "Item Data",
          "description": "Complete data of the created list item returned by SharePoint.",
          "additionalProperties": true
        },
        "created_at": {
          "type": "string",
          "title": "Created At",
          "description": "ISO 8601 timestamp when the item was created."
        }
      },
      "description": "Response model for a successfully created list item."
    }
  },
  "title": "CreateListItemByIdResponseWrapper",
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
        "item_id",
        "item_data",
        "message"
      ],
      "properties": {
        "item_id": {
          "type": "integer",
          "title": "Item Id",
          "description": "The numeric ID of the newly created list item."
        },
        "message": {
          "type": "string",
          "title": "Message",
          "description": "Success message describing the creation result."
        },
        "success": {
          "type": "boolean",
          "title": "Success",
          "description": "Indicates whether the item creation succeeded."
        },
        "item_data": {
          "type": "object",
          "title": "Item Data",
          "description": "Complete data of the created list item returned by SharePoint.",
          "additionalProperties": true
        },
        "created_at": {
          "type": "string",
          "title": "Created At",
          "description": "ISO 8601 timestamp when the item was created."
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

## SHARE_POINT_CREATE_LIST_ITEM_IN_FOLDER
Tool to create a list item in a specific folder within a SharePoint list. IMPORTANT: This action works ONLY with SharePoint lists (not document libraries). The folder_url can be either a server-relative URL (e.g., '/Lists/MyList') or an absolute URL (e.g., 'https://site.sharepoint.com/sites/sitename/Lists/MyList'). To create files in document libraries, use a different action like upload_file.

**Input schema:**
```json
{
  "type": "object",
  "title": "CreateListItemInFolderRequest",
  "example": {
    "site": "composio-test",
    "values": [
      {
        "FieldName": "Title",
        "FieldValue": "New Item"
      }
    ],
    "folder_url": "/Lists/MyList",
    "list_title": "MyList",
    "check_in_comment": "Initial creation"
  },
  "required": [
    "list_title",
    "folder_url",
    "values"
  ],
  "properties": {
    "values": {
      "type": "array",
      "items": {
        "type": "object",
        "title": "FieldValue",
        "required": [
          "FieldName",
          "FieldValue"
        ],
        "properties": {
          "FieldName": {
            "type": "string",
            "title": "Field Name",
            "description": "Internal name of the field to set"
          },
          "FieldValue": {
            "type": "string",
            "title": "Field Value",
            "description": "Value to assign to the field"
          }
        }
      },
      "title": "Values",
      "description": "List of field name/value pairs to set on the new item."
    },
    "site_name": {
      "type": "string",
      "title": "Site Name",
      "examples": [
        "composio-test",
        "marketing",
        "hr-portal"
      ],
      "description": "The subsite name to scope the request to (e.g., 'composio-test'). If omitted, the root site is used. When provided, the tenant is derived from the connected account's base URL."
    },
    "folder_url": {
      "type": "string",
      "title": "Folder Url",
      "examples": [
        "/Lists/MyList",
        "/Lists/Tasks/SubFolder",
        "https://site.sharepoint.com/sites/sitename/Lists/MyList",
        "https://site.sharepoint.com/sites/sitename/Lists/Tasks/SubFolder"
      ],
      "description": "URL of the target folder within the list where the item will be created. Accepts both server-relative URLs (e.g., '/Lists/MyList') and absolute URLs (e.g., 'https://site.sharepoint.com/sites/sitename/Lists/MyList'). For the list root folder, use '/Lists/<ListName>' or the full absolute URL. For a subfolder within the list, append the subfolder path. You can obtain this URL from the list's RootFolder.ServerRelativeUrl property. This parameter works with SharePoint lists only, NOT document libraries."
    },
    "list_title": {
      "type": "string",
      "title": "List Title",
      "examples": [
        "MyList",
        "Tasks",
        "Announcements"
      ],
      "description": "The title of the SharePoint list where the item will be created. Must be an existing list (not a document library)."
    },
    "check_in_comment": {
      "type": "string",
      "title": "Check In Comment",
      "description": "Optional check-in comment if the item is checked out."
    }
  },
  "additionalProperties": false
}
```

**Output schema:**
```json
{
  "type": "object",
  "$defs": {
    "ListItemFieldResult": {
      "type": "object",
      "title": "ListItemFieldResult",
      "required": [
        "ErrorCode",
        "FieldName",
        "FieldValue",
        "HasException",
        "ItemId"
      ],
      "properties": {
        "ItemId": {
          "type": "integer",
          "title": "Item Id",
          "description": "Item ID reference (typically 0 in the response). To get the actual created item ID, look for the field result where FieldName='Id'."
        },
        "ErrorCode": {
          "type": "integer",
          "title": "Error Code",
          "description": "Error code for the field operation. 0 indicates success, non-zero indicates an error."
        },
        "FieldName": {
          "type": "string",
          "title": "Field Name",
          "description": "Internal name of the field."
        },
        "FieldValue": {
          "type": "string",
          "title": "Field Value",
          "description": "Value resulting after validation/update."
        },
        "ErrorMessage": {
          "type": "string",
          "title": "Error Message",
          "description": "Error message for the field, if any."
        },
        "HasException": {
          "type": "boolean",
          "title": "Has Exception",
          "description": "Indicates whether validation/update failed for the field."
        }
      }
    },
    "CreateListItemInFolderResponse": {
      "type": "object",
      "title": "CreateListItemInFolderResponse",
      "required": [
        "value"
      ],
      "properties": {
        "value": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "ListItemFieldResult",
            "required": [
              "ErrorCode",
              "FieldName",
              "FieldValue",
              "HasException",
              "ItemId"
            ],
            "properties": {
              "ItemId": {
                "type": "integer",
                "title": "Item Id",
                "description": "Item ID reference (typically 0 in the response). To get the actual created item ID, look for the field result where FieldName='Id'."
              },
              "ErrorCode": {
                "type": "integer",
                "title": "Error Code",
                "description": "Error code for the field operation. 0 indicates success, non-zero indicates an error."
              },
              "FieldName": {
                "type": "string",
                "title": "Field Name",
                "description": "Internal name of the field."
              },
              "FieldValue": {
                "type": "string",
                "title": "Field Value",
                "description": "Value resulting after validation/update."
              },
              "ErrorMessage": {
                "type": "string",
                "title": "Error Message",
                "description": "Error message for the field, if any."
              },
              "HasException": {
                "type": "boolean",
                "title": "Has Exception",
                "description": "Indicates whether validation/update failed for the field."
              }
            }
          },
          "title": "Value",
          "description": "Array of per-field results for the newly created item."
        }
      }
    }
  },
  "title": "CreateListItemInFolderResponseWrapper",
  "required": [
    "data",
    "successful"
  ],
  "properties": {
    "data": {
      "type": "object",
      "title": "Data",
      "required": [
        "value"
      ],
      "properties": {
        "value": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "ListItemFieldResult",
            "required": [
              "ErrorCode",
              "FieldName",
              "FieldValue",
              "HasException",
              "ItemId"
            ],
            "properties": {
              "ItemId": {
                "type": "integer",
                "title": "Item Id",
                "description": "Item ID reference (typically 0 in the response). To get the actual created item ID, look for the field result where FieldName='Id'."
              },
              "ErrorCode": {
                "type": "integer",
                "title": "Error Code",
                "description": "Error code for the field operation. 0 indicates success, non-zero indicates an error."
              },
              "FieldName": {
                "type": "string",
                "title": "Field Name",
                "description": "Internal name of the field."
              },
              "FieldValue": {
                "type": "string",
                "title": "Field Value",
                "description": "Value resulting after validation/update."
              },
              "ErrorMessage": {
                "type": "string",
                "title": "Error Message",
                "description": "Error message for the field, if any."
              },
              "HasException": {
                "type": "boolean",
                "title": "Has Exception",
                "description": "Indicates whether validation/update failed for the field."
              }
            }
          },
          "title": "Value",
          "description": "Array of per-field results for the newly created item."
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

## SHARE_POINT_CREATE_WEB
Tool to create a new SharePoint subsite under the current site. Use when you need to create a new subsite with specific settings for permissions, language, and template.

**Input schema:**
```json
{
  "type": "object",
  "title": "CreateWebRequest",
  "required": [
    "url",
    "title"
  ],
  "properties": {
    "url": {
      "type": "string",
      "title": "Url",
      "pattern": "^[a-zA-Z0-9_-]{1,128}$",
      "description": "The URL segment for the new subsite (e.g., 'TestSubWeb'). This becomes part of the site URL path. Must contain only letters, numbers, hyphens, and underscores."
    },
    "title": {
      "type": "string",
      "title": "Title",
      "description": "The display title for the new subsite."
    },
    "language": {
      "type": "integer",
      "title": "Language",
      "default": 1033,
      "minimum": 1,
      "description": "Language code for the subsite. Default is 1033 (English - United States). Examples: 1031 (German), 1033 (English), 1036 (French), 1040 (Italian), 1041 (Japanese), 1042 (Korean), 1043 (Dutch), 2052 (Chinese - Simplified), 3082 (Spanish)."
    },
    "site_name": {
      "type": "string",
      "title": "Site Name",
      "description": "The subsite name to scope the request to. You can find this in your SharePoint URL after /sites/ (e.g., https://tenant.sharepoint.com/sites/<subsite-name>). If omitted, the root site is used."
    },
    "description": {
      "type": "string",
      "title": "Description",
      "default": "",
      "description": "A description of the new subsite (optional)."
    },
    "web_template": {
      "type": "string",
      "title": "Web Template",
      "default": "sts",
      "description": "Web template to use for the subsite. Use 'sts' for modern team site homepage or 'sts#0' for classic team site. Other options include 'blog', 'wiki', etc."
    },
    "use_unique_permissions": {
      "type": "boolean",
      "title": "Use Unique Permissions",
      "default": false,
      "description": "If true, the subsite will have unique permissions separate from the parent site. If false, it inherits permissions from the parent site."
    }
  }
}
```

**Output schema:**
```json
{
  "type": "object",
  "$defs": {
    "CreateWebResponse": {
      "type": "object",
      "title": "CreateWebResponse",
      "required": [
        "message",
        "id",
        "title",
        "url",
        "server_relative_url",
        "description",
        "language",
        "web_template"
      ],
      "properties": {
        "id": {
          "type": "string",
          "title": "Id",
          "description": "The unique identifier (GUID) of the created subsite"
        },
        "url": {
          "type": "string",
          "title": "Url",
          "description": "The URL of the created subsite"
        },
        "title": {
          "type": "string",
          "title": "Title",
          "description": "The title of the created subsite"
        },
        "message": {
          "type": "string",
          "title": "Message",
          "description": "Success message indicating subsite creation"
        },
        "language": {
          "type": "integer",
          "title": "Language",
          "description": "The language code of the created subsite"
        },
        "description": {
          "type": "string",
          "title": "Description",
          "description": "The description of the created subsite"
        },
        "web_template": {
          "type": "string",
          "title": "Web Template",
          "description": "The web template used for the created subsite"
        },
        "server_relative_url": {
          "type": "string",
          "title": "Server Relative Url",
          "description": "The server-relative URL of the created subsite"
        }
      }
    }
  },
  "title": "CreateWebResponseWrapper",
  "required": [
    "data",
    "successful"
  ],
  "properties": {
    "data": {
      "type": "object",
      "title": "Data",
      "required": [
        "message",
        "id",
        "title",
        "url",
        "server_relative_url",
        "description",
        "language",
        "web_template"
      ],
      "properties": {
        "id": {
          "type": "string",
          "title": "Id",
          "description": "The unique identifier (GUID) of the created subsite"
        },
        "url": {
          "type": "string",
          "title": "Url",
          "description": "The URL of the created subsite"
        },
        "title": {
          "type": "string",
          "title": "Title",
          "description": "The title of the created subsite"
        },
        "message": {
          "type": "string",
          "title": "Message",
          "description": "Success message indicating subsite creation"
        },
        "language": {
          "type": "integer",
          "title": "Language",
          "description": "The language code of the created subsite"
        },
        "description": {
          "type": "string",
          "title": "Description",
          "description": "The description of the created subsite"
        },
        "web_template": {
          "type": "string",
          "title": "Web Template",
          "description": "The web template used for the created subsite"
        },
        "server_relative_url": {
          "type": "string",
          "title": "Server Relative Url",
          "description": "The server-relative URL of the created subsite"
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

## SHARE_POINT_DELETE_DRIVE_ITEM_VERSION_CONTENT
Tool to delete content for a specific version of a drive item in SharePoint. Use when you need to remove the binary content associated with a particular version of a file while keeping the version metadata.

**Input schema:**
```json
{
  "type": "object",
  "title": "DeleteDriveItemVersionContentRequest",
  "required": [
    "drive_id",
    "driveitem_id",
    "driveitemversion_id"
  ],
  "properties": {
    "drive_id": {
      "type": "string",
      "title": "Drive Id",
      "examples": [
        "b!sAYRj4psj0qqpjB3OOHdglZBMF5Nk0xPnR4Fc4pfinI6LsO0Ty3NT6hz1n27BFpo"
      ],
      "description": "The unique identifier of the drive. This is the ID of the document library or drive where the item is stored. You can get this from drive listing endpoints."
    },
    "driveitem_id": {
      "type": "string",
      "title": "Driveitem Id",
      "examples": [
        "01K67O4VSVYSGCL3MHHNDIESCQSPJ6CCZP"
      ],
      "description": "The unique identifier of the drive item (file or folder). This is the ID of the specific item whose version content you want to delete."
    },
    "driveitemversion_id": {
      "type": "string",
      "title": "Driveitemversion Id",
      "examples": [
        "24.0",
        "1.0",
        "2.0"
      ],
      "description": "The unique identifier of the version. Version IDs are typically numeric strings like '1.0', '2.0', '24.0', etc. You can retrieve version IDs by listing versions for a drive item."
    }
  },
  "description": "Request model for deleting content for a specific version of a drive item."
}
```

**Output schema:**
```json
{
  "type": "object",
  "$defs": {
    "DeleteDriveItemVersionContentResponse": {
      "type": "object",
      "title": "DeleteDriveItemVersionContentResponse",
      "required": [
        "message",
        "drive_id",
        "driveitem_id",
        "driveitemversion_id"
      ],
      "properties": {
        "message": {
          "type": "string",
          "title": "Message",
          "description": "Success message confirming the version content was deleted"
        },
        "drive_id": {
          "type": "string",
          "title": "Drive Id",
          "description": "The drive ID of the deleted version content"
        },
        "driveitem_id": {
          "type": "string",
          "title": "Driveitem Id",
          "description": "The drive item ID of the deleted version content"
        },
        "driveitemversion_id": {
          "type": "string",
          "title": "Driveitemversion Id",
          "description": "The version ID of the deleted content"
        }
      },
      "description": "Response model for drive item version content deletion."
    }
  },
  "title": "DeleteDriveItemVersionContentResponseWrapper",
  "required": [
    "data",
    "successful"
  ],
  "properties": {
    "data": {
      "type": "object",
      "title": "Data",
      "required": [
        "message",
        "drive_id",
        "driveitem_id",
        "driveitemversion_id"
      ],
      "properties": {
        "message": {
          "type": "string",
          "title": "Message",
          "description": "Success message confirming the version content was deleted"
        },
        "drive_id": {
          "type": "string",
          "title": "Drive Id",
          "description": "The drive ID of the deleted version content"
        },
        "driveitem_id": {
          "type": "string",
          "title": "Driveitem Id",
          "description": "The drive item ID of the deleted version content"
        },
        "driveitemversion_id": {
          "type": "string",
          "title": "Driveitemversion Id",
          "description": "The version ID of the deleted content"
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

## SHARE_POINT_DELETE_FOLDER
Deletes a folder from a SharePoint document library. This action permanently removes the specified folder and moves it to the site's recycle bin. Use this when you need to remove folders that are no longer needed. The operation is idempotent - attempting to delete a non-existent folder will succeed without error. Requires the server-relative path of the folder (e.g., '/Shared Documents/FolderName').

**Input schema:**
```json
{
  "type": "object",
  "title": "DeleteFolderRequest",
  "required": [
    "server_relative_url"
  ],
  "properties": {
    "etag": {
      "type": "string",
      "title": "Etag",
      "default": "*",
      "examples": [
        "*",
        "\"1\""
      ],
      "description": "ETag for conditional deletion. Use '*' (default) to delete regardless of version. Provide a specific ETag value to delete only if the folder hasn't been modified since that version."
    },
    "site_name": {
      "type": "string",
      "title": "Site Name",
      "description": "The subsite name to scope the request to (e.g., composio-test). If omitted, the root site is used. When provided, the API base URL becomes https://{tenant}.sharepoint.com/sites/{site}."
    },
    "server_relative_url": {
      "type": "string",
      "title": "Server Relative Url",
      "examples": [
        "/Shared Documents/Folder1",
        "/Documents/Projects/Archive"
      ],
      "description": "The server-relative path of the folder to delete. This is the full path from the site root, including the document library and any parent folders. Format: '/DocumentLibrary/ParentFolder/FolderName'. Examples: '/Shared Documents/Reports', '/Documents/2024/Q1'."
    }
  },
  "description": "Request model for deleting a SharePoint folder by server-relative URL."
}
```

**Output schema:**
```json
{
  "type": "object",
  "$defs": {
    "DeleteFolderResponse": {
      "type": "object",
      "title": "DeleteFolderResponse",
      "required": [
        "message",
        "server_relative_url"
      ],
      "properties": {
        "message": {
          "type": "string",
          "title": "Message",
          "description": "Success message confirming the folder was deleted"
        },
        "server_relative_url": {
          "type": "string",
          "title": "Server Relative Url",
          "description": "The server-relative path of the folder that was deleted, matching the input parameter"
        }
      },
      "description": "Response model for SharePoint folder deletion."
    }
  },
  "title": "DeleteFolderResponseWrapper",
  "required": [
    "data",
    "successful"
  ],
  "properties": {
    "data": {
      "type": "object",
      "title": "Data",
      "required": [
        "message",
        "server_relative_url"
      ],
      "properties": {
        "message": {
          "type": "string",
          "title": "Message",
          "description": "Success message confirming the folder was deleted"
        },
        "server_relative_url": {
          "type": "string",
          "title": "Server Relative Url",
          "description": "The server-relative path of the folder that was deleted, matching the input parameter"
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

## SHARE_POINT_DELETE_LIST
Tool to delete a SharePoint list. Use when you need to remove a list by its GUID after confirming the correct list identifier.

**Input schema:**
```json
{
  "type": "object",
  "title": "DeleteListRequest",
  "required": [
    "list_guid"
  ],
  "properties": {
    "if_match": {
      "type": "string",
      "title": "If Match",
      "default": "*",
      "description": "ETag for concurrency control; use '*' to delete regardless of version.",
      "human_parameter_name": "If-Match ETag",
      "human_parameter_description": "The ETag of the list for concurrency. Use '*' to force deletion."
    },
    "list_guid": {
      "type": "string",
      "title": "List Guid",
      "description": "The GUID of the SharePoint list to delete (format: 'xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx').",
      "human_parameter_name": "List GUID",
      "human_parameter_description": "Unique identifier of the SharePoint list you want to delete."
    },
    "site_name": {
      "type": "string",
      "title": "Site Name",
      "description": "The subsite name to scope the request to (e.g., 'composio-test'). If omitted, the root site is used. When provided, the API base URL becomes 'https://{tenant}.sharepoint.com/sites/{site}'.",
      "human_parameter_name": "Subsite Name",
      "human_parameter_description": "Optional subsite name to target. Leave empty for root site operations."
    }
  }
}
```

**Output schema:**
```json
{
  "type": "object",
  "$defs": {
    "DeleteListResponse": {
      "type": "object",
      "title": "DeleteListResponse",
      "required": [
        "message"
      ],
      "properties": {
        "message": {
          "type": "string",
          "title": "Message",
          "description": "Success message confirming list deletion."
        }
      }
    }
  },
  "title": "DeleteListResponseWrapper",
  "required": [
    "data",
    "successful"
  ],
  "properties": {
    "data": {
      "type": "object",
      "title": "Data",
      "required": [
        "message"
      ],
      "properties": {
        "message": {
          "type": "string",
          "title": "Message",
          "description": "Success message confirming list deletion."
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

## SHARE_POINT_DELETE_LIST_BY_TITLE
Tool to delete a SharePoint list by its title. Use when you need to permanently remove a list and all its contents by specifying the list name.

**Input schema:**
```json
{
  "type": "object",
  "title": "DeleteListByTitleRequest",
  "example": {
    "site": "composio-test",
    "if_match": "*",
    "list_title": "TestListToDelete"
  },
  "required": [
    "list_title"
  ],
  "properties": {
    "if_match": {
      "type": "string",
      "title": "If Match",
      "default": "*",
      "description": "ETag for concurrency control. Use '*' to force delete regardless of version, or provide a specific ETag value for version checking."
    },
    "site_name": {
      "type": "string",
      "title": "Site Name",
      "examples": [
        "composio-test",
        "teamsite"
      ],
      "description": "The subsite name to scope the request to (e.g., 'composio-test'). If omitted, the root site is used. When provided, the API base URL becomes https://{tenant}.sharepoint.com/sites/{site}."
    },
    "list_title": {
      "type": "string",
      "title": "List Title",
      "examples": [
        "TestListToDelete",
        "MyTemporaryList"
      ],
      "description": "The title of the SharePoint list to delete. This is a destructive operation that permanently removes the list and all its contents."
    }
  },
  "description": "Request model for deleting a SharePoint list by its title.",
  "additionalProperties": false
}
```

**Output schema:**
```json
{
  "type": "object",
  "$defs": {
    "DeleteListByTitleResponse": {
      "type": "object",
      "title": "DeleteListByTitleResponse",
      "required": [
        "message"
      ],
      "properties": {
        "message": {
          "type": "string",
          "title": "Message",
          "description": "Success message confirming the list was deleted."
        }
      },
      "description": "Response model for successful list deletion."
    }
  },
  "title": "DeleteListByTitleResponseWrapper",
  "required": [
    "data",
    "successful"
  ],
  "properties": {
    "data": {
      "type": "object",
      "title": "Data",
      "required": [
        "message"
      ],
      "properties": {
        "message": {
          "type": "string",
          "title": "Message",
          "description": "Success message confirming the list was deleted."
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

## SHARE_POINT_DELETE_LIST_ITEM
Tool to delete a SharePoint list item. Use when you need to permanently remove an item by its ID. Use after obtaining the item's ETag to ensure concurrency control.

**Input schema:**
```json
{
  "type": "object",
  "title": "DeleteListItemRequest",
  "example": {
    "item_id": 5,
    "list_title": "Tasks",
    "match_etag": "*"
  },
  "required": [
    "list_title",
    "item_id"
  ],
  "properties": {
    "item_id": {
      "type": "integer",
      "title": "Item Id",
      "description": "Numeric ID of the list item to delete",
      "human_parameter_name": "Item ID",
      "human_parameter_description": "The numeric identifier of the list item you want to remove."
    },
    "site_name": {
      "type": "string",
      "title": "Site Name",
      "description": "The subsite name to scope the request to (e.g., 'composio-test'). If omitted, the root site is used. When provided, the API base URL becomes https://{tenant}.sharepoint.com/sites/{site}.",
      "human_parameter_name": "Site",
      "human_parameter_description": "Optional subsite name. Leave empty for root site, or specify a subsite like 'composio-test'."
    },
    "list_title": {
      "type": "string",
      "title": "List Title",
      "description": "The exact title of the SharePoint list containing the item to delete",
      "human_parameter_name": "List Title",
      "human_parameter_description": "Enter the title of the SharePoint list where the item exists."
    },
    "match_etag": {
      "type": "string",
      "title": "Match Etag",
      "default": "*",
      "description": "ETag value for concurrency control. Use '*' to force delete regardless of version. If providing a specific ETag, use the full quoted value returned by GET_LIST_ITEM_ETAG (e.g., '\"guid,version\"' format like '\"c7a93369-bda8-4da1-b1a3-3d87d2e207fc,1\"'). Simple version numbers like '1' are not valid ETags.",
      "human_parameter_name": "ETag",
      "human_parameter_description": "The ETag of the list item. Use '*' to delete unconditionally, or provide the full ETag value from GET_LIST_ITEM_ETAG (in '\"guid,version\"' format)."
    }
  },
  "additionalProperties": false
}
```

**Output schema:**
```json
{
  "type": "object",
  "$defs": {
    "DeleteListItemResponse": {
      "type": "object",
      "title": "DeleteListItemResponse",
      "required": [
        "message"
      ],
      "properties": {
        "message": {
          "type": "string",
          "title": "Message",
          "description": "Result message indicating deletion status"
        }
      }
    }
  },
  "title": "DeleteListItemResponseWrapper",
  "required": [
    "data",
    "successful"
  ],
  "properties": {
    "data": {
      "type": "object",
      "title": "Data",
      "required": [
        "message"
      ],
      "properties": {
        "message": {
          "type": "string",
          "title": "Message",
          "description": "Result message indicating deletion status"
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

## SHARE_POINT_DELETE_RECYCLE_BIN_ITEM_PERMANENT
Tool to permanently delete a SharePoint Recycle Bin item. Use after confirming the item's GUID to remove it irrevocably.

**Input schema:**
```json
{
  "type": "object",
  "title": "DeleteRecycleBinItemPermanentRequest",
  "required": [
    "recyclebinitemid"
  ],
  "properties": {
    "site_name": {
      "type": "string",
      "title": "Site Name",
      "examples": [
        "composio-test"
      ],
      "description": "The subsite name to scope the request to (e.g., 'composio-test'). If omitted, the root site is used. When provided, the API base URL becomes https://{tenant}.sharepoint.com/sites/{site}."
    },
    "recyclebinitemid": {
      "type": "string",
      "title": "Recyclebinitemid",
      "examples": [
        "123e4567-e89b-12d3-a456-426614174000"
      ],
      "description": "GUID of the Recycle Bin item to delete permanently. Must not be empty. Retrieve this GUID by querying the recycle bin and cross-referencing item name, original path, and deletion timestamp to confirm the correct item before deletion."
    }
  },
  "additionalProperties": false
}
```

**Output schema:**
```json
{
  "type": "object",
  "$defs": {
    "DeleteRecycleBinItemPermanentResponse": {
      "type": "object",
      "title": "DeleteRecycleBinItemPermanentResponse",
      "required": [
        "message"
      ],
      "properties": {
        "message": {
          "type": "string",
          "title": "Message",
          "description": "Status message indicating the permanent deletion result"
        }
      }
    }
  },
  "title": "DeleteRecycleBinItemPermanentResponseWrapper",
  "required": [
    "data",
    "successful"
  ],
  "properties": {
    "data": {
      "type": "object",
      "title": "Data",
      "required": [
        "message"
      ],
      "properties": {
        "message": {
          "type": "string",
          "title": "Message",
          "description": "Status message indicating the permanent deletion result"
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

## SHARE_POINT_DOWNLOAD_FILE_BY_SERVER_RELATIVE_URL
Tool to download a file by server-relative URL. Use when you need to fetch the raw bytes of a SharePoint file by its server-relative path.

**Input schema:**
```json
{
  "type": "object",
  "title": "DownloadFileByServerRelativeUrlRequest",
  "required": [
    "server_relative_url"
  ],
  "properties": {
    "site_name": {
      "type": "string",
      "title": "Site Name",
      "examples": [
        "testcomposio",
        "marketing",
        "hr-portal"
      ],
      "description": "Optional SharePoint site name to scope the file download. If provided, the file path is resolved relative to this site. If not provided, the site is auto-extracted from paths starting with /sites/. If not provided and no /sites/ prefix, the file path is resolved relative to the tenant root site. E.g., 'testcomposio' for a site at /sites/testcomposio."
    },
    "server_relative_url": {
      "type": "string",
      "title": "Server Relative Url",
      "examples": [
        "/Shared Documents/report.pdf",
        "/sites/CustomerDocs/Documents/file.pdf",
        "/personal/username_domain/Documents/file.docx"
      ],
      "description": "Server-relative URL of the file to download, starting with '/'. Can be either URL-encoded or unencoded. E.g., '/Shared Documents/report.pdf' for root site, '/sites/CustomerDocs/Documents/file.pdf' for subsites, or '/personal/username_domain/Documents/file.docx' for personal OneDrive sites."
    }
  },
  "description": "Request model for downloading a file by its server-relative URL."
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
    "DownloadFileByServerRelativeUrlResponse": {
      "type": "object",
      "title": "DownloadFileByServerRelativeUrlResponse",
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
          "description": "Downloaded file content"
        }
      },
      "description": "Response model containing the downloaded file content."
    }
  },
  "title": "DownloadFileByServerRelativeUrlResponseWrapper",
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
          "description": "Downloaded file content"
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

## SHARE_POINT_ENSURE_USER
Ensures a user exists in a SharePoint site by their login name. If the user already exists, returns their info; if not, adds them to the site — this is a write operation with a provisioning side effect, not a read-only presence check. Use when you need to add a user or get their user ID for permissions. The login name must be in SharePoint claims format (e.g., 'i:0#.f|membership|user@domain.com'). This action only registers the user in the site collection and does not grant any permissions. To assign list-level access, pass the returned Id field as principal_id to SHARE_POINT_ADD_ROLE_ASSIGNMENT_TO_LIST.

**Input schema:**
```json
{
  "type": "object",
  "title": "EnsureUserRequest",
  "properties": {
    "email": {
      "type": "string",
      "title": "Email",
      "examples": [
        "user@domain.com"
      ],
      "description": "Email address of the user to add to SharePoint. Automatically converted to claims format 'i:0#.f|membership|{email}'. Either email or login_name must be provided."
    },
    "title": {
      "type": "string",
      "title": "Title",
      "description": "Optional display name/title for the user in SharePoint. If provided, the user's title will be updated after ensuring them."
    },
    "site_name": {
      "type": "string",
      "title": "Site Name",
      "examples": [
        "composio-test"
      ],
      "description": "The subsite name to scope the request to (e.g., 'composio-test'). If omitted, the root site is used. When provided, the API base URL becomes 'https://{tenant}.sharepoint.com/sites/{site}'."
    },
    "login_name": {
      "type": "string",
      "title": "Login Name",
      "examples": [
        "i:0#.f|membership|user@domain.com"
      ],
      "description": "Login name of the user in SharePoint claims format (e.g., 'i:0#.f|membership|user@domain.com'). Either login_name or email must be provided. If both are given, login_name takes priority. Throws an exception if login_name does not map to a real directory user; in batch operations, handle each user individually to prevent one failure from halting the batch."
    }
  }
}
```

**Output schema:**
```json
{
  "type": "object",
  "$defs": {
    "Deferred": {
      "type": "object",
      "title": "Deferred",
      "required": [
        "uri"
      ],
      "properties": {
        "uri": {
          "type": "string",
          "title": "Uri",
          "description": "URL for deferred navigation link."
        }
      }
    },
    "GroupsInfo": {
      "type": "object",
      "title": "GroupsInfo",
      "required": [
        "__deferred"
      ],
      "properties": {
        "__deferred": {
          "type": "object",
          "title": "  Deferred",
          "required": [
            "uri"
          ],
          "properties": {
            "uri": {
              "type": "string",
              "title": "Uri",
              "description": "URL for deferred navigation link."
            }
          },
          "description": "Deferred link to the user's group memberships."
        }
      }
    },
    "UserIdInfo": {
      "type": "object",
      "title": "UserIdInfo",
      "required": [
        "NameId",
        "NameIdIssuer"
      ],
      "properties": {
        "NameId": {
          "type": "string",
          "title": "Name Id",
          "description": "Name identifier of the user."
        },
        "NameIdIssuer": {
          "type": "string",
          "title": "Name Id Issuer",
          "description": "Issuer of the name identifier."
        }
      }
    },
    "EnsureUserResponse": {
      "type": "object",
      "title": "EnsureUserResponse",
      "required": [
        "Id",
        "LoginName",
        "Title",
        "Email",
        "IsSiteAdmin",
        "PrincipalType",
        "UserId",
        "Groups"
      ],
      "properties": {
        "Id": {
          "type": "integer",
          "title": "Id",
          "description": "Member identifier for the user."
        },
        "Email": {
          "type": "string",
          "title": "Email",
          "description": "Email address of the user."
        },
        "Title": {
          "type": "string",
          "title": "Title",
          "description": "Display name of the user."
        },
        "Groups": {
          "type": "object",
          "title": "Groups",
          "required": [
            "__deferred"
          ],
          "properties": {
            "__deferred": {
              "type": "object",
              "title": "  Deferred",
              "required": [
                "uri"
              ],
              "properties": {
                "uri": {
                  "type": "string",
                  "title": "Uri",
                  "description": "URL for deferred navigation link."
                }
              },
              "description": "Deferred link to the user's group memberships."
            }
          },
          "description": "Deferred link to the user's group memberships."
        },
        "UserId": {
          "type": "object",
          "title": "User Id",
          "required": [
            "NameId",
            "NameIdIssuer"
          ],
          "properties": {
            "NameId": {
              "type": "string",
              "title": "Name Id",
              "description": "Name identifier of the user."
            },
            "NameIdIssuer": {
              "type": "string",
              "title": "Name Id Issuer",
              "description": "Issuer of the name identifier."
            }
          },
          "description": "User ID info with NameId and NameIdIssuer."
        },
        "LoginName": {
          "type": "string",
          "title": "Login Name",
          "description": "User's login name."
        },
        "IsSiteAdmin": {
          "type": "boolean",
          "title": "Is Site Admin",
          "description": "Whether the user is a site collection administrator."
        },
        "PrincipalType": {
          "type": "integer",
          "title": "Principal Type",
          "description": "Principal type bit flags (1=User, 4=SecurityGroup, 8=DistributionList)."
        }
      },
      "description": "SharePoint user object returned or created by ensureUser."
    }
  },
  "title": "EnsureUserResponseWrapper",
  "required": [
    "data",
    "successful"
  ],
  "properties": {
    "data": {
      "type": "object",
      "title": "Data",
      "required": [
        "Id",
        "LoginName",
        "Title",
        "Email",
        "IsSiteAdmin",
        "PrincipalType",
        "UserId",
        "Groups"
      ],
      "properties": {
        "Id": {
          "type": "integer",
          "title": "Id",
          "description": "Member identifier for the user."
        },
        "Email": {
          "type": "string",
          "title": "Email",
          "description": "Email address of the user."
        },
        "Title": {
          "type": "string",
          "title": "Title",
          "description": "Display name of the user."
        },
        "Groups": {
          "type": "object",
          "title": "Groups",
          "required": [
            "__deferred"
          ],
          "properties": {
            "__deferred": {
              "type": "object",
              "title": "  Deferred",
              "required": [
                "uri"
              ],
              "properties": {
                "uri": {
                  "type": "string",
                  "title": "Uri",
                  "description": "URL for deferred navigation link."
                }
              },
              "description": "Deferred link to the user's group memberships."
            }
          },
          "description": "Deferred link to the user's group memberships."
        },
        "UserId": {
          "type": "object",
          "title": "User Id",
          "required": [
            "NameId",
            "NameIdIssuer"
          ],
          "properties": {
            "NameId": {
              "type": "string",
              "title": "Name Id",
              "description": "Name identifier of the user."
            },
            "NameIdIssuer": {
              "type": "string",
              "title": "Name Id Issuer",
              "description": "Issuer of the name identifier."
            }
          },
          "description": "User ID info with NameId and NameIdIssuer."
        },
        "LoginName": {
          "type": "string",
          "title": "Login Name",
          "description": "User's login name."
        },
        "IsSiteAdmin": {
          "type": "boolean",
          "title": "Is Site Admin",
          "description": "Whether the user is a site collection administrator."
        },
        "PrincipalType": {
          "type": "integer",
          "title": "Principal Type",
          "description": "Principal type bit flags (1=User, 4=SecurityGroup, 8=DistributionList)."
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

## SHARE_POINT_FOLLOW
Follow a SharePoint user, document, site, or tag. Use to make the authenticated user follow a specified actor. Supports following users (actor_type=0), documents (actor_type=1), sites (actor_type=2), or tags (actor_type=3).

**Input schema:**
```json
{
  "type": "object",
  "title": "FollowRequest",
  "required": [
    "actor_type"
  ],
  "properties": {
    "tag_guid": {
      "type": "string",
      "title": "Tag Guid",
      "format": "uuid",
      "description": "GUID of the tag when actor_type=3."
    },
    "site_name": {
      "type": "string",
      "title": "Site Name",
      "description": "The subsite name to scope the request to (e.g., 'composio-test'). If omitted, the root site is used. When provided, the API base URL becomes https://{tenant}.sharepoint.com/sites/{site}."
    },
    "actor_type": {
      "enum": [
        0,
        1,
        2,
        3
      ],
      "type": "integer",
      "title": "Actor Type",
      "examples": [
        0,
        1,
        2,
        3
      ],
      "description": "Type of the actor to follow: 0=user, 1=document, 2=site, 3=tag."
    },
    "content_uri": {
      "type": "string",
      "title": "Content Uri",
      "description": "URI of the document or site when actor_type=1 or 2, e.g., 'http://server/site'."
    },
    "account_name": {
      "type": "string",
      "title": "Account Name",
      "description": "Account name for a user when actor_type=0, in claims format, e.g., 'i:0#.f|membership|user@domain.com'."
    }
  },
  "description": "Request parameters to follow a SharePoint actor.",
  "additionalProperties": false
}
```

**Output schema:**
```json
{
  "type": "object",
  "$defs": {
    "FollowResponse": {
      "type": "object",
      "title": "FollowResponse",
      "required": [
        "follow"
      ],
      "properties": {
        "follow": {
          "enum": [
            0,
            1,
            2,
            3
          ],
          "type": "integer",
          "title": "Follow",
          "description": "Result of follow operation: 0=OK; 1=AlreadyFollowing; 2=LimitReached; 3=InternalError."
        }
      },
      "description": "Response model with follow result code."
    }
  },
  "title": "FollowResponseWrapper",
  "required": [
    "data",
    "successful"
  ],
  "properties": {
    "data": {
      "type": "object",
      "title": "Data",
      "required": [
        "follow"
      ],
      "properties": {
        "follow": {
          "enum": [
            0,
            1,
            2,
            3
          ],
          "type": "integer",
          "title": "Follow",
          "description": "Result of follow operation: 0=OK; 1=AlreadyFollowing; 2=LimitReached; 3=InternalError."
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

## SHARE_POINT_GET_ALL_FOLDERS
Tool to retrieve all folders in the SharePoint web. Use when you need to discover all available folders across the site. Supports OData query parameters for filtering, selecting specific fields, sorting, and pagination.

**Input schema:**
```json
{
  "type": "object",
  "title": "GetAllFoldersRequest",
  "example": {
    "top": 100,
    "site": "composio-test",
    "select": "Name,ServerRelativeUrl,ItemCount",
    "orderby": "Name asc"
  },
  "properties": {
    "top": {
      "type": "integer",
      "title": "Top",
      "minimum": 1,
      "examples": [
        50
      ],
      "description": "OData $top to limit the number of folders returned."
    },
    "expand": {
      "type": "string",
      "title": "Expand",
      "examples": [
        "Files,Folders"
      ],
      "description": "OData $expand to include related entities such as 'Files,Folders,ListItemAllFields'."
    },
    "filter": {
      "type": "string",
      "title": "Filter",
      "examples": [
        "ItemCount gt 0"
      ],
      "description": "OData $filter to narrow results based on folder properties."
    },
    "select": {
      "type": "string",
      "title": "Select",
      "examples": [
        "Name,ServerRelativeUrl,ItemCount"
      ],
      "description": "OData $select to specify which folder fields to return (comma-separated), e.g., 'Name,ServerRelativeUrl,ItemCount'."
    },
    "tenant": {
      "type": "string",
      "title": "Tenant",
      "examples": [
        "composio2024"
      ],
      "description": "The SharePoint tenant name (e.g., 'composio2024' for composio2024.sharepoint.com). This parameter is not used; tenant information is derived from the authenticated connection."
    },
    "orderby": {
      "type": "string",
      "title": "Orderby",
      "examples": [
        "Name asc"
      ],
      "description": "OData $orderby to sort results, e.g., 'Name asc' or 'TimeCreated desc'."
    },
    "site_name": {
      "type": "string",
      "title": "Site Name",
      "examples": [
        "composio-test"
      ],
      "description": "The subsite name to scope the request to (e.g., 'composio-test'). If omitted, the root site is used. When provided, the API base URL becomes https://{tenant}.sharepoint.com/sites/{site}."
    }
  },
  "description": "Optional OData query parameters for retrieving all folders in SharePoint web.",
  "additionalProperties": false
}
```

**Output schema:**
```json
{
  "type": "object",
  "$defs": {
    "GetAllFoldersResponse": {
      "type": "object",
      "title": "GetAllFoldersResponse",
      "required": [
        "folders"
      ],
      "properties": {
        "folders": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "SharePointFolderMetadata",
            "properties": {
              "Name": {
                "type": "string",
                "title": "Name",
                "description": "Name of the folder."
              },
              "Exists": {
                "type": "boolean",
                "title": "Exists",
                "description": "Whether the folder exists."
              },
              "UniqueId": {
                "type": "string",
                "title": "Unique Id",
                "description": "Unique identifier (GUID) of the folder."
              },
              "ItemCount": {
                "type": "integer",
                "title": "Item Count",
                "description": "Number of items in the folder."
              },
              "TimeCreated": {
                "type": "string",
                "title": "Time Created",
                "description": "ISO 8601 timestamp when the folder was created."
              },
              "WelcomePage": {
                "type": "string",
                "title": "Welcome Page",
                "description": "Welcome page URL for the folder if set."
              },
              "TimeLastModified": {
                "type": "string",
                "title": "Time Last Modified",
                "description": "ISO 8601 timestamp when the folder was last modified."
              },
              "ServerRelativeUrl": {
                "type": "string",
                "title": "Server Relative Url",
                "description": "Server-relative URL path to the folder."
              }
            },
            "description": "SharePoint folder metadata and properties.",
            "additionalProperties": true
          },
          "title": "Folders",
          "description": "Array of folder objects with metadata. Each folder includes properties based on the $select parameter used."
        }
      },
      "description": "Response model containing list of all folders in the SharePoint web."
    },
    "SharePointFolderMetadata": {
      "type": "object",
      "title": "SharePointFolderMetadata",
      "properties": {
        "Name": {
          "type": "string",
          "title": "Name",
          "description": "Name of the folder."
        },
        "Exists": {
          "type": "boolean",
          "title": "Exists",
          "description": "Whether the folder exists."
        },
        "UniqueId": {
          "type": "string",
          "title": "Unique Id",
          "description": "Unique identifier (GUID) of the folder."
        },
        "ItemCount": {
          "type": "integer",
          "title": "Item Count",
          "description": "Number of items in the folder."
        },
        "TimeCreated": {
          "type": "string",
          "title": "Time Created",
          "description": "ISO 8601 timestamp when the folder was created."
        },
        "WelcomePage": {
          "type": "string",
          "title": "Welcome Page",
          "description": "Welcome page URL for the folder if set."
        },
        "TimeLastModified": {
          "type": "string",
          "title": "Time Last Modified",
          "description": "ISO 8601 timestamp when the folder was last modified."
        },
        "ServerRelativeUrl": {
          "type": "string",
          "title": "Server Relative Url",
          "description": "Server-relative URL path to the folder."
        }
      },
      "description": "SharePoint folder metadata and properties.",
      "additionalProperties": true
    }
  },
  "title": "GetAllFoldersResponseWrapper",
  "required": [
    "data",
    "successful"
  ],
  "properties": {
    "data": {
      "type": "object",
      "title": "Data",
      "required": [
        "folders"
      ],
      "properties": {
        "folders": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "SharePointFolderMetadata",
            "properties": {
              "Name": {
                "type": "string",
                "title": "Name",
                "description": "Name of the folder."
              },
              "Exists": {
                "type": "boolean",
                "title": "Exists",
                "description": "Whether the folder exists."
              },
              "UniqueId": {
                "type": "string",
                "title": "Unique Id",
                "description": "Unique identifier (GUID) of the folder."
              },
              "ItemCount": {
                "type": "integer",
                "title": "Item Count",
                "description": "Number of items in the folder."
              },
              "TimeCreated": {
                "type": "string",
                "title": "Time Created",
                "description": "ISO 8601 timestamp when the folder was created."
              },
              "WelcomePage": {
                "type": "string",
                "title": "Welcome Page",
                "description": "Welcome page URL for the folder if set."
              },
              "TimeLastModified": {
                "type": "string",
                "title": "Time Last Modified",
                "description": "ISO 8601 timestamp when the folder was last modified."
              },
              "ServerRelativeUrl": {
                "type": "string",
                "title": "Server Relative Url",
                "description": "Server-relative URL path to the folder."
              }
            },
            "description": "SharePoint folder metadata and properties.",
            "additionalProperties": true
          },
          "title": "Folders",
          "description": "Array of folder objects with metadata. Each folder includes properties based on the $select parameter used."
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

## SHARE_POINT_GET_CHANGES
Tool to retrieve changes from SharePoint list change log. Use when processing webhook notifications to get actual changes that occurred. Set boolean flags in query (Add, Item, Update, etc.) to filter change types. Store the ChangeToken from the last change and use as ChangeTokenStart in subsequent calls to track only new changes.

**Input schema:**
```json
{
  "type": "object",
  "title": "GetChangesRequest",
  "required": [
    "list_id",
    "query"
  ],
  "properties": {
    "query": {
      "type": "object",
      "title": "Query",
      "properties": {
        "Add": {
          "type": "boolean",
          "title": "Add",
          "description": "Include changes for added objects (new items, files, folders, etc.)"
        },
        "Web": {
          "type": "boolean",
          "title": "Web",
          "description": "Include changes for webs (subsites)"
        },
        "File": {
          "type": "boolean",
          "title": "File",
          "description": "Include changes for files"
        },
        "Item": {
          "type": "boolean",
          "title": "Item",
          "description": "Include changes for list items"
        },
        "List": {
          "type": "boolean",
          "title": "List",
          "description": "Include changes for lists"
        },
        "Move": {
          "type": "boolean",
          "title": "Move",
          "description": "Include changes for moved objects"
        },
        "Site": {
          "type": "boolean",
          "title": "Site",
          "description": "Include changes for sites"
        },
        "User": {
          "type": "boolean",
          "title": "User",
          "description": "Include changes for users"
        },
        "View": {
          "type": "boolean",
          "title": "View",
          "description": "Include changes for views"
        },
        "Alert": {
          "type": "boolean",
          "title": "Alert",
          "description": "Include changes for alerts"
        },
        "Field": {
          "type": "boolean",
          "title": "Field",
          "description": "Include changes for fields (columns)"
        },
        "Group": {
          "type": "boolean",
          "title": "Group",
          "description": "Include changes for groups"
        },
        "Folder": {
          "type": "boolean",
          "title": "Folder",
          "description": "Include changes for folders"
        },
        "Rename": {
          "type": "boolean",
          "title": "Rename",
          "description": "Include changes for renamed objects"
        },
        "Update": {
          "type": "boolean",
          "title": "Update",
          "description": "Include changes for updated objects"
        },
        "Restore": {
          "type": "boolean",
          "title": "Restore",
          "description": "Include changes for restored objects (from recycle bin or backup)"
        },
        "FetchLimit": {
          "type": "integer",
          "title": "Fetch Limit",
          "minimum": 1,
          "description": "Maximum number of changes to return. Default is no limit."
        },
        "Navigation": {
          "type": "boolean",
          "title": "Navigation",
          "description": "Include changes for navigation structure"
        },
        "__metadata": {
          "type": "object",
          "title": "  Metadata",
          "default": {
            "type": "SP.ChangeQuery"
          },
          "description": "Metadata type for SharePoint ChangeQuery object",
          "additionalProperties": true
        },
        "ContentType": {
          "type": "boolean",
          "title": "Content Type",
          "description": "Include changes for content types"
        },
        "LatestFirst": {
          "type": "boolean",
          "title": "Latest First",
          "description": "Return changes in reverse chronological order (newest first)"
        },
        "DeleteObject": {
          "type": "boolean",
          "title": "Delete Object",
          "description": "Include changes for deleted objects"
        },
        "RecursiveAll": {
          "type": "boolean",
          "title": "Recursive All",
          "description": "Include changes for all items in folders recursively"
        },
        "SystemUpdate": {
          "type": "boolean",
          "title": "System Update",
          "description": "Include changes made via SystemUpdate method"
        },
        "ChangeTokenEnd": {
          "type": "string",
          "title": "Change Token End",
          "description": "Change token at which to stop retrieving changes"
        },
        "SecurityPolicy": {
          "type": "boolean",
          "title": "Security Policy",
          "description": "Include changes for security policies"
        },
        "ChangeTokenStart": {
          "type": "string",
          "title": "Change Token Start",
          "description": "Change token from which to start retrieving changes. Use the change token from previous GetChanges call to get only new changes since last check."
        },
        "RoleAssignmentAdd": {
          "type": "boolean",
          "title": "Role Assignment Add",
          "description": "Include changes for role assignments added (permissions granted)"
        },
        "RoleDefinitionAdd": {
          "type": "boolean",
          "title": "Role Definition Add",
          "description": "Include changes for role definitions added"
        },
        "GroupMembershipAdd": {
          "type": "boolean",
          "title": "Group Membership Add",
          "description": "Include changes for users added to groups"
        },
        "RequireSecurityTrim": {
          "type": "boolean",
          "title": "Require Security Trim",
          "description": "Apply security trimming to filter changes based on current user permissions"
        },
        "RoleAssignmentDelete": {
          "type": "boolean",
          "title": "Role Assignment Delete",
          "description": "Include changes for role assignments removed (permissions revoked)"
        },
        "RoleDefinitionDelete": {
          "type": "boolean",
          "title": "Role Definition Delete",
          "description": "Include changes for role definitions deleted"
        },
        "RoleDefinitionUpdate": {
          "type": "boolean",
          "title": "Role Definition Update",
          "description": "Include changes for role definitions updated"
        },
        "GroupMembershipDelete": {
          "type": "boolean",
          "title": "Group Membership Delete",
          "description": "Include changes for users removed from groups"
        }
      },
      "description": "Change query parameters specifying which types of changes to retrieve. Set boolean properties to True to include specific change types (e.g., Add=True, Item=True for new items).",
      "additionalProperties": false
    },
    "list_id": {
      "type": "string",
      "title": "List Id",
      "examples": [
        "a12e3d6e-9414-462d-bd53-cf06f3982ad3"
      ],
      "description": "GUID of the SharePoint list to get changes for, in canonical format, e.g., 'a12e3d6e-9414-462d-bd53-cf06f3982ad3'."
    },
    "site_name": {
      "type": "string",
      "title": "Site Name",
      "description": "The subsite name to scope the request to (e.g., 'composio-test'). If omitted, the root site is used. When provided, the API base URL becomes https://{tenant}.sharepoint.com/sites/{site}."
    }
  },
  "description": "Request model for retrieving changes from the SharePoint change log.",
  "additionalProperties": false
}
```

**Output schema:**
```json
{
  "type": "object",
  "$defs": {
    "ChangeItem": {
      "type": "object",
      "title": "ChangeItem",
      "properties": {
        "Time": {
          "type": "string",
          "title": "Time",
          "description": "Timestamp when the change occurred"
        },
        "Title": {
          "type": "string",
          "title": "Title",
          "description": "Title of the changed item"
        },
        "WebId": {
          "type": "string",
          "title": "Web Id",
          "description": "GUID of the web (subsite)"
        },
        "Editor": {
          "type": "string",
          "title": "Editor",
          "description": "User who made the change"
        },
        "ItemId": {
          "type": "integer",
          "title": "Item Id",
          "description": "ID of the item that changed"
        },
        "ListId": {
          "type": "string",
          "title": "List Id",
          "description": "GUID of the list containing the changed item"
        },
        "SiteId": {
          "type": "string",
          "title": "Site Id",
          "description": "GUID of the site collection"
        },
        "UniqueId": {
          "type": "string",
          "title": "Unique Id",
          "description": "Unique identifier of the changed object"
        },
        "ChangeType": {
          "type": "integer",
          "title": "Change Type",
          "description": "Type of change as integer (0=NoChange, 1=Add, 2=Update, 3=DeleteObject, 4=Rename, 5=MoveAway, 6=MoveInto, 7=Restore, 8=RoleAdd, 9=RoleDelete, 10=RoleUpdate, 11=AssignmentAdd, 12=AssignmentDelete, 13=MemberAdd, 14=MemberDelete, 15=SystemUpdate, 16=Navigation, 17=ScopeAdd, 18=ScopeDelete)"
        },
        "ChangeToken": {
          "type": "string",
          "title": "Change Token",
          "description": "Change token for this change. Store this to use as ChangeTokenStart in subsequent GetChanges calls."
        },
        "EditorEmailHint": {
          "type": "string",
          "title": "Editor Email Hint",
          "description": "Email hint for the editor"
        },
        "ServerRelativeUrl": {
          "type": "string",
          "title": "Server Relative Url",
          "description": "Server-relative URL of the changed object"
        }
      },
      "description": "A single change entry from the change log."
    },
    "GetChangesResponse": {
      "type": "object",
      "title": "GetChangesResponse",
      "required": [
        "changes"
      ],
      "properties": {
        "changes": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "ChangeItem",
            "properties": {
              "Time": {
                "type": "string",
                "title": "Time",
                "description": "Timestamp when the change occurred"
              },
              "Title": {
                "type": "string",
                "title": "Title",
                "description": "Title of the changed item"
              },
              "WebId": {
                "type": "string",
                "title": "Web Id",
                "description": "GUID of the web (subsite)"
              },
              "Editor": {
                "type": "string",
                "title": "Editor",
                "description": "User who made the change"
              },
              "ItemId": {
                "type": "integer",
                "title": "Item Id",
                "description": "ID of the item that changed"
              },
              "ListId": {
                "type": "string",
                "title": "List Id",
                "description": "GUID of the list containing the changed item"
              },
              "SiteId": {
                "type": "string",
                "title": "Site Id",
                "description": "GUID of the site collection"
              },
              "UniqueId": {
                "type": "string",
                "title": "Unique Id",
                "description": "Unique identifier of the changed object"
              },
              "ChangeType": {
                "type": "integer",
                "title": "Change Type",
                "description": "Type of change as integer (0=NoChange, 1=Add, 2=Update, 3=DeleteObject, 4=Rename, 5=MoveAway, 6=MoveInto, 7=Restore, 8=RoleAdd, 9=RoleDelete, 10=RoleUpdate, 11=AssignmentAdd, 12=AssignmentDelete, 13=MemberAdd, 14=MemberDelete, 15=SystemUpdate, 16=Navigation, 17=ScopeAdd, 18=ScopeDelete)"
              },
              "ChangeToken": {
                "type": "string",
                "title": "Change Token",
                "description": "Change token for this change. Store this to use as ChangeTokenStart in subsequent GetChanges calls."
              },
              "EditorEmailHint": {
                "type": "string",
                "title": "Editor Email Hint",
                "description": "Email hint for the editor"
              },
              "ServerRelativeUrl": {
                "type": "string",
                "title": "Server Relative Url",
                "description": "Server-relative URL of the changed object"
              }
            },
            "description": "A single change entry from the change log."
          },
          "title": "Changes",
          "description": "Array of change entries. Each change includes a ChangeToken that should be stored and used as ChangeTokenStart in the next GetChanges call to retrieve only new changes."
        }
      },
      "description": "Response model containing the list of changes from the change log."
    }
  },
  "title": "GetChangesResponseWrapper",
  "required": [
    "data",
    "successful"
  ],
  "properties": {
    "data": {
      "type": "object",
      "title": "Data",
      "required": [
        "changes"
      ],
      "properties": {
        "changes": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "ChangeItem",
            "properties": {
              "Time": {
                "type": "string",
                "title": "Time",
                "description": "Timestamp when the change occurred"
              },
              "Title": {
                "type": "string",
                "title": "Title",
                "description": "Title of the changed item"
              },
              "WebId": {
                "type": "string",
                "title": "Web Id",
                "description": "GUID of the web (subsite)"
              },
              "Editor": {
                "type": "string",
                "title": "Editor",
                "description": "User who made the change"
              },
              "ItemId": {
                "type": "integer",
                "title": "Item Id",
                "description": "ID of the item that changed"
              },
              "ListId": {
                "type": "string",
                "title": "List Id",
                "description": "GUID of the list containing the changed item"
              },
              "SiteId": {
                "type": "string",
                "title": "Site Id",
                "description": "GUID of the site collection"
              },
              "UniqueId": {
                "type": "string",
                "title": "Unique Id",
                "description": "Unique identifier of the changed object"
              },
              "ChangeType": {
                "type": "integer",
                "title": "Change Type",
                "description": "Type of change as integer (0=NoChange, 1=Add, 2=Update, 3=DeleteObject, 4=Rename, 5=MoveAway, 6=MoveInto, 7=Restore, 8=RoleAdd, 9=RoleDelete, 10=RoleUpdate, 11=AssignmentAdd, 12=AssignmentDelete, 13=MemberAdd, 14=MemberDelete, 15=SystemUpdate, 16=Navigation, 17=ScopeAdd, 18=ScopeDelete)"
              },
              "ChangeToken": {
                "type": "string",
                "title": "Change Token",
                "description": "Change token for this change. Store this to use as ChangeTokenStart in subsequent GetChanges calls."
              },
              "EditorEmailHint": {
                "type": "string",
                "title": "Editor Email Hint",
                "description": "Email hint for the editor"
              },
              "ServerRelativeUrl": {
                "type": "string",
                "title": "Server Relative Url",
                "description": "Server-relative URL of the changed object"
              }
            },
            "description": "A single change entry from the change log."
          },
          "title": "Changes",
          "description": "Array of change entries. Each change includes a ChangeToken that should be stored and used as ChangeTokenStart in the next GetChanges call to retrieve only new changes."
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

## SHARE_POINT_GET_CONTENT_TYPE
Tool to retrieve a single SharePoint content type by its ID. Use when you need detailed information about a specific content type including its fields, forms, and metadata.

**Input schema:**
```json
{
  "type": "object",
  "title": "GetContentTypeRequest",
  "required": [
    "content_type_id"
  ],
  "properties": {
    "site_name": {
      "type": "string",
      "title": "Site Name",
      "examples": [
        "composio-test",
        "team-site"
      ],
      "description": "The subsite name to scope the request to (e.g., 'composio-test'). If omitted, the root site is used. When provided, the API base URL becomes https://{tenant}.sharepoint.com/sites/{site}."
    },
    "content_type_id": {
      "type": "string",
      "title": "Content Type Id",
      "examples": [
        "0x01",
        "0x0101",
        "0x0120"
      ],
      "description": "The unique identifier of the content type to retrieve. This can be the hexadecimal content type ID (e.g., '0x01' for Item, '0x0101' for Document) or the string representation. Common IDs: '0x01' (Item), '0x0101' (Document), '0x0120' (Folder)."
    }
  },
  "description": "Request model for retrieving a single SharePoint content type by ID."
}
```

**Output schema:**
```json
{
  "type": "object",
  "$defs": {
    "ContentTypeId": {
      "type": "object",
      "title": "ContentTypeId",
      "required": [
        "StringValue"
      ],
      "properties": {
        "StringValue": {
          "type": "string",
          "title": "String Value",
          "description": "String representation of the content type ID."
        }
      },
      "description": "Model for the content type ID object."
    },
    "GetContentTypeResponse": {
      "type": "object",
      "title": "GetContentTypeResponse",
      "required": [
        "Id",
        "Name"
      ],
      "properties": {
        "Id": {
          "type": "object",
          "title": "Id",
          "required": [
            "StringValue"
          ],
          "properties": {
            "StringValue": {
              "type": "string",
              "title": "String Value",
              "description": "String representation of the content type ID."
            }
          },
          "description": "Content type ID object containing the string representation."
        },
        "Name": {
          "type": "string",
          "title": "Name",
          "description": "Name of the content type (e.g., 'Item', 'Document', 'Folder', 'Task')."
        },
        "Group": {
          "type": "string",
          "title": "Group",
          "description": "Content type group category (e.g., 'List Content Types', 'Document Content Types', 'Folder Content Types')."
        },
        "Scope": {
          "type": "string",
          "title": "Scope",
          "description": "Scope of the content type (e.g., site collection, web)."
        },
        "Hidden": {
          "type": "boolean",
          "title": "Hidden",
          "description": "Indicates whether the content type is hidden from the user interface."
        },
        "JSLink": {
          "type": "string",
          "title": "Js Link",
          "description": "JavaScript link or file associated with this content type for customization."
        },
        "Sealed": {
          "type": "boolean",
          "title": "Sealed",
          "description": "Indicates whether the content type is sealed and cannot be customized further."
        },
        "ReadOnly": {
          "type": "boolean",
          "title": "Read Only",
          "description": "Indicates whether the content type is read-only and cannot be modified."
        },
        "StringId": {
          "type": "string",
          "title": "String Id",
          "description": "String representation of the content type ID (convenience field, same as Id.StringValue)."
        },
        "SchemaXml": {
          "type": "string",
          "title": "Schema Xml",
          "description": "XML schema defining the content type structure and fields."
        },
        "NewFormUrl": {
          "type": "string",
          "title": "New Form Url",
          "description": "Server-relative URL of the new item form for this content type."
        },
        "Description": {
          "type": "string",
          "title": "Description",
          "description": "Description of the content type explaining its purpose."
        },
        "EditFormUrl": {
          "type": "string",
          "title": "Edit Form Url",
          "description": "Server-relative URL of the edit form for this content type."
        },
        "DisplayFormUrl": {
          "type": "string",
          "title": "Display Form Url",
          "description": "Server-relative URL of the display form for this content type."
        },
        "DocumentTemplate": {
          "type": "string",
          "title": "Document Template",
          "description": "Document template associated with this content type."
        },
        "MobileNewFormUrl": {
          "type": "string",
          "title": "Mobile New Form Url",
          "description": "Server-relative URL of the mobile new item form."
        },
        "MobileEditFormUrl": {
          "type": "string",
          "title": "Mobile Edit Form Url",
          "description": "Server-relative URL of the mobile edit form."
        },
        "DocumentTemplateUrl": {
          "type": "string",
          "title": "Document Template Url",
          "description": "Server-relative URL of the document template."
        },
        "NewFormTemplateName": {
          "type": "string",
          "title": "New Form Template Name",
          "description": "Name of the new form template used by this content type."
        },
        "EditFormTemplateName": {
          "type": "string",
          "title": "Edit Form Template Name",
          "description": "Name of the edit form template used by this content type."
        },
        "MobileDisplayFormUrl": {
          "type": "string",
          "title": "Mobile Display Form Url",
          "description": "Server-relative URL of the mobile display form."
        },
        "DisplayFormTemplateName": {
          "type": "string",
          "title": "Display Form Template Name",
          "description": "Name of the display form template used by this content type."
        }
      },
      "description": "Response model containing a single SharePoint content type."
    }
  },
  "title": "GetContentTypeResponseWrapper",
  "required": [
    "data",
    "successful"
  ],
  "properties": {
    "data": {
      "type": "object",
      "title": "Data",
      "required": [
        "Id",
        "Name"
      ],
      "properties": {
        "Id": {
          "type": "object",
          "title": "Id",
          "required": [
            "StringValue"
          ],
          "properties": {
            "StringValue": {
              "type": "string",
              "title": "String Value",
              "description": "String representation of the content type ID."
            }
          },
          "description": "Content type ID object containing the string representation."
        },
        "Name": {
          "type": "string",
          "title": "Name",
          "description": "Name of the content type (e.g., 'Item', 'Document', 'Folder', 'Task')."
        },
        "Group": {
          "type": "string",
          "title": "Group",
          "description": "Content type group category (e.g., 'List Content Types', 'Document Content Types', 'Folder Content Types')."
        },
        "Scope": {
          "type": "string",
          "title": "Scope",
          "description": "Scope of the content type (e.g., site collection, web)."
        },
        "Hidden": {
          "type": "boolean",
          "title": "Hidden",
          "description": "Indicates whether the content type is hidden from the user interface."
        },
        "JSLink": {
          "type": "string",
          "title": "Js Link",
          "description": "JavaScript link or file associated with this content type for customization."
        },
        "Sealed": {
          "type": "boolean",
          "title": "Sealed",
          "description": "Indicates whether the content type is sealed and cannot be customized further."
        },
        "ReadOnly": {
          "type": "boolean",
          "title": "Read Only",
          "description": "Indicates whether the content type is read-only and cannot be modified."
        },
        "StringId": {
          "type": "string",
          "title": "String Id",
          "description": "String representation of the content type ID (convenience field, same as Id.StringValue)."
        },
        "SchemaXml": {
          "type": "string",
          "title": "Schema Xml",
          "description": "XML schema defining the content type structure and fields."
        },
        "NewFormUrl": {
          "type": "string",
          "title": "New Form Url",
          "description": "Server-relative URL of the new item form for this content type."
        },
        "Description": {
          "type": "string",
          "title": "Description",
          "description": "Description of the content type explaining its purpose."
        },
        "EditFormUrl": {
          "type": "string",
          "title": "Edit Form Url",
          "description": "Server-relative URL of the edit form for this content type."
        },
        "DisplayFormUrl": {
          "type": "string",
          "title": "Display Form Url",
          "description": "Server-relative URL of the display form for this content type."
        },
        "DocumentTemplate": {
          "type": "string",
          "title": "Document Template",
          "description": "Document template associated with this content type."
        },
        "MobileNewFormUrl": {
          "type": "string",
          "title": "Mobile New Form Url",
          "description": "Server-relative URL of the mobile new item form."
        },
        "MobileEditFormUrl": {
          "type": "string",
          "title": "Mobile Edit Form Url",
          "description": "Server-relative URL of the mobile edit form."
        },
        "DocumentTemplateUrl": {
          "type": "string",
          "title": "Document Template Url",
          "description": "Server-relative URL of the document template."
        },
        "NewFormTemplateName": {
          "type": "string",
          "title": "New Form Template Name",
          "description": "Name of the new form template used by this content type."
        },
        "EditFormTemplateName": {
          "type": "string",
          "title": "Edit Form Template Name",
          "description": "Name of the edit form template used by this content type."
        },
        "MobileDisplayFormUrl": {
          "type": "string",
          "title": "Mobile Display Form Url",
          "description": "Server-relative URL of the mobile display form."
        },
        "DisplayFormTemplateName": {
          "type": "string",
          "title": "Display Form Template Name",
          "description": "Name of the display form template used by this content type."
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

## SHARE_POINT_GET_CONTENT_TYPES
Retrieves all content types from the current SharePoint site. Use this action to discover available content types on a SharePoint site. Returns metadata for each content type including Id, Name, Description, Group, and other properties. Supports OData query parameters for filtering, selecting specific fields, sorting, and pagination.

**Input schema:**
```json
{
  "type": "object",
  "title": "GetContentTypesRequest",
  "properties": {
    "top": {
      "type": "integer",
      "title": "Top",
      "minimum": 1,
      "examples": [
        10
      ],
      "description": "OData $top to limit the number of results."
    },
    "expand": {
      "type": "string",
      "title": "Expand",
      "examples": [
        "Fields"
      ],
      "description": "OData $expand to include related entities."
    },
    "filter": {
      "type": "string",
      "title": "Filter",
      "examples": [
        "Hidden eq false"
      ],
      "description": "OData $filter to narrow results, e.g., 'Hidden eq false'."
    },
    "select": {
      "type": "string",
      "title": "Select",
      "examples": [
        "Name,Id,Description"
      ],
      "description": "OData $select to specify which content type fields to return, e.g., 'Name,Id,Description'."
    },
    "orderby": {
      "type": "string",
      "title": "Orderby",
      "examples": [
        "Name asc"
      ],
      "description": "OData $orderby to sort results, e.g., 'Name asc'."
    },
    "site_name": {
      "type": "string",
      "title": "Site Name",
      "examples": [
        "composio-test"
      ],
      "description": "The subsite name to scope the request to (e.g., 'composio-test'). If omitted, the root site is used. When provided, the API base URL becomes https://{tenant}.sharepoint.com/sites/{site}."
    },
    "skiptoken": {
      "type": "string",
      "title": "Skiptoken",
      "examples": [
        "Paged=TRUE&p_ID=15"
      ],
      "description": "OData $skiptoken for paging through results."
    }
  },
  "description": "Optional OData query parameters for retrieving all SharePoint site content types.",
  "additionalProperties": false
}
```

**Output schema:**
```json
{
  "type": "object",
  "$defs": {
    "ContentType": {
      "type": "object",
      "title": "ContentType",
      "required": [
        "Id",
        "Name"
      ],
      "properties": {
        "Id": {
          "type": "object",
          "title": "Id",
          "required": [
            "StringValue"
          ],
          "properties": {
            "StringValue": {
              "type": "string",
              "title": "String Value",
              "description": "String representation of the content type ID (Id.StringValue)."
            }
          },
          "description": "Content type ID object. Use Id.StringValue for the string ID."
        },
        "Name": {
          "type": "string",
          "title": "Name",
          "description": "Name of the content type, e.g., 'Item', 'Folder', 'Task'."
        },
        "Group": {
          "type": "string",
          "title": "Group",
          "description": "Content type group, e.g., 'List Content Types', 'Folder Content Types'."
        },
        "Hidden": {
          "type": "boolean",
          "title": "Hidden",
          "description": "Whether the content type is hidden from the user interface."
        },
        "Sealed": {
          "type": "boolean",
          "title": "Sealed",
          "description": "Whether the content type is sealed and cannot be customized."
        },
        "ReadOnly": {
          "type": "boolean",
          "title": "Read Only",
          "description": "Whether the content type is read-only and cannot be modified."
        },
        "StringId": {
          "type": "string",
          "title": "String Id",
          "description": "String representation of the content type ID (convenience field, same as Id.StringValue)."
        },
        "Description": {
          "type": "string",
          "title": "Description",
          "description": "Description of the content type, e.g., 'Create a new list item.'."
        }
      },
      "description": "Model representing a SharePoint content type."
    },
    "ContentTypeId": {
      "type": "object",
      "title": "ContentTypeId",
      "required": [
        "StringValue"
      ],
      "properties": {
        "StringValue": {
          "type": "string",
          "title": "String Value",
          "description": "String representation of the content type ID (Id.StringValue)."
        }
      },
      "description": "Model for the content type ID object."
    },
    "GetContentTypesResponse": {
      "type": "object",
      "title": "GetContentTypesResponse",
      "required": [
        "content_types"
      ],
      "properties": {
        "content_types": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "ContentType",
            "required": [
              "Id",
              "Name"
            ],
            "properties": {
              "Id": {
                "type": "object",
                "title": "Id",
                "required": [
                  "StringValue"
                ],
                "properties": {
                  "StringValue": {
                    "type": "string",
                    "title": "String Value",
                    "description": "String representation of the content type ID (Id.StringValue)."
                  }
                },
                "description": "Content type ID object. Use Id.StringValue for the string ID."
              },
              "Name": {
                "type": "string",
                "title": "Name",
                "description": "Name of the content type, e.g., 'Item', 'Folder', 'Task'."
              },
              "Group": {
                "type": "string",
                "title": "Group",
                "description": "Content type group, e.g., 'List Content Types', 'Folder Content Types'."
              },
              "Hidden": {
                "type": "boolean",
                "title": "Hidden",
                "description": "Whether the content type is hidden from the user interface."
              },
              "Sealed": {
                "type": "boolean",
                "title": "Sealed",
                "description": "Whether the content type is sealed and cannot be customized."
              },
              "ReadOnly": {
                "type": "boolean",
                "title": "Read Only",
                "description": "Whether the content type is read-only and cannot be modified."
              },
              "StringId": {
                "type": "string",
                "title": "String Id",
                "description": "String representation of the content type ID (convenience field, same as Id.StringValue)."
              },
              "Description": {
                "type": "string",
                "title": "Description",
                "description": "Description of the content type, e.g., 'Create a new list item.'."
              }
            },
            "description": "Model representing a SharePoint content type."
          },
          "title": "Content Types",
          "description": "List of content types for the SharePoint site."
        }
      },
      "description": "Response model containing a list of content types."
    }
  },
  "title": "GetContentTypesResponseWrapper",
  "required": [
    "data",
    "successful"
  ],
  "properties": {
    "data": {
      "type": "object",
      "title": "Data",
      "required": [
        "content_types"
      ],
      "properties": {
        "content_types": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "ContentType",
            "required": [
              "Id",
              "Name"
            ],
            "properties": {
              "Id": {
                "type": "object",
                "title": "Id",
                "required": [
                  "StringValue"
                ],
                "properties": {
                  "StringValue": {
                    "type": "string",
                    "title": "String Value",
                    "description": "String representation of the content type ID (Id.StringValue)."
                  }
                },
                "description": "Content type ID object. Use Id.StringValue for the string ID."
              },
              "Name": {
                "type": "string",
                "title": "Name",
                "description": "Name of the content type, e.g., 'Item', 'Folder', 'Task'."
              },
              "Group": {
                "type": "string",
                "title": "Group",
                "description": "Content type group, e.g., 'List Content Types', 'Folder Content Types'."
              },
              "Hidden": {
                "type": "boolean",
                "title": "Hidden",
                "description": "Whether the content type is hidden from the user interface."
              },
              "Sealed": {
                "type": "boolean",
                "title": "Sealed",
                "description": "Whether the content type is sealed and cannot be customized."
              },
              "ReadOnly": {
                "type": "boolean",
                "title": "Read Only",
                "description": "Whether the content type is read-only and cannot be modified."
              },
              "StringId": {
                "type": "string",
                "title": "String Id",
                "description": "String representation of the content type ID (convenience field, same as Id.StringValue)."
              },
              "Description": {
                "type": "string",
                "title": "Description",
                "description": "Description of the content type, e.g., 'Create a new list item.'."
              }
            },
            "description": "Model representing a SharePoint content type."
          },
          "title": "Content Types",
          "description": "List of content types for the SharePoint site."
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

## SHARE_POINT_GET_CONTENT_TYPES_FOR_LIST
Tool to retrieve all content types for a specific SharePoint list by GUID. Use when you need the content type IDs, names, and descriptions of every content type in a list.

**Input schema:**
```json
{
  "type": "object",
  "title": "GetContentTypesForListRequest",
  "required": [
    "list_guid"
  ],
  "properties": {
    "list_guid": {
      "type": "string",
      "title": "List Guid",
      "examples": [
        "01234567-89ab-cdef-0123-456789abcdef"
      ],
      "description": "GUID of the SharePoint list to retrieve content types for, in canonical format, e.g., '01234567-89ab-cdef-0123-456789abcdef'."
    },
    "site_name": {
      "type": "string",
      "title": "Site Name",
      "examples": [
        "composio-test"
      ],
      "description": "The subsite name to scope the request to (e.g., 'composio-test'). If omitted, the root site is used. When provided, the API base URL becomes 'https://{tenant}.sharepoint.com/sites/{site}'."
    }
  },
  "description": "Request model for retrieving content types of a SharePoint list by GUID."
}
```

**Output schema:**
```json
{
  "type": "object",
  "$defs": {
    "ContentType": {
      "type": "object",
      "title": "ContentType",
      "required": [
        "Id",
        "Name"
      ],
      "properties": {
        "Id": {
          "type": "object",
          "title": "Id",
          "required": [
            "StringValue"
          ],
          "properties": {
            "StringValue": {
              "type": "string",
              "title": "String Value",
              "description": "String representation of the content type ID (Id.StringValue)."
            }
          },
          "description": "Content type ID object. Use Id.StringValue for the string ID."
        },
        "Name": {
          "type": "string",
          "title": "Name",
          "description": "Name of the content type, e.g., 'Item', 'Folder', 'Task'."
        },
        "Group": {
          "type": "string",
          "title": "Group",
          "description": "Content type group category (e.g., 'List Content Types', 'Folder Content Types')."
        },
        "Hidden": {
          "type": "boolean",
          "title": "Hidden",
          "description": "Whether the content type is hidden from the user interface."
        },
        "Sealed": {
          "type": "boolean",
          "title": "Sealed",
          "description": "Whether the content type is sealed and cannot be customized."
        },
        "ReadOnly": {
          "type": "boolean",
          "title": "Read Only",
          "description": "Whether the content type is read-only and cannot be modified."
        },
        "StringId": {
          "type": "string",
          "title": "String Id",
          "description": "String representation of the content type ID (alternative to Id.StringValue)."
        },
        "Description": {
          "type": "string",
          "title": "Description",
          "description": "Description of the content type, e.g., 'Create a new list item.'."
        }
      },
      "description": "Model representing a SharePoint content type."
    },
    "ContentTypeId": {
      "type": "object",
      "title": "ContentTypeId",
      "required": [
        "StringValue"
      ],
      "properties": {
        "StringValue": {
          "type": "string",
          "title": "String Value",
          "description": "String representation of the content type ID (Id.StringValue)."
        }
      },
      "description": "Model for the content type ID object."
    },
    "GetContentTypesForListResponse": {
      "type": "object",
      "title": "GetContentTypesForListResponse",
      "required": [
        "content_types"
      ],
      "properties": {
        "content_types": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "ContentType",
            "required": [
              "Id",
              "Name"
            ],
            "properties": {
              "Id": {
                "type": "object",
                "title": "Id",
                "required": [
                  "StringValue"
                ],
                "properties": {
                  "StringValue": {
                    "type": "string",
                    "title": "String Value",
                    "description": "String representation of the content type ID (Id.StringValue)."
                  }
                },
                "description": "Content type ID object. Use Id.StringValue for the string ID."
              },
              "Name": {
                "type": "string",
                "title": "Name",
                "description": "Name of the content type, e.g., 'Item', 'Folder', 'Task'."
              },
              "Group": {
                "type": "string",
                "title": "Group",
                "description": "Content type group category (e.g., 'List Content Types', 'Folder Content Types')."
              },
              "Hidden": {
                "type": "boolean",
                "title": "Hidden",
                "description": "Whether the content type is hidden from the user interface."
              },
              "Sealed": {
                "type": "boolean",
                "title": "Sealed",
                "description": "Whether the content type is sealed and cannot be customized."
              },
              "ReadOnly": {
                "type": "boolean",
                "title": "Read Only",
                "description": "Whether the content type is read-only and cannot be modified."
              },
              "StringId": {
                "type": "string",
                "title": "String Id",
                "description": "String representation of the content type ID (alternative to Id.StringValue)."
              },
              "Description": {
                "type": "string",
                "title": "Description",
                "description": "Description of the content type, e.g., 'Create a new list item.'."
              }
            },
            "description": "Model representing a SharePoint content type."
          },
          "title": "Content Types",
          "description": "List of content types for the specified SharePoint list."
        }
      },
      "description": "Response model containing a list of content types."
    }
  },
  "title": "GetContentTypesForListResponseWrapper",
  "required": [
    "data",
    "successful"
  ],
  "properties": {
    "data": {
      "type": "object",
      "title": "Data",
      "required": [
        "content_types"
      ],
      "properties": {
        "content_types": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "ContentType",
            "required": [
              "Id",
              "Name"
            ],
            "properties": {
              "Id": {
                "type": "object",
                "title": "Id",
                "required": [
                  "StringValue"
                ],
                "properties": {
                  "StringValue": {
                    "type": "string",
                    "title": "String Value",
                    "description": "String representation of the content type ID (Id.StringValue)."
                  }
                },
                "description": "Content type ID object. Use Id.StringValue for the string ID."
              },
              "Name": {
                "type": "string",
                "title": "Name",
                "description": "Name of the content type, e.g., 'Item', 'Folder', 'Task'."
              },
              "Group": {
                "type": "string",
                "title": "Group",
                "description": "Content type group category (e.g., 'List Content Types', 'Folder Content Types')."
              },
              "Hidden": {
                "type": "boolean",
                "title": "Hidden",
                "description": "Whether the content type is hidden from the user interface."
              },
              "Sealed": {
                "type": "boolean",
                "title": "Sealed",
                "description": "Whether the content type is sealed and cannot be customized."
              },
              "ReadOnly": {
                "type": "boolean",
                "title": "Read Only",
                "description": "Whether the content type is read-only and cannot be modified."
              },
              "StringId": {
                "type": "string",
                "title": "String Id",
                "description": "String representation of the content type ID (alternative to Id.StringValue)."
              },
              "Description": {
                "type": "string",
                "title": "Description",
                "description": "Description of the content type, e.g., 'Create a new list item.'."
              }
            },
            "description": "Model representing a SharePoint content type."
          },
          "title": "Content Types",
          "description": "List of content types for the specified SharePoint list."
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

## SHARE_POINT_GET_CONTEXT_INFO
Tool to retrieve SharePoint context information including the form digest value. Use when you need a form digest token for write operations (POST, PUT, DELETE).

**Input schema:**
```json
{
  "type": "object",
  "title": "GetContextInfoRequest",
  "properties": {
    "site_name": {
      "type": "string",
      "title": "Site Name",
      "description": "The subsite name to scope the request to (e.g., `composio-test`). If omitted, the root site is used. When provided, the API base URL becomes `https://{tenant}.sharepoint.com/sites/{site}`."
    }
  },
  "description": "Request model for retrieving context info.",
  "additionalProperties": false
}
```

**Output schema:**
```json
{
  "type": "object",
  "$defs": {
    "GetContextInfoResponse": {
      "type": "object",
      "title": "GetContextInfoResponse",
      "required": [
        "GetContextWebInformation"
      ],
      "properties": {
        "GetContextWebInformation": {
          "type": "object",
          "title": "Get Context Web Information",
          "required": [
            "FormDigestValue",
            "FormDigestTimeoutSeconds"
          ],
          "properties": {
            "WebFullUrl": {
              "type": "string",
              "title": "Web Full Url",
              "description": "Full URL of the current web."
            },
            "SiteFullUrl": {
              "type": "string",
              "title": "Site Full Url",
              "description": "Full URL of the SharePoint site."
            },
            "LibraryVersion": {
              "type": "string",
              "title": "Library Version",
              "description": "Version of the SharePoint library."
            },
            "FormDigestValue": {
              "type": "string",
              "title": "Form Digest Value",
              "description": "Form digest value required for write operations (POST, PUT, DELETE). Include this in the X-RequestDigest header."
            },
            "SupportedSchemaVersions": {
              "type": "array",
              "items": {
                "type": "string"
              },
              "title": "Supported Schema Versions",
              "description": "List of supported schema versions."
            },
            "FormDigestTimeoutSeconds": {
              "type": "integer",
              "title": "Form Digest Timeout Seconds",
              "description": "Number of seconds until the form digest value expires and a new one must be requested."
            }
          },
          "description": "Context information object containing form digest and other details."
        }
      },
      "description": "Response containing context information."
    },
    "GetContextWebInformation": {
      "type": "object",
      "title": "GetContextWebInformation",
      "required": [
        "FormDigestValue",
        "FormDigestTimeoutSeconds"
      ],
      "properties": {
        "WebFullUrl": {
          "type": "string",
          "title": "Web Full Url",
          "description": "Full URL of the current web."
        },
        "SiteFullUrl": {
          "type": "string",
          "title": "Site Full Url",
          "description": "Full URL of the SharePoint site."
        },
        "LibraryVersion": {
          "type": "string",
          "title": "Library Version",
          "description": "Version of the SharePoint library."
        },
        "FormDigestValue": {
          "type": "string",
          "title": "Form Digest Value",
          "description": "Form digest value required for write operations (POST, PUT, DELETE). Include this in the X-RequestDigest header."
        },
        "SupportedSchemaVersions": {
          "type": "array",
          "items": {
            "type": "string"
          },
          "title": "Supported Schema Versions",
          "description": "List of supported schema versions."
        },
        "FormDigestTimeoutSeconds": {
          "type": "integer",
          "title": "Form Digest Timeout Seconds",
          "description": "Number of seconds until the form digest value expires and a new one must be requested."
        }
      },
      "description": "Context information returned by SharePoint."
    }
  },
  "title": "GetContextInfoResponseWrapper",
  "required": [
    "data",
    "successful"
  ],
  "properties": {
    "data": {
      "type": "object",
      "title": "Data",
      "required": [
        "GetContextWebInformation"
      ],
      "properties": {
        "GetContextWebInformation": {
          "type": "object",
          "title": "Get Context Web Information",
          "required": [
            "FormDigestValue",
            "FormDigestTimeoutSeconds"
          ],
          "properties": {
            "WebFullUrl": {
              "type": "string",
              "title": "Web Full Url",
              "description": "Full URL of the current web."
            },
            "SiteFullUrl": {
              "type": "string",
              "title": "Site Full Url",
              "description": "Full URL of the SharePoint site."
            },
            "LibraryVersion": {
              "type": "string",
              "title": "Library Version",
              "description": "Version of the SharePoint library."
            },
            "FormDigestValue": {
              "type": "string",
              "title": "Form Digest Value",
              "description": "Form digest value required for write operations (POST, PUT, DELETE). Include this in the X-RequestDigest header."
            },
            "SupportedSchemaVersions": {
              "type": "array",
              "items": {
                "type": "string"
              },
              "title": "Supported Schema Versions",
              "description": "List of supported schema versions."
            },
            "FormDigestTimeoutSeconds": {
              "type": "integer",
              "title": "Form Digest Timeout Seconds",
              "description": "Number of seconds until the form digest value expires and a new one must be requested."
            }
          },
          "description": "Context information object containing form digest and other details."
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

## SHARE_POINT_GET_CURRENT_USER
Tool to retrieve the current user for the site. Use after authenticating to get the current SharePoint user. A successful response confirms authentication only; access to specific sites, lists, or libraries depends on separate scopes and item-level permissions.

**Input schema:**
```json
{
  "type": "object",
  "title": "GetCurrentUserRequest",
  "properties": {
    "site_name": {
      "type": "string",
      "title": "Site Name",
      "description": "The subsite name to scope the request to (e.g., `composio-test`). If omitted, the root site is used. When provided, the API base URL becomes `https://{tenant}.sharepoint.com/sites/{site}`."
    }
  },
  "description": "Request model for retrieving current user.",
  "additionalProperties": false
}
```

**Output schema:**
```json
{
  "type": "object",
  "$defs": {
    "Deferred": {
      "type": "object",
      "title": "Deferred",
      "required": [
        "__deferred"
      ],
      "properties": {
        "__deferred": {
          "type": "object",
          "title": "  Deferred",
          "required": [
            "uri"
          ],
          "properties": {
            "uri": {
              "type": "string",
              "title": "Uri",
              "description": "URI for deferred navigation property"
            }
          },
          "description": "Deferred loading information for navigation property"
        }
      }
    },
    "UserIdInfo": {
      "type": "object",
      "title": "UserIdInfo",
      "required": [
        "NameId",
        "NameIdIssuer"
      ],
      "properties": {
        "NameId": {
          "type": "string",
          "title": "Name Id",
          "description": "Identifier for the user in the issuer system"
        },
        "NameIdIssuer": {
          "type": "string",
          "title": "Name Id Issuer",
          "description": "Issuer of the NameId identifier"
        }
      }
    },
    "DeferredURI": {
      "type": "object",
      "title": "DeferredURI",
      "required": [
        "uri"
      ],
      "properties": {
        "uri": {
          "type": "string",
          "title": "Uri",
          "description": "URI for deferred navigation property"
        }
      }
    },
    "GetCurrentUserResponse": {
      "type": "object",
      "title": "GetCurrentUserResponse",
      "required": [
        "Email",
        "Groups",
        "Id",
        "IsHiddenInUI",
        "IsSiteAdmin",
        "LoginName",
        "PrincipalType",
        "Title",
        "UserId"
      ],
      "properties": {
        "Id": {
          "type": "integer",
          "title": "Id",
          "description": "Member identifier for the user"
        },
        "Email": {
          "type": "string",
          "title": "Email",
          "description": "User's email address"
        },
        "Title": {
          "type": "string",
          "title": "Title",
          "description": "Display name of the user"
        },
        "Alerts": {
          "type": "object",
          "title": "Alerts",
          "required": [
            "__deferred"
          ],
          "properties": {
            "__deferred": {
              "type": "object",
              "title": "  Deferred",
              "required": [
                "uri"
              ],
              "properties": {
                "uri": {
                  "type": "string",
                  "title": "Uri",
                  "description": "URI for deferred navigation property"
                }
              },
              "description": "Deferred loading information for navigation property"
            }
          },
          "description": "Deferred navigation property for user's alerts"
        },
        "Groups": {
          "type": "object",
          "title": "Groups",
          "required": [
            "__deferred"
          ],
          "properties": {
            "__deferred": {
              "type": "object",
              "title": "  Deferred",
              "required": [
                "uri"
              ],
              "properties": {
                "uri": {
                  "type": "string",
                  "title": "Uri",
                  "description": "URI for deferred navigation property"
                }
              },
              "description": "Deferred loading information for navigation property"
            }
          },
          "description": "Deferred navigation property for user's groups"
        },
        "UserId": {
          "type": "object",
          "title": "User Id",
          "required": [
            "NameId",
            "NameIdIssuer"
          ],
          "properties": {
            "NameId": {
              "type": "string",
              "title": "Name Id",
              "description": "Identifier for the user in the issuer system"
            },
            "NameIdIssuer": {
              "type": "string",
              "title": "Name Id Issuer",
              "description": "Issuer of the NameId identifier"
            }
          },
          "description": "Navigation property containing the user's identifier information"
        },
        "LoginName": {
          "type": "string",
          "title": "Login Name",
          "description": "Login name of the user"
        },
        "Expiration": {
          "type": "string",
          "title": "Expiration",
          "description": "Expiration date for the user account, if applicable"
        },
        "IsSiteAdmin": {
          "type": "boolean",
          "title": "Is Site Admin",
          "description": "Whether the user is a site collection administrator"
        },
        "IsHiddenInUI": {
          "type": "boolean",
          "title": "Is Hidden In Ui",
          "description": "Whether this user should be hidden in the UI"
        },
        "PrincipalType": {
          "type": "integer",
          "title": "Principal Type",
          "description": "Bitwise SP.PrincipalType value"
        },
        "UserPrincipalName": {
          "type": "string",
          "title": "User Principal Name",
          "description": "User Principal Name (UPN) in Azure AD/Microsoft 365"
        },
        "IsShareByEmailGuestUser": {
          "type": "boolean",
          "title": "Is Share By Email Guest User",
          "description": "Whether the user is a guest user invited by email sharing"
        },
        "IsEmailAuthenticationGuestUser": {
          "type": "boolean",
          "title": "Is Email Authentication Guest User",
          "description": "Whether the user is a guest user authenticated via email"
        }
      }
    }
  },
  "title": "GetCurrentUserResponseWrapper",
  "required": [
    "data",
    "successful"
  ],
  "properties": {
    "data": {
      "type": "object",
      "title": "Data",
      "required": [
        "Email",
        "Groups",
        "Id",
        "IsHiddenInUI",
        "IsSiteAdmin",
        "LoginName",
        "PrincipalType",
        "Title",
        "UserId"
      ],
      "properties": {
        "Id": {
          "type": "integer",
          "title": "Id",
          "description": "Member identifier for the user"
        },
        "Email": {
          "type": "string",
          "title": "Email",
          "description": "User's email address"
        },
        "Title": {
          "type": "string",
          "title": "Title",
          "description": "Display name of the user"
        },
        "Alerts": {
          "type": "object",
          "title": "Alerts",
          "required": [
            "__deferred"
          ],
          "properties": {
            "__deferred": {
              "type": "object",
              "title": "  Deferred",
              "required": [
                "uri"
              ],
              "properties": {
                "uri": {
                  "type": "string",
                  "title": "Uri",
                  "description": "URI for deferred navigation property"
                }
              },
              "description": "Deferred loading information for navigation property"
            }
          },
          "description": "Deferred navigation property for user's alerts"
        },
        "Groups": {
          "type": "object",
          "title": "Groups",
          "required": [
            "__deferred"
          ],
          "properties": {
            "__deferred": {
              "type": "object",
              "title": "  Deferred",
              "required": [
                "uri"
              ],
              "properties": {
                "uri": {
                  "type": "string",
                  "title": "Uri",
                  "description": "URI for deferred navigation property"
                }
              },
              "description": "Deferred loading information for navigation property"
            }
          },
          "description": "Deferred navigation property for user's groups"
        },
        "UserId": {
          "type": "object",
          "title": "User Id",
          "required": [
            "NameId",
            "NameIdIssuer"
          ],
          "properties": {
            "NameId": {
              "type": "string",
              "title": "Name Id",
              "description": "Identifier for the user in the issuer system"
            },
            "NameIdIssuer": {
              "type": "string",
              "title": "Name Id Issuer",
              "description": "Issuer of the NameId identifier"
            }
          },
          "description": "Navigation property containing the user's identifier information"
        },
        "LoginName": {
          "type": "string",
          "title": "Login Name",
          "description": "Login name of the user"
        },
        "Expiration": {
          "type": "string",
          "title": "Expiration",
          "description": "Expiration date for the user account, if applicable"
        },
        "IsSiteAdmin": {
          "type": "boolean",
          "title": "Is Site Admin",
          "description": "Whether the user is a site collection administrator"
        },
        "IsHiddenInUI": {
          "type": "boolean",
          "title": "Is Hidden In Ui",
          "description": "Whether this user should be hidden in the UI"
        },
        "PrincipalType": {
          "type": "integer",
          "title": "Principal Type",
          "description": "Bitwise SP.PrincipalType value"
        },
        "UserPrincipalName": {
          "type": "string",
          "title": "User Principal Name",
          "description": "User Principal Name (UPN) in Azure AD/Microsoft 365"
        },
        "IsShareByEmailGuestUser": {
          "type": "boolean",
          "title": "Is Share By Email Guest User",
          "description": "Whether the user is a guest user invited by email sharing"
        },
        "IsEmailAuthenticationGuestUser": {
          "type": "boolean",
          "title": "Is Email Authentication Guest User",
          "description": "Whether the user is a guest user authenticated via email"
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

## SHARE_POINT_GET_DRIVE_ITEM_ANALYTICS
Tool to get analytics for a SharePoint drive item. Use when you need to retrieve access statistics (view counts, unique viewers) for files or folders in SharePoint/OneDrive.

**Input schema:**
```json
{
  "type": "object",
  "title": "GetDriveItemAnalyticsRequest",
  "required": [
    "drive_id",
    "drive_item_id"
  ],
  "properties": {
    "drive_id": {
      "type": "string",
      "title": "Drive Id",
      "examples": [
        "b!sAYRj4psj0qqpjB3OOHdglZBMF5Nk0xPnR4Fc4pfinI7DA8OPuKvSo4igDo7VyMV"
      ],
      "description": "The unique identifier of the drive containing the item."
    },
    "site_name": {
      "type": "string",
      "title": "Site Name",
      "examples": [
        "composio-test"
      ],
      "description": "The subsite name to scope the request to (e.g., 'composio-test'). If omitted, the root site is used. When provided, the API base URL becomes https://{tenant}.sharepoint.com/sites/{site}."
    },
    "time_range": {
      "enum": [
        "allTime",
        "lastSevenDays"
      ],
      "type": "string",
      "title": "Time Range",
      "default": "allTime",
      "examples": [
        "allTime",
        "lastSevenDays"
      ],
      "description": "Time range for analytics data. Use 'allTime' for all-time statistics or 'lastSevenDays' for the last seven days."
    },
    "drive_item_id": {
      "type": "string",
      "title": "Drive Item Id",
      "examples": [
        "01K67O4VQJ6LBMI64JF5FLHHIQ4OJP45SP"
      ],
      "description": "The unique identifier of the drive item to get analytics for."
    }
  },
  "description": "Request model for retrieving analytics for a SharePoint drive item.",
  "additionalProperties": false
}
```

**Output schema:**
```json
{
  "type": "object",
  "$defs": {
    "IncompleteData": {
      "type": "object",
      "title": "IncompleteData",
      "properties": {
        "wasThrottled": {
          "type": "boolean",
          "title": "Was Throttled",
          "description": "Some data was not recorded due to excessive activity."
        },
        "missingDataBeforeDateTime": {
          "type": "string",
          "title": "Missing Data Before Date Time",
          "description": "The service does not have source data before the specified time."
        }
      },
      "description": "Information about incomplete data in analytics."
    },
    "ItemActionStat": {
      "type": "object",
      "title": "ItemActionStat",
      "properties": {
        "actorCount": {
          "type": "integer",
          "title": "Actor Count",
          "description": "The number of distinct actors that performed the action."
        },
        "actionCount": {
          "type": "integer",
          "title": "Action Count",
          "description": "The number of times the action took place."
        }
      },
      "description": "Statistics about a specific action type."
    },
    "GetDriveItemAnalyticsResponse": {
      "type": "object",
      "title": "GetDriveItemAnalyticsResponse",
      "properties": {
        "edit": {
          "type": "object",
          "title": "Edit",
          "properties": {
            "actorCount": {
              "type": "integer",
              "title": "Actor Count",
              "description": "The number of distinct actors that performed the action."
            },
            "actionCount": {
              "type": "integer",
              "title": "Action Count",
              "description": "The number of times the action took place."
            }
          },
          "description": "Statistics about the edit actions in this interval."
        },
        "move": {
          "type": "object",
          "title": "Move",
          "properties": {
            "actorCount": {
              "type": "integer",
              "title": "Actor Count",
              "description": "The number of distinct actors that performed the action."
            },
            "actionCount": {
              "type": "integer",
              "title": "Action Count",
              "description": "The number of times the action took place."
            }
          },
          "description": "Statistics about the move actions in this interval."
        },
        "access": {
          "type": "object",
          "title": "Access",
          "properties": {
            "actorCount": {
              "type": "integer",
              "title": "Actor Count",
              "description": "The number of distinct actors that performed the action."
            },
            "actionCount": {
              "type": "integer",
              "title": "Action Count",
              "description": "The number of times the action took place."
            }
          },
          "description": "Statistics about the access actions in this interval."
        },
        "create": {
          "type": "object",
          "title": "Create",
          "properties": {
            "actorCount": {
              "type": "integer",
              "title": "Actor Count",
              "description": "The number of distinct actors that performed the action."
            },
            "actionCount": {
              "type": "integer",
              "title": "Action Count",
              "description": "The number of times the action took place."
            }
          },
          "description": "Statistics about the create actions in this interval."
        },
        "delete": {
          "type": "object",
          "title": "Delete",
          "properties": {
            "actorCount": {
              "type": "integer",
              "title": "Actor Count",
              "description": "The number of distinct actors that performed the action."
            },
            "actionCount": {
              "type": "integer",
              "title": "Action Count",
              "description": "The number of times the action took place."
            }
          },
          "description": "Statistics about the delete actions in this interval."
        },
        "isTrending": {
          "type": "boolean",
          "title": "Is Trending",
          "description": "Indicates whether the item is trending."
        },
        "endDateTime": {
          "type": "string",
          "title": "End Date Time",
          "description": "When the interval ends."
        },
        "startDateTime": {
          "type": "string",
          "title": "Start Date Time",
          "description": "When the interval starts."
        },
        "incompleteData": {
          "type": "object",
          "title": "Incomplete Data",
          "properties": {
            "wasThrottled": {
              "type": "boolean",
              "title": "Was Throttled",
              "description": "Some data was not recorded due to excessive activity."
            },
            "missingDataBeforeDateTime": {
              "type": "string",
              "title": "Missing Data Before Date Time",
              "description": "The service does not have source data before the specified time."
            }
          },
          "description": "Indicates that the statistics in this interval are based on incomplete data."
        }
      },
      "description": "Response model for drive item analytics.",
      "additionalProperties": true
    }
  },
  "title": "GetDriveItemAnalyticsResponseWrapper",
  "required": [
    "data",
    "successful"
  ],
  "properties": {
    "data": {
      "type": "object",
      "title": "Data",
      "properties": {
        "edit": {
          "type": "object",
          "title": "Edit",
          "properties": {
            "actorCount": {
              "type": "integer",
              "title": "Actor Count",
              "description": "The number of distinct actors that performed the action."
            },
            "actionCount": {
              "type": "integer",
              "title": "Action Count",
              "description": "The number of times the action took place."
            }
          },
          "description": "Statistics about the edit actions in this interval."
        },
        "move": {
          "type": "object",
          "title": "Move",
          "properties": {
            "actorCount": {
              "type": "integer",
              "title": "Actor Count",
              "description": "The number of distinct actors that performed the action."
            },
            "actionCount": {
              "type": "integer",
              "title": "Action Count",
              "description": "The number of times the action took place."
            }
          },
          "description": "Statistics about the move actions in this interval."
        },
        "access": {
          "type": "object",
          "title": "Access",
          "properties": {
            "actorCount": {
              "type": "integer",
              "title": "Actor Count",
              "description": "The number of distinct actors that performed the action."
            },
            "actionCount": {
              "type": "integer",
              "title": "Action Count",
              "description": "The number of times the action took place."
            }
          },
          "description": "Statistics about the access actions in this interval."
        },
        "create": {
          "type": "object",
          "title": "Create",
          "properties": {
            "actorCount": {
              "type": "integer",
              "title": "Actor Count",
              "description": "The number of distinct actors that performed the action."
            },
            "actionCount": {
              "type": "integer",
              "title": "Action Count",
              "description": "The number of times the action took place."
            }
          },
          "description": "Statistics about the create actions in this interval."
        },
        "delete": {
          "type": "object",
          "title": "Delete",
          "properties": {
            "actorCount": {
              "type": "integer",
              "title": "Actor Count",
              "description": "The number of distinct actors that performed the action."
            },
            "actionCount": {
              "type": "integer",
              "title": "Action Count",
              "description": "The number of times the action took place."
            }
          },
          "description": "Statistics about the delete actions in this interval."
        },
        "isTrending": {
          "type": "boolean",
          "title": "Is Trending",
          "description": "Indicates whether the item is trending."
        },
        "endDateTime": {
          "type": "string",
          "title": "End Date Time",
          "description": "When the interval ends."
        },
        "startDateTime": {
          "type": "string",
          "title": "Start Date Time",
          "description": "When the interval starts."
        },
        "incompleteData": {
          "type": "object",
          "title": "Incomplete Data",
          "properties": {
            "wasThrottled": {
              "type": "boolean",
              "title": "Was Throttled",
              "description": "Some data was not recorded due to excessive activity."
            },
            "missingDataBeforeDateTime": {
              "type": "string",
              "title": "Missing Data Before Date Time",
              "description": "The service does not have source data before the specified time."
            }
          },
          "description": "Indicates that the statistics in this interval are based on incomplete data."
        }
      },
      "description": "Data from the action execution",
      "additionalProperties": true
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

## SHARE_POINT_GET_FILE_BY_SERVER_RELATIVE_URL
DEPRECATED: Use GetSiteDriveItemByPath instead. Tool to fetch SharePoint file metadata (exists/permissions/URLs/UniqueId) given a server-relative path, using the more robust ServerRelativePath API for special characters. Use after SHARE_POINT_SEARCH_QUERY returns a Path and you need to confirm the canonical working path or retrieve file properties without downloading bytes.

**Input schema:**
```json
{
  "type": "object",
  "title": "GetFileByServerRelativeUrlRequest",
  "required": [
    "server_relative_path_decoded"
  ],
  "properties": {
    "expand": {
      "type": "string",
      "title": "Expand",
      "examples": [
        "ListItemAllFields"
      ],
      "description": "OData $expand query option. Comma-separated list of related entities to expand, such as 'ListItemAllFields' to include list item metadata."
    },
    "select": {
      "type": "string",
      "title": "Select",
      "examples": [
        "ServerRelativeUrl,UniqueId,Name,Length,TimeLastModified"
      ],
      "description": "OData $select query option. Comma-separated list of fields to return. E.g., 'ServerRelativeUrl,UniqueId,Name,Length,TimeLastModified,LinkingUri'."
    },
    "site_name": {
      "type": "string",
      "title": "Site Name",
      "examples": [
        "Workshopsubmissions",
        "Finance",
        "HR"
      ],
      "description": "Optional SharePoint site name to scope the file retrieval. Required when accessing files in a subsite (e.g., when the path starts with /sites/). If the file path is '/sites/Workshopsubmissions/Shared Documents/file.pdf', set site_name='Workshopsubmissions'. If not provided, the file is resolved from the tenant root site context. This parameter is auto-extracted from paths starting with /sites/ if not explicitly provided."
    },
    "server_relative_path_decoded": {
      "type": "string",
      "title": "Server Relative Path Decoded",
      "examples": [
        "/sites/Finance/Shared Documents/W-9.pdf",
        "/Shared Documents/report.pdf",
        "/personal/username_domain/Documents/file.docx"
      ],
      "description": "Decoded server-relative path of the file, starting with '/'. E.g., '/sites/Finance/Shared Documents/W-9.pdf' or '/Shared Documents/report.pdf'. Do not URL-encode; provide the path with spaces and special characters as-is."
    }
  },
  "description": "Request parameters for retrieving SharePoint file metadata by its server-relative path.",
  "additionalProperties": false
}
```

**Output schema:**
```json
{
  "type": "object",
  "$defs": {
    "GetFileByServerRelativeUrlResponse": {
      "type": "object",
      "title": "GetFileByServerRelativeUrlResponse",
      "required": [
        "Exists"
      ],
      "properties": {
        "Name": {
          "type": "string",
          "title": "Name",
          "description": "Name of the file."
        },
        "Title": {
          "type": "string",
          "title": "Title",
          "description": "Title of the file if available."
        },
        "Exists": {
          "type": "boolean",
          "title": "Exists",
          "description": "Whether the file exists. True if found (200), False if not found (404)."
        },
        "Length": {
          "type": "integer",
          "title": "Length",
          "description": "File size in bytes."
        },
        "UniqueId": {
          "type": "string",
          "title": "Unique Id",
          "description": "Unique identifier (GUID) of the file."
        },
        "LinkingUri": {
          "type": "string",
          "title": "Linking Uri",
          "description": "Linking URI of the file."
        },
        "TimeCreated": {
          "type": "string",
          "title": "Time Created",
          "description": "Creation timestamp of the file."
        },
        "CheckOutType": {
          "type": "integer",
          "title": "Check Out Type",
          "description": "Check-out type of the file (0=Online, 1=Offline, 2=None)."
        },
        "MajorVersion": {
          "type": "integer",
          "title": "Major Version",
          "description": "Major version number of the file."
        },
        "MinorVersion": {
          "type": "integer",
          "title": "Minor Version",
          "description": "Minor version number of the file."
        },
        "TimeLastModified": {
          "type": "string",
          "title": "Time Last Modified",
          "description": "Last modified timestamp of the file."
        },
        "ListItemAllFields": {
          "type": "object",
          "title": "List Item All Fields",
          "description": "List item metadata for the file, present if expanded with $expand=ListItemAllFields. Contains both standard SharePoint fields (Id, Created, Modified, AuthorId, EditorId, ContentTypeId, GUID, etc.) and custom user-defined columns specific to the document library configuration. The schema is dynamic and varies by list/library.",
          "additionalProperties": true
        },
        "ServerRelativeUrl": {
          "type": "string",
          "title": "Server Relative Url",
          "description": "Server-relative URL of the file."
        }
      },
      "description": "Response model for SharePoint file metadata."
    }
  },
  "title": "GetFileByServerRelativeUrlResponseWrapper",
  "required": [
    "data",
    "successful"
  ],
  "properties": {
    "data": {
      "type": "object",
      "title": "Data",
      "required": [
        "Exists"
      ],
      "properties": {
        "Name": {
          "type": "string",
          "title": "Name",
          "description": "Name of the file."
        },
        "Title": {
          "type": "string",
          "title": "Title",
          "description": "Title of the file if available."
        },
        "Exists": {
          "type": "boolean",
          "title": "Exists",
          "description": "Whether the file exists. True if found (200), False if not found (404)."
        },
        "Length": {
          "type": "integer",
          "title": "Length",
          "description": "File size in bytes."
        },
        "UniqueId": {
          "type": "string",
          "title": "Unique Id",
          "description": "Unique identifier (GUID) of the file."
        },
        "LinkingUri": {
          "type": "string",
          "title": "Linking Uri",
          "description": "Linking URI of the file."
        },
        "TimeCreated": {
          "type": "string",
          "title": "Time Created",
          "description": "Creation timestamp of the file."
        },
        "CheckOutType": {
          "type": "integer",
          "title": "Check Out Type",
          "description": "Check-out type of the file (0=Online, 1=Offline, 2=None)."
        },
        "MajorVersion": {
          "type": "integer",
          "title": "Major Version",
          "description": "Major version number of the file."
        },
        "MinorVersion": {
          "type": "integer",
          "title": "Minor Version",
          "description": "Minor version number of the file."
        },
        "TimeLastModified": {
          "type": "string",
          "title": "Time Last Modified",
          "description": "Last modified timestamp of the file."
        },
        "ListItemAllFields": {
          "type": "object",
          "title": "List Item All Fields",
          "description": "List item metadata for the file, present if expanded with $expand=ListItemAllFields. Contains both standard SharePoint fields (Id, Created, Modified, AuthorId, EditorId, ContentTypeId, GUID, etc.) and custom user-defined columns specific to the document library configuration. The schema is dynamic and varies by list/library.",
          "additionalProperties": true
        },
        "ServerRelativeUrl": {
          "type": "string",
          "title": "Server Relative Url",
          "description": "Server-relative URL of the file."
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

## SHARE_POINT_GET_FOLDER_BY_SERVER_RELATIVE_URL
DEPRECATED: Use SHARE_POINT_GET_SITE_DRIVE_ITEM_BY_PATH instead. Tool to retrieve a folder by its server-relative URL. Use when you need to fetch folder metadata by path before further operations. Returns only the immediate folder; to traverse nested structures, iterate `Folders.results` and call this tool recursively for each subfolder.

**Input schema:**
```json
{
  "type": "object",
  "title": "GetFolderByServerRelativeUrlRequest",
  "required": [
    "server_relative_url"
  ],
  "properties": {
    "expand": {
      "type": "string",
      "title": "Expand",
      "examples": [
        "Files,Folders"
      ],
      "description": "OData $expand query option. Comma-separated list of related entities to expand, such as 'Files,Folders,ListItemAllFields'. Expanding Files or Folders can produce large responses; access nested data via `Files.results` and `Folders.results` arrays."
    },
    "select": {
      "type": "string",
      "title": "Select",
      "examples": [
        "Name,ServerRelativeUrl,ItemCount"
      ],
      "description": "OData $select query option. Comma-separated list of fields to return. E.g., 'Name,ServerRelativeUrl,ItemCount'."
    },
    "site_name": {
      "type": "string",
      "title": "Site Name",
      "examples": [
        "composio-test",
        "Finance",
        "HR"
      ],
      "description": "The subsite name to scope the request to (e.g., 'composio-test'). If omitted, the root site is used. When provided, the API base URL becomes https://{tenant}.sharepoint.com/sites/{site_name}."
    },
    "server_relative_url": {
      "type": "string",
      "title": "Server Relative Url",
      "examples": [
        "/Shared Documents/MyFolder"
      ],
      "description": "Server-relative URL of the folder to retrieve, including library and any parent folders. Can be provided as a plain path (e.g., '/Shared Documents/MyFolder') or as a pre-encoded URL (e.g., '/Shared%20Documents/MyFolder'). Both formats are accepted and handled correctly. Path must exactly match the real SharePoint library name (e.g., '/Shared Documents' not '/Documents'); extra or missing slashes cause resolution failures. Prefer reusing the `server_relative_url` returned by this tool for downstream calls rather than constructing paths manually."
    }
  },
  "description": "Request parameters for retrieving a SharePoint folder by its server-relative URL.",
  "additionalProperties": false
}
```

**Output schema:**
```json
{
  "type": "object",
  "$defs": {
    "GetFolderByServerRelativeUrlResponse": {
      "type": "object",
      "title": "GetFolderByServerRelativeUrlResponse",
      "properties": {
        "Name": {
          "type": "string",
          "title": "Name",
          "description": "Name of the folder."
        },
        "Files": {
          "anyOf": [
            {
              "type": "array",
              "items": {
                "type": "object",
                "additionalProperties": true
              }
            },
            {
              "type": "object",
              "additionalProperties": true
            }
          ],
          "title": "Files",
          "description": "List of files in the folder if expanded with $expand=Files, otherwise a deferred reference object."
        },
        "Folders": {
          "anyOf": [
            {
              "type": "array",
              "items": {
                "type": "object",
                "additionalProperties": true
              }
            },
            {
              "type": "object",
              "additionalProperties": true
            }
          ],
          "title": "Folders",
          "description": "List of subfolders if expanded with $expand=Folders, otherwise a deferred reference object."
        },
        "ItemCount": {
          "type": "integer",
          "title": "Item Count",
          "description": "Number of items in the folder."
        },
        "WelcomePage": {
          "type": "string",
          "title": "Welcome Page",
          "description": "URL of the folder's welcome page if set, otherwise empty or null."
        },
        "ListItemAllFields": {
          "type": "object",
          "title": "List Item All Fields",
          "description": "List item representing the folder if expanded with $expand=ListItemAllFields, otherwise a deferred reference object.",
          "additionalProperties": true
        },
        "ServerRelativeUrl": {
          "type": "string",
          "title": "Server Relative Url",
          "description": "Server-relative URL of the folder."
        }
      },
      "description": "Response model for retrieved SharePoint folder."
    }
  },
  "title": "GetFolderByServerRelativeUrlResponseWrapper",
  "required": [
    "data",
    "successful"
  ],
  "properties": {
    "data": {
      "type": "object",
      "title": "Data",
      "properties": {
        "Name": {
          "type": "string",
          "title": "Name",
          "description": "Name of the folder."
        },
        "Files": {
          "anyOf": [
            {
              "type": "array",
              "items": {
                "type": "object",
                "additionalProperties": true
              }
            },
            {
              "type": "object",
              "additionalProperties": true
            }
          ],
          "title": "Files",
          "description": "List of files in the folder if expanded with $expand=Files, otherwise a deferred reference object."
        },
        "Folders": {
          "anyOf": [
            {
              "type": "array",
              "items": {
                "type": "object",
                "additionalProperties": true
              }
            },
            {
              "type": "object",
              "additionalProperties": true
            }
          ],
          "title": "Folders",
          "description": "List of subfolders if expanded with $expand=Folders, otherwise a deferred reference object."
        },
        "ItemCount": {
          "type": "integer",
          "title": "Item Count",
          "description": "Number of items in the folder."
        },
        "WelcomePage": {
          "type": "string",
          "title": "Welcome Page",
          "description": "URL of the folder's welcome page if set, otherwise empty or null."
        },
        "ListItemAllFields": {
          "type": "object",
          "title": "List Item All Fields",
          "description": "List item representing the folder if expanded with $expand=ListItemAllFields, otherwise a deferred reference object.",
          "additionalProperties": true
        },
        "ServerRelativeUrl": {
          "type": "string",
          "title": "Server Relative Url",
          "description": "Server-relative URL of the folder."
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

## SHARE_POINT_GET_GROUP_USERS
Retrieves all users who are members of a specified SharePoint group. This action returns user information including IDs, names, email addresses, login names, and permission details. Supports OData query parameters for filtering, sorting, field selection, and pagination. Use this when you need to audit group membership, check user permissions, or list members of a specific group.

**Input schema:**
```json
{
  "type": "object",
  "title": "GetGroupUsersRequest",
  "required": [
    "group_name"
  ],
  "properties": {
    "top": {
      "type": "integer",
      "title": "Top",
      "minimum": 1,
      "examples": [
        10,
        50
      ],
      "description": "OData $top parameter to limit the number of returned users. Must be a positive integer."
    },
    "expand": {
      "type": "string",
      "title": "Expand",
      "examples": [
        "Groups"
      ],
      "description": "OData $expand parameter to expand related navigation properties. Use 'Groups' to get the user's group memberships."
    },
    "filter": {
      "type": "string",
      "title": "Filter",
      "examples": [
        "PrincipalType eq 1",
        "IsSiteAdmin eq true"
      ],
      "description": "OData $filter parameter to filter the returned users. Use OData filter syntax (e.g., 'PrincipalType eq 1' for regular users)."
    },
    "select": {
      "type": "string",
      "title": "Select",
      "examples": [
        "Id,Title,Email"
      ],
      "description": "OData $select parameter to return only specific user fields. Comma-separated field names (e.g., 'Id,Title,Email,LoginName')."
    },
    "orderby": {
      "type": "string",
      "title": "Orderby",
      "examples": [
        "Title",
        "Title desc"
      ],
      "description": "OData $orderby parameter to sort the returned users. Specify field name and optional 'asc' or 'desc' (e.g., 'Title desc')."
    },
    "site_name": {
      "type": "string",
      "title": "Site Name",
      "examples": [
        "composio-test",
        "teamsite"
      ],
      "description": "The subsite name to scope the request to (e.g., 'composio-test'). If omitted, the root site is used. When provided, the API base URL becomes https://{tenant}.sharepoint.com/sites/{site}."
    },
    "skiptoken": {
      "type": "string",
      "title": "Skiptoken",
      "description": "OData $skiptoken parameter for pagination. Use the skiptoken value from a previous response's __next link to get the next page of results."
    },
    "group_name": {
      "type": "string",
      "title": "Group Name",
      "examples": [
        "Communication site Members",
        "Site Owners"
      ],
      "description": "Name of the SharePoint group to retrieve users from. Use the LoginName or Title of the group (e.g., 'Communication site Members', 'Site Owners')."
    }
  },
  "additionalProperties": false
}
```

**Output schema:**
```json
{
  "type": "object",
  "$defs": {
    "SPUser": {
      "type": "object",
      "title": "SPUser",
      "required": [
        "Id"
      ],
      "properties": {
        "Id": {
          "type": "integer",
          "title": "Id",
          "description": "User's member identifier."
        },
        "Email": {
          "type": "string",
          "title": "Email",
          "description": "Email address of the user."
        },
        "Title": {
          "type": "string",
          "title": "Title",
          "description": "Display name of the user."
        },
        "Groups": {
          "type": "object",
          "title": "Groups",
          "properties": {
            "results": {
              "type": "array",
              "items": {
                "type": "object",
                "title": "SPGroupInfo",
                "properties": {
                  "Id": {
                    "type": "integer",
                    "title": "Id",
                    "description": "Group ID."
                  },
                  "Title": {
                    "type": "string",
                    "title": "Title",
                    "description": "Group title."
                  },
                  "__metadata": {
                    "type": "object",
                    "title": "  Metadata",
                    "required": [
                      "id",
                      "uri",
                      "type"
                    ],
                    "properties": {
                      "id": {
                        "type": "string",
                        "title": "Id",
                        "description": "OData id of the group."
                      },
                      "uri": {
                        "type": "string",
                        "title": "Uri",
                        "description": "OData uri of the group."
                      },
                      "type": {
                        "type": "string",
                        "title": "Type",
                        "description": "OData type of the group."
                      }
                    },
                    "additionalProperties": true,
                    "description": "OData metadata for the group."
                  }
                },
                "additionalProperties": true
              },
              "title": "Results",
              "description": "Expanded list of groups when $expand is used."
            },
            "__deferred": {
              "type": "object",
              "title": "  Deferred",
              "required": [
                "uri"
              ],
              "properties": {
                "uri": {
                  "type": "string",
                  "title": "Uri",
                  "description": "URI of the deferred navigation property."
                }
              },
              "description": "Deferred link to groups collection.",
              "additionalProperties": true
            }
          },
          "description": "Deferred link or expanded groups the user belongs to.",
          "additionalProperties": true
        },
        "UserId": {
          "type": "object",
          "title": "User Id",
          "required": [
            "NameId",
            "NameIdIssuer"
          ],
          "properties": {
            "NameId": {
              "type": "string",
              "title": "Name Id",
              "description": "NameId assigned to the user."
            },
            "NameIdIssuer": {
              "type": "string",
              "title": "Name Id Issuer",
              "description": "Issuer of the NameId."
            }
          },
          "description": "UserId and issuer info. May be null for some users."
        },
        "LoginName": {
          "type": "string",
          "title": "Login Name",
          "description": "User login name (claims format)."
        },
        "IsSiteAdmin": {
          "type": "boolean",
          "title": "Is Site Admin",
          "description": "Whether the user is a site collection admin."
        },
        "IsHiddenInUI": {
          "type": "boolean",
          "title": "Is Hidden In Ui",
          "description": "Whether the member is hidden in UI."
        },
        "PrincipalType": {
          "type": "integer",
          "title": "Principal Type",
          "description": "Principal type bitmask."
        }
      },
      "additionalProperties": true
    },
    "SPGroupInfo": {
      "type": "object",
      "title": "SPGroupInfo",
      "properties": {
        "Id": {
          "type": "integer",
          "title": "Id",
          "description": "Group ID."
        },
        "Title": {
          "type": "string",
          "title": "Title",
          "description": "Group title."
        },
        "__metadata": {
          "type": "object",
          "title": "  Metadata",
          "required": [
            "id",
            "uri",
            "type"
          ],
          "properties": {
            "id": {
              "type": "string",
              "title": "Id",
              "description": "OData id of the group."
            },
            "uri": {
              "type": "string",
              "title": "Uri",
              "description": "OData uri of the group."
            },
            "type": {
              "type": "string",
              "title": "Type",
              "description": "OData type of the group."
            }
          },
          "additionalProperties": true,
          "description": "OData metadata for the group."
        }
      },
      "additionalProperties": true
    },
    "SPUserIdInfo": {
      "type": "object",
      "title": "SPUserIdInfo",
      "required": [
        "NameId",
        "NameIdIssuer"
      ],
      "properties": {
        "NameId": {
          "type": "string",
          "title": "Name Id",
          "description": "NameId assigned to the user."
        },
        "NameIdIssuer": {
          "type": "string",
          "title": "Name Id Issuer",
          "description": "Issuer of the NameId."
        }
      }
    },
    "SPDeferredLink": {
      "type": "object",
      "title": "SPDeferredLink",
      "required": [
        "uri"
      ],
      "properties": {
        "uri": {
          "type": "string",
          "title": "Uri",
          "description": "URI of the deferred navigation property."
        }
      },
      "description": "Represents a deferred navigation property link.",
      "additionalProperties": true
    },
    "SPGroupMetadata": {
      "type": "object",
      "title": "SPGroupMetadata",
      "required": [
        "id",
        "uri",
        "type"
      ],
      "properties": {
        "id": {
          "type": "string",
          "title": "Id",
          "description": "OData id of the group."
        },
        "uri": {
          "type": "string",
          "title": "Uri",
          "description": "OData uri of the group."
        },
        "type": {
          "type": "string",
          "title": "Type",
          "description": "OData type of the group."
        }
      },
      "additionalProperties": true
    },
    "SPGroupCollection": {
      "type": "object",
      "title": "SPGroupCollection",
      "properties": {
        "results": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "SPGroupInfo",
            "properties": {
              "Id": {
                "type": "integer",
                "title": "Id",
                "description": "Group ID."
              },
              "Title": {
                "type": "string",
                "title": "Title",
                "description": "Group title."
              },
              "__metadata": {
                "type": "object",
                "title": "  Metadata",
                "required": [
                  "id",
                  "uri",
                  "type"
                ],
                "properties": {
                  "id": {
                    "type": "string",
                    "title": "Id",
                    "description": "OData id of the group."
                  },
                  "uri": {
                    "type": "string",
                    "title": "Uri",
                    "description": "OData uri of the group."
                  },
                  "type": {
                    "type": "string",
                    "title": "Type",
                    "description": "OData type of the group."
                  }
                },
                "additionalProperties": true,
                "description": "OData metadata for the group."
              }
            },
            "additionalProperties": true
          },
          "title": "Results",
          "description": "Expanded list of groups when $expand is used."
        },
        "__deferred": {
          "type": "object",
          "title": "  Deferred",
          "required": [
            "uri"
          ],
          "properties": {
            "uri": {
              "type": "string",
              "title": "Uri",
              "description": "URI of the deferred navigation property."
            }
          },
          "description": "Deferred link to groups collection.",
          "additionalProperties": true
        }
      },
      "description": "Represents either a deferred link or expanded group results.",
      "additionalProperties": true
    },
    "GetGroupUsersResponse": {
      "type": "object",
      "title": "GetGroupUsersResponse",
      "required": [
        "value"
      ],
      "properties": {
        "value": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "SPUser",
            "required": [
              "Id"
            ],
            "properties": {
              "Id": {
                "type": "integer",
                "title": "Id",
                "description": "User's member identifier."
              },
              "Email": {
                "type": "string",
                "title": "Email",
                "description": "Email address of the user."
              },
              "Title": {
                "type": "string",
                "title": "Title",
                "description": "Display name of the user."
              },
              "Groups": {
                "type": "object",
                "title": "Groups",
                "properties": {
                  "results": {
                    "type": "array",
                    "items": {
                      "type": "object",
                      "title": "SPGroupInfo",
                      "properties": {
                        "Id": {
                          "type": "integer",
                          "title": "Id",
                          "description": "Group ID."
                        },
                        "Title": {
                          "type": "string",
                          "title": "Title",
                          "description": "Group title."
                        },
                        "__metadata": {
                          "type": "object",
                          "title": "  Metadata",
                          "required": [
                            "id",
                            "uri",
                            "type"
                          ],
                          "properties": {
                            "id": {
                              "type": "string",
                              "title": "Id",
                              "description": "OData id of the group."
                            },
                            "uri": {
                              "type": "string",
                              "title": "Uri",
                              "description": "OData uri of the group."
                            },
                            "type": {
                              "type": "string",
                              "title": "Type",
                              "description": "OData type of the group."
                            }
                          },
                          "additionalProperties": true,
                          "description": "OData metadata for the group."
                        }
                      },
                      "additionalProperties": true
                    },
                    "title": "Results",
                    "description": "Expanded list of groups when $expand is used."
                  },
                  "__deferred": {
                    "type": "object",
                    "title": "  Deferred",
                    "required": [
                      "uri"
                    ],
                    "properties": {
                      "uri": {
                        "type": "string",
                        "title": "Uri",
                        "description": "URI of the deferred navigation property."
                      }
                    },
                    "description": "Deferred link to groups collection.",
                    "additionalProperties": true
                  }
                },
                "description": "Deferred link or expanded groups the user belongs to.",
                "additionalProperties": true
              },
              "UserId": {
                "type": "object",
                "title": "User Id",
                "required": [
                  "NameId",
                  "NameIdIssuer"
                ],
                "properties": {
                  "NameId": {
                    "type": "string",
                    "title": "Name Id",
                    "description": "NameId assigned to the user."
                  },
                  "NameIdIssuer": {
                    "type": "string",
                    "title": "Name Id Issuer",
                    "description": "Issuer of the NameId."
                  }
                },
                "description": "UserId and issuer info. May be null for some users."
              },
              "LoginName": {
                "type": "string",
                "title": "Login Name",
                "description": "User login name (claims format)."
              },
              "IsSiteAdmin": {
                "type": "boolean",
                "title": "Is Site Admin",
                "description": "Whether the user is a site collection admin."
              },
              "IsHiddenInUI": {
                "type": "boolean",
                "title": "Is Hidden In Ui",
                "description": "Whether the member is hidden in UI."
              },
              "PrincipalType": {
                "type": "integer",
                "title": "Principal Type",
                "description": "Principal type bitmask."
              }
            },
            "additionalProperties": true
          },
          "title": "Value",
          "description": "List of users in the SharePoint group."
        }
      }
    }
  },
  "title": "GetGroupUsersResponseWrapper",
  "required": [
    "data",
    "successful"
  ],
  "properties": {
    "data": {
      "type": "object",
      "title": "Data",
      "required": [
        "value"
      ],
      "properties": {
        "value": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "SPUser",
            "required": [
              "Id"
            ],
            "properties": {
              "Id": {
                "type": "integer",
                "title": "Id",
                "description": "User's member identifier."
              },
              "Email": {
                "type": "string",
                "title": "Email",
                "description": "Email address of the user."
              },
              "Title": {
                "type": "string",
                "title": "Title",
                "description": "Display name of the user."
              },
              "Groups": {
                "type": "object",
                "title": "Groups",
                "properties": {
                  "results": {
                    "type": "array",
                    "items": {
                      "type": "object",
                      "title": "SPGroupInfo",
                      "properties": {
                        "Id": {
                          "type": "integer",
                          "title": "Id",
                          "description": "Group ID."
                        },
                        "Title": {
                          "type": "string",
                          "title": "Title",
                          "description": "Group title."
                        },
                        "__metadata": {
                          "type": "object",
                          "title": "  Metadata",
                          "required": [
                            "id",
                            "uri",
                            "type"
                          ],
                          "properties": {
                            "id": {
                              "type": "string",
                              "title": "Id",
                              "description": "OData id of the group."
                            },
                            "uri": {
                              "type": "string",
                              "title": "Uri",
                              "description": "OData uri of the group."
                            },
                            "type": {
                              "type": "string",
                              "title": "Type",
                              "description": "OData type of the group."
                            }
                          },
                          "additionalProperties": true,
                          "description": "OData metadata for the group."
                        }
                      },
                      "additionalProperties": true
                    },
                    "title": "Results",
                    "description": "Expanded list of groups when $expand is used."
                  },
                  "__deferred": {
                    "type": "object",
                    "title": "  Deferred",
                    "required": [
                      "uri"
                    ],
                    "properties": {
                      "uri": {
                        "type": "string",
                        "title": "Uri",
                        "description": "URI of the deferred navigation property."
                      }
                    },
                    "description": "Deferred link to groups collection.",
                    "additionalProperties": true
                  }
                },
                "description": "Deferred link or expanded groups the user belongs to.",
                "additionalProperties": true
              },
              "UserId": {
                "type": "object",
                "title": "User Id",
                "required": [
                  "NameId",
                  "NameIdIssuer"
                ],
                "properties": {
                  "NameId": {
                    "type": "string",
                    "title": "Name Id",
                    "description": "NameId assigned to the user."
                  },
                  "NameIdIssuer": {
                    "type": "string",
                    "title": "Name Id Issuer",
                    "description": "Issuer of the NameId."
                  }
                },
                "description": "UserId and issuer info. May be null for some users."
              },
              "LoginName": {
                "type": "string",
                "title": "Login Name",
                "description": "User login name (claims format)."
              },
              "IsSiteAdmin": {
                "type": "boolean",
                "title": "Is Site Admin",
                "description": "Whether the user is a site collection admin."
              },
              "IsHiddenInUI": {
                "type": "boolean",
                "title": "Is Hidden In Ui",
                "description": "Whether the member is hidden in UI."
              },
              "PrincipalType": {
                "type": "integer",
                "title": "Principal Type",
                "description": "Principal type bitmask."
              }
            },
            "additionalProperties": true
          },
          "title": "Value",
          "description": "List of users in the SharePoint group."
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

## SHARE_POINT_GET_GROUP_USERS_BY_ID
Tool to retrieve all users in a specific SharePoint site group by group ID. Use when you have the numeric group ID and need to list all members of that group, including their IDs, names, email addresses, and permission details. Supports OData query parameters for filtering, sorting, field selection, and pagination.

**Input schema:**
```json
{
  "type": "object",
  "title": "GetGroupUsersByIdRequest",
  "required": [
    "group_id"
  ],
  "properties": {
    "top": {
      "type": "integer",
      "title": "Top",
      "minimum": 1,
      "examples": [
        10,
        50
      ],
      "description": "OData $top parameter to limit the number of returned users. Must be a positive integer."
    },
    "expand": {
      "type": "string",
      "title": "Expand",
      "examples": [
        "Groups"
      ],
      "description": "OData $expand parameter to expand related navigation properties. Use 'Groups' to get the user's group memberships."
    },
    "filter": {
      "type": "string",
      "title": "Filter",
      "examples": [
        "PrincipalType eq 1",
        "IsSiteAdmin eq true"
      ],
      "description": "OData $filter parameter to filter the returned users. Use OData filter syntax (e.g., 'PrincipalType eq 1' for regular users)."
    },
    "select": {
      "type": "string",
      "title": "Select",
      "examples": [
        "Id,Title,Email"
      ],
      "description": "OData $select parameter to return only specific user fields. Comma-separated field names (e.g., 'Id,Title,Email,LoginName')."
    },
    "orderby": {
      "type": "string",
      "title": "Orderby",
      "examples": [
        "Title",
        "Title desc"
      ],
      "description": "OData $orderby parameter to sort the returned users. Specify field name and optional 'asc' or 'desc' (e.g., 'Title desc')."
    },
    "group_id": {
      "type": "integer",
      "title": "Group Id",
      "examples": [
        3,
        5,
        7
      ],
      "description": "Numeric ID of the SharePoint site group to retrieve users from. Use list_site_groups action to get available group IDs."
    },
    "site_name": {
      "type": "string",
      "title": "Site Name",
      "examples": [
        "composio-test",
        "teamsite"
      ],
      "description": "The subsite name to scope the request to (e.g., 'composio-test'). If omitted, the root site is used. When provided, the API base URL becomes https://{tenant}.sharepoint.com/sites/{site}."
    },
    "skiptoken": {
      "type": "string",
      "title": "Skiptoken",
      "description": "OData $skiptoken parameter for pagination. Use the skiptoken value from a previous response's __next link to get the next page of results."
    }
  },
  "additionalProperties": false
}
```

**Output schema:**
```json
{
  "type": "object",
  "$defs": {
    "SPUser": {
      "type": "object",
      "title": "SPUser",
      "required": [
        "Id"
      ],
      "properties": {
        "Id": {
          "type": "integer",
          "title": "Id",
          "description": "User's member identifier."
        },
        "Email": {
          "type": "string",
          "title": "Email",
          "description": "Email address of the user."
        },
        "Title": {
          "type": "string",
          "title": "Title",
          "description": "Display name of the user."
        },
        "Groups": {
          "type": "object",
          "title": "Groups",
          "properties": {
            "results": {
              "type": "array",
              "items": {
                "type": "object",
                "title": "SPGroupInfo",
                "properties": {
                  "Id": {
                    "type": "integer",
                    "title": "Id",
                    "description": "Group ID."
                  },
                  "Title": {
                    "type": "string",
                    "title": "Title",
                    "description": "Group title."
                  },
                  "__metadata": {
                    "type": "object",
                    "title": "  Metadata",
                    "required": [
                      "id",
                      "uri",
                      "type"
                    ],
                    "properties": {
                      "id": {
                        "type": "string",
                        "title": "Id",
                        "description": "OData id of the group."
                      },
                      "uri": {
                        "type": "string",
                        "title": "Uri",
                        "description": "OData uri of the group."
                      },
                      "type": {
                        "type": "string",
                        "title": "Type",
                        "description": "OData type of the group."
                      }
                    },
                    "additionalProperties": true,
                    "description": "OData metadata for the group."
                  }
                },
                "additionalProperties": true
              },
              "title": "Results",
              "description": "Expanded list of groups when $expand is used."
            },
            "__deferred": {
              "type": "object",
              "title": "  Deferred",
              "required": [
                "uri"
              ],
              "properties": {
                "uri": {
                  "type": "string",
                  "title": "Uri",
                  "description": "URI of the deferred navigation property."
                }
              },
              "description": "Deferred link to groups collection.",
              "additionalProperties": true
            }
          },
          "description": "Deferred link or expanded groups the user belongs to.",
          "additionalProperties": true
        },
        "UserId": {
          "type": "object",
          "title": "User Id",
          "required": [
            "NameId",
            "NameIdIssuer"
          ],
          "properties": {
            "NameId": {
              "type": "string",
              "title": "Name Id",
              "description": "NameId assigned to the user."
            },
            "NameIdIssuer": {
              "type": "string",
              "title": "Name Id Issuer",
              "description": "Issuer of the NameId."
            }
          },
          "description": "UserId and issuer info. May be null for some users."
        },
        "LoginName": {
          "type": "string",
          "title": "Login Name",
          "description": "User login name (claims format)."
        },
        "IsSiteAdmin": {
          "type": "boolean",
          "title": "Is Site Admin",
          "description": "Whether the user is a site collection admin."
        },
        "IsHiddenInUI": {
          "type": "boolean",
          "title": "Is Hidden In Ui",
          "description": "Whether the member is hidden in UI."
        },
        "PrincipalType": {
          "type": "integer",
          "title": "Principal Type",
          "description": "Principal type bitmask."
        }
      },
      "additionalProperties": true
    },
    "SPGroupInfo": {
      "type": "object",
      "title": "SPGroupInfo",
      "properties": {
        "Id": {
          "type": "integer",
          "title": "Id",
          "description": "Group ID."
        },
        "Title": {
          "type": "string",
          "title": "Title",
          "description": "Group title."
        },
        "__metadata": {
          "type": "object",
          "title": "  Metadata",
          "required": [
            "id",
            "uri",
            "type"
          ],
          "properties": {
            "id": {
              "type": "string",
              "title": "Id",
              "description": "OData id of the group."
            },
            "uri": {
              "type": "string",
              "title": "Uri",
              "description": "OData uri of the group."
            },
            "type": {
              "type": "string",
              "title": "Type",
              "description": "OData type of the group."
            }
          },
          "additionalProperties": true,
          "description": "OData metadata for the group."
        }
      },
      "additionalProperties": true
    },
    "SPUserIdInfo": {
      "type": "object",
      "title": "SPUserIdInfo",
      "required": [
        "NameId",
        "NameIdIssuer"
      ],
      "properties": {
        "NameId": {
          "type": "string",
          "title": "Name Id",
          "description": "NameId assigned to the user."
        },
        "NameIdIssuer": {
          "type": "string",
          "title": "Name Id Issuer",
          "description": "Issuer of the NameId."
        }
      }
    },
    "SPDeferredLink": {
      "type": "object",
      "title": "SPDeferredLink",
      "required": [
        "uri"
      ],
      "properties": {
        "uri": {
          "type": "string",
          "title": "Uri",
          "description": "URI of the deferred navigation property."
        }
      },
      "description": "Represents a deferred navigation property link.",
      "additionalProperties": true
    },
    "SPGroupMetadata": {
      "type": "object",
      "title": "SPGroupMetadata",
      "required": [
        "id",
        "uri",
        "type"
      ],
      "properties": {
        "id": {
          "type": "string",
          "title": "Id",
          "description": "OData id of the group."
        },
        "uri": {
          "type": "string",
          "title": "Uri",
          "description": "OData uri of the group."
        },
        "type": {
          "type": "string",
          "title": "Type",
          "description": "OData type of the group."
        }
      },
      "additionalProperties": true
    },
    "SPGroupCollection": {
      "type": "object",
      "title": "SPGroupCollection",
      "properties": {
        "results": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "SPGroupInfo",
            "properties": {
              "Id": {
                "type": "integer",
                "title": "Id",
                "description": "Group ID."
              },
              "Title": {
                "type": "string",
                "title": "Title",
                "description": "Group title."
              },
              "__metadata": {
                "type": "object",
                "title": "  Metadata",
                "required": [
                  "id",
                  "uri",
                  "type"
                ],
                "properties": {
                  "id": {
                    "type": "string",
                    "title": "Id",
                    "description": "OData id of the group."
                  },
                  "uri": {
                    "type": "string",
                    "title": "Uri",
                    "description": "OData uri of the group."
                  },
                  "type": {
                    "type": "string",
                    "title": "Type",
                    "description": "OData type of the group."
                  }
                },
                "additionalProperties": true,
                "description": "OData metadata for the group."
              }
            },
            "additionalProperties": true
          },
          "title": "Results",
          "description": "Expanded list of groups when $expand is used."
        },
        "__deferred": {
          "type": "object",
          "title": "  Deferred",
          "required": [
            "uri"
          ],
          "properties": {
            "uri": {
              "type": "string",
              "title": "Uri",
              "description": "URI of the deferred navigation property."
            }
          },
          "description": "Deferred link to groups collection.",
          "additionalProperties": true
        }
      },
      "description": "Represents either a deferred link or expanded group results.",
      "additionalProperties": true
    },
    "GetGroupUsersByIdResponse": {
      "type": "object",
      "title": "GetGroupUsersByIdResponse",
      "required": [
        "value"
      ],
      "properties": {
        "value": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "SPUser",
            "required": [
              "Id"
            ],
            "properties": {
              "Id": {
                "type": "integer",
                "title": "Id",
                "description": "User's member identifier."
              },
              "Email": {
                "type": "string",
                "title": "Email",
                "description": "Email address of the user."
              },
              "Title": {
                "type": "string",
                "title": "Title",
                "description": "Display name of the user."
              },
              "Groups": {
                "type": "object",
                "title": "Groups",
                "properties": {
                  "results": {
                    "type": "array",
                    "items": {
                      "type": "object",
                      "title": "SPGroupInfo",
                      "properties": {
                        "Id": {
                          "type": "integer",
                          "title": "Id",
                          "description": "Group ID."
                        },
                        "Title": {
                          "type": "string",
                          "title": "Title",
                          "description": "Group title."
                        },
                        "__metadata": {
                          "type": "object",
                          "title": "  Metadata",
                          "required": [
                            "id",
                            "uri",
                            "type"
                          ],
                          "properties": {
                            "id": {
                              "type": "string",
                              "title": "Id",
                              "description": "OData id of the group."
                            },
                            "uri": {
                              "type": "string",
                              "title": "Uri",
                              "description": "OData uri of the group."
                            },
                            "type": {
                              "type": "string",
                              "title": "Type",
                              "description": "OData type of the group."
                            }
                          },
                          "additionalProperties": true,
                          "description": "OData metadata for the group."
                        }
                      },
                      "additionalProperties": true
                    },
                    "title": "Results",
                    "description": "Expanded list of groups when $expand is used."
                  },
                  "__deferred": {
                    "type": "object",
                    "title": "  Deferred",
                    "required": [
                      "uri"
                    ],
                    "properties": {
                      "uri": {
                        "type": "string",
                        "title": "Uri",
                        "description": "URI of the deferred navigation property."
                      }
                    },
                    "description": "Deferred link to groups collection.",
                    "additionalProperties": true
                  }
                },
                "description": "Deferred link or expanded groups the user belongs to.",
                "additionalProperties": true
              },
              "UserId": {
                "type": "object",
                "title": "User Id",
                "required": [
                  "NameId",
                  "NameIdIssuer"
                ],
                "properties": {
                  "NameId": {
                    "type": "string",
                    "title": "Name Id",
                    "description": "NameId assigned to the user."
                  },
                  "NameIdIssuer": {
                    "type": "string",
                    "title": "Name Id Issuer",
                    "description": "Issuer of the NameId."
                  }
                },
                "description": "UserId and issuer info. May be null for some users."
              },
              "LoginName": {
                "type": "string",
                "title": "Login Name",
                "description": "User login name (claims format)."
              },
              "IsSiteAdmin": {
                "type": "boolean",
                "title": "Is Site Admin",
                "description": "Whether the user is a site collection admin."
              },
              "IsHiddenInUI": {
                "type": "boolean",
                "title": "Is Hidden In Ui",
                "description": "Whether the member is hidden in UI."
              },
              "PrincipalType": {
                "type": "integer",
                "title": "Principal Type",
                "description": "Principal type bitmask."
              }
            },
            "additionalProperties": true
          },
          "title": "Value",
          "description": "List of users in the SharePoint group."
        }
      }
    }
  },
  "title": "GetGroupUsersByIdResponseWrapper",
  "required": [
    "data",
    "successful"
  ],
  "properties": {
    "data": {
      "type": "object",
      "title": "Data",
      "required": [
        "value"
      ],
      "properties": {
        "value": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "SPUser",
            "required": [
              "Id"
            ],
            "properties": {
              "Id": {
                "type": "integer",
                "title": "Id",
                "description": "User's member identifier."
              },
              "Email": {
                "type": "string",
                "title": "Email",
                "description": "Email address of the user."
              },
              "Title": {
                "type": "string",
                "title": "Title",
                "description": "Display name of the user."
              },
              "Groups": {
                "type": "object",
                "title": "Groups",
                "properties": {
                  "results": {
                    "type": "array",
                    "items": {
                      "type": "object",
                      "title": "SPGroupInfo",
                      "properties": {
                        "Id": {
                          "type": "integer",
                          "title": "Id",
                          "description": "Group ID."
                        },
                        "Title": {
                          "type": "string",
                          "title": "Title",
                          "description": "Group title."
                        },
                        "__metadata": {
                          "type": "object",
                          "title": "  Metadata",
                          "required": [
                            "id",
                            "uri",
                            "type"
                          ],
                          "properties": {
                            "id": {
                              "type": "string",
                              "title": "Id",
                              "description": "OData id of the group."
                            },
                            "uri": {
                              "type": "string",
                              "title": "Uri",
                              "description": "OData uri of the group."
                            },
                            "type": {
                              "type": "string",
                              "title": "Type",
                              "description": "OData type of the group."
                            }
                          },
                          "additionalProperties": true,
                          "description": "OData metadata for the group."
                        }
                      },
                      "additionalProperties": true
                    },
                    "title": "Results",
                    "description": "Expanded list of groups when $expand is used."
                  },
                  "__deferred": {
                    "type": "object",
                    "title": "  Deferred",
                    "required": [
                      "uri"
                    ],
                    "properties": {
                      "uri": {
                        "type": "string",
                        "title": "Uri",
                        "description": "URI of the deferred navigation property."
                      }
                    },
                    "description": "Deferred link to groups collection.",
                    "additionalProperties": true
                  }
                },
                "description": "Deferred link or expanded groups the user belongs to.",
                "additionalProperties": true
              },
              "UserId": {
                "type": "object",
                "title": "User Id",
                "required": [
                  "NameId",
                  "NameIdIssuer"
                ],
                "properties": {
                  "NameId": {
                    "type": "string",
                    "title": "Name Id",
                    "description": "NameId assigned to the user."
                  },
                  "NameIdIssuer": {
                    "type": "string",
                    "title": "Name Id Issuer",
                    "description": "Issuer of the NameId."
                  }
                },
                "description": "UserId and issuer info. May be null for some users."
              },
              "LoginName": {
                "type": "string",
                "title": "Login Name",
                "description": "User login name (claims format)."
              },
              "IsSiteAdmin": {
                "type": "boolean",
                "title": "Is Site Admin",
                "description": "Whether the user is a site collection admin."
              },
              "IsHiddenInUI": {
                "type": "boolean",
                "title": "Is Hidden In Ui",
                "description": "Whether the member is hidden in UI."
              },
              "PrincipalType": {
                "type": "integer",
                "title": "Principal Type",
                "description": "Principal type bitmask."
              }
            },
            "additionalProperties": true
          },
          "title": "Value",
          "description": "List of users in the SharePoint group."
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

## SHARE_POINT_GET_ITEM_ATTACHMENT_CONTENT
Tool to download an attachment from a SharePoint list item. Use when retrieving the binary contents of a specific attachment after confirming the list title, item ID, and filename.

**Input schema:**
```json
{
  "type": "object",
  "title": "GetItemAttachmentContentRequest",
  "required": [
    "list_title",
    "item_id",
    "file_name"
  ],
  "properties": {
    "item_id": {
      "type": "integer",
      "title": "Item Id",
      "minimum": 0,
      "examples": [
        1
      ],
      "description": "ID of the list item to retrieve the attachment from (must be non-negative)."
    },
    "file_name": {
      "type": "string",
      "title": "File Name",
      "examples": [
        "report.pdf"
      ],
      "description": "Exact name of the attachment file, including extension."
    },
    "site_name": {
      "type": "string",
      "title": "Site Name",
      "examples": [
        "composio-test",
        "marketing",
        "hr-portal"
      ],
      "description": "The subsite name to scope the request to (e.g., 'composio-test'). If omitted, the root site is used. When provided, the API base URL becomes https://{tenant}.sharepoint.com/sites/{site}."
    },
    "list_title": {
      "type": "string",
      "title": "List Title",
      "examples": [
        "Documents"
      ],
      "description": "Title of the SharePoint list containing the target item."
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
    "GetItemAttachmentContentResponse": {
      "type": "object",
      "title": "GetItemAttachmentContentResponse",
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
          "description": "Downloaded file content"
        }
      }
    }
  },
  "title": "GetItemAttachmentContentResponseWrapper",
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
          "description": "Downloaded file content"
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

## SHARE_POINT_GET_LIST_BY_GUID
Tool to retrieve a SharePoint list by its GUID. Use when you need to fetch list metadata by its unique identifier. Prefer over name-based lookup tools when the GUID is known, as names may collide across similarly named lists.

**Input schema:**
```json
{
  "type": "object",
  "title": "GetListByGuidRequest",
  "required": [
    "list_guid"
  ],
  "properties": {
    "expand": {
      "type": "string",
      "title": "Expand",
      "description": "Comma-separated list of related entities to include in the response. Common values: Fields (list fields/columns), RootFolder (folder information), ContentTypes, Views. Example: 'Fields' or 'RootFolder'"
    },
    "select": {
      "type": "string",
      "title": "Select",
      "description": "Comma-separated list of fields to return. Limits the response to only specified fields. Common fields: Title, Id, Description, ItemCount, BaseType, BaseTemplate, Created, Hidden, EntityTypeName, ListItemEntityTypeFullName. Example: 'Title,Id,ItemCount'"
    },
    "list_guid": {
      "type": "string",
      "title": "List Guid",
      "examples": [
        "01234567-89ab-cdef-0123-456789abcdef"
      ],
      "description": "GUID of the SharePoint list to retrieve, in canonical format, e.g., '01234567-89ab-cdef-0123-456789abcdef'."
    },
    "site_name": {
      "type": "string",
      "title": "Site Name",
      "examples": [
        "composio-test",
        "marketing",
        "hr-portal"
      ],
      "description": "The subsite name to scope the request to (e.g., 'composio-test'). If omitted, the root site is used. When provided, the API base URL becomes https://{tenant}.sharepoint.com/sites/{site}."
    }
  },
  "description": "Request model for retrieving a SharePoint list by its GUID."
}
```

**Output schema:**
```json
{
  "type": "object",
  "$defs": {
    "GetListByGuidResponse": {
      "type": "object",
      "title": "GetListByGuidResponse",
      "properties": {
        "Id": {
          "type": "string",
          "title": "Id",
          "description": "GUID of the list."
        },
        "Title": {
          "type": "string",
          "title": "Title",
          "description": "Title of the list."
        },
        "Hidden": {
          "type": "boolean",
          "title": "Hidden",
          "description": "Whether the list is hidden."
        },
        "Created": {
          "type": "string",
          "title": "Created",
          "description": "Timestamp when the list was created."
        },
        "NoCrawl": {
          "type": "boolean",
          "title": "No Crawl",
          "description": "Whether the list is excluded from search."
        },
        "BaseType": {
          "type": "integer",
          "title": "Base Type",
          "description": "Base type of the list."
        },
        "ImageUrl": {
          "type": "string",
          "title": "Image Url",
          "description": "URL of the list image if set."
        },
        "Direction": {
          "type": "string",
          "title": "Direction",
          "description": "Direction setting of the list."
        },
        "IrmExpire": {
          "type": "boolean",
          "title": "Irm Expire",
          "description": "Whether IRM expiration is enabled."
        },
        "IrmReject": {
          "type": "boolean",
          "title": "Irm Reject",
          "description": "Whether IRM rejection is enabled."
        },
        "IsCatalog": {
          "type": "boolean",
          "title": "Is Catalog",
          "description": "Whether the list is a catalog."
        },
        "IsPrivate": {
          "type": "boolean",
          "title": "Is Private",
          "description": "Whether the list is private."
        },
        "ItemCount": {
          "type": "integer",
          "title": "Item Count",
          "description": "Number of items in the list."
        },
        "IrmEnabled": {
          "type": "boolean",
          "title": "Irm Enabled",
          "description": "Whether IRM is enabled."
        },
        "Description": {
          "type": "string",
          "title": "Description",
          "description": "Description of the list."
        },
        "BaseTemplate": {
          "type": "integer",
          "title": "Base Template",
          "description": "Base template ID of the list."
        },
        "ParentWebUrl": {
          "type": "string",
          "title": "Parent Web Url",
          "description": "Server-relative URL of the parent web."
        },
        "ForceCheckout": {
          "type": "boolean",
          "title": "Force Checkout",
          "description": "Whether files require checkout."
        },
        "EntityTypeName": {
          "type": "string",
          "title": "Entity Type Name",
          "description": "Entity type name for list items."
        },
        "EnableModeration": {
          "type": "boolean",
          "title": "Enable Moderation",
          "description": "Whether moderation is enabled."
        },
        "EnableVersioning": {
          "type": "boolean",
          "title": "Enable Versioning",
          "description": "Whether versioning is enabled."
        },
        "MultipleDataList": {
          "type": "boolean",
          "title": "Multiple Data List",
          "description": "Whether multiple data sources are enabled."
        },
        "AllowContentTypes": {
          "type": "boolean",
          "title": "Allow Content Types",
          "description": "Whether content types are allowed on the list."
        },
        "EnableAttachments": {
          "type": "boolean",
          "title": "Enable Attachments",
          "description": "Whether attachments are enabled."
        },
        "IsApplicationList": {
          "type": "boolean",
          "title": "Is Application List",
          "description": "Whether this is an application list."
        },
        "TemplateFeatureId": {
          "type": "string",
          "title": "Template Feature Id",
          "description": "GUID of the template feature."
        },
        "ContentTypesEnabled": {
          "type": "boolean",
          "title": "Content Types Enabled",
          "description": "Whether content types are enabled."
        },
        "DocumentTemplateUrl": {
          "type": "string",
          "title": "Document Template Url",
          "description": "URL of the document template if any."
        },
        "EnableMinorVersions": {
          "type": "boolean",
          "title": "Enable Minor Versions",
          "description": "Whether minor versions are enabled."
        },
        "LastItemDeletedDate": {
          "type": "string",
          "title": "Last Item Deleted Date",
          "description": "Timestamp when the last item was deleted."
        },
        "EnableFolderCreation": {
          "type": "boolean",
          "title": "Enable Folder Creation",
          "description": "Whether folder creation is allowed."
        },
        "LastItemModifiedDate": {
          "type": "string",
          "title": "Last Item Modified Date",
          "description": "Timestamp when the last item was modified."
        },
        "HasExternalDataSource": {
          "type": "boolean",
          "title": "Has External Data Source",
          "description": "Whether external data source is connected."
        },
        "DraftVersionVisibility": {
          "type": "integer",
          "title": "Draft Version Visibility",
          "description": "Draft version visibility setting."
        },
        "ListItemEntityTypeFullName": {
          "type": "string",
          "title": "List Item Entity Type Full Name",
          "description": "Full entity type name for list items."
        },
        "ServerTemplateCanCreateFolders": {
          "type": "boolean",
          "title": "Server Template Can Create Folders",
          "description": "Whether the template allows folder creation."
        },
        "DefaultContentApprovalWorkflowId": {
          "type": "string",
          "title": "Default Content Approval Workflow Id",
          "description": "GUID of the default content approval workflow."
        }
      },
      "description": "Response model for a SharePoint list retrieved by GUID. Fields may be optional when using $select parameter.",
      "additionalProperties": true
    }
  },
  "title": "GetListByGuidResponseWrapper",
  "required": [
    "data",
    "successful"
  ],
  "properties": {
    "data": {
      "type": "object",
      "title": "Data",
      "properties": {
        "Id": {
          "type": "string",
          "title": "Id",
          "description": "GUID of the list."
        },
        "Title": {
          "type": "string",
          "title": "Title",
          "description": "Title of the list."
        },
        "Hidden": {
          "type": "boolean",
          "title": "Hidden",
          "description": "Whether the list is hidden."
        },
        "Created": {
          "type": "string",
          "title": "Created",
          "description": "Timestamp when the list was created."
        },
        "NoCrawl": {
          "type": "boolean",
          "title": "No Crawl",
          "description": "Whether the list is excluded from search."
        },
        "BaseType": {
          "type": "integer",
          "title": "Base Type",
          "description": "Base type of the list."
        },
        "ImageUrl": {
          "type": "string",
          "title": "Image Url",
          "description": "URL of the list image if set."
        },
        "Direction": {
          "type": "string",
          "title": "Direction",
          "description": "Direction setting of the list."
        },
        "IrmExpire": {
          "type": "boolean",
          "title": "Irm Expire",
          "description": "Whether IRM expiration is enabled."
        },
        "IrmReject": {
          "type": "boolean",
          "title": "Irm Reject",
          "description": "Whether IRM rejection is enabled."
        },
        "IsCatalog": {
          "type": "boolean",
          "title": "Is Catalog",
          "description": "Whether the list is a catalog."
        },
        "IsPrivate": {
          "type": "boolean",
          "title": "Is Private",
          "description": "Whether the list is private."
        },
        "ItemCount": {
          "type": "integer",
          "title": "Item Count",
          "description": "Number of items in the list."
        },
        "IrmEnabled": {
          "type": "boolean",
          "title": "Irm Enabled",
          "description": "Whether IRM is enabled."
        },
        "Description": {
          "type": "string",
          "title": "Description",
          "description": "Description of the list."
        },
        "BaseTemplate": {
          "type": "integer",
          "title": "Base Template",
          "description": "Base template ID of the list."
        },
        "ParentWebUrl": {
          "type": "string",
          "title": "Parent Web Url",
          "description": "Server-relative URL of the parent web."
        },
        "ForceCheckout": {
          "type": "boolean",
          "title": "Force Checkout",
          "description": "Whether files require checkout."
        },
        "EntityTypeName": {
          "type": "string",
          "title": "Entity Type Name",
          "description": "Entity type name for list items."
        },
        "EnableModeration": {
          "type": "boolean",
          "title": "Enable Moderation",
          "description": "Whether moderation is enabled."
        },
        "EnableVersioning": {
          "type": "boolean",
          "title": "Enable Versioning",
          "description": "Whether versioning is enabled."
        },
        "MultipleDataList": {
          "type": "boolean",
          "title": "Multiple Data List",
          "description": "Whether multiple data sources are enabled."
        },
        "AllowContentTypes": {
          "type": "boolean",
          "title": "Allow Content Types",
          "description": "Whether content types are allowed on the list."
        },
        "EnableAttachments": {
          "type": "boolean",
          "title": "Enable Attachments",
          "description": "Whether attachments are enabled."
        },
        "IsApplicationList": {
          "type": "boolean",
          "title": "Is Application List",
          "description": "Whether this is an application list."
        },
        "TemplateFeatureId": {
          "type": "string",
          "title": "Template Feature Id",
          "description": "GUID of the template feature."
        },
        "ContentTypesEnabled": {
          "type": "boolean",
          "title": "Content Types Enabled",
          "description": "Whether content types are enabled."
        },
        "DocumentTemplateUrl": {
          "type": "string",
          "title": "Document Template Url",
          "description": "URL of the document template if any."
        },
        "EnableMinorVersions": {
          "type": "boolean",
          "title": "Enable Minor Versions",
          "description": "Whether minor versions are enabled."
        },
        "LastItemDeletedDate": {
          "type": "string",
          "title": "Last Item Deleted Date",
          "description": "Timestamp when the last item was deleted."
        },
        "EnableFolderCreation": {
          "type": "boolean",
          "title": "Enable Folder Creation",
          "description": "Whether folder creation is allowed."
        },
        "LastItemModifiedDate": {
          "type": "string",
          "title": "Last Item Modified Date",
          "description": "Timestamp when the last item was modified."
        },
        "HasExternalDataSource": {
          "type": "boolean",
          "title": "Has External Data Source",
          "description": "Whether external data source is connected."
        },
        "DraftVersionVisibility": {
          "type": "integer",
          "title": "Draft Version Visibility",
          "description": "Draft version visibility setting."
        },
        "ListItemEntityTypeFullName": {
          "type": "string",
          "title": "List Item Entity Type Full Name",
          "description": "Full entity type name for list items."
        },
        "ServerTemplateCanCreateFolders": {
          "type": "boolean",
          "title": "Server Template Can Create Folders",
          "description": "Whether the template allows folder creation."
        },
        "DefaultContentApprovalWorkflowId": {
          "type": "string",
          "title": "Default Content Approval Workflow Id",
          "description": "GUID of the default content approval workflow."
        }
      },
      "description": "Data from the action execution",
      "additionalProperties": true
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

## SHARE_POINT_GET_LIST_BY_TITLE
Tool to retrieve a SharePoint list by its title. Use when you need to fetch list metadata by title.

**Input schema:**
```json
{
  "type": "object",
  "title": "GetListByTitleRequest",
  "required": [
    "list_title"
  ],
  "properties": {
    "expand": {
      "type": "string",
      "title": "Expand",
      "description": "Comma-separated list of related entities to include in the response. Common values: Fields (list fields/columns), RootFolder (folder information), ContentTypes, Views. Example: 'Fields' or 'RootFolder' Expanding Fields includes system and hidden fields; check the Hidden metadata flag to identify user-facing columns."
    },
    "select": {
      "type": "string",
      "title": "Select",
      "description": "Comma-separated list of fields to return. Limits the response to only specified fields. Common fields: Title, Id, Description, ItemCount, BaseType, BaseTemplate, Created, Hidden, EntityTypeName, ListItemEntityTypeFullName. Example: 'Title,Id,ItemCount' Include 'Id' when the list GUID is needed as `list_guid`/`list_id` for downstream calls like SHARE_POINT_CREATE_LIST_FIELD."
    },
    "site_name": {
      "type": "string",
      "title": "Site Name",
      "examples": [
        "testcomposio",
        "marketing",
        "hr-portal"
      ],
      "description": "Optional SharePoint site name to scope the list retrieval. If provided, the list is fetched from /sites/{site}. If not provided, the list is fetched from the tenant root site. E.g., 'testcomposio' for a site at /sites/testcomposio."
    },
    "list_title": {
      "type": "string",
      "title": "List Title",
      "examples": [
        "Documents"
      ],
      "description": "Title of the SharePoint list to retrieve. Will be URL-encoded and enclosed in single quotes in the endpoint. Must be an exact case-sensitive match to the list's display title; typos or renamed lists will cause lookup failures."
    }
  },
  "description": "Request model for retrieving a SharePoint list by its title.",
  "additionalProperties": false
}
```

**Output schema:**
```json
{
  "type": "object",
  "$defs": {
    "GetListByTitleResponse": {
      "type": "object",
      "title": "GetListByTitleResponse",
      "properties": {
        "Id": {
          "type": "string",
          "title": "Id",
          "description": "GUID ID of the list."
        },
        "Title": {
          "type": "string",
          "title": "Title",
          "description": "Title of the list."
        },
        "Hidden": {
          "type": "boolean",
          "title": "Hidden",
          "description": "Whether the list is hidden."
        },
        "Created": {
          "type": "string",
          "title": "Created",
          "description": "When the list was created."
        },
        "NoCrawl": {
          "type": "boolean",
          "title": "No Crawl",
          "description": "Whether the list is excluded from crawl."
        },
        "BaseType": {
          "type": "integer",
          "title": "Base Type",
          "description": "Base type of the list."
        },
        "ImageUrl": {
          "type": "string",
          "title": "Image Url",
          "description": "URL of the list image."
        },
        "Direction": {
          "type": "string",
          "title": "Direction",
          "description": "Direction of the list (e.g., none)."
        },
        "IrmExpire": {
          "type": "boolean",
          "title": "Irm Expire",
          "description": "IRM expire setting."
        },
        "IrmReject": {
          "type": "boolean",
          "title": "Irm Reject",
          "description": "IRM reject setting."
        },
        "IsCatalog": {
          "type": "boolean",
          "title": "Is Catalog",
          "description": "Whether this is a catalog list."
        },
        "IsPrivate": {
          "type": "boolean",
          "title": "Is Private",
          "description": "Whether this is a private list."
        },
        "ItemCount": {
          "type": "integer",
          "title": "Item Count",
          "description": "Number of items in the list."
        },
        "IrmEnabled": {
          "type": "boolean",
          "title": "Irm Enabled",
          "description": "Whether IRM is enabled."
        },
        "Description": {
          "type": "string",
          "title": "Description",
          "description": "Description of the list."
        },
        "BaseTemplate": {
          "type": "integer",
          "title": "Base Template",
          "description": "List definition type on which the list is based."
        },
        "ParentWebUrl": {
          "type": "string",
          "title": "Parent Web Url",
          "description": "Server-relative URL of the parent web."
        },
        "ForceCheckout": {
          "type": "boolean",
          "title": "Force Checkout",
          "description": "Whether checkout is forced for documents."
        },
        "EntityTypeName": {
          "type": "string",
          "title": "Entity Type Name",
          "description": "Entity type name for list items."
        },
        "EnableModeration": {
          "type": "boolean",
          "title": "Enable Moderation",
          "description": "Whether content moderation is enabled."
        },
        "EnableVersioning": {
          "type": "boolean",
          "title": "Enable Versioning",
          "description": "Whether versioning is enabled for list items."
        },
        "MultipleDataList": {
          "type": "boolean",
          "title": "Multiple Data List",
          "description": "Whether the list supports multiple data lists."
        },
        "AllowContentTypes": {
          "type": "boolean",
          "title": "Allow Content Types",
          "description": "Whether content types are allowed."
        },
        "EnableAttachments": {
          "type": "boolean",
          "title": "Enable Attachments",
          "description": "Whether attachments are enabled for list items."
        },
        "IsApplicationList": {
          "type": "boolean",
          "title": "Is Application List",
          "description": "Whether this is an application list."
        },
        "TemplateFeatureId": {
          "type": "string",
          "title": "Template Feature Id",
          "description": "Feature ID for the list template."
        },
        "ContentTypesEnabled": {
          "type": "boolean",
          "title": "Content Types Enabled",
          "description": "Whether content types are enabled for the list."
        },
        "DocumentTemplateUrl": {
          "type": "string",
          "title": "Document Template Url",
          "description": "Server-relative URL of the document template."
        },
        "EnableMinorVersions": {
          "type": "boolean",
          "title": "Enable Minor Versions",
          "description": "Whether minor versions are enabled."
        },
        "LastItemDeletedDate": {
          "type": "string",
          "title": "Last Item Deleted Date",
          "description": "Date when last item was deleted."
        },
        "EnableFolderCreation": {
          "type": "boolean",
          "title": "Enable Folder Creation",
          "description": "Whether folder creation is enabled."
        },
        "LastItemModifiedDate": {
          "type": "string",
          "title": "Last Item Modified Date",
          "description": "Date when last item was modified."
        },
        "HasExternalDataSource": {
          "type": "boolean",
          "title": "Has External Data Source",
          "description": "Whether the list has an external data source."
        },
        "DraftVersionVisibility": {
          "type": "integer",
          "title": "Draft Version Visibility",
          "description": "Draft version visibility setting."
        },
        "ListItemEntityTypeFullName": {
          "type": "string",
          "title": "List Item Entity Type Full Name",
          "description": "Full entity type name for list items."
        },
        "ServerTemplateCanCreateFolders": {
          "type": "boolean",
          "title": "Server Template Can Create Folders",
          "description": "Whether the server template allows folder creation."
        },
        "DefaultContentApprovalWorkflowId": {
          "type": "string",
          "title": "Default Content Approval Workflow Id",
          "description": "ID of the default content approval workflow."
        }
      },
      "description": "Response model representing a SharePoint list resource. Fields may be optional when using $select parameter.",
      "additionalProperties": true
    }
  },
  "title": "GetListByTitleResponseWrapper",
  "required": [
    "data",
    "successful"
  ],
  "properties": {
    "data": {
      "type": "object",
      "title": "Data",
      "properties": {
        "Id": {
          "type": "string",
          "title": "Id",
          "description": "GUID ID of the list."
        },
        "Title": {
          "type": "string",
          "title": "Title",
          "description": "Title of the list."
        },
        "Hidden": {
          "type": "boolean",
          "title": "Hidden",
          "description": "Whether the list is hidden."
        },
        "Created": {
          "type": "string",
          "title": "Created",
          "description": "When the list was created."
        },
        "NoCrawl": {
          "type": "boolean",
          "title": "No Crawl",
          "description": "Whether the list is excluded from crawl."
        },
        "BaseType": {
          "type": "integer",
          "title": "Base Type",
          "description": "Base type of the list."
        },
        "ImageUrl": {
          "type": "string",
          "title": "Image Url",
          "description": "URL of the list image."
        },
        "Direction": {
          "type": "string",
          "title": "Direction",
          "description": "Direction of the list (e.g., none)."
        },
        "IrmExpire": {
          "type": "boolean",
          "title": "Irm Expire",
          "description": "IRM expire setting."
        },
        "IrmReject": {
          "type": "boolean",
          "title": "Irm Reject",
          "description": "IRM reject setting."
        },
        "IsCatalog": {
          "type": "boolean",
          "title": "Is Catalog",
          "description": "Whether this is a catalog list."
        },
        "IsPrivate": {
          "type": "boolean",
          "title": "Is Private",
          "description": "Whether this is a private list."
        },
        "ItemCount": {
          "type": "integer",
          "title": "Item Count",
          "description": "Number of items in the list."
        },
        "IrmEnabled": {
          "type": "boolean",
          "title": "Irm Enabled",
          "description": "Whether IRM is enabled."
        },
        "Description": {
          "type": "string",
          "title": "Description",
          "description": "Description of the list."
        },
        "BaseTemplate": {
          "type": "integer",
          "title": "Base Template",
          "description": "List definition type on which the list is based."
        },
        "ParentWebUrl": {
          "type": "string",
          "title": "Parent Web Url",
          "description": "Server-relative URL of the parent web."
        },
        "ForceCheckout": {
          "type": "boolean",
          "title": "Force Checkout",
          "description": "Whether checkout is forced for documents."
        },
        "EntityTypeName": {
          "type": "string",
          "title": "Entity Type Name",
          "description": "Entity type name for list items."
        },
        "EnableModeration": {
          "type": "boolean",
          "title": "Enable Moderation",
          "description": "Whether content moderation is enabled."
        },
        "EnableVersioning": {
          "type": "boolean",
          "title": "Enable Versioning",
          "description": "Whether versioning is enabled for list items."
        },
        "MultipleDataList": {
          "type": "boolean",
          "title": "Multiple Data List",
          "description": "Whether the list supports multiple data lists."
        },
        "AllowContentTypes": {
          "type": "boolean",
          "title": "Allow Content Types",
          "description": "Whether content types are allowed."
        },
        "EnableAttachments": {
          "type": "boolean",
          "title": "Enable Attachments",
          "description": "Whether attachments are enabled for list items."
        },
        "IsApplicationList": {
          "type": "boolean",
          "title": "Is Application List",
          "description": "Whether this is an application list."
        },
        "TemplateFeatureId": {
          "type": "string",
          "title": "Template Feature Id",
          "description": "Feature ID for the list template."
        },
        "ContentTypesEnabled": {
          "type": "boolean",
          "title": "Content Types Enabled",
          "description": "Whether content types are enabled for the list."
        },
        "DocumentTemplateUrl": {
          "type": "string",
          "title": "Document Template Url",
          "description": "Server-relative URL of the document template."
        },
        "EnableMinorVersions": {
          "type": "boolean",
          "title": "Enable Minor Versions",
          "description": "Whether minor versions are enabled."
        },
        "LastItemDeletedDate": {
          "type": "string",
          "title": "Last Item Deleted Date",
          "description": "Date when last item was deleted."
        },
        "EnableFolderCreation": {
          "type": "boolean",
          "title": "Enable Folder Creation",
          "description": "Whether folder creation is enabled."
        },
        "LastItemModifiedDate": {
          "type": "string",
          "title": "Last Item Modified Date",
          "description": "Date when last item was modified."
        },
        "HasExternalDataSource": {
          "type": "boolean",
          "title": "Has External Data Source",
          "description": "Whether the list has an external data source."
        },
        "DraftVersionVisibility": {
          "type": "integer",
          "title": "Draft Version Visibility",
          "description": "Draft version visibility setting."
        },
        "ListItemEntityTypeFullName": {
          "type": "string",
          "title": "List Item Entity Type Full Name",
          "description": "Full entity type name for list items."
        },
        "ServerTemplateCanCreateFolders": {
          "type": "boolean",
          "title": "Server Template Can Create Folders",
          "description": "Whether the server template allows folder creation."
        },
        "DefaultContentApprovalWorkflowId": {
          "type": "string",
          "title": "Default Content Approval Workflow Id",
          "description": "ID of the default content approval workflow."
        }
      },
      "description": "Data from the action execution",
      "additionalProperties": true
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

## SHARE_POINT_GET_LIST_CONTENT_TYPE_BY_ID
Tool to retrieve a specific content type from a SharePoint list by its ID. Use when you need detailed information about a particular content type including its fields, schema, and metadata.

**Input schema:**
```json
{
  "type": "object",
  "title": "GetListContentTypeByIdRequest",
  "required": [
    "list_id",
    "content_type_id"
  ],
  "properties": {
    "list_id": {
      "type": "string",
      "title": "List Id",
      "examples": [
        "0e0f0c3b-e23e-4aaf-8e22-803a3b572315"
      ],
      "description": "GUID of the SharePoint list containing the content type, in canonical format (e.g., '0e0f0c3b-e23e-4aaf-8e22-803a3b572315')."
    },
    "site_name": {
      "type": "string",
      "title": "Site Name",
      "examples": [
        "composio-test",
        "marketing",
        "hr-portal"
      ],
      "description": "The subsite name to scope the request to (e.g., 'composio-test'). If omitted, the root site is used. When provided, the API base URL becomes https://{tenant}.sharepoint.com/sites/{site}."
    },
    "content_type_id": {
      "type": "string",
      "title": "Content Type Id",
      "examples": [
        "0x010100EAADC19ECD09234BAD136AAD68B38066"
      ],
      "description": "The content type identifier, a hexadecimal string (e.g., '0x010100EAADC19ECD09234BAD136AAD68B38066'). This is the unique ID of the content type within SharePoint."
    }
  },
  "description": "Request model for retrieving a specific content type from a SharePoint list."
}
```

**Output schema:**
```json
{
  "type": "object",
  "$defs": {
    "FieldRef": {
      "type": "object",
      "title": "FieldRef",
      "properties": {
        "Id": {
          "type": "string",
          "title": "Id",
          "description": "GUID of the field."
        },
        "Name": {
          "type": "string",
          "title": "Name",
          "description": "Internal name of the field."
        },
        "Type": {
          "type": "string",
          "title": "Type",
          "description": "Type of the field (e.g., 'Text', 'Number', 'DateTime')."
        },
        "Hidden": {
          "type": "boolean",
          "title": "Hidden",
          "description": "Whether the field is hidden from users."
        },
        "Required": {
          "type": "boolean",
          "title": "Required",
          "description": "Whether the field is required."
        },
        "DisplayName": {
          "type": "string",
          "title": "Display Name",
          "description": "Display name of the field shown to users."
        }
      },
      "description": "Model representing a field reference within a content type."
    },
    "ContentTypeIdObject": {
      "type": "object",
      "title": "ContentTypeIdObject",
      "required": [
        "StringValue"
      ],
      "properties": {
        "StringValue": {
          "type": "string",
          "title": "String Value",
          "description": "String representation of the content type ID."
        }
      },
      "description": "Model for the content type ID object returned by SharePoint."
    },
    "GetListContentTypeByIdResponse": {
      "type": "object",
      "title": "GetListContentTypeByIdResponse",
      "required": [
        "Id",
        "Name"
      ],
      "properties": {
        "Id": {
          "type": "object",
          "title": "Id",
          "required": [
            "StringValue"
          ],
          "properties": {
            "StringValue": {
              "type": "string",
              "title": "String Value",
              "description": "String representation of the content type ID."
            }
          },
          "description": "Content type ID object containing the StringValue."
        },
        "Name": {
          "type": "string",
          "title": "Name",
          "description": "Name of the content type (e.g., 'Document', 'Item', 'Folder')."
        },
        "Group": {
          "type": "string",
          "title": "Group",
          "description": "Content type group category (e.g., 'Document Content Types', 'List Content Types')."
        },
        "Fields": {
          "anyOf": [
            {
              "type": "array",
              "items": {
                "type": "object",
                "title": "FieldRef",
                "properties": {
                  "Id": {
                    "type": "string",
                    "title": "Id",
                    "description": "GUID of the field."
                  },
                  "Name": {
                    "type": "string",
                    "title": "Name",
                    "description": "Internal name of the field."
                  },
                  "Type": {
                    "type": "string",
                    "title": "Type",
                    "description": "Type of the field (e.g., 'Text', 'Number', 'DateTime')."
                  },
                  "Hidden": {
                    "type": "boolean",
                    "title": "Hidden",
                    "description": "Whether the field is hidden from users."
                  },
                  "Required": {
                    "type": "boolean",
                    "title": "Required",
                    "description": "Whether the field is required."
                  },
                  "DisplayName": {
                    "type": "string",
                    "title": "Display Name",
                    "description": "Display name of the field shown to users."
                  }
                },
                "description": "Model representing a field reference within a content type."
              }
            },
            {
              "type": "object",
              "additionalProperties": true
            }
          ],
          "title": "Fields",
          "description": "List of fields associated with this content type. May be a deferred object if not expanded."
        },
        "Hidden": {
          "type": "boolean",
          "title": "Hidden",
          "description": "Whether the content type is hidden from the user interface."
        },
        "Sealed": {
          "type": "boolean",
          "title": "Sealed",
          "description": "Whether the content type is sealed and cannot be customized."
        },
        "ReadOnly": {
          "type": "boolean",
          "title": "Read Only",
          "description": "Whether the content type is read-only and cannot be modified."
        },
        "StringId": {
          "type": "string",
          "title": "String Id",
          "description": "String representation of the content type ID (convenience field, same as Id.StringValue)."
        },
        "SchemaXml": {
          "type": "string",
          "title": "Schema Xml",
          "description": "XML schema definition of the content type."
        },
        "Description": {
          "type": "string",
          "title": "Description",
          "description": "Description of the content type."
        }
      },
      "description": "Response model for a SharePoint content type retrieved by ID."
    }
  },
  "title": "GetListContentTypeByIdResponseWrapper",
  "required": [
    "data",
    "successful"
  ],
  "properties": {
    "data": {
      "type": "object",
      "title": "Data",
      "required": [
        "Id",
        "Name"
      ],
      "properties": {
        "Id": {
          "type": "object",
          "title": "Id",
          "required": [
            "StringValue"
          ],
          "properties": {
            "StringValue": {
              "type": "string",
              "title": "String Value",
              "description": "String representation of the content type ID."
            }
          },
          "description": "Content type ID object containing the StringValue."
        },
        "Name": {
          "type": "string",
          "title": "Name",
          "description": "Name of the content type (e.g., 'Document', 'Item', 'Folder')."
        },
        "Group": {
          "type": "string",
          "title": "Group",
          "description": "Content type group category (e.g., 'Document Content Types', 'List Content Types')."
        },
        "Fields": {
          "anyOf": [
            {
              "type": "array",
              "items": {
                "type": "object",
                "title": "FieldRef",
                "properties": {
                  "Id": {
                    "type": "string",
                    "title": "Id",
                    "description": "GUID of the field."
                  },
                  "Name": {
                    "type": "string",
                    "title": "Name",
                    "description": "Internal name of the field."
                  },
                  "Type": {
                    "type": "string",
                    "title": "Type",
                    "description": "Type of the field (e.g., 'Text', 'Number', 'DateTime')."
                  },
                  "Hidden": {
                    "type": "boolean",
                    "title": "Hidden",
                    "description": "Whether the field is hidden from users."
                  },
                  "Required": {
                    "type": "boolean",
                    "title": "Required",
                    "description": "Whether the field is required."
                  },
                  "DisplayName": {
                    "type": "string",
                    "title": "Display Name",
                    "description": "Display name of the field shown to users."
                  }
                },
                "description": "Model representing a field reference within a content type."
              }
            },
            {
              "type": "object",
              "additionalProperties": true
            }
          ],
          "title": "Fields",
          "description": "List of fields associated with this content type. May be a deferred object if not expanded."
        },
        "Hidden": {
          "type": "boolean",
          "title": "Hidden",
          "description": "Whether the content type is hidden from the user interface."
        },
        "Sealed": {
          "type": "boolean",
          "title": "Sealed",
          "description": "Whether the content type is sealed and cannot be customized."
        },
        "ReadOnly": {
          "type": "boolean",
          "title": "Read Only",
          "description": "Whether the content type is read-only and cannot be modified."
        },
        "StringId": {
          "type": "string",
          "title": "String Id",
          "description": "String representation of the content type ID (convenience field, same as Id.StringValue)."
        },
        "SchemaXml": {
          "type": "string",
          "title": "Schema Xml",
          "description": "XML schema definition of the content type."
        },
        "Description": {
          "type": "string",
          "title": "Description",
          "description": "Description of the content type."
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

## SHARE_POINT_GET_LIST_ITEM_BY_ID
Tool to retrieve a SharePoint list item by ID. Use when you need to fetch a specific item after knowing its ID.

**Input schema:**
```json
{
  "type": "object",
  "title": "GetListItemByIdRequest",
  "required": [
    "list_title",
    "item_id"
  ],
  "properties": {
    "expand": {
      "type": "string",
      "title": "Expand",
      "description": "OData $expand to expand related entities, e.g., 'Author,Editor'. Must be used together with select parameter that includes the expanded fields."
    },
    "select": {
      "type": "string",
      "title": "Select",
      "description": "OData $select to specify which fields to return, e.g., 'Title,Created'. Required when using expand parameter."
    },
    "item_id": {
      "type": "integer",
      "title": "Item Id",
      "minimum": 1,
      "examples": [
        1
      ],
      "description": "Numeric ID of the list item to retrieve."
    },
    "site_name": {
      "type": "string",
      "title": "Site Name",
      "description": "The subsite name to scope the request to (e.g., 'composio-test'). If omitted, the root site is used. When provided, the API base URL becomes https://{tenant}.sharepoint.com/sites/{site}."
    },
    "list_title": {
      "type": "string",
      "title": "List Title",
      "examples": [
        "My List"
      ],
      "description": "Display title of the target SharePoint list."
    }
  },
  "description": "Request model for retrieving a SharePoint list item by ID.",
  "additionalProperties": false
}
```

**Output schema:**
```json
{
  "type": "object",
  "$defs": {
    "GetListItemByIdResponse": {
      "type": "object",
      "title": "GetListItemByIdResponse",
      "properties": {
        "Id": {
          "type": "integer",
          "title": "Id",
          "description": "Item ID."
        },
        "GUID": {
          "type": "string",
          "title": "Guid",
          "description": "GUID of the list item."
        },
        "Title": {
          "type": "string",
          "title": "Title",
          "description": "Title of the list item."
        },
        "Created": {
          "type": "string",
          "title": "Created",
          "description": "Creation time of the item."
        },
        "AuthorId": {
          "type": "integer",
          "title": "Author Id",
          "description": "ID of the author user."
        },
        "EditorId": {
          "type": "integer",
          "title": "Editor Id",
          "description": "ID of the editor user."
        },
        "Modified": {
          "type": "string",
          "title": "Modified",
          "description": "Last modified time of the item."
        },
        "Attachments": {
          "type": "boolean",
          "title": "Attachments",
          "description": "Indicates if the item has attachments."
        },
        "ContentTypeId": {
          "type": "string",
          "title": "Content Type Id",
          "description": "Content type ID of the item."
        },
        "FileSystemObjectType": {
          "type": "integer",
          "title": "File System Object Type",
          "description": "Item type indicator (0 = list item, 1 = folder, 2 = file)."
        },
        "OData__UIVersionString": {
          "type": "string",
          "title": "O Data  Ui Version String",
          "description": "UI version string."
        }
      },
      "additionalProperties": true
    }
  },
  "title": "GetListItemByIdResponseWrapper",
  "required": [
    "data",
    "successful"
  ],
  "properties": {
    "data": {
      "type": "object",
      "title": "Data",
      "properties": {
        "Id": {
          "type": "integer",
          "title": "Id",
          "description": "Item ID."
        },
        "GUID": {
          "type": "string",
          "title": "Guid",
          "description": "GUID of the list item."
        },
        "Title": {
          "type": "string",
          "title": "Title",
          "description": "Title of the list item."
        },
        "Created": {
          "type": "string",
          "title": "Created",
          "description": "Creation time of the item."
        },
        "AuthorId": {
          "type": "integer",
          "title": "Author Id",
          "description": "ID of the author user."
        },
        "EditorId": {
          "type": "integer",
          "title": "Editor Id",
          "description": "ID of the editor user."
        },
        "Modified": {
          "type": "string",
          "title": "Modified",
          "description": "Last modified time of the item."
        },
        "Attachments": {
          "type": "boolean",
          "title": "Attachments",
          "description": "Indicates if the item has attachments."
        },
        "ContentTypeId": {
          "type": "string",
          "title": "Content Type Id",
          "description": "Content type ID of the item."
        },
        "FileSystemObjectType": {
          "type": "integer",
          "title": "File System Object Type",
          "description": "Item type indicator (0 = list item, 1 = folder, 2 = file)."
        },
        "OData__UIVersionString": {
          "type": "string",
          "title": "O Data  Ui Version String",
          "description": "UI version string."
        }
      },
      "additionalProperties": true,
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

## SHARE_POINT_GET_LIST_ITEMS
Tool to retrieve items from a SharePoint list. Use when you need to fetch list entries with optional OData parameters.

**Input schema:**
```json
{
  "type": "object",
  "title": "GetListItemsRequest",
  "required": [
    "list_title"
  ],
  "properties": {
    "top": {
      "type": "integer",
      "title": "Top",
      "minimum": 1,
      "examples": [
        10
      ],
      "description": "Maximum number of items to return."
    },
    "expand": {
      "type": "string",
      "title": "Expand",
      "examples": [
        "Author,Editor"
      ],
      "description": "Comma-separated list of navigation properties to expand for lookup fields."
    },
    "filter": {
      "type": "string",
      "title": "Filter",
      "examples": [
        "Title eq 'Test'"
      ],
      "description": "OData filter expression to limit results (e.g., Title eq 'Test')."
    },
    "select": {
      "type": "string",
      "title": "Select",
      "examples": [
        "Title,Id",
        "*",
        "FileLeafRef,Created,Modified"
      ],
      "description": "Comma-separated list of internal field names to return. Use '*' to retrieve all available fields, which is recommended when you don't know the exact field names. SharePoint uses internal field names, not display names - spaces are hex-encoded as '_x0020_' (e.g., 'File_x0020_Size' for 'File Size'). Common system fields: Id, Title, Created, Modified, AuthorId, EditorId, GUID, FileLeafRef (file name), FileDirRef (folder path), FileRef (server-relative URL). Field availability varies by list type: document libraries include file-specific fields like File_x0020_Size, while custom lists have their own schema. To discover available fields for a specific list, either: (1) use select='*' first to see all fields returned in items, or (2) use SHARE_POINT_GET_LIST_BY_TITLE with expand='Fields' to get field metadata including InternalName."
    },
    "orderby": {
      "type": "string",
      "title": "Orderby",
      "examples": [
        "Created desc"
      ],
      "description": "OData orderby expression to sort results (e.g., Created desc)."
    },
    "site_name": {
      "type": "string",
      "title": "Site Name",
      "examples": [
        "testcomposio",
        "marketing",
        "hr-portal"
      ],
      "description": "Optional SharePoint site name to scope the list retrieval. If provided, the list is fetched from /sites/{site}. If not provided, the list is fetched from the tenant root site. E.g., 'testcomposio' for a site at /sites/testcomposio."
    },
    "skiptoken": {
      "type": "string",
      "title": "Skiptoken",
      "examples": [
        "Paged=TRUE&p_ID=15"
      ],
      "description": "Token for paging through results."
    },
    "list_title": {
      "type": "string",
      "title": "List Title",
      "examples": [
        "Documents",
        "My List",
        "Tasks"
      ],
      "description": "Exact Title property value of the SharePoint list to query. The Title property value varies by site configuration and localization - for example, the default document library's Title may be 'Documents', 'Shared Documents', or a localized name. To find the exact Title property value, use SHARE_POINT_LIST_ALL_LISTS which returns all lists with their Title properties."
    }
  },
  "description": "Request parameters for retrieving items from a SharePoint list.",
  "additionalProperties": false
}
```

**Output schema:**
```json
{
  "type": "object",
  "$defs": {
    "DeferredProperty": {
      "type": "object",
      "title": "DeferredProperty",
      "required": [
        "__deferred"
      ],
      "properties": {
        "__deferred": {
          "type": "object",
          "title": "  Deferred",
          "description": "Deferred property with URI.",
          "additionalProperties": {
            "type": "string"
          }
        }
      },
      "description": "Represents a deferred navigation property."
    },
    "ListItemMetadata": {
      "type": "object",
      "title": "ListItemMetadata",
      "required": [
        "id",
        "uri",
        "etag",
        "type"
      ],
      "properties": {
        "id": {
          "type": "string",
          "title": "Id",
          "description": "Unique identifier for the list item resource."
        },
        "uri": {
          "type": "string",
          "title": "Uri",
          "description": "URI to access the list item."
        },
        "etag": {
          "type": "string",
          "title": "Etag",
          "description": "ETag value for versioning."
        },
        "type": {
          "type": "string",
          "title": "Type",
          "description": "Entity type name (e.g., 'SP.Data.TestListItem')."
        }
      },
      "description": "Metadata object for a SharePoint list item."
    },
    "SharePointListItem": {
      "type": "object",
      "title": "SharePointListItem",
      "required": [
        "__metadata"
      ],
      "properties": {
        "Id": {
          "type": "integer",
          "title": "Id",
          "description": "Unique integer ID of the list item. Returned by default or when selected."
        },
        "File": {
          "anyOf": [
            {
              "type": "object",
              "title": "DeferredProperty",
              "required": [
                "__deferred"
              ],
              "properties": {
                "__deferred": {
                  "type": "object",
                  "title": "  Deferred",
                  "description": "Deferred property with URI.",
                  "additionalProperties": {
                    "type": "string"
                  }
                }
              },
              "description": "Represents a deferred navigation property."
            },
            {
              "type": "object",
              "additionalProperties": true
            }
          ],
          "title": "File",
          "description": "Navigation property for file (if item is a file). Returns deferred reference by default, or full object when expanded."
        },
        "GUID": {
          "type": "string",
          "title": "Guid",
          "description": "GUID of the list item."
        },
        "Title": {
          "type": "string",
          "title": "Title",
          "description": "Title of the list item."
        },
        "Folder": {
          "anyOf": [
            {
              "type": "object",
              "title": "DeferredProperty",
              "required": [
                "__deferred"
              ],
              "properties": {
                "__deferred": {
                  "type": "object",
                  "title": "  Deferred",
                  "description": "Deferred property with URI.",
                  "additionalProperties": {
                    "type": "string"
                  }
                }
              },
              "description": "Represents a deferred navigation property."
            },
            {
              "type": "object",
              "additionalProperties": true
            }
          ],
          "title": "Folder",
          "description": "Navigation property for folder (if item is a folder). Returns deferred reference by default, or full object when expanded."
        },
        "Created": {
          "type": "string",
          "title": "Created",
          "description": "Creation timestamp (ISO 8601 format)."
        },
        "AuthorId": {
          "type": "integer",
          "title": "Author Id",
          "description": "ID of the item author."
        },
        "EditorId": {
          "type": "integer",
          "title": "Editor Id",
          "description": "ID of the last editor."
        },
        "Modified": {
          "type": "string",
          "title": "Modified",
          "description": "Last modified timestamp (ISO 8601 format)."
        },
        "ParentList": {
          "anyOf": [
            {
              "type": "object",
              "title": "DeferredProperty",
              "required": [
                "__deferred"
              ],
              "properties": {
                "__deferred": {
                  "type": "object",
                  "title": "  Deferred",
                  "description": "Deferred property with URI.",
                  "additionalProperties": {
                    "type": "string"
                  }
                }
              },
              "description": "Represents a deferred navigation property."
            },
            {
              "type": "object",
              "additionalProperties": true
            }
          ],
          "title": "Parent List",
          "description": "Navigation property for parent list. Returns deferred reference by default, or full object when expanded."
        },
        "__metadata": {
          "type": "object",
          "title": "  Metadata",
          "required": [
            "id",
            "uri",
            "etag",
            "type"
          ],
          "properties": {
            "id": {
              "type": "string",
              "title": "Id",
              "description": "Unique identifier for the list item resource."
            },
            "uri": {
              "type": "string",
              "title": "Uri",
              "description": "URI to access the list item."
            },
            "etag": {
              "type": "string",
              "title": "Etag",
              "description": "ETag value for versioning."
            },
            "type": {
              "type": "string",
              "title": "Type",
              "description": "Entity type name (e.g., 'SP.Data.TestListItem')."
            }
          },
          "description": "Metadata about the list item."
        },
        "Attachments": {
          "type": "boolean",
          "title": "Attachments",
          "description": "Whether the item has attachments."
        },
        "ContentType": {
          "anyOf": [
            {
              "type": "object",
              "title": "DeferredProperty",
              "required": [
                "__deferred"
              ],
              "properties": {
                "__deferred": {
                  "type": "object",
                  "title": "  Deferred",
                  "description": "Deferred property with URI.",
                  "additionalProperties": {
                    "type": "string"
                  }
                }
              },
              "description": "Represents a deferred navigation property."
            },
            {
              "type": "object",
              "additionalProperties": true
            }
          ],
          "title": "Content Type",
          "description": "Navigation property for content type. Returns deferred reference by default, or full object when expanded."
        },
        "ContentTypeId": {
          "type": "string",
          "title": "Content Type Id",
          "description": "Content type ID."
        },
        "AttachmentFiles": {
          "anyOf": [
            {
              "type": "object",
              "title": "DeferredProperty",
              "required": [
                "__deferred"
              ],
              "properties": {
                "__deferred": {
                  "type": "object",
                  "title": "  Deferred",
                  "description": "Deferred property with URI.",
                  "additionalProperties": {
                    "type": "string"
                  }
                }
              },
              "description": "Represents a deferred navigation property."
            },
            {
              "type": "object",
              "additionalProperties": true
            }
          ],
          "title": "Attachment Files",
          "description": "Navigation property for attachment files. Returns deferred reference by default, or full object when expanded."
        },
        "RoleAssignments": {
          "anyOf": [
            {
              "type": "object",
              "title": "DeferredProperty",
              "required": [
                "__deferred"
              ],
              "properties": {
                "__deferred": {
                  "type": "object",
                  "title": "  Deferred",
                  "description": "Deferred property with URI.",
                  "additionalProperties": {
                    "type": "string"
                  }
                }
              },
              "description": "Represents a deferred navigation property."
            },
            {
              "type": "object",
              "additionalProperties": true
            }
          ],
          "title": "Role Assignments",
          "description": "Navigation property for role assignments. Returns deferred reference by default, or full object when expanded."
        },
        "FieldValuesAsHtml": {
          "anyOf": [
            {
              "type": "object",
              "title": "DeferredProperty",
              "required": [
                "__deferred"
              ],
              "properties": {
                "__deferred": {
                  "type": "object",
                  "title": "  Deferred",
                  "description": "Deferred property with URI.",
                  "additionalProperties": {
                    "type": "string"
                  }
                }
              },
              "description": "Represents a deferred navigation property."
            },
            {
              "type": "object",
              "additionalProperties": true
            }
          ],
          "title": "Field Values As Html",
          "description": "Navigation property for field values as HTML. Returns deferred reference by default, or full object when expanded."
        },
        "FieldValuesAsText": {
          "anyOf": [
            {
              "type": "object",
              "title": "DeferredProperty",
              "required": [
                "__deferred"
              ],
              "properties": {
                "__deferred": {
                  "type": "object",
                  "title": "  Deferred",
                  "description": "Deferred property with URI.",
                  "additionalProperties": {
                    "type": "string"
                  }
                }
              },
              "description": "Represents a deferred navigation property."
            },
            {
              "type": "object",
              "additionalProperties": true
            }
          ],
          "title": "Field Values As Text",
          "description": "Navigation property for field values as text. Returns deferred reference by default, or full object when expanded."
        },
        "FieldValuesForEdit": {
          "anyOf": [
            {
              "type": "object",
              "title": "DeferredProperty",
              "required": [
                "__deferred"
              ],
              "properties": {
                "__deferred": {
                  "type": "object",
                  "title": "  Deferred",
                  "description": "Deferred property with URI.",
                  "additionalProperties": {
                    "type": "string"
                  }
                }
              },
              "description": "Represents a deferred navigation property."
            },
            {
              "type": "object",
              "additionalProperties": true
            }
          ],
          "title": "Field Values For Edit",
          "description": "Navigation property for field values for editing. Returns deferred reference by default, or full object when expanded."
        },
        "FileSystemObjectType": {
          "type": "integer",
          "title": "File System Object Type",
          "description": "Type of object: 0 for file, 1 for folder, 2 for web. Only returned when selected."
        },
        "OData__UIVersionString": {
          "type": "string",
          "title": "O Data  Ui Version String",
          "description": "UI version string."
        },
        "FirstUniqueAncestorSecurableObject": {
          "anyOf": [
            {
              "type": "object",
              "title": "DeferredProperty",
              "required": [
                "__deferred"
              ],
              "properties": {
                "__deferred": {
                  "type": "object",
                  "title": "  Deferred",
                  "description": "Deferred property with URI.",
                  "additionalProperties": {
                    "type": "string"
                  }
                }
              },
              "description": "Represents a deferred navigation property."
            },
            {
              "type": "object",
              "additionalProperties": true
            }
          ],
          "title": "First Unique Ancestor Securable Object",
          "description": "Navigation property for first unique ancestor securable object. Returns deferred reference by default, or full object when expanded."
        }
      },
      "description": "Represents a SharePoint list item with standard system fields.\n\nAdditional custom fields defined in the list schema will be present but are not\ntyped here as they vary by list configuration.",
      "additionalProperties": true
    },
    "GetListItemsResponse": {
      "type": "object",
      "title": "GetListItemsResponse",
      "required": [
        "items"
      ],
      "properties": {
        "items": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "SharePointListItem",
            "required": [
              "__metadata"
            ],
            "properties": {
              "Id": {
                "type": "integer",
                "title": "Id",
                "description": "Unique integer ID of the list item. Returned by default or when selected."
              },
              "File": {
                "anyOf": [
                  {
                    "type": "object",
                    "title": "DeferredProperty",
                    "required": [
                      "__deferred"
                    ],
                    "properties": {
                      "__deferred": {
                        "type": "object",
                        "title": "  Deferred",
                        "description": "Deferred property with URI.",
                        "additionalProperties": {
                          "type": "string"
                        }
                      }
                    },
                    "description": "Represents a deferred navigation property."
                  },
                  {
                    "type": "object",
                    "additionalProperties": true
                  }
                ],
                "title": "File",
                "description": "Navigation property for file (if item is a file). Returns deferred reference by default, or full object when expanded."
              },
              "GUID": {
                "type": "string",
                "title": "Guid",
                "description": "GUID of the list item."
              },
              "Title": {
                "type": "string",
                "title": "Title",
                "description": "Title of the list item."
              },
              "Folder": {
                "anyOf": [
                  {
                    "type": "object",
                    "title": "DeferredProperty",
                    "required": [
                      "__deferred"
                    ],
                    "properties": {
                      "__deferred": {
                        "type": "object",
                        "title": "  Deferred",
                        "description": "Deferred property with URI.",
                        "additionalProperties": {
                          "type": "string"
                        }
                      }
                    },
                    "description": "Represents a deferred navigation property."
                  },
                  {
                    "type": "object",
                    "additionalProperties": true
                  }
                ],
                "title": "Folder",
                "description": "Navigation property for folder (if item is a folder). Returns deferred reference by default, or full object when expanded."
              },
              "Created": {
                "type": "string",
                "title": "Created",
                "description": "Creation timestamp (ISO 8601 format)."
              },
              "AuthorId": {
                "type": "integer",
                "title": "Author Id",
                "description": "ID of the item author."
              },
              "EditorId": {
                "type": "integer",
                "title": "Editor Id",
                "description": "ID of the last editor."
              },
              "Modified": {
                "type": "string",
                "title": "Modified",
                "description": "Last modified timestamp (ISO 8601 format)."
              },
              "ParentList": {
                "anyOf": [
                  {
                    "type": "object",
                    "title": "DeferredProperty",
                    "required": [
                      "__deferred"
                    ],
                    "properties": {
                      "__deferred": {
                        "type": "object",
                        "title": "  Deferred",
                        "description": "Deferred property with URI.",
                        "additionalProperties": {
                          "type": "string"
                        }
                      }
                    },
                    "description": "Represents a deferred navigation property."
                  },
                  {
                    "type": "object",
                    "additionalProperties": true
                  }
                ],
                "title": "Parent List",
                "description": "Navigation property for parent list. Returns deferred reference by default, or full object when expanded."
              },
              "__metadata": {
                "type": "object",
                "title": "  Metadata",
                "required": [
                  "id",
                  "uri",
                  "etag",
                  "type"
                ],
                "properties": {
                  "id": {
                    "type": "string",
                    "title": "Id",
                    "description": "Unique identifier for the list item resource."
                  },
                  "uri": {
                    "type": "string",
                    "title": "Uri",
                    "description": "URI to access the list item."
                  },
                  "etag": {
                    "type": "string",
                    "title": "Etag",
                    "description": "ETag value for versioning."
                  },
                  "type": {
                    "type": "string",
                    "title": "Type",
                    "description": "Entity type name (e.g., 'SP.Data.TestListItem')."
                  }
                },
                "description": "Metadata about the list item."
              },
              "Attachments": {
                "type": "boolean",
                "title": "Attachments",
                "description": "Whether the item has attachments."
              },
              "ContentType": {
                "anyOf": [
                  {
                    "type": "object",
                    "title": "DeferredProperty",
                    "required": [
                      "__deferred"
                    ],
                    "properties": {
                      "__deferred": {
                        "type": "object",
                        "title": "  Deferred",
                        "description": "Deferred property with URI.",
                        "additionalProperties": {
                          "type": "string"
                        }
                      }
                    },
                    "description": "Represents a deferred navigation property."
                  },
                  {
                    "type": "object",
                    "additionalProperties": true
                  }
                ],
                "title": "Content Type",
                "description": "Navigation property for content type. Returns deferred reference by default, or full object when expanded."
              },
              "ContentTypeId": {
                "type": "string",
                "title": "Content Type Id",
                "description": "Content type ID."
              },
              "AttachmentFiles": {
                "anyOf": [
                  {
                    "type": "object",
                    "title": "DeferredProperty",
                    "required": [
                      "__deferred"
                    ],
                    "properties": {
                      "__deferred": {
                        "type": "object",
                        "title": "  Deferred",
                        "description": "Deferred property with URI.",
                        "additionalProperties": {
                          "type": "string"
                        }
                      }
                    },
                    "description": "Represents a deferred navigation property."
                  },
                  {
                    "type": "object",
                    "additionalProperties": true
                  }
                ],
                "title": "Attachment Files",
                "description": "Navigation property for attachment files. Returns deferred reference by default, or full object when expanded."
              },
              "RoleAssignments": {
                "anyOf": [
                  {
                    "type": "object",
                    "title": "DeferredProperty",
                    "required": [
                      "__deferred"
                    ],
                    "properties": {
                      "__deferred": {
                        "type": "object",
                        "title": "  Deferred",
                        "description": "Deferred property with URI.",
                        "additionalProperties": {
                          "type": "string"
                        }
                      }
                    },
                    "description": "Represents a deferred navigation property."
                  },
                  {
                    "type": "object",
                    "additionalProperties": true
                  }
                ],
                "title": "Role Assignments",
                "description": "Navigation property for role assignments. Returns deferred reference by default, or full object when expanded."
              },
              "FieldValuesAsHtml": {
                "anyOf": [
                  {
                    "type": "object",
                    "title": "DeferredProperty",
                    "required": [
                      "__deferred"
                    ],
                    "properties": {
                      "__deferred": {
                        "type": "object",
                        "title": "  Deferred",
                        "description": "Deferred property with URI.",
                        "additionalProperties": {
                          "type": "string"
                        }
                      }
                    },
                    "description": "Represents a deferred navigation property."
                  },
                  {
                    "type": "object",
                    "additionalProperties": true
                  }
                ],
                "title": "Field Values As Html",
                "description": "Navigation property for field values as HTML. Returns deferred reference by default, or full object when expanded."
              },
              "FieldValuesAsText": {
                "anyOf": [
                  {
                    "type": "object",
                    "title": "DeferredProperty",
                    "required": [
                      "__deferred"
                    ],
                    "properties": {
                      "__deferred": {
                        "type": "object",
                        "title": "  Deferred",
                        "description": "Deferred property with URI.",
                        "additionalProperties": {
                          "type": "string"
                        }
                      }
                    },
                    "description": "Represents a deferred navigation property."
                  },
                  {
                    "type": "object",
                    "additionalProperties": true
                  }
                ],
                "title": "Field Values As Text",
                "description": "Navigation property for field values as text. Returns deferred reference by default, or full object when expanded."
              },
              "FieldValuesForEdit": {
                "anyOf": [
                  {
                    "type": "object",
                    "title": "DeferredProperty",
                    "required": [
                      "__deferred"
                    ],
                    "properties": {
                      "__deferred": {
                        "type": "object",
                        "title": "  Deferred",
                        "description": "Deferred property with URI.",
                        "additionalProperties": {
                          "type": "string"
                        }
                      }
                    },
                    "description": "Represents a deferred navigation property."
                  },
                  {
                    "type": "object",
                    "additionalProperties": true
                  }
                ],
                "title": "Field Values For Edit",
                "description": "Navigation property for field values for editing. Returns deferred reference by default, or full object when expanded."
              },
              "FileSystemObjectType": {
                "type": "integer",
                "title": "File System Object Type",
                "description": "Type of object: 0 for file, 1 for folder, 2 for web. Only returned when selected."
              },
              "OData__UIVersionString": {
                "type": "string",
                "title": "O Data  Ui Version String",
                "description": "UI version string."
              },
              "FirstUniqueAncestorSecurableObject": {
                "anyOf": [
                  {
                    "type": "object",
                    "title": "DeferredProperty",
                    "required": [
                      "__deferred"
                    ],
                    "properties": {
                      "__deferred": {
                        "type": "object",
                        "title": "  Deferred",
                        "description": "Deferred property with URI.",
                        "additionalProperties": {
                          "type": "string"
                        }
                      }
                    },
                    "description": "Represents a deferred navigation property."
                  },
                  {
                    "type": "object",
                    "additionalProperties": true
                  }
                ],
                "title": "First Unique Ancestor Securable Object",
                "description": "Navigation property for first unique ancestor securable object. Returns deferred reference by default, or full object when expanded."
              }
            },
            "description": "Represents a SharePoint list item with standard system fields.\n\nAdditional custom fields defined in the list schema will be present but are not\ntyped here as they vary by list configuration.",
            "additionalProperties": true
          },
          "title": "Items",
          "description": "Array of list item objects returned from the SharePoint list."
        }
      },
      "description": "Response model for list items retrieved from a SharePoint list."
    }
  },
  "title": "GetListItemsResponseWrapper",
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
            "title": "SharePointListItem",
            "required": [
              "__metadata"
            ],
            "properties": {
              "Id": {
                "type": "integer",
                "title": "Id",
                "description": "Unique integer ID of the list item. Returned by default or when selected."
              },
              "File": {
                "anyOf": [
                  {
                    "type": "object",
                    "title": "DeferredProperty",
                    "required": [
                      "__deferred"
                    ],
                    "properties": {
                      "__deferred": {
                        "type": "object",
                        "title": "  Deferred",
                        "description": "Deferred property with URI.",
                        "additionalProperties": {
                          "type": "string"
                        }
                      }
                    },
                    "description": "Represents a deferred navigation property."
                  },
                  {
                    "type": "object",
                    "additionalProperties": true
                  }
                ],
                "title": "File",
                "description": "Navigation property for file (if item is a file). Returns deferred reference by default, or full object when expanded."
              },
              "GUID": {
                "type": "string",
                "title": "Guid",
                "description": "GUID of the list item."
              },
              "Title": {
                "type": "string",
                "title": "Title",
                "description": "Title of the list item."
              },
              "Folder": {
                "anyOf": [
                  {
                    "type": "object",
                    "title": "DeferredProperty",
                    "required": [
                      "__deferred"
                    ],
                    "properties": {
                      "__deferred": {
                        "type": "object",
                        "title": "  Deferred",
                        "description": "Deferred property with URI.",
                        "additionalProperties": {
                          "type": "string"
                        }
                      }
                    },
                    "description": "Represents a deferred navigation property."
                  },
                  {
                    "type": "object",
                    "additionalProperties": true
                  }
                ],
                "title": "Folder",
                "description": "Navigation property for folder (if item is a folder). Returns deferred reference by default, or full object when expanded."
              },
              "Created": {
                "type": "string",
                "title": "Created",
                "description": "Creation timestamp (ISO 8601 format)."
              },
              "AuthorId": {
                "type": "integer",
                "title": "Author Id",
                "description": "ID of the item author."
              },
              "EditorId": {
                "type": "integer",
                "title": "Editor Id",
                "description": "ID of the last editor."
              },
              "Modified": {
                "type": "string",
                "title": "Modified",
                "description": "Last modified timestamp (ISO 8601 format)."
              },
              "ParentList": {
                "anyOf": [
                  {
                    "type": "object",
                    "title": "DeferredProperty",
                    "required": [
                      "__deferred"
                    ],
                    "properties": {
                      "__deferred": {
                        "type": "object",
                        "title": "  Deferred",
                        "description": "Deferred property with URI.",
                        "additionalProperties": {
                          "type": "string"
                        }
                      }
                    },
                    "description": "Represents a deferred navigation property."
                  },
                  {
                    "type": "object",
                    "additionalProperties": true
                  }
                ],
                "title": "Parent List",
                "description": "Navigation property for parent list. Returns deferred reference by default, or full object when expanded."
              },
              "__metadata": {
                "type": "object",
                "title": "  Metadata",
                "required": [
                  "id",
                  "uri",
                  "etag",
                  "type"
                ],
                "properties": {
                  "id": {
                    "type": "string",
                    "title": "Id",
                    "description": "Unique identifier for the list item resource."
                  },
                  "uri": {
                    "type": "string",
                    "title": "Uri",
                    "description": "URI to access the list item."
                  },
                  "etag": {
                    "type": "string",
                    "title": "Etag",
                    "description": "ETag value for versioning."
                  },
                  "type": {
                    "type": "string",
                    "title": "Type",
                    "description": "Entity type name (e.g., 'SP.Data.TestListItem')."
                  }
                },
                "description": "Metadata about the list item."
              },
              "Attachments": {
                "type": "boolean",
                "title": "Attachments",
                "description": "Whether the item has attachments."
              },
              "ContentType": {
                "anyOf": [
                  {
                    "type": "object",
                    "title": "DeferredProperty",
                    "required": [
                      "__deferred"
                    ],
                    "properties": {
                      "__deferred": {
                        "type": "object",
                        "title": "  Deferred",
                        "description": "Deferred property with URI.",
                        "additionalProperties": {
                          "type": "string"
                        }
                      }
                    },
                    "description": "Represents a deferred navigation property."
                  },
                  {
                    "type": "object",
                    "additionalProperties": true
                  }
                ],
                "title": "Content Type",
                "description": "Navigation property for content type. Returns deferred reference by default, or full object when expanded."
              },
              "ContentTypeId": {
                "type": "string",
                "title": "Content Type Id",
                "description": "Content type ID."
              },
              "AttachmentFiles": {
                "anyOf": [
                  {
                    "type": "object",
                    "title": "DeferredProperty",
                    "required": [
                      "__deferred"
                    ],
                    "properties": {
                      "__deferred": {
                        "type": "object",
                        "title": "  Deferred",
                        "description": "Deferred property with URI.",
                        "additionalProperties": {
                          "type": "string"
                        }
                      }
                    },
                    "description": "Represents a deferred navigation property."
                  },
                  {
                    "type": "object",
                    "additionalProperties": true
                  }
                ],
                "title": "Attachment Files",
                "description": "Navigation property for attachment files. Returns deferred reference by default, or full object when expanded."
              },
              "RoleAssignments": {
                "anyOf": [
                  {
                    "type": "object",
                    "title": "DeferredProperty",
                    "required": [
                      "__deferred"
                    ],
                    "properties": {
                      "__deferred": {
                        "type": "object",
                        "title": "  Deferred",
                        "description": "Deferred property with URI.",
                        "additionalProperties": {
                          "type": "string"
                        }
                      }
                    },
                    "description": "Represents a deferred navigation property."
                  },
                  {
                    "type": "object",
                    "additionalProperties": true
                  }
                ],
                "title": "Role Assignments",
                "description": "Navigation property for role assignments. Returns deferred reference by default, or full object when expanded."
              },
              "FieldValuesAsHtml": {
                "anyOf": [
                  {
                    "type": "object",
                    "title": "DeferredProperty",
                    "required": [
                      "__deferred"
                    ],
                    "properties": {
                      "__deferred": {
                        "type": "object",
                        "title": "  Deferred",
                        "description": "Deferred property with URI.",
                        "additionalProperties": {
                          "type": "string"
                        }
                      }
                    },
                    "description": "Represents a deferred navigation property."
                  },
                  {
                    "type": "object",
                    "additionalProperties": true
                  }
                ],
                "title": "Field Values As Html",
                "description": "Navigation property for field values as HTML. Returns deferred reference by default, or full object when expanded."
              },
              "FieldValuesAsText": {
                "anyOf": [
                  {
                    "type": "object",
                    "title": "DeferredProperty",
                    "required": [
                      "__deferred"
                    ],
                    "properties": {
                      "__deferred": {
                        "type": "object",
                        "title": "  Deferred",
                        "description": "Deferred property with URI.",
                        "additionalProperties": {
                          "type": "string"
                        }
                      }
                    },
                    "description": "Represents a deferred navigation property."
                  },
                  {
                    "type": "object",
                    "additionalProperties": true
                  }
                ],
                "title": "Field Values As Text",
                "description": "Navigation property for field values as text. Returns deferred reference by default, or full object when expanded."
              },
              "FieldValuesForEdit": {
                "anyOf": [
                  {
                    "type": "object",
                    "title": "DeferredProperty",
                    "required": [
                      "__deferred"
                    ],
                    "properties": {
                      "__deferred": {
                        "type": "object",
                        "title": "  Deferred",
                        "description": "Deferred property with URI.",
                        "additionalProperties": {
                          "type": "string"
                        }
                      }
                    },
                    "description": "Represents a deferred navigation property."
                  },
                  {
                    "type": "object",
                    "additionalProperties": true
                  }
                ],
                "title": "Field Values For Edit",
                "description": "Navigation property for field values for editing. Returns deferred reference by default, or full object when expanded."
              },
              "FileSystemObjectType": {
                "type": "integer",
                "title": "File System Object Type",
                "description": "Type of object: 0 for file, 1 for folder, 2 for web. Only returned when selected."
              },
              "OData__UIVersionString": {
                "type": "string",
                "title": "O Data  Ui Version String",
                "description": "UI version string."
              },
              "FirstUniqueAncestorSecurableObject": {
                "anyOf": [
                  {
                    "type": "object",
                    "title": "DeferredProperty",
                    "required": [
                      "__deferred"
                    ],
                    "properties": {
                      "__deferred": {
                        "type": "object",
                        "title": "  Deferred",
                        "description": "Deferred property with URI.",
                        "additionalProperties": {
                          "type": "string"
                        }
                      }
                    },
                    "description": "Represents a deferred navigation property."
                  },
                  {
                    "type": "object",
                    "additionalProperties": true
                  }
                ],
                "title": "First Unique Ancestor Securable Object",
                "description": "Navigation property for first unique ancestor securable object. Returns deferred reference by default, or full object when expanded."
              }
            },
            "description": "Represents a SharePoint list item with standard system fields.\n\nAdditional custom fields defined in the list schema will be present but are not\ntyped here as they vary by list configuration.",
            "additionalProperties": true
          },
          "title": "Items",
          "description": "Array of list item objects returned from the SharePoint list."
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

## SHARE_POINT_GET_LIST_ITEMS_BY_GUID
Tool to retrieve items from a SharePoint list using its GUID. Use when you have the list's unique identifier and need to fetch list entries with optional OData parameters.

**Input schema:**
```json
{
  "type": "object",
  "title": "GetListItemsByGuidRequest",
  "required": [
    "list_guid"
  ],
  "properties": {
    "top": {
      "type": "integer",
      "title": "Top",
      "minimum": 1,
      "examples": [
        10
      ],
      "description": "Maximum number of items to return."
    },
    "expand": {
      "type": "string",
      "title": "Expand",
      "examples": [
        "Author,Editor"
      ],
      "description": "Comma-separated list of navigation properties to expand for lookup fields."
    },
    "filter": {
      "type": "string",
      "title": "Filter",
      "examples": [
        "Title eq 'Test'"
      ],
      "description": "OData filter expression to limit results (e.g., Title eq 'Test')."
    },
    "select": {
      "type": "string",
      "title": "Select",
      "examples": [
        "Title,Id",
        "*",
        "FileLeafRef,Created,Modified"
      ],
      "description": "Comma-separated list of internal field names to return. Use '*' to retrieve all available fields, which is recommended when you don't know the exact field names. SharePoint uses internal field names, not display names - spaces are hex-encoded as '_x0020_' (e.g., 'File_x0020_Size' for 'File Size'). Common system fields: Id, Title, Created, Modified, AuthorId, EditorId, GUID, FileLeafRef (file name), FileDirRef (folder path), FileRef (server-relative URL). Field availability varies by list type: document libraries include file-specific fields like File_x0020_Size, while custom lists have their own schema. To discover available fields for a specific list, either: (1) use select='*' first to see all fields returned in items, or (2) use SHARE_POINT_GET_LIST_BY_GUID with expand='Fields' to get field metadata including InternalName."
    },
    "orderby": {
      "type": "string",
      "title": "Orderby",
      "examples": [
        "Created desc"
      ],
      "description": "OData orderby expression to sort results (e.g., Created desc)."
    },
    "list_guid": {
      "type": "string",
      "title": "List Guid",
      "examples": [
        "a12e3d6e-9414-462d-bd53-cf06f3982ad3"
      ],
      "description": "GUID of the SharePoint list to retrieve items from, in canonical format. The GUID uniquely identifies a list across the SharePoint site. To find list GUIDs, use SHARE_POINT_LIST_ALL_LISTS which returns all lists with their Id (GUID) properties."
    },
    "site_name": {
      "type": "string",
      "title": "Site Name",
      "examples": [
        "composio-test"
      ],
      "description": "The subsite name to scope the request to (e.g., 'composio-test'). If omitted, the root site is used. When provided, the API base URL becomes https://{tenant}.sharepoint.com/sites/{site}."
    },
    "skiptoken": {
      "type": "string",
      "title": "Skiptoken",
      "examples": [
        "Paged=TRUE&p_ID=15"
      ],
      "description": "Token for paging through results."
    }
  },
  "description": "Request parameters for retrieving items from a SharePoint list by GUID.",
  "additionalProperties": false
}
```

**Output schema:**
```json
{
  "type": "object",
  "$defs": {
    "GetListItemsByGuidResponse": {
      "type": "object",
      "title": "GetListItemsByGuidResponse",
      "required": [
        "items"
      ],
      "properties": {
        "items": {
          "type": "array",
          "items": {
            "type": "object",
            "additionalProperties": true
          },
          "title": "Items",
          "description": "Array of list item objects returned from the SharePoint list."
        }
      },
      "description": "Response model for list items retrieved from a SharePoint list by GUID."
    }
  },
  "title": "GetListItemsByGuidResponseWrapper",
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
            "additionalProperties": true
          },
          "title": "Items",
          "description": "Array of list item objects returned from the SharePoint list."
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

## SHARE_POINT_GET_LIST_ITEM_VERSION
Tool to retrieve a specific version of a SharePoint list item. Use when you need to access historical versions of list items.

**Input schema:**
```json
{
  "type": "object",
  "title": "GetListItemVersionRequest",
  "required": [
    "list_guid",
    "item_id",
    "version_id"
  ],
  "properties": {
    "item_id": {
      "type": "integer",
      "title": "Item Id",
      "minimum": 1,
      "examples": [
        1
      ],
      "description": "Numeric ID of the list item whose version to retrieve."
    },
    "list_guid": {
      "type": "string",
      "title": "List Guid",
      "examples": [
        "a12e3d6e-9414-462d-bd53-cf06f3982ad3"
      ],
      "description": "GUID of the SharePoint list in canonical format, e.g., '01234567-89ab-cdef-0123-456789abcdef'."
    },
    "site_name": {
      "type": "string",
      "title": "Site Name",
      "examples": [
        "composio-test",
        "marketing",
        "hr-portal"
      ],
      "description": "The subsite name to scope the request to (e.g., 'composio-test'). If omitted, the root site is used. When provided, the API base URL becomes https://{tenant}.sharepoint.com/sites/{site}."
    },
    "version_id": {
      "type": "integer",
      "title": "Version Id",
      "minimum": 1,
      "examples": [
        512
      ],
      "description": "Version ID of the specific list item version to retrieve."
    }
  },
  "description": "Request model for retrieving a specific version of a SharePoint list item.",
  "additionalProperties": false
}
```

**Output schema:**
```json
{
  "type": "object",
  "$defs": {
    "GetListItemVersionResponse": {
      "type": "object",
      "title": "GetListItemVersionResponse",
      "properties": {
        "Fields": {
          "type": "object",
          "title": "Fields",
          "description": "Field values for this version of the list item.",
          "additionalProperties": true
        },
        "Created": {
          "type": "string",
          "title": "Created",
          "description": "Timestamp when this version was created."
        },
        "CreatedBy": {
          "type": "object",
          "title": "Created By",
          "description": "User information who created this version.",
          "additionalProperties": true
        },
        "VersionId": {
          "type": "integer",
          "title": "Version Id",
          "description": "Version ID of this version."
        },
        "VersionLabel": {
          "type": "string",
          "title": "Version Label",
          "description": "Version label (e.g., '1.0', '2.0')."
        },
        "IsCurrentVersion": {
          "type": "boolean",
          "title": "Is Current Version",
          "description": "Whether this is the current version."
        }
      },
      "description": "Response model for a SharePoint list item version.",
      "additionalProperties": true
    }
  },
  "title": "GetListItemVersionResponseWrapper",
  "required": [
    "data",
    "successful"
  ],
  "properties": {
    "data": {
      "type": "object",
      "title": "Data",
      "properties": {
        "Fields": {
          "type": "object",
          "title": "Fields",
          "description": "Field values for this version of the list item.",
          "additionalProperties": true
        },
        "Created": {
          "type": "string",
          "title": "Created",
          "description": "Timestamp when this version was created."
        },
        "CreatedBy": {
          "type": "object",
          "title": "Created By",
          "description": "User information who created this version.",
          "additionalProperties": true
        },
        "VersionId": {
          "type": "integer",
          "title": "Version Id",
          "description": "Version ID of this version."
        },
        "VersionLabel": {
          "type": "string",
          "title": "Version Label",
          "description": "Version label (e.g., '1.0', '2.0')."
        },
        "IsCurrentVersion": {
          "type": "boolean",
          "title": "Is Current Version",
          "description": "Whether this is the current version."
        }
      },
      "description": "Data from the action execution",
      "additionalProperties": true
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

## SHARE_POINT_GET_MY_FOLLOWED
Tool to get entities the current user is following. Use when you need to retrieve followed users, documents, sites, or tags after authentication.

**Input schema:**
```json
{
  "type": "object",
  "title": "GetMyFollowedRequest",
  "required": [
    "types"
  ],
  "properties": {
    "types": {
      "type": "integer",
      "title": "Types",
      "maximum": 15,
      "minimum": 1,
      "examples": [
        1,
        2,
        4,
        8,
        15
      ],
      "description": "Bitmask of actor types to include. Users=1, Documents=2, Sites=4, Tags=8. Combine values with bitwise OR (e.g., 15 for all)."
    },
    "site_name": {
      "type": "string",
      "title": "Site Name",
      "description": "The subsite name to scope the request to (e.g., 'composio-test'). If omitted, the root site is used. When provided, the API base URL becomes https://{tenant}.sharepoint.com/sites/{site}."
    }
  },
  "description": "Request parameters for retrieving the entities the current user is following.",
  "additionalProperties": false
}
```

**Output schema:**
```json
{
  "type": "object",
  "$defs": {
    "SocialActor": {
      "type": "object",
      "title": "SocialActor",
      "required": [
        "ActorType",
        "CanFollow",
        "Id",
        "IsFollowed"
      ],
      "properties": {
        "Id": {
          "type": "string",
          "title": "Id",
          "description": "Actor's unique identifier."
        },
        "Uri": {
          "type": "string",
          "title": "Uri",
          "description": "Canonical URI for the actor."
        },
        "Name": {
          "type": "string",
          "title": "Name",
          "description": "Display name of the actor."
        },
        "Title": {
          "type": "string",
          "title": "Title",
          "description": "Title of the actor (users)."
        },
        "Status": {
          "type": "integer",
          "title": "Status",
          "description": "Status code if retrieval error occurred."
        },
        "TagGuid": {
          "type": "string",
          "title": "Tag Guid",
          "description": "Tag GUID (tags)."
        },
        "ImageUri": {
          "type": "string",
          "title": "Image Uri",
          "description": "Image URI (users, documents, sites)."
        },
        "ActorType": {
          "type": "integer",
          "title": "Actor Type",
          "description": "Type of actor: 0=User, 1=Document, 2=Site, 3=Tag."
        },
        "CanFollow": {
          "type": "boolean",
          "title": "Can Follow",
          "description": "Whether the actor can be followed."
        },
        "ContentUri": {
          "type": "string",
          "title": "Content Uri",
          "description": "Content URI (documents, sites)."
        },
        "IsFollowed": {
          "type": "boolean",
          "title": "Is Followed",
          "description": "Whether the current user is following this actor."
        },
        "LibraryUri": {
          "type": "string",
          "title": "Library Uri",
          "description": "Library URI (documents)."
        },
        "StatusText": {
          "type": "string",
          "title": "Status Text",
          "description": "Most recent post text (users)."
        },
        "AccountName": {
          "type": "string",
          "title": "Account Name",
          "description": "Actor's account name (users)."
        },
        "EmailAddress": {
          "type": "string",
          "title": "Email Address",
          "description": "Email address (users)."
        },
        "PersonalSiteUri": {
          "type": "string",
          "title": "Personal Site Uri",
          "description": "Personal site URI (users)."
        },
        "FollowedContentUri": {
          "type": "string",
          "title": "Followed Content Uri",
          "description": "URI of followed content (users)."
        }
      }
    },
    "GetMyFollowedResponse": {
      "type": "object",
      "title": "GetMyFollowedResponse",
      "required": [
        "results"
      ],
      "properties": {
        "results": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "SocialActor",
            "required": [
              "ActorType",
              "CanFollow",
              "Id",
              "IsFollowed"
            ],
            "properties": {
              "Id": {
                "type": "string",
                "title": "Id",
                "description": "Actor's unique identifier."
              },
              "Uri": {
                "type": "string",
                "title": "Uri",
                "description": "Canonical URI for the actor."
              },
              "Name": {
                "type": "string",
                "title": "Name",
                "description": "Display name of the actor."
              },
              "Title": {
                "type": "string",
                "title": "Title",
                "description": "Title of the actor (users)."
              },
              "Status": {
                "type": "integer",
                "title": "Status",
                "description": "Status code if retrieval error occurred."
              },
              "TagGuid": {
                "type": "string",
                "title": "Tag Guid",
                "description": "Tag GUID (tags)."
              },
              "ImageUri": {
                "type": "string",
                "title": "Image Uri",
                "description": "Image URI (users, documents, sites)."
              },
              "ActorType": {
                "type": "integer",
                "title": "Actor Type",
                "description": "Type of actor: 0=User, 1=Document, 2=Site, 3=Tag."
              },
              "CanFollow": {
                "type": "boolean",
                "title": "Can Follow",
                "description": "Whether the actor can be followed."
              },
              "ContentUri": {
                "type": "string",
                "title": "Content Uri",
                "description": "Content URI (documents, sites)."
              },
              "IsFollowed": {
                "type": "boolean",
                "title": "Is Followed",
                "description": "Whether the current user is following this actor."
              },
              "LibraryUri": {
                "type": "string",
                "title": "Library Uri",
                "description": "Library URI (documents)."
              },
              "StatusText": {
                "type": "string",
                "title": "Status Text",
                "description": "Most recent post text (users)."
              },
              "AccountName": {
                "type": "string",
                "title": "Account Name",
                "description": "Actor's account name (users)."
              },
              "EmailAddress": {
                "type": "string",
                "title": "Email Address",
                "description": "Email address (users)."
              },
              "PersonalSiteUri": {
                "type": "string",
                "title": "Personal Site Uri",
                "description": "Personal site URI (users)."
              },
              "FollowedContentUri": {
                "type": "string",
                "title": "Followed Content Uri",
                "description": "URI of followed content (users)."
              }
            }
          },
          "title": "Results",
          "description": "List of social actors the current user is following."
        }
      },
      "description": "Response model containing the list of followed actors for the current user."
    }
  },
  "title": "GetMyFollowedResponseWrapper",
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
            "title": "SocialActor",
            "required": [
              "ActorType",
              "CanFollow",
              "Id",
              "IsFollowed"
            ],
            "properties": {
              "Id": {
                "type": "string",
                "title": "Id",
                "description": "Actor's unique identifier."
              },
              "Uri": {
                "type": "string",
                "title": "Uri",
                "description": "Canonical URI for the actor."
              },
              "Name": {
                "type": "string",
                "title": "Name",
                "description": "Display name of the actor."
              },
              "Title": {
                "type": "string",
                "title": "Title",
                "description": "Title of the actor (users)."
              },
              "Status": {
                "type": "integer",
                "title": "Status",
                "description": "Status code if retrieval error occurred."
              },
              "TagGuid": {
                "type": "string",
                "title": "Tag Guid",
                "description": "Tag GUID (tags)."
              },
              "ImageUri": {
                "type": "string",
                "title": "Image Uri",
                "description": "Image URI (users, documents, sites)."
              },
              "ActorType": {
                "type": "integer",
                "title": "Actor Type",
                "description": "Type of actor: 0=User, 1=Document, 2=Site, 3=Tag."
              },
              "CanFollow": {
                "type": "boolean",
                "title": "Can Follow",
                "description": "Whether the actor can be followed."
              },
              "ContentUri": {
                "type": "string",
                "title": "Content Uri",
                "description": "Content URI (documents, sites)."
              },
              "IsFollowed": {
                "type": "boolean",
                "title": "Is Followed",
                "description": "Whether the current user is following this actor."
              },
              "LibraryUri": {
                "type": "string",
                "title": "Library Uri",
                "description": "Library URI (documents)."
              },
              "StatusText": {
                "type": "string",
                "title": "Status Text",
                "description": "Most recent post text (users)."
              },
              "AccountName": {
                "type": "string",
                "title": "Account Name",
                "description": "Actor's account name (users)."
              },
              "EmailAddress": {
                "type": "string",
                "title": "Email Address",
                "description": "Email address (users)."
              },
              "PersonalSiteUri": {
                "type": "string",
                "title": "Personal Site Uri",
                "description": "Personal site URI (users)."
              },
              "FollowedContentUri": {
                "type": "string",
                "title": "Followed Content Uri",
                "description": "URI of followed content (users)."
              }
            }
          },
          "title": "Results",
          "description": "List of social actors the current user is following."
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

## SHARE_POINT_GET_MY_FOLLOWERS
Retrieves the list of users who are following the authenticated user in SharePoint. Returns an array of SocialActor objects containing follower details like name, email, account name, and personal site URI. No parameters required - automatically retrieves followers for the current authenticated user.

**Input schema:**
```json
{
  "type": "object",
  "title": "GetMyFollowersRequest",
  "properties": {
    "site_name": {
      "type": "string",
      "title": "Site Name",
      "description": "The subsite name to scope the request to (e.g., `composio-test`). If omitted, the root site is used. When provided, the API base URL becomes `https://{tenant}.sharepoint.com/sites/{site}`."
    }
  },
  "description": "Request model for retrieving current user's followers.",
  "additionalProperties": false
}
```

**Output schema:**
```json
{
  "type": "object",
  "$defs": {
    "SocialActor": {
      "type": "object",
      "title": "SocialActor",
      "properties": {
        "Id": {
          "type": "string",
          "title": "Id",
          "description": "Unique identifier for the actor."
        },
        "Uri": {
          "type": "string",
          "title": "Uri",
          "format": "uri",
          "maxLength": 2083,
          "minLength": 1,
          "description": "Canonical URI for the actor's profile."
        },
        "Name": {
          "type": "string",
          "title": "Name",
          "description": "Display name of the actor."
        },
        "Title": {
          "type": "string",
          "title": "Title",
          "description": "Job title or role (for user actors)."
        },
        "Status": {
          "type": "integer",
          "title": "Status",
          "description": "Status code indicating retrieval state (0=OK, 9=PartialData)."
        },
        "GroupId": {
          "type": "string",
          "title": "Group Id",
          "description": "SharePoint group identifier."
        },
        "TagGuid": {
          "type": "string",
          "title": "Tag Guid",
          "description": "GUID identifier (for tag actors)."
        },
        "ImageUri": {
          "type": "string",
          "title": "Image Uri",
          "format": "uri",
          "maxLength": 2083,
          "minLength": 1,
          "description": "URI to profile image (for users, documents, and sites)."
        },
        "ActorType": {
          "type": "integer",
          "title": "Actor Type",
          "description": "Type of actor: 0=User, 1=Document, 2=Site, 3=Tag."
        },
        "CanFollow": {
          "type": "boolean",
          "title": "Can Follow",
          "description": "Whether the current user can follow this actor."
        },
        "ContentUri": {
          "type": "string",
          "title": "Content Uri",
          "format": "uri",
          "maxLength": 2083,
          "minLength": 1,
          "description": "URI to the content (for documents and sites)."
        },
        "IsFollowed": {
          "type": "boolean",
          "title": "Is Followed",
          "description": "Whether the current user is following this actor back."
        },
        "LibraryUri": {
          "type": "string",
          "title": "Library Uri",
          "format": "uri",
          "maxLength": 2083,
          "minLength": 1,
          "description": "URI to the document library (for documents)."
        },
        "StatusText": {
          "type": "string",
          "title": "Status Text",
          "description": "Text of the most recent post (for user actors)."
        },
        "AccountName": {
          "type": "string",
          "title": "Account Name",
          "description": "Account name in claims format (e.g., 'i:0#.f|membership|user@domain.com')."
        },
        "EmailAddress": {
          "type": "string",
          "title": "Email Address",
          "format": "email",
          "description": "Email address (for user actors)."
        },
        "PersonalSiteUri": {
          "type": "string",
          "title": "Personal Site Uri",
          "format": "uri",
          "maxLength": 2083,
          "minLength": 1,
          "description": "URI to the personal site (for user actors)."
        },
        "FollowedContentUri": {
          "type": "string",
          "title": "Followed Content Uri",
          "format": "uri",
          "maxLength": 2083,
          "minLength": 1,
          "description": "URI of the actor's list of followed content (for users)."
        }
      },
      "description": "Representation of a SharePoint SocialActor (user/document/site/tag)."
    },
    "GetMyFollowersResponse": {
      "type": "object",
      "title": "GetMyFollowersResponse",
      "required": [
        "followers"
      ],
      "properties": {
        "followers": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "SocialActor",
            "properties": {
              "Id": {
                "type": "string",
                "title": "Id",
                "description": "Unique identifier for the actor."
              },
              "Uri": {
                "type": "string",
                "title": "Uri",
                "format": "uri",
                "maxLength": 2083,
                "minLength": 1,
                "description": "Canonical URI for the actor's profile."
              },
              "Name": {
                "type": "string",
                "title": "Name",
                "description": "Display name of the actor."
              },
              "Title": {
                "type": "string",
                "title": "Title",
                "description": "Job title or role (for user actors)."
              },
              "Status": {
                "type": "integer",
                "title": "Status",
                "description": "Status code indicating retrieval state (0=OK, 9=PartialData)."
              },
              "GroupId": {
                "type": "string",
                "title": "Group Id",
                "description": "SharePoint group identifier."
              },
              "TagGuid": {
                "type": "string",
                "title": "Tag Guid",
                "description": "GUID identifier (for tag actors)."
              },
              "ImageUri": {
                "type": "string",
                "title": "Image Uri",
                "format": "uri",
                "maxLength": 2083,
                "minLength": 1,
                "description": "URI to profile image (for users, documents, and sites)."
              },
              "ActorType": {
                "type": "integer",
                "title": "Actor Type",
                "description": "Type of actor: 0=User, 1=Document, 2=Site, 3=Tag."
              },
              "CanFollow": {
                "type": "boolean",
                "title": "Can Follow",
                "description": "Whether the current user can follow this actor."
              },
              "ContentUri": {
                "type": "string",
                "title": "Content Uri",
                "format": "uri",
                "maxLength": 2083,
                "minLength": 1,
                "description": "URI to the content (for documents and sites)."
              },
              "IsFollowed": {
                "type": "boolean",
                "title": "Is Followed",
                "description": "Whether the current user is following this actor back."
              },
              "LibraryUri": {
                "type": "string",
                "title": "Library Uri",
                "format": "uri",
                "maxLength": 2083,
                "minLength": 1,
                "description": "URI to the document library (for documents)."
              },
              "StatusText": {
                "type": "string",
                "title": "Status Text",
                "description": "Text of the most recent post (for user actors)."
              },
              "AccountName": {
                "type": "string",
                "title": "Account Name",
                "description": "Account name in claims format (e.g., 'i:0#.f|membership|user@domain.com')."
              },
              "EmailAddress": {
                "type": "string",
                "title": "Email Address",
                "format": "email",
                "description": "Email address (for user actors)."
              },
              "PersonalSiteUri": {
                "type": "string",
                "title": "Personal Site Uri",
                "format": "uri",
                "maxLength": 2083,
                "minLength": 1,
                "description": "URI to the personal site (for user actors)."
              },
              "FollowedContentUri": {
                "type": "string",
                "title": "Followed Content Uri",
                "format": "uri",
                "maxLength": 2083,
                "minLength": 1,
                "description": "URI of the actor's list of followed content (for users)."
              }
            },
            "description": "Representation of a SharePoint SocialActor (user/document/site/tag)."
          },
          "title": "Followers",
          "description": "Array of SocialActor objects representing users who follow the current user."
        }
      },
      "description": "Response containing the list of users following the authenticated user."
    }
  },
  "title": "GetMyFollowersResponseWrapper",
  "required": [
    "data",
    "successful"
  ],
  "properties": {
    "data": {
      "type": "object",
      "title": "Data",
      "required": [
        "followers"
      ],
      "properties": {
        "followers": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "SocialActor",
            "properties": {
              "Id": {
                "type": "string",
                "title": "Id",
                "description": "Unique identifier for the actor."
              },
              "Uri": {
                "type": "string",
                "title": "Uri",
                "format": "uri",
                "maxLength": 2083,
                "minLength": 1,
                "description": "Canonical URI for the actor's profile."
              },
              "Name": {
                "type": "string",
                "title": "Name",
                "description": "Display name of the actor."
              },
              "Title": {
                "type": "string",
                "title": "Title",
                "description": "Job title or role (for user actors)."
              },
              "Status": {
                "type": "integer",
                "title": "Status",
                "description": "Status code indicating retrieval state (0=OK, 9=PartialData)."
              },
              "GroupId": {
                "type": "string",
                "title": "Group Id",
                "description": "SharePoint group identifier."
              },
              "TagGuid": {
                "type": "string",
                "title": "Tag Guid",
                "description": "GUID identifier (for tag actors)."
              },
              "ImageUri": {
                "type": "string",
                "title": "Image Uri",
                "format": "uri",
                "maxLength": 2083,
                "minLength": 1,
                "description": "URI to profile image (for users, documents, and sites)."
              },
              "ActorType": {
                "type": "integer",
                "title": "Actor Type",
                "description": "Type of actor: 0=User, 1=Document, 2=Site, 3=Tag."
              },
              "CanFollow": {
                "type": "boolean",
                "title": "Can Follow",
                "description": "Whether the current user can follow this actor."
              },
              "ContentUri": {
                "type": "string",
                "title": "Content Uri",
                "format": "uri",
                "maxLength": 2083,
                "minLength": 1,
                "description": "URI to the content (for documents and sites)."
              },
              "IsFollowed": {
                "type": "boolean",
                "title": "Is Followed",
                "description": "Whether the current user is following this actor back."
              },
              "LibraryUri": {
                "type": "string",
                "title": "Library Uri",
                "format": "uri",
                "maxLength": 2083,
                "minLength": 1,
                "description": "URI to the document library (for documents)."
              },
              "StatusText": {
                "type": "string",
                "title": "Status Text",
                "description": "Text of the most recent post (for user actors)."
              },
              "AccountName": {
                "type": "string",
                "title": "Account Name",
                "description": "Account name in claims format (e.g., 'i:0#.f|membership|user@domain.com')."
              },
              "EmailAddress": {
                "type": "string",
                "title": "Email Address",
                "format": "email",
                "description": "Email address (for user actors)."
              },
              "PersonalSiteUri": {
                "type": "string",
                "title": "Personal Site Uri",
                "format": "uri",
                "maxLength": 2083,
                "minLength": 1,
                "description": "URI to the personal site (for user actors)."
              },
              "FollowedContentUri": {
                "type": "string",
                "title": "Followed Content Uri",
                "format": "uri",
                "maxLength": 2083,
                "minLength": 1,
                "description": "URI of the actor's list of followed content (for users)."
              }
            },
            "description": "Representation of a SharePoint SocialActor (user/document/site/tag)."
          },
          "title": "Followers",
          "description": "Array of SocialActor objects representing users who follow the current user."
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

## SHARE_POINT_GET_ROLE_DEFINITIONS
Tool to list role definitions at the web level. Role definition IDs and names are scoped per web/site collection — never hard-code them, as admins can modify role sets and IDs differ across site collections. Always resolve current values dynamically via this tool.

**Input schema:**
```json
{
  "type": "object",
  "title": "GetRoleDefinitionsRequest",
  "properties": {
    "top": {
      "type": "integer",
      "title": "Top",
      "minimum": 1,
      "examples": [
        5
      ],
      "description": "OData top: Maximum number of items to return, must be \u2265 1."
    },
    "expand": {
      "type": "string",
      "title": "Expand",
      "examples": [
        "BasePermissions"
      ],
      "description": "OData expand: Expand related entities (bulk expansion not supported)."
    },
    "filter": {
      "type": "string",
      "title": "Filter",
      "examples": [
        "Name eq 'Read'"
      ],
      "description": "OData filter: Expression to filter returned role definitions (e.g., \"Name eq 'Read'\"). Name-based filters may be case-sensitive or locale-sensitive; normalize role names before constructing filter expressions to avoid empty results."
    },
    "select": {
      "type": "string",
      "title": "Select",
      "examples": [
        "Name,Id"
      ],
      "description": "OData select: Comma-separated list of properties to return (e.g., 'Name,Id')."
    },
    "orderby": {
      "type": "string",
      "title": "Orderby",
      "examples": [
        "Name desc"
      ],
      "description": "OData orderby: Sort order (e.g., 'Name desc')."
    },
    "site_name": {
      "type": "string",
      "title": "Site Name",
      "examples": [
        "composio-test"
      ],
      "description": "The subsite name to scope the request to (e.g., 'composio-test'). If omitted, the root site is used. When provided, the API base URL becomes https://{tenant}.sharepoint.com/sites/{site}."
    },
    "skiptoken": {
      "type": "string",
      "title": "Skiptoken",
      "examples": [
        "Paged=TRUE&p_ID=20"
      ],
      "description": "OData skiptoken: Pagination token for continuing a prior query."
    }
  },
  "description": "Request parameters for listing role definitions at the web level.",
  "additionalProperties": false
}
```

**Output schema:**
```json
{
  "type": "object",
  "$defs": {
    "RoleDefinition": {
      "type": "object",
      "title": "RoleDefinition",
      "properties": {
        "Id": {
          "type": "integer",
          "title": "Id",
          "description": "Identifier of the role definition."
        },
        "Name": {
          "type": "string",
          "title": "Name",
          "description": "Name of the role definition."
        },
        "Order": {
          "type": "integer",
          "title": "Order",
          "description": "Display order on the Permission Levels page."
        },
        "Hidden": {
          "type": "boolean",
          "title": "Hidden",
          "description": "True if hidden in the UI."
        },
        "Description": {
          "type": "string",
          "title": "Description",
          "description": "Role definition description."
        },
        "RoleTypeKind": {
          "type": "integer",
          "title": "Role Type Kind",
          "description": "Numeric code of the role type (SP.RoleType enum)."
        },
        "BasePermissions": {
          "type": "object",
          "title": "Base Permissions",
          "description": "Bitmasked permissions as two 32-bit values under 'High' and 'Low' (returned as strings).",
          "additionalProperties": {
            "type": "string"
          }
        }
      },
      "description": "A single role definition (permission level) on the site."
    },
    "GetRoleDefinitionsResponse": {
      "type": "object",
      "title": "GetRoleDefinitionsResponse",
      "required": [
        "value"
      ],
      "properties": {
        "value": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "RoleDefinition",
            "properties": {
              "Id": {
                "type": "integer",
                "title": "Id",
                "description": "Identifier of the role definition."
              },
              "Name": {
                "type": "string",
                "title": "Name",
                "description": "Name of the role definition."
              },
              "Order": {
                "type": "integer",
                "title": "Order",
                "description": "Display order on the Permission Levels page."
              },
              "Hidden": {
                "type": "boolean",
                "title": "Hidden",
                "description": "True if hidden in the UI."
              },
              "Description": {
                "type": "string",
                "title": "Description",
                "description": "Role definition description."
              },
              "RoleTypeKind": {
                "type": "integer",
                "title": "Role Type Kind",
                "description": "Numeric code of the role type (SP.RoleType enum)."
              },
              "BasePermissions": {
                "type": "object",
                "title": "Base Permissions",
                "description": "Bitmasked permissions as two 32-bit values under 'High' and 'Low' (returned as strings).",
                "additionalProperties": {
                  "type": "string"
                }
              }
            },
            "description": "A single role definition (permission level) on the site."
          },
          "title": "Value",
          "description": "List of role definitions returned from the SharePoint web."
        }
      },
      "description": "Response model for listing role definitions."
    }
  },
  "title": "GetRoleDefinitionsResponseWrapper",
  "required": [
    "data",
    "successful"
  ],
  "properties": {
    "data": {
      "type": "object",
      "title": "Data",
      "required": [
        "value"
      ],
      "properties": {
        "value": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "RoleDefinition",
            "properties": {
              "Id": {
                "type": "integer",
                "title": "Id",
                "description": "Identifier of the role definition."
              },
              "Name": {
                "type": "string",
                "title": "Name",
                "description": "Name of the role definition."
              },
              "Order": {
                "type": "integer",
                "title": "Order",
                "description": "Display order on the Permission Levels page."
              },
              "Hidden": {
                "type": "boolean",
                "title": "Hidden",
                "description": "True if hidden in the UI."
              },
              "Description": {
                "type": "string",
                "title": "Description",
                "description": "Role definition description."
              },
              "RoleTypeKind": {
                "type": "integer",
                "title": "Role Type Kind",
                "description": "Numeric code of the role type (SP.RoleType enum)."
              },
              "BasePermissions": {
                "type": "object",
                "title": "Base Permissions",
                "description": "Bitmasked permissions as two 32-bit values under 'High' and 'Low' (returned as strings).",
                "additionalProperties": {
                  "type": "string"
                }
              }
            },
            "description": "A single role definition (permission level) on the site."
          },
          "title": "Value",
          "description": "List of role definitions returned from the SharePoint web."
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

## SHARE_POINT_GET_SITE_COLLECTION_INFO
Tool to fetch site collection metadata (URL, ID, root web URI) only—not list item or document-level details. Use before subsequent calls to resolve correct API names. Requires SharePoint connection with site-collection-level scopes; may fail even when user-level tools succeed. Verify site_id before use—an incorrect site_id can silently return data for an unrelated site.

**Input schema:**
```json
{
  "type": "object",
  "title": "GetSiteCollectionInfoRequest",
  "properties": {
    "expand": {
      "type": "string",
      "title": "Expand",
      "examples": [
        "Owner",
        "Owner,RootWeb"
      ],
      "description": "OData $expand to expand navigation properties, e.g., 'Owner,RootWeb'."
    },
    "select": {
      "type": "string",
      "title": "Select",
      "examples": [
        "Id,Url",
        "Id,Url,ServerRelativeUrl"
      ],
      "description": "OData $select to specify fields to return, e.g., 'Id,Url,ServerRelativeUrl'."
    }
  },
  "description": "Request parameters for retrieving site collection info.",
  "additionalProperties": false
}
```

**Output schema:**
```json
{
  "type": "object",
  "$defs": {
    "Deferred": {
      "type": "object",
      "title": "Deferred",
      "required": [
        "__deferred"
      ],
      "properties": {
        "__deferred": {
          "type": "object",
          "title": "  Deferred",
          "required": [
            "uri"
          ],
          "properties": {
            "uri": {
              "type": "string",
              "title": "Uri",
              "description": "URI for deferred navigation property"
            }
          },
          "description": "Deferred loading info for navigation property"
        }
      },
      "additionalProperties": true
    },
    "DeferredURI": {
      "type": "object",
      "title": "DeferredURI",
      "required": [
        "uri"
      ],
      "properties": {
        "uri": {
          "type": "string",
          "title": "Uri",
          "description": "URI for deferred navigation property"
        }
      }
    },
    "ExpandedEntity": {
      "type": "object",
      "title": "ExpandedEntity",
      "properties": {},
      "description": "Represents an expanded entity with flexible schema.",
      "additionalProperties": true
    },
    "GetSiteCollectionInfoResponse": {
      "type": "object",
      "title": "GetSiteCollectionInfoResponse",
      "properties": {
        "Id": {
          "type": "string",
          "title": "Id",
          "description": "GUID that identifies the site collection."
        },
        "Url": {
          "type": "string",
          "title": "Url",
          "description": "Full URL to the root Web of the site collection."
        },
        "Owner": {
          "anyOf": [
            {
              "type": "object",
              "title": "Deferred",
              "required": [
                "__deferred"
              ],
              "properties": {
                "__deferred": {
                  "type": "object",
                  "title": "  Deferred",
                  "required": [
                    "uri"
                  ],
                  "properties": {
                    "uri": {
                      "type": "string",
                      "title": "Uri",
                      "description": "URI for deferred navigation property"
                    }
                  },
                  "description": "Deferred loading info for navigation property"
                }
              },
              "additionalProperties": true
            },
            {
              "type": "object",
              "title": "ExpandedEntity",
              "properties": {},
              "description": "Represents an expanded entity with flexible schema.",
              "additionalProperties": true
            }
          ],
          "title": "Owner",
          "description": "Navigation property for site collection owner. Can be deferred or expanded."
        },
        "RootWeb": {
          "anyOf": [
            {
              "type": "object",
              "title": "Deferred",
              "required": [
                "__deferred"
              ],
              "properties": {
                "__deferred": {
                  "type": "object",
                  "title": "  Deferred",
                  "required": [
                    "uri"
                  ],
                  "properties": {
                    "uri": {
                      "type": "string",
                      "title": "Uri",
                      "description": "URI for deferred navigation property"
                    }
                  },
                  "description": "Deferred loading info for navigation property"
                }
              },
              "additionalProperties": true
            },
            {
              "type": "object",
              "title": "ExpandedEntity",
              "properties": {},
              "description": "Represents an expanded entity with flexible schema.",
              "additionalProperties": true
            }
          ],
          "title": "Root Web",
          "description": "Navigation property for the root web of the site collection. Can be deferred or expanded."
        },
        "ReadOnly": {
          "type": "boolean",
          "title": "Read Only",
          "description": "Indicates whether the site collection is read-only."
        },
        "HubSiteId": {
          "type": "string",
          "title": "Hub Site Id",
          "description": "GUID of the hub site if this site is associated with one."
        },
        "IsHubSite": {
          "type": "boolean",
          "title": "Is Hub Site",
          "description": "Indicates whether this is a hub site."
        },
        "GeoLocation": {
          "type": "string",
          "title": "Geo Location",
          "description": "Geographic location code for the site collection (e.g., 'NAM', 'EUR')."
        },
        "Classification": {
          "type": "string",
          "title": "Classification",
          "description": "Classification label for the site collection."
        },
        "ServerRelativeUrl": {
          "type": "string",
          "title": "Server Relative Url",
          "description": "Server-relative URL of the root Web."
        },
        "CompatibilityLevel": {
          "type": "integer",
          "title": "Compatibility Level",
          "description": "SharePoint version compatibility level."
        },
        "AllowSelfServiceUpgrade": {
          "type": "boolean",
          "title": "Allow Self Service Upgrade",
          "description": "Indicates whether self-service upgrade is allowed."
        },
        "MaxItemsPerThrottledOperation": {
          "type": "integer",
          "title": "Max Items Per Throttled Operation",
          "description": "Maximum number of items per throttled operation."
        }
      },
      "description": "Response model representing SP.Site metadata.",
      "additionalProperties": true
    }
  },
  "title": "GetSiteCollectionInfoResponseWrapper",
  "required": [
    "data",
    "successful"
  ],
  "properties": {
    "data": {
      "type": "object",
      "title": "Data",
      "properties": {
        "Id": {
          "type": "string",
          "title": "Id",
          "description": "GUID that identifies the site collection."
        },
        "Url": {
          "type": "string",
          "title": "Url",
          "description": "Full URL to the root Web of the site collection."
        },
        "Owner": {
          "anyOf": [
            {
              "type": "object",
              "title": "Deferred",
              "required": [
                "__deferred"
              ],
              "properties": {
                "__deferred": {
                  "type": "object",
                  "title": "  Deferred",
                  "required": [
                    "uri"
                  ],
                  "properties": {
                    "uri": {
                      "type": "string",
                      "title": "Uri",
                      "description": "URI for deferred navigation property"
                    }
                  },
                  "description": "Deferred loading info for navigation property"
                }
              },
              "additionalProperties": true
            },
            {
              "type": "object",
              "title": "ExpandedEntity",
              "properties": {},
              "description": "Represents an expanded entity with flexible schema.",
              "additionalProperties": true
            }
          ],
          "title": "Owner",
          "description": "Navigation property for site collection owner. Can be deferred or expanded."
        },
        "RootWeb": {
          "anyOf": [
            {
              "type": "object",
              "title": "Deferred",
              "required": [
                "__deferred"
              ],
              "properties": {
                "__deferred": {
                  "type": "object",
                  "title": "  Deferred",
                  "required": [
                    "uri"
                  ],
                  "properties": {
                    "uri": {
                      "type": "string",
                      "title": "Uri",
                      "description": "URI for deferred navigation property"
                    }
                  },
                  "description": "Deferred loading info for navigation property"
                }
              },
              "additionalProperties": true
            },
            {
              "type": "object",
              "title": "ExpandedEntity",
              "properties": {},
              "description": "Represents an expanded entity with flexible schema.",
              "additionalProperties": true
            }
          ],
          "title": "Root Web",
          "description": "Navigation property for the root web of the site collection. Can be deferred or expanded."
        },
        "ReadOnly": {
          "type": "boolean",
          "title": "Read Only",
          "description": "Indicates whether the site collection is read-only."
        },
        "HubSiteId": {
          "type": "string",
          "title": "Hub Site Id",
          "description": "GUID of the hub site if this site is associated with one."
        },
        "IsHubSite": {
          "type": "boolean",
          "title": "Is Hub Site",
          "description": "Indicates whether this is a hub site."
        },
        "GeoLocation": {
          "type": "string",
          "title": "Geo Location",
          "description": "Geographic location code for the site collection (e.g., 'NAM', 'EUR')."
        },
        "Classification": {
          "type": "string",
          "title": "Classification",
          "description": "Classification label for the site collection."
        },
        "ServerRelativeUrl": {
          "type": "string",
          "title": "Server Relative Url",
          "description": "Server-relative URL of the root Web."
        },
        "CompatibilityLevel": {
          "type": "integer",
          "title": "Compatibility Level",
          "description": "SharePoint version compatibility level."
        },
        "AllowSelfServiceUpgrade": {
          "type": "boolean",
          "title": "Allow Self Service Upgrade",
          "description": "Indicates whether self-service upgrade is allowed."
        },
        "MaxItemsPerThrottledOperation": {
          "type": "integer",
          "title": "Max Items Per Throttled Operation",
          "description": "Maximum number of items per throttled operation."
        }
      },
      "description": "Data from the action execution",
      "additionalProperties": true
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

## SHARE_POINT_GET_SITE_DRIVE_ITEM_BY_PATH
Tool to retrieve a file or folder by its server-relative path in a SharePoint site. Use when you need to get metadata for an item (file or folder) by path.

**Input schema:**
```json
{
  "type": "object",
  "title": "GetSiteDriveItemByPathRequest",
  "required": [
    "item_path"
  ],
  "properties": {
    "expand": {
      "type": "string",
      "title": "Expand",
      "examples": [
        "ListItemAllFields",
        "Files,Folders"
      ],
      "description": "OData $expand query option. Comma-separated list of related entities to expand. E.g., 'ListItemAllFields' for files, or 'Files,Folders' for folders."
    },
    "select": {
      "type": "string",
      "title": "Select",
      "examples": [
        "Name,ServerRelativeUrl,UniqueId,Length"
      ],
      "description": "OData $select query option. Comma-separated list of fields to return. E.g., 'Name,ServerRelativeUrl,UniqueId,Length,TimeLastModified'."
    },
    "item_path": {
      "type": "string",
      "title": "Item Path",
      "examples": [
        "/Shared Documents/report.pdf",
        "/Shared Documents/MyFolder",
        "/sites/Finance/Shared Documents/file.pdf"
      ],
      "description": "Server-relative path of the file or folder to retrieve, starting with '/'. E.g., '/Shared Documents/file.pdf' for files or '/Shared Documents/MyFolder' for folders. Can be provided as a plain path or pre-encoded. Both formats are accepted."
    },
    "site_name": {
      "type": "string",
      "title": "Site Name",
      "examples": [
        "Workshopsubmissions",
        "Finance",
        "HR"
      ],
      "description": "Optional SharePoint site name to scope the retrieval. Required when accessing items in a subsite (e.g., when the path starts with /sites/). If the path is '/sites/Workshopsubmissions/Shared Documents/file.pdf', set site_name='Workshopsubmissions'. If not provided, the item is resolved from the tenant root site context."
    }
  },
  "description": "Request parameters for retrieving a SharePoint file or folder by its server-relative path.",
  "additionalProperties": false
}
```

**Output schema:**
```json
{
  "type": "object",
  "$defs": {
    "DeferredUri": {
      "type": "object",
      "title": "DeferredUri",
      "required": [
        "uri"
      ],
      "properties": {
        "uri": {
          "type": "string",
          "title": "Uri",
          "description": "URI to fetch the deferred entity."
        }
      },
      "description": "URI for a deferred reference."
    },
    "FileMetadata": {
      "type": "object",
      "title": "FileMetadata",
      "required": [
        "id",
        "uri",
        "type"
      ],
      "properties": {
        "id": {
          "type": "string",
          "title": "Id",
          "description": "Unique identifier URI for the file."
        },
        "uri": {
          "type": "string",
          "title": "Uri",
          "description": "API URI for the file."
        },
        "type": {
          "type": "string",
          "title": "Type",
          "description": "Entity type (SP.File)."
        }
      },
      "description": "Metadata about the file entity."
    },
    "SharePointFile": {
      "type": "object",
      "title": "SharePointFile",
      "properties": {
        "Web": {
          "type": "object",
          "title": "Web",
          "required": [
            "__deferred"
          ],
          "properties": {
            "__deferred": {
              "type": "object",
              "title": "  Deferred",
              "required": [
                "uri"
              ],
              "properties": {
                "uri": {
                  "type": "string",
                  "title": "Uri",
                  "description": "URI to fetch the deferred entity."
                }
              },
              "description": "Deferred URI object."
            }
          },
          "description": "Web context (deferred reference)."
        },
        "ETag": {
          "type": "string",
          "title": "E Tag",
          "description": "Entity tag for versioning."
        },
        "Name": {
          "type": "string",
          "title": "Name",
          "description": "Name of the file."
        },
        "Level": {
          "type": "integer",
          "title": "Level",
          "description": "Level of the file."
        },
        "Title": {
          "type": "string",
          "title": "Title",
          "description": "Title of the file."
        },
        "Author": {
          "type": "object",
          "title": "Author",
          "required": [
            "__deferred"
          ],
          "properties": {
            "__deferred": {
              "type": "object",
              "title": "  Deferred",
              "required": [
                "uri"
              ],
              "properties": {
                "uri": {
                  "type": "string",
                  "title": "Uri",
                  "description": "URI to fetch the deferred entity."
                }
              },
              "description": "Deferred URI object."
            }
          },
          "description": "Author of the file (deferred reference)."
        },
        "Exists": {
          "type": "boolean",
          "title": "Exists",
          "description": "Whether the file exists."
        },
        "Length": {
          "type": "string",
          "title": "Length",
          "description": "File size in bytes."
        },
        "UniqueId": {
          "type": "string",
          "title": "Unique Id",
          "description": "Unique identifier (GUID) of the file."
        },
        "Versions": {
          "type": "object",
          "title": "Versions",
          "required": [
            "__deferred"
          ],
          "properties": {
            "__deferred": {
              "type": "object",
              "title": "  Deferred",
              "required": [
                "uri"
              ],
              "properties": {
                "uri": {
                  "type": "string",
                  "title": "Uri",
                  "description": "URI to fetch the deferred entity."
                }
              },
              "description": "Deferred URI object."
            }
          },
          "description": "File versions (deferred reference)."
        },
        "UIVersion": {
          "type": "integer",
          "title": "Ui Version",
          "description": "UI version number."
        },
        "ContentTag": {
          "type": "string",
          "title": "Content Tag",
          "description": "Content tag for the file."
        },
        "IrmEnabled": {
          "type": "boolean",
          "title": "Irm Enabled",
          "description": "Whether Information Rights Management is enabled."
        },
        "LinkingUri": {
          "type": "string",
          "title": "Linking Uri",
          "description": "Linking URI for the file."
        },
        "LinkingUrl": {
          "type": "string",
          "title": "Linking Url",
          "description": "Linking URL for the file."
        },
        "ModifiedBy": {
          "type": "object",
          "title": "Modified By",
          "required": [
            "__deferred"
          ],
          "properties": {
            "__deferred": {
              "type": "object",
              "title": "  Deferred",
              "required": [
                "uri"
              ],
              "properties": {
                "uri": {
                  "type": "string",
                  "title": "Uri",
                  "description": "URI to fetch the deferred entity."
                }
              },
              "description": "Deferred URI object."
            }
          },
          "description": "User who last modified the file (deferred reference)."
        },
        "Properties": {
          "type": "object",
          "title": "Properties",
          "required": [
            "__deferred"
          ],
          "properties": {
            "__deferred": {
              "type": "object",
              "title": "  Deferred",
              "required": [
                "uri"
              ],
              "properties": {
                "uri": {
                  "type": "string",
                  "title": "Uri",
                  "description": "URI to fetch the deferred entity."
                }
              },
              "description": "Deferred URI object."
            }
          },
          "description": "File properties (deferred reference)."
        },
        "__metadata": {
          "type": "object",
          "title": "  Metadata",
          "required": [
            "id",
            "uri",
            "type"
          ],
          "properties": {
            "id": {
              "type": "string",
              "title": "Id",
              "description": "Unique identifier URI for the file."
            },
            "uri": {
              "type": "string",
              "title": "Uri",
              "description": "API URI for the file."
            },
            "type": {
              "type": "string",
              "title": "Type",
              "description": "Entity type (SP.File)."
            }
          },
          "description": "Metadata for the file entity."
        },
        "TimeCreated": {
          "type": "string",
          "title": "Time Created",
          "description": "Creation timestamp."
        },
        "CheckOutType": {
          "type": "integer",
          "title": "Check Out Type",
          "description": "Check-out type (0=Online, 1=Offline, 2=None)."
        },
        "LockedByUser": {
          "type": "object",
          "title": "Locked By User",
          "required": [
            "__deferred"
          ],
          "properties": {
            "__deferred": {
              "type": "object",
              "title": "  Deferred",
              "required": [
                "uri"
              ],
              "properties": {
                "uri": {
                  "type": "string",
                  "title": "Uri",
                  "description": "URI to fetch the deferred entity."
                }
              },
              "description": "Deferred URI object."
            }
          },
          "description": "User who locked the file (deferred reference)."
        },
        "MajorVersion": {
          "type": "integer",
          "title": "Major Version",
          "description": "Major version number."
        },
        "MinorVersion": {
          "type": "integer",
          "title": "Minor Version",
          "description": "Minor version number."
        },
        "VersionEvents": {
          "type": "object",
          "title": "Version Events",
          "required": [
            "__deferred"
          ],
          "properties": {
            "__deferred": {
              "type": "object",
              "title": "  Deferred",
              "required": [
                "uri"
              ],
              "properties": {
                "uri": {
                  "type": "string",
                  "title": "Uri",
                  "description": "URI to fetch the deferred entity."
                }
              },
              "description": "Deferred URI object."
            }
          },
          "description": "Version events (deferred reference)."
        },
        "CheckInComment": {
          "type": "string",
          "title": "Check In Comment",
          "description": "Check-in comment."
        },
        "UIVersionLabel": {
          "type": "string",
          "title": "Ui Version Label",
          "description": "UI version label."
        },
        "CheckedOutByUser": {
          "type": "object",
          "title": "Checked Out By User",
          "required": [
            "__deferred"
          ],
          "properties": {
            "__deferred": {
              "type": "object",
              "title": "  Deferred",
              "required": [
                "uri"
              ],
              "properties": {
                "uri": {
                  "type": "string",
                  "title": "Uri",
                  "description": "URI to fetch the deferred entity."
                }
              },
              "description": "Deferred URI object."
            }
          },
          "description": "User who checked out the file (deferred reference)."
        },
        "TimeLastModified": {
          "type": "string",
          "title": "Time Last Modified",
          "description": "Last modified timestamp."
        },
        "ListItemAllFields": {
          "type": "object",
          "title": "List Item All Fields",
          "required": [
            "__deferred"
          ],
          "properties": {
            "__deferred": {
              "type": "object",
              "title": "  Deferred",
              "required": [
                "uri"
              ],
              "properties": {
                "uri": {
                  "type": "string",
                  "title": "Uri",
                  "description": "URI to fetch the deferred entity."
                }
              },
              "description": "Deferred URI object."
            }
          },
          "description": "List item fields (deferred reference)."
        },
        "ServerRelativeUrl": {
          "type": "string",
          "title": "Server Relative Url",
          "description": "Server-relative URL of the file."
        },
        "ExistsWithException": {
          "type": "boolean",
          "title": "Exists With Exception",
          "description": "Whether the file exists (with exceptions)."
        },
        "CustomizedPageStatus": {
          "type": "integer",
          "title": "Customized Page Status",
          "description": "Customized page status."
        },
        "VersionExpirationReport": {
          "type": "object",
          "title": "Version Expiration Report",
          "required": [
            "__deferred"
          ],
          "properties": {
            "__deferred": {
              "type": "object",
              "title": "  Deferred",
              "required": [
                "uri"
              ],
              "properties": {
                "uri": {
                  "type": "string",
                  "title": "Uri",
                  "description": "URI to fetch the deferred entity."
                }
              },
              "description": "Deferred URI object."
            }
          },
          "description": "Version expiration report (deferred reference)."
        },
        "ExistsAllowThrowForPolicyFailures": {
          "type": "boolean",
          "title": "Exists Allow Throw For Policy Failures",
          "description": "Whether the file exists (with policy check)."
        },
        "InformationRightsManagementSettings": {
          "type": "object",
          "title": "Information Rights Management Settings",
          "required": [
            "__deferred"
          ],
          "properties": {
            "__deferred": {
              "type": "object",
              "title": "  Deferred",
              "required": [
                "uri"
              ],
              "properties": {
                "uri": {
                  "type": "string",
                  "title": "Uri",
                  "description": "URI to fetch the deferred entity."
                }
              },
              "description": "Deferred URI object."
            }
          },
          "description": "IRM settings (deferred reference)."
        },
        "EffectiveInformationRightsManagementSettings": {
          "type": "object",
          "title": "Effective Information Rights Management Settings",
          "required": [
            "__deferred"
          ],
          "properties": {
            "__deferred": {
              "type": "object",
              "title": "  Deferred",
              "required": [
                "uri"
              ],
              "properties": {
                "uri": {
                  "type": "string",
                  "title": "Uri",
                  "description": "URI to fetch the deferred entity."
                }
              },
              "description": "Deferred URI object."
            }
          },
          "description": "Effective IRM settings (deferred reference)."
        }
      },
      "description": "SharePoint File entity with metadata and properties.",
      "additionalProperties": true
    },
    "DeferredReference": {
      "type": "object",
      "title": "DeferredReference",
      "required": [
        "__deferred"
      ],
      "properties": {
        "__deferred": {
          "type": "object",
          "title": "  Deferred",
          "required": [
            "uri"
          ],
          "properties": {
            "uri": {
              "type": "string",
              "title": "Uri",
              "description": "URI to fetch the deferred entity."
            }
          },
          "description": "Deferred URI object."
        }
      },
      "description": "A deferred reference to a related entity that requires a separate API call."
    },
    "GetSiteDriveItemByPathResponse": {
      "type": "object",
      "title": "GetSiteDriveItemByPathResponse",
      "properties": {
        "Name": {
          "type": "string",
          "title": "Name",
          "description": "Name of the file or folder."
        },
        "Files": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "SharePointFile",
            "properties": {
              "Web": {
                "type": "object",
                "title": "Web",
                "required": [
                  "__deferred"
                ],
                "properties": {
                  "__deferred": {
                    "type": "object",
                    "title": "  Deferred",
                    "required": [
                      "uri"
                    ],
                    "properties": {
                      "uri": {
                        "type": "string",
                        "title": "Uri",
                        "description": "URI to fetch the deferred entity."
                      }
                    },
                    "description": "Deferred URI object."
                  }
                },
                "description": "Web context (deferred reference)."
              },
              "ETag": {
                "type": "string",
                "title": "E Tag",
                "description": "Entity tag for versioning."
              },
              "Name": {
                "type": "string",
                "title": "Name",
                "description": "Name of the file."
              },
              "Level": {
                "type": "integer",
                "title": "Level",
                "description": "Level of the file."
              },
              "Title": {
                "type": "string",
                "title": "Title",
                "description": "Title of the file."
              },
              "Author": {
                "type": "object",
                "title": "Author",
                "required": [
                  "__deferred"
                ],
                "properties": {
                  "__deferred": {
                    "type": "object",
                    "title": "  Deferred",
                    "required": [
                      "uri"
                    ],
                    "properties": {
                      "uri": {
                        "type": "string",
                        "title": "Uri",
                        "description": "URI to fetch the deferred entity."
                      }
                    },
                    "description": "Deferred URI object."
                  }
                },
                "description": "Author of the file (deferred reference)."
              },
              "Exists": {
                "type": "boolean",
                "title": "Exists",
                "description": "Whether the file exists."
              },
              "Length": {
                "type": "string",
                "title": "Length",
                "description": "File size in bytes."
              },
              "UniqueId": {
                "type": "string",
                "title": "Unique Id",
                "description": "Unique identifier (GUID) of the file."
              },
              "Versions": {
                "type": "object",
                "title": "Versions",
                "required": [
                  "__deferred"
                ],
                "properties": {
                  "__deferred": {
                    "type": "object",
                    "title": "  Deferred",
                    "required": [
                      "uri"
                    ],
                    "properties": {
                      "uri": {
                        "type": "string",
                        "title": "Uri",
                        "description": "URI to fetch the deferred entity."
                      }
                    },
                    "description": "Deferred URI object."
                  }
                },
                "description": "File versions (deferred reference)."
              },
              "UIVersion": {
                "type": "integer",
                "title": "Ui Version",
                "description": "UI version number."
              },
              "ContentTag": {
                "type": "string",
                "title": "Content Tag",
                "description": "Content tag for the file."
              },
              "IrmEnabled": {
                "type": "boolean",
                "title": "Irm Enabled",
                "description": "Whether Information Rights Management is enabled."
              },
              "LinkingUri": {
                "type": "string",
                "title": "Linking Uri",
                "description": "Linking URI for the file."
              },
              "LinkingUrl": {
                "type": "string",
                "title": "Linking Url",
                "description": "Linking URL for the file."
              },
              "ModifiedBy": {
                "type": "object",
                "title": "Modified By",
                "required": [
                  "__deferred"
                ],
                "properties": {
                  "__deferred": {
                    "type": "object",
                    "title": "  Deferred",
                    "required": [
                      "uri"
                    ],
                    "properties": {
                      "uri": {
                        "type": "string",
                        "title": "Uri",
                        "description": "URI to fetch the deferred entity."
                      }
                    },
                    "description": "Deferred URI object."
                  }
                },
                "description": "User who last modified the file (deferred reference)."
              },
              "Properties": {
                "type": "object",
                "title": "Properties",
                "required": [
                  "__deferred"
                ],
                "properties": {
                  "__deferred": {
                    "type": "object",
                    "title": "  Deferred",
                    "required": [
                      "uri"
                    ],
                    "properties": {
                      "uri": {
                        "type": "string",
                        "title": "Uri",
                        "description": "URI to fetch the deferred entity."
                      }
                    },
                    "description": "Deferred URI object."
                  }
                },
                "description": "File properties (deferred reference)."
              },
              "__metadata": {
                "type": "object",
                "title": "  Metadata",
                "required": [
                  "id",
                  "uri",
                  "type"
                ],
                "properties": {
                  "id": {
                    "type": "string",
                    "title": "Id",
                    "description": "Unique identifier URI for the file."
                  },
                  "uri": {
                    "type": "string",
                    "title": "Uri",
                    "description": "API URI for the file."
                  },
                  "type": {
                    "type": "string",
                    "title": "Type",
                    "description": "Entity type (SP.File)."
                  }
                },
                "description": "Metadata for the file entity."
              },
              "TimeCreated": {
                "type": "string",
                "title": "Time Created",
                "description": "Creation timestamp."
              },
              "CheckOutType": {
                "type": "integer",
                "title": "Check Out Type",
                "description": "Check-out type (0=Online, 1=Offline, 2=None)."
              },
              "LockedByUser": {
                "type": "object",
                "title": "Locked By User",
                "required": [
                  "__deferred"
                ],
                "properties": {
                  "__deferred": {
                    "type": "object",
                    "title": "  Deferred",
                    "required": [
                      "uri"
                    ],
                    "properties": {
                      "uri": {
                        "type": "string",
                        "title": "Uri",
                        "description": "URI to fetch the deferred entity."
                      }
                    },
                    "description": "Deferred URI object."
                  }
                },
                "description": "User who locked the file (deferred reference)."
              },
              "MajorVersion": {
                "type": "integer",
                "title": "Major Version",
                "description": "Major version number."
              },
              "MinorVersion": {
                "type": "integer",
                "title": "Minor Version",
                "description": "Minor version number."
              },
              "VersionEvents": {
                "type": "object",
                "title": "Version Events",
                "required": [
                  "__deferred"
                ],
                "properties": {
                  "__deferred": {
                    "type": "object",
                    "title": "  Deferred",
                    "required": [
                      "uri"
                    ],
                    "properties": {
                      "uri": {
                        "type": "string",
                        "title": "Uri",
                        "description": "URI to fetch the deferred entity."
                      }
                    },
                    "description": "Deferred URI object."
                  }
                },
                "description": "Version events (deferred reference)."
              },
              "CheckInComment": {
                "type": "string",
                "title": "Check In Comment",
                "description": "Check-in comment."
              },
              "UIVersionLabel": {
                "type": "string",
                "title": "Ui Version Label",
                "description": "UI version label."
              },
              "CheckedOutByUser": {
                "type": "object",
                "title": "Checked Out By User",
                "required": [
                  "__deferred"
                ],
                "properties": {
                  "__deferred": {
                    "type": "object",
                    "title": "  Deferred",
                    "required": [
                      "uri"
                    ],
                    "properties": {
                      "uri": {
                        "type": "string",
                        "title": "Uri",
                        "description": "URI to fetch the deferred entity."
                      }
                    },
                    "description": "Deferred URI object."
                  }
                },
                "description": "User who checked out the file (deferred reference)."
              },
              "TimeLastModified": {
                "type": "string",
                "title": "Time Last Modified",
                "description": "Last modified timestamp."
              },
              "ListItemAllFields": {
                "type": "object",
                "title": "List Item All Fields",
                "required": [
                  "__deferred"
                ],
                "properties": {
                  "__deferred": {
                    "type": "object",
                    "title": "  Deferred",
                    "required": [
                      "uri"
                    ],
                    "properties": {
                      "uri": {
                        "type": "string",
                        "title": "Uri",
                        "description": "URI to fetch the deferred entity."
                      }
                    },
                    "description": "Deferred URI object."
                  }
                },
                "description": "List item fields (deferred reference)."
              },
              "ServerRelativeUrl": {
                "type": "string",
                "title": "Server Relative Url",
                "description": "Server-relative URL of the file."
              },
              "ExistsWithException": {
                "type": "boolean",
                "title": "Exists With Exception",
                "description": "Whether the file exists (with exceptions)."
              },
              "CustomizedPageStatus": {
                "type": "integer",
                "title": "Customized Page Status",
                "description": "Customized page status."
              },
              "VersionExpirationReport": {
                "type": "object",
                "title": "Version Expiration Report",
                "required": [
                  "__deferred"
                ],
                "properties": {
                  "__deferred": {
                    "type": "object",
                    "title": "  Deferred",
                    "required": [
                      "uri"
                    ],
                    "properties": {
                      "uri": {
                        "type": "string",
                        "title": "Uri",
                        "description": "URI to fetch the deferred entity."
                      }
                    },
                    "description": "Deferred URI object."
                  }
                },
                "description": "Version expiration report (deferred reference)."
              },
              "ExistsAllowThrowForPolicyFailures": {
                "type": "boolean",
                "title": "Exists Allow Throw For Policy Failures",
                "description": "Whether the file exists (with policy check)."
              },
              "InformationRightsManagementSettings": {
                "type": "object",
                "title": "Information Rights Management Settings",
                "required": [
                  "__deferred"
                ],
                "properties": {
                  "__deferred": {
                    "type": "object",
                    "title": "  Deferred",
                    "required": [
                      "uri"
                    ],
                    "properties": {
                      "uri": {
                        "type": "string",
                        "title": "Uri",
                        "description": "URI to fetch the deferred entity."
                      }
                    },
                    "description": "Deferred URI object."
                  }
                },
                "description": "IRM settings (deferred reference)."
              },
              "EffectiveInformationRightsManagementSettings": {
                "type": "object",
                "title": "Effective Information Rights Management Settings",
                "required": [
                  "__deferred"
                ],
                "properties": {
                  "__deferred": {
                    "type": "object",
                    "title": "  Deferred",
                    "required": [
                      "uri"
                    ],
                    "properties": {
                      "uri": {
                        "type": "string",
                        "title": "Uri",
                        "description": "URI to fetch the deferred entity."
                      }
                    },
                    "description": "Deferred URI object."
                  }
                },
                "description": "Effective IRM settings (deferred reference)."
              }
            },
            "description": "SharePoint File entity with metadata and properties.",
            "additionalProperties": true
          },
          "title": "Files",
          "description": "List of files if this is a folder and expanded with $expand=Files. None when not expanded."
        },
        "Title": {
          "type": "string",
          "title": "Title",
          "description": "Title of the item if available."
        },
        "Exists": {
          "type": "boolean",
          "title": "Exists",
          "description": "Whether the item exists. True if found, False if not found."
        },
        "Length": {
          "type": "string",
          "title": "Length",
          "description": "File size in bytes. Only present for files."
        },
        "Folders": {
          "type": "array",
          "items": {
            "type": "object",
            "additionalProperties": true
          },
          "title": "Folders",
          "description": "List of subfolders if this is a folder and expanded with $expand=Folders. None when not expanded."
        },
        "UniqueId": {
          "type": "string",
          "title": "Unique Id",
          "description": "Unique identifier (GUID) of the item."
        },
        "ItemCount": {
          "type": "integer",
          "title": "Item Count",
          "description": "Number of items in the folder. Only present for folders."
        },
        "TimeCreated": {
          "type": "string",
          "title": "Time Created",
          "description": "Creation timestamp."
        },
        "WelcomePage": {
          "type": "string",
          "title": "Welcome Page",
          "description": "URL of the folder's welcome page if set. Only for folders."
        },
        "CheckOutType": {
          "type": "integer",
          "title": "Check Out Type",
          "description": "Check-out type of the file (0=Online, 1=Offline, 2=None). Only for files."
        },
        "MajorVersion": {
          "type": "integer",
          "title": "Major Version",
          "description": "Major version number. Only for files."
        },
        "MinorVersion": {
          "type": "integer",
          "title": "Minor Version",
          "description": "Minor version number. Only for files."
        },
        "TimeLastModified": {
          "type": "string",
          "title": "Time Last Modified",
          "description": "Last modified timestamp."
        },
        "ListItemAllFields": {
          "type": "object",
          "title": "List Item All Fields",
          "description": "List item metadata. Populated when expanded with $expand=ListItemAllFields, None otherwise.",
          "additionalProperties": true
        },
        "ServerRelativeUrl": {
          "type": "string",
          "title": "Server Relative Url",
          "description": "Server-relative URL of the item."
        }
      },
      "description": "Response model for SharePoint file or folder metadata."
    }
  },
  "title": "GetSiteDriveItemByPathResponseWrapper",
  "required": [
    "data",
    "successful"
  ],
  "properties": {
    "data": {
      "type": "object",
      "title": "Data",
      "properties": {
        "Name": {
          "type": "string",
          "title": "Name",
          "description": "Name of the file or folder."
        },
        "Files": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "SharePointFile",
            "properties": {
              "Web": {
                "type": "object",
                "title": "Web",
                "required": [
                  "__deferred"
                ],
                "properties": {
                  "__deferred": {
                    "type": "object",
                    "title": "  Deferred",
                    "required": [
                      "uri"
                    ],
                    "properties": {
                      "uri": {
                        "type": "string",
                        "title": "Uri",
                        "description": "URI to fetch the deferred entity."
                      }
                    },
                    "description": "Deferred URI object."
                  }
                },
                "description": "Web context (deferred reference)."
              },
              "ETag": {
                "type": "string",
                "title": "E Tag",
                "description": "Entity tag for versioning."
              },
              "Name": {
                "type": "string",
                "title": "Name",
                "description": "Name of the file."
              },
              "Level": {
                "type": "integer",
                "title": "Level",
                "description": "Level of the file."
              },
              "Title": {
                "type": "string",
                "title": "Title",
                "description": "Title of the file."
              },
              "Author": {
                "type": "object",
                "title": "Author",
                "required": [
                  "__deferred"
                ],
                "properties": {
                  "__deferred": {
                    "type": "object",
                    "title": "  Deferred",
                    "required": [
                      "uri"
                    ],
                    "properties": {
                      "uri": {
                        "type": "string",
                        "title": "Uri",
                        "description": "URI to fetch the deferred entity."
                      }
                    },
                    "description": "Deferred URI object."
                  }
                },
                "description": "Author of the file (deferred reference)."
              },
              "Exists": {
                "type": "boolean",
                "title": "Exists",
                "description": "Whether the file exists."
              },
              "Length": {
                "type": "string",
                "title": "Length",
                "description": "File size in bytes."
              },
              "UniqueId": {
                "type": "string",
                "title": "Unique Id",
                "description": "Unique identifier (GUID) of the file."
              },
              "Versions": {
                "type": "object",
                "title": "Versions",
                "required": [
                  "__deferred"
                ],
                "properties": {
                  "__deferred": {
                    "type": "object",
                    "title": "  Deferred",
                    "required": [
                      "uri"
                    ],
                    "properties": {
                      "uri": {
                        "type": "string",
                        "title": "Uri",
                        "description": "URI to fetch the deferred entity."
                      }
                    },
                    "description": "Deferred URI object."
                  }
                },
                "description": "File versions (deferred reference)."
              },
              "UIVersion": {
                "type": "integer",
                "title": "Ui Version",
                "description": "UI version number."
              },
              "ContentTag": {
                "type": "string",
                "title": "Content Tag",
                "description": "Content tag for the file."
              },
              "IrmEnabled": {
                "type": "boolean",
                "title": "Irm Enabled",
                "description": "Whether Information Rights Management is enabled."
              },
              "LinkingUri": {
                "type": "string",
                "title": "Linking Uri",
                "description": "Linking URI for the file."
              },
              "LinkingUrl": {
                "type": "string",
                "title": "Linking Url",
                "description": "Linking URL for the file."
              },
              "ModifiedBy": {
                "type": "object",
                "title": "Modified By",
                "required": [
                  "__deferred"
                ],
                "properties": {
                  "__deferred": {
                    "type": "object",
                    "title": "  Deferred",
                    "required": [
                      "uri"
                    ],
                    "properties": {
                      "uri": {
                        "type": "string",
                        "title": "Uri",
                        "description": "URI to fetch the deferred entity."
                      }
                    },
                    "description": "Deferred URI object."
                  }
                },
                "description": "User who last modified the file (deferred reference)."
              },
              "Properties": {
                "type": "object",
                "title": "Properties",
                "required": [
                  "__deferred"
                ],
                "properties": {
                  "__deferred": {
                    "type": "object",
                    "title": "  Deferred",
                    "required": [
                      "uri"
                    ],
                    "properties": {
                      "uri": {
                        "type": "string",
                        "title": "Uri",
                        "description": "URI to fetch the deferred entity."
                      }
                    },
                    "description": "Deferred URI object."
                  }
                },
                "description": "File properties (deferred reference)."
              },
              "__metadata": {
                "type": "object",
                "title": "  Metadata",
                "required": [
                  "id",
                  "uri",
                  "type"
                ],
                "properties": {
                  "id": {
                    "type": "string",
                    "title": "Id",
                    "description": "Unique identifier URI for the file."
                  },
                  "uri": {
                    "type": "string",
                    "title": "Uri",
                    "description": "API URI for the file."
                  },
                  "type": {
                    "type": "string",
                    "title": "Type",
                    "description": "Entity type (SP.File)."
                  }
                },
                "description": "Metadata for the file entity."
              },
              "TimeCreated": {
                "type": "string",
                "title": "Time Created",
                "description": "Creation timestamp."
              },
              "CheckOutType": {
                "type": "integer",
                "title": "Check Out Type",
                "description": "Check-out type (0=Online, 1=Offline, 2=None)."
              },
              "LockedByUser": {
                "type": "object",
                "title": "Locked By User",
                "required": [
                  "__deferred"
                ],
                "properties": {
                  "__deferred": {
                    "type": "object",
                    "title": "  Deferred",
                    "required": [
                      "uri"
                    ],
                    "properties": {
                      "uri": {
                        "type": "string",
                        "title": "Uri",
                        "description": "URI to fetch the deferred entity."
                      }
                    },
                    "description": "Deferred URI object."
                  }
                },
                "description": "User who locked the file (deferred reference)."
              },
              "MajorVersion": {
                "type": "integer",
                "title": "Major Version",
                "description": "Major version number."
              },
              "MinorVersion": {
                "type": "integer",
                "title": "Minor Version",
                "description": "Minor version number."
              },
              "VersionEvents": {
                "type": "object",
                "title": "Version Events",
                "required": [
                  "__deferred"
                ],
                "properties": {
                  "__deferred": {
                    "type": "object",
                    "title": "  Deferred",
                    "required": [
                      "uri"
                    ],
                    "properties": {
                      "uri": {
                        "type": "string",
                        "title": "Uri",
                        "description": "URI to fetch the deferred entity."
                      }
                    },
                    "description": "Deferred URI object."
                  }
                },
                "description": "Version events (deferred reference)."
              },
              "CheckInComment": {
                "type": "string",
                "title": "Check In Comment",
                "description": "Check-in comment."
              },
              "UIVersionLabel": {
                "type": "string",
                "title": "Ui Version Label",
                "description": "UI version label."
              },
              "CheckedOutByUser": {
                "type": "object",
                "title": "Checked Out By User",
                "required": [
                  "__deferred"
                ],
                "properties": {
                  "__deferred": {
                    "type": "object",
                    "title": "  Deferred",
                    "required": [
                      "uri"
                    ],
                    "properties": {
                      "uri": {
                        "type": "string",
                        "title": "Uri",
                        "description": "URI to fetch the deferred entity."
                      }
                    },
                    "description": "Deferred URI object."
                  }
                },
                "description": "User who checked out the file (deferred reference)."
              },
              "TimeLastModified": {
                "type": "string",
                "title": "Time Last Modified",
                "description": "Last modified timestamp."
              },
              "ListItemAllFields": {
                "type": "object",
                "title": "List Item All Fields",
                "required": [
                  "__deferred"
                ],
                "properties": {
                  "__deferred": {
                    "type": "object",
                    "title": "  Deferred",
                    "required": [
                      "uri"
                    ],
                    "properties": {
                      "uri": {
                        "type": "string",
                        "title": "Uri",
                        "description": "URI to fetch the deferred entity."
                      }
                    },
                    "description": "Deferred URI object."
                  }
                },
                "description": "List item fields (deferred reference)."
              },
              "ServerRelativeUrl": {
                "type": "string",
                "title": "Server Relative Url",
                "description": "Server-relative URL of the file."
              },
              "ExistsWithException": {
                "type": "boolean",
                "title": "Exists With Exception",
                "description": "Whether the file exists (with exceptions)."
              },
              "CustomizedPageStatus": {
                "type": "integer",
                "title": "Customized Page Status",
                "description": "Customized page status."
              },
              "VersionExpirationReport": {
                "type": "object",
                "title": "Version Expiration Report",
                "required": [
                  "__deferred"
                ],
                "properties": {
                  "__deferred": {
                    "type": "object",
                    "title": "  Deferred",
                    "required": [
                      "uri"
                    ],
                    "properties": {
                      "uri": {
                        "type": "string",
                        "title": "Uri",
                        "description": "URI to fetch the deferred entity."
                      }
                    },
                    "description": "Deferred URI object."
                  }
                },
                "description": "Version expiration report (deferred reference)."
              },
              "ExistsAllowThrowForPolicyFailures": {
                "type": "boolean",
                "title": "Exists Allow Throw For Policy Failures",
                "description": "Whether the file exists (with policy check)."
              },
              "InformationRightsManagementSettings": {
                "type": "object",
                "title": "Information Rights Management Settings",
                "required": [
                  "__deferred"
                ],
                "properties": {
                  "__deferred": {
                    "type": "object",
                    "title": "  Deferred",
                    "required": [
                      "uri"
                    ],
                    "properties": {
                      "uri": {
                        "type": "string",
                        "title": "Uri",
                        "description": "URI to fetch the deferred entity."
                      }
                    },
                    "description": "Deferred URI object."
                  }
                },
                "description": "IRM settings (deferred reference)."
              },
              "EffectiveInformationRightsManagementSettings": {
                "type": "object",
                "title": "Effective Information Rights Management Settings",
                "required": [
                  "__deferred"
                ],
                "properties": {
                  "__deferred": {
                    "type": "object",
                    "title": "  Deferred",
                    "required": [
                      "uri"
                    ],
                    "properties": {
                      "uri": {
                        "type": "string",
                        "title": "Uri",
                        "description": "URI to fetch the deferred entity."
                      }
                    },
                    "description": "Deferred URI object."
                  }
                },
                "description": "Effective IRM settings (deferred reference)."
              }
            },
            "description": "SharePoint File entity with metadata and properties.",
            "additionalProperties": true
          },
          "title": "Files",
          "description": "List of files if this is a folder and expanded with $expand=Files. None when not expanded."
        },
        "Title": {
          "type": "string",
          "title": "Title",
          "description": "Title of the item if available."
        },
        "Exists": {
          "type": "boolean",
          "title": "Exists",
          "description": "Whether the item exists. True if found, False if not found."
        },
        "Length": {
          "type": "string",
          "title": "Length",
          "description": "File size in bytes. Only present for files."
        },
        "Folders": {
          "type": "array",
          "items": {
            "type": "object",
            "additionalProperties": true
          },
          "title": "Folders",
          "description": "List of subfolders if this is a folder and expanded with $expand=Folders. None when not expanded."
        },
        "UniqueId": {
          "type": "string",
          "title": "Unique Id",
          "description": "Unique identifier (GUID) of the item."
        },
        "ItemCount": {
          "type": "integer",
          "title": "Item Count",
          "description": "Number of items in the folder. Only present for folders."
        },
        "TimeCreated": {
          "type": "string",
          "title": "Time Created",
          "description": "Creation timestamp."
        },
        "WelcomePage": {
          "type": "string",
          "title": "Welcome Page",
          "description": "URL of the folder's welcome page if set. Only for folders."
        },
        "CheckOutType": {
          "type": "integer",
          "title": "Check Out Type",
          "description": "Check-out type of the file (0=Online, 1=Offline, 2=None). Only for files."
        },
        "MajorVersion": {
          "type": "integer",
          "title": "Major Version",
          "description": "Major version number. Only for files."
        },
        "MinorVersion": {
          "type": "integer",
          "title": "Minor Version",
          "description": "Minor version number. Only for files."
        },
        "TimeLastModified": {
          "type": "string",
          "title": "Time Last Modified",
          "description": "Last modified timestamp."
        },
        "ListItemAllFields": {
          "type": "object",
          "title": "List Item All Fields",
          "description": "List item metadata. Populated when expanded with $expand=ListItemAllFields, None otherwise.",
          "additionalProperties": true
        },
        "ServerRelativeUrl": {
          "type": "string",
          "title": "Server Relative Url",
          "description": "Server-relative URL of the item."
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

## SHARE_POINT_GET_SITE_PAGE_CONTENT
Tool to retrieve modern SharePoint Site Pages content by reading list item fields. Use when a .aspx page result cannot be downloaded as a file or when you need the structured content (CanvasContent1, LayoutWebpartsContent) of modern pages.

**Input schema:**
```json
{
  "type": "object",
  "title": "GetSitePageContentRequest",
  "properties": {
    "item_id": {
      "type": "integer",
      "title": "Item Id",
      "minimum": 1,
      "examples": [
        5,
        12
      ],
      "description": "List item ID of the page in the Site Pages library. Either page_file_name or item_id must be provided."
    },
    "render_as": {
      "enum": [
        "raw",
        "text",
        "html"
      ],
      "type": "string",
      "title": "Render As",
      "default": "raw",
      "examples": [
        "raw",
        "text",
        "html"
      ],
      "description": "Format for retrieving content fields. 'raw' returns direct field values (CanvasContent1, LayoutWebpartsContent). 'text' uses FieldValuesAsText endpoint for plain text rendering. 'html' uses FieldValuesAsHtml endpoint for HTML rendering."
    },
    "site_name": {
      "type": "string",
      "title": "Site Name",
      "examples": [
        "testcomposio",
        "marketing",
        "hr-portal"
      ],
      "description": "Optional SharePoint site name to scope the page retrieval. If provided, the page is retrieved from /sites/{site}. If not provided, the page is retrieved from the tenant root site. E.g., 'testcomposio' for a site at /sites/testcomposio."
    },
    "page_file_name": {
      "type": "string",
      "title": "Page File Name",
      "examples": [
        "Home.aspx",
        "Formed-LLC-&-Received-EIN.aspx"
      ],
      "description": "File name of the modern SharePoint page to retrieve (e.g., 'Formed-LLC-&-Received-EIN.aspx'). Must include the .aspx extension. Either page_file_name or item_id must be provided."
    }
  },
  "description": "Request parameters for retrieving modern SharePoint site page content.",
  "additionalProperties": false
}
```

**Output schema:**
```json
{
  "type": "object",
  "$defs": {
    "GetSitePageContentResponse": {
      "type": "object",
      "title": "GetSitePageContentResponse",
      "properties": {
        "Id": {
          "type": "integer",
          "title": "Id",
          "description": "List item ID of the page."
        },
        "Title": {
          "type": "string",
          "title": "Title",
          "description": "Title of the page."
        },
        "FileRef": {
          "type": "string",
          "title": "File Ref",
          "description": "Server-relative URL path to the page file."
        },
        "FileLeafRef": {
          "type": "string",
          "title": "File Leaf Ref",
          "description": "File name of the page (only returned when querying by page_file_name)."
        },
        "CanvasContent1": {
          "type": "string",
          "title": "Canvas Content1",
          "description": "Main canvas content of the modern page (JSON structure or text/html based on render_as)."
        },
        "LayoutWebpartsContent": {
          "type": "string",
          "title": "Layout Webparts Content",
          "description": "Layout web parts content (JSON structure, only available with render_as='raw')."
        }
      },
      "description": "Response model for modern SharePoint site page content.",
      "additionalProperties": true
    }
  },
  "title": "GetSitePageContentResponseWrapper",
  "required": [
    "data",
    "successful"
  ],
  "properties": {
    "data": {
      "type": "object",
      "title": "Data",
      "properties": {
        "Id": {
          "type": "integer",
          "title": "Id",
          "description": "List item ID of the page."
        },
        "Title": {
          "type": "string",
          "title": "Title",
          "description": "Title of the page."
        },
        "FileRef": {
          "type": "string",
          "title": "File Ref",
          "description": "Server-relative URL path to the page file."
        },
        "FileLeafRef": {
          "type": "string",
          "title": "File Leaf Ref",
          "description": "File name of the page (only returned when querying by page_file_name)."
        },
        "CanvasContent1": {
          "type": "string",
          "title": "Canvas Content1",
          "description": "Main canvas content of the modern page (JSON structure or text/html based on render_as)."
        },
        "LayoutWebpartsContent": {
          "type": "string",
          "title": "Layout Webparts Content",
          "description": "Layout web parts content (JSON structure, only available with render_as='raw')."
        }
      },
      "description": "Data from the action execution",
      "additionalProperties": true
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

## SHARE_POINT_GET_USER_EFFECTIVE_PERMISSIONS_ON_WEB
Get a user's effective permissions on the current SharePoint site (Web). This action retrieves the combined permissions a user has on the site, taking into account direct permissions, group memberships, and permission inheritance. Use this when you need to verify what permissions a user or group has before performing operations. The response contains permission masks as 64-bit integers split into high and low 32-bit values. A value of "0" for both means no permissions. Returns site-level permissions only; list-level or item-level grants and restrictions are not reflected.

**Input schema:**
```json
{
  "type": "object",
  "title": "GetUserEffectivePermissionsOnWebRequest",
  "required": [
    "login_name"
  ],
  "properties": {
    "site_name": {
      "type": "string",
      "title": "Site Name",
      "description": "The subsite name to scope the request to (e.g., 'composio-test'). If omitted, the root site is used. When provided, the API base URL becomes https://{tenant}.sharepoint.com/sites/{site}."
    },
    "login_name": {
      "type": "string",
      "title": "Login Name",
      "examples": [
        "i:0#.f|membership|user@domain.onmicrosoft.com",
        "c:0(.s|true",
        "i:0#.w|nt service\\spsearch"
      ],
      "description": "Claims-based login name of the user or group whose permissions to retrieve. Provide the unencoded login; the action will URL-encode it automatically. Use list_site_users or get_current_user to obtain valid login names."
    }
  },
  "description": "Request model for retrieving effective permissions of a user on the SharePoint web.\n\nlogin_name: Claims-based login name of the user (unencoded).\n            Example: \"i:0#.f|membership|user@domain.onmicrosoft.com\" for regular users,\n                     \"c:0(.s|true\" for security groups,\n                     \"i:0#.w|nt service\\spsearch\" for Windows service accounts."
}
```

**Output schema:**
```json
{
  "type": "object",
  "$defs": {
    "GetUserEffectivePermissionsOnWebResponse": {
      "type": "object",
      "title": "GetUserEffectivePermissionsOnWebResponse",
      "required": [
        "high",
        "low"
      ],
      "properties": {
        "low": {
          "type": "string",
          "title": "Low",
          "description": "Low 32 bits of the 64-bit permission mask as a string integer. Represents permissions at bit positions 0-31. Common permissions like ViewListItems, AddListItems, EditListItems are in the low bits."
        },
        "high": {
          "type": "string",
          "title": "High",
          "description": "High 32 bits of the 64-bit permission mask as a string integer. Represents permissions at bit positions 32-63."
        }
      },
      "description": "Response model containing the user's effective permissions as a 64-bit permission mask.\n\nThe permission mask is represented as two 32-bit integers (high and low) that together\nform a 64-bit bitmask. Each bit position represents a specific SharePoint permission.\nUse bitwise operations to check specific permissions. A value of \"0\" for both high and\nlow indicates no permissions. Non-zero values indicate the user has some permissions."
    }
  },
  "title": "GetUserEffectivePermissionsOnWebResponseWrapper",
  "required": [
    "data",
    "successful"
  ],
  "properties": {
    "data": {
      "type": "object",
      "title": "Data",
      "required": [
        "high",
        "low"
      ],
      "properties": {
        "low": {
          "type": "string",
          "title": "Low",
          "description": "Low 32 bits of the 64-bit permission mask as a string integer. Represents permissions at bit positions 0-31. Common permissions like ViewListItems, AddListItems, EditListItems are in the low bits."
        },
        "high": {
          "type": "string",
          "title": "High",
          "description": "High 32 bits of the 64-bit permission mask as a string integer. Represents permissions at bit positions 32-63."
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

## SHARE_POINT_GET_WEBHOOK_SUBSCRIPTION
Tool to retrieve a specific webhook subscription by ID from a SharePoint list. Use when you need to check subscription details like expiration date or notification URL.

**Input schema:**
```json
{
  "type": "object",
  "title": "GetWebhookSubscriptionRequest",
  "required": [
    "list_id",
    "subscription_id"
  ],
  "properties": {
    "list_id": {
      "type": "string",
      "title": "List Id",
      "examples": [
        "a12e3d6e-9414-462d-bd53-cf06f3982ad3"
      ],
      "description": "GUID of the SharePoint list containing the subscription, in canonical format, e.g., '01234567-89ab-cdef-0123-456789abcdef'."
    },
    "site_name": {
      "type": "string",
      "title": "Site Name",
      "examples": [
        "composio-test"
      ],
      "description": "The subsite name to scope the request to (e.g., 'composio-test'). If omitted, the root site is used. When provided, the API base URL becomes 'https://{tenant}.sharepoint.com/sites/{site}'."
    },
    "subscription_id": {
      "type": "string",
      "title": "Subscription Id",
      "examples": [
        "a8e6d5e6-9f7f-497a-b97f-8ffe8f559dc7"
      ],
      "description": "GUID of the webhook subscription to retrieve, in canonical format, e.g., '01234567-89ab-cdef-0123-456789abcdef'."
    }
  },
  "description": "Request model for retrieving a SharePoint webhook subscription by ID."
}
```

**Output schema:**
```json
{
  "type": "object",
  "$defs": {
    "GetWebhookSubscriptionResponse": {
      "type": "object",
      "title": "GetWebhookSubscriptionResponse",
      "required": [
        "id",
        "expirationDateTime",
        "notificationUrl",
        "resource"
      ],
      "properties": {
        "id": {
          "type": "string",
          "title": "Id",
          "description": "GUID of the webhook subscription."
        },
        "resource": {
          "type": "string",
          "title": "Resource",
          "description": "GUID of the SharePoint list this subscription monitors."
        },
        "clientState": {
          "type": "string",
          "title": "Client State",
          "description": "Optional client-provided state string that is included in notifications for validation purposes."
        },
        "notificationUrl": {
          "type": "string",
          "title": "Notification Url",
          "description": "URL that receives webhook notifications when list changes occur."
        },
        "expirationDateTime": {
          "type": "string",
          "title": "Expiration Date Time",
          "description": "ISO 8601 timestamp when the subscription expires. Maximum validity is 180 days."
        }
      },
      "description": "Response model for a SharePoint webhook subscription."
    }
  },
  "title": "GetWebhookSubscriptionResponseWrapper",
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
        "expirationDateTime",
        "notificationUrl",
        "resource"
      ],
      "properties": {
        "id": {
          "type": "string",
          "title": "Id",
          "description": "GUID of the webhook subscription."
        },
        "resource": {
          "type": "string",
          "title": "Resource",
          "description": "GUID of the SharePoint list this subscription monitors."
        },
        "clientState": {
          "type": "string",
          "title": "Client State",
          "description": "Optional client-provided state string that is included in notifications for validation purposes."
        },
        "notificationUrl": {
          "type": "string",
          "title": "Notification Url",
          "description": "URL that receives webhook notifications when list changes occur."
        },
        "expirationDateTime": {
          "type": "string",
          "title": "Expiration Date Time",
          "description": "ISO 8601 timestamp when the subscription expires. Maximum validity is 180 days."
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

## SHARE_POINT_GET_WEBHOOK_SUBSCRIPTIONS
Tool to retrieve all webhook subscriptions on a SharePoint list. Use when you need to view existing webhook configurations for a list.

**Input schema:**
```json
{
  "type": "object",
  "title": "GetWebhookSubscriptionsRequest",
  "required": [
    "list_id"
  ],
  "properties": {
    "list_id": {
      "type": "string",
      "title": "List Id",
      "examples": [
        "a12e3d6e-9414-462d-bd53-cf06f3982ad3"
      ],
      "description": "The GUID of the SharePoint list to retrieve subscriptions for, in canonical format (e.g., '01234567-89ab-cdef-0123-456789abcdef')."
    },
    "site_name": {
      "type": "string",
      "title": "Site Name",
      "examples": [
        "composio-test",
        "marketing",
        "hr-portal"
      ],
      "description": "The subsite name to scope the request to (e.g., 'composio-test'). If omitted, the root site is used. When provided, the API base URL becomes https://{tenant}.sharepoint.com/sites/{site}."
    }
  },
  "description": "Request model for retrieving webhook subscriptions on a SharePoint list."
}
```

**Output schema:**
```json
{
  "type": "object",
  "$defs": {
    "WebhookSubscription": {
      "type": "object",
      "title": "WebhookSubscription",
      "required": [
        "id",
        "expirationDateTime",
        "notificationUrl",
        "resource"
      ],
      "properties": {
        "id": {
          "type": "string",
          "title": "Id",
          "description": "Unique identifier for the subscription."
        },
        "resource": {
          "type": "string",
          "title": "Resource",
          "description": "Resource identifier (list GUID) that this subscription monitors."
        },
        "clientState": {
          "type": "string",
          "title": "Client State",
          "description": "Optional client state string that is included in webhook notifications for validation."
        },
        "notificationUrl": {
          "type": "string",
          "title": "Notification Url",
          "description": "URL to which webhook notifications are sent."
        },
        "expirationDateTime": {
          "type": "string",
          "title": "Expiration Date Time",
          "description": "Expiration date and time of the subscription in ISO 8601 format."
        }
      },
      "description": "Model for a single webhook subscription."
    },
    "GetWebhookSubscriptionsResponse": {
      "type": "object",
      "title": "GetWebhookSubscriptionsResponse",
      "required": [
        "value"
      ],
      "properties": {
        "value": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "WebhookSubscription",
            "required": [
              "id",
              "expirationDateTime",
              "notificationUrl",
              "resource"
            ],
            "properties": {
              "id": {
                "type": "string",
                "title": "Id",
                "description": "Unique identifier for the subscription."
              },
              "resource": {
                "type": "string",
                "title": "Resource",
                "description": "Resource identifier (list GUID) that this subscription monitors."
              },
              "clientState": {
                "type": "string",
                "title": "Client State",
                "description": "Optional client state string that is included in webhook notifications for validation."
              },
              "notificationUrl": {
                "type": "string",
                "title": "Notification Url",
                "description": "URL to which webhook notifications are sent."
              },
              "expirationDateTime": {
                "type": "string",
                "title": "Expiration Date Time",
                "description": "Expiration date and time of the subscription in ISO 8601 format."
              }
            },
            "description": "Model for a single webhook subscription."
          },
          "title": "Value",
          "description": "Array of webhook subscription objects for the specified list."
        }
      },
      "description": "Response model for webhook subscriptions retrieved from a SharePoint list."
    }
  },
  "title": "GetWebhookSubscriptionsResponseWrapper",
  "required": [
    "data",
    "successful"
  ],
  "properties": {
    "data": {
      "type": "object",
      "title": "Data",
      "required": [
        "value"
      ],
      "properties": {
        "value": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "WebhookSubscription",
            "required": [
              "id",
              "expirationDateTime",
              "notificationUrl",
              "resource"
            ],
            "properties": {
              "id": {
                "type": "string",
                "title": "Id",
                "description": "Unique identifier for the subscription."
              },
              "resource": {
                "type": "string",
                "title": "Resource",
                "description": "Resource identifier (list GUID) that this subscription monitors."
              },
              "clientState": {
                "type": "string",
                "title": "Client State",
                "description": "Optional client state string that is included in webhook notifications for validation."
              },
              "notificationUrl": {
                "type": "string",
                "title": "Notification Url",
                "description": "URL to which webhook notifications are sent."
              },
              "expirationDateTime": {
                "type": "string",
                "title": "Expiration Date Time",
                "description": "Expiration date and time of the subscription in ISO 8601 format."
              }
            },
            "description": "Model for a single webhook subscription."
          },
          "title": "Value",
          "description": "Array of webhook subscription objects for the specified list."
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

## SHARE_POINT_GET_WEB_INFO
Tool to retrieve information about the current SharePoint web (site) using REST API. Use when you need web metadata such as title, URL, language, or template information.

**Input schema:**
```json
{
  "type": "object",
  "title": "GetWebInfoRequest",
  "properties": {
    "expand": {
      "type": "string",
      "title": "Expand",
      "examples": [
        "CurrentUser",
        "Lists,Webs"
      ],
      "description": "OData $expand to expand navigation properties, e.g., 'CurrentUser,Lists,Webs'."
    },
    "select": {
      "type": "string",
      "title": "Select",
      "examples": [
        "Id,Title,Url",
        "Title,Description,Created"
      ],
      "description": "OData $select to specify fields to return, e.g., 'Id,Title,Url,ServerRelativeUrl'."
    },
    "site_name": {
      "type": "string",
      "title": "Site Name",
      "examples": [
        "composio-test",
        "team-site"
      ],
      "description": "The subsite name to scope the request to (e.g., 'composio-test'). If omitted, the root site is used. When provided, the API base URL becomes https://{tenant}.sharepoint.com/sites/{site}."
    }
  },
  "description": "Request parameters for retrieving SharePoint web information.",
  "additionalProperties": false
}
```

**Output schema:**
```json
{
  "type": "object",
  "$defs": {
    "Deferred": {
      "type": "object",
      "title": "Deferred",
      "required": [
        "__deferred"
      ],
      "properties": {
        "__deferred": {
          "type": "object",
          "title": "  Deferred",
          "required": [
            "uri"
          ],
          "properties": {
            "uri": {
              "type": "string",
              "title": "Uri",
              "description": "URI for deferred navigation property"
            }
          },
          "description": "Deferred loading info for navigation property"
        }
      },
      "additionalProperties": true
    },
    "DeferredURI": {
      "type": "object",
      "title": "DeferredURI",
      "required": [
        "uri"
      ],
      "properties": {
        "uri": {
          "type": "string",
          "title": "Uri",
          "description": "URI for deferred navigation property"
        }
      }
    },
    "ExpandedEntity": {
      "type": "object",
      "title": "ExpandedEntity",
      "properties": {},
      "description": "Represents an expanded entity with flexible schema.",
      "additionalProperties": true
    },
    "GetWebInfoResponse": {
      "type": "object",
      "title": "GetWebInfoResponse",
      "properties": {
        "Id": {
          "type": "string",
          "title": "Id",
          "description": "GUID that uniquely identifies the web (site)."
        },
        "Url": {
          "type": "string",
          "title": "Url",
          "description": "Full URL of the web."
        },
        "Webs": {
          "anyOf": [
            {
              "type": "object",
              "title": "Deferred",
              "required": [
                "__deferred"
              ],
              "properties": {
                "__deferred": {
                  "type": "object",
                  "title": "  Deferred",
                  "required": [
                    "uri"
                  ],
                  "properties": {
                    "uri": {
                      "type": "string",
                      "title": "Uri",
                      "description": "URI for deferred navigation property"
                    }
                  },
                  "description": "Deferred loading info for navigation property"
                }
              },
              "additionalProperties": true
            },
            {
              "type": "object",
              "title": "ExpandedEntity",
              "properties": {},
              "description": "Represents an expanded entity with flexible schema.",
              "additionalProperties": true
            }
          ],
          "title": "Webs",
          "description": "Navigation property for child webs. Can be deferred or expanded."
        },
        "Lists": {
          "anyOf": [
            {
              "type": "object",
              "title": "Deferred",
              "required": [
                "__deferred"
              ],
              "properties": {
                "__deferred": {
                  "type": "object",
                  "title": "  Deferred",
                  "required": [
                    "uri"
                  ],
                  "properties": {
                    "uri": {
                      "type": "string",
                      "title": "Uri",
                      "description": "URI for deferred navigation property"
                    }
                  },
                  "description": "Deferred loading info for navigation property"
                }
              },
              "additionalProperties": true
            },
            {
              "type": "object",
              "title": "ExpandedEntity",
              "properties": {},
              "description": "Represents an expanded entity with flexible schema.",
              "additionalProperties": true
            }
          ],
          "title": "Lists",
          "description": "Navigation property for lists in the web. Can be deferred or expanded."
        },
        "Title": {
          "type": "string",
          "title": "Title",
          "description": "Title of the web."
        },
        "Created": {
          "type": "string",
          "title": "Created",
          "description": "ISO 8601 timestamp when the web was created."
        },
        "Language": {
          "type": "integer",
          "title": "Language",
          "description": "Locale ID (LCID) for the language used by the web."
        },
        "MasterUrl": {
          "type": "string",
          "title": "Master Url",
          "description": "Server-relative URL of the master page for the web."
        },
        "ParentWeb": {
          "anyOf": [
            {
              "type": "object",
              "title": "Deferred",
              "required": [
                "__deferred"
              ],
              "properties": {
                "__deferred": {
                  "type": "object",
                  "title": "  Deferred",
                  "required": [
                    "uri"
                  ],
                  "properties": {
                    "uri": {
                      "type": "string",
                      "title": "Uri",
                      "description": "URI for deferred navigation property"
                    }
                  },
                  "description": "Deferred loading info for navigation property"
                }
              },
              "additionalProperties": true
            },
            {
              "type": "object",
              "title": "ExpandedEntity",
              "properties": {},
              "description": "Represents an expanded entity with flexible schema.",
              "additionalProperties": true
            }
          ],
          "title": "Parent Web",
          "description": "Navigation property for parent web. Can be deferred or expanded."
        },
        "SiteUsers": {
          "anyOf": [
            {
              "type": "object",
              "title": "Deferred",
              "required": [
                "__deferred"
              ],
              "properties": {
                "__deferred": {
                  "type": "object",
                  "title": "  Deferred",
                  "required": [
                    "uri"
                  ],
                  "properties": {
                    "uri": {
                      "type": "string",
                      "title": "Uri",
                      "description": "URI for deferred navigation property"
                    }
                  },
                  "description": "Deferred loading info for navigation property"
                }
              },
              "additionalProperties": true
            },
            {
              "type": "object",
              "title": "ExpandedEntity",
              "properties": {},
              "description": "Represents an expanded entity with flexible schema.",
              "additionalProperties": true
            }
          ],
          "title": "Site Users",
          "description": "Navigation property for site users. Can be deferred or expanded."
        },
        "UIVersion": {
          "type": "integer",
          "title": "Ui Version",
          "description": "User interface version number for the web."
        },
        "RootFolder": {
          "anyOf": [
            {
              "type": "object",
              "title": "Deferred",
              "required": [
                "__deferred"
              ],
              "properties": {
                "__deferred": {
                  "type": "object",
                  "title": "  Deferred",
                  "required": [
                    "uri"
                  ],
                  "properties": {
                    "uri": {
                      "type": "string",
                      "title": "Uri",
                      "description": "URI for deferred navigation property"
                    }
                  },
                  "description": "Deferred loading info for navigation property"
                }
              },
              "additionalProperties": true
            },
            {
              "type": "object",
              "title": "ExpandedEntity",
              "properties": {},
              "description": "Represents an expanded entity with flexible schema.",
              "additionalProperties": true
            }
          ],
          "title": "Root Folder",
          "description": "Navigation property for root folder. Can be deferred or expanded."
        },
        "SiteGroups": {
          "anyOf": [
            {
              "type": "object",
              "title": "Deferred",
              "required": [
                "__deferred"
              ],
              "properties": {
                "__deferred": {
                  "type": "object",
                  "title": "  Deferred",
                  "required": [
                    "uri"
                  ],
                  "properties": {
                    "uri": {
                      "type": "string",
                      "title": "Uri",
                      "description": "URI for deferred navigation property"
                    }
                  },
                  "description": "Deferred loading info for navigation property"
                }
              },
              "additionalProperties": true
            },
            {
              "type": "object",
              "title": "ExpandedEntity",
              "properties": {},
              "description": "Represents an expanded entity with flexible schema.",
              "additionalProperties": true
            }
          ],
          "title": "Site Groups",
          "description": "Navigation property for site groups. Can be deferred or expanded."
        },
        "CurrentUser": {
          "anyOf": [
            {
              "type": "object",
              "title": "Deferred",
              "required": [
                "__deferred"
              ],
              "properties": {
                "__deferred": {
                  "type": "object",
                  "title": "  Deferred",
                  "required": [
                    "uri"
                  ],
                  "properties": {
                    "uri": {
                      "type": "string",
                      "title": "Uri",
                      "description": "URI for deferred navigation property"
                    }
                  },
                  "description": "Deferred loading info for navigation property"
                }
              },
              "additionalProperties": true
            },
            {
              "type": "object",
              "title": "ExpandedEntity",
              "properties": {},
              "description": "Represents an expanded entity with flexible schema.",
              "additionalProperties": true
            }
          ],
          "title": "Current User",
          "description": "Navigation property for the current user. Can be deferred or expanded."
        },
        "Description": {
          "type": "string",
          "title": "Description",
          "description": "Description of the web."
        },
        "WebTemplate": {
          "type": "string",
          "title": "Web Template",
          "description": "Name of the site template applied to the web."
        },
        "AllowRssFeeds": {
          "type": "boolean",
          "title": "Allow Rss Feeds",
          "description": "Whether RSS feeds are enabled for the web."
        },
        "Configuration": {
          "type": "integer",
          "title": "Configuration",
          "description": "Configuration number for the site template."
        },
        "WebTemplateId": {
          "type": "integer",
          "title": "Web Template Id",
          "description": "Numeric identifier for the site template."
        },
        "CustomMasterUrl": {
          "type": "string",
          "title": "Custom Master Url",
          "description": "Server-relative URL of the custom master page."
        },
        "TreeViewEnabled": {
          "type": "boolean",
          "title": "Tree View Enabled",
          "description": "Whether the tree view is enabled."
        },
        "RecycleBinEnabled": {
          "type": "boolean",
          "title": "Recycle Bin Enabled",
          "description": "Whether the Recycle Bin is enabled."
        },
        "ServerRelativeUrl": {
          "type": "string",
          "title": "Server Relative Url",
          "description": "Server-relative URL of the web."
        },
        "QuickLaunchEnabled": {
          "type": "boolean",
          "title": "Quick Launch Enabled",
          "description": "Whether Quick Launch is enabled."
        },
        "SyndicationEnabled": {
          "type": "boolean",
          "title": "Syndication Enabled",
          "description": "Whether syndication is enabled."
        },
        "LastItemModifiedDate": {
          "type": "string",
          "title": "Last Item Modified Date",
          "description": "ISO 8601 timestamp when an item in the web was last modified."
        },
        "EnableMinimalDownload": {
          "type": "boolean",
          "title": "Enable Minimal Download",
          "description": "Whether the Minimal Download Strategy feature is enabled."
        },
        "LastItemUserModifiedDate": {
          "type": "string",
          "title": "Last Item User Modified Date",
          "description": "ISO 8601 timestamp when an item in the web was last modified by a user."
        },
        "SaveSiteAsTemplateEnabled": {
          "type": "boolean",
          "title": "Save Site As Template Enabled",
          "description": "Whether saving the site as a template is enabled."
        },
        "UIVersionConfigurationEnabled": {
          "type": "boolean",
          "title": "Ui Version Configuration Enabled",
          "description": "Whether UI version configuration is enabled."
        }
      },
      "description": "Response model representing SP.Web metadata.",
      "additionalProperties": true
    }
  },
  "title": "GetWebInfoResponseWrapper",
  "required": [
    "data",
    "successful"
  ],
  "properties": {
    "data": {
      "type": "object",
      "title": "Data",
      "properties": {
        "Id": {
          "type": "string",
          "title": "Id",
          "description": "GUID that uniquely identifies the web (site)."
        },
        "Url": {
          "type": "string",
          "title": "Url",
          "description": "Full URL of the web."
        },
        "Webs": {
          "anyOf": [
            {
              "type": "object",
              "title": "Deferred",
              "required": [
                "__deferred"
              ],
              "properties": {
                "__deferred": {
                  "type": "object",
                  "title": "  Deferred",
                  "required": [
                    "uri"
                  ],
                  "properties": {
                    "uri": {
                      "type": "string",
                      "title": "Uri",
                      "description": "URI for deferred navigation property"
                    }
                  },
                  "description": "Deferred loading info for navigation property"
                }
              },
              "additionalProperties": true
            },
            {
              "type": "object",
              "title": "ExpandedEntity",
              "properties": {},
              "description": "Represents an expanded entity with flexible schema.",
              "additionalProperties": true
            }
          ],
          "title": "Webs",
          "description": "Navigation property for child webs. Can be deferred or expanded."
        },
        "Lists": {
          "anyOf": [
            {
              "type": "object",
              "title": "Deferred",
              "required": [
                "__deferred"
              ],
              "properties": {
                "__deferred": {
                  "type": "object",
                  "title": "  Deferred",
                  "required": [
                    "uri"
                  ],
                  "properties": {
                    "uri": {
                      "type": "string",
                      "title": "Uri",
                      "description": "URI for deferred navigation property"
                    }
                  },
                  "description": "Deferred loading info for navigation property"
                }
              },
              "additionalProperties": true
            },
            {
              "type": "object",
              "title": "ExpandedEntity",
              "properties": {},
              "description": "Represents an expanded entity with flexible schema.",
              "additionalProperties": true
            }
          ],
          "title": "Lists",
          "description": "Navigation property for lists in the web. Can be deferred or expanded."
        },
        "Title": {
          "type": "string",
          "title": "Title",
          "description": "Title of the web."
        },
        "Created": {
          "type": "string",
          "title": "Created",
          "description": "ISO 8601 timestamp when the web was created."
        },
        "Language": {
          "type": "integer",
          "title": "Language",
          "description": "Locale ID (LCID) for the language used by the web."
        },
        "MasterUrl": {
          "type": "string",
          "title": "Master Url",
          "description": "Server-relative URL of the master page for the web."
        },
        "ParentWeb": {
          "anyOf": [
            {
              "type": "object",
              "title": "Deferred",
              "required": [
                "__deferred"
              ],
              "properties": {
                "__deferred": {
                  "type": "object",
                  "title": "  Deferred",
                  "required": [
                    "uri"
                  ],
                  "properties": {
                    "uri": {
                      "type": "string",
                      "title": "Uri",
                      "description": "URI for deferred navigation property"
                    }
                  },
                  "description": "Deferred loading info for navigation property"
                }
              },
              "additionalProperties": true
            },
            {
              "type": "object",
              "title": "ExpandedEntity",
              "properties": {},
              "description": "Represents an expanded entity with flexible schema.",
              "additionalProperties": true
            }
          ],
          "title": "Parent Web",
          "description": "Navigation property for parent web. Can be deferred or expanded."
        },
        "SiteUsers": {
          "anyOf": [
            {
              "type": "object",
              "title": "Deferred",
              "required": [
                "__deferred"
              ],
              "properties": {
                "__deferred": {
                  "type": "object",
                  "title": "  Deferred",
                  "required": [
                    "uri"
                  ],
                  "properties": {
                    "uri": {
                      "type": "string",
                      "title": "Uri",
                      "description": "URI for deferred navigation property"
                    }
                  },
                  "description": "Deferred loading info for navigation property"
                }
              },
              "additionalProperties": true
            },
            {
              "type": "object",
              "title": "ExpandedEntity",
              "properties": {},
              "description": "Represents an expanded entity with flexible schema.",
              "additionalProperties": true
            }
          ],
          "title": "Site Users",
          "description": "Navigation property for site users. Can be deferred or expanded."
        },
        "UIVersion": {
          "type": "integer",
          "title": "Ui Version",
          "description": "User interface version number for the web."
        },
        "RootFolder": {
          "anyOf": [
            {
              "type": "object",
              "title": "Deferred",
              "required": [
                "__deferred"
              ],
              "properties": {
                "__deferred": {
                  "type": "object",
                  "title": "  Deferred",
                  "required": [
                    "uri"
                  ],
                  "properties": {
                    "uri": {
                      "type": "string",
                      "title": "Uri",
                      "description": "URI for deferred navigation property"
                    }
                  },
                  "description": "Deferred loading info for navigation property"
                }
              },
              "additionalProperties": true
            },
            {
              "type": "object",
              "title": "ExpandedEntity",
              "properties": {},
              "description": "Represents an expanded entity with flexible schema.",
              "additionalProperties": true
            }
          ],
          "title": "Root Folder",
          "description": "Navigation property for root folder. Can be deferred or expanded."
        },
        "SiteGroups": {
          "anyOf": [
            {
              "type": "object",
              "title": "Deferred",
              "required": [
                "__deferred"
              ],
              "properties": {
                "__deferred": {
                  "type": "object",
                  "title": "  Deferred",
                  "required": [
                    "uri"
                  ],
                  "properties": {
                    "uri": {
                      "type": "string",
                      "title": "Uri",
                      "description": "URI for deferred navigation property"
                    }
                  },
                  "description": "Deferred loading info for navigation property"
                }
              },
              "additionalProperties": true
            },
            {
              "type": "object",
              "title": "ExpandedEntity",
              "properties": {},
              "description": "Represents an expanded entity with flexible schema.",
              "additionalProperties": true
            }
          ],
          "title": "Site Groups",
          "description": "Navigation property for site groups. Can be deferred or expanded."
        },
        "CurrentUser": {
          "anyOf": [
            {
              "type": "object",
              "title": "Deferred",
              "required": [
                "__deferred"
              ],
              "properties": {
                "__deferred": {
                  "type": "object",
                  "title": "  Deferred",
                  "required": [
                    "uri"
                  ],
                  "properties": {
                    "uri": {
                      "type": "string",
                      "title": "Uri",
                      "description": "URI for deferred navigation property"
                    }
                  },
                  "description": "Deferred loading info for navigation property"
                }
              },
              "additionalProperties": true
            },
            {
              "type": "object",
              "title": "ExpandedEntity",
              "properties": {},
              "description": "Represents an expanded entity with flexible schema.",
              "additionalProperties": true
            }
          ],
          "title": "Current User",
          "description": "Navigation property for the current user. Can be deferred or expanded."
        },
        "Description": {
          "type": "string",
          "title": "Description",
          "description": "Description of the web."
        },
        "WebTemplate": {
          "type": "string",
          "title": "Web Template",
          "description": "Name of the site template applied to the web."
        },
        "AllowRssFeeds": {
          "type": "boolean",
          "title": "Allow Rss Feeds",
          "description": "Whether RSS feeds are enabled for the web."
        },
        "Configuration": {
          "type": "integer",
          "title": "Configuration",
          "description": "Configuration number for the site template."
        },
        "WebTemplateId": {
          "type": "integer",
          "title": "Web Template Id",
          "description": "Numeric identifier for the site template."
        },
        "CustomMasterUrl": {
          "type": "string",
          "title": "Custom Master Url",
          "description": "Server-relative URL of the custom master page."
        },
        "TreeViewEnabled": {
          "type": "boolean",
          "title": "Tree View Enabled",
          "description": "Whether the tree view is enabled."
        },
        "RecycleBinEnabled": {
          "type": "boolean",
          "title": "Recycle Bin Enabled",
          "description": "Whether the Recycle Bin is enabled."
        },
        "ServerRelativeUrl": {
          "type": "string",
          "title": "Server Relative Url",
          "description": "Server-relative URL of the web."
        },
        "QuickLaunchEnabled": {
          "type": "boolean",
          "title": "Quick Launch Enabled",
          "description": "Whether Quick Launch is enabled."
        },
        "SyndicationEnabled": {
          "type": "boolean",
          "title": "Syndication Enabled",
          "description": "Whether syndication is enabled."
        },
        "LastItemModifiedDate": {
          "type": "string",
          "title": "Last Item Modified Date",
          "description": "ISO 8601 timestamp when an item in the web was last modified."
        },
        "EnableMinimalDownload": {
          "type": "boolean",
          "title": "Enable Minimal Download",
          "description": "Whether the Minimal Download Strategy feature is enabled."
        },
        "LastItemUserModifiedDate": {
          "type": "string",
          "title": "Last Item User Modified Date",
          "description": "ISO 8601 timestamp when an item in the web was last modified by a user."
        },
        "SaveSiteAsTemplateEnabled": {
          "type": "boolean",
          "title": "Save Site As Template Enabled",
          "description": "Whether saving the site as a template is enabled."
        },
        "UIVersionConfigurationEnabled": {
          "type": "boolean",
          "title": "Ui Version Configuration Enabled",
          "description": "Whether UI version configuration is enabled."
        }
      },
      "description": "Data from the action execution",
      "additionalProperties": true
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

## SHARE_POINT_IS_FOLLOWED
Tool to check if the current user is following a specified actor. Use when verifying follow status before performing follow or unfollow operations.

**Input schema:**
```json
{
  "type": "object",
  "title": "IsFollowedRequest",
  "required": [
    "actor_type"
  ],
  "properties": {
    "tag_guid": {
      "type": "string",
      "title": "Tag Guid",
      "format": "uuid",
      "description": "GUID of the tag when actor_type=3."
    },
    "site_name": {
      "type": "string",
      "title": "Site Name",
      "description": "The subsite name to scope the request to (e.g., 'composio-test'). If omitted, the root site is used. When provided, the API base URL becomes 'https://{tenant}.sharepoint.com/sites/{site}'."
    },
    "actor_type": {
      "enum": [
        0,
        1,
        2,
        3
      ],
      "type": "integer",
      "title": "Actor Type",
      "examples": [
        0,
        1,
        2,
        3
      ],
      "description": "Type of the actor to check: 0=user, 1=document, 2=site, 3=tag."
    },
    "content_uri": {
      "type": "string",
      "title": "Content Uri",
      "description": "URI of the document or site when actor_type=1 or 2, e.g., 'http://server/site'."
    },
    "account_name": {
      "type": "string",
      "title": "Account Name",
      "description": "Account name for a user when actor_type=0, in claims format, e.g., 'i:0#.f|membership|user@domain.com'."
    }
  },
  "description": "Request parameters to check if the current user follows a SharePoint actor.",
  "additionalProperties": false
}
```

**Output schema:**
```json
{
  "type": "object",
  "$defs": {
    "IsFollowedResponse": {
      "type": "object",
      "title": "IsFollowedResponse",
      "required": [
        "is_followed"
      ],
      "properties": {
        "is_followed": {
          "type": "boolean",
          "title": "Is Followed",
          "description": "True if the current user follows the specified actor."
        }
      }
    }
  },
  "title": "IsFollowedResponseWrapper",
  "required": [
    "data",
    "successful"
  ],
  "properties": {
    "data": {
      "type": "object",
      "title": "Data",
      "required": [
        "is_followed"
      ],
      "properties": {
        "is_followed": {
          "type": "boolean",
          "title": "Is Followed",
          "description": "True if the current user follows the specified actor."
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

## SHARE_POINT_LIST_ALL_LISTS
Retrieves all lists in the current SharePoint web/site. Use this action to discover available lists and document libraries on a SharePoint site, or to pre-check for existing lists before creation (duplicate list names will fail). Returns metadata for each list including Title, Id, BaseType, ItemCount, and other properties. Supports OData query parameters for filtering, selecting specific fields, sorting, and pagination.

**Input schema:**
```json
{
  "type": "object",
  "title": "ListAllListsRequest",
  "properties": {
    "top": {
      "type": "integer",
      "title": "Top",
      "minimum": 1,
      "examples": [
        10
      ],
      "description": "OData $top to limit the number of results."
    },
    "expand": {
      "type": "string",
      "title": "Expand",
      "examples": [
        "Fields"
      ],
      "description": "OData $expand to include related entities."
    },
    "filter": {
      "type": "string",
      "title": "Filter",
      "examples": [
        "Hidden eq false"
      ],
      "description": "OData $filter to narrow results."
    },
    "select": {
      "type": "string",
      "title": "Select",
      "examples": [
        "Title,Id"
      ],
      "description": "OData $select to specify which list fields to return, e.g., 'Title,Id'."
    },
    "orderby": {
      "type": "string",
      "title": "Orderby",
      "examples": [
        "Title desc"
      ],
      "description": "OData $orderby to sort results, e.g., 'Title desc'."
    },
    "site_name": {
      "type": "string",
      "title": "Site Name",
      "examples": [
        "composio-test"
      ],
      "description": "The subsite name to scope the request to (e.g., 'composio-test'). If omitted, the root site is used. When provided, the API base URL becomes https://{tenant}.sharepoint.com/sites/{site}."
    },
    "skiptoken": {
      "type": "string",
      "title": "Skiptoken",
      "examples": [
        "Paged=TRUE&p_ID=15"
      ],
      "description": "OData $skiptoken for paging through results. The token value is returned in the previous response when more results exist; pass it unchanged to retrieve the next page."
    }
  },
  "description": "Optional OData query parameters for listing all SharePoint lists.",
  "additionalProperties": false
}
```

**Output schema:**
```json
{
  "type": "object",
  "$defs": {
    "ListAllListsResponse": {
      "type": "object",
      "title": "ListAllListsResponse",
      "required": [
        "lists"
      ],
      "properties": {
        "lists": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "SharePointListMetadata",
            "required": [
              "Title"
            ],
            "properties": {
              "Id": {
                "type": "string",
                "title": "Id",
                "description": "The unique GUID identifier of the list. Only returned when 'Id' is included in the $select parameter or when no $select is specified."
              },
              "Title": {
                "type": "string",
                "title": "Title",
                "description": "The display title of the list."
              },
              "Hidden": {
                "type": "boolean",
                "title": "Hidden",
                "description": "Whether the list is hidden."
              },
              "Created": {
                "type": "string",
                "title": "Created",
                "description": "ISO 8601 timestamp when the list was created."
              },
              "BaseType": {
                "type": "integer",
                "title": "Base Type",
                "description": "The base type of the list (0=GenericList, 1=DocumentLibrary)."
              },
              "ItemCount": {
                "type": "integer",
                "title": "Item Count",
                "description": "Number of items in the list."
              },
              "Description": {
                "type": "string",
                "title": "Description",
                "description": "The description of the list."
              }
            },
            "description": "SharePoint list metadata and properties.",
            "additionalProperties": true
          },
          "title": "Lists",
          "description": "Array of SharePoint list objects with metadata. Each list includes Title, Id, and other properties based on the $select parameter used."
        }
      },
      "description": "Response model for listing all SharePoint lists."
    },
    "SharePointListMetadata": {
      "type": "object",
      "title": "SharePointListMetadata",
      "required": [
        "Title"
      ],
      "properties": {
        "Id": {
          "type": "string",
          "title": "Id",
          "description": "The unique GUID identifier of the list. Only returned when 'Id' is included in the $select parameter or when no $select is specified."
        },
        "Title": {
          "type": "string",
          "title": "Title",
          "description": "The display title of the list."
        },
        "Hidden": {
          "type": "boolean",
          "title": "Hidden",
          "description": "Whether the list is hidden."
        },
        "Created": {
          "type": "string",
          "title": "Created",
          "description": "ISO 8601 timestamp when the list was created."
        },
        "BaseType": {
          "type": "integer",
          "title": "Base Type",
          "description": "The base type of the list (0=GenericList, 1=DocumentLibrary)."
        },
        "ItemCount": {
          "type": "integer",
          "title": "Item Count",
          "description": "Number of items in the list."
        },
        "Description": {
          "type": "string",
          "title": "Description",
          "description": "The description of the list."
        }
      },
      "description": "SharePoint list metadata and properties.",
      "additionalProperties": true
    }
  },
  "title": "ListAllListsResponseWrapper",
  "required": [
    "data",
    "successful"
  ],
  "properties": {
    "data": {
      "type": "object",
      "title": "Data",
      "required": [
        "lists"
      ],
      "properties": {
        "lists": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "SharePointListMetadata",
            "required": [
              "Title"
            ],
            "properties": {
              "Id": {
                "type": "string",
                "title": "Id",
                "description": "The unique GUID identifier of the list. Only returned when 'Id' is included in the $select parameter or when no $select is specified."
              },
              "Title": {
                "type": "string",
                "title": "Title",
                "description": "The display title of the list."
              },
              "Hidden": {
                "type": "boolean",
                "title": "Hidden",
                "description": "Whether the list is hidden."
              },
              "Created": {
                "type": "string",
                "title": "Created",
                "description": "ISO 8601 timestamp when the list was created."
              },
              "BaseType": {
                "type": "integer",
                "title": "Base Type",
                "description": "The base type of the list (0=GenericList, 1=DocumentLibrary)."
              },
              "ItemCount": {
                "type": "integer",
                "title": "Item Count",
                "description": "Number of items in the list."
              },
              "Description": {
                "type": "string",
                "title": "Description",
                "description": "The description of the list."
              }
            },
            "description": "SharePoint list metadata and properties.",
            "additionalProperties": true
          },
          "title": "Lists",
          "description": "Array of SharePoint list objects with metadata. Each list includes Title, Id, and other properties based on the $select parameter used."
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

## SHARE_POINT_LIST_DRIVE_CHILDREN
Tool to list children (files and folders) in a SharePoint drive using REST API v2.0. Use when you need to enumerate items in a drive's root folder or a specific folder within the drive.

**Input schema:**
```json
{
  "type": "object",
  "title": "ListDriveChildrenRequest",
  "required": [
    "drive_id"
  ],
  "properties": {
    "top": {
      "type": "integer",
      "title": "Top",
      "default": 200,
      "minimum": 1,
      "examples": [
        200,
        100
      ],
      "description": "Number of items to return (OData $top parameter). Default is 200."
    },
    "filter": {
      "type": "string",
      "title": "Filter",
      "examples": [
        "folder ne null",
        "file ne null"
      ],
      "description": "OData filter expression. Common values: 'folder ne null' (only folders), 'file ne null' (only files), or custom filters like \"name eq 'document.pdf'\"."
    },
    "select": {
      "type": "string",
      "title": "Select",
      "examples": [
        "id,name,size,folder,file,webUrl"
      ],
      "description": "Comma-separated properties to return (e.g., 'id,name,size,folder,file,webUrl')."
    },
    "orderby": {
      "type": "string",
      "title": "Orderby",
      "examples": [
        "name asc",
        "lastModifiedDateTime desc"
      ],
      "description": "OData orderby expression (e.g., 'name asc', 'lastModifiedDateTime desc')."
    },
    "drive_id": {
      "type": "string",
      "title": "Drive Id",
      "examples": [
        "b!-RIj2DuyvEyV1T4NlOaMHk8XkS_I8MdFlUCq1BlcjgmhRfAj3-Z8RY2VpuvV_tpd"
      ],
      "description": "The unique identifier of the drive. This is the drive ID (GUID) that identifies a specific document library or OneDrive."
    },
    "folder_id": {
      "type": "string",
      "title": "Folder Id",
      "examples": [
        "01BYE5RZ6QN3ZWBTUFOFD3GSPGOHDJD36K"
      ],
      "description": "The unique identifier of a specific folder within the drive. If not provided, lists root folder children."
    }
  },
  "description": "Request parameters for listing children in a SharePoint drive.",
  "additionalProperties": false
}
```

**Output schema:**
```json
{
  "type": "object",
  "$defs": {
    "Identity": {
      "type": "object",
      "title": "Identity",
      "properties": {
        "id": {
          "type": "string",
          "title": "Id",
          "description": "Unique identifier"
        },
        "displayName": {
          "type": "string",
          "title": "Display Name",
          "description": "Display name"
        }
      },
      "description": "Identity information for a user, application, or device.",
      "additionalProperties": true
    },
    "DriveItem": {
      "type": "object",
      "title": "DriveItem",
      "properties": {
        "id": {
          "type": "string",
          "title": "Id",
          "description": "Unique identifier of the item within the drive"
        },
        "cTag": {
          "type": "string",
          "title": "C Tag",
          "description": "ETag for the content of the item"
        },
        "eTag": {
          "type": "string",
          "title": "E Tag",
          "description": "ETag for the entire item (metadata + content)"
        },
        "file": {
          "type": "object",
          "title": "File",
          "properties": {
            "hashes": {
              "type": "object",
              "title": "Hashes",
              "description": "Hashes of the file content",
              "additionalProperties": {
                "type": "string"
              }
            },
            "mimeType": {
              "type": "string",
              "title": "Mime Type",
              "description": "MIME type of the file"
            }
          },
          "description": "File metadata, if the item is a file",
          "additionalProperties": true
        },
        "name": {
          "type": "string",
          "title": "Name",
          "description": "Name of the item (filename and extension)"
        },
        "size": {
          "type": "integer",
          "title": "Size",
          "description": "Size of the item in bytes"
        },
        "folder": {
          "type": "object",
          "title": "Folder",
          "properties": {
            "childCount": {
              "type": "integer",
              "title": "Child Count",
              "description": "Number of children in the folder"
            }
          },
          "description": "Folder metadata, if the item is a folder",
          "additionalProperties": true
        },
        "webUrl": {
          "type": "string",
          "title": "Web Url",
          "description": "URL that displays the resource in the browser"
        },
        "createdBy": {
          "type": "object",
          "title": "Created By",
          "properties": {
            "user": {
              "type": "object",
              "title": "User",
              "properties": {
                "id": {
                  "type": "string",
                  "title": "Id",
                  "description": "Unique identifier"
                },
                "displayName": {
                  "type": "string",
                  "title": "Display Name",
                  "description": "Display name"
                }
              },
              "description": "User identity information",
              "additionalProperties": true
            },
            "device": {
              "type": "object",
              "title": "Device",
              "properties": {
                "id": {
                  "type": "string",
                  "title": "Id",
                  "description": "Unique identifier"
                },
                "displayName": {
                  "type": "string",
                  "title": "Display Name",
                  "description": "Display name"
                }
              },
              "description": "Device identity information",
              "additionalProperties": true
            },
            "application": {
              "type": "object",
              "title": "Application",
              "properties": {
                "id": {
                  "type": "string",
                  "title": "Id",
                  "description": "Unique identifier"
                },
                "displayName": {
                  "type": "string",
                  "title": "Display Name",
                  "description": "Display name"
                }
              },
              "description": "Application identity information",
              "additionalProperties": true
            }
          },
          "description": "Identity of the user, device, and application that created the item",
          "additionalProperties": true
        },
        "fileSystemInfo": {
          "type": "object",
          "title": "File System Info",
          "properties": {
            "createdDateTime": {
              "type": "string",
              "title": "Created Date Time",
              "description": "Date and time the item was created (ISO 8601)"
            },
            "lastAccessedDateTime": {
              "type": "string",
              "title": "Last Accessed Date Time",
              "description": "Date and time the item was last accessed (ISO 8601)"
            },
            "lastModifiedDateTime": {
              "type": "string",
              "title": "Last Modified Date Time",
              "description": "Date and time the item was last modified (ISO 8601)"
            }
          },
          "description": "File system information on client",
          "additionalProperties": true
        },
        "lastModifiedBy": {
          "type": "object",
          "title": "Last Modified By",
          "properties": {
            "user": {
              "type": "object",
              "title": "User",
              "properties": {
                "id": {
                  "type": "string",
                  "title": "Id",
                  "description": "Unique identifier"
                },
                "displayName": {
                  "type": "string",
                  "title": "Display Name",
                  "description": "Display name"
                }
              },
              "description": "User identity information",
              "additionalProperties": true
            },
            "device": {
              "type": "object",
              "title": "Device",
              "properties": {
                "id": {
                  "type": "string",
                  "title": "Id",
                  "description": "Unique identifier"
                },
                "displayName": {
                  "type": "string",
                  "title": "Display Name",
                  "description": "Display name"
                }
              },
              "description": "Device identity information",
              "additionalProperties": true
            },
            "application": {
              "type": "object",
              "title": "Application",
              "properties": {
                "id": {
                  "type": "string",
                  "title": "Id",
                  "description": "Unique identifier"
                },
                "displayName": {
                  "type": "string",
                  "title": "Display Name",
                  "description": "Display name"
                }
              },
              "description": "Application identity information",
              "additionalProperties": true
            }
          },
          "description": "Identity of the user, device, and application that last modified the item",
          "additionalProperties": true
        },
        "createdDateTime": {
          "type": "string",
          "title": "Created Date Time",
          "description": "Date and time of item creation (ISO 8601)"
        },
        "parentReference": {
          "type": "object",
          "title": "Parent Reference",
          "properties": {
            "id": {
              "type": "string",
              "title": "Id",
              "description": "Identifier of the item"
            },
            "name": {
              "type": "string",
              "title": "Name",
              "description": "Name of the item"
            },
            "path": {
              "type": "string",
              "title": "Path",
              "description": "Path to the item"
            },
            "siteId": {
              "type": "string",
              "title": "Site Id",
              "description": "Identifier of the site"
            },
            "driveId": {
              "type": "string",
              "title": "Drive Id",
              "description": "Identifier of the drive"
            }
          },
          "description": "Parent information, if the item has a parent",
          "additionalProperties": true
        },
        "lastModifiedDateTime": {
          "type": "string",
          "title": "Last Modified Date Time",
          "description": "Date and time the item was last modified (ISO 8601)"
        }
      },
      "description": "Drive item representing a file or folder.",
      "additionalProperties": true
    },
    "FileFacet": {
      "type": "object",
      "title": "FileFacet",
      "properties": {
        "hashes": {
          "type": "object",
          "title": "Hashes",
          "description": "Hashes of the file content",
          "additionalProperties": {
            "type": "string"
          }
        },
        "mimeType": {
          "type": "string",
          "title": "Mime Type",
          "description": "MIME type of the file"
        }
      },
      "description": "File facet indicating the item is a file.",
      "additionalProperties": true
    },
    "FolderFacet": {
      "type": "object",
      "title": "FolderFacet",
      "properties": {
        "childCount": {
          "type": "integer",
          "title": "Child Count",
          "description": "Number of children in the folder"
        }
      },
      "description": "Folder facet indicating the item is a folder.",
      "additionalProperties": true
    },
    "IdentitySet": {
      "type": "object",
      "title": "IdentitySet",
      "properties": {
        "user": {
          "type": "object",
          "title": "User",
          "properties": {
            "id": {
              "type": "string",
              "title": "Id",
              "description": "Unique identifier"
            },
            "displayName": {
              "type": "string",
              "title": "Display Name",
              "description": "Display name"
            }
          },
          "description": "User identity information",
          "additionalProperties": true
        },
        "device": {
          "type": "object",
          "title": "Device",
          "properties": {
            "id": {
              "type": "string",
              "title": "Id",
              "description": "Unique identifier"
            },
            "displayName": {
              "type": "string",
              "title": "Display Name",
              "description": "Display name"
            }
          },
          "description": "Device identity information",
          "additionalProperties": true
        },
        "application": {
          "type": "object",
          "title": "Application",
          "properties": {
            "id": {
              "type": "string",
              "title": "Id",
              "description": "Unique identifier"
            },
            "displayName": {
              "type": "string",
              "title": "Display Name",
              "description": "Display name"
            }
          },
          "description": "Application identity information",
          "additionalProperties": true
        }
      },
      "description": "Identity information about who created or modified an item.",
      "additionalProperties": true
    },
    "ItemReference": {
      "type": "object",
      "title": "ItemReference",
      "properties": {
        "id": {
          "type": "string",
          "title": "Id",
          "description": "Identifier of the item"
        },
        "name": {
          "type": "string",
          "title": "Name",
          "description": "Name of the item"
        },
        "path": {
          "type": "string",
          "title": "Path",
          "description": "Path to the item"
        },
        "siteId": {
          "type": "string",
          "title": "Site Id",
          "description": "Identifier of the site"
        },
        "driveId": {
          "type": "string",
          "title": "Drive Id",
          "description": "Identifier of the drive"
        }
      },
      "description": "Reference to a parent item or drive.",
      "additionalProperties": true
    },
    "FileSystemInfo": {
      "type": "object",
      "title": "FileSystemInfo",
      "properties": {
        "createdDateTime": {
          "type": "string",
          "title": "Created Date Time",
          "description": "Date and time the item was created (ISO 8601)"
        },
        "lastAccessedDateTime": {
          "type": "string",
          "title": "Last Accessed Date Time",
          "description": "Date and time the item was last accessed (ISO 8601)"
        },
        "lastModifiedDateTime": {
          "type": "string",
          "title": "Last Modified Date Time",
          "description": "Date and time the item was last modified (ISO 8601)"
        }
      },
      "description": "File system metadata.",
      "additionalProperties": true
    },
    "ListDriveChildrenResponse": {
      "type": "object",
      "title": "ListDriveChildrenResponse",
      "required": [
        "value"
      ],
      "properties": {
        "value": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "DriveItem",
            "properties": {
              "id": {
                "type": "string",
                "title": "Id",
                "description": "Unique identifier of the item within the drive"
              },
              "cTag": {
                "type": "string",
                "title": "C Tag",
                "description": "ETag for the content of the item"
              },
              "eTag": {
                "type": "string",
                "title": "E Tag",
                "description": "ETag for the entire item (metadata + content)"
              },
              "file": {
                "type": "object",
                "title": "File",
                "properties": {
                  "hashes": {
                    "type": "object",
                    "title": "Hashes",
                    "description": "Hashes of the file content",
                    "additionalProperties": {
                      "type": "string"
                    }
                  },
                  "mimeType": {
                    "type": "string",
                    "title": "Mime Type",
                    "description": "MIME type of the file"
                  }
                },
                "description": "File metadata, if the item is a file",
                "additionalProperties": true
              },
              "name": {
                "type": "string",
                "title": "Name",
                "description": "Name of the item (filename and extension)"
              },
              "size": {
                "type": "integer",
                "title": "Size",
                "description": "Size of the item in bytes"
              },
              "folder": {
                "type": "object",
                "title": "Folder",
                "properties": {
                  "childCount": {
                    "type": "integer",
                    "title": "Child Count",
                    "description": "Number of children in the folder"
                  }
                },
                "description": "Folder metadata, if the item is a folder",
                "additionalProperties": true
              },
              "webUrl": {
                "type": "string",
                "title": "Web Url",
                "description": "URL that displays the resource in the browser"
              },
              "createdBy": {
                "type": "object",
                "title": "Created By",
                "properties": {
                  "user": {
                    "type": "object",
                    "title": "User",
                    "properties": {
                      "id": {
                        "type": "string",
                        "title": "Id",
                        "description": "Unique identifier"
                      },
                      "displayName": {
                        "type": "string",
                        "title": "Display Name",
                        "description": "Display name"
                      }
                    },
                    "description": "User identity information",
                    "additionalProperties": true
                  },
                  "device": {
                    "type": "object",
                    "title": "Device",
                    "properties": {
                      "id": {
                        "type": "string",
                        "title": "Id",
                        "description": "Unique identifier"
                      },
                      "displayName": {
                        "type": "string",
                        "title": "Display Name",
                        "description": "Display name"
                      }
                    },
                    "description": "Device identity information",
                    "additionalProperties": true
                  },
                  "application": {
                    "type": "object",
                    "title": "Application",
                    "properties": {
                      "id": {
                        "type": "string",
                        "title": "Id",
                        "description": "Unique identifier"
                      },
                      "displayName": {
                        "type": "string",
                        "title": "Display Name",
                        "description": "Display name"
                      }
                    },
                    "description": "Application identity information",
                    "additionalProperties": true
                  }
                },
                "description": "Identity of the user, device, and application that created the item",
                "additionalProperties": true
              },
              "fileSystemInfo": {
                "type": "object",
                "title": "File System Info",
                "properties": {
                  "createdDateTime": {
                    "type": "string",
                    "title": "Created Date Time",
                    "description": "Date and time the item was created (ISO 8601)"
                  },
                  "lastAccessedDateTime": {
                    "type": "string",
                    "title": "Last Accessed Date Time",
                    "description": "Date and time the item was last accessed (ISO 8601)"
                  },
                  "lastModifiedDateTime": {
                    "type": "string",
                    "title": "Last Modified Date Time",
                    "description": "Date and time the item was last modified (ISO 8601)"
                  }
                },
                "description": "File system information on client",
                "additionalProperties": true
              },
              "lastModifiedBy": {
                "type": "object",
                "title": "Last Modified By",
                "properties": {
                  "user": {
                    "type": "object",
                    "title": "User",
                    "properties": {
                      "id": {
                        "type": "string",
                        "title": "Id",
                        "description": "Unique identifier"
                      },
                      "displayName": {
                        "type": "string",
                        "title": "Display Name",
                        "description": "Display name"
                      }
                    },
                    "description": "User identity information",
                    "additionalProperties": true
                  },
                  "device": {
                    "type": "object",
                    "title": "Device",
                    "properties": {
                      "id": {
                        "type": "string",
                        "title": "Id",
                        "description": "Unique identifier"
                      },
                      "displayName": {
                        "type": "string",
                        "title": "Display Name",
                        "description": "Display name"
                      }
                    },
                    "description": "Device identity information",
                    "additionalProperties": true
                  },
                  "application": {
                    "type": "object",
                    "title": "Application",
                    "properties": {
                      "id": {
                        "type": "string",
                        "title": "Id",
                        "description": "Unique identifier"
                      },
                      "displayName": {
                        "type": "string",
                        "title": "Display Name",
                        "description": "Display name"
                      }
                    },
                    "description": "Application identity information",
                    "additionalProperties": true
                  }
                },
                "description": "Identity of the user, device, and application that last modified the item",
                "additionalProperties": true
              },
              "createdDateTime": {
                "type": "string",
                "title": "Created Date Time",
                "description": "Date and time of item creation (ISO 8601)"
              },
              "parentReference": {
                "type": "object",
                "title": "Parent Reference",
                "properties": {
                  "id": {
                    "type": "string",
                    "title": "Id",
                    "description": "Identifier of the item"
                  },
                  "name": {
                    "type": "string",
                    "title": "Name",
                    "description": "Name of the item"
                  },
                  "path": {
                    "type": "string",
                    "title": "Path",
                    "description": "Path to the item"
                  },
                  "siteId": {
                    "type": "string",
                    "title": "Site Id",
                    "description": "Identifier of the site"
                  },
                  "driveId": {
                    "type": "string",
                    "title": "Drive Id",
                    "description": "Identifier of the drive"
                  }
                },
                "description": "Parent information, if the item has a parent",
                "additionalProperties": true
              },
              "lastModifiedDateTime": {
                "type": "string",
                "title": "Last Modified Date Time",
                "description": "Date and time the item was last modified (ISO 8601)"
              }
            },
            "description": "Drive item representing a file or folder.",
            "additionalProperties": true
          },
          "title": "Value",
          "description": "Array of drive items (files and folders) in the specified drive or folder."
        },
        "@odata.nextLink": {
          "type": "string",
          "title": "@Odata.Next Link",
          "description": "URL for the next page of results if pagination is needed."
        }
      },
      "description": "Response model containing children of a drive or folder.",
      "additionalProperties": true
    }
  },
  "title": "ListDriveChildrenResponseWrapper",
  "required": [
    "data",
    "successful"
  ],
  "properties": {
    "data": {
      "type": "object",
      "title": "Data",
      "required": [
        "value"
      ],
      "properties": {
        "value": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "DriveItem",
            "properties": {
              "id": {
                "type": "string",
                "title": "Id",
                "description": "Unique identifier of the item within the drive"
              },
              "cTag": {
                "type": "string",
                "title": "C Tag",
                "description": "ETag for the content of the item"
              },
              "eTag": {
                "type": "string",
                "title": "E Tag",
                "description": "ETag for the entire item (metadata + content)"
              },
              "file": {
                "type": "object",
                "title": "File",
                "properties": {
                  "hashes": {
                    "type": "object",
                    "title": "Hashes",
                    "description": "Hashes of the file content",
                    "additionalProperties": {
                      "type": "string"
                    }
                  },
                  "mimeType": {
                    "type": "string",
                    "title": "Mime Type",
                    "description": "MIME type of the file"
                  }
                },
                "description": "File metadata, if the item is a file",
                "additionalProperties": true
              },
              "name": {
                "type": "string",
                "title": "Name",
                "description": "Name of the item (filename and extension)"
              },
              "size": {
                "type": "integer",
                "title": "Size",
                "description": "Size of the item in bytes"
              },
              "folder": {
                "type": "object",
                "title": "Folder",
                "properties": {
                  "childCount": {
                    "type": "integer",
                    "title": "Child Count",
                    "description": "Number of children in the folder"
                  }
                },
                "description": "Folder metadata, if the item is a folder",
                "additionalProperties": true
              },
              "webUrl": {
                "type": "string",
                "title": "Web Url",
                "description": "URL that displays the resource in the browser"
              },
              "createdBy": {
                "type": "object",
                "title": "Created By",
                "properties": {
                  "user": {
                    "type": "object",
                    "title": "User",
                    "properties": {
                      "id": {
                        "type": "string",
                        "title": "Id",
                        "description": "Unique identifier"
                      },
                      "displayName": {
                        "type": "string",
                        "title": "Display Name",
                        "description": "Display name"
                      }
                    },
                    "description": "User identity information",
                    "additionalProperties": true
                  },
                  "device": {
                    "type": "object",
                    "title": "Device",
                    "properties": {
                      "id": {
                        "type": "string",
                        "title": "Id",
                        "description": "Unique identifier"
                      },
                      "displayName": {
                        "type": "string",
                        "title": "Display Name",
                        "description": "Display name"
                      }
                    },
                    "description": "Device identity information",
                    "additionalProperties": true
                  },
                  "application": {
                    "type": "object",
                    "title": "Application",
                    "properties": {
                      "id": {
                        "type": "string",
                        "title": "Id",
                        "description": "Unique identifier"
                      },
                      "displayName": {
                        "type": "string",
                        "title": "Display Name",
                        "description": "Display name"
                      }
                    },
                    "description": "Application identity information",
                    "additionalProperties": true
                  }
                },
                "description": "Identity of the user, device, and application that created the item",
                "additionalProperties": true
              },
              "fileSystemInfo": {
                "type": "object",
                "title": "File System Info",
                "properties": {
                  "createdDateTime": {
                    "type": "string",
                    "title": "Created Date Time",
                    "description": "Date and time the item was created (ISO 8601)"
                  },
                  "lastAccessedDateTime": {
                    "type": "string",
                    "title": "Last Accessed Date Time",
                    "description": "Date and time the item was last accessed (ISO 8601)"
                  },
                  "lastModifiedDateTime": {
                    "type": "string",
                    "title": "Last Modified Date Time",
                    "description": "Date and time the item was last modified (ISO 8601)"
                  }
                },
                "description": "File system information on client",
                "additionalProperties": true
              },
              "lastModifiedBy": {
                "type": "object",
                "title": "Last Modified By",
                "properties": {
                  "user": {
                    "type": "object",
                    "title": "User",
                    "properties": {
                      "id": {
                        "type": "string",
                        "title": "Id",
                        "description": "Unique identifier"
                      },
                      "displayName": {
                        "type": "string",
                        "title": "Display Name",
                        "description": "Display name"
                      }
                    },
                    "description": "User identity information",
                    "additionalProperties": true
                  },
                  "device": {
                    "type": "object",
                    "title": "Device",
                    "properties": {
                      "id": {
                        "type": "string",
                        "title": "Id",
                        "description": "Unique identifier"
                      },
                      "displayName": {
                        "type": "string",
                        "title": "Display Name",
                        "description": "Display name"
                      }
                    },
                    "description": "Device identity information",
                    "additionalProperties": true
                  },
                  "application": {
                    "type": "object",
                    "title": "Application",
                    "properties": {
                      "id": {
                        "type": "string",
                        "title": "Id",
                        "description": "Unique identifier"
                      },
                      "displayName": {
                        "type": "string",
                        "title": "Display Name",
                        "description": "Display name"
                      }
                    },
                    "description": "Application identity information",
                    "additionalProperties": true
                  }
                },
                "description": "Identity of the user, device, and application that last modified the item",
                "additionalProperties": true
              },
              "createdDateTime": {
                "type": "string",
                "title": "Created Date Time",
                "description": "Date and time of item creation (ISO 8601)"
              },
              "parentReference": {
                "type": "object",
                "title": "Parent Reference",
                "properties": {
                  "id": {
                    "type": "string",
                    "title": "Id",
                    "description": "Identifier of the item"
                  },
                  "name": {
                    "type": "string",
                    "title": "Name",
                    "description": "Name of the item"
                  },
                  "path": {
                    "type": "string",
                    "title": "Path",
                    "description": "Path to the item"
                  },
                  "siteId": {
                    "type": "string",
                    "title": "Site Id",
                    "description": "Identifier of the site"
                  },
                  "driveId": {
                    "type": "string",
                    "title": "Drive Id",
                    "description": "Identifier of the drive"
                  }
                },
                "description": "Parent information, if the item has a parent",
                "additionalProperties": true
              },
              "lastModifiedDateTime": {
                "type": "string",
                "title": "Last Modified Date Time",
                "description": "Date and time the item was last modified (ISO 8601)"
              }
            },
            "description": "Drive item representing a file or folder.",
            "additionalProperties": true
          },
          "title": "Value",
          "description": "Array of drive items (files and folders) in the specified drive or folder."
        },
        "@odata.nextLink": {
          "type": "string",
          "title": "@Odata.Next Link",
          "description": "URL for the next page of results if pagination is needed."
        }
      },
      "description": "Data from the action execution",
      "additionalProperties": true
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

## SHARE_POINT_LIST_DRIVE_RECENT_ITEMS
Tool to list recently modified items in a SharePoint drive using Microsoft Graph API. Returns files and folders from the root folder sorted by modification time (most recent first). Note: This action uses the /root/children endpoint with $orderby=lastModifiedDateTime desc to retrieve recently modified items from the root folder.

**Input schema:**
```json
{
  "type": "object",
  "title": "ListDriveRecentItemsRequest",
  "required": [
    "drive_id"
  ],
  "properties": {
    "drive_id": {
      "type": "string",
      "title": "Drive Id",
      "examples": [
        "b!sAYRj4psj0qqpjB3OOHdglZBMF5Nk0xPnR4Fc4pfinLYXvUneLOfS60CAyfNpnLO"
      ],
      "description": "The unique identifier of the drive. This is the drive ID (GUID) that identifies a specific document library or OneDrive."
    },
    "row_limit": {
      "type": "integer",
      "title": "Row Limit",
      "default": 20,
      "maximum": 500,
      "minimum": 1,
      "examples": [
        20,
        50
      ],
      "description": "Maximum number of recently modified items to return. Default is 20."
    },
    "site_name": {
      "type": "string",
      "title": "Site Name",
      "examples": [
        "composio-test"
      ],
      "description": "The subsite name to scope the request to (e.g., 'composio-test'). If omitted, the root site is used."
    }
  },
  "description": "Request parameters for listing recently modified items in a drive.",
  "additionalProperties": false
}
```

**Output schema:**
```json
{
  "type": "object",
  "$defs": {
    "Identity": {
      "type": "object",
      "title": "Identity",
      "properties": {
        "id": {
          "type": "string",
          "title": "Id",
          "description": "Unique identifier"
        },
        "displayName": {
          "type": "string",
          "title": "Display Name",
          "description": "Display name"
        }
      },
      "description": "Identity information for a user, application, or device.",
      "additionalProperties": true
    },
    "DriveItem": {
      "type": "object",
      "title": "DriveItem",
      "properties": {
        "id": {
          "type": "string",
          "title": "Id",
          "description": "Unique identifier of the item within the drive."
        },
        "cTag": {
          "type": "string",
          "title": "C Tag",
          "description": "ETag for the content of the item"
        },
        "eTag": {
          "type": "string",
          "title": "E Tag",
          "description": "ETag for the entire item (metadata + content)"
        },
        "file": {
          "type": "object",
          "title": "File",
          "properties": {
            "hashes": {
              "type": "object",
              "title": "Hashes",
              "description": "Hashes of the file content",
              "additionalProperties": {
                "type": "string"
              }
            },
            "mimeType": {
              "type": "string",
              "title": "Mime Type",
              "description": "MIME type of the file"
            }
          },
          "description": "File metadata, if the item is a file",
          "additionalProperties": true
        },
        "name": {
          "type": "string",
          "title": "Name",
          "description": "Name of the item (filename and extension)"
        },
        "size": {
          "type": "integer",
          "title": "Size",
          "description": "Size of the item in bytes"
        },
        "folder": {
          "type": "object",
          "title": "Folder",
          "properties": {
            "childCount": {
              "type": "integer",
              "title": "Child Count",
              "description": "Number of children in the folder"
            }
          },
          "description": "Folder metadata, if the item is a folder",
          "additionalProperties": true
        },
        "webUrl": {
          "type": "string",
          "title": "Web Url",
          "description": "URL that displays the resource in the browser"
        },
        "createdBy": {
          "type": "object",
          "title": "Created By",
          "properties": {
            "user": {
              "type": "object",
              "title": "User",
              "properties": {
                "id": {
                  "type": "string",
                  "title": "Id",
                  "description": "Unique identifier"
                },
                "displayName": {
                  "type": "string",
                  "title": "Display Name",
                  "description": "Display name"
                }
              },
              "description": "User identity information",
              "additionalProperties": true
            },
            "device": {
              "type": "object",
              "title": "Device",
              "properties": {
                "id": {
                  "type": "string",
                  "title": "Id",
                  "description": "Unique identifier"
                },
                "displayName": {
                  "type": "string",
                  "title": "Display Name",
                  "description": "Display name"
                }
              },
              "description": "Device identity information",
              "additionalProperties": true
            },
            "application": {
              "type": "object",
              "title": "Application",
              "properties": {
                "id": {
                  "type": "string",
                  "title": "Id",
                  "description": "Unique identifier"
                },
                "displayName": {
                  "type": "string",
                  "title": "Display Name",
                  "description": "Display name"
                }
              },
              "description": "Application identity information",
              "additionalProperties": true
            }
          },
          "description": "Identity of the user, device, and application that created the item",
          "additionalProperties": true
        },
        "remoteItem": {
          "type": "object",
          "title": "Remote Item",
          "properties": {
            "id": {
              "type": "string",
              "title": "Id",
              "description": "Unique identifier of the remote item"
            },
            "file": {
              "type": "object",
              "title": "File",
              "properties": {
                "hashes": {
                  "type": "object",
                  "title": "Hashes",
                  "description": "Hashes of the file content",
                  "additionalProperties": {
                    "type": "string"
                  }
                },
                "mimeType": {
                  "type": "string",
                  "title": "Mime Type",
                  "description": "MIME type of the file"
                }
              },
              "description": "File facet if the remote item is a file",
              "additionalProperties": true
            },
            "name": {
              "type": "string",
              "title": "Name",
              "description": "Name of the remote item"
            },
            "size": {
              "type": "integer",
              "title": "Size",
              "description": "Size of the remote item in bytes"
            },
            "folder": {
              "type": "object",
              "title": "Folder",
              "properties": {
                "childCount": {
                  "type": "integer",
                  "title": "Child Count",
                  "description": "Number of children in the folder"
                }
              },
              "description": "Folder facet if the remote item is a folder",
              "additionalProperties": true
            },
            "webUrl": {
              "type": "string",
              "title": "Web Url",
              "description": "URL to access the remote item in a browser"
            },
            "parentReference": {
              "type": "object",
              "title": "Parent Reference",
              "properties": {
                "id": {
                  "type": "string",
                  "title": "Id",
                  "description": "Identifier of the item"
                },
                "name": {
                  "type": "string",
                  "title": "Name",
                  "description": "Name of the item"
                },
                "path": {
                  "type": "string",
                  "title": "Path",
                  "description": "Path to the item"
                },
                "siteId": {
                  "type": "string",
                  "title": "Site Id",
                  "description": "Identifier of the site"
                },
                "driveId": {
                  "type": "string",
                  "title": "Drive Id",
                  "description": "Identifier of the drive"
                }
              },
              "description": "Reference to the parent of the remote item",
              "additionalProperties": true
            }
          },
          "description": "Remote item data, if the item is shared from a drive other than the one being accessed",
          "additionalProperties": true
        },
        "fileSystemInfo": {
          "type": "object",
          "title": "File System Info",
          "properties": {
            "createdDateTime": {
              "type": "string",
              "title": "Created Date Time",
              "description": "Date and time the item was created (ISO 8601)"
            },
            "lastAccessedDateTime": {
              "type": "string",
              "title": "Last Accessed Date Time",
              "description": "Date and time the item was last accessed (ISO 8601)"
            },
            "lastModifiedDateTime": {
              "type": "string",
              "title": "Last Modified Date Time",
              "description": "Date and time the item was last modified (ISO 8601)"
            }
          },
          "description": "File system information on client",
          "additionalProperties": true
        },
        "lastModifiedBy": {
          "type": "object",
          "title": "Last Modified By",
          "properties": {
            "user": {
              "type": "object",
              "title": "User",
              "properties": {
                "id": {
                  "type": "string",
                  "title": "Id",
                  "description": "Unique identifier"
                },
                "displayName": {
                  "type": "string",
                  "title": "Display Name",
                  "description": "Display name"
                }
              },
              "description": "User identity information",
              "additionalProperties": true
            },
            "device": {
              "type": "object",
              "title": "Device",
              "properties": {
                "id": {
                  "type": "string",
                  "title": "Id",
                  "description": "Unique identifier"
                },
                "displayName": {
                  "type": "string",
                  "title": "Display Name",
                  "description": "Display name"
                }
              },
              "description": "Device identity information",
              "additionalProperties": true
            },
            "application": {
              "type": "object",
              "title": "Application",
              "properties": {
                "id": {
                  "type": "string",
                  "title": "Id",
                  "description": "Unique identifier"
                },
                "displayName": {
                  "type": "string",
                  "title": "Display Name",
                  "description": "Display name"
                }
              },
              "description": "Application identity information",
              "additionalProperties": true
            }
          },
          "description": "Identity of the user, device, and application that last modified the item",
          "additionalProperties": true
        },
        "createdDateTime": {
          "type": "string",
          "title": "Created Date Time",
          "description": "Date and time of item creation (ISO 8601)"
        },
        "parentReference": {
          "type": "object",
          "title": "Parent Reference",
          "properties": {
            "id": {
              "type": "string",
              "title": "Id",
              "description": "Identifier of the item"
            },
            "name": {
              "type": "string",
              "title": "Name",
              "description": "Name of the item"
            },
            "path": {
              "type": "string",
              "title": "Path",
              "description": "Path to the item"
            },
            "siteId": {
              "type": "string",
              "title": "Site Id",
              "description": "Identifier of the site"
            },
            "driveId": {
              "type": "string",
              "title": "Drive Id",
              "description": "Identifier of the drive"
            }
          },
          "description": "Parent information, if the item has a parent",
          "additionalProperties": true
        },
        "lastModifiedDateTime": {
          "type": "string",
          "title": "Last Modified Date Time",
          "description": "Date and time the item was last modified (ISO 8601)"
        }
      },
      "description": "Drive item representing a file or folder.",
      "additionalProperties": true
    },
    "FileFacet": {
      "type": "object",
      "title": "FileFacet",
      "properties": {
        "hashes": {
          "type": "object",
          "title": "Hashes",
          "description": "Hashes of the file content",
          "additionalProperties": {
            "type": "string"
          }
        },
        "mimeType": {
          "type": "string",
          "title": "Mime Type",
          "description": "MIME type of the file"
        }
      },
      "description": "File facet indicating the item is a file.",
      "additionalProperties": true
    },
    "RemoteItem": {
      "type": "object",
      "title": "RemoteItem",
      "properties": {
        "id": {
          "type": "string",
          "title": "Id",
          "description": "Unique identifier of the remote item"
        },
        "file": {
          "type": "object",
          "title": "File",
          "properties": {
            "hashes": {
              "type": "object",
              "title": "Hashes",
              "description": "Hashes of the file content",
              "additionalProperties": {
                "type": "string"
              }
            },
            "mimeType": {
              "type": "string",
              "title": "Mime Type",
              "description": "MIME type of the file"
            }
          },
          "description": "File facet if the remote item is a file",
          "additionalProperties": true
        },
        "name": {
          "type": "string",
          "title": "Name",
          "description": "Name of the remote item"
        },
        "size": {
          "type": "integer",
          "title": "Size",
          "description": "Size of the remote item in bytes"
        },
        "folder": {
          "type": "object",
          "title": "Folder",
          "properties": {
            "childCount": {
              "type": "integer",
              "title": "Child Count",
              "description": "Number of children in the folder"
            }
          },
          "description": "Folder facet if the remote item is a folder",
          "additionalProperties": true
        },
        "webUrl": {
          "type": "string",
          "title": "Web Url",
          "description": "URL to access the remote item in a browser"
        },
        "parentReference": {
          "type": "object",
          "title": "Parent Reference",
          "properties": {
            "id": {
              "type": "string",
              "title": "Id",
              "description": "Identifier of the item"
            },
            "name": {
              "type": "string",
              "title": "Name",
              "description": "Name of the item"
            },
            "path": {
              "type": "string",
              "title": "Path",
              "description": "Path to the item"
            },
            "siteId": {
              "type": "string",
              "title": "Site Id",
              "description": "Identifier of the site"
            },
            "driveId": {
              "type": "string",
              "title": "Drive Id",
              "description": "Identifier of the drive"
            }
          },
          "description": "Reference to the parent of the remote item",
          "additionalProperties": true
        }
      },
      "description": "Information about an item from another drive.",
      "additionalProperties": true
    },
    "FolderFacet": {
      "type": "object",
      "title": "FolderFacet",
      "properties": {
        "childCount": {
          "type": "integer",
          "title": "Child Count",
          "description": "Number of children in the folder"
        }
      },
      "description": "Folder facet indicating the item is a folder.",
      "additionalProperties": true
    },
    "IdentitySet": {
      "type": "object",
      "title": "IdentitySet",
      "properties": {
        "user": {
          "type": "object",
          "title": "User",
          "properties": {
            "id": {
              "type": "string",
              "title": "Id",
              "description": "Unique identifier"
            },
            "displayName": {
              "type": "string",
              "title": "Display Name",
              "description": "Display name"
            }
          },
          "description": "User identity information",
          "additionalProperties": true
        },
        "device": {
          "type": "object",
          "title": "Device",
          "properties": {
            "id": {
              "type": "string",
              "title": "Id",
              "description": "Unique identifier"
            },
            "displayName": {
              "type": "string",
              "title": "Display Name",
              "description": "Display name"
            }
          },
          "description": "Device identity information",
          "additionalProperties": true
        },
        "application": {
          "type": "object",
          "title": "Application",
          "properties": {
            "id": {
              "type": "string",
              "title": "Id",
              "description": "Unique identifier"
            },
            "displayName": {
              "type": "string",
              "title": "Display Name",
              "description": "Display name"
            }
          },
          "description": "Application identity information",
          "additionalProperties": true
        }
      },
      "description": "Identity information about who created or modified an item.",
      "additionalProperties": true
    },
    "ItemReference": {
      "type": "object",
      "title": "ItemReference",
      "properties": {
        "id": {
          "type": "string",
          "title": "Id",
          "description": "Identifier of the item"
        },
        "name": {
          "type": "string",
          "title": "Name",
          "description": "Name of the item"
        },
        "path": {
          "type": "string",
          "title": "Path",
          "description": "Path to the item"
        },
        "siteId": {
          "type": "string",
          "title": "Site Id",
          "description": "Identifier of the site"
        },
        "driveId": {
          "type": "string",
          "title": "Drive Id",
          "description": "Identifier of the drive"
        }
      },
      "description": "Reference to a parent item or drive.",
      "additionalProperties": true
    },
    "FileSystemInfo": {
      "type": "object",
      "title": "FileSystemInfo",
      "properties": {
        "createdDateTime": {
          "type": "string",
          "title": "Created Date Time",
          "description": "Date and time the item was created (ISO 8601)"
        },
        "lastAccessedDateTime": {
          "type": "string",
          "title": "Last Accessed Date Time",
          "description": "Date and time the item was last accessed (ISO 8601)"
        },
        "lastModifiedDateTime": {
          "type": "string",
          "title": "Last Modified Date Time",
          "description": "Date and time the item was last modified (ISO 8601)"
        }
      },
      "description": "File system metadata.",
      "additionalProperties": true
    },
    "ListDriveRecentItemsResponse": {
      "type": "object",
      "title": "ListDriveRecentItemsResponse",
      "required": [
        "value"
      ],
      "properties": {
        "value": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "DriveItem",
            "properties": {
              "id": {
                "type": "string",
                "title": "Id",
                "description": "Unique identifier of the item within the drive."
              },
              "cTag": {
                "type": "string",
                "title": "C Tag",
                "description": "ETag for the content of the item"
              },
              "eTag": {
                "type": "string",
                "title": "E Tag",
                "description": "ETag for the entire item (metadata + content)"
              },
              "file": {
                "type": "object",
                "title": "File",
                "properties": {
                  "hashes": {
                    "type": "object",
                    "title": "Hashes",
                    "description": "Hashes of the file content",
                    "additionalProperties": {
                      "type": "string"
                    }
                  },
                  "mimeType": {
                    "type": "string",
                    "title": "Mime Type",
                    "description": "MIME type of the file"
                  }
                },
                "description": "File metadata, if the item is a file",
                "additionalProperties": true
              },
              "name": {
                "type": "string",
                "title": "Name",
                "description": "Name of the item (filename and extension)"
              },
              "size": {
                "type": "integer",
                "title": "Size",
                "description": "Size of the item in bytes"
              },
              "folder": {
                "type": "object",
                "title": "Folder",
                "properties": {
                  "childCount": {
                    "type": "integer",
                    "title": "Child Count",
                    "description": "Number of children in the folder"
                  }
                },
                "description": "Folder metadata, if the item is a folder",
                "additionalProperties": true
              },
              "webUrl": {
                "type": "string",
                "title": "Web Url",
                "description": "URL that displays the resource in the browser"
              },
              "createdBy": {
                "type": "object",
                "title": "Created By",
                "properties": {
                  "user": {
                    "type": "object",
                    "title": "User",
                    "properties": {
                      "id": {
                        "type": "string",
                        "title": "Id",
                        "description": "Unique identifier"
                      },
                      "displayName": {
                        "type": "string",
                        "title": "Display Name",
                        "description": "Display name"
                      }
                    },
                    "description": "User identity information",
                    "additionalProperties": true
                  },
                  "device": {
                    "type": "object",
                    "title": "Device",
                    "properties": {
                      "id": {
                        "type": "string",
                        "title": "Id",
                        "description": "Unique identifier"
                      },
                      "displayName": {
                        "type": "string",
                        "title": "Display Name",
                        "description": "Display name"
                      }
                    },
                    "description": "Device identity information",
                    "additionalProperties": true
                  },
                  "application": {
                    "type": "object",
                    "title": "Application",
                    "properties": {
                      "id": {
                        "type": "string",
                        "title": "Id",
                        "description": "Unique identifier"
                      },
                      "displayName": {
                        "type": "string",
                        "title": "Display Name",
                        "description": "Display name"
                      }
                    },
                    "description": "Application identity information",
                    "additionalProperties": true
                  }
                },
                "description": "Identity of the user, device, and application that created the item",
                "additionalProperties": true
              },
              "remoteItem": {
                "type": "object",
                "title": "Remote Item",
                "properties": {
                  "id": {
                    "type": "string",
                    "title": "Id",
                    "description": "Unique identifier of the remote item"
                  },
                  "file": {
                    "type": "object",
                    "title": "File",
                    "properties": {
                      "hashes": {
                        "type": "object",
                        "title": "Hashes",
                        "description": "Hashes of the file content",
                        "additionalProperties": {
                          "type": "string"
                        }
                      },
                      "mimeType": {
                        "type": "string",
                        "title": "Mime Type",
                        "description": "MIME type of the file"
                      }
                    },
                    "description": "File facet if the remote item is a file",
                    "additionalProperties": true
                  },
                  "name": {
                    "type": "string",
                    "title": "Name",
                    "description": "Name of the remote item"
                  },
                  "size": {
                    "type": "integer",
                    "title": "Size",
                    "description": "Size of the remote item in bytes"
                  },
                  "folder": {
                    "type": "object",
                    "title": "Folder",
                    "properties": {
                      "childCount": {
                        "type": "integer",
                        "title": "Child Count",
                        "description": "Number of children in the folder"
                      }
                    },
                    "description": "Folder facet if the remote item is a folder",
                    "additionalProperties": true
                  },
                  "webUrl": {
                    "type": "string",
                    "title": "Web Url",
                    "description": "URL to access the remote item in a browser"
                  },
                  "parentReference": {
                    "type": "object",
                    "title": "Parent Reference",
                    "properties": {
                      "id": {
                        "type": "string",
                        "title": "Id",
                        "description": "Identifier of the item"
                      },
                      "name": {
                        "type": "string",
                        "title": "Name",
                        "description": "Name of the item"
                      },
                      "path": {
                        "type": "string",
                        "title": "Path",
                        "description": "Path to the item"
                      },
                      "siteId": {
                        "type": "string",
                        "title": "Site Id",
                        "description": "Identifier of the site"
                      },
                      "driveId": {
                        "type": "string",
                        "title": "Drive Id",
                        "description": "Identifier of the drive"
                      }
                    },
                    "description": "Reference to the parent of the remote item",
                    "additionalProperties": true
                  }
                },
                "description": "Remote item data, if the item is shared from a drive other than the one being accessed",
                "additionalProperties": true
              },
              "fileSystemInfo": {
                "type": "object",
                "title": "File System Info",
                "properties": {
                  "createdDateTime": {
                    "type": "string",
                    "title": "Created Date Time",
                    "description": "Date and time the item was created (ISO 8601)"
                  },
                  "lastAccessedDateTime": {
                    "type": "string",
                    "title": "Last Accessed Date Time",
                    "description": "Date and time the item was last accessed (ISO 8601)"
                  },
                  "lastModifiedDateTime": {
                    "type": "string",
                    "title": "Last Modified Date Time",
                    "description": "Date and time the item was last modified (ISO 8601)"
                  }
                },
                "description": "File system information on client",
                "additionalProperties": true
              },
              "lastModifiedBy": {
                "type": "object",
                "title": "Last Modified By",
                "properties": {
                  "user": {
                    "type": "object",
                    "title": "User",
                    "properties": {
                      "id": {
                        "type": "string",
                        "title": "Id",
                        "description": "Unique identifier"
                      },
                      "displayName": {
                        "type": "string",
                        "title": "Display Name",
                        "description": "Display name"
                      }
                    },
                    "description": "User identity information",
                    "additionalProperties": true
                  },
                  "device": {
                    "type": "object",
                    "title": "Device",
                    "properties": {
                      "id": {
                        "type": "string",
                        "title": "Id",
                        "description": "Unique identifier"
                      },
                      "displayName": {
                        "type": "string",
                        "title": "Display Name",
                        "description": "Display name"
                      }
                    },
                    "description": "Device identity information",
                    "additionalProperties": true
                  },
                  "application": {
                    "type": "object",
                    "title": "Application",
                    "properties": {
                      "id": {
                        "type": "string",
                        "title": "Id",
                        "description": "Unique identifier"
                      },
                      "displayName": {
                        "type": "string",
                        "title": "Display Name",
                        "description": "Display name"
                      }
                    },
                    "description": "Application identity information",
                    "additionalProperties": true
                  }
                },
                "description": "Identity of the user, device, and application that last modified the item",
                "additionalProperties": true
              },
              "createdDateTime": {
                "type": "string",
                "title": "Created Date Time",
                "description": "Date and time of item creation (ISO 8601)"
              },
              "parentReference": {
                "type": "object",
                "title": "Parent Reference",
                "properties": {
                  "id": {
                    "type": "string",
                    "title": "Id",
                    "description": "Identifier of the item"
                  },
                  "name": {
                    "type": "string",
                    "title": "Name",
                    "description": "Name of the item"
                  },
                  "path": {
                    "type": "string",
                    "title": "Path",
                    "description": "Path to the item"
                  },
                  "siteId": {
                    "type": "string",
                    "title": "Site Id",
                    "description": "Identifier of the site"
                  },
                  "driveId": {
                    "type": "string",
                    "title": "Drive Id",
                    "description": "Identifier of the drive"
                  }
                },
                "description": "Parent information, if the item has a parent",
                "additionalProperties": true
              },
              "lastModifiedDateTime": {
                "type": "string",
                "title": "Last Modified Date Time",
                "description": "Date and time the item was last modified (ISO 8601)"
              }
            },
            "description": "Drive item representing a file or folder.",
            "additionalProperties": true
          },
          "title": "Value",
          "description": "Array of recently modified drive items sorted by modification time (most recent first). Items include files and folders from the root folder."
        }
      },
      "description": "Response model containing recently modified drive items.",
      "additionalProperties": true
    }
  },
  "title": "ListDriveRecentItemsResponseWrapper",
  "required": [
    "data",
    "successful"
  ],
  "properties": {
    "data": {
      "type": "object",
      "title": "Data",
      "required": [
        "value"
      ],
      "properties": {
        "value": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "DriveItem",
            "properties": {
              "id": {
                "type": "string",
                "title": "Id",
                "description": "Unique identifier of the item within the drive."
              },
              "cTag": {
                "type": "string",
                "title": "C Tag",
                "description": "ETag for the content of the item"
              },
              "eTag": {
                "type": "string",
                "title": "E Tag",
                "description": "ETag for the entire item (metadata + content)"
              },
              "file": {
                "type": "object",
                "title": "File",
                "properties": {
                  "hashes": {
                    "type": "object",
                    "title": "Hashes",
                    "description": "Hashes of the file content",
                    "additionalProperties": {
                      "type": "string"
                    }
                  },
                  "mimeType": {
                    "type": "string",
                    "title": "Mime Type",
                    "description": "MIME type of the file"
                  }
                },
                "description": "File metadata, if the item is a file",
                "additionalProperties": true
              },
              "name": {
                "type": "string",
                "title": "Name",
                "description": "Name of the item (filename and extension)"
              },
              "size": {
                "type": "integer",
                "title": "Size",
                "description": "Size of the item in bytes"
              },
              "folder": {
                "type": "object",
                "title": "Folder",
                "properties": {
                  "childCount": {
                    "type": "integer",
                    "title": "Child Count",
                    "description": "Number of children in the folder"
                  }
                },
                "description": "Folder metadata, if the item is a folder",
                "additionalProperties": true
              },
              "webUrl": {
                "type": "string",
                "title": "Web Url",
                "description": "URL that displays the resource in the browser"
              },
              "createdBy": {
                "type": "object",
                "title": "Created By",
                "properties": {
                  "user": {
                    "type": "object",
                    "title": "User",
                    "properties": {
                      "id": {
                        "type": "string",
                        "title": "Id",
                        "description": "Unique identifier"
                      },
                      "displayName": {
                        "type": "string",
                        "title": "Display Name",
                        "description": "Display name"
                      }
                    },
                    "description": "User identity information",
                    "additionalProperties": true
                  },
                  "device": {
                    "type": "object",
                    "title": "Device",
                    "properties": {
                      "id": {
                        "type": "string",
                        "title": "Id",
                        "description": "Unique identifier"
                      },
                      "displayName": {
                        "type": "string",
                        "title": "Display Name",
                        "description": "Display name"
                      }
                    },
                    "description": "Device identity information",
                    "additionalProperties": true
                  },
                  "application": {
                    "type": "object",
                    "title": "Application",
                    "properties": {
                      "id": {
                        "type": "string",
                        "title": "Id",
                        "description": "Unique identifier"
                      },
                      "displayName": {
                        "type": "string",
                        "title": "Display Name",
                        "description": "Display name"
                      }
                    },
                    "description": "Application identity information",
                    "additionalProperties": true
                  }
                },
                "description": "Identity of the user, device, and application that created the item",
                "additionalProperties": true
              },
              "remoteItem": {
                "type": "object",
                "title": "Remote Item",
                "properties": {
                  "id": {
                    "type": "string",
                    "title": "Id",
                    "description": "Unique identifier of the remote item"
                  },
                  "file": {
                    "type": "object",
                    "title": "File",
                    "properties": {
                      "hashes": {
                        "type": "object",
                        "title": "Hashes",
                        "description": "Hashes of the file content",
                        "additionalProperties": {
                          "type": "string"
                        }
                      },
                      "mimeType": {
                        "type": "string",
                        "title": "Mime Type",
                        "description": "MIME type of the file"
                      }
                    },
                    "description": "File facet if the remote item is a file",
                    "additionalProperties": true
                  },
                  "name": {
                    "type": "string",
                    "title": "Name",
                    "description": "Name of the remote item"
                  },
                  "size": {
                    "type": "integer",
                    "title": "Size",
                    "description": "Size of the remote item in bytes"
                  },
                  "folder": {
                    "type": "object",
                    "title": "Folder",
                    "properties": {
                      "childCount": {
                        "type": "integer",
                        "title": "Child Count",
                        "description": "Number of children in the folder"
                      }
                    },
                    "description": "Folder facet if the remote item is a folder",
                    "additionalProperties": true
                  },
                  "webUrl": {
                    "type": "string",
                    "title": "Web Url",
                    "description": "URL to access the remote item in a browser"
                  },
                  "parentReference": {
                    "type": "object",
                    "title": "Parent Reference",
                    "properties": {
                      "id": {
                        "type": "string",
                        "title": "Id",
                        "description": "Identifier of the item"
                      },
                      "name": {
                        "type": "string",
                        "title": "Name",
                        "description": "Name of the item"
                      },
                      "path": {
                        "type": "string",
                        "title": "Path",
                        "description": "Path to the item"
                      },
                      "siteId": {
                        "type": "string",
                        "title": "Site Id",
                        "description": "Identifier of the site"
                      },
                      "driveId": {
                        "type": "string",
                        "title": "Drive Id",
                        "description": "Identifier of the drive"
                      }
                    },
                    "description": "Reference to the parent of the remote item",
                    "additionalProperties": true
                  }
                },
                "description": "Remote item data, if the item is shared from a drive other than the one being accessed",
                "additionalProperties": true
              },
              "fileSystemInfo": {
                "type": "object",
                "title": "File System Info",
                "properties": {
                  "createdDateTime": {
                    "type": "string",
                    "title": "Created Date Time",
                    "description": "Date and time the item was created (ISO 8601)"
                  },
                  "lastAccessedDateTime": {
                    "type": "string",
                    "title": "Last Accessed Date Time",
                    "description": "Date and time the item was last accessed (ISO 8601)"
                  },
                  "lastModifiedDateTime": {
                    "type": "string",
                    "title": "Last Modified Date Time",
                    "description": "Date and time the item was last modified (ISO 8601)"
                  }
                },
                "description": "File system information on client",
                "additionalProperties": true
              },
              "lastModifiedBy": {
                "type": "object",
                "title": "Last Modified By",
                "properties": {
                  "user": {
                    "type": "object",
                    "title": "User",
                    "properties": {
                      "id": {
                        "type": "string",
                        "title": "Id",
                        "description": "Unique identifier"
                      },
                      "displayName": {
                        "type": "string",
                        "title": "Display Name",
                        "description": "Display name"
                      }
                    },
                    "description": "User identity information",
                    "additionalProperties": true
                  },
                  "device": {
                    "type": "object",
                    "title": "Device",
                    "properties": {
                      "id": {
                        "type": "string",
                        "title": "Id",
                        "description": "Unique identifier"
                      },
                      "displayName": {
                        "type": "string",
                        "title": "Display Name",
                        "description": "Display name"
                      }
                    },
                    "description": "Device identity information",
                    "additionalProperties": true
                  },
                  "application": {
                    "type": "object",
                    "title": "Application",
                    "properties": {
                      "id": {
                        "type": "string",
                        "title": "Id",
                        "description": "Unique identifier"
                      },
                      "displayName": {
                        "type": "string",
                        "title": "Display Name",
                        "description": "Display name"
                      }
                    },
                    "description": "Application identity information",
                    "additionalProperties": true
                  }
                },
                "description": "Identity of the user, device, and application that last modified the item",
                "additionalProperties": true
              },
              "createdDateTime": {
                "type": "string",
                "title": "Created Date Time",
                "description": "Date and time of item creation (ISO 8601)"
              },
              "parentReference": {
                "type": "object",
                "title": "Parent Reference",
                "properties": {
                  "id": {
                    "type": "string",
                    "title": "Id",
                    "description": "Identifier of the item"
                  },
                  "name": {
                    "type": "string",
                    "title": "Name",
                    "description": "Name of the item"
                  },
                  "path": {
                    "type": "string",
                    "title": "Path",
                    "description": "Path to the item"
                  },
                  "siteId": {
                    "type": "string",
                    "title": "Site Id",
                    "description": "Identifier of the site"
                  },
                  "driveId": {
                    "type": "string",
                    "title": "Drive Id",
                    "description": "Identifier of the drive"
                  }
                },
                "description": "Parent information, if the item has a parent",
                "additionalProperties": true
              },
              "lastModifiedDateTime": {
                "type": "string",
                "title": "Last Modified Date Time",
                "description": "Date and time the item was last modified (ISO 8601)"
              }
            },
            "description": "Drive item representing a file or folder.",
            "additionalProperties": true
          },
          "title": "Value",
          "description": "Array of recently modified drive items sorted by modification time (most recent first). Items include files and folders from the root folder."
        }
      },
      "description": "Data from the action execution",
      "additionalProperties": true
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

## SHARE_POINT_LIST_DRIVES_REST_API
Tool to retrieve drives using SharePoint REST API v2.0. Use when you need to list document libraries and drives from a SharePoint site using native SharePoint authentication (not Microsoft Graph).

**Input schema:**
```json
{
  "type": "object",
  "title": "ListDrivesRestApiRequest",
  "properties": {
    "top": {
      "type": "integer",
      "title": "Top",
      "default": 100,
      "minimum": 1,
      "examples": [
        100,
        50,
        10
      ],
      "description": "OData $top parameter - number of drives to return. Default: 100."
    },
    "expand": {
      "type": "string",
      "title": "Expand",
      "examples": [
        "root",
        "items",
        "root,items"
      ],
      "description": "OData $expand parameter to expand related entities (e.g., 'root,items')."
    },
    "select": {
      "type": "string",
      "title": "Select",
      "examples": [
        "id,name,webUrl,driveType",
        "id,name,createdDateTime"
      ],
      "description": "OData $select parameter - comma-separated properties to return (e.g., 'id,name,webUrl,driveType')."
    },
    "site_name": {
      "type": "string",
      "title": "Site Name",
      "examples": [
        "composio-test",
        "Workshopsubmissions",
        "Finance"
      ],
      "description": "The subsite name to scope the request to (e.g., 'composio-test'). If omitted, the root site is used. When provided, the API base URL becomes 'https://{tenant}.sharepoint.com/sites/{site}'."
    },
    "site_path": {
      "type": "string",
      "title": "Site Path",
      "default": "root",
      "examples": [
        "root",
        "teamsite",
        "engineering"
      ],
      "description": "Site identifier or path segment (e.g., 'teamsite', 'engineering', or a site ID). Use 'root' for the root site. Do not include 'sites/' prefix as it is added automatically."
    },
    "sharepoint_site_url": {
      "type": "string",
      "title": "Sharepoint Site Url",
      "examples": [
        "https://composio2024.sharepoint.com",
        "https://contoso.sharepoint.com"
      ],
      "description": "Full SharePoint site URL (e.g., 'https://composio2024.sharepoint.com'). If not provided, uses the default site from connection."
    }
  },
  "description": "Request parameters for listing drives using SharePoint REST API v2.0.",
  "additionalProperties": false
}
```

**Output schema:**
```json
{
  "type": "object",
  "$defs": {
    "Drive": {
      "type": "object",
      "title": "Drive",
      "properties": {
        "id": {
          "type": "string",
          "title": "Id",
          "description": "Unique identifier of the drive within the SharePoint site"
        },
        "name": {
          "type": "string",
          "title": "Name",
          "description": "Name of the drive"
        },
        "owner": {
          "type": "object",
          "title": "Owner",
          "properties": {
            "user": {
              "type": "object",
              "title": "User",
              "properties": {
                "id": {
                  "type": "string",
                  "title": "Id",
                  "description": "Unique identifier of the user"
                },
                "email": {
                  "type": "string",
                  "title": "Email",
                  "description": "Email address of the user"
                },
                "displayName": {
                  "type": "string",
                  "title": "Display Name",
                  "description": "Display name of the user"
                }
              },
              "description": "User information for the drive owner",
              "additionalProperties": true
            }
          },
          "description": "Owner information for the drive",
          "additionalProperties": true
        },
        "quota": {
          "type": "object",
          "title": "Quota",
          "properties": {
            "used": {
              "type": "integer",
              "title": "Used",
              "description": "Total space used, in bytes"
            },
            "state": {
              "type": "string",
              "title": "State",
              "description": "State of the storage space (normal, nearing, critical, exceeded)"
            },
            "total": {
              "type": "integer",
              "title": "Total",
              "description": "Total allowed storage space, in bytes"
            },
            "deleted": {
              "type": "integer",
              "title": "Deleted",
              "description": "Total space consumed by files in the recycle bin, in bytes"
            },
            "remaining": {
              "type": "integer",
              "title": "Remaining",
              "description": "Total space remaining before reaching the quota limit, in bytes"
            }
          },
          "description": "Quota information for the drive storage",
          "additionalProperties": true
        },
        "webUrl": {
          "type": "string",
          "title": "Web Url",
          "description": "URL to access the drive in a web browser"
        },
        "driveType": {
          "type": "string",
          "title": "Drive Type",
          "description": "Type of drive (e.g., 'documentLibrary', 'business', 'personal')"
        },
        "description": {
          "type": "string",
          "title": "Description",
          "description": "Description of the drive"
        },
        "createdDateTime": {
          "type": "string",
          "title": "Created Date Time",
          "description": "Date and time the drive was created (ISO 8601)"
        },
        "lastModifiedDateTime": {
          "type": "string",
          "title": "Last Modified Date Time",
          "description": "Date and time the drive was last modified (ISO 8601)"
        }
      },
      "description": "Drive information from SharePoint REST API v2.0.",
      "additionalProperties": true
    },
    "DriveUser": {
      "type": "object",
      "title": "DriveUser",
      "properties": {
        "id": {
          "type": "string",
          "title": "Id",
          "description": "Unique identifier of the user"
        },
        "email": {
          "type": "string",
          "title": "Email",
          "description": "Email address of the user"
        },
        "displayName": {
          "type": "string",
          "title": "Display Name",
          "description": "Display name of the user"
        }
      },
      "description": "User information for drive owner.",
      "additionalProperties": true
    },
    "DriveOwner": {
      "type": "object",
      "title": "DriveOwner",
      "properties": {
        "user": {
          "type": "object",
          "title": "User",
          "properties": {
            "id": {
              "type": "string",
              "title": "Id",
              "description": "Unique identifier of the user"
            },
            "email": {
              "type": "string",
              "title": "Email",
              "description": "Email address of the user"
            },
            "displayName": {
              "type": "string",
              "title": "Display Name",
              "description": "Display name of the user"
            }
          },
          "description": "User information for the drive owner",
          "additionalProperties": true
        }
      },
      "description": "Owner information for a drive.",
      "additionalProperties": true
    },
    "DriveQuota": {
      "type": "object",
      "title": "DriveQuota",
      "properties": {
        "used": {
          "type": "integer",
          "title": "Used",
          "description": "Total space used, in bytes"
        },
        "state": {
          "type": "string",
          "title": "State",
          "description": "State of the storage space (normal, nearing, critical, exceeded)"
        },
        "total": {
          "type": "integer",
          "title": "Total",
          "description": "Total allowed storage space, in bytes"
        },
        "deleted": {
          "type": "integer",
          "title": "Deleted",
          "description": "Total space consumed by files in the recycle bin, in bytes"
        },
        "remaining": {
          "type": "integer",
          "title": "Remaining",
          "description": "Total space remaining before reaching the quota limit, in bytes"
        }
      },
      "description": "Quota information for a drive.",
      "additionalProperties": true
    },
    "ListDrivesRestApiResponse": {
      "type": "object",
      "title": "ListDrivesRestApiResponse",
      "required": [
        "value"
      ],
      "properties": {
        "value": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "Drive",
            "properties": {
              "id": {
                "type": "string",
                "title": "Id",
                "description": "Unique identifier of the drive within the SharePoint site"
              },
              "name": {
                "type": "string",
                "title": "Name",
                "description": "Name of the drive"
              },
              "owner": {
                "type": "object",
                "title": "Owner",
                "properties": {
                  "user": {
                    "type": "object",
                    "title": "User",
                    "properties": {
                      "id": {
                        "type": "string",
                        "title": "Id",
                        "description": "Unique identifier of the user"
                      },
                      "email": {
                        "type": "string",
                        "title": "Email",
                        "description": "Email address of the user"
                      },
                      "displayName": {
                        "type": "string",
                        "title": "Display Name",
                        "description": "Display name of the user"
                      }
                    },
                    "description": "User information for the drive owner",
                    "additionalProperties": true
                  }
                },
                "description": "Owner information for the drive",
                "additionalProperties": true
              },
              "quota": {
                "type": "object",
                "title": "Quota",
                "properties": {
                  "used": {
                    "type": "integer",
                    "title": "Used",
                    "description": "Total space used, in bytes"
                  },
                  "state": {
                    "type": "string",
                    "title": "State",
                    "description": "State of the storage space (normal, nearing, critical, exceeded)"
                  },
                  "total": {
                    "type": "integer",
                    "title": "Total",
                    "description": "Total allowed storage space, in bytes"
                  },
                  "deleted": {
                    "type": "integer",
                    "title": "Deleted",
                    "description": "Total space consumed by files in the recycle bin, in bytes"
                  },
                  "remaining": {
                    "type": "integer",
                    "title": "Remaining",
                    "description": "Total space remaining before reaching the quota limit, in bytes"
                  }
                },
                "description": "Quota information for the drive storage",
                "additionalProperties": true
              },
              "webUrl": {
                "type": "string",
                "title": "Web Url",
                "description": "URL to access the drive in a web browser"
              },
              "driveType": {
                "type": "string",
                "title": "Drive Type",
                "description": "Type of drive (e.g., 'documentLibrary', 'business', 'personal')"
              },
              "description": {
                "type": "string",
                "title": "Description",
                "description": "Description of the drive"
              },
              "createdDateTime": {
                "type": "string",
                "title": "Created Date Time",
                "description": "Date and time the drive was created (ISO 8601)"
              },
              "lastModifiedDateTime": {
                "type": "string",
                "title": "Last Modified Date Time",
                "description": "Date and time the drive was last modified (ISO 8601)"
              }
            },
            "description": "Drive information from SharePoint REST API v2.0.",
            "additionalProperties": true
          },
          "title": "Value",
          "description": "Array of drives from the SharePoint site. Each drive represents a document library or storage location."
        }
      },
      "description": "Response model containing drives from SharePoint REST API v2.0.",
      "additionalProperties": true
    }
  },
  "title": "ListDrivesRestApiResponseWrapper",
  "required": [
    "data",
    "successful"
  ],
  "properties": {
    "data": {
      "type": "object",
      "title": "Data",
      "required": [
        "value"
      ],
      "properties": {
        "value": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "Drive",
            "properties": {
              "id": {
                "type": "string",
                "title": "Id",
                "description": "Unique identifier of the drive within the SharePoint site"
              },
              "name": {
                "type": "string",
                "title": "Name",
                "description": "Name of the drive"
              },
              "owner": {
                "type": "object",
                "title": "Owner",
                "properties": {
                  "user": {
                    "type": "object",
                    "title": "User",
                    "properties": {
                      "id": {
                        "type": "string",
                        "title": "Id",
                        "description": "Unique identifier of the user"
                      },
                      "email": {
                        "type": "string",
                        "title": "Email",
                        "description": "Email address of the user"
                      },
                      "displayName": {
                        "type": "string",
                        "title": "Display Name",
                        "description": "Display name of the user"
                      }
                    },
                    "description": "User information for the drive owner",
                    "additionalProperties": true
                  }
                },
                "description": "Owner information for the drive",
                "additionalProperties": true
              },
              "quota": {
                "type": "object",
                "title": "Quota",
                "properties": {
                  "used": {
                    "type": "integer",
                    "title": "Used",
                    "description": "Total space used, in bytes"
                  },
                  "state": {
                    "type": "string",
                    "title": "State",
                    "description": "State of the storage space (normal, nearing, critical, exceeded)"
                  },
                  "total": {
                    "type": "integer",
                    "title": "Total",
                    "description": "Total allowed storage space, in bytes"
                  },
                  "deleted": {
                    "type": "integer",
                    "title": "Deleted",
                    "description": "Total space consumed by files in the recycle bin, in bytes"
                  },
                  "remaining": {
                    "type": "integer",
                    "title": "Remaining",
                    "description": "Total space remaining before reaching the quota limit, in bytes"
                  }
                },
                "description": "Quota information for the drive storage",
                "additionalProperties": true
              },
              "webUrl": {
                "type": "string",
                "title": "Web Url",
                "description": "URL to access the drive in a web browser"
              },
              "driveType": {
                "type": "string",
                "title": "Drive Type",
                "description": "Type of drive (e.g., 'documentLibrary', 'business', 'personal')"
              },
              "description": {
                "type": "string",
                "title": "Description",
                "description": "Description of the drive"
              },
              "createdDateTime": {
                "type": "string",
                "title": "Created Date Time",
                "description": "Date and time the drive was created (ISO 8601)"
              },
              "lastModifiedDateTime": {
                "type": "string",
                "title": "Last Modified Date Time",
                "description": "Date and time the drive was last modified (ISO 8601)"
              }
            },
            "description": "Drive information from SharePoint REST API v2.0.",
            "additionalProperties": true
          },
          "title": "Value",
          "description": "Array of drives from the SharePoint site. Each drive represents a document library or storage location."
        }
      },
      "description": "Data from the action execution",
      "additionalProperties": true
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

## SHARE_POINT_LIST_FILES_IN_FOLDER
Tool to list files within a SharePoint folder (non-recursive; does not enumerate subfolders). Use when you need to enumerate all files in a folder by its server-relative URL. To cover nested structures, call the tool separately for each subfolder.

**Input schema:**
```json
{
  "type": "object",
  "title": "ListFilesInFolderRequest",
  "example": {
    "top": 50,
    "select": "Name,ServerRelativeUrl,Length",
    "folder_name": "/Shared Documents"
  },
  "required": [
    "folder_name"
  ],
  "properties": {
    "top": {
      "type": "integer",
      "title": "Top",
      "minimum": 1,
      "examples": [
        100
      ],
      "description": "OData $top to limit the number of files returned."
    },
    "expand": {
      "type": "string",
      "title": "Expand",
      "examples": [
        "ListItemAllFields"
      ],
      "description": "OData $expand to inline related entities (e.g., 'ListItemAllFields'). When expanding 'Files,Folders', access results via `Files.results` and `Folders.results` arrays in the response."
    },
    "select": {
      "type": "string",
      "title": "Select",
      "examples": [
        "Name,ServerRelativeUrl,Length"
      ],
      "description": "OData $select to specify which file properties to return (comma-separated)."
    },
    "orderby": {
      "type": "string",
      "title": "Orderby",
      "examples": [
        "Name desc"
      ],
      "description": "OData $orderby to sort the results (e.g., 'Name desc')."
    },
    "site_name": {
      "type": "string",
      "title": "Site Name",
      "examples": [
        "composio-test"
      ],
      "description": "The subsite name to scope the request to (e.g., 'composio-test'). If omitted, the root site is used. When provided, the API base URL becomes 'https://{tenant}.sharepoint.com/sites/{site}'."
    },
    "skiptoken": {
      "type": "string",
      "title": "Skiptoken",
      "examples": [
        "Paged=TRUE&p_ID=15"
      ],
      "description": "OData $skiptoken for server-side paging."
    },
    "folder_name": {
      "type": "string",
      "title": "Folder Name",
      "examples": [
        "/Shared Documents"
      ],
      "description": "Server-relative URL of the folder, e.g., '/Shared Documents' or '/sites/MySite/Folder'. Must be a valid path to an existing folder. Near-miss paths (wrong casing, extra/missing slashes, abbreviated names) silently return empty results rather than an error; use server_relative_url values from prior API responses to ensure exact paths."
    }
  },
  "description": "Request parameters for listing files in a SharePoint folder.",
  "additionalProperties": false
}
```

**Output schema:**
```json
{
  "type": "object",
  "$defs": {
    "FileInfo": {
      "type": "object",
      "title": "FileInfo",
      "properties": {
        "ETag": {
          "type": "string",
          "title": "E Tag",
          "description": "Entity tag for versioning."
        },
        "Name": {
          "type": "string",
          "title": "Name",
          "description": "The name of the file."
        },
        "Title": {
          "type": "string",
          "title": "Title",
          "description": "Title of the file."
        },
        "Exists": {
          "type": "boolean",
          "title": "Exists",
          "description": "Whether the file exists."
        },
        "Length": {
          "type": "string",
          "title": "Length",
          "description": "File size in bytes (as string)."
        },
        "UniqueId": {
          "type": "string",
          "title": "Unique Id",
          "description": "Unique identifier (GUID) of the file."
        },
        "TimeCreated": {
          "type": "string",
          "title": "Time Created",
          "description": "When the file was created (ISO 8601 format)."
        },
        "TimeLastModified": {
          "type": "string",
          "title": "Time Last Modified",
          "description": "When the file was last modified (ISO 8601 format)."
        },
        "ServerRelativeUrl": {
          "type": "string",
          "title": "Server Relative Url",
          "description": "Server-relative URL of the file."
        }
      },
      "description": "SharePoint file information model.",
      "additionalProperties": true
    },
    "ListFilesInFolderResponse": {
      "type": "object",
      "title": "ListFilesInFolderResponse",
      "required": [
        "files"
      ],
      "properties": {
        "files": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "FileInfo",
            "properties": {
              "ETag": {
                "type": "string",
                "title": "E Tag",
                "description": "Entity tag for versioning."
              },
              "Name": {
                "type": "string",
                "title": "Name",
                "description": "The name of the file."
              },
              "Title": {
                "type": "string",
                "title": "Title",
                "description": "Title of the file."
              },
              "Exists": {
                "type": "boolean",
                "title": "Exists",
                "description": "Whether the file exists."
              },
              "Length": {
                "type": "string",
                "title": "Length",
                "description": "File size in bytes (as string)."
              },
              "UniqueId": {
                "type": "string",
                "title": "Unique Id",
                "description": "Unique identifier (GUID) of the file."
              },
              "TimeCreated": {
                "type": "string",
                "title": "Time Created",
                "description": "When the file was created (ISO 8601 format)."
              },
              "TimeLastModified": {
                "type": "string",
                "title": "Time Last Modified",
                "description": "When the file was last modified (ISO 8601 format)."
              },
              "ServerRelativeUrl": {
                "type": "string",
                "title": "Server Relative Url",
                "description": "Server-relative URL of the file."
              }
            },
            "description": "SharePoint file information model.",
            "additionalProperties": true
          },
          "title": "Files",
          "description": "Array of file objects returned from the specified folder."
        }
      },
      "description": "Response model containing list of files in the folder."
    }
  },
  "title": "ListFilesInFolderResponseWrapper",
  "required": [
    "data",
    "successful"
  ],
  "properties": {
    "data": {
      "type": "object",
      "title": "Data",
      "required": [
        "files"
      ],
      "properties": {
        "files": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "FileInfo",
            "properties": {
              "ETag": {
                "type": "string",
                "title": "E Tag",
                "description": "Entity tag for versioning."
              },
              "Name": {
                "type": "string",
                "title": "Name",
                "description": "The name of the file."
              },
              "Title": {
                "type": "string",
                "title": "Title",
                "description": "Title of the file."
              },
              "Exists": {
                "type": "boolean",
                "title": "Exists",
                "description": "Whether the file exists."
              },
              "Length": {
                "type": "string",
                "title": "Length",
                "description": "File size in bytes (as string)."
              },
              "UniqueId": {
                "type": "string",
                "title": "Unique Id",
                "description": "Unique identifier (GUID) of the file."
              },
              "TimeCreated": {
                "type": "string",
                "title": "Time Created",
                "description": "When the file was created (ISO 8601 format)."
              },
              "TimeLastModified": {
                "type": "string",
                "title": "Time Last Modified",
                "description": "When the file was last modified (ISO 8601 format)."
              },
              "ServerRelativeUrl": {
                "type": "string",
                "title": "Server Relative Url",
                "description": "Server-relative URL of the file."
              }
            },
            "description": "SharePoint file information model.",
            "additionalProperties": true
          },
          "title": "Files",
          "description": "Array of file objects returned from the specified folder."
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

## SHARE_POINT_LIST_ITEM_ATTACHMENTS
Tool to list all attachments for a SharePoint list item. Use when you need to retrieve filenames and server-relative URLs of each attachment after confirming the list title and item ID.

**Input schema:**
```json
{
  "type": "object",
  "title": "ListItemAttachmentsRequest",
  "required": [
    "list_title",
    "item_id"
  ],
  "properties": {
    "item_id": {
      "type": "integer",
      "title": "Item Id",
      "minimum": 1,
      "examples": [
        1
      ],
      "description": "ID of the list item to list attachments for (must be \u2265 1)."
    },
    "site_name": {
      "type": "string",
      "title": "Site Name",
      "examples": [
        "composio-test",
        "testcomposio",
        "marketing"
      ],
      "description": "The subsite name to scope the request to (e.g., 'composio-test'). If omitted, the root site is used. When provided, the API base URL becomes https://{tenant}.sharepoint.com/sites/{site}."
    },
    "list_title": {
      "type": "string",
      "title": "List Title",
      "examples": [
        "My List"
      ],
      "description": "Display title of the SharePoint list containing the item."
    }
  },
  "description": "Request model for listing attachments of a SharePoint list item."
}
```

**Output schema:**
```json
{
  "type": "object",
  "$defs": {
    "Attachment": {
      "type": "object",
      "title": "Attachment",
      "required": [
        "FileName",
        "ServerRelativeUrl"
      ],
      "properties": {
        "FileName": {
          "type": "string",
          "title": "File Name",
          "description": "Attachment file name including extension."
        },
        "ServerRelativeUrl": {
          "type": "string",
          "title": "Server Relative Url",
          "description": "Server-relative URL to the attachment file."
        }
      },
      "description": "Model representing an attachment on a list item."
    },
    "ListItemAttachmentsResponse": {
      "type": "object",
      "title": "ListItemAttachmentsResponse",
      "required": [
        "attachments"
      ],
      "properties": {
        "attachments": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "Attachment",
            "required": [
              "FileName",
              "ServerRelativeUrl"
            ],
            "properties": {
              "FileName": {
                "type": "string",
                "title": "File Name",
                "description": "Attachment file name including extension."
              },
              "ServerRelativeUrl": {
                "type": "string",
                "title": "Server Relative Url",
                "description": "Server-relative URL to the attachment file."
              }
            },
            "description": "Model representing an attachment on a list item."
          },
          "title": "Attachments",
          "description": "List of attachments for the specified list item."
        }
      },
      "description": "Response model for attachments of a SharePoint list item."
    }
  },
  "title": "ListItemAttachmentsResponseWrapper",
  "required": [
    "data",
    "successful"
  ],
  "properties": {
    "data": {
      "type": "object",
      "title": "Data",
      "required": [
        "attachments"
      ],
      "properties": {
        "attachments": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "Attachment",
            "required": [
              "FileName",
              "ServerRelativeUrl"
            ],
            "properties": {
              "FileName": {
                "type": "string",
                "title": "File Name",
                "description": "Attachment file name including extension."
              },
              "ServerRelativeUrl": {
                "type": "string",
                "title": "Server Relative Url",
                "description": "Server-relative URL to the attachment file."
              }
            },
            "description": "Model representing an attachment on a list item."
          },
          "title": "Attachments",
          "description": "List of attachments for the specified list item."
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

## SHARE_POINT_LIST_LIST_COLUMNS
Tool to list all column definitions in a SharePoint list. Use when you need to retrieve field metadata including column names, types, and properties.

**Input schema:**
```json
{
  "type": "object",
  "title": "ListListColumnsRequest",
  "required": [
    "list_id"
  ],
  "properties": {
    "top": {
      "type": "integer",
      "title": "Top",
      "minimum": 1,
      "examples": [
        10
      ],
      "description": "OData $top to limit the number of results."
    },
    "filter": {
      "type": "string",
      "title": "Filter",
      "examples": [
        "Hidden eq false"
      ],
      "description": "OData $filter to narrow results, e.g., 'Hidden eq false'."
    },
    "select": {
      "type": "string",
      "title": "Select",
      "examples": [
        "Title,InternalName,TypeAsString"
      ],
      "description": "OData $select to specify which column fields to return, e.g., 'Title,InternalName,TypeAsString'."
    },
    "list_id": {
      "type": "string",
      "title": "List Id",
      "examples": [
        "01234567-89ab-cdef-0123-456789abcdef"
      ],
      "description": "GUID of the SharePoint list to retrieve columns for, in canonical format, e.g., '01234567-89ab-cdef-0123-456789abcdef'."
    },
    "orderby": {
      "type": "string",
      "title": "Orderby",
      "examples": [
        "Title asc"
      ],
      "description": "OData $orderby to sort results, e.g., 'Title asc'."
    },
    "site_name": {
      "type": "string",
      "title": "Site Name",
      "examples": [
        "composio-test"
      ],
      "description": "The subsite name to scope the request to (e.g., 'composio-test'). If omitted, the root site is used. When provided, the API base URL becomes https://{tenant}.sharepoint.com/sites/{site}."
    }
  },
  "description": "Request model for listing column definitions in a SharePoint list."
}
```

**Output schema:**
```json
{
  "type": "object",
  "$defs": {
    "ColumnDefinition": {
      "type": "object",
      "title": "ColumnDefinition",
      "required": [
        "Title"
      ],
      "properties": {
        "Id": {
          "type": "string",
          "title": "Id",
          "description": "GUID of the column."
        },
        "Group": {
          "type": "string",
          "title": "Group",
          "description": "Group or category of the column."
        },
        "Title": {
          "type": "string",
          "title": "Title",
          "description": "Display title of the column."
        },
        "Hidden": {
          "type": "boolean",
          "title": "Hidden",
          "description": "Whether the column is hidden from the user interface."
        },
        "Indexed": {
          "type": "boolean",
          "title": "Indexed",
          "description": "Whether the column is indexed for search and queries."
        },
        "Required": {
          "type": "boolean",
          "title": "Required",
          "description": "Whether the column is required (non-nullable)."
        },
        "StaticName": {
          "type": "string",
          "title": "Static Name",
          "description": "Static name of the column (same as InternalName)."
        },
        "Description": {
          "type": "string",
          "title": "Description",
          "description": "Description of the column."
        },
        "DefaultValue": {
          "type": "string",
          "title": "Default Value",
          "description": "Default value for the column."
        },
        "InternalName": {
          "type": "string",
          "title": "Internal Name",
          "description": "Internal name of the column (static name)."
        },
        "TypeAsString": {
          "type": "string",
          "title": "Type As String",
          "description": "Field type as string, e.g., 'Text', 'Number', 'DateTime', 'Choice', 'Lookup', 'User'."
        },
        "FieldTypeKind": {
          "type": "integer",
          "title": "Field Type Kind",
          "description": "Numeric value from SP.FieldType enumeration. Common values: 1=Counter, 2=Text, 3=Note, 6=Choice, 8=Boolean, 9=Number, 11=URL, 20=User."
        },
        "ReadOnlyField": {
          "type": "boolean",
          "title": "Read Only Field",
          "description": "Whether the column is read-only."
        },
        "EnforceUniqueValues": {
          "type": "boolean",
          "title": "Enforce Unique Values",
          "description": "Whether values in this column must be unique."
        }
      },
      "description": "Model representing a SharePoint list column definition.",
      "additionalProperties": true
    },
    "ListListColumnsResponse": {
      "type": "object",
      "title": "ListListColumnsResponse",
      "required": [
        "columns"
      ],
      "properties": {
        "columns": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "ColumnDefinition",
            "required": [
              "Title"
            ],
            "properties": {
              "Id": {
                "type": "string",
                "title": "Id",
                "description": "GUID of the column."
              },
              "Group": {
                "type": "string",
                "title": "Group",
                "description": "Group or category of the column."
              },
              "Title": {
                "type": "string",
                "title": "Title",
                "description": "Display title of the column."
              },
              "Hidden": {
                "type": "boolean",
                "title": "Hidden",
                "description": "Whether the column is hidden from the user interface."
              },
              "Indexed": {
                "type": "boolean",
                "title": "Indexed",
                "description": "Whether the column is indexed for search and queries."
              },
              "Required": {
                "type": "boolean",
                "title": "Required",
                "description": "Whether the column is required (non-nullable)."
              },
              "StaticName": {
                "type": "string",
                "title": "Static Name",
                "description": "Static name of the column (same as InternalName)."
              },
              "Description": {
                "type": "string",
                "title": "Description",
                "description": "Description of the column."
              },
              "DefaultValue": {
                "type": "string",
                "title": "Default Value",
                "description": "Default value for the column."
              },
              "InternalName": {
                "type": "string",
                "title": "Internal Name",
                "description": "Internal name of the column (static name)."
              },
              "TypeAsString": {
                "type": "string",
                "title": "Type As String",
                "description": "Field type as string, e.g., 'Text', 'Number', 'DateTime', 'Choice', 'Lookup', 'User'."
              },
              "FieldTypeKind": {
                "type": "integer",
                "title": "Field Type Kind",
                "description": "Numeric value from SP.FieldType enumeration. Common values: 1=Counter, 2=Text, 3=Note, 6=Choice, 8=Boolean, 9=Number, 11=URL, 20=User."
              },
              "ReadOnlyField": {
                "type": "boolean",
                "title": "Read Only Field",
                "description": "Whether the column is read-only."
              },
              "EnforceUniqueValues": {
                "type": "boolean",
                "title": "Enforce Unique Values",
                "description": "Whether values in this column must be unique."
              }
            },
            "description": "Model representing a SharePoint list column definition.",
            "additionalProperties": true
          },
          "title": "Columns",
          "description": "List of column definitions for the specified SharePoint list."
        }
      },
      "description": "Response model containing a list of column definitions."
    }
  },
  "title": "ListListColumnsResponseWrapper",
  "required": [
    "data",
    "successful"
  ],
  "properties": {
    "data": {
      "type": "object",
      "title": "Data",
      "required": [
        "columns"
      ],
      "properties": {
        "columns": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "ColumnDefinition",
            "required": [
              "Title"
            ],
            "properties": {
              "Id": {
                "type": "string",
                "title": "Id",
                "description": "GUID of the column."
              },
              "Group": {
                "type": "string",
                "title": "Group",
                "description": "Group or category of the column."
              },
              "Title": {
                "type": "string",
                "title": "Title",
                "description": "Display title of the column."
              },
              "Hidden": {
                "type": "boolean",
                "title": "Hidden",
                "description": "Whether the column is hidden from the user interface."
              },
              "Indexed": {
                "type": "boolean",
                "title": "Indexed",
                "description": "Whether the column is indexed for search and queries."
              },
              "Required": {
                "type": "boolean",
                "title": "Required",
                "description": "Whether the column is required (non-nullable)."
              },
              "StaticName": {
                "type": "string",
                "title": "Static Name",
                "description": "Static name of the column (same as InternalName)."
              },
              "Description": {
                "type": "string",
                "title": "Description",
                "description": "Description of the column."
              },
              "DefaultValue": {
                "type": "string",
                "title": "Default Value",
                "description": "Default value for the column."
              },
              "InternalName": {
                "type": "string",
                "title": "Internal Name",
                "description": "Internal name of the column (static name)."
              },
              "TypeAsString": {
                "type": "string",
                "title": "Type As String",
                "description": "Field type as string, e.g., 'Text', 'Number', 'DateTime', 'Choice', 'Lookup', 'User'."
              },
              "FieldTypeKind": {
                "type": "integer",
                "title": "Field Type Kind",
                "description": "Numeric value from SP.FieldType enumeration. Common values: 1=Counter, 2=Text, 3=Note, 6=Choice, 8=Boolean, 9=Number, 11=URL, 20=User."
              },
              "ReadOnlyField": {
                "type": "boolean",
                "title": "Read Only Field",
                "description": "Whether the column is read-only."
              },
              "EnforceUniqueValues": {
                "type": "boolean",
                "title": "Enforce Unique Values",
                "description": "Whether values in this column must be unique."
              }
            },
            "description": "Model representing a SharePoint list column definition.",
            "additionalProperties": true
          },
          "title": "Columns",
          "description": "List of column definitions for the specified SharePoint list."
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

## SHARE_POINT_LIST_RECYCLE_BIN_ITEMS
Tool to list items in the SharePoint Recycle Bin. Use when you need to retrieve deleted items and page through results.

**Input schema:**
```json
{
  "type": "object",
  "title": "ListRecycleBinItemsRequest",
  "properties": {
    "top": {
      "type": "integer",
      "title": "Top",
      "minimum": 1,
      "examples": [
        10
      ],
      "description": "Maximum number of items to return."
    },
    "expand": {
      "type": "string",
      "title": "Expand",
      "examples": [
        "Author,DeletedBy"
      ],
      "description": "Comma-separated list of navigation properties to expand (e.g., Author,DeletedBy)."
    },
    "filter": {
      "type": "string",
      "title": "Filter",
      "examples": [
        "ItemState eq 1"
      ],
      "description": "OData filter expression to filter items (e.g., ItemState eq 1)."
    },
    "select": {
      "type": "string",
      "title": "Select",
      "examples": [
        "Id,Title,DeletedDate"
      ],
      "description": "Comma-separated list of fields to include in the response (e.g., Id,Title,DeletedDate)."
    },
    "orderby": {
      "type": "string",
      "title": "Orderby",
      "examples": [
        "DeletedDate desc"
      ],
      "description": "OData orderby expression to sort results (e.g., DeletedDate desc)."
    },
    "site_name": {
      "type": "string",
      "title": "Site Name",
      "examples": [
        "composio-test"
      ],
      "description": "The subsite name to scope the request to (e.g., `composio-test`). If omitted, the root site is used. When provided, the API base URL becomes `https://{tenant}.sharepoint.com/sites/{site}`."
    },
    "skiptoken": {
      "type": "string",
      "title": "Skiptoken",
      "examples": [
        "Paged=TRUE&p_ID=15"
      ],
      "description": "Token for server-driven pagination. Extract this value from the `@odata.nextLink` or pagination token in the previous response and pass it into the next call to retrieve subsequent pages."
    }
  },
  "description": "Request parameters for listing items in the SharePoint Recycle Bin.",
  "additionalProperties": false
}
```

**Output schema:**
```json
{
  "type": "object",
  "$defs": {
    "RecycleBinItem": {
      "type": "object",
      "title": "RecycleBinItem",
      "properties": {
        "Id": {
          "type": "string",
          "title": "Id",
          "format": "uuid",
          "description": "Unique identifier of the recycle bin item."
        },
        "Size": {
          "type": "integer",
          "title": "Size",
          "description": "Size of the item in bytes."
        },
        "Title": {
          "type": "string",
          "title": "Title",
          "description": "Title of the recycle bin item."
        },
        "Author": {
          "type": "object",
          "title": "Author",
          "description": "Expanded user who created the recycle bin item if requested.",
          "additionalProperties": true
        },
        "DirName": {
          "type": "string",
          "title": "Dir Name",
          "description": "Site-relative URL of the list or folder that originally contained the item."
        },
        "ItemType": {
          "type": "integer",
          "title": "Item Type",
          "description": "Type of the recycled object (SP.RecycleBinItemType enum)."
        },
        "LeafName": {
          "type": "string",
          "title": "Leaf Name",
          "description": "Name of the file or list item."
        },
        "DeletedBy": {
          "type": "object",
          "title": "Deleted By",
          "description": "Expanded user who deleted the item if requested.",
          "additionalProperties": true
        },
        "ItemState": {
          "type": "integer",
          "title": "Item State",
          "description": "Stage of the recycle bin (SP.RecycleBinItemState enum)."
        },
        "DeletedDate": {
          "type": "string",
          "title": "Deleted Date",
          "format": "date-time",
          "description": "Timestamp when the item was deleted."
        }
      },
      "description": "Model representing a recycle bin item in SharePoint.\n\nNote: SharePoint REST returns PascalCase property names (e.g., Id, Title, DeletedDate).\nWe map these via aliases so the model fields remain pythonic while accepting API keys."
    },
    "ListRecycleBinItemsResponse": {
      "type": "object",
      "title": "ListRecycleBinItemsResponse",
      "required": [
        "items"
      ],
      "properties": {
        "items": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "RecycleBinItem",
            "properties": {
              "Id": {
                "type": "string",
                "title": "Id",
                "format": "uuid",
                "description": "Unique identifier of the recycle bin item."
              },
              "Size": {
                "type": "integer",
                "title": "Size",
                "description": "Size of the item in bytes."
              },
              "Title": {
                "type": "string",
                "title": "Title",
                "description": "Title of the recycle bin item."
              },
              "Author": {
                "type": "object",
                "title": "Author",
                "description": "Expanded user who created the recycle bin item if requested.",
                "additionalProperties": true
              },
              "DirName": {
                "type": "string",
                "title": "Dir Name",
                "description": "Site-relative URL of the list or folder that originally contained the item."
              },
              "ItemType": {
                "type": "integer",
                "title": "Item Type",
                "description": "Type of the recycled object (SP.RecycleBinItemType enum)."
              },
              "LeafName": {
                "type": "string",
                "title": "Leaf Name",
                "description": "Name of the file or list item."
              },
              "DeletedBy": {
                "type": "object",
                "title": "Deleted By",
                "description": "Expanded user who deleted the item if requested.",
                "additionalProperties": true
              },
              "ItemState": {
                "type": "integer",
                "title": "Item State",
                "description": "Stage of the recycle bin (SP.RecycleBinItemState enum)."
              },
              "DeletedDate": {
                "type": "string",
                "title": "Deleted Date",
                "format": "date-time",
                "description": "Timestamp when the item was deleted."
              }
            },
            "description": "Model representing a recycle bin item in SharePoint.\n\nNote: SharePoint REST returns PascalCase property names (e.g., Id, Title, DeletedDate).\nWe map these via aliases so the model fields remain pythonic while accepting API keys."
          },
          "title": "Items",
          "description": "List of recycle bin items."
        },
        "skiptoken": {
          "type": "string",
          "title": "Skiptoken",
          "description": "Pagination token to retrieve the next page of results."
        }
      },
      "description": "Response model containing recycle bin items and pagination token."
    }
  },
  "title": "ListRecycleBinItemsResponseWrapper",
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
            "title": "RecycleBinItem",
            "properties": {
              "Id": {
                "type": "string",
                "title": "Id",
                "format": "uuid",
                "description": "Unique identifier of the recycle bin item."
              },
              "Size": {
                "type": "integer",
                "title": "Size",
                "description": "Size of the item in bytes."
              },
              "Title": {
                "type": "string",
                "title": "Title",
                "description": "Title of the recycle bin item."
              },
              "Author": {
                "type": "object",
                "title": "Author",
                "description": "Expanded user who created the recycle bin item if requested.",
                "additionalProperties": true
              },
              "DirName": {
                "type": "string",
                "title": "Dir Name",
                "description": "Site-relative URL of the list or folder that originally contained the item."
              },
              "ItemType": {
                "type": "integer",
                "title": "Item Type",
                "description": "Type of the recycled object (SP.RecycleBinItemType enum)."
              },
              "LeafName": {
                "type": "string",
                "title": "Leaf Name",
                "description": "Name of the file or list item."
              },
              "DeletedBy": {
                "type": "object",
                "title": "Deleted By",
                "description": "Expanded user who deleted the item if requested.",
                "additionalProperties": true
              },
              "ItemState": {
                "type": "integer",
                "title": "Item State",
                "description": "Stage of the recycle bin (SP.RecycleBinItemState enum)."
              },
              "DeletedDate": {
                "type": "string",
                "title": "Deleted Date",
                "format": "date-time",
                "description": "Timestamp when the item was deleted."
              }
            },
            "description": "Model representing a recycle bin item in SharePoint.\n\nNote: SharePoint REST returns PascalCase property names (e.g., Id, Title, DeletedDate).\nWe map these via aliases so the model fields remain pythonic while accepting API keys."
          },
          "title": "Items",
          "description": "List of recycle bin items."
        },
        "skiptoken": {
          "type": "string",
          "title": "Skiptoken",
          "description": "Pagination token to retrieve the next page of results."
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

## SHARE_POINT_LIST_SITE_GROUPS
Tool to list SharePoint site groups for a site collection. Use when you need to see all groups and their settings before managing permissions.

**Input schema:**
```json
{
  "type": "object",
  "title": "ListSiteGroupsRequest",
  "properties": {
    "top": {
      "type": "integer",
      "title": "Top",
      "minimum": 1,
      "examples": [
        10
      ],
      "description": "OData $top clause to limit the number of returned groups."
    },
    "skip": {
      "type": "integer",
      "title": "Skip",
      "minimum": 0,
      "examples": [
        5
      ],
      "description": "OData $skip clause for paging, number of results to skip."
    },
    "expand": {
      "type": "string",
      "title": "Expand",
      "examples": [
        "Users,Owner"
      ],
      "description": "OData $expand clause to pull in navigation properties like Users or Owner."
    },
    "filter": {
      "type": "string",
      "title": "Filter",
      "examples": [
        "substringof('Owners',Title)"
      ],
      "description": "OData $filter clause to filter results. Example: \"substringof('Owners',Title)\""
    },
    "select": {
      "type": "string",
      "title": "Select",
      "examples": [
        "Title,Id"
      ],
      "description": "OData $select clause to specify which group fields to return. Example: 'Title,Id'"
    },
    "orderby": {
      "type": "string",
      "title": "Orderby",
      "examples": [
        "Title desc"
      ],
      "description": "OData $orderby clause to sort results. Example: 'Title desc'"
    },
    "site_name": {
      "type": "string",
      "title": "Site Name",
      "description": "The subsite name to scope the request to (e.g., 'composio-test'). If omitted, the root site is used. When provided, the API base URL becomes https://{tenant}.sharepoint.com/sites/{site}."
    }
  },
  "description": "Request parameters for listing SharePoint site groups with optional OData queries.",
  "additionalProperties": false
}
```

**Output schema:**
```json
{
  "type": "object",
  "$defs": {
    "SPUser": {
      "type": "object",
      "title": "SPUser",
      "properties": {
        "Id": {
          "type": "integer",
          "title": "Id",
          "description": "User ID."
        },
        "Email": {
          "type": "string",
          "title": "Email",
          "description": "User email address."
        },
        "Title": {
          "type": "string",
          "title": "Title",
          "description": "User display name."
        },
        "Alerts": {
          "type": "object",
          "title": "Alerts",
          "description": "Deferred link to user alerts.",
          "additionalProperties": true
        },
        "Groups": {
          "type": "object",
          "title": "Groups",
          "description": "Deferred link to user groups.",
          "additionalProperties": true
        },
        "UserId": {
          "type": "object",
          "title": "User Id",
          "description": "User ID info.",
          "additionalProperties": true
        },
        "LoginName": {
          "type": "string",
          "title": "Login Name",
          "description": "User login name."
        },
        "Expiration": {
          "type": "string",
          "title": "Expiration",
          "description": "User expiration date."
        },
        "IsSiteAdmin": {
          "type": "boolean",
          "title": "Is Site Admin",
          "description": "Whether user is site admin."
        },
        "IsHiddenInUI": {
          "type": "boolean",
          "title": "Is Hidden In Ui",
          "description": "Whether hidden in UI."
        },
        "PrincipalType": {
          "type": "integer",
          "title": "Principal Type",
          "description": "Principal type."
        },
        "UserPrincipalName": {
          "type": "string",
          "title": "User Principal Name",
          "description": "User principal name (UPN)."
        },
        "IsShareByEmailGuestUser": {
          "type": "boolean",
          "title": "Is Share By Email Guest User",
          "description": "Whether user is a share by email guest."
        },
        "IsEmailAuthenticationGuestUser": {
          "type": "boolean",
          "title": "Is Email Authentication Guest User",
          "description": "Whether user is an email guest."
        }
      },
      "description": "Representation of a SharePoint user within a group."
    },
    "SPGroup": {
      "type": "object",
      "title": "SPGroup",
      "properties": {
        "Id": {
          "type": "integer",
          "title": "Id",
          "description": "Unique identifier for the group."
        },
        "Owner": {
          "type": "object",
          "title": "Owner",
          "properties": {
            "results": {
              "type": "array",
              "items": {
                "type": "object",
                "title": "SPUser",
                "properties": {
                  "Id": {
                    "type": "integer",
                    "title": "Id",
                    "description": "User ID."
                  },
                  "Email": {
                    "type": "string",
                    "title": "Email",
                    "description": "User email address."
                  },
                  "Title": {
                    "type": "string",
                    "title": "Title",
                    "description": "User display name."
                  },
                  "Alerts": {
                    "type": "object",
                    "title": "Alerts",
                    "description": "Deferred link to user alerts.",
                    "additionalProperties": true
                  },
                  "Groups": {
                    "type": "object",
                    "title": "Groups",
                    "description": "Deferred link to user groups.",
                    "additionalProperties": true
                  },
                  "UserId": {
                    "type": "object",
                    "title": "User Id",
                    "description": "User ID info.",
                    "additionalProperties": true
                  },
                  "LoginName": {
                    "type": "string",
                    "title": "Login Name",
                    "description": "User login name."
                  },
                  "Expiration": {
                    "type": "string",
                    "title": "Expiration",
                    "description": "User expiration date."
                  },
                  "IsSiteAdmin": {
                    "type": "boolean",
                    "title": "Is Site Admin",
                    "description": "Whether user is site admin."
                  },
                  "IsHiddenInUI": {
                    "type": "boolean",
                    "title": "Is Hidden In Ui",
                    "description": "Whether hidden in UI."
                  },
                  "PrincipalType": {
                    "type": "integer",
                    "title": "Principal Type",
                    "description": "Principal type."
                  },
                  "UserPrincipalName": {
                    "type": "string",
                    "title": "User Principal Name",
                    "description": "User principal name (UPN)."
                  },
                  "IsShareByEmailGuestUser": {
                    "type": "boolean",
                    "title": "Is Share By Email Guest User",
                    "description": "Whether user is a share by email guest."
                  },
                  "IsEmailAuthenticationGuestUser": {
                    "type": "boolean",
                    "title": "Is Email Authentication Guest User",
                    "description": "Whether user is an email guest."
                  }
                },
                "description": "Representation of a SharePoint user within a group."
              },
              "title": "Results",
              "description": "Expanded results when navigation property is expanded."
            },
            "__deferred": {
              "type": "object",
              "title": "  Deferred",
              "required": [
                "uri"
              ],
              "properties": {
                "uri": {
                  "type": "string",
                  "title": "Uri",
                  "description": "URI of the deferred navigation link."
                }
              },
              "description": "Deferred navigation property link."
            }
          },
          "description": "Deferred navigation link to the group owner."
        },
        "Title": {
          "type": "string",
          "title": "Title",
          "description": "Display name of the group."
        },
        "Users": {
          "type": "object",
          "title": "Users",
          "properties": {
            "results": {
              "type": "array",
              "items": {
                "type": "object",
                "title": "SPUser",
                "properties": {
                  "Id": {
                    "type": "integer",
                    "title": "Id",
                    "description": "User ID."
                  },
                  "Email": {
                    "type": "string",
                    "title": "Email",
                    "description": "User email address."
                  },
                  "Title": {
                    "type": "string",
                    "title": "Title",
                    "description": "User display name."
                  },
                  "Alerts": {
                    "type": "object",
                    "title": "Alerts",
                    "description": "Deferred link to user alerts.",
                    "additionalProperties": true
                  },
                  "Groups": {
                    "type": "object",
                    "title": "Groups",
                    "description": "Deferred link to user groups.",
                    "additionalProperties": true
                  },
                  "UserId": {
                    "type": "object",
                    "title": "User Id",
                    "description": "User ID info.",
                    "additionalProperties": true
                  },
                  "LoginName": {
                    "type": "string",
                    "title": "Login Name",
                    "description": "User login name."
                  },
                  "Expiration": {
                    "type": "string",
                    "title": "Expiration",
                    "description": "User expiration date."
                  },
                  "IsSiteAdmin": {
                    "type": "boolean",
                    "title": "Is Site Admin",
                    "description": "Whether user is site admin."
                  },
                  "IsHiddenInUI": {
                    "type": "boolean",
                    "title": "Is Hidden In Ui",
                    "description": "Whether hidden in UI."
                  },
                  "PrincipalType": {
                    "type": "integer",
                    "title": "Principal Type",
                    "description": "Principal type."
                  },
                  "UserPrincipalName": {
                    "type": "string",
                    "title": "User Principal Name",
                    "description": "User principal name (UPN)."
                  },
                  "IsShareByEmailGuestUser": {
                    "type": "boolean",
                    "title": "Is Share By Email Guest User",
                    "description": "Whether user is a share by email guest."
                  },
                  "IsEmailAuthenticationGuestUser": {
                    "type": "boolean",
                    "title": "Is Email Authentication Guest User",
                    "description": "Whether user is an email guest."
                  }
                },
                "description": "Representation of a SharePoint user within a group."
              },
              "title": "Results",
              "description": "Expanded results when navigation property is expanded."
            },
            "__deferred": {
              "type": "object",
              "title": "  Deferred",
              "required": [
                "uri"
              ],
              "properties": {
                "uri": {
                  "type": "string",
                  "title": "Uri",
                  "description": "URI of the deferred navigation link."
                }
              },
              "description": "Deferred navigation property link."
            }
          },
          "description": "Deferred navigation link to the group's users."
        },
        "LoginName": {
          "type": "string",
          "title": "Login Name",
          "description": "Login name of the group."
        },
        "OwnerTitle": {
          "type": "string",
          "title": "Owner Title",
          "description": "Title of the group owner."
        },
        "Description": {
          "type": "string",
          "title": "Description",
          "description": "Group description text."
        },
        "IsHiddenInUI": {
          "type": "boolean",
          "title": "Is Hidden In Ui",
          "description": "Whether the group is hidden in the UI."
        },
        "PrincipalType": {
          "type": "integer",
          "title": "Principal Type",
          "description": "Bitwise SP.PrincipalType value."
        },
        "AllowRequestToJoinLeave": {
          "type": "boolean",
          "title": "Allow Request To Join Leave",
          "description": "Whether users can request to join or leave the group."
        },
        "AllowMembersEditMembership": {
          "type": "boolean",
          "title": "Allow Members Edit Membership",
          "description": "Whether members can edit the group membership."
        },
        "AutoAcceptRequestToJoinLeave": {
          "type": "boolean",
          "title": "Auto Accept Request To Join Leave",
          "description": "Whether join/leave requests are auto-accepted."
        },
        "OnlyAllowMembersViewMembership": {
          "type": "boolean",
          "title": "Only Allow Members View Membership",
          "description": "Whether only members can view the membership list."
        },
        "RequestToJoinLeaveEmailSetting": {
          "type": "string",
          "title": "Request To Join Leave Email Setting",
          "description": "Email address configured for membership requests."
        }
      },
      "description": "Representation of a SharePoint site group."
    },
    "SPDeferred": {
      "type": "object",
      "title": "SPDeferred",
      "required": [
        "uri"
      ],
      "properties": {
        "uri": {
          "type": "string",
          "title": "Uri",
          "description": "URI of the deferred navigation link."
        }
      }
    },
    "SPNavigationLink": {
      "type": "object",
      "title": "SPNavigationLink",
      "properties": {
        "results": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "SPUser",
            "properties": {
              "Id": {
                "type": "integer",
                "title": "Id",
                "description": "User ID."
              },
              "Email": {
                "type": "string",
                "title": "Email",
                "description": "User email address."
              },
              "Title": {
                "type": "string",
                "title": "Title",
                "description": "User display name."
              },
              "Alerts": {
                "type": "object",
                "title": "Alerts",
                "description": "Deferred link to user alerts.",
                "additionalProperties": true
              },
              "Groups": {
                "type": "object",
                "title": "Groups",
                "description": "Deferred link to user groups.",
                "additionalProperties": true
              },
              "UserId": {
                "type": "object",
                "title": "User Id",
                "description": "User ID info.",
                "additionalProperties": true
              },
              "LoginName": {
                "type": "string",
                "title": "Login Name",
                "description": "User login name."
              },
              "Expiration": {
                "type": "string",
                "title": "Expiration",
                "description": "User expiration date."
              },
              "IsSiteAdmin": {
                "type": "boolean",
                "title": "Is Site Admin",
                "description": "Whether user is site admin."
              },
              "IsHiddenInUI": {
                "type": "boolean",
                "title": "Is Hidden In Ui",
                "description": "Whether hidden in UI."
              },
              "PrincipalType": {
                "type": "integer",
                "title": "Principal Type",
                "description": "Principal type."
              },
              "UserPrincipalName": {
                "type": "string",
                "title": "User Principal Name",
                "description": "User principal name (UPN)."
              },
              "IsShareByEmailGuestUser": {
                "type": "boolean",
                "title": "Is Share By Email Guest User",
                "description": "Whether user is a share by email guest."
              },
              "IsEmailAuthenticationGuestUser": {
                "type": "boolean",
                "title": "Is Email Authentication Guest User",
                "description": "Whether user is an email guest."
              }
            },
            "description": "Representation of a SharePoint user within a group."
          },
          "title": "Results",
          "description": "Expanded results when navigation property is expanded."
        },
        "__deferred": {
          "type": "object",
          "title": "  Deferred",
          "required": [
            "uri"
          ],
          "properties": {
            "uri": {
              "type": "string",
              "title": "Uri",
              "description": "URI of the deferred navigation link."
            }
          },
          "description": "Deferred navigation property link."
        }
      },
      "description": "Navigation property that can be either deferred (not expanded) or expanded with results.\nWhen not expanded: contains __deferred with uri.\nWhen expanded: contains results array."
    },
    "ListSiteGroupsResponse": {
      "type": "object",
      "title": "ListSiteGroupsResponse",
      "required": [
        "value"
      ],
      "properties": {
        "value": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "SPGroup",
            "properties": {
              "Id": {
                "type": "integer",
                "title": "Id",
                "description": "Unique identifier for the group."
              },
              "Owner": {
                "type": "object",
                "title": "Owner",
                "properties": {
                  "results": {
                    "type": "array",
                    "items": {
                      "type": "object",
                      "title": "SPUser",
                      "properties": {
                        "Id": {
                          "type": "integer",
                          "title": "Id",
                          "description": "User ID."
                        },
                        "Email": {
                          "type": "string",
                          "title": "Email",
                          "description": "User email address."
                        },
                        "Title": {
                          "type": "string",
                          "title": "Title",
                          "description": "User display name."
                        },
                        "Alerts": {
                          "type": "object",
                          "title": "Alerts",
                          "description": "Deferred link to user alerts.",
                          "additionalProperties": true
                        },
                        "Groups": {
                          "type": "object",
                          "title": "Groups",
                          "description": "Deferred link to user groups.",
                          "additionalProperties": true
                        },
                        "UserId": {
                          "type": "object",
                          "title": "User Id",
                          "description": "User ID info.",
                          "additionalProperties": true
                        },
                        "LoginName": {
                          "type": "string",
                          "title": "Login Name",
                          "description": "User login name."
                        },
                        "Expiration": {
                          "type": "string",
                          "title": "Expiration",
                          "description": "User expiration date."
                        },
                        "IsSiteAdmin": {
                          "type": "boolean",
                          "title": "Is Site Admin",
                          "description": "Whether user is site admin."
                        },
                        "IsHiddenInUI": {
                          "type": "boolean",
                          "title": "Is Hidden In Ui",
                          "description": "Whether hidden in UI."
                        },
                        "PrincipalType": {
                          "type": "integer",
                          "title": "Principal Type",
                          "description": "Principal type."
                        },
                        "UserPrincipalName": {
                          "type": "string",
                          "title": "User Principal Name",
                          "description": "User principal name (UPN)."
                        },
                        "IsShareByEmailGuestUser": {
                          "type": "boolean",
                          "title": "Is Share By Email Guest User",
                          "description": "Whether user is a share by email guest."
                        },
                        "IsEmailAuthenticationGuestUser": {
                          "type": "boolean",
                          "title": "Is Email Authentication Guest User",
                          "description": "Whether user is an email guest."
                        }
                      },
                      "description": "Representation of a SharePoint user within a group."
                    },
                    "title": "Results",
                    "description": "Expanded results when navigation property is expanded."
                  },
                  "__deferred": {
                    "type": "object",
                    "title": "  Deferred",
                    "required": [
                      "uri"
                    ],
                    "properties": {
                      "uri": {
                        "type": "string",
                        "title": "Uri",
                        "description": "URI of the deferred navigation link."
                      }
                    },
                    "description": "Deferred navigation property link."
                  }
                },
                "description": "Deferred navigation link to the group owner."
              },
              "Title": {
                "type": "string",
                "title": "Title",
                "description": "Display name of the group."
              },
              "Users": {
                "type": "object",
                "title": "Users",
                "properties": {
                  "results": {
                    "type": "array",
                    "items": {
                      "type": "object",
                      "title": "SPUser",
                      "properties": {
                        "Id": {
                          "type": "integer",
                          "title": "Id",
                          "description": "User ID."
                        },
                        "Email": {
                          "type": "string",
                          "title": "Email",
                          "description": "User email address."
                        },
                        "Title": {
                          "type": "string",
                          "title": "Title",
                          "description": "User display name."
                        },
                        "Alerts": {
                          "type": "object",
                          "title": "Alerts",
                          "description": "Deferred link to user alerts.",
                          "additionalProperties": true
                        },
                        "Groups": {
                          "type": "object",
                          "title": "Groups",
                          "description": "Deferred link to user groups.",
                          "additionalProperties": true
                        },
                        "UserId": {
                          "type": "object",
                          "title": "User Id",
                          "description": "User ID info.",
                          "additionalProperties": true
                        },
                        "LoginName": {
                          "type": "string",
                          "title": "Login Name",
                          "description": "User login name."
                        },
                        "Expiration": {
                          "type": "string",
                          "title": "Expiration",
                          "description": "User expiration date."
                        },
                        "IsSiteAdmin": {
                          "type": "boolean",
                          "title": "Is Site Admin",
                          "description": "Whether user is site admin."
                        },
                        "IsHiddenInUI": {
                          "type": "boolean",
                          "title": "Is Hidden In Ui",
                          "description": "Whether hidden in UI."
                        },
                        "PrincipalType": {
                          "type": "integer",
                          "title": "Principal Type",
                          "description": "Principal type."
                        },
                        "UserPrincipalName": {
                          "type": "string",
                          "title": "User Principal Name",
                          "description": "User principal name (UPN)."
                        },
                        "IsShareByEmailGuestUser": {
                          "type": "boolean",
                          "title": "Is Share By Email Guest User",
                          "description": "Whether user is a share by email guest."
                        },
                        "IsEmailAuthenticationGuestUser": {
                          "type": "boolean",
                          "title": "Is Email Authentication Guest User",
                          "description": "Whether user is an email guest."
                        }
                      },
                      "description": "Representation of a SharePoint user within a group."
                    },
                    "title": "Results",
                    "description": "Expanded results when navigation property is expanded."
                  },
                  "__deferred": {
                    "type": "object",
                    "title": "  Deferred",
                    "required": [
                      "uri"
                    ],
                    "properties": {
                      "uri": {
                        "type": "string",
                        "title": "Uri",
                        "description": "URI of the deferred navigation link."
                      }
                    },
                    "description": "Deferred navigation property link."
                  }
                },
                "description": "Deferred navigation link to the group's users."
              },
              "LoginName": {
                "type": "string",
                "title": "Login Name",
                "description": "Login name of the group."
              },
              "OwnerTitle": {
                "type": "string",
                "title": "Owner Title",
                "description": "Title of the group owner."
              },
              "Description": {
                "type": "string",
                "title": "Description",
                "description": "Group description text."
              },
              "IsHiddenInUI": {
                "type": "boolean",
                "title": "Is Hidden In Ui",
                "description": "Whether the group is hidden in the UI."
              },
              "PrincipalType": {
                "type": "integer",
                "title": "Principal Type",
                "description": "Bitwise SP.PrincipalType value."
              },
              "AllowRequestToJoinLeave": {
                "type": "boolean",
                "title": "Allow Request To Join Leave",
                "description": "Whether users can request to join or leave the group."
              },
              "AllowMembersEditMembership": {
                "type": "boolean",
                "title": "Allow Members Edit Membership",
                "description": "Whether members can edit the group membership."
              },
              "AutoAcceptRequestToJoinLeave": {
                "type": "boolean",
                "title": "Auto Accept Request To Join Leave",
                "description": "Whether join/leave requests are auto-accepted."
              },
              "OnlyAllowMembersViewMembership": {
                "type": "boolean",
                "title": "Only Allow Members View Membership",
                "description": "Whether only members can view the membership list."
              },
              "RequestToJoinLeaveEmailSetting": {
                "type": "string",
                "title": "Request To Join Leave Email Setting",
                "description": "Email address configured for membership requests."
              }
            },
            "description": "Representation of a SharePoint site group."
          },
          "title": "Value",
          "description": "List of SharePoint site groups."
        }
      }
    }
  },
  "title": "ListSiteGroupsResponseWrapper",
  "required": [
    "data",
    "successful"
  ],
  "properties": {
    "data": {
      "type": "object",
      "title": "Data",
      "required": [
        "value"
      ],
      "properties": {
        "value": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "SPGroup",
            "properties": {
              "Id": {
                "type": "integer",
                "title": "Id",
                "description": "Unique identifier for the group."
              },
              "Owner": {
                "type": "object",
                "title": "Owner",
                "properties": {
                  "results": {
                    "type": "array",
                    "items": {
                      "type": "object",
                      "title": "SPUser",
                      "properties": {
                        "Id": {
                          "type": "integer",
                          "title": "Id",
                          "description": "User ID."
                        },
                        "Email": {
                          "type": "string",
                          "title": "Email",
                          "description": "User email address."
                        },
                        "Title": {
                          "type": "string",
                          "title": "Title",
                          "description": "User display name."
                        },
                        "Alerts": {
                          "type": "object",
                          "title": "Alerts",
                          "description": "Deferred link to user alerts.",
                          "additionalProperties": true
                        },
                        "Groups": {
                          "type": "object",
                          "title": "Groups",
                          "description": "Deferred link to user groups.",
                          "additionalProperties": true
                        },
                        "UserId": {
                          "type": "object",
                          "title": "User Id",
                          "description": "User ID info.",
                          "additionalProperties": true
                        },
                        "LoginName": {
                          "type": "string",
                          "title": "Login Name",
                          "description": "User login name."
                        },
                        "Expiration": {
                          "type": "string",
                          "title": "Expiration",
                          "description": "User expiration date."
                        },
                        "IsSiteAdmin": {
                          "type": "boolean",
                          "title": "Is Site Admin",
                          "description": "Whether user is site admin."
                        },
                        "IsHiddenInUI": {
                          "type": "boolean",
                          "title": "Is Hidden In Ui",
                          "description": "Whether hidden in UI."
                        },
                        "PrincipalType": {
                          "type": "integer",
                          "title": "Principal Type",
                          "description": "Principal type."
                        },
                        "UserPrincipalName": {
                          "type": "string",
                          "title": "User Principal Name",
                          "description": "User principal name (UPN)."
                        },
                        "IsShareByEmailGuestUser": {
                          "type": "boolean",
                          "title": "Is Share By Email Guest User",
                          "description": "Whether user is a share by email guest."
                        },
                        "IsEmailAuthenticationGuestUser": {
                          "type": "boolean",
                          "title": "Is Email Authentication Guest User",
                          "description": "Whether user is an email guest."
                        }
                      },
                      "description": "Representation of a SharePoint user within a group."
                    },
                    "title": "Results",
                    "description": "Expanded results when navigation property is expanded."
                  },
                  "__deferred": {
                    "type": "object",
                    "title": "  Deferred",
                    "required": [
                      "uri"
                    ],
                    "properties": {
                      "uri": {
                        "type": "string",
                        "title": "Uri",
                        "description": "URI of the deferred navigation link."
                      }
                    },
                    "description": "Deferred navigation property link."
                  }
                },
                "description": "Deferred navigation link to the group owner."
              },
              "Title": {
                "type": "string",
                "title": "Title",
                "description": "Display name of the group."
              },
              "Users": {
                "type": "object",
                "title": "Users",
                "properties": {
                  "results": {
                    "type": "array",
                    "items": {
                      "type": "object",
                      "title": "SPUser",
                      "properties": {
                        "Id": {
                          "type": "integer",
                          "title": "Id",
                          "description": "User ID."
                        },
                        "Email": {
                          "type": "string",
                          "title": "Email",
                          "description": "User email address."
                        },
                        "Title": {
                          "type": "string",
                          "title": "Title",
                          "description": "User display name."
                        },
                        "Alerts": {
                          "type": "object",
                          "title": "Alerts",
                          "description": "Deferred link to user alerts.",
                          "additionalProperties": true
                        },
                        "Groups": {
                          "type": "object",
                          "title": "Groups",
                          "description": "Deferred link to user groups.",
                          "additionalProperties": true
                        },
                        "UserId": {
                          "type": "object",
                          "title": "User Id",
                          "description": "User ID info.",
                          "additionalProperties": true
                        },
                        "LoginName": {
                          "type": "string",
                          "title": "Login Name",
                          "description": "User login name."
                        },
                        "Expiration": {
                          "type": "string",
                          "title": "Expiration",
                          "description": "User expiration date."
                        },
                        "IsSiteAdmin": {
                          "type": "boolean",
                          "title": "Is Site Admin",
                          "description": "Whether user is site admin."
                        },
                        "IsHiddenInUI": {
                          "type": "boolean",
                          "title": "Is Hidden In Ui",
                          "description": "Whether hidden in UI."
                        },
                        "PrincipalType": {
                          "type": "integer",
                          "title": "Principal Type",
                          "description": "Principal type."
                        },
                        "UserPrincipalName": {
                          "type": "string",
                          "title": "User Principal Name",
                          "description": "User principal name (UPN)."
                        },
                        "IsShareByEmailGuestUser": {
                          "type": "boolean",
                          "title": "Is Share By Email Guest User",
                          "description": "Whether user is a share by email guest."
                        },
                        "IsEmailAuthenticationGuestUser": {
                          "type": "boolean",
                          "title": "Is Email Authentication Guest User",
                          "description": "Whether user is an email guest."
                        }
                      },
                      "description": "Representation of a SharePoint user within a group."
                    },
                    "title": "Results",
                    "description": "Expanded results when navigation property is expanded."
                  },
                  "__deferred": {
                    "type": "object",
                    "title": "  Deferred",
                    "required": [
                      "uri"
                    ],
                    "properties": {
                      "uri": {
                        "type": "string",
                        "title": "Uri",
                        "description": "URI of the deferred navigation link."
                      }
                    },
                    "description": "Deferred navigation property link."
                  }
                },
                "description": "Deferred navigation link to the group's users."
              },
              "LoginName": {
                "type": "string",
                "title": "Login Name",
                "description": "Login name of the group."
              },
              "OwnerTitle": {
                "type": "string",
                "title": "Owner Title",
                "description": "Title of the group owner."
              },
              "Description": {
                "type": "string",
                "title": "Description",
                "description": "Group description text."
              },
              "IsHiddenInUI": {
                "type": "boolean",
                "title": "Is Hidden In Ui",
                "description": "Whether the group is hidden in the UI."
              },
              "PrincipalType": {
                "type": "integer",
                "title": "Principal Type",
                "description": "Bitwise SP.PrincipalType value."
              },
              "AllowRequestToJoinLeave": {
                "type": "boolean",
                "title": "Allow Request To Join Leave",
                "description": "Whether users can request to join or leave the group."
              },
              "AllowMembersEditMembership": {
                "type": "boolean",
                "title": "Allow Members Edit Membership",
                "description": "Whether members can edit the group membership."
              },
              "AutoAcceptRequestToJoinLeave": {
                "type": "boolean",
                "title": "Auto Accept Request To Join Leave",
                "description": "Whether join/leave requests are auto-accepted."
              },
              "OnlyAllowMembersViewMembership": {
                "type": "boolean",
                "title": "Only Allow Members View Membership",
                "description": "Whether only members can view the membership list."
              },
              "RequestToJoinLeaveEmailSetting": {
                "type": "string",
                "title": "Request To Join Leave Email Setting",
                "description": "Email address configured for membership requests."
              }
            },
            "description": "Representation of a SharePoint site group."
          },
          "title": "Value",
          "description": "List of SharePoint site groups."
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

## SHARE_POINT_LIST_SITES
Tool to retrieve all SharePoint sites accessible to the user. Use when you need to discover available sites before performing site-specific operations.

**Input schema:**
```json
{
  "type": "object",
  "title": "ListSitesRequest",
  "properties": {
    "top": {
      "type": "integer",
      "title": "Top",
      "default": 50,
      "maximum": 500,
      "minimum": 1,
      "examples": [
        50,
        100,
        200
      ],
      "description": "Number of sites to return. Maximum value is 500."
    },
    "search": {
      "type": "string",
      "title": "Search",
      "examples": [
        "*",
        "Team",
        "Marketing"
      ],
      "description": "Search query to filter sites by name or description. Use '*' to get all sites."
    },
    "select": {
      "type": "string",
      "title": "Select",
      "examples": [
        "SiteId,SiteName,Title,Path",
        "SiteId,Title,Description"
      ],
      "description": "Comma-separated list of managed property names to return. Common properties: SiteId, SiteName, Title, Path, Description, Created, LastModifiedTime. If not specified, SharePoint returns a default set of properties."
    }
  },
  "description": "Request parameters for listing SharePoint sites.",
  "additionalProperties": false
}
```

**Output schema:**
```json
{
  "type": "object",
  "$defs": {
    "SiteItem": {
      "type": "object",
      "title": "SiteItem",
      "properties": {
        "id": {
          "type": "string",
          "title": "Id",
          "description": "Unique identifier of the site (format: {hostname},{siteCollection-id},{site-id})"
        },
        "name": {
          "type": "string",
          "title": "Name",
          "description": "Name of the site"
        },
        "webUrl": {
          "type": "string",
          "title": "Web Url",
          "description": "URL that displays the item in the browser"
        },
        "description": {
          "type": "string",
          "title": "Description",
          "description": "Description of the site"
        },
        "displayName": {
          "type": "string",
          "title": "Display Name",
          "description": "The full title for the site"
        },
        "createdDateTime": {
          "type": "string",
          "title": "Created Date Time",
          "description": "Date and time when the site was created (ISO 8601)"
        },
        "lastModifiedDateTime": {
          "type": "string",
          "title": "Last Modified Date Time",
          "description": "Date and time when the site was last modified (ISO 8601)"
        }
      },
      "description": "Represents a SharePoint site.",
      "additionalProperties": true
    },
    "ListSitesResponse": {
      "type": "object",
      "title": "ListSitesResponse",
      "required": [
        "value"
      ],
      "properties": {
        "value": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "SiteItem",
            "properties": {
              "id": {
                "type": "string",
                "title": "Id",
                "description": "Unique identifier of the site (format: {hostname},{siteCollection-id},{site-id})"
              },
              "name": {
                "type": "string",
                "title": "Name",
                "description": "Name of the site"
              },
              "webUrl": {
                "type": "string",
                "title": "Web Url",
                "description": "URL that displays the item in the browser"
              },
              "description": {
                "type": "string",
                "title": "Description",
                "description": "Description of the site"
              },
              "displayName": {
                "type": "string",
                "title": "Display Name",
                "description": "The full title for the site"
              },
              "createdDateTime": {
                "type": "string",
                "title": "Created Date Time",
                "description": "Date and time when the site was created (ISO 8601)"
              },
              "lastModifiedDateTime": {
                "type": "string",
                "title": "Last Modified Date Time",
                "description": "Date and time when the site was last modified (ISO 8601)"
              }
            },
            "description": "Represents a SharePoint site.",
            "additionalProperties": true
          },
          "title": "Value",
          "description": "Array of SharePoint sites accessible to the user."
        }
      },
      "description": "Response model containing list of SharePoint sites.",
      "additionalProperties": true
    }
  },
  "title": "ListSitesResponseWrapper",
  "required": [
    "data",
    "successful"
  ],
  "properties": {
    "data": {
      "type": "object",
      "title": "Data",
      "required": [
        "value"
      ],
      "properties": {
        "value": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "SiteItem",
            "properties": {
              "id": {
                "type": "string",
                "title": "Id",
                "description": "Unique identifier of the site (format: {hostname},{siteCollection-id},{site-id})"
              },
              "name": {
                "type": "string",
                "title": "Name",
                "description": "Name of the site"
              },
              "webUrl": {
                "type": "string",
                "title": "Web Url",
                "description": "URL that displays the item in the browser"
              },
              "description": {
                "type": "string",
                "title": "Description",
                "description": "Description of the site"
              },
              "displayName": {
                "type": "string",
                "title": "Display Name",
                "description": "The full title for the site"
              },
              "createdDateTime": {
                "type": "string",
                "title": "Created Date Time",
                "description": "Date and time when the site was created (ISO 8601)"
              },
              "lastModifiedDateTime": {
                "type": "string",
                "title": "Last Modified Date Time",
                "description": "Date and time when the site was last modified (ISO 8601)"
              }
            },
            "description": "Represents a SharePoint site.",
            "additionalProperties": true
          },
          "title": "Value",
          "description": "Array of SharePoint sites accessible to the user."
        }
      },
      "description": "Data from the action execution",
      "additionalProperties": true
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

## SHARE_POINT_LIST_SITE_USERS
Tool to list users in the site collection. Results include person users, groups, and system principals by default; use filter 'PrincipalType eq 1' to restrict to individual users.

**Input schema:**
```json
{
  "type": "object",
  "title": "ListSiteUsersRequest",
  "properties": {
    "top": {
      "type": "integer",
      "title": "Top",
      "minimum": 1,
      "examples": [
        10
      ],
      "description": "OData top to limit the number of results."
    },
    "expand": {
      "type": "string",
      "title": "Expand",
      "examples": [
        "Groups"
      ],
      "description": "OData expand to include related entities, e.g., 'Groups'."
    },
    "filter": {
      "type": "string",
      "title": "Filter",
      "examples": [
        "PrincipalType eq 1"
      ],
      "description": "OData filter to narrow results, e.g., 'PrincipalType eq 1'. substringof filters are case-sensitive; normalize casing in filter values to avoid missing valid matches."
    },
    "select": {
      "type": "string",
      "title": "Select",
      "examples": [
        "Title,Email"
      ],
      "description": "OData select to specify which user fields to return, e.g., 'Title,Email'. Email can be empty for some users; prefer LoginName or Id for reliable identification."
    },
    "orderby": {
      "type": "string",
      "title": "Orderby",
      "examples": [
        "Title asc"
      ],
      "description": "OData orderby to sort results, e.g., 'Title asc'."
    },
    "site_name": {
      "type": "string",
      "title": "Site Name",
      "examples": [
        "composio-test"
      ],
      "description": "The subsite name to scope the request to (e.g., 'composio-test'). If omitted, the root site is used. When provided, the API base URL becomes 'https://{tenant}.sharepoint.com/sites/{site}'."
    },
    "skiptoken": {
      "type": "string",
      "title": "Skiptoken",
      "examples": [
        "Paged=TRUE&p_ID=15"
      ],
      "description": "OData skiptoken for paging through results. Iterate requests following each returned skiptoken until no further skiptoken is returned to retrieve all users."
    }
  },
  "description": "Optional OData query parameters for listing all users in the site collection.",
  "additionalProperties": false
}
```

**Output schema:**
```json
{
  "type": "object",
  "$defs": {
    "SPUser": {
      "type": "object",
      "title": "SPUser",
      "required": [
        "Id"
      ],
      "properties": {
        "Id": {
          "type": "integer",
          "title": "Id",
          "description": "User or group identifier."
        },
        "Email": {
          "type": "string",
          "title": "Email",
          "description": "Email address of the user."
        },
        "Title": {
          "type": "string",
          "title": "Title",
          "description": "Display name of the user."
        },
        "Groups": {
          "type": "object",
          "title": "Groups",
          "properties": {
            "results": {
              "type": "array",
              "items": {
                "type": "object",
                "title": "SPGroup",
                "properties": {
                  "Id": {
                    "type": "integer",
                    "title": "Id",
                    "description": "Group ID."
                  },
                  "Owner": {
                    "type": "object",
                    "title": "Owner",
                    "required": [
                      "__deferred"
                    ],
                    "properties": {
                      "__deferred": {
                        "type": "object",
                        "title": "  Deferred",
                        "required": [
                          "uri"
                        ],
                        "properties": {
                          "uri": {
                            "type": "string",
                            "title": "Uri",
                            "description": "URI to the deferred resource."
                          }
                        },
                        "description": "Deferred link reference."
                      }
                    },
                    "description": "Deferred link to group owner."
                  },
                  "Title": {
                    "type": "string",
                    "title": "Title",
                    "description": "Group title."
                  },
                  "Users": {
                    "type": "object",
                    "title": "Users",
                    "required": [
                      "__deferred"
                    ],
                    "properties": {
                      "__deferred": {
                        "type": "object",
                        "title": "  Deferred",
                        "required": [
                          "uri"
                        ],
                        "properties": {
                          "uri": {
                            "type": "string",
                            "title": "Uri",
                            "description": "URI to the deferred resource."
                          }
                        },
                        "description": "Deferred link reference."
                      }
                    },
                    "description": "Deferred link to group users."
                  },
                  "LoginName": {
                    "type": "string",
                    "title": "Login Name",
                    "description": "Group login name."
                  },
                  "OwnerTitle": {
                    "type": "string",
                    "title": "Owner Title",
                    "description": "Owner title."
                  },
                  "__metadata": {
                    "type": "object",
                    "title": "  Metadata",
                    "properties": {
                      "id": {
                        "type": "string",
                        "title": "Id",
                        "description": "Group metadata ID."
                      },
                      "uri": {
                        "type": "string",
                        "title": "Uri",
                        "description": "Group metadata URI."
                      },
                      "type": {
                        "type": "string",
                        "title": "Type",
                        "description": "Group type (e.g., SP.Group)."
                      }
                    },
                    "description": "Group metadata."
                  },
                  "Description": {
                    "type": "string",
                    "title": "Description",
                    "description": "Group description."
                  },
                  "IsHiddenInUI": {
                    "type": "boolean",
                    "title": "Is Hidden In Ui",
                    "description": "Whether group is hidden in UI."
                  },
                  "PrincipalType": {
                    "type": "integer",
                    "title": "Principal Type",
                    "description": "Principal type."
                  },
                  "AllowRequestToJoinLeave": {
                    "type": "boolean",
                    "title": "Allow Request To Join Leave",
                    "description": "Whether users can request to join/leave."
                  },
                  "AllowMembersEditMembership": {
                    "type": "boolean",
                    "title": "Allow Members Edit Membership",
                    "description": "Whether members can edit membership."
                  },
                  "AutoAcceptRequestToJoinLeave": {
                    "type": "boolean",
                    "title": "Auto Accept Request To Join Leave",
                    "description": "Whether join/leave requests are auto-accepted."
                  },
                  "OnlyAllowMembersViewMembership": {
                    "type": "boolean",
                    "title": "Only Allow Members View Membership",
                    "description": "Whether only members can view membership."
                  },
                  "RequestToJoinLeaveEmailSetting": {
                    "type": "string",
                    "title": "Request To Join Leave Email Setting",
                    "description": "Email setting for join/leave requests."
                  }
                },
                "description": "SharePoint group information."
              },
              "title": "Results",
              "description": "Expanded list of groups."
            },
            "__deferred": {
              "type": "object",
              "title": "  Deferred",
              "required": [
                "uri"
              ],
              "properties": {
                "uri": {
                  "type": "string",
                  "title": "Uri",
                  "description": "URI to the deferred resource."
                }
              },
              "description": "Deferred link to group collection."
            }
          },
          "description": "Deferred or expanded groups the user belongs to."
        },
        "UserId": {
          "type": "object",
          "title": "User Id",
          "required": [
            "NameId",
            "NameIdIssuer"
          ],
          "properties": {
            "NameId": {
              "type": "string",
              "title": "Name Id",
              "description": "User's name identifier."
            },
            "NameIdIssuer": {
              "type": "string",
              "title": "Name Id Issuer",
              "description": "Issuer of the name identifier."
            }
          },
          "description": "Object containing name identifier and issuer info."
        },
        "LoginName": {
          "type": "string",
          "title": "Login Name",
          "description": "User login name or claim."
        },
        "IsSiteAdmin": {
          "type": "boolean",
          "title": "Is Site Admin",
          "description": "True if site collection administrator."
        },
        "IsHiddenInUI": {
          "type": "boolean",
          "title": "Is Hidden In Ui",
          "description": "True if hidden in the UI."
        },
        "PrincipalType": {
          "type": "integer",
          "title": "Principal Type",
          "description": "Principal type bitmask."
        }
      },
      "description": "SharePoint user resource."
    },
    "SPGroup": {
      "type": "object",
      "title": "SPGroup",
      "properties": {
        "Id": {
          "type": "integer",
          "title": "Id",
          "description": "Group ID."
        },
        "Owner": {
          "type": "object",
          "title": "Owner",
          "required": [
            "__deferred"
          ],
          "properties": {
            "__deferred": {
              "type": "object",
              "title": "  Deferred",
              "required": [
                "uri"
              ],
              "properties": {
                "uri": {
                  "type": "string",
                  "title": "Uri",
                  "description": "URI to the deferred resource."
                }
              },
              "description": "Deferred link reference."
            }
          },
          "description": "Deferred link to group owner."
        },
        "Title": {
          "type": "string",
          "title": "Title",
          "description": "Group title."
        },
        "Users": {
          "type": "object",
          "title": "Users",
          "required": [
            "__deferred"
          ],
          "properties": {
            "__deferred": {
              "type": "object",
              "title": "  Deferred",
              "required": [
                "uri"
              ],
              "properties": {
                "uri": {
                  "type": "string",
                  "title": "Uri",
                  "description": "URI to the deferred resource."
                }
              },
              "description": "Deferred link reference."
            }
          },
          "description": "Deferred link to group users."
        },
        "LoginName": {
          "type": "string",
          "title": "Login Name",
          "description": "Group login name."
        },
        "OwnerTitle": {
          "type": "string",
          "title": "Owner Title",
          "description": "Owner title."
        },
        "__metadata": {
          "type": "object",
          "title": "  Metadata",
          "properties": {
            "id": {
              "type": "string",
              "title": "Id",
              "description": "Group metadata ID."
            },
            "uri": {
              "type": "string",
              "title": "Uri",
              "description": "Group metadata URI."
            },
            "type": {
              "type": "string",
              "title": "Type",
              "description": "Group type (e.g., SP.Group)."
            }
          },
          "description": "Group metadata."
        },
        "Description": {
          "type": "string",
          "title": "Description",
          "description": "Group description."
        },
        "IsHiddenInUI": {
          "type": "boolean",
          "title": "Is Hidden In Ui",
          "description": "Whether group is hidden in UI."
        },
        "PrincipalType": {
          "type": "integer",
          "title": "Principal Type",
          "description": "Principal type."
        },
        "AllowRequestToJoinLeave": {
          "type": "boolean",
          "title": "Allow Request To Join Leave",
          "description": "Whether users can request to join/leave."
        },
        "AllowMembersEditMembership": {
          "type": "boolean",
          "title": "Allow Members Edit Membership",
          "description": "Whether members can edit membership."
        },
        "AutoAcceptRequestToJoinLeave": {
          "type": "boolean",
          "title": "Auto Accept Request To Join Leave",
          "description": "Whether join/leave requests are auto-accepted."
        },
        "OnlyAllowMembersViewMembership": {
          "type": "boolean",
          "title": "Only Allow Members View Membership",
          "description": "Whether only members can view membership."
        },
        "RequestToJoinLeaveEmailSetting": {
          "type": "string",
          "title": "Request To Join Leave Email Setting",
          "description": "Email setting for join/leave requests."
        }
      },
      "description": "SharePoint group information."
    },
    "DeferredLink": {
      "type": "object",
      "title": "DeferredLink",
      "required": [
        "uri"
      ],
      "properties": {
        "uri": {
          "type": "string",
          "title": "Uri",
          "description": "URI to the deferred resource."
        }
      },
      "description": "Deferred link reference."
    },
    "SPUserIdInfo": {
      "type": "object",
      "title": "SPUserIdInfo",
      "required": [
        "NameId",
        "NameIdIssuer"
      ],
      "properties": {
        "NameId": {
          "type": "string",
          "title": "Name Id",
          "description": "User's name identifier."
        },
        "NameIdIssuer": {
          "type": "string",
          "title": "Name Id Issuer",
          "description": "Issuer of the name identifier."
        }
      }
    },
    "SPGroupMetadata": {
      "type": "object",
      "title": "SPGroupMetadata",
      "properties": {
        "id": {
          "type": "string",
          "title": "Id",
          "description": "Group metadata ID."
        },
        "uri": {
          "type": "string",
          "title": "Uri",
          "description": "Group metadata URI."
        },
        "type": {
          "type": "string",
          "title": "Type",
          "description": "Group type (e.g., SP.Group)."
        }
      },
      "description": "SharePoint group metadata."
    },
    "SPGroupCollection": {
      "type": "object",
      "title": "SPGroupCollection",
      "properties": {
        "results": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "SPGroup",
            "properties": {
              "Id": {
                "type": "integer",
                "title": "Id",
                "description": "Group ID."
              },
              "Owner": {
                "type": "object",
                "title": "Owner",
                "required": [
                  "__deferred"
                ],
                "properties": {
                  "__deferred": {
                    "type": "object",
                    "title": "  Deferred",
                    "required": [
                      "uri"
                    ],
                    "properties": {
                      "uri": {
                        "type": "string",
                        "title": "Uri",
                        "description": "URI to the deferred resource."
                      }
                    },
                    "description": "Deferred link reference."
                  }
                },
                "description": "Deferred link to group owner."
              },
              "Title": {
                "type": "string",
                "title": "Title",
                "description": "Group title."
              },
              "Users": {
                "type": "object",
                "title": "Users",
                "required": [
                  "__deferred"
                ],
                "properties": {
                  "__deferred": {
                    "type": "object",
                    "title": "  Deferred",
                    "required": [
                      "uri"
                    ],
                    "properties": {
                      "uri": {
                        "type": "string",
                        "title": "Uri",
                        "description": "URI to the deferred resource."
                      }
                    },
                    "description": "Deferred link reference."
                  }
                },
                "description": "Deferred link to group users."
              },
              "LoginName": {
                "type": "string",
                "title": "Login Name",
                "description": "Group login name."
              },
              "OwnerTitle": {
                "type": "string",
                "title": "Owner Title",
                "description": "Owner title."
              },
              "__metadata": {
                "type": "object",
                "title": "  Metadata",
                "properties": {
                  "id": {
                    "type": "string",
                    "title": "Id",
                    "description": "Group metadata ID."
                  },
                  "uri": {
                    "type": "string",
                    "title": "Uri",
                    "description": "Group metadata URI."
                  },
                  "type": {
                    "type": "string",
                    "title": "Type",
                    "description": "Group type (e.g., SP.Group)."
                  }
                },
                "description": "Group metadata."
              },
              "Description": {
                "type": "string",
                "title": "Description",
                "description": "Group description."
              },
              "IsHiddenInUI": {
                "type": "boolean",
                "title": "Is Hidden In Ui",
                "description": "Whether group is hidden in UI."
              },
              "PrincipalType": {
                "type": "integer",
                "title": "Principal Type",
                "description": "Principal type."
              },
              "AllowRequestToJoinLeave": {
                "type": "boolean",
                "title": "Allow Request To Join Leave",
                "description": "Whether users can request to join/leave."
              },
              "AllowMembersEditMembership": {
                "type": "boolean",
                "title": "Allow Members Edit Membership",
                "description": "Whether members can edit membership."
              },
              "AutoAcceptRequestToJoinLeave": {
                "type": "boolean",
                "title": "Auto Accept Request To Join Leave",
                "description": "Whether join/leave requests are auto-accepted."
              },
              "OnlyAllowMembersViewMembership": {
                "type": "boolean",
                "title": "Only Allow Members View Membership",
                "description": "Whether only members can view membership."
              },
              "RequestToJoinLeaveEmailSetting": {
                "type": "string",
                "title": "Request To Join Leave Email Setting",
                "description": "Email setting for join/leave requests."
              }
            },
            "description": "SharePoint group information."
          },
          "title": "Results",
          "description": "Expanded list of groups."
        },
        "__deferred": {
          "type": "object",
          "title": "  Deferred",
          "required": [
            "uri"
          ],
          "properties": {
            "uri": {
              "type": "string",
              "title": "Uri",
              "description": "URI to the deferred resource."
            }
          },
          "description": "Deferred link to group collection."
        }
      },
      "description": "SharePoint group collection - can be either deferred or expanded."
    },
    "SPGroupDeferredLink": {
      "type": "object",
      "title": "SPGroupDeferredLink",
      "required": [
        "__deferred"
      ],
      "properties": {
        "__deferred": {
          "type": "object",
          "title": "  Deferred",
          "required": [
            "uri"
          ],
          "properties": {
            "uri": {
              "type": "string",
              "title": "Uri",
              "description": "URI to the deferred resource."
            }
          },
          "description": "Deferred link reference."
        }
      },
      "description": "Deferred link for a group property."
    },
    "ListSiteUsersResponse": {
      "type": "object",
      "title": "ListSiteUsersResponse",
      "required": [
        "users"
      ],
      "properties": {
        "users": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "SPUser",
            "required": [
              "Id"
            ],
            "properties": {
              "Id": {
                "type": "integer",
                "title": "Id",
                "description": "User or group identifier."
              },
              "Email": {
                "type": "string",
                "title": "Email",
                "description": "Email address of the user."
              },
              "Title": {
                "type": "string",
                "title": "Title",
                "description": "Display name of the user."
              },
              "Groups": {
                "type": "object",
                "title": "Groups",
                "properties": {
                  "results": {
                    "type": "array",
                    "items": {
                      "type": "object",
                      "title": "SPGroup",
                      "properties": {
                        "Id": {
                          "type": "integer",
                          "title": "Id",
                          "description": "Group ID."
                        },
                        "Owner": {
                          "type": "object",
                          "title": "Owner",
                          "required": [
                            "__deferred"
                          ],
                          "properties": {
                            "__deferred": {
                              "type": "object",
                              "title": "  Deferred",
                              "required": [
                                "uri"
                              ],
                              "properties": {
                                "uri": {
                                  "type": "string",
                                  "title": "Uri",
                                  "description": "URI to the deferred resource."
                                }
                              },
                              "description": "Deferred link reference."
                            }
                          },
                          "description": "Deferred link to group owner."
                        },
                        "Title": {
                          "type": "string",
                          "title": "Title",
                          "description": "Group title."
                        },
                        "Users": {
                          "type": "object",
                          "title": "Users",
                          "required": [
                            "__deferred"
                          ],
                          "properties": {
                            "__deferred": {
                              "type": "object",
                              "title": "  Deferred",
                              "required": [
                                "uri"
                              ],
                              "properties": {
                                "uri": {
                                  "type": "string",
                                  "title": "Uri",
                                  "description": "URI to the deferred resource."
                                }
                              },
                              "description": "Deferred link reference."
                            }
                          },
                          "description": "Deferred link to group users."
                        },
                        "LoginName": {
                          "type": "string",
                          "title": "Login Name",
                          "description": "Group login name."
                        },
                        "OwnerTitle": {
                          "type": "string",
                          "title": "Owner Title",
                          "description": "Owner title."
                        },
                        "__metadata": {
                          "type": "object",
                          "title": "  Metadata",
                          "properties": {
                            "id": {
                              "type": "string",
                              "title": "Id",
                              "description": "Group metadata ID."
                            },
                            "uri": {
                              "type": "string",
                              "title": "Uri",
                              "description": "Group metadata URI."
                            },
                            "type": {
                              "type": "string",
                              "title": "Type",
                              "description": "Group type (e.g., SP.Group)."
                            }
                          },
                          "description": "Group metadata."
                        },
                        "Description": {
                          "type": "string",
                          "title": "Description",
                          "description": "Group description."
                        },
                        "IsHiddenInUI": {
                          "type": "boolean",
                          "title": "Is Hidden In Ui",
                          "description": "Whether group is hidden in UI."
                        },
                        "PrincipalType": {
                          "type": "integer",
                          "title": "Principal Type",
                          "description": "Principal type."
                        },
                        "AllowRequestToJoinLeave": {
                          "type": "boolean",
                          "title": "Allow Request To Join Leave",
                          "description": "Whether users can request to join/leave."
                        },
                        "AllowMembersEditMembership": {
                          "type": "boolean",
                          "title": "Allow Members Edit Membership",
                          "description": "Whether members can edit membership."
                        },
                        "AutoAcceptRequestToJoinLeave": {
                          "type": "boolean",
                          "title": "Auto Accept Request To Join Leave",
                          "description": "Whether join/leave requests are auto-accepted."
                        },
                        "OnlyAllowMembersViewMembership": {
                          "type": "boolean",
                          "title": "Only Allow Members View Membership",
                          "description": "Whether only members can view membership."
                        },
                        "RequestToJoinLeaveEmailSetting": {
                          "type": "string",
                          "title": "Request To Join Leave Email Setting",
                          "description": "Email setting for join/leave requests."
                        }
                      },
                      "description": "SharePoint group information."
                    },
                    "title": "Results",
                    "description": "Expanded list of groups."
                  },
                  "__deferred": {
                    "type": "object",
                    "title": "  Deferred",
                    "required": [
                      "uri"
                    ],
                    "properties": {
                      "uri": {
                        "type": "string",
                        "title": "Uri",
                        "description": "URI to the deferred resource."
                      }
                    },
                    "description": "Deferred link to group collection."
                  }
                },
                "description": "Deferred or expanded groups the user belongs to."
              },
              "UserId": {
                "type": "object",
                "title": "User Id",
                "required": [
                  "NameId",
                  "NameIdIssuer"
                ],
                "properties": {
                  "NameId": {
                    "type": "string",
                    "title": "Name Id",
                    "description": "User's name identifier."
                  },
                  "NameIdIssuer": {
                    "type": "string",
                    "title": "Name Id Issuer",
                    "description": "Issuer of the name identifier."
                  }
                },
                "description": "Object containing name identifier and issuer info."
              },
              "LoginName": {
                "type": "string",
                "title": "Login Name",
                "description": "User login name or claim."
              },
              "IsSiteAdmin": {
                "type": "boolean",
                "title": "Is Site Admin",
                "description": "True if site collection administrator."
              },
              "IsHiddenInUI": {
                "type": "boolean",
                "title": "Is Hidden In Ui",
                "description": "True if hidden in the UI."
              },
              "PrincipalType": {
                "type": "integer",
                "title": "Principal Type",
                "description": "Principal type bitmask."
              }
            },
            "description": "SharePoint user resource."
          },
          "title": "Users",
          "description": "Array of users in the site collection."
        },
        "skiptoken": {
          "type": "string",
          "title": "Skiptoken",
          "description": "Pagination token to retrieve the next page of results."
        }
      },
      "description": "Response model for listing site users."
    }
  },
  "title": "ListSiteUsersResponseWrapper",
  "required": [
    "data",
    "successful"
  ],
  "properties": {
    "data": {
      "type": "object",
      "title": "Data",
      "required": [
        "users"
      ],
      "properties": {
        "users": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "SPUser",
            "required": [
              "Id"
            ],
            "properties": {
              "Id": {
                "type": "integer",
                "title": "Id",
                "description": "User or group identifier."
              },
              "Email": {
                "type": "string",
                "title": "Email",
                "description": "Email address of the user."
              },
              "Title": {
                "type": "string",
                "title": "Title",
                "description": "Display name of the user."
              },
              "Groups": {
                "type": "object",
                "title": "Groups",
                "properties": {
                  "results": {
                    "type": "array",
                    "items": {
                      "type": "object",
                      "title": "SPGroup",
                      "properties": {
                        "Id": {
                          "type": "integer",
                          "title": "Id",
                          "description": "Group ID."
                        },
                        "Owner": {
                          "type": "object",
                          "title": "Owner",
                          "required": [
                            "__deferred"
                          ],
                          "properties": {
                            "__deferred": {
                              "type": "object",
                              "title": "  Deferred",
                              "required": [
                                "uri"
                              ],
                              "properties": {
                                "uri": {
                                  "type": "string",
                                  "title": "Uri",
                                  "description": "URI to the deferred resource."
                                }
                              },
                              "description": "Deferred link reference."
                            }
                          },
                          "description": "Deferred link to group owner."
                        },
                        "Title": {
                          "type": "string",
                          "title": "Title",
                          "description": "Group title."
                        },
                        "Users": {
                          "type": "object",
                          "title": "Users",
                          "required": [
                            "__deferred"
                          ],
                          "properties": {
                            "__deferred": {
                              "type": "object",
                              "title": "  Deferred",
                              "required": [
                                "uri"
                              ],
                              "properties": {
                                "uri": {
                                  "type": "string",
                                  "title": "Uri",
                                  "description": "URI to the deferred resource."
                                }
                              },
                              "description": "Deferred link reference."
                            }
                          },
                          "description": "Deferred link to group users."
                        },
                        "LoginName": {
                          "type": "string",
                          "title": "Login Name",
                          "description": "Group login name."
                        },
                        "OwnerTitle": {
                          "type": "string",
                          "title": "Owner Title",
                          "description": "Owner title."
                        },
                        "__metadata": {
                          "type": "object",
                          "title": "  Metadata",
                          "properties": {
                            "id": {
                              "type": "string",
                              "title": "Id",
                              "description": "Group metadata ID."
                            },
                            "uri": {
                              "type": "string",
                              "title": "Uri",
                              "description": "Group metadata URI."
                            },
                            "type": {
                              "type": "string",
                              "title": "Type",
                              "description": "Group type (e.g., SP.Group)."
                            }
                          },
                          "description": "Group metadata."
                        },
                        "Description": {
                          "type": "string",
                          "title": "Description",
                          "description": "Group description."
                        },
                        "IsHiddenInUI": {
                          "type": "boolean",
                          "title": "Is Hidden In Ui",
                          "description": "Whether group is hidden in UI."
                        },
                        "PrincipalType": {
                          "type": "integer",
                          "title": "Principal Type",
                          "description": "Principal type."
                        },
                        "AllowRequestToJoinLeave": {
                          "type": "boolean",
                          "title": "Allow Request To Join Leave",
                          "description": "Whether users can request to join/leave."
                        },
                        "AllowMembersEditMembership": {
                          "type": "boolean",
                          "title": "Allow Members Edit Membership",
                          "description": "Whether members can edit membership."
                        },
                        "AutoAcceptRequestToJoinLeave": {
                          "type": "boolean",
                          "title": "Auto Accept Request To Join Leave",
                          "description": "Whether join/leave requests are auto-accepted."
                        },
                        "OnlyAllowMembersViewMembership": {
                          "type": "boolean",
                          "title": "Only Allow Members View Membership",
                          "description": "Whether only members can view membership."
                        },
                        "RequestToJoinLeaveEmailSetting": {
                          "type": "string",
                          "title": "Request To Join Leave Email Setting",
                          "description": "Email setting for join/leave requests."
                        }
                      },
                      "description": "SharePoint group information."
                    },
                    "title": "Results",
                    "description": "Expanded list of groups."
                  },
                  "__deferred": {
                    "type": "object",
                    "title": "  Deferred",
                    "required": [
                      "uri"
                    ],
                    "properties": {
                      "uri": {
                        "type": "string",
                        "title": "Uri",
                        "description": "URI to the deferred resource."
                      }
                    },
                    "description": "Deferred link to group collection."
                  }
                },
                "description": "Deferred or expanded groups the user belongs to."
              },
              "UserId": {
                "type": "object",
                "title": "User Id",
                "required": [
                  "NameId",
                  "NameIdIssuer"
                ],
                "properties": {
                  "NameId": {
                    "type": "string",
                    "title": "Name Id",
                    "description": "User's name identifier."
                  },
                  "NameIdIssuer": {
                    "type": "string",
                    "title": "Name Id Issuer",
                    "description": "Issuer of the name identifier."
                  }
                },
                "description": "Object containing name identifier and issuer info."
              },
              "LoginName": {
                "type": "string",
                "title": "Login Name",
                "description": "User login name or claim."
              },
              "IsSiteAdmin": {
                "type": "boolean",
                "title": "Is Site Admin",
                "description": "True if site collection administrator."
              },
              "IsHiddenInUI": {
                "type": "boolean",
                "title": "Is Hidden In Ui",
                "description": "True if hidden in the UI."
              },
              "PrincipalType": {
                "type": "integer",
                "title": "Principal Type",
                "description": "Principal type bitmask."
              }
            },
            "description": "SharePoint user resource."
          },
          "title": "Users",
          "description": "Array of users in the site collection."
        },
        "skiptoken": {
          "type": "string",
          "title": "Skiptoken",
          "description": "Pagination token to retrieve the next page of results."
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

## SHARE_POINT_LIST_SUBFOLDERS_IN_FOLDER
Tool to list immediate child folders within a SharePoint folder. Use when you need folder navigation or directory discovery by server-relative URL.

**Input schema:**
```json
{
  "type": "object",
  "title": "ListSubfoldersInFolderRequest",
  "example": {
    "top": 50,
    "select": "Name,ServerRelativeUrl,UniqueId",
    "folder_server_relative_url": "/Shared Documents"
  },
  "required": [
    "folder_server_relative_url"
  ],
  "properties": {
    "top": {
      "type": "integer",
      "title": "Top",
      "minimum": 1,
      "examples": [
        100
      ],
      "description": "OData $top to limit the number of subfolders returned."
    },
    "select": {
      "type": "string",
      "title": "Select",
      "examples": [
        "Name,ServerRelativeUrl,UniqueId"
      ],
      "description": "OData $select to specify which folder properties to return (comma-separated)."
    },
    "orderby": {
      "type": "string",
      "title": "Orderby",
      "examples": [
        "Name asc"
      ],
      "description": "OData $orderby to sort the results (e.g., 'Name desc')."
    },
    "site_name": {
      "type": "string",
      "title": "Site Name",
      "examples": [
        "composio-test"
      ],
      "description": "The subsite name to scope the request to (e.g., 'composio-test'). If omitted, the root site is used. When provided, the API base URL becomes https://{tenant}.sharepoint.com/sites/{site}."
    },
    "folder_server_relative_url": {
      "type": "string",
      "title": "Folder Server Relative Url",
      "examples": [
        "/Shared Documents",
        "/sites/MySite/MyFolder"
      ],
      "description": "Server-relative URL of the parent folder, e.g., '/Shared Documents' or '/sites/MySite/Folder'. Must be a valid path to an existing folder. For folders with special characters (#, %), the action will automatically use the ResourcePath-based endpoint."
    }
  },
  "description": "Request parameters for listing immediate subfolders in a SharePoint folder.",
  "additionalProperties": false
}
```

**Output schema:**
```json
{
  "type": "object",
  "$defs": {
    "SharePointFolderMetadata": {
      "type": "object",
      "title": "SharePointFolderMetadata",
      "properties": {
        "Name": {
          "type": "string",
          "title": "Name",
          "description": "Folder name"
        },
        "Exists": {
          "type": "boolean",
          "title": "Exists",
          "description": "Whether the folder exists"
        },
        "UniqueId": {
          "type": "string",
          "title": "Unique Id",
          "description": "Unique identifier (GUID)"
        },
        "ItemCount": {
          "type": "integer",
          "title": "Item Count",
          "description": "Number of items in the folder"
        },
        "TimeCreated": {
          "type": "string",
          "title": "Time Created",
          "description": "Folder creation timestamp (ISO 8601)"
        },
        "WelcomePage": {
          "type": "string",
          "title": "Welcome Page",
          "description": "Welcome page URL"
        },
        "TimeLastModified": {
          "type": "string",
          "title": "Time Last Modified",
          "description": "Last modification timestamp (ISO 8601)"
        },
        "ServerRelativeUrl": {
          "type": "string",
          "title": "Server Relative Url",
          "description": "Server-relative URL path to the folder"
        }
      },
      "description": "SharePoint folder metadata properties.",
      "additionalProperties": true
    },
    "ListSubfoldersInFolderResponse": {
      "type": "object",
      "title": "ListSubfoldersInFolderResponse",
      "required": [
        "folders"
      ],
      "properties": {
        "folders": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "SharePointFolderMetadata",
            "properties": {
              "Name": {
                "type": "string",
                "title": "Name",
                "description": "Folder name"
              },
              "Exists": {
                "type": "boolean",
                "title": "Exists",
                "description": "Whether the folder exists"
              },
              "UniqueId": {
                "type": "string",
                "title": "Unique Id",
                "description": "Unique identifier (GUID)"
              },
              "ItemCount": {
                "type": "integer",
                "title": "Item Count",
                "description": "Number of items in the folder"
              },
              "TimeCreated": {
                "type": "string",
                "title": "Time Created",
                "description": "Folder creation timestamp (ISO 8601)"
              },
              "WelcomePage": {
                "type": "string",
                "title": "Welcome Page",
                "description": "Welcome page URL"
              },
              "TimeLastModified": {
                "type": "string",
                "title": "Time Last Modified",
                "description": "Last modification timestamp (ISO 8601)"
              },
              "ServerRelativeUrl": {
                "type": "string",
                "title": "Server Relative Url",
                "description": "Server-relative URL path to the folder"
              }
            },
            "description": "SharePoint folder metadata properties.",
            "additionalProperties": true
          },
          "title": "Folders",
          "description": "Array of folder objects with metadata. Returns empty array if folder has no subfolders."
        }
      },
      "description": "Response model containing list of immediate subfolders in the folder."
    }
  },
  "title": "ListSubfoldersInFolderResponseWrapper",
  "required": [
    "data",
    "successful"
  ],
  "properties": {
    "data": {
      "type": "object",
      "title": "Data",
      "required": [
        "folders"
      ],
      "properties": {
        "folders": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "SharePointFolderMetadata",
            "properties": {
              "Name": {
                "type": "string",
                "title": "Name",
                "description": "Folder name"
              },
              "Exists": {
                "type": "boolean",
                "title": "Exists",
                "description": "Whether the folder exists"
              },
              "UniqueId": {
                "type": "string",
                "title": "Unique Id",
                "description": "Unique identifier (GUID)"
              },
              "ItemCount": {
                "type": "integer",
                "title": "Item Count",
                "description": "Number of items in the folder"
              },
              "TimeCreated": {
                "type": "string",
                "title": "Time Created",
                "description": "Folder creation timestamp (ISO 8601)"
              },
              "WelcomePage": {
                "type": "string",
                "title": "Welcome Page",
                "description": "Welcome page URL"
              },
              "TimeLastModified": {
                "type": "string",
                "title": "Time Last Modified",
                "description": "Last modification timestamp (ISO 8601)"
              },
              "ServerRelativeUrl": {
                "type": "string",
                "title": "Server Relative Url",
                "description": "Server-relative URL path to the folder"
              }
            },
            "description": "SharePoint folder metadata properties.",
            "additionalProperties": true
          },
          "title": "Folders",
          "description": "Array of folder objects with metadata. Returns empty array if folder has no subfolders."
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

## SHARE_POINT_LOG_EVENT
Log custom usage analytics events in SharePoint for tracking user activities. Records usage events (views, edits, custom actions) to SharePoint's analytics system. Use this after performing actions to track usage patterns. The event will be logged to SharePoint's usage analytics database for reporting and analytics purposes. Common use cases: - Track document views or edits - Record custom user interactions - Log application-specific events for analytics Note: Obtain site/web GUIDs from GET /api/site or GET /api/web endpoints. Use consistent item_id, scope_id, and site GUIDs across related events for the same entity to ensure correct analytics grouping and correlation in reports.

**Input schema:**
```json
{
  "type": "object",
  "title": "LogEventRequest",
  "required": [
    "event_type_id",
    "item_id",
    "scope_id",
    "site_id",
    "user"
  ],
  "properties": {
    "user": {
      "type": "string",
      "title": "User",
      "examples": [
        "user@domain.com",
        "i:0#.f|membership|user@domain.com"
      ],
      "description": "User identifier who triggered the event. Can be email address (user@domain.com), display name, or SharePoint LoginName (i:0#.f|membership|user@domain.com)."
    },
    "item_id": {
      "type": "string",
      "title": "Item Id",
      "examples": [
        "5e304156-934d-4f4c-9d1e-05738a5f8a72"
      ],
      "description": "GUID of the item (document, list item, or web) related to this event. Can be a document ID, list item ID, web ID, or site collection ID."
    },
    "site_id": {
      "type": "string",
      "title": "Site Id",
      "examples": [
        "8f1106b0-6c8a-4a8f-aaa6-307738e1dd82"
      ],
      "description": "GUID of the site collection where the event occurred. Use the site collection ID from GET /api/site."
    },
    "scope_id": {
      "type": "string",
      "title": "Scope Id",
      "examples": [
        "8f1106b0-6c8a-4a8f-aaa6-307738e1dd82"
      ],
      "description": "GUID defining the scope/context of the event. Typically the web ID or site collection ID where the event occurred."
    },
    "site_name": {
      "type": "string",
      "title": "Site Name",
      "examples": [
        "composio-test"
      ],
      "description": "The subsite name to scope the request to (e.g., 'composio-test'). If omitted, the root site is used. When provided, the API base URL becomes 'https://{tenant}.sharepoint.com/sites/{site}'."
    },
    "event_type_id": {
      "type": "integer",
      "title": "Event Type Id",
      "minimum": 1,
      "examples": [
        1,
        2,
        3
      ],
      "description": "ID of the usage event type. Valid values are typically 1-4 for different SharePoint event types (e.g., 1=View, 2=Edit, 3=Custom). Use values 1-4 for standard tracking events."
    }
  },
  "description": "Request model for logging a usage event in SharePoint."
}
```

**Output schema:**
```json
{
  "type": "object",
  "$defs": {
    "LogEventResponse": {
      "type": "object",
      "title": "LogEventResponse",
      "required": [
        "status"
      ],
      "properties": {
        "status": {
          "type": "integer",
          "title": "Status",
          "description": "HTTP status code returned by the log event operation."
        }
      },
      "description": "Response model for the log event operation."
    }
  },
  "title": "LogEventResponseWrapper",
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
          "type": "integer",
          "title": "Status",
          "description": "HTTP status code returned by the log event operation."
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

## SHARE_POINT_RECYCLE_FILE
Tool to move a file to the Recycle Bin. Use when you need to recycle a file after confirming its folder and filename paths.

**Input schema:**
```json
{
  "type": "object",
  "title": "RecycleFileRequest",
  "required": [
    "folder_relative_url",
    "file_relative_url"
  ],
  "properties": {
    "site_name": {
      "type": "string",
      "title": "Site Name",
      "examples": [
        "composio-test",
        "testcomposio"
      ],
      "description": "The subsite name to scope the request to (e.g., 'composio-test'). If omitted, the root site is used. When provided, the API base URL becomes 'https://{tenant}.sharepoint.com/sites/{site}'."
    },
    "file_relative_url": {
      "type": "string",
      "title": "File Relative Url",
      "examples": [
        "document.docx"
      ],
      "description": "Relative URL of the file within the folder to recycle, e.g., 'document.docx'. Do not include a leading '/'."
    },
    "folder_relative_url": {
      "type": "string",
      "title": "Folder Relative Url",
      "examples": [
        "/Shared Documents/Folder1"
      ],
      "description": "Server-relative URL of the folder containing the file to recycle, e.g., '/Shared Documents/Folder1'."
    }
  },
  "description": "Request parameters for recycling a SharePoint file to the Recycle Bin."
}
```

**Output schema:**
```json
{
  "type": "object",
  "$defs": {
    "RecycleFileResponse": {
      "type": "object",
      "title": "RecycleFileResponse",
      "required": [
        "recycled_item_id"
      ],
      "properties": {
        "recycled_item_id": {
          "type": "string",
          "title": "Recycled Item Id",
          "description": "GUID of the recycled file item."
        }
      },
      "description": "Response model for recycled file."
    }
  },
  "title": "RecycleFileResponseWrapper",
  "required": [
    "data",
    "successful"
  ],
  "properties": {
    "data": {
      "type": "object",
      "title": "Data",
      "required": [
        "recycled_item_id"
      ],
      "properties": {
        "recycled_item_id": {
          "type": "string",
          "title": "Recycled Item Id",
          "description": "GUID of the recycled file item."
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

## SHARE_POINT_RECYCLE_LIST_ITEM
Tool to move a list item to the Recycle Bin. Use when you need to soft-delete an item but preserve the ability to restore it.

**Input schema:**
```json
{
  "type": "object",
  "title": "RecycleListItemRequest",
  "required": [
    "list_id",
    "item_id"
  ],
  "properties": {
    "item_id": {
      "type": "integer",
      "title": "Item Id",
      "minimum": 1,
      "examples": [
        1
      ],
      "description": "Numeric ID of the list item to recycle."
    },
    "list_id": {
      "type": "string",
      "title": "List Id",
      "examples": [
        "01234567-89ab-cdef-0123-456789abcdef"
      ],
      "description": "GUID of the SharePoint list containing the target item, in canonical format (e.g., '01234567-89ab-cdef-0123-456789abcdef')."
    },
    "site_name": {
      "type": "string",
      "title": "Site Name",
      "examples": [
        "composio-test",
        "testcomposio",
        "marketing"
      ],
      "description": "The subsite name to scope the request to (e.g., 'composio-test'). If omitted, the root site is used. When provided, the API base URL becomes https://{tenant}.sharepoint.com/sites/{site}."
    }
  },
  "additionalProperties": false
}
```

**Output schema:**
```json
{
  "type": "object",
  "$defs": {
    "RecycleListItemResponse": {
      "type": "object",
      "title": "RecycleListItemResponse",
      "required": [
        "recycle_bin_item_id"
      ],
      "properties": {
        "recycle_bin_item_id": {
          "type": "string",
          "title": "Recycle Bin Item Id",
          "examples": [
            "2162c659-abcd-1234-ef00-0000deadbeef"
          ],
          "description": "GUID of the newly created recycle-bin entry for the item."
        }
      }
    }
  },
  "title": "RecycleListItemResponseWrapper",
  "required": [
    "data",
    "successful"
  ],
  "properties": {
    "data": {
      "type": "object",
      "title": "Data",
      "required": [
        "recycle_bin_item_id"
      ],
      "properties": {
        "recycle_bin_item_id": {
          "type": "string",
          "title": "Recycle Bin Item Id",
          "examples": [
            "2162c659-abcd-1234-ef00-0000deadbeef"
          ],
          "description": "GUID of the newly created recycle-bin entry for the item."
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

## SHARE_POINT_RENAME_FOLDER
Renames a SharePoint folder by updating its list item metadata. To use this action: 1. First call GET_FOLDER_BY_SERVER_RELATIVE_URL with expand=ListItemAllFields to get the folder's metadata_type 2. Extract the '__metadata.type' value from the response's ListItemAllFields (e.g., 'SP.Data.Shared_x0020_DocumentsItem') 3. Call this action with the folder path, metadata_type, and new name The rename operation updates both the folder's display name (Title) and actual name (FileLeafRef). Note: This only changes the folder name, not its location in the hierarchy.

**Input schema:**
```json
{
  "type": "object",
  "title": "RenameFolderRequest",
  "required": [
    "server_relative_folder_url",
    "__metadata.type",
    "new_name"
  ],
  "properties": {
    "new_name": {
      "type": "string",
      "title": "New Name",
      "examples": [
        "NewFolder",
        "Renamed Folder 2024"
      ],
      "description": "New folder name (leaf name only, not full path). This will be used for both the display name (Title) and the actual folder name (FileLeafRef). Do not include path separators (/)."
    },
    "site_name": {
      "type": "string",
      "title": "Site Name",
      "examples": [
        "composio-test",
        "teamsite"
      ],
      "description": "The subsite name to scope the request to (e.g., 'composio-test'). If omitted, the root site is used. When provided, the API base URL becomes https://{tenant}.sharepoint.com/sites/{site}."
    },
    "match_etag": {
      "type": "string",
      "title": "Match Etag",
      "default": "*",
      "description": "ETag value for concurrency control. Use '*' (default) to overwrite regardless of the current version. To enforce version checking, obtain the ETag from GET_FOLDER_BY_SERVER_RELATIVE_URL with expand=ListItemAllFields, then use the '__metadata.etag' value."
    },
    "__metadata.type": {
      "type": "string",
      "title": "  Metadata.Type",
      "examples": [
        "SP.Data.Shared_x0020_DocumentsItem"
      ],
      "description": "OData entity type of the folder's list item. This is required by SharePoint's REST API. To obtain this value, first call GET_FOLDER_BY_SERVER_RELATIVE_URL with expand=ListItemAllFields, then extract the '__metadata.type' field from ListItemAllFields (typically 'SP.Data.Shared_x0020_DocumentsItem' for the 'Shared Documents' library, but varies by library name)."
    },
    "server_relative_folder_url": {
      "type": "string",
      "title": "Server Relative Folder Url",
      "examples": [
        "/Shared Documents/OldFolder",
        "/Shared Documents/Parent/OldFolder"
      ],
      "description": "Server-relative path of the folder to rename, including library and any parent folders. Must start with '/' and include the document library name. Example: '/Shared Documents/OldFolder' or '/Shared Documents/ParentFolder/OldFolder'."
    }
  },
  "additionalProperties": false
}
```

**Output schema:**
```json
{
  "type": "object",
  "$defs": {
    "RenameFolderResponse": {
      "type": "object",
      "title": "RenameFolderResponse",
      "required": [
        "message",
        "old_path",
        "new_name"
      ],
      "properties": {
        "message": {
          "type": "string",
          "title": "Message",
          "description": "Success message confirming the folder was renamed successfully."
        },
        "new_name": {
          "type": "string",
          "title": "New Name",
          "description": "The new name that was applied to the folder."
        },
        "old_path": {
          "type": "string",
          "title": "Old Path",
          "description": "The original server-relative path of the folder before renaming."
        }
      }
    }
  },
  "title": "RenameFolderResponseWrapper",
  "required": [
    "data",
    "successful"
  ],
  "properties": {
    "data": {
      "type": "object",
      "title": "Data",
      "required": [
        "message",
        "old_path",
        "new_name"
      ],
      "properties": {
        "message": {
          "type": "string",
          "title": "Message",
          "description": "Success message confirming the folder was renamed successfully."
        },
        "new_name": {
          "type": "string",
          "title": "New Name",
          "description": "The new name that was applied to the folder."
        },
        "old_path": {
          "type": "string",
          "title": "Old Path",
          "description": "The original server-relative path of the folder before renaming."
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

## SHARE_POINT_RENDER_LIST_DATA_AS_STREAM
Retrieve list items from SharePoint with rich metadata and formatting. Returns items in the 'Row' array along with pagination info (FirstRow, LastRow, NextHref). Supports CAML queries via ViewXml for filtering and sorting. Use this when you need list data with properly formatted field values, lookup fields, or managed metadata - more capable than standard OData endpoints.

**Input schema:**
```json
{
  "type": "object",
  "title": "RenderListDataAsStreamRequest",
  "required": [
    "list_server_relative_url"
  ],
  "properties": {
    "site_name": {
      "type": "string",
      "title": "Site Name",
      "examples": [
        "testcomposio",
        "marketing",
        "hr-portal"
      ],
      "description": "Optional SharePoint site name to scope the list data request. If provided, the list path is resolved relative to this site. If not provided and list_server_relative_url starts with '/sites/{site}/', the site is extracted automatically from the path. E.g., 'testcomposio' for a site at /sites/testcomposio."
    },
    "parameters": {
      "type": "object",
      "title": "RenderListDataAsStreamParameters",
      "properties": {
        "Paging": {
          "type": "string",
          "title": "Paging",
          "description": "Paging information string."
        },
        "ViewXml": {
          "type": "string",
          "title": "View Xml",
          "description": "CAML view XML to use for rendering. Example: '<View><RowLimit>10</RowLimit></View>' for simple paging, or '<View><Query><Where><Eq><FieldRef Name=\"Status\"/><Value Type=\"Text\">Active</Value></Eq></Where></Query><RowLimit>50</RowLimit></View>' for filtering. Use RowLimit to control page size."
        },
        "DatesInUtc": {
          "type": "boolean",
          "title": "Dates In Utc",
          "description": "Return DateTime fields in UTC."
        },
        "ExpandGroups": {
          "type": "boolean",
          "title": "Expand Groups",
          "description": "Expand grouping in returned data."
        },
        "ReplaceGroup": {
          "type": "boolean",
          "title": "Replace Group",
          "description": "Replace grouping to handle GroupBy throttling."
        },
        "RenderOptions": {
          "type": "integer",
          "title": "Render Options",
          "examples": [
            1,
            2,
            4
          ],
          "description": "Integer flags (SPRenderListDataOptions) to control output sections."
        },
        "FirstGroupOnly": {
          "type": "boolean",
          "title": "First Group Only",
          "description": "Return only the first group regardless of view schema."
        },
        "OverrideViewXml": {
          "type": "string",
          "title": "Override View Xml",
          "description": "CAML override for the view (applies only to Query/Where)."
        },
        "AddRequiredFields": {
          "type": "boolean",
          "title": "Add Required Fields",
          "description": "Include required fields in the response."
        },
        "FolderServerRelativeUrl": {
          "type": "string",
          "title": "Folder Server Relative Url",
          "description": "Server-relative URL of a folder to return items from."
        },
        "ImageFieldsToTryRewriteToCdnUrls": {
          "type": "string",
          "title": "Image Fields To Try Rewrite To Cdn Urls",
          "description": "Comma-separated field names to rewrite as CDN URLs."
        },
        "AllowMultipleValueFilterForTaxonomyFields": {
          "type": "boolean",
          "title": "Allow Multiple Value Filter For Taxonomy Fields",
          "description": "Allow multi-value filtering for taxonomy fields."
        }
      },
      "description": "Body parameters to control rendering options for RenderListDataAsStream.",
      "additionalProperties": false
    },
    "query_params": {
      "type": "object",
      "title": "Query Params",
      "description": "Optional query string parameters to control view behavior. See documentation for supported keys.",
      "additionalProperties": {
        "anyOf": [
          {
            "type": "string"
          },
          {
            "type": "integer"
          },
          {
            "type": "boolean"
          }
        ]
      }
    },
    "list_server_relative_url": {
      "type": "string",
      "title": "List Server Relative Url",
      "examples": [
        "/Lists/Orders",
        "/Shared Documents",
        "/sites/team-a/Lists/Orders"
      ],
      "description": "Server-relative URL of the list. If 'site' parameter is provided, this should be the path relative to that site (e.g., '/Lists/Orders' or '/Shared Documents'). If 'site' is not provided and the path does not start with '/sites/', it's resolved relative to the tenant root."
    }
  },
  "description": "Request parameters for rendering list data as a stream with complex fields.",
  "additionalProperties": false
}
```

**Output schema:**
```json
{
  "type": "object",
  "$defs": {
    "RenderListDataAsStreamResponse": {
      "type": "object",
      "title": "RenderListDataAsStreamResponse",
      "properties": {
        "Row": {
          "type": "array",
          "items": {
            "type": "object",
            "additionalProperties": true
          },
          "title": "Row",
          "description": "Array of list items. Each item is a dict with field names as keys and field values. This is the primary field containing the actual list data."
        },
        "LastRow": {
          "type": "integer",
          "title": "Last Row",
          "description": "Index of the last row in this batch (used for paging)."
        },
        "FirstRow": {
          "type": "integer",
          "title": "First Row",
          "description": "Index of the first row in this batch (used for paging)."
        },
        "ListData": {
          "type": "object",
          "title": "List Data",
          "description": "List data metadata section, present when RenderOptions includes ListData flag.",
          "additionalProperties": true
        },
        "MenuView": {
          "type": "string",
          "title": "Menu View",
          "description": "HTML for list menu, present when RenderOptions includes MenuView flag."
        },
        "NextHref": {
          "type": "string",
          "title": "Next Href",
          "description": "URL for the next page of results. If absent, all data has been returned."
        },
        "PrevHref": {
          "type": "string",
          "title": "Prev Href",
          "description": "URL for the previous page of results."
        },
        "RowLimit": {
          "type": "integer",
          "title": "Row Limit",
          "description": "Number of items per page."
        },
        "Spotlight": {
          "type": "object",
          "title": "Spotlight",
          "description": "Spotlight rendering info, present when RenderOptions includes Spotlight flag.",
          "additionalProperties": true
        },
        "FilterLink": {
          "type": "string",
          "title": "Filter Link",
          "description": "Filter information for the current view."
        },
        "ListSchema": {
          "type": "object",
          "title": "List Schema",
          "description": "List schema section with field definitions, present when RenderOptions includes ListSchema flag.",
          "additionalProperties": true
        },
        "ParentInfo": {
          "type": "object",
          "title": "Parent Info",
          "description": "Parent folder info, present when RenderOptions includes ParentInfo flag.",
          "additionalProperties": true
        },
        "ContextInfo": {
          "type": "object",
          "title": "Context Info",
          "description": "List context info section, present when RenderOptions includes ContextInfo flag.",
          "additionalProperties": true
        },
        "QuickLaunch": {
          "type": "array",
          "items": {
            "type": "object",
            "additionalProperties": true
          },
          "title": "Quick Launch",
          "description": "QuickLaunch navigation nodes, present when RenderOptions includes QuickLaunch flag."
        },
        "ViewMetadata": {
          "type": "object",
          "title": "View Metadata",
          "description": "View XML and related info, present when RenderOptions includes ViewMetadata flag.",
          "additionalProperties": true
        },
        "Visualization": {
          "type": "object",
          "title": "Visualization",
          "description": "Visualization rendering info, present when RenderOptions includes Visualization flag.",
          "additionalProperties": true
        },
        "ListContentType": {
          "type": "object",
          "title": "List Content Type",
          "description": "List content types, present when RenderOptions includes ListContentType flag.",
          "additionalProperties": true
        },
        "PageContextInfo": {
          "type": "object",
          "title": "Page Context Info",
          "description": "Page context info, present when RenderOptions includes PageContextInfo flag.",
          "additionalProperties": true
        },
        "ClientFormSchema": {
          "type": "object",
          "title": "Client Form Schema",
          "description": "Client form schema for add/edit, present when RenderOptions includes ClientFormSchema flag.",
          "additionalProperties": true
        },
        "FileSystemItemId": {
          "type": "object",
          "title": "File System Item Id",
          "description": "File system item IDs per item, present when RenderOptions includes FileSystemItemId flag.",
          "additionalProperties": true
        },
        "ForceNoHierarchy": {
          "type": "string",
          "title": "Force No Hierarchy",
          "description": "Indicates if hierarchy is disabled."
        },
        "EnableMediaTAUrls": {
          "type": "object",
          "title": "Enable Media Ta Urls",
          "description": "Media transformation URLs info, present when RenderOptions includes EnableMediaTAUrls flag.",
          "additionalProperties": true
        },
        "DisableAutoHyperlink": {
          "type": "object",
          "title": "Disable Auto Hyperlink",
          "description": "Hyperlink disabling info, present when RenderOptions includes DisableAutoHyperlink flag.",
          "additionalProperties": true
        },
        "HierarchyHasIndention": {
          "type": "string",
          "title": "Hierarchy Has Indention",
          "description": "Indicates if hierarchy has indentation."
        },
        "CurrentFolderSpItemUrl": {
          "type": "string",
          "title": "Current Folder Sp Item Url",
          "description": "URL of the current folder item."
        },
        "ClientSideComponentManifest": {
          "type": "object",
          "title": "Client Side Component Manifest",
          "description": "Client-side component manifest info, present when RenderOptions includes ClientSideComponentManifest flag.",
          "additionalProperties": true
        }
      },
      "description": "Response model for RenderListDataAsStream API."
    }
  },
  "title": "RenderListDataAsStreamResponseWrapper",
  "required": [
    "data",
    "successful"
  ],
  "properties": {
    "data": {
      "type": "object",
      "title": "Data",
      "properties": {
        "Row": {
          "type": "array",
          "items": {
            "type": "object",
            "additionalProperties": true
          },
          "title": "Row",
          "description": "Array of list items. Each item is a dict with field names as keys and field values. This is the primary field containing the actual list data."
        },
        "LastRow": {
          "type": "integer",
          "title": "Last Row",
          "description": "Index of the last row in this batch (used for paging)."
        },
        "FirstRow": {
          "type": "integer",
          "title": "First Row",
          "description": "Index of the first row in this batch (used for paging)."
        },
        "ListData": {
          "type": "object",
          "title": "List Data",
          "description": "List data metadata section, present when RenderOptions includes ListData flag.",
          "additionalProperties": true
        },
        "MenuView": {
          "type": "string",
          "title": "Menu View",
          "description": "HTML for list menu, present when RenderOptions includes MenuView flag."
        },
        "NextHref": {
          "type": "string",
          "title": "Next Href",
          "description": "URL for the next page of results. If absent, all data has been returned."
        },
        "PrevHref": {
          "type": "string",
          "title": "Prev Href",
          "description": "URL for the previous page of results."
        },
        "RowLimit": {
          "type": "integer",
          "title": "Row Limit",
          "description": "Number of items per page."
        },
        "Spotlight": {
          "type": "object",
          "title": "Spotlight",
          "description": "Spotlight rendering info, present when RenderOptions includes Spotlight flag.",
          "additionalProperties": true
        },
        "FilterLink": {
          "type": "string",
          "title": "Filter Link",
          "description": "Filter information for the current view."
        },
        "ListSchema": {
          "type": "object",
          "title": "List Schema",
          "description": "List schema section with field definitions, present when RenderOptions includes ListSchema flag.",
          "additionalProperties": true
        },
        "ParentInfo": {
          "type": "object",
          "title": "Parent Info",
          "description": "Parent folder info, present when RenderOptions includes ParentInfo flag.",
          "additionalProperties": true
        },
        "ContextInfo": {
          "type": "object",
          "title": "Context Info",
          "description": "List context info section, present when RenderOptions includes ContextInfo flag.",
          "additionalProperties": true
        },
        "QuickLaunch": {
          "type": "array",
          "items": {
            "type": "object",
            "additionalProperties": true
          },
          "title": "Quick Launch",
          "description": "QuickLaunch navigation nodes, present when RenderOptions includes QuickLaunch flag."
        },
        "ViewMetadata": {
          "type": "object",
          "title": "View Metadata",
          "description": "View XML and related info, present when RenderOptions includes ViewMetadata flag.",
          "additionalProperties": true
        },
        "Visualization": {
          "type": "object",
          "title": "Visualization",
          "description": "Visualization rendering info, present when RenderOptions includes Visualization flag.",
          "additionalProperties": true
        },
        "ListContentType": {
          "type": "object",
          "title": "List Content Type",
          "description": "List content types, present when RenderOptions includes ListContentType flag.",
          "additionalProperties": true
        },
        "PageContextInfo": {
          "type": "object",
          "title": "Page Context Info",
          "description": "Page context info, present when RenderOptions includes PageContextInfo flag.",
          "additionalProperties": true
        },
        "ClientFormSchema": {
          "type": "object",
          "title": "Client Form Schema",
          "description": "Client form schema for add/edit, present when RenderOptions includes ClientFormSchema flag.",
          "additionalProperties": true
        },
        "FileSystemItemId": {
          "type": "object",
          "title": "File System Item Id",
          "description": "File system item IDs per item, present when RenderOptions includes FileSystemItemId flag.",
          "additionalProperties": true
        },
        "ForceNoHierarchy": {
          "type": "string",
          "title": "Force No Hierarchy",
          "description": "Indicates if hierarchy is disabled."
        },
        "EnableMediaTAUrls": {
          "type": "object",
          "title": "Enable Media Ta Urls",
          "description": "Media transformation URLs info, present when RenderOptions includes EnableMediaTAUrls flag.",
          "additionalProperties": true
        },
        "DisableAutoHyperlink": {
          "type": "object",
          "title": "Disable Auto Hyperlink",
          "description": "Hyperlink disabling info, present when RenderOptions includes DisableAutoHyperlink flag.",
          "additionalProperties": true
        },
        "HierarchyHasIndention": {
          "type": "string",
          "title": "Hierarchy Has Indention",
          "description": "Indicates if hierarchy has indentation."
        },
        "CurrentFolderSpItemUrl": {
          "type": "string",
          "title": "Current Folder Sp Item Url",
          "description": "URL of the current folder item."
        },
        "ClientSideComponentManifest": {
          "type": "object",
          "title": "Client Side Component Manifest",
          "description": "Client-side component manifest info, present when RenderOptions includes ClientSideComponentManifest flag.",
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

## SHARE_POINT_RESTORE_DRIVE_ITEM_VERSION
Tool to restore a previous version of a SharePoint drive item. Use when you need to revert a file to an earlier version.

**Input schema:**
```json
{
  "type": "object",
  "title": "RestoreDriveItemVersionRequest",
  "required": [
    "drive_id",
    "driveItem_id",
    "driveItemVersion_id"
  ],
  "properties": {
    "drive_id": {
      "type": "string",
      "title": "Drive Id",
      "examples": [
        "b!sAYRj4psj0qqpjB3OOHdglZBMF5Nk0xPnR4Fc4pfinI6LsO0Ty3NT6hz1n27BFpo"
      ],
      "description": "The unique identifier of the drive containing the item"
    },
    "driveItem_id": {
      "type": "string",
      "title": "Drive Item Id",
      "examples": [
        "01K67O4VSVYSGCL3MHHNDIESCQSPJ6CCZP"
      ],
      "description": "The unique identifier of the drive item (file or folder) to restore"
    },
    "driveItemVersion_id": {
      "type": "string",
      "title": "Drive Item Version Id",
      "examples": [
        "23.0",
        "1.0"
      ],
      "description": "The unique identifier or version number of the version to restore (e.g., '23.0', '1.0')"
    }
  },
  "description": "Request parameters for restoring a specific version of a drive item."
}
```

**Output schema:**
```json
{
  "type": "object",
  "$defs": {
    "RestoreDriveItemVersionResponse": {
      "type": "object",
      "title": "RestoreDriveItemVersionResponse",
      "required": [
        "message",
        "drive_id",
        "driveItem_id",
        "driveItemVersion_id"
      ],
      "properties": {
        "message": {
          "type": "string",
          "title": "Message",
          "description": "Status message indicating the version was successfully restored"
        },
        "drive_id": {
          "type": "string",
          "title": "Drive Id",
          "description": "The drive ID of the restored item"
        },
        "driveItem_id": {
          "type": "string",
          "title": "Drive Item Id",
          "description": "The drive item ID that was restored"
        },
        "driveItemVersion_id": {
          "type": "string",
          "title": "Drive Item Version Id",
          "description": "The version ID that was restored"
        }
      },
      "description": "Response model indicating result of restore version operation."
    }
  },
  "title": "RestoreDriveItemVersionResponseWrapper",
  "required": [
    "data",
    "successful"
  ],
  "properties": {
    "data": {
      "type": "object",
      "title": "Data",
      "required": [
        "message",
        "drive_id",
        "driveItem_id",
        "driveItemVersion_id"
      ],
      "properties": {
        "message": {
          "type": "string",
          "title": "Message",
          "description": "Status message indicating the version was successfully restored"
        },
        "drive_id": {
          "type": "string",
          "title": "Drive Id",
          "description": "The drive ID of the restored item"
        },
        "driveItem_id": {
          "type": "string",
          "title": "Drive Item Id",
          "description": "The drive item ID that was restored"
        },
        "driveItemVersion_id": {
          "type": "string",
          "title": "Drive Item Version Id",
          "description": "The version ID that was restored"
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

## SHARE_POINT_RESTORE_RECYCLE_BIN_ITEM
Tool to restore a SharePoint Recycle Bin item. Use when you need to recover a deleted item by providing its GUID.

**Input schema:**
```json
{
  "type": "object",
  "title": "RestoreRecycleBinItemRequest",
  "required": [
    "recyclebinitemid"
  ],
  "properties": {
    "site_name": {
      "type": "string",
      "title": "Site Name",
      "examples": [
        "composio-test"
      ],
      "description": "The subsite name to scope the request to (e.g., 'composio-test'). If omitted, the root site is used. When provided, the API base URL becomes https://{tenant}.sharepoint.com/sites/{site}."
    },
    "recyclebinitemid": {
      "type": "string",
      "title": "Recyclebinitemid",
      "examples": [
        "123e4567-e89b-12d3-a456-426614174000"
      ],
      "description": "GUID of the Recycle Bin item to restore. Must be a valid GUID string."
    }
  },
  "description": "Request parameters for restoring a SharePoint Recycle Bin item.",
  "additionalProperties": false
}
```

**Output schema:**
```json
{
  "type": "object",
  "$defs": {
    "RestoreRecycleBinItemResponse": {
      "type": "object",
      "title": "RestoreRecycleBinItemResponse",
      "required": [
        "message"
      ],
      "properties": {
        "message": {
          "type": "string",
          "title": "Message",
          "description": "Status message indicating the restore result"
        }
      },
      "description": "Response model indicating result of restore operation."
    }
  },
  "title": "RestoreRecycleBinItemResponseWrapper",
  "required": [
    "data",
    "successful"
  ],
  "properties": {
    "data": {
      "type": "object",
      "title": "Data",
      "required": [
        "message"
      ],
      "properties": {
        "message": {
          "type": "string",
          "title": "Message",
          "description": "Status message indicating the restore result"
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

## SHARE_POINT_SEARCH_QUERY
Search SharePoint content using Keyword Query Language (KQL). Returns documents, list items, folders, and other content matching your query. Supports filtering by properties (file type, author, date), pagination, and custom property selection. Results are nested under PrimaryQueryResult→RelevantResults→Table→Rows→Cells as Key/Value pairs requiring explicit extraction. Results are security-trimmed: inaccessible content never appears even if it exists. Use contentclass (e.g., STS_Site, STS_Web, STS_ListItem_DocumentLibrary) in querytext to isolate specific item types.

**Input schema:**
```json
{
  "type": "object",
  "title": "SearchQueryRequest",
  "required": [
    "querytext"
  ],
  "properties": {
    "rowlimit": {
      "type": "integer",
      "title": "Rowlimit",
      "maximum": 500,
      "minimum": 1,
      "examples": [
        10
      ],
      "description": "Maximum number of results to return per request. Default is determined by SharePoint (typically 50). Maximum is 500."
    },
    "startrow": {
      "type": "integer",
      "title": "Startrow",
      "minimum": 0,
      "examples": [
        0
      ],
      "description": "Zero-based index of the first result to return. Use for pagination (e.g., startrow=0 for page 1, startrow=10 for page 2 with rowlimit=10). Compare TotalRows vs RowCount in the response to determine if additional pages exist; increment startrow by rowlimit until all results are retrieved."
    },
    "querytext": {
      "type": "string",
      "title": "Querytext",
      "examples": [
        "SharePoint"
      ],
      "description": "The search query using Keyword Query Language (KQL) syntax. Examples: 'project report', 'IsDocument:1', 'FileType:docx', 'Author:\"John Doe\"'. Broad queries (e.g., '.xlsx' alone) return noisy large result sets; narrow with site paths, Author, date ranges, or other KQL properties. Filter by contentclass to isolate specific item types."
    },
    "site_name": {
      "type": "string",
      "title": "Site Name",
      "examples": [
        "composio-test"
      ],
      "description": "The subsite name to scope the request to (e.g., 'composio-test'). If omitted, the root site is used. When provided, the API base URL becomes 'https://{tenant}.sharepoint.com/sites/{site}'."
    },
    "selectproperties": {
      "type": "string",
      "title": "Selectproperties",
      "examples": [
        "Title,Author,Path"
      ],
      "description": "Comma-separated list of managed property names to return in results. If not specified, SharePoint returns a default set of properties. Common properties: Title, Author, Path, Size, LastModifiedTime, FileType. Include SiteId and WebId alongside Path to disambiguate items sharing the same title across different locations."
    },
    "refinementfilters": {
      "type": "string",
      "title": "Refinementfilters",
      "examples": [
        "FileType:equals(\"docx\")"
      ],
      "description": "Refinement filters to narrow search results. Format: 'PropertyName:value' or use FQL syntax for complex filters. Example: 'FileType:equals(\"docx\")'."
    }
  },
  "description": "Request parameters for executing a SharePoint search query.",
  "additionalProperties": false
}
```

**Output schema:**
```json
{
  "type": "object",
  "$defs": {
    "Refiner": {
      "type": "object",
      "title": "Refiner",
      "required": [
        "Entries",
        "Name"
      ],
      "properties": {
        "Name": {
          "type": "string",
          "title": "Name",
          "description": "Name of the refiner (managed property)."
        },
        "Entries": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "RefinementEntry",
            "required": [
              "RefinementCount",
              "RefinementName",
              "RefinementToken",
              "RefinementValue"
            ],
            "properties": {
              "RefinementName": {
                "type": "string",
                "title": "Refinement Name",
                "description": "Display name for the refinement bin (e.g., 'Html', 'From 2023-01-01 up to 2023-12-31')."
              },
              "RefinementCount": {
                "type": "string",
                "title": "Refinement Count",
                "description": "Number of items matching this refinement bin."
              },
              "RefinementToken": {
                "type": "string",
                "title": "Refinement Token",
                "description": "Token used with RefinerName to construct refinement filters for refined queries."
              },
              "RefinementValue": {
                "type": "string",
                "title": "Refinement Value",
                "description": "Implementation-specific formatted string representing the refinement."
              }
            },
            "description": "Represents a single refinement option within a refiner."
          },
          "title": "Entries",
          "description": "Array of refinement options for this refiner."
        }
      },
      "description": "Contains refinement entries for a specific managed property."
    },
    "RefinementEntry": {
      "type": "object",
      "title": "RefinementEntry",
      "required": [
        "RefinementCount",
        "RefinementName",
        "RefinementToken",
        "RefinementValue"
      ],
      "properties": {
        "RefinementName": {
          "type": "string",
          "title": "Refinement Name",
          "description": "Display name for the refinement bin (e.g., 'Html', 'From 2023-01-01 up to 2023-12-31')."
        },
        "RefinementCount": {
          "type": "string",
          "title": "Refinement Count",
          "description": "Number of items matching this refinement bin."
        },
        "RefinementToken": {
          "type": "string",
          "title": "Refinement Token",
          "description": "Token used with RefinerName to construct refinement filters for refined queries."
        },
        "RefinementValue": {
          "type": "string",
          "title": "Refinement Value",
          "description": "Implementation-specific formatted string representing the refinement."
        }
      },
      "description": "Represents a single refinement option within a refiner."
    },
    "SearchResultRow": {
      "type": "object",
      "title": "SearchResultRow",
      "required": [
        "Cells"
      ],
      "properties": {
        "Cells": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "SearchResultCell",
            "required": [
              "Key",
              "ValueType"
            ],
            "properties": {
              "Key": {
                "type": "string",
                "title": "Key",
                "description": "Property name (e.g., Title, Author, Path)."
              },
              "Value": {
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
                  }
                ],
                "title": "Value",
                "description": "Property value. Type varies by property."
              },
              "ValueType": {
                "type": "string",
                "title": "Value Type",
                "description": "OData type of the value (e.g., Edm.String, Edm.Int64, Null)."
              }
            },
            "description": "Represents a single cell in a search result row containing property key-value pairs."
          },
          "title": "Cells",
          "description": "Array of cells containing property key-value pairs for this result."
        }
      },
      "description": "Represents a single search result row."
    },
    "SearchResultCell": {
      "type": "object",
      "title": "SearchResultCell",
      "required": [
        "Key",
        "ValueType"
      ],
      "properties": {
        "Key": {
          "type": "string",
          "title": "Key",
          "description": "Property name (e.g., Title, Author, Path)."
        },
        "Value": {
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
            }
          ],
          "title": "Value",
          "description": "Property value. Type varies by property."
        },
        "ValueType": {
          "type": "string",
          "title": "Value Type",
          "description": "OData type of the value (e.g., Edm.String, Edm.Int64, Null)."
        }
      },
      "description": "Represents a single cell in a search result row containing property key-value pairs."
    },
    "SearchResultTable": {
      "type": "object",
      "title": "SearchResultTable",
      "required": [
        "Rows"
      ],
      "properties": {
        "Rows": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "SearchResultRow",
            "required": [
              "Cells"
            ],
            "properties": {
              "Cells": {
                "type": "array",
                "items": {
                  "type": "object",
                  "title": "SearchResultCell",
                  "required": [
                    "Key",
                    "ValueType"
                  ],
                  "properties": {
                    "Key": {
                      "type": "string",
                      "title": "Key",
                      "description": "Property name (e.g., Title, Author, Path)."
                    },
                    "Value": {
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
                        }
                      ],
                      "title": "Value",
                      "description": "Property value. Type varies by property."
                    },
                    "ValueType": {
                      "type": "string",
                      "title": "Value Type",
                      "description": "OData type of the value (e.g., Edm.String, Edm.Int64, Null)."
                    }
                  },
                  "description": "Represents a single cell in a search result row containing property key-value pairs."
                },
                "title": "Cells",
                "description": "Array of cells containing property key-value pairs for this result."
              }
            },
            "description": "Represents a single search result row."
          },
          "title": "Rows",
          "description": "Array of search result rows."
        }
      },
      "description": "Contains the rows of search results."
    },
    "SearchResultsModel": {
      "type": "object",
      "title": "SearchResultsModel",
      "required": [
        "ElapsedTime",
        "PrimaryQueryResult",
        "Properties",
        "SecondaryQueryResults",
        "TriggeredRules"
      ],
      "properties": {
        "Properties": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "SearchResultCell",
            "required": [
              "Key",
              "ValueType"
            ],
            "properties": {
              "Key": {
                "type": "string",
                "title": "Key",
                "description": "Property name (e.g., Title, Author, Path)."
              },
              "Value": {
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
                  }
                ],
                "title": "Value",
                "description": "Property value. Type varies by property."
              },
              "ValueType": {
                "type": "string",
                "title": "Value Type",
                "description": "OData type of the value (e.g., Edm.String, Edm.Int64, Null)."
              }
            },
            "description": "Represents a single cell in a search result row containing property key-value pairs."
          },
          "title": "Properties",
          "description": "Additional query metadata and settings."
        },
        "ElapsedTime": {
          "type": "integer",
          "title": "Elapsed Time",
          "description": "Query execution time in milliseconds."
        },
        "TriggeredRules": {
          "type": "array",
          "items": {
            "type": "object",
            "additionalProperties": true
          },
          "title": "Triggered Rules",
          "description": "Query rules that were triggered."
        },
        "PrimaryQueryResult": {
          "type": "object",
          "title": "Primary Query Result",
          "required": [
            "CustomResults",
            "QueryId",
            "QueryRuleId",
            "RelevantResults"
          ],
          "properties": {
            "QueryId": {
              "type": "string",
              "title": "Query Id",
              "description": "Unique identifier for the query."
            },
            "QueryRuleId": {
              "type": "string",
              "title": "Query Rule Id",
              "description": "ID of the query rule that was applied, if any."
            },
            "CustomResults": {
              "type": "array",
              "items": {
                "type": "object",
                "additionalProperties": true
              },
              "title": "Custom Results",
              "description": "Custom results based on query rules."
            },
            "RelevantResults": {
              "type": "object",
              "title": "Relevant Results",
              "required": [
                "Properties",
                "RowCount",
                "Table",
                "TotalRows",
                "TotalRowsIncludingDuplicates"
              ],
              "properties": {
                "Table": {
                  "type": "object",
                  "title": "Table",
                  "required": [
                    "Rows"
                  ],
                  "properties": {
                    "Rows": {
                      "type": "array",
                      "items": {
                        "type": "object",
                        "title": "SearchResultRow",
                        "required": [
                          "Cells"
                        ],
                        "properties": {
                          "Cells": {
                            "type": "array",
                            "items": {
                              "type": "object",
                              "title": "SearchResultCell",
                              "required": [
                                "Key",
                                "ValueType"
                              ],
                              "properties": {
                                "Key": {
                                  "type": "string",
                                  "title": "Key",
                                  "description": "Property name (e.g., Title, Author, Path)."
                                },
                                "Value": {
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
                                    }
                                  ],
                                  "title": "Value",
                                  "description": "Property value. Type varies by property."
                                },
                                "ValueType": {
                                  "type": "string",
                                  "title": "Value Type",
                                  "description": "OData type of the value (e.g., Edm.String, Edm.Int64, Null)."
                                }
                              },
                              "description": "Represents a single cell in a search result row containing property key-value pairs."
                            },
                            "title": "Cells",
                            "description": "Array of cells containing property key-value pairs for this result."
                          }
                        },
                        "description": "Represents a single search result row."
                      },
                      "title": "Rows",
                      "description": "Array of search result rows."
                    }
                  },
                  "description": "Table containing search result rows."
                },
                "RowCount": {
                  "type": "integer",
                  "title": "Row Count",
                  "description": "Number of results returned in this response."
                },
                "TotalRows": {
                  "type": "integer",
                  "title": "Total Rows",
                  "description": "Total number of results matching the query (excluding duplicates)."
                },
                "Properties": {
                  "type": "array",
                  "items": {
                    "type": "object",
                    "title": "SearchResultCell",
                    "required": [
                      "Key",
                      "ValueType"
                    ],
                    "properties": {
                      "Key": {
                        "type": "string",
                        "title": "Key",
                        "description": "Property name (e.g., Title, Author, Path)."
                      },
                      "Value": {
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
                          }
                        ],
                        "title": "Value",
                        "description": "Property value. Type varies by property."
                      },
                      "ValueType": {
                        "type": "string",
                        "title": "Value Type",
                        "description": "OData type of the value (e.g., Edm.String, Edm.Int64, Null)."
                      }
                    },
                    "description": "Represents a single cell in a search result row containing property key-value pairs."
                  },
                  "title": "Properties",
                  "description": "Additional metadata properties for the result set."
                },
                "ResultTitle": {
                  "type": "string",
                  "title": "Result Title",
                  "description": "Title for the result block."
                },
                "ItemTemplateId": {
                  "type": "string",
                  "title": "Item Template Id",
                  "description": "Template ID for rendering items."
                },
                "ResultTitleUrl": {
                  "type": "string",
                  "title": "Result Title Url",
                  "description": "URL for the result block title."
                },
                "GroupTemplateId": {
                  "type": "string",
                  "title": "Group Template Id",
                  "description": "Template ID for grouping results."
                },
                "TotalRowsIncludingDuplicates": {
                  "type": "integer",
                  "title": "Total Rows Including Duplicates",
                  "description": "Total number of results including duplicates."
                }
              },
              "description": "Main search results."
            },
            "RefinementResults": {
              "type": "object",
              "title": "Refinement Results",
              "required": [
                "Refiners"
              ],
              "properties": {
                "Refiners": {
                  "type": "array",
                  "items": {
                    "type": "object",
                    "title": "Refiner",
                    "required": [
                      "Entries",
                      "Name"
                    ],
                    "properties": {
                      "Name": {
                        "type": "string",
                        "title": "Name",
                        "description": "Name of the refiner (managed property)."
                      },
                      "Entries": {
                        "type": "array",
                        "items": {
                          "type": "object",
                          "title": "RefinementEntry",
                          "required": [
                            "RefinementCount",
                            "RefinementName",
                            "RefinementToken",
                            "RefinementValue"
                          ],
                          "properties": {
                            "RefinementName": {
                              "type": "string",
                              "title": "Refinement Name",
                              "description": "Display name for the refinement bin (e.g., 'Html', 'From 2023-01-01 up to 2023-12-31')."
                            },
                            "RefinementCount": {
                              "type": "string",
                              "title": "Refinement Count",
                              "description": "Number of items matching this refinement bin."
                            },
                            "RefinementToken": {
                              "type": "string",
                              "title": "Refinement Token",
                              "description": "Token used with RefinerName to construct refinement filters for refined queries."
                            },
                            "RefinementValue": {
                              "type": "string",
                              "title": "Refinement Value",
                              "description": "Implementation-specific formatted string representing the refinement."
                            }
                          },
                          "description": "Represents a single refinement option within a refiner."
                        },
                        "title": "Entries",
                        "description": "Array of refinement options for this refiner."
                      }
                    },
                    "description": "Contains refinement entries for a specific managed property."
                  },
                  "title": "Refiners",
                  "description": "Array of refiners with refinement options."
                }
              },
              "description": "Refinement/facet results for filtering."
            },
            "SpecialTermResults": {
              "type": "object",
              "title": "Special Term Results",
              "description": "Results for special terms in the query.",
              "additionalProperties": true
            }
          },
          "description": "Primary query results."
        },
        "SpellingSuggestion": {
          "type": "string",
          "title": "Spelling Suggestion",
          "description": "Spelling suggestion for the query, if applicable."
        },
        "SecondaryQueryResults": {
          "type": "array",
          "items": {
            "type": "object",
            "additionalProperties": true
          },
          "title": "Secondary Query Results",
          "description": "Results from secondary queries."
        }
      },
      "description": "Complete SharePoint search response structure."
    },
    "SearchQueryResponse": {
      "type": "object",
      "title": "SearchQueryResponse",
      "required": [
        "search_results"
      ],
      "properties": {
        "search_results": {
          "type": "object",
          "title": "Search Results",
          "required": [
            "ElapsedTime",
            "PrimaryQueryResult",
            "Properties",
            "SecondaryQueryResults",
            "TriggeredRules"
          ],
          "properties": {
            "Properties": {
              "type": "array",
              "items": {
                "type": "object",
                "title": "SearchResultCell",
                "required": [
                  "Key",
                  "ValueType"
                ],
                "properties": {
                  "Key": {
                    "type": "string",
                    "title": "Key",
                    "description": "Property name (e.g., Title, Author, Path)."
                  },
                  "Value": {
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
                      }
                    ],
                    "title": "Value",
                    "description": "Property value. Type varies by property."
                  },
                  "ValueType": {
                    "type": "string",
                    "title": "Value Type",
                    "description": "OData type of the value (e.g., Edm.String, Edm.Int64, Null)."
                  }
                },
                "description": "Represents a single cell in a search result row containing property key-value pairs."
              },
              "title": "Properties",
              "description": "Additional query metadata and settings."
            },
            "ElapsedTime": {
              "type": "integer",
              "title": "Elapsed Time",
              "description": "Query execution time in milliseconds."
            },
            "TriggeredRules": {
              "type": "array",
              "items": {
                "type": "object",
                "additionalProperties": true
              },
              "title": "Triggered Rules",
              "description": "Query rules that were triggered."
            },
            "PrimaryQueryResult": {
              "type": "object",
              "title": "Primary Query Result",
              "required": [
                "CustomResults",
                "QueryId",
                "QueryRuleId",
                "RelevantResults"
              ],
              "properties": {
                "QueryId": {
                  "type": "string",
                  "title": "Query Id",
                  "description": "Unique identifier for the query."
                },
                "QueryRuleId": {
                  "type": "string",
                  "title": "Query Rule Id",
                  "description": "ID of the query rule that was applied, if any."
                },
                "CustomResults": {
                  "type": "array",
                  "items": {
                    "type": "object",
                    "additionalProperties": true
                  },
                  "title": "Custom Results",
                  "description": "Custom results based on query rules."
                },
                "RelevantResults": {
                  "type": "object",
                  "title": "Relevant Results",
                  "required": [
                    "Properties",
                    "RowCount",
                    "Table",
                    "TotalRows",
                    "TotalRowsIncludingDuplicates"
                  ],
                  "properties": {
                    "Table": {
                      "type": "object",
                      "title": "Table",
                      "required": [
                        "Rows"
                      ],
                      "properties": {
                        "Rows": {
                          "type": "array",
                          "items": {
                            "type": "object",
                            "title": "SearchResultRow",
                            "required": [
                              "Cells"
                            ],
                            "properties": {
                              "Cells": {
                                "type": "array",
                                "items": {
                                  "type": "object",
                                  "title": "SearchResultCell",
                                  "required": [
                                    "Key",
                                    "ValueType"
                                  ],
                                  "properties": {
                                    "Key": {
                                      "type": "string",
                                      "title": "Key",
                                      "description": "Property name (e.g., Title, Author, Path)."
                                    },
                                    "Value": {
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
                                        }
                                      ],
                                      "title": "Value",
                                      "description": "Property value. Type varies by property."
                                    },
                                    "ValueType": {
                                      "type": "string",
                                      "title": "Value Type",
                                      "description": "OData type of the value (e.g., Edm.String, Edm.Int64, Null)."
                                    }
                                  },
                                  "description": "Represents a single cell in a search result row containing property key-value pairs."
                                },
                                "title": "Cells",
                                "description": "Array of cells containing property key-value pairs for this result."
                              }
                            },
                            "description": "Represents a single search result row."
                          },
                          "title": "Rows",
                          "description": "Array of search result rows."
                        }
                      },
                      "description": "Table containing search result rows."
                    },
                    "RowCount": {
                      "type": "integer",
                      "title": "Row Count",
                      "description": "Number of results returned in this response."
                    },
                    "TotalRows": {
                      "type": "integer",
                      "title": "Total Rows",
                      "description": "Total number of results matching the query (excluding duplicates)."
                    },
                    "Properties": {
                      "type": "array",
                      "items": {
                        "type": "object",
                        "title": "SearchResultCell",
                        "required": [
                          "Key",
                          "ValueType"
                        ],
                        "properties": {
                          "Key": {
                            "type": "string",
                            "title": "Key",
                            "description": "Property name (e.g., Title, Author, Path)."
                          },
                          "Value": {
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
                              }
                            ],
                            "title": "Value",
                            "description": "Property value. Type varies by property."
                          },
                          "ValueType": {
                            "type": "string",
                            "title": "Value Type",
                            "description": "OData type of the value (e.g., Edm.String, Edm.Int64, Null)."
                          }
                        },
                        "description": "Represents a single cell in a search result row containing property key-value pairs."
                      },
                      "title": "Properties",
                      "description": "Additional metadata properties for the result set."
                    },
                    "ResultTitle": {
                      "type": "string",
                      "title": "Result Title",
                      "description": "Title for the result block."
                    },
                    "ItemTemplateId": {
                      "type": "string",
                      "title": "Item Template Id",
                      "description": "Template ID for rendering items."
                    },
                    "ResultTitleUrl": {
                      "type": "string",
                      "title": "Result Title Url",
                      "description": "URL for the result block title."
                    },
                    "GroupTemplateId": {
                      "type": "string",
                      "title": "Group Template Id",
                      "description": "Template ID for grouping results."
                    },
                    "TotalRowsIncludingDuplicates": {
                      "type": "integer",
                      "title": "Total Rows Including Duplicates",
                      "description": "Total number of results including duplicates."
                    }
                  },
                  "description": "Main search results."
                },
                "RefinementResults": {
                  "type": "object",
                  "title": "Refinement Results",
                  "required": [
                    "Refiners"
                  ],
                  "properties": {
                    "Refiners": {
                      "type": "array",
                      "items": {
                        "type": "object",
                        "title": "Refiner",
                        "required": [
                          "Entries",
                          "Name"
                        ],
                        "properties": {
                          "Name": {
                            "type": "string",
                            "title": "Name",
                            "description": "Name of the refiner (managed property)."
                          },
                          "Entries": {
                            "type": "array",
                            "items": {
                              "type": "object",
                              "title": "RefinementEntry",
                              "required": [
                                "RefinementCount",
                                "RefinementName",
                                "RefinementToken",
                                "RefinementValue"
                              ],
                              "properties": {
                                "RefinementName": {
                                  "type": "string",
                                  "title": "Refinement Name",
                                  "description": "Display name for the refinement bin (e.g., 'Html', 'From 2023-01-01 up to 2023-12-31')."
                                },
                                "RefinementCount": {
                                  "type": "string",
                                  "title": "Refinement Count",
                                  "description": "Number of items matching this refinement bin."
                                },
                                "RefinementToken": {
                                  "type": "string",
                                  "title": "Refinement Token",
                                  "description": "Token used with RefinerName to construct refinement filters for refined queries."
                                },
                                "RefinementValue": {
                                  "type": "string",
                                  "title": "Refinement Value",
                                  "description": "Implementation-specific formatted string representing the refinement."
                                }
                              },
                              "description": "Represents a single refinement option within a refiner."
                            },
                            "title": "Entries",
                            "description": "Array of refinement options for this refiner."
                          }
                        },
                        "description": "Contains refinement entries for a specific managed property."
                      },
                      "title": "Refiners",
                      "description": "Array of refiners with refinement options."
                    }
                  },
                  "description": "Refinement/facet results for filtering."
                },
                "SpecialTermResults": {
                  "type": "object",
                  "title": "Special Term Results",
                  "description": "Results for special terms in the query.",
                  "additionalProperties": true
                }
              },
              "description": "Primary query results."
            },
            "SpellingSuggestion": {
              "type": "string",
              "title": "Spelling Suggestion",
              "description": "Spelling suggestion for the query, if applicable."
            },
            "SecondaryQueryResults": {
              "type": "array",
              "items": {
                "type": "object",
                "additionalProperties": true
              },
              "title": "Secondary Query Results",
              "description": "Results from secondary queries."
            }
          },
          "description": "SharePoint search results with structured data including elapsed time, primary query results, properties, and metadata."
        }
      },
      "description": "Response model containing the search results."
    },
    "RelevantResultsModel": {
      "type": "object",
      "title": "RelevantResultsModel",
      "required": [
        "Properties",
        "RowCount",
        "Table",
        "TotalRows",
        "TotalRowsIncludingDuplicates"
      ],
      "properties": {
        "Table": {
          "type": "object",
          "title": "Table",
          "required": [
            "Rows"
          ],
          "properties": {
            "Rows": {
              "type": "array",
              "items": {
                "type": "object",
                "title": "SearchResultRow",
                "required": [
                  "Cells"
                ],
                "properties": {
                  "Cells": {
                    "type": "array",
                    "items": {
                      "type": "object",
                      "title": "SearchResultCell",
                      "required": [
                        "Key",
                        "ValueType"
                      ],
                      "properties": {
                        "Key": {
                          "type": "string",
                          "title": "Key",
                          "description": "Property name (e.g., Title, Author, Path)."
                        },
                        "Value": {
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
                            }
                          ],
                          "title": "Value",
                          "description": "Property value. Type varies by property."
                        },
                        "ValueType": {
                          "type": "string",
                          "title": "Value Type",
                          "description": "OData type of the value (e.g., Edm.String, Edm.Int64, Null)."
                        }
                      },
                      "description": "Represents a single cell in a search result row containing property key-value pairs."
                    },
                    "title": "Cells",
                    "description": "Array of cells containing property key-value pairs for this result."
                  }
                },
                "description": "Represents a single search result row."
              },
              "title": "Rows",
              "description": "Array of search result rows."
            }
          },
          "description": "Table containing search result rows."
        },
        "RowCount": {
          "type": "integer",
          "title": "Row Count",
          "description": "Number of results returned in this response."
        },
        "TotalRows": {
          "type": "integer",
          "title": "Total Rows",
          "description": "Total number of results matching the query (excluding duplicates)."
        },
        "Properties": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "SearchResultCell",
            "required": [
              "Key",
              "ValueType"
            ],
            "properties": {
              "Key": {
                "type": "string",
                "title": "Key",
                "description": "Property name (e.g., Title, Author, Path)."
              },
              "Value": {
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
                  }
                ],
                "title": "Value",
                "description": "Property value. Type varies by property."
              },
              "ValueType": {
                "type": "string",
                "title": "Value Type",
                "description": "OData type of the value (e.g., Edm.String, Edm.Int64, Null)."
              }
            },
            "description": "Represents a single cell in a search result row containing property key-value pairs."
          },
          "title": "Properties",
          "description": "Additional metadata properties for the result set."
        },
        "ResultTitle": {
          "type": "string",
          "title": "Result Title",
          "description": "Title for the result block."
        },
        "ItemTemplateId": {
          "type": "string",
          "title": "Item Template Id",
          "description": "Template ID for rendering items."
        },
        "ResultTitleUrl": {
          "type": "string",
          "title": "Result Title Url",
          "description": "URL for the result block title."
        },
        "GroupTemplateId": {
          "type": "string",
          "title": "Group Template Id",
          "description": "Template ID for grouping results."
        },
        "TotalRowsIncludingDuplicates": {
          "type": "integer",
          "title": "Total Rows Including Duplicates",
          "description": "Total number of results including duplicates."
        }
      },
      "description": "Contains the main search results and metadata."
    },
    "RefinementResultsModel": {
      "type": "object",
      "title": "RefinementResultsModel",
      "required": [
        "Refiners"
      ],
      "properties": {
        "Refiners": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "Refiner",
            "required": [
              "Entries",
              "Name"
            ],
            "properties": {
              "Name": {
                "type": "string",
                "title": "Name",
                "description": "Name of the refiner (managed property)."
              },
              "Entries": {
                "type": "array",
                "items": {
                  "type": "object",
                  "title": "RefinementEntry",
                  "required": [
                    "RefinementCount",
                    "RefinementName",
                    "RefinementToken",
                    "RefinementValue"
                  ],
                  "properties": {
                    "RefinementName": {
                      "type": "string",
                      "title": "Refinement Name",
                      "description": "Display name for the refinement bin (e.g., 'Html', 'From 2023-01-01 up to 2023-12-31')."
                    },
                    "RefinementCount": {
                      "type": "string",
                      "title": "Refinement Count",
                      "description": "Number of items matching this refinement bin."
                    },
                    "RefinementToken": {
                      "type": "string",
                      "title": "Refinement Token",
                      "description": "Token used with RefinerName to construct refinement filters for refined queries."
                    },
                    "RefinementValue": {
                      "type": "string",
                      "title": "Refinement Value",
                      "description": "Implementation-specific formatted string representing the refinement."
                    }
                  },
                  "description": "Represents a single refinement option within a refiner."
                },
                "title": "Entries",
                "description": "Array of refinement options for this refiner."
              }
            },
            "description": "Contains refinement entries for a specific managed property."
          },
          "title": "Refiners",
          "description": "Array of refiners with refinement options."
        }
      },
      "description": "Contains query refinement/facet data for filtering search results."
    },
    "PrimaryQueryResultModel": {
      "type": "object",
      "title": "PrimaryQueryResultModel",
      "required": [
        "CustomResults",
        "QueryId",
        "QueryRuleId",
        "RelevantResults"
      ],
      "properties": {
        "QueryId": {
          "type": "string",
          "title": "Query Id",
          "description": "Unique identifier for the query."
        },
        "QueryRuleId": {
          "type": "string",
          "title": "Query Rule Id",
          "description": "ID of the query rule that was applied, if any."
        },
        "CustomResults": {
          "type": "array",
          "items": {
            "type": "object",
            "additionalProperties": true
          },
          "title": "Custom Results",
          "description": "Custom results based on query rules."
        },
        "RelevantResults": {
          "type": "object",
          "title": "Relevant Results",
          "required": [
            "Properties",
            "RowCount",
            "Table",
            "TotalRows",
            "TotalRowsIncludingDuplicates"
          ],
          "properties": {
            "Table": {
              "type": "object",
              "title": "Table",
              "required": [
                "Rows"
              ],
              "properties": {
                "Rows": {
                  "type": "array",
                  "items": {
                    "type": "object",
                    "title": "SearchResultRow",
                    "required": [
                      "Cells"
                    ],
                    "properties": {
                      "Cells": {
                        "type": "array",
                        "items": {
                          "type": "object",
                          "title": "SearchResultCell",
                          "required": [
                            "Key",
                            "ValueType"
                          ],
                          "properties": {
                            "Key": {
                              "type": "string",
                              "title": "Key",
                              "description": "Property name (e.g., Title, Author, Path)."
                            },
                            "Value": {
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
                                }
                              ],
                              "title": "Value",
                              "description": "Property value. Type varies by property."
                            },
                            "ValueType": {
                              "type": "string",
                              "title": "Value Type",
                              "description": "OData type of the value (e.g., Edm.String, Edm.Int64, Null)."
                            }
                          },
                          "description": "Represents a single cell in a search result row containing property key-value pairs."
                        },
                        "title": "Cells",
                        "description": "Array of cells containing property key-value pairs for this result."
                      }
                    },
                    "description": "Represents a single search result row."
                  },
                  "title": "Rows",
                  "description": "Array of search result rows."
                }
              },
              "description": "Table containing search result rows."
            },
            "RowCount": {
              "type": "integer",
              "title": "Row Count",
              "description": "Number of results returned in this response."
            },
            "TotalRows": {
              "type": "integer",
              "title": "Total Rows",
              "description": "Total number of results matching the query (excluding duplicates)."
            },
            "Properties": {
              "type": "array",
              "items": {
                "type": "object",
                "title": "SearchResultCell",
                "required": [
                  "Key",
                  "ValueType"
                ],
                "properties": {
                  "Key": {
                    "type": "string",
                    "title": "Key",
                    "description": "Property name (e.g., Title, Author, Path)."
                  },
                  "Value": {
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
                      }
                    ],
                    "title": "Value",
                    "description": "Property value. Type varies by property."
                  },
                  "ValueType": {
                    "type": "string",
                    "title": "Value Type",
                    "description": "OData type of the value (e.g., Edm.String, Edm.Int64, Null)."
                  }
                },
                "description": "Represents a single cell in a search result row containing property key-value pairs."
              },
              "title": "Properties",
              "description": "Additional metadata properties for the result set."
            },
            "ResultTitle": {
              "type": "string",
              "title": "Result Title",
              "description": "Title for the result block."
            },
            "ItemTemplateId": {
              "type": "string",
              "title": "Item Template Id",
              "description": "Template ID for rendering items."
            },
            "ResultTitleUrl": {
              "type": "string",
              "title": "Result Title Url",
              "description": "URL for the result block title."
            },
            "GroupTemplateId": {
              "type": "string",
              "title": "Group Template Id",
              "description": "Template ID for grouping results."
            },
            "TotalRowsIncludingDuplicates": {
              "type": "integer",
              "title": "Total Rows Including Duplicates",
              "description": "Total number of results including duplicates."
            }
          },
          "description": "Main search results."
        },
        "RefinementResults": {
          "type": "object",
          "title": "Refinement Results",
          "required": [
            "Refiners"
          ],
          "properties": {
            "Refiners": {
              "type": "array",
              "items": {
                "type": "object",
                "title": "Refiner",
                "required": [
                  "Entries",
                  "Name"
                ],
                "properties": {
                  "Name": {
                    "type": "string",
                    "title": "Name",
                    "description": "Name of the refiner (managed property)."
                  },
                  "Entries": {
                    "type": "array",
                    "items": {
                      "type": "object",
                      "title": "RefinementEntry",
                      "required": [
                        "RefinementCount",
                        "RefinementName",
                        "RefinementToken",
                        "RefinementValue"
                      ],
                      "properties": {
                        "RefinementName": {
                          "type": "string",
                          "title": "Refinement Name",
                          "description": "Display name for the refinement bin (e.g., 'Html', 'From 2023-01-01 up to 2023-12-31')."
                        },
                        "RefinementCount": {
                          "type": "string",
                          "title": "Refinement Count",
                          "description": "Number of items matching this refinement bin."
                        },
                        "RefinementToken": {
                          "type": "string",
                          "title": "Refinement Token",
                          "description": "Token used with RefinerName to construct refinement filters for refined queries."
                        },
                        "RefinementValue": {
                          "type": "string",
                          "title": "Refinement Value",
                          "description": "Implementation-specific formatted string representing the refinement."
                        }
                      },
                      "description": "Represents a single refinement option within a refiner."
                    },
                    "title": "Entries",
                    "description": "Array of refinement options for this refiner."
                  }
                },
                "description": "Contains refinement entries for a specific managed property."
              },
              "title": "Refiners",
              "description": "Array of refiners with refinement options."
            }
          },
          "description": "Refinement/facet results for filtering."
        },
        "SpecialTermResults": {
          "type": "object",
          "title": "Special Term Results",
          "description": "Results for special terms in the query.",
          "additionalProperties": true
        }
      },
      "description": "Contains the primary search query results and metadata."
    }
  },
  "title": "SearchQueryResponseWrapper",
  "required": [
    "data",
    "successful"
  ],
  "properties": {
    "data": {
      "type": "object",
      "title": "Data",
      "required": [
        "search_results"
      ],
      "properties": {
        "search_results": {
          "type": "object",
          "title": "Search Results",
          "required": [
            "ElapsedTime",
            "PrimaryQueryResult",
            "Properties",
            "SecondaryQueryResults",
            "TriggeredRules"
          ],
          "properties": {
            "Properties": {
              "type": "array",
              "items": {
                "type": "object",
                "title": "SearchResultCell",
                "required": [
                  "Key",
                  "ValueType"
                ],
                "properties": {
                  "Key": {
                    "type": "string",
                    "title": "Key",
                    "description": "Property name (e.g., Title, Author, Path)."
                  },
                  "Value": {
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
                      }
                    ],
                    "title": "Value",
                    "description": "Property value. Type varies by property."
                  },
                  "ValueType": {
                    "type": "string",
                    "title": "Value Type",
                    "description": "OData type of the value (e.g., Edm.String, Edm.Int64, Null)."
                  }
                },
                "description": "Represents a single cell in a search result row containing property key-value pairs."
              },
              "title": "Properties",
              "description": "Additional query metadata and settings."
            },
            "ElapsedTime": {
              "type": "integer",
              "title": "Elapsed Time",
              "description": "Query execution time in milliseconds."
            },
            "TriggeredRules": {
              "type": "array",
              "items": {
                "type": "object",
                "additionalProperties": true
              },
              "title": "Triggered Rules",
              "description": "Query rules that were triggered."
            },
            "PrimaryQueryResult": {
              "type": "object",
              "title": "Primary Query Result",
              "required": [
                "CustomResults",
                "QueryId",
                "QueryRuleId",
                "RelevantResults"
              ],
              "properties": {
                "QueryId": {
                  "type": "string",
                  "title": "Query Id",
                  "description": "Unique identifier for the query."
                },
                "QueryRuleId": {
                  "type": "string",
                  "title": "Query Rule Id",
                  "description": "ID of the query rule that was applied, if any."
                },
                "CustomResults": {
                  "type": "array",
                  "items": {
                    "type": "object",
                    "additionalProperties": true
                  },
                  "title": "Custom Results",
                  "description": "Custom results based on query rules."
                },
                "RelevantResults": {
                  "type": "object",
                  "title": "Relevant Results",
                  "required": [
                    "Properties",
                    "RowCount",
                    "Table",
                    "TotalRows",
                    "TotalRowsIncludingDuplicates"
                  ],
                  "properties": {
                    "Table": {
                      "type": "object",
                      "title": "Table",
                      "required": [
                        "Rows"
                      ],
                      "properties": {
                        "Rows": {
                          "type": "array",
                          "items": {
                            "type": "object",
                            "title": "SearchResultRow",
                            "required": [
                              "Cells"
                            ],
                            "properties": {
                              "Cells": {
                                "type": "array",
                                "items": {
                                  "type": "object",
                                  "title": "SearchResultCell",
                                  "required": [
                                    "Key",
                                    "ValueType"
                                  ],
                                  "properties": {
                                    "Key": {
                                      "type": "string",
                                      "title": "Key",
                                      "description": "Property name (e.g., Title, Author, Path)."
                                    },
                                    "Value": {
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
                                        }
                                      ],
                                      "title": "Value",
                                      "description": "Property value. Type varies by property."
                                    },
                                    "ValueType": {
                                      "type": "string",
                                      "title": "Value Type",
                                      "description": "OData type of the value (e.g., Edm.String, Edm.Int64, Null)."
                                    }
                                  },
                                  "description": "Represents a single cell in a search result row containing property key-value pairs."
                                },
                                "title": "Cells",
                                "description": "Array of cells containing property key-value pairs for this result."
                              }
                            },
                            "description": "Represents a single search result row."
                          },
                          "title": "Rows",
                          "description": "Array of search result rows."
                        }
                      },
                      "description": "Table containing search result rows."
                    },
                    "RowCount": {
                      "type": "integer",
                      "title": "Row Count",
                      "description": "Number of results returned in this response."
                    },
                    "TotalRows": {
                      "type": "integer",
                      "title": "Total Rows",
                      "description": "Total number of results matching the query (excluding duplicates)."
                    },
                    "Properties": {
                      "type": "array",
                      "items": {
                        "type": "object",
                        "title": "SearchResultCell",
                        "required": [
                          "Key",
                          "ValueType"
                        ],
                        "properties": {
                          "Key": {
                            "type": "string",
                            "title": "Key",
                            "description": "Property name (e.g., Title, Author, Path)."
                          },
                          "Value": {
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
                              }
                            ],
                            "title": "Value",
                            "description": "Property value. Type varies by property."
                          },
                          "ValueType": {
                            "type": "string",
                            "title": "Value Type",
                            "description": "OData type of the value (e.g., Edm.String, Edm.Int64, Null)."
                          }
                        },
                        "description": "Represents a single cell in a search result row containing property key-value pairs."
                      },
                      "title": "Properties",
                      "description": "Additional metadata properties for the result set."
                    },
                    "ResultTitle": {
                      "type": "string",
                      "title": "Result Title",
                      "description": "Title for the result block."
                    },
                    "ItemTemplateId": {
                      "type": "string",
                      "title": "Item Template Id",
                      "description": "Template ID for rendering items."
                    },
                    "ResultTitleUrl": {
                      "type": "string",
                      "title": "Result Title Url",
                      "description": "URL for the result block title."
                    },
                    "GroupTemplateId": {
                      "type": "string",
                      "title": "Group Template Id",
                      "description": "Template ID for grouping results."
                    },
                    "TotalRowsIncludingDuplicates": {
                      "type": "integer",
                      "title": "Total Rows Including Duplicates",
                      "description": "Total number of results including duplicates."
                    }
                  },
                  "description": "Main search results."
                },
                "RefinementResults": {
                  "type": "object",
                  "title": "Refinement Results",
                  "required": [
                    "Refiners"
                  ],
                  "properties": {
                    "Refiners": {
                      "type": "array",
                      "items": {
                        "type": "object",
                        "title": "Refiner",
                        "required": [
                          "Entries",
                          "Name"
                        ],
                        "properties": {
                          "Name": {
                            "type": "string",
                            "title": "Name",
                            "description": "Name of the refiner (managed property)."
                          },
                          "Entries": {
                            "type": "array",
                            "items": {
                              "type": "object",
                              "title": "RefinementEntry",
                              "required": [
                                "RefinementCount",
                                "RefinementName",
                                "RefinementToken",
                                "RefinementValue"
                              ],
                              "properties": {
                                "RefinementName": {
                                  "type": "string",
                                  "title": "Refinement Name",
                                  "description": "Display name for the refinement bin (e.g., 'Html', 'From 2023-01-01 up to 2023-12-31')."
                                },
                                "RefinementCount": {
                                  "type": "string",
                                  "title": "Refinement Count",
                                  "description": "Number of items matching this refinement bin."
                                },
                                "RefinementToken": {
                                  "type": "string",
                                  "title": "Refinement Token",
                                  "description": "Token used with RefinerName to construct refinement filters for refined queries."
                                },
                                "RefinementValue": {
                                  "type": "string",
                                  "title": "Refinement Value",
                                  "description": "Implementation-specific formatted string representing the refinement."
                                }
                              },
                              "description": "Represents a single refinement option within a refiner."
                            },
                            "title": "Entries",
                            "description": "Array of refinement options for this refiner."
                          }
                        },
                        "description": "Contains refinement entries for a specific managed property."
                      },
                      "title": "Refiners",
                      "description": "Array of refiners with refinement options."
                    }
                  },
                  "description": "Refinement/facet results for filtering."
                },
                "SpecialTermResults": {
                  "type": "object",
                  "title": "Special Term Results",
                  "description": "Results for special terms in the query.",
                  "additionalProperties": true
                }
              },
              "description": "Primary query results."
            },
            "SpellingSuggestion": {
              "type": "string",
              "title": "Spelling Suggestion",
              "description": "Spelling suggestion for the query, if applicable."
            },
            "SecondaryQueryResults": {
              "type": "array",
              "items": {
                "type": "object",
                "additionalProperties": true
              },
              "title": "Secondary Query Results",
              "description": "Results from secondary queries."
            }
          },
          "description": "SharePoint search results with structured data including elapsed time, primary query results, properties, and metadata."
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

## SHARE_POINT_SEARCH_SUGGEST
Tool to get search query suggestions. Use when you need to provide autocomplete options for user search input.

**Input schema:**
```json
{
  "type": "object",
  "title": "SearchSuggestRequest",
  "required": [
    "querytext"
  ],
  "properties": {
    "Culture": {
      "type": "integer",
      "title": "Culture",
      "examples": [
        1033
      ],
      "description": "Locale ID (LCID) for the query."
    },
    "querytext": {
      "type": "string",
      "title": "Querytext",
      "examples": [
        "sharepoint"
      ],
      "description": "Text for which to retrieve query suggestions."
    },
    "site_name": {
      "type": "string",
      "title": "Site Name",
      "examples": [
        "composio-test",
        "team-site"
      ],
      "description": "The subsite name to scope the request to (e.g., 'composio-test'). If omitted, the root site is used. When provided, the API base URL becomes https://{tenant}.sharepoint.com/sites/{site}."
    },
    "EnableStemming": {
      "type": "boolean",
      "title": "Enable Stemming",
      "default": true,
      "description": "True to enable stemming."
    },
    "EnableQueryRules": {
      "type": "boolean",
      "title": "Enable Query Rules",
      "default": true,
      "description": "True to enable query rules."
    },
    "fHitHighlighting": {
      "type": "boolean",
      "title": "F Hit Highlighting",
      "default": true,
      "description": "True to bold-match terms in suggestions."
    },
    "fPreQuerySuggestions": {
      "type": "boolean",
      "title": "F Pre Query Suggestions",
      "default": false,
      "description": "True to get pre-query suggestions; false for post-query."
    },
    "fPrefixMatchAllTerms": {
      "type": "boolean",
      "title": "F Prefix Match All Terms",
      "description": "True to return suggestions matching all query prefixes."
    },
    "fCapitalizeFirstLetters": {
      "type": "boolean",
      "title": "F Capitalize First Letters",
      "default": false,
      "description": "True to capitalize first letters of each term."
    },
    "ShowPeopleNameSuggestions": {
      "type": "boolean",
      "title": "Show People Name Suggestions",
      "default": true,
      "description": "True to include people name suggestions."
    },
    "iNumberOfQuerySuggestions": {
      "type": "integer",
      "title": "I Number Of Query Suggestions",
      "default": 5,
      "minimum": 1,
      "description": "Number of query suggestions to retrieve. Must be >= 1."
    },
    "iNumberOfResultSuggestions": {
      "type": "integer",
      "title": "I Number Of Result Suggestions",
      "default": 5,
      "minimum": 1,
      "description": "Number of result suggestions to retrieve. Must be >= 1."
    }
  },
  "description": "Request parameters for retrieving search query suggestions from SharePoint.",
  "additionalProperties": false
}
```

**Output schema:**
```json
{
  "type": "object",
  "$defs": {
    "SearchSuggestResponse": {
      "type": "object",
      "title": "SearchSuggestResponse",
      "required": [
        "query_suggestions"
      ],
      "properties": {
        "query_suggestions": {
          "type": "array",
          "items": {
            "type": "string"
          },
          "title": "Query Suggestions",
          "description": "List of query suggestion strings."
        },
        "result_suggestions": {
          "type": "array",
          "items": {
            "type": "object",
            "additionalProperties": true
          },
          "title": "Result Suggestions",
          "description": "List of result suggestion objects (personalized results)."
        }
      },
      "description": "Response model for search suggestions from SharePoint."
    }
  },
  "title": "SearchSuggestResponseWrapper",
  "required": [
    "data",
    "successful"
  ],
  "properties": {
    "data": {
      "type": "object",
      "title": "Data",
      "required": [
        "query_suggestions"
      ],
      "properties": {
        "query_suggestions": {
          "type": "array",
          "items": {
            "type": "string"
          },
          "title": "Query Suggestions",
          "description": "List of query suggestion strings."
        },
        "result_suggestions": {
          "type": "array",
          "items": {
            "type": "object",
            "additionalProperties": true
          },
          "title": "Result Suggestions",
          "description": "List of result suggestion objects (personalized results)."
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

## SHARE_POINT_SHAREPOINT_CHECK_OUT_FILE
Tool to check out a file in a document library. Use when you need to lock a file before making changes.

**Input schema:**
```json
{
  "type": "object",
  "title": "CheckOutFileRequest",
  "required": [
    "server_relative_path"
  ],
  "properties": {
    "site_name": {
      "type": "string",
      "title": "Site Name",
      "examples": [
        "composio-test",
        "Finance",
        "HR"
      ],
      "description": "The subsite name to scope the request to (e.g., 'composio-test'). If omitted, the root site is used. When provided, the API base URL becomes https://{tenant}.sharepoint.com/sites/{site}."
    },
    "server_relative_path": {
      "type": "string",
      "title": "Server Relative Path",
      "examples": [
        "/Shared Documents/a.txt"
      ],
      "description": "The server-relative path to the file that needs to be checked out, e.g., '/Shared Documents/a.txt'."
    }
  }
}
```

**Output schema:**
```json
{
  "type": "object",
  "$defs": {
    "CheckOutFileResponse": {
      "type": "object",
      "title": "CheckOutFileResponse",
      "required": [
        "message",
        "server_relative_path"
      ],
      "properties": {
        "message": {
          "type": "string",
          "title": "Message",
          "description": "Success message indicating the file has been checked out"
        },
        "server_relative_path": {
          "type": "string",
          "title": "Server Relative Path",
          "description": "The server-relative path of the checked out file"
        }
      }
    }
  },
  "title": "CheckOutFileResponseWrapper",
  "required": [
    "data",
    "successful"
  ],
  "properties": {
    "data": {
      "type": "object",
      "title": "Data",
      "required": [
        "message",
        "server_relative_path"
      ],
      "properties": {
        "message": {
          "type": "string",
          "title": "Message",
          "description": "Success message indicating the file has been checked out"
        },
        "server_relative_path": {
          "type": "string",
          "title": "Server Relative Path",
          "description": "The server-relative path of the checked out file"
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

## SHARE_POINT_SHAREPOINT_CREATE_FOLDER
Creates a new folder in SharePoint using the REST API. Returns `server_relative_url`; use it for downstream operations instead of constructing paths manually. Does not configure sharing or permissions on the created folder.

**Input schema:**
```json
{
  "type": "object",
  "title": "CreateFolderRequest",
  "required": [
    "folder_name"
  ],
  "properties": {
    "site_name": {
      "type": "string",
      "title": "Site Name",
      "description": "The subsite name to scope the request to (e.g., 'composio-test'). If omitted, the root site is used. When provided, the API base URL becomes https://{tenant}.sharepoint.com/sites/{site}.",
      "human_parameter_name": "Site",
      "human_parameter_description": "The subsite name if you want to create the folder in a specific subsite. Leave blank to use the root site."
    },
    "folder_name": {
      "type": "string",
      "title": "Folder Name",
      "description": "The name of the folder to create.",
      "human_parameter_name": "Folder Name",
      "human_parameter_description": "Enter what you want to call the new folder. This is the folder that will be created in SharePoint."
    },
    "relative_path": {
      "type": "string",
      "title": "Relative Path",
      "default": "",
      "description": "Additional path within the document library (optional). The parent path must already exist; non-existent paths cause creation to fail. Path segments must be correctly encoded (e.g., spaces as %20).",
      "human_parameter_name": "Relative Path",
      "human_parameter_description": "If you want the new folder inside an existing subfolder, provide that path relative to the library (e.g., 'Projects/2025'). Leave blank to create it at the library root."
    },
    "document_library": {
      "type": "string",
      "title": "Document Library",
      "default": "Shared Documents",
      "description": "The document library where the folder should be created.",
      "human_parameter_name": "Document Library",
      "human_parameter_description": "Choose the library where you want the folder to live (for example, 'Shared Documents')."
    }
  }
}
```

**Output schema:**
```json
{
  "type": "object",
  "$defs": {
    "CreateFolderResponse": {
      "type": "object",
      "title": "CreateFolderResponse",
      "required": [
        "message",
        "server_relative_url",
        "item_count",
        "name"
      ],
      "properties": {
        "name": {
          "type": "string",
          "title": "Name",
          "description": "Name of the created folder"
        },
        "message": {
          "type": "string",
          "title": "Message",
          "description": "Success message indicating folder creation"
        },
        "item_count": {
          "type": "integer",
          "title": "Item Count",
          "description": "Number of items in the created folder"
        },
        "server_relative_url": {
          "type": "string",
          "title": "Server Relative Url",
          "description": "The server relative URL of the created folder"
        }
      }
    }
  },
  "title": "CreateFolderResponseWrapper",
  "required": [
    "data",
    "successful"
  ],
  "properties": {
    "data": {
      "type": "object",
      "title": "Data",
      "required": [
        "message",
        "server_relative_url",
        "item_count",
        "name"
      ],
      "properties": {
        "name": {
          "type": "string",
          "title": "Name",
          "description": "Name of the created folder"
        },
        "message": {
          "type": "string",
          "title": "Message",
          "description": "Success message indicating folder creation"
        },
        "item_count": {
          "type": "integer",
          "title": "Item Count",
          "description": "Number of items in the created folder"
        },
        "server_relative_url": {
          "type": "string",
          "title": "Server Relative Url",
          "description": "The server relative URL of the created folder"
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

## SHARE_POINT_SHAREPOINT_CREATE_LIST
Creates a new list in SharePoint using the REST API. Custom columns cannot be added at creation time; use SHARE_POINT_CREATE_LIST_FIELD with the returned `list_id` to add them afterward. Check `success` and `error` fields in the response to confirm creation. Returns a `list_id` used by downstream tools; note SHARE_POINT_SHAREPOINT_CREATE_LIST_ITEM targets lists by `list_name` (title).

**Input schema:**
```json
{
  "type": "object",
  "title": "CreateListRequest",
  "required": [
    "name",
    "template"
  ],
  "properties": {
    "name": {
      "type": "string",
      "title": "Name",
      "description": "The name of the list to create. Must be unique per site; duplicate names cause failure. Pre-check with SHARE_POINT_GET_LIST_BY_TITLE or SHARE_POINT_LIST_ALL_LISTS before calling.",
      "human_parameter_description": "The title you want to give the new SharePoint list. Choose a clear, descriptive name so people immediately know what it contains."
    },
    "template": {
      "type": "string",
      "title": "Template",
      "description": "The template type for the list (e.g., 'genericList', 'documentLibrary', 'tasks', etc.).",
      "human_parameter_description": "Select the type of list you want to create (for example: genericList, documentLibrary, tasks). This choice sets up the default columns and behavior for the list."
    },
    "site_name": {
      "type": "string",
      "title": "Site Name",
      "description": "The subsite name to scope the request to (e.g., 'composio-test'). If omitted, the root site is used. When provided, the API base URL becomes https://{tenant}.sharepoint.com/sites/{site}.",
      "human_parameter_description": "The name of the subsite where you want to create the list. Leave empty to create the list on the main site."
    },
    "description": {
      "type": "string",
      "title": "Description",
      "default": "",
      "description": "Description of the list (optional).",
      "human_parameter_description": "A short summary of what the list is for. This helps teammates understand its purpose when they see it in SharePoint."
    }
  }
}
```

**Output schema:**
```json
{
  "type": "object",
  "$defs": {
    "CreateListResponse": {
      "type": "object",
      "title": "CreateListResponse",
      "required": [
        "message",
        "list_id",
        "title",
        "description"
      ],
      "properties": {
        "title": {
          "type": "string",
          "title": "Title",
          "description": "The title of the created list"
        },
        "list_id": {
          "type": "string",
          "title": "List Id",
          "description": "The ID of the created list"
        },
        "message": {
          "type": "string",
          "title": "Message",
          "description": "Success message indicating list creation"
        },
        "description": {
          "type": "string",
          "title": "Description",
          "description": "The description of the created list"
        }
      }
    }
  },
  "title": "CreateListResponseWrapper",
  "required": [
    "data",
    "successful"
  ],
  "properties": {
    "data": {
      "type": "object",
      "title": "Data",
      "required": [
        "message",
        "list_id",
        "title",
        "description"
      ],
      "properties": {
        "title": {
          "type": "string",
          "title": "Title",
          "description": "The title of the created list"
        },
        "list_id": {
          "type": "string",
          "title": "List Id",
          "description": "The ID of the created list"
        },
        "message": {
          "type": "string",
          "title": "Message",
          "description": "Success message indicating list creation"
        },
        "description": {
          "type": "string",
          "title": "Description",
          "description": "The description of the created list"
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

## SHARE_POINT_SHAREPOINT_CREATE_LIST_ITEM
Creates a new item in a SharePoint list. Returns an `item_data` object containing `item_id`, `Title`, and timestamps on success.

**Input schema:**
```json
{
  "type": "object",
  "title": "CreateListItemRequest",
  "example": {
    "list_name": "My List",
    "item_properties": {
      "Body": "Content here",
      "Title": "New Item"
    }
  },
  "required": [
    "list_name",
    "item_properties"
  ],
  "properties": {
    "list_name": {
      "type": "string",
      "title": "List Name",
      "description": "The name or title of the list where the item will be created. Must exactly match the list's title as it exists in the site; verify the list exists first using SHARE_POINT_SHAREPOINT_CREATE_LIST if uncertain.",
      "human_parameter_name": "List Name",
      "human_parameter_description": "Enter the exact name of the SharePoint list where you want to create the item. This lets us know which list to add your new entry to."
    },
    "site_name": {
      "type": "string",
      "title": "Site Name",
      "description": "The subsite name to scope the request to (e.g., 'composio-test'). If omitted, the root site is used. When provided, the API base URL becomes https://{tenant}.sharepoint.com/sites/{site}.",
      "human_parameter_name": "Site",
      "human_parameter_description": "Optional: Enter the subsite name if you want to create the list item in a specific subsite rather than the root site."
    },
    "item_properties": {
      "type": "object",
      "title": "Item Properties",
      "description": "Dictionary of field names and values for the list item. Example: {'Title': 'New Item', 'Body': 'Content'} Keys must be SharePoint column internal names (not display names); use the SharePoint column settings to find internal names. The example key 'Body' is invalid on default lists \u2014 use 'Title' as the minimal valid payload and add fields one at a time to isolate errors.",
      "additionalProperties": true,
      "human_parameter_name": "Item Properties",
      "human_parameter_description": "Provide the fields and values you want to save in the new item (for example, Title and Description). Use each column's name with the value you want to store."
    }
  },
  "additionalProperties": false
}
```

**Output schema:**
```json
{
  "type": "object",
  "$defs": {
    "CreateListItemResponse": {
      "type": "object",
      "title": "CreateListItemResponse",
      "required": [
        "message",
        "item_id",
        "created_at",
        "item_data"
      ],
      "properties": {
        "item_id": {
          "type": "integer",
          "title": "Item Id",
          "description": "The ID of the created list item"
        },
        "message": {
          "type": "string",
          "title": "Message",
          "description": "Success message indicating item creation"
        },
        "item_data": {
          "type": "object",
          "title": "Item Data",
          "description": "The created item's data",
          "additionalProperties": true
        },
        "created_at": {
          "type": "string",
          "title": "Created At",
          "description": "Timestamp when the item was created"
        }
      }
    }
  },
  "title": "CreateListItemResponseWrapper",
  "required": [
    "data",
    "successful"
  ],
  "properties": {
    "data": {
      "type": "object",
      "title": "Data",
      "required": [
        "message",
        "item_id",
        "created_at",
        "item_data"
      ],
      "properties": {
        "item_id": {
          "type": "integer",
          "title": "Item Id",
          "description": "The ID of the created list item"
        },
        "message": {
          "type": "string",
          "title": "Message",
          "description": "Success message indicating item creation"
        },
        "item_data": {
          "type": "object",
          "title": "Item Data",
          "description": "The created item's data",
          "additionalProperties": true
        },
        "created_at": {
          "type": "string",
          "title": "Created At",
          "description": "Timestamp when the item was created"
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

## SHARE_POINT_SHAREPOINT_CREATE_USER
DEPRECATED: Use SHARE_POINT_ENSURE_USER instead (supports email param directly). Adds an existing Azure AD user to the SharePoint site collection using the ensureuser endpoint. This action is idempotent - if the user is already in the site, it returns their existing details without error.

**Input schema:**
```json
{
  "type": "object",
  "title": "CreateUserRequest",
  "required": [
    "email"
  ],
  "properties": {
    "email": {
      "type": "string",
      "title": "Email",
      "description": "Email address of the Azure AD user to add to SharePoint site. Must be a valid user in your organization's Azure Active Directory.",
      "human_parameter_name": "Email Address",
      "human_parameter_description": "The work or school email address of an existing user in your organization's directory. This user must already exist in Azure AD to be added to the SharePoint site."
    },
    "title": {
      "type": "string",
      "title": "Title",
      "description": "Optional display name/title for the user in SharePoint. If not provided, the user's existing display name from Azure AD will be used.",
      "human_parameter_name": "User Title",
      "human_parameter_description": "Optional: The display name you want to show for this user in SharePoint, such as their full name or job title. Leave empty to use their default name from Azure AD."
    },
    "tenant": {
      "type": "string",
      "title": "Tenant",
      "description": "DEPRECATED: This parameter is no longer used. The tenant is now automatically derived from the connected account's base_url in metadata.",
      "human_parameter_name": "Tenant Name (Deprecated)",
      "human_parameter_description": "This parameter is deprecated and no longer used. The tenant is automatically determined from your connected account."
    },
    "site_name": {
      "type": "string",
      "title": "Site Name",
      "description": "The subsite name to scope the request to (e.g., 'composio-test'). If omitted, the root site is used. When provided, the API base URL becomes https://{tenant}.sharepoint.com/sites/{site}.",
      "human_parameter_name": "Subsite Name",
      "human_parameter_description": "Optional: The name of a specific subsite if you want to add the user to a subsite instead of the root site. Leave empty to use the root site."
    },
    "login_name": {
      "type": "string",
      "title": "Login Name",
      "description": "Optional login name for the user. If not provided, defaults to 'i:0#.f|membership|{email}'. This parameter is typically not needed as the email is sufficient.",
      "human_parameter_name": "Login Name",
      "human_parameter_description": "Advanced: The user's claims-based login name. Leave empty to use the default format based on the email address. Only provide this if you need a specific login format."
    }
  }
}
```

**Output schema:**
```json
{
  "type": "object",
  "$defs": {
    "CreateUserResponse": {
      "type": "object",
      "title": "CreateUserResponse",
      "required": [
        "message",
        "user_id",
        "login_name"
      ],
      "properties": {
        "message": {
          "type": "string",
          "title": "Message",
          "description": "Status message indicating whether the user was newly added to SharePoint or already existed in the site"
        },
        "user_id": {
          "type": "string",
          "title": "User Id",
          "description": "The SharePoint user ID assigned to this user in the site"
        },
        "login_name": {
          "type": "string",
          "title": "Login Name",
          "description": "The claims-based login name of the user in SharePoint (format: i:0#.f|membership|email)"
        }
      }
    }
  },
  "title": "CreateUserResponseWrapper",
  "required": [
    "data",
    "successful"
  ],
  "properties": {
    "data": {
      "type": "object",
      "title": "Data",
      "required": [
        "message",
        "user_id",
        "login_name"
      ],
      "properties": {
        "message": {
          "type": "string",
          "title": "Message",
          "description": "Status message indicating whether the user was newly added to SharePoint or already existed in the site"
        },
        "user_id": {
          "type": "string",
          "title": "User Id",
          "description": "The SharePoint user ID assigned to this user in the site"
        },
        "login_name": {
          "type": "string",
          "title": "Login Name",
          "description": "The claims-based login name of the user in SharePoint (format: i:0#.f|membership|email)"
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

## SHARE_POINT_SHAREPOINT_FIND_USER
Searches for a user in the SharePoint site by email address and returns their profile information if found. Response includes `exists_in_graph`, `exists_in_sharepoint`, and `error_details` fields; inspect all three together — `successful=true` can coexist with Graph errors in `error_details`. When the two backends diverge, treat `exists_in_sharepoint` as authoritative for access decisions.

**Input schema:**
```json
{
  "type": "object",
  "title": "FindUserRequest",
  "required": [
    "email"
  ],
  "properties": {
    "email": {
      "type": "string",
      "title": "Email",
      "description": "Email address of the user to find. Must be a complete, valid email address \u2014 display names and short names are rejected and return 'User not found'. Use SHARE_POINT_LIST_SITE_USERS to resolve a display name to an email first.",
      "human_parameter_name": "Email Address",
      "human_parameter_description": "Enter the person's work or school email address so we can look them up and confirm if they exist in your organization."
    },
    "site_name": {
      "type": "string",
      "title": "Site Name",
      "description": "The subsite name to scope the request to (e.g., 'composio-test'). If omitted, the root site is used. When provided, the API base URL becomes https://{tenant}.sharepoint.com/sites/{site}.",
      "human_parameter_name": "Subsite Name",
      "human_parameter_description": "Optional: Enter the name of a specific SharePoint subsite (e.g., 'team-site' or 'project-alpha'). Leave blank to search in the root site."
    }
  }
}
```

**Output schema:**
```json
{
  "type": "object",
  "$defs": {
    "UserDetails": {
      "type": "object",
      "title": "UserDetails",
      "properties": {
        "Id": {
          "type": "integer",
          "title": "Id",
          "description": "User ID in SharePoint"
        },
        "Email": {
          "type": "string",
          "title": "Email",
          "description": "Email address"
        },
        "Title": {
          "type": "string",
          "title": "Title",
          "description": "Display name"
        },
        "LoginName": {
          "type": "string",
          "title": "Login Name",
          "description": "User login name"
        },
        "IsSiteAdmin": {
          "type": "boolean",
          "title": "Is Site Admin",
          "description": "Whether user is site admin"
        },
        "PrincipalType": {
          "type": "integer",
          "title": "Principal Type",
          "description": "Principal type"
        },
        "UserPrincipalName": {
          "type": "string",
          "title": "User Principal Name",
          "description": "User principal name"
        }
      },
      "description": "SharePoint user details."
    },
    "FindUserResponse": {
      "type": "object",
      "title": "FindUserResponse",
      "required": [
        "user_exists"
      ],
      "properties": {
        "user_exists": {
          "type": "boolean",
          "title": "User Exists",
          "description": "Whether user exists in SharePoint site"
        },
        "user_details": {
          "type": "object",
          "title": "User Details",
          "properties": {
            "Id": {
              "type": "integer",
              "title": "Id",
              "description": "User ID in SharePoint"
            },
            "Email": {
              "type": "string",
              "title": "Email",
              "description": "Email address"
            },
            "Title": {
              "type": "string",
              "title": "Title",
              "description": "Display name"
            },
            "LoginName": {
              "type": "string",
              "title": "Login Name",
              "description": "User login name"
            },
            "IsSiteAdmin": {
              "type": "boolean",
              "title": "Is Site Admin",
              "description": "Whether user is site admin"
            },
            "PrincipalType": {
              "type": "integer",
              "title": "Principal Type",
              "description": "Principal type"
            },
            "UserPrincipalName": {
              "type": "string",
              "title": "User Principal Name",
              "description": "User principal name"
            }
          },
          "description": "User details if found in SharePoint"
        },
        "error_message": {
          "type": "string",
          "title": "Error Message",
          "default": "",
          "description": "Error message if user not found or lookup failed"
        }
      }
    }
  },
  "title": "FindUserResponseWrapper",
  "required": [
    "data",
    "successful"
  ],
  "properties": {
    "data": {
      "type": "object",
      "title": "Data",
      "required": [
        "user_exists"
      ],
      "properties": {
        "user_exists": {
          "type": "boolean",
          "title": "User Exists",
          "description": "Whether user exists in SharePoint site"
        },
        "user_details": {
          "type": "object",
          "title": "User Details",
          "properties": {
            "Id": {
              "type": "integer",
              "title": "Id",
              "description": "User ID in SharePoint"
            },
            "Email": {
              "type": "string",
              "title": "Email",
              "description": "Email address"
            },
            "Title": {
              "type": "string",
              "title": "Title",
              "description": "Display name"
            },
            "LoginName": {
              "type": "string",
              "title": "Login Name",
              "description": "User login name"
            },
            "IsSiteAdmin": {
              "type": "boolean",
              "title": "Is Site Admin",
              "description": "Whether user is site admin"
            },
            "PrincipalType": {
              "type": "integer",
              "title": "Principal Type",
              "description": "Principal type"
            },
            "UserPrincipalName": {
              "type": "string",
              "title": "User Principal Name",
              "description": "User principal name"
            }
          },
          "description": "User details if found in SharePoint"
        },
        "error_message": {
          "type": "string",
          "title": "Error Message",
          "default": "",
          "description": "Error message if user not found or lookup failed"
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

## SHARE_POINT_SHAREPOINT_REMOVE_USER
Removes a user from SharePoint. Returns success even if user doesn't exist or was never a member; check response fields `was_removed` (bool) and `message` (str) to distinguish an actual removal from a no-op.

**Input schema:**
```json
{
  "type": "object",
  "title": "RemoveUserRequest",
  "required": [
    "email"
  ],
  "properties": {
    "email": {
      "type": "string",
      "title": "Email",
      "description": "Email address of the user to remove.",
      "human_parameter_name": "User Email",
      "human_parameter_description": "The email address of the person you want to remove from SharePoint. Use their work email as it appears in SharePoint."
    },
    "site_name": {
      "type": "string",
      "title": "Site Name",
      "description": "The subsite name to scope the request to (e.g., 'composio-test'). If omitted, the root site is used. When provided, the API base URL becomes 'https://{tenant}.sharepoint.com/sites/{site}'.",
      "human_parameter_name": "Subsite",
      "human_parameter_description": "Optional subsite name if you want to remove the user from a specific subsite instead of the root site."
    }
  }
}
```

**Output schema:**
```json
{
  "type": "object",
  "$defs": {
    "RemoveUserResponse": {
      "type": "object",
      "title": "RemoveUserResponse",
      "required": [
        "message",
        "was_removed",
        "email"
      ],
      "properties": {
        "email": {
          "type": "string",
          "title": "Email",
          "description": "The email of the user that was removed"
        },
        "message": {
          "type": "string",
          "title": "Message",
          "description": "Success message indicating user removal status"
        },
        "was_removed": {
          "type": "boolean",
          "title": "Was Removed",
          "description": "Whether the user was actually removed"
        }
      }
    }
  },
  "title": "RemoveUserResponseWrapper",
  "required": [
    "data",
    "successful"
  ],
  "properties": {
    "data": {
      "type": "object",
      "title": "Data",
      "required": [
        "message",
        "was_removed",
        "email"
      ],
      "properties": {
        "email": {
          "type": "string",
          "title": "Email",
          "description": "The email of the user that was removed"
        },
        "message": {
          "type": "string",
          "title": "Message",
          "description": "Success message indicating user removal status"
        },
        "was_removed": {
          "type": "boolean",
          "title": "Was Removed",
          "description": "Whether the user was actually removed"
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

## SHARE_POINT_UNDO_CHECKOUT_FILE
Tool to undo a file checkout, discarding any changes made while checked out. Use when you need to cancel edits and unlock the file without saving.

**Input schema:**
```json
{
  "type": "object",
  "title": "UndoCheckoutFileRequest",
  "required": [
    "server_relative_path"
  ],
  "properties": {
    "site_name": {
      "type": "string",
      "title": "Site Name",
      "examples": [
        "composio-test",
        "Finance",
        "HR"
      ],
      "description": "The subsite name to scope the request to (e.g., 'composio-test'). If omitted, the root site is used. When provided, the API base URL becomes https://{tenant}.sharepoint.com/sites/{site}."
    },
    "server_relative_path": {
      "type": "string",
      "title": "Server Relative Path",
      "examples": [
        "/Shared Documents/test_undocheckout.txt",
        "/sites/Finance/Documents/report.docx"
      ],
      "description": "Server-relative URL of the file to undo checkout, including library and folders. E.g., '/Shared Documents/test_undocheckout.txt'. This will discard any changes made while checked out."
    }
  }
}
```

**Output schema:**
```json
{
  "type": "object",
  "$defs": {
    "UndoCheckoutFileResponse": {
      "type": "object",
      "title": "UndoCheckoutFileResponse",
      "required": [
        "status",
        "message",
        "server_relative_path"
      ],
      "properties": {
        "status": {
          "type": "integer",
          "title": "Status",
          "description": "HTTP status code returned by SharePoint for the undo checkout operation. 200 or 204 indicates success."
        },
        "message": {
          "type": "string",
          "title": "Message",
          "description": "Success message confirming the file checkout has been undone and changes discarded."
        },
        "server_relative_path": {
          "type": "string",
          "title": "Server Relative Path",
          "description": "Server-relative path of the file."
        }
      }
    }
  },
  "title": "UndoCheckoutFileResponseWrapper",
  "required": [
    "data",
    "successful"
  ],
  "properties": {
    "data": {
      "type": "object",
      "title": "Data",
      "required": [
        "status",
        "message",
        "server_relative_path"
      ],
      "properties": {
        "status": {
          "type": "integer",
          "title": "Status",
          "description": "HTTP status code returned by SharePoint for the undo checkout operation. 200 or 204 indicates success."
        },
        "message": {
          "type": "string",
          "title": "Message",
          "description": "Success message confirming the file checkout has been undone and changes discarded."
        },
        "server_relative_path": {
          "type": "string",
          "title": "Server Relative Path",
          "description": "Server-relative path of the file."
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

## SHARE_POINT_UPDATE_CONTENT_TYPE
Tool to update a SharePoint content type's properties such as name, description, group, or hidden status. Use when you need to modify content type metadata.

**Input schema:**
```json
{
  "type": "object",
  "title": "UpdateContentTypeRequest",
  "required": [
    "content_type_id"
  ],
  "properties": {
    "name": {
      "type": "string",
      "title": "Name",
      "examples": [
        "Updated Content Type"
      ],
      "description": "The name of the content type. Use this to rename the content type."
    },
    "group": {
      "type": "string",
      "title": "Group",
      "examples": [
        "Custom Content Types"
      ],
      "description": "The group name that this content type belongs to. Use this to change the group classification."
    },
    "hidden": {
      "type": "boolean",
      "title": "Hidden",
      "description": "Indicates whether the content type is hidden in the list's New menu. Set to true to hide the content type."
    },
    "site_name": {
      "type": "string",
      "title": "Site Name",
      "examples": [
        "composio-test"
      ],
      "description": "The subsite name to scope the request to (e.g., 'composio-test'). If omitted, the root site is used. When provided, the API base URL becomes https://{tenant}.sharepoint.com/sites/{site}."
    },
    "description": {
      "type": "string",
      "title": "Description",
      "examples": [
        "Updated description via REST API"
      ],
      "description": "The descriptive text for the content type. Use this to update the content type description."
    },
    "document_set": {
      "type": "object",
      "title": "DocumentSet",
      "properties": {
        "sharedColumns": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "DocumentSetSharedColumn",
            "properties": {
              "id": {
                "type": "string",
                "title": "Id",
                "description": "The ID of the shared column."
              },
              "name": {
                "type": "string",
                "title": "Name",
                "description": "The name of the shared column."
              }
            },
            "description": "Model for document set shared columns."
          },
          "title": "Shared Columns",
          "description": "List of shared columns in the document set."
        },
        "defaultContents": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "DocumentSetDefaultContent",
            "properties": {
              "fileName": {
                "type": "string",
                "title": "File Name",
                "description": "The file name for the default content."
              },
              "folderName": {
                "type": "string",
                "title": "Folder Name",
                "description": "The folder path for the default content."
              },
              "contentTypeName": {
                "type": "string",
                "title": "Content Type Name",
                "description": "The name of the content type for the default content."
              }
            },
            "description": "Model for document set default contents."
          },
          "title": "Default Contents",
          "description": "List of default contents for the document set."
        },
        "welcomePageColumns": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "DocumentSetWelcomePageColumn",
            "properties": {
              "id": {
                "type": "string",
                "title": "Id",
                "description": "The ID of the welcome page column."
              },
              "name": {
                "type": "string",
                "title": "Name",
                "description": "The name of the welcome page column."
              }
            },
            "description": "Model for document set welcome page columns."
          },
          "title": "Welcome Page Columns",
          "description": "List of welcome page columns in the document set."
        },
        "allowedContentTypes": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "DocumentSetAllowedContentType",
            "properties": {
              "id": {
                "type": "string",
                "title": "Id",
                "description": "The content type ID."
              },
              "name": {
                "type": "string",
                "title": "Name",
                "description": "The content type name."
              }
            },
            "description": "Model for document set allowed content types."
          },
          "title": "Allowed Content Types",
          "description": "List of content types allowed in the document set."
        },
        "shouldPrefixNameToFile": {
          "type": "boolean",
          "title": "Should Prefix Name To File",
          "description": "Whether to prefix the document set name to files."
        }
      },
      "description": "Model for document set metadata.",
      "additionalProperties": false
    },
    "content_type_id": {
      "type": "string",
      "title": "Content Type Id",
      "examples": [
        "0x01",
        "0x0101"
      ],
      "description": "The unique identifier of the content type to update. This can be the content type ID (e.g., '0x01' for Item) or the string ID from the Id.StringValue property."
    }
  },
  "description": "Request model for updating a SharePoint content type."
}
```

**Output schema:**
```json
{
  "type": "object",
  "$defs": {
    "ContentTypeIdObject": {
      "type": "object",
      "title": "ContentTypeIdObject",
      "properties": {
        "StringValue": {
          "type": "string",
          "title": "String Value",
          "description": "String representation of the content type ID."
        }
      },
      "description": "Model for content type ID object."
    },
    "UpdateContentTypeResponse": {
      "type": "object",
      "title": "UpdateContentTypeResponse",
      "properties": {
        "Id": {
          "type": "object",
          "title": "Id",
          "properties": {
            "StringValue": {
              "type": "string",
              "title": "String Value",
              "description": "String representation of the content type ID."
            }
          },
          "description": "Content type ID object with StringValue property."
        },
        "Name": {
          "type": "string",
          "title": "Name",
          "description": "Name of the content type."
        },
        "Group": {
          "type": "string",
          "title": "Group",
          "description": "Content type group."
        },
        "Hidden": {
          "type": "boolean",
          "title": "Hidden",
          "description": "Whether the content type is hidden."
        },
        "Sealed": {
          "type": "boolean",
          "title": "Sealed",
          "description": "Whether the content type is sealed."
        },
        "ReadOnly": {
          "type": "boolean",
          "title": "Read Only",
          "description": "Whether the content type is read-only."
        },
        "StringId": {
          "type": "string",
          "title": "String Id",
          "description": "String representation of the content type ID."
        },
        "Description": {
          "type": "string",
          "title": "Description",
          "description": "Description of the content type."
        }
      },
      "description": "Response model for the updated content type."
    }
  },
  "title": "UpdateContentTypeResponseWrapper",
  "required": [
    "data",
    "successful"
  ],
  "properties": {
    "data": {
      "type": "object",
      "title": "Data",
      "properties": {
        "Id": {
          "type": "object",
          "title": "Id",
          "properties": {
            "StringValue": {
              "type": "string",
              "title": "String Value",
              "description": "String representation of the content type ID."
            }
          },
          "description": "Content type ID object with StringValue property."
        },
        "Name": {
          "type": "string",
          "title": "Name",
          "description": "Name of the content type."
        },
        "Group": {
          "type": "string",
          "title": "Group",
          "description": "Content type group."
        },
        "Hidden": {
          "type": "boolean",
          "title": "Hidden",
          "description": "Whether the content type is hidden."
        },
        "Sealed": {
          "type": "boolean",
          "title": "Sealed",
          "description": "Whether the content type is sealed."
        },
        "ReadOnly": {
          "type": "boolean",
          "title": "Read Only",
          "description": "Whether the content type is read-only."
        },
        "StringId": {
          "type": "string",
          "title": "String Id",
          "description": "String representation of the content type ID."
        },
        "Description": {
          "type": "string",
          "title": "Description",
          "description": "Description of the content type."
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

## SHARE_POINT_UPDATE_DRIVE_ITEM
Tool to update the properties of a drive item (file or folder) in SharePoint using SharePoint REST API. Use when you need to rename files/folders or update their title property.

**Input schema:**
```json
{
  "type": "object",
  "title": "UpdateDriveItemRequest",
  "required": [
    "server_relative_url"
  ],
  "properties": {
    "name": {
      "type": "string",
      "title": "Name",
      "examples": [
        "new-file-name.docx",
        "Updated Folder"
      ],
      "description": "The new name for the item (filename with extension for files, folder name for folders). Use to rename the file or folder."
    },
    "title": {
      "type": "string",
      "title": "Title",
      "examples": [
        "My Document Title",
        "Project Folder"
      ],
      "description": "The new title for the item. This updates the Title field of the list item."
    },
    "site_name": {
      "type": "string",
      "title": "Site Name",
      "examples": [
        "composio-test",
        "Finance",
        "HR"
      ],
      "description": "The subsite name to scope the request to (e.g., 'composio-test'). If omitted, the root site is used. When provided, the API base URL becomes https://{tenant}.sharepoint.com/sites/{site}."
    },
    "server_relative_url": {
      "type": "string",
      "title": "Server Relative Url",
      "examples": [
        "/Shared Documents/test.docx",
        "/sites/mysite/Documents/MyFolder"
      ],
      "description": "The server-relative URL of the file or folder to update (e.g., '/Shared Documents/file.docx' or '/sites/mysite/Shared Documents/folder')."
    }
  },
  "description": "Request parameters for updating a drive item's (file or folder) properties via SharePoint REST API.",
  "additionalProperties": false
}
```

**Output schema:**
```json
{
  "type": "object",
  "$defs": {
    "UpdateDriveItemResponse": {
      "type": "object",
      "title": "UpdateDriveItemResponse",
      "properties": {
        "Id": {
          "type": "integer",
          "title": "Id",
          "description": "The list item ID."
        },
        "Title": {
          "type": "string",
          "title": "Title",
          "description": "The title of the item."
        },
        "Created": {
          "type": "string",
          "title": "Created",
          "description": "Date and time of item creation."
        },
        "FileRef": {
          "type": "string",
          "title": "File Ref",
          "description": "The server-relative URL of the item."
        },
        "Modified": {
          "type": "string",
          "title": "Modified",
          "description": "Date and time the item was last modified."
        },
        "odata.id": {
          "type": "string",
          "title": "Odata.Id",
          "description": "OData ID of the resource."
        },
        "odata.etag": {
          "type": "string",
          "title": "Odata.Etag",
          "description": "OData etag of the resource."
        },
        "odata.type": {
          "type": "string",
          "title": "Odata.Type",
          "description": "OData type of the resource."
        },
        "FileLeafRef": {
          "type": "string",
          "title": "File Leaf Ref",
          "description": "The name of the file or folder."
        },
        "ContentTypeId": {
          "type": "string",
          "title": "Content Type Id",
          "description": "Content type ID."
        },
        "odata.editLink": {
          "type": "string",
          "title": "Odata.Edit Link",
          "description": "OData edit link."
        },
        "File_x0020_Type": {
          "type": "string",
          "title": "File X0020 Type",
          "description": "The file extension (for files)."
        }
      },
      "description": "Response model containing the updated drive item details.",
      "additionalProperties": true
    }
  },
  "title": "UpdateDriveItemResponseWrapper",
  "required": [
    "data",
    "successful"
  ],
  "properties": {
    "data": {
      "type": "object",
      "title": "Data",
      "properties": {
        "Id": {
          "type": "integer",
          "title": "Id",
          "description": "The list item ID."
        },
        "Title": {
          "type": "string",
          "title": "Title",
          "description": "The title of the item."
        },
        "Created": {
          "type": "string",
          "title": "Created",
          "description": "Date and time of item creation."
        },
        "FileRef": {
          "type": "string",
          "title": "File Ref",
          "description": "The server-relative URL of the item."
        },
        "Modified": {
          "type": "string",
          "title": "Modified",
          "description": "Date and time the item was last modified."
        },
        "odata.id": {
          "type": "string",
          "title": "Odata.Id",
          "description": "OData ID of the resource."
        },
        "odata.etag": {
          "type": "string",
          "title": "Odata.Etag",
          "description": "OData etag of the resource."
        },
        "odata.type": {
          "type": "string",
          "title": "Odata.Type",
          "description": "OData type of the resource."
        },
        "FileLeafRef": {
          "type": "string",
          "title": "File Leaf Ref",
          "description": "The name of the file or folder."
        },
        "ContentTypeId": {
          "type": "string",
          "title": "Content Type Id",
          "description": "Content type ID."
        },
        "odata.editLink": {
          "type": "string",
          "title": "Odata.Edit Link",
          "description": "OData edit link."
        },
        "File_x0020_Type": {
          "type": "string",
          "title": "File X0020 Type",
          "description": "The file extension (for files)."
        }
      },
      "description": "Data from the action execution",
      "additionalProperties": true
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

## SHARE_POINT_UPDATE_LIST
Tool to update properties of an existing SharePoint list. Use when you need to modify list metadata such as title, description, or settings like versioning and attachments.

**Input schema:**
```json
{
  "type": "object",
  "title": "UpdateListRequest",
  "required": [
    "list_guid"
  ],
  "properties": {
    "title": {
      "type": "string",
      "title": "Title",
      "examples": [
        "Updated List Title"
      ],
      "description": "New title for the list. Provide this to rename the list."
    },
    "if_match": {
      "type": "string",
      "title": "If Match",
      "default": "*",
      "description": "ETag value for concurrency control. Use '*' to force update regardless of version. Provide a specific ETag to ensure safe concurrent updates."
    },
    "list_guid": {
      "type": "string",
      "title": "List Guid",
      "examples": [
        "a12e3d6e-9414-462d-bd53-cf06f3982ad3"
      ],
      "description": "GUID of the SharePoint list to update, in canonical format (e.g., 'a12e3d6e-9414-462d-bd53-cf06f3982ad3')."
    },
    "site_name": {
      "type": "string",
      "title": "Site Name",
      "examples": [
        "composio-test",
        "marketing",
        "hr-portal"
      ],
      "description": "The subsite name to scope the request to (e.g., 'composio-test'). If omitted, the root site is used. When provided, the API base URL becomes https://{tenant}.sharepoint.com/sites/{site}."
    },
    "description": {
      "type": "string",
      "title": "Description",
      "examples": [
        "Updated list description via API"
      ],
      "description": "New description for the list. Provide this to update the list description."
    },
    "enable_versioning": {
      "type": "boolean",
      "title": "Enable Versioning",
      "description": "Whether versioning is enabled for the list. Set to true to enable, false to disable."
    },
    "enable_attachments": {
      "type": "boolean",
      "title": "Enable Attachments",
      "description": "Whether attachments are enabled for list items. Set to true to enable, false to disable."
    },
    "content_types_enabled": {
      "type": "boolean",
      "title": "Content Types Enabled",
      "description": "Whether content types are enabled for the list. Set to true to enable, false to disable."
    }
  },
  "description": "Request model for updating a SharePoint list."
}
```

**Output schema:**
```json
{
  "type": "object",
  "$defs": {
    "UpdateListResponse": {
      "type": "object",
      "title": "UpdateListResponse",
      "required": [
        "success",
        "list_guid",
        "message"
      ],
      "properties": {
        "message": {
          "type": "string",
          "title": "Message",
          "description": "Success message describing the update result."
        },
        "success": {
          "type": "boolean",
          "title": "Success",
          "description": "Indicates whether the update operation succeeded."
        },
        "list_guid": {
          "type": "string",
          "title": "List Guid",
          "description": "The GUID of the updated list."
        }
      },
      "description": "Response model for a successful list update."
    }
  },
  "title": "UpdateListResponseWrapper",
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
        "list_guid",
        "message"
      ],
      "properties": {
        "message": {
          "type": "string",
          "title": "Message",
          "description": "Success message describing the update result."
        },
        "success": {
          "type": "boolean",
          "title": "Success",
          "description": "Indicates whether the update operation succeeded."
        },
        "list_guid": {
          "type": "string",
          "title": "List Guid",
          "description": "The GUID of the updated list."
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

## SHARE_POINT_UPDATE_LIST_ITEM
Tool to update fields on an existing SharePoint list item. Use when you need to modify an item's properties with proper ETag concurrency control via MERGE.

**Input schema:**
```json
{
  "type": "object",
  "title": "UpdateListItemRequest",
  "examples": [
    {
      "etag": "*",
      "fields": {
        "Title": "Updated Task",
        "Status": "Complete"
      },
      "item_id": 5,
      "list_title": "Tasks"
    },
    {
      "etag": "*",
      "fields": {
        "Title": "Q4 Initiative",
        "ProjectManagerId": 12
      },
      "item_id": 10,
      "list_title": "Projects"
    },
    {
      "etag": "*",
      "fields": {
        "Title": "Blog Post",
        "AuthorsId": {
          "results": [
            5,
            8,
            12
          ]
        }
      },
      "item_id": 7,
      "list_title": "Content Calendar"
    }
  ],
  "required": [
    "list_title",
    "item_id",
    "fields"
  ],
  "properties": {
    "etag": {
      "type": "string",
      "title": "Etag",
      "default": "*",
      "description": "ETag value for concurrency control. Use '*' to force update regardless of version. Provide a specific ETag (from GET_LIST_ITEM_ETAG tool) to ensure safe concurrent updates. Format: '\"guid,version\"' like '\"c7a93369-bda8-4da1-b1a3-3d87d2e207fc,1\"'."
    },
    "fields": {
      "type": "object",
      "title": "Fields",
      "examples": [
        {
          "Title": "Updated Title",
          "Status": "Complete"
        },
        {
          "ProjectId": 5,
          "AssignedToId": 12
        },
        {
          "CategoriesId": {
            "results": [
              1,
              3,
              5
            ]
          }
        }
      ],
      "description": "Dictionary mapping internal field names to their new values. Supports text, numbers, booleans, dates, and complex types for lookup/person fields.\n\n**Lookup fields (single-value)**: Append 'Id' to the internal field name and provide the lookup item's ID as an integer. Example: {'ProjectId': 5}\n\n**Lookup fields (multi-value)**: Append 'Id' to the field name and provide {'results': [id1, id2, ...]} using OData verbose format. Example: {'CategoriesId': {'results': [1, 3, 5]}}\n\n**Person/Group fields (single-value)**: Append 'Id' to the field name and provide the user's ID as an integer. Example: {'AssignedToId': 12}\n\n**Person/Group fields (multi-value)**: Append 'Id' to the field name and provide {'results': [userId1, userId2, ...]} using OData verbose format. Example: {'TeamMembersId': {'results': [12, 15, 18]}}\n\n**Note**: Internal field names with spaces are encoded with '_x0020_' (e.g., 'Related_x0020_Item' for 'Related Item'). The OData verbose format {'results': [...]} is required for multi-value fields per SharePoint REST API conventions.",
      "additionalProperties": {
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
            "type": "null"
          }
        ]
      }
    },
    "item_id": {
      "type": "integer",
      "title": "Item Id",
      "minimum": 1,
      "examples": [
        1,
        42
      ],
      "description": "Numeric ID of the list item to update."
    },
    "site_name": {
      "type": "string",
      "title": "Site Name",
      "description": "The subsite name to scope the request to (e.g., 'composio-test'). If omitted, the root site is used. When provided, the API base URL becomes https://{tenant}.sharepoint.com/sites/{site}."
    },
    "list_title": {
      "type": "string",
      "title": "List Title",
      "examples": [
        "Tasks",
        "My List"
      ],
      "description": "The exact title of the SharePoint list containing the item to update."
    },
    "entity_type_full_name": {
      "type": "string",
      "title": "Entity Type Full Name",
      "description": "The ListItemEntityTypeFullName required for __metadata.type in the request body. If not provided, it will be fetched automatically using GET_LIST_ITEM_ENTITY_TYPE_FULL_NAME. Format: 'SP.Data.{ListName}ListItem' like 'SP.Data.TasksListItem'."
    }
  },
  "description": "Request model for updating a SharePoint list item.",
  "additionalProperties": false
}
```

**Output schema:**
```json
{
  "type": "object",
  "$defs": {
    "UpdateListItemResponse": {
      "type": "object",
      "title": "UpdateListItemResponse",
      "required": [
        "success",
        "item_id",
        "message"
      ],
      "properties": {
        "etag": {
          "type": "string",
          "title": "Etag",
          "description": "The ETag of the updated item, if returned by the server."
        },
        "item_id": {
          "type": "integer",
          "title": "Item Id",
          "description": "The ID of the updated list item."
        },
        "message": {
          "type": "string",
          "title": "Message",
          "description": "Success message describing the update result."
        },
        "success": {
          "type": "boolean",
          "title": "Success",
          "description": "Indicates whether the update operation succeeded."
        }
      },
      "description": "Response model for a successful list item update."
    }
  },
  "title": "UpdateListItemResponseWrapper",
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
        "item_id",
        "message"
      ],
      "properties": {
        "etag": {
          "type": "string",
          "title": "Etag",
          "description": "The ETag of the updated item, if returned by the server."
        },
        "item_id": {
          "type": "integer",
          "title": "Item Id",
          "description": "The ID of the updated list item."
        },
        "message": {
          "type": "string",
          "title": "Message",
          "description": "Success message describing the update result."
        },
        "success": {
          "type": "boolean",
          "title": "Success",
          "description": "Indicates whether the update operation succeeded."
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

## SHARE_POINT_UPDATE_SITE
Tool to update properties of the current SharePoint site (web). Use when you need to modify site title, description, or other SP.Web properties via MERGE.

**Input schema:**
```json
{
  "type": "object",
  "title": "UpdateSiteRequest",
  "example": {
    "title": "Updated Site Title",
    "description": "Updated site description via API"
  },
  "properties": {
    "title": {
      "type": "string",
      "title": "Title",
      "examples": [
        "My Updated Site",
        "Engineering Team Site"
      ],
      "description": "The new title for the site. If not provided, the title will not be updated."
    },
    "site_name": {
      "type": "string",
      "title": "Site Name",
      "examples": [
        "composio-test",
        "engineering-team"
      ],
      "description": "The subsite name to scope the request to (e.g., `composio-test`). If omitted, the root site is used. When provided, the API base URL becomes `https://{tenant}.sharepoint.com/sites/{site}`."
    },
    "description": {
      "type": "string",
      "title": "Description",
      "examples": [
        "Updated site description",
        "This site is for the engineering team"
      ],
      "description": "The new description for the site. If not provided, the description will not be updated."
    },
    "tree_view_enabled": {
      "type": "boolean",
      "title": "Tree View Enabled",
      "description": "Whether the tree view is enabled on the site."
    },
    "quick_launch_enabled": {
      "type": "boolean",
      "title": "Quick Launch Enabled",
      "description": "Whether the Quick Launch navigation is enabled on the site."
    },
    "enable_minimal_download": {
      "type": "boolean",
      "title": "Enable Minimal Download",
      "description": "Whether to enable minimal download strategy for the site."
    },
    "save_site_as_template_enabled": {
      "type": "boolean",
      "title": "Save Site As Template Enabled",
      "description": "Whether the 'Save Site as Template' feature is enabled."
    }
  },
  "description": "Request model for updating a SharePoint site (web).",
  "additionalProperties": false
}
```

**Output schema:**
```json
{
  "type": "object",
  "$defs": {
    "UpdateSiteResponse": {
      "type": "object",
      "title": "UpdateSiteResponse",
      "required": [
        "success",
        "message"
      ],
      "properties": {
        "message": {
          "type": "string",
          "title": "Message",
          "description": "Success message describing the update result."
        },
        "success": {
          "type": "boolean",
          "title": "Success",
          "description": "Indicates whether the update operation succeeded."
        }
      },
      "description": "Response model for a successful site update."
    }
  },
  "title": "UpdateSiteResponseWrapper",
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
          "description": "Success message describing the update result."
        },
        "success": {
          "type": "boolean",
          "title": "Success",
          "description": "Indicates whether the update operation succeeded."
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

## SHARE_POINT_UPLOAD_FILE
Tool to upload a file to a SharePoint document library or folder. Use when you need to programmatically add or update a file in a document library.

**Input schema:**
```json
{
  "type": "object",
  "title": "UploadFileRequest",
  "required": [
    "folder_relative_url"
  ],
  "properties": {
    "file": {
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
      "description": "File to upload. Alternatively, omit this and provide either 'content_text' for UTF-8 text or 'content_base64' for arbitrary bytes along with 'file_name' to set the filename.",
      "file_uploadable": true,
      "additionalProperties": false
    },
    "file_name": {
      "type": "string",
      "title": "File Name",
      "examples": [
        "document.txt",
        "image.png"
      ],
      "description": "Filename to use when uploading if 'file' is not provided."
    },
    "overwrite": {
      "type": "boolean",
      "title": "Overwrite",
      "default": true,
      "description": "Whether to overwrite an existing file with the same name. Defaults to true."
    },
    "site_name": {
      "type": "string",
      "title": "Site Name",
      "examples": [
        "composio-test"
      ],
      "description": "The subsite name to scope the request to (e.g., 'composio-test'). If omitted, the root site is used. When provided, the API base URL becomes https://{tenant}.sharepoint.com/sites/{site}."
    },
    "content_text": {
      "type": "string",
      "title": "Content Text",
      "description": "Optional raw text content to upload (UTF-8 encoded). Use when not passing 'file'."
    },
    "content_base64": {
      "type": "string",
      "title": "Content Base64",
      "description": "Optional base64-encoded bytes to upload. Use for binary content when not passing 'file'."
    },
    "folder_relative_url": {
      "type": "string",
      "title": "Folder Relative Url",
      "examples": [
        "/Shared Documents"
      ],
      "description": "Server-relative URL of the destination folder, starting with '/'. E.g., '/Shared Documents'."
    }
  },
  "description": "Request model for uploading a file to a SharePoint document library or folder.",
  "additionalProperties": false
}
```

**Output schema:**
```json
{
  "type": "object",
  "$defs": {
    "UploadFileResponse": {
      "type": "object",
      "title": "UploadFileResponse",
      "required": [
        "server_relative_path",
        "name"
      ],
      "properties": {
        "name": {
          "type": "string",
          "title": "Name",
          "description": "Name of the uploaded file"
        },
        "server_relative_path": {
          "type": "string",
          "title": "Server Relative Path",
          "description": "Server-relative URL of the uploaded file"
        }
      },
      "description": "Response model containing the server-relative path and name of the uploaded file."
    }
  },
  "title": "UploadFileResponseWrapper",
  "required": [
    "data",
    "successful"
  ],
  "properties": {
    "data": {
      "type": "object",
      "title": "Data",
      "required": [
        "server_relative_path",
        "name"
      ],
      "properties": {
        "name": {
          "type": "string",
          "title": "Name",
          "description": "Name of the uploaded file"
        },
        "server_relative_path": {
          "type": "string",
          "title": "Server Relative Path",
          "description": "Server-relative URL of the uploaded file"
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

## SHARE_POINT_UPLOAD_FROM_URL
Tool to fetch a file from a URL and upload it to SharePoint. Use when you need to upload files directly from external URLs without downloading them to the client first.

**Input schema:**
```json
{
  "type": "object",
  "title": "UploadFromUrlRequest",
  "required": [
    "file_url"
  ],
  "properties": {
    "site_id": {
      "type": "string",
      "title": "Site Id",
      "description": "SharePoint site ID (e.g., contoso.sharepoint.com,2C712604-...,2D2244C3-...). If not provided, uses the default site from authentication."
    },
    "drive_id": {
      "type": "string",
      "title": "Drive Id",
      "examples": [
        "b!xyz123"
      ],
      "description": "Drive ID where the file should be uploaded. If not provided, uses the default document library."
    },
    "file_url": {
      "type": "string",
      "title": "File Url",
      "examples": [
        "https://example.com/document.pdf",
        "https://cdn.example.com/image.png"
      ],
      "description": "The URL of the file to download and upload to SharePoint. Must be accessible from the server."
    },
    "file_name": {
      "type": "string",
      "title": "File Name",
      "examples": [
        "document.pdf",
        "report.xlsx"
      ],
      "description": "Name for the uploaded file. If not provided, extracts from the URL or Content-Disposition header."
    },
    "overwrite": {
      "type": "boolean",
      "title": "Overwrite",
      "default": true,
      "description": "Whether to overwrite the file if it already exists. Default: true."
    },
    "folder_path": {
      "type": "string",
      "title": "Folder Path",
      "examples": [
        "Documents",
        "Documents/Projects",
        "Shared Documents/Team"
      ],
      "description": "Folder path relative to the drive root (e.g., 'Documents/Projects'). Defaults to root of drive."
    },
    "source_headers": {
      "type": "object",
      "title": "Source Headers",
      "examples": [
        {
          "Authorization": "Bearer token123"
        },
        {
          "X-Custom-Header": "value"
        }
      ],
      "description": "Optional HTTP headers to include when downloading from file_url. Use for authentication tokens, signed URLs, or CDN-specific headers.",
      "additionalProperties": {
        "type": "string"
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
    "UploadFromUrlResponse": {
      "type": "object",
      "title": "UploadFromUrlResponse",
      "required": [
        "id",
        "name"
      ],
      "properties": {
        "id": {
          "type": "string",
          "title": "Id",
          "description": "The unique ID of the uploaded file in SharePoint."
        },
        "name": {
          "type": "string",
          "title": "Name",
          "description": "The name of the uploaded file."
        },
        "size": {
          "type": "integer",
          "title": "Size",
          "description": "The size of the file in bytes."
        },
        "webUrl": {
          "type": "string",
          "title": "Web Url",
          "description": "A URL for opening the file in SharePoint's web interface."
        },
        "createdDateTime": {
          "type": "string",
          "title": "Created Date Time",
          "description": "The timestamp when the file was created."
        },
        "lastModifiedDateTime": {
          "type": "string",
          "title": "Last Modified Date Time",
          "description": "The timestamp when the file was last modified."
        }
      }
    }
  },
  "title": "UploadFromUrlResponseWrapper",
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
          "description": "The unique ID of the uploaded file in SharePoint."
        },
        "name": {
          "type": "string",
          "title": "Name",
          "description": "The name of the uploaded file."
        },
        "size": {
          "type": "integer",
          "title": "Size",
          "description": "The size of the file in bytes."
        },
        "webUrl": {
          "type": "string",
          "title": "Web Url",
          "description": "A URL for opening the file in SharePoint's web interface."
        },
        "createdDateTime": {
          "type": "string",
          "title": "Created Date Time",
          "description": "The timestamp when the file was created."
        },
        "lastModifiedDateTime": {
          "type": "string",
          "title": "Last Modified Date Time",
          "description": "The timestamp when the file was last modified."
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
