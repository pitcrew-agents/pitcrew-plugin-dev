# composio_gdrive_native_tools

## gdrive_download_file
**Input schema:**
```json
{
  "type": "object",
  "required": [
    "drive_url"
  ],
  "properties": {
    "drive_url": {
      "type": "string",
      "description": "Google Drive file URL or bare file ID. Accepts https://drive.google.com/file/d/FILE_ID/view or just FILE_ID."
    }
  }
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
    "file_path": {
      "type": "string",
      "description": "Local /tmp path of the downloaded file."
    },
    "s3_path": {
      "type": "string",
      "description": "S3 key where the file is stored. Empty string if S3 upload failed."
    },
    "filename": {
      "type": "string"
    },
    "drive_file_id": {
      "type": "string"
    },
    "file_size": {
      "type": "integer",
      "description": "Size of the downloaded file in bytes."
    }
  }
}
```

## gdrive_download_folder
**Input schema:**
```json
{
  "type": "object",
  "required": [
    "folder_url"
  ],
  "properties": {
    "folder_url": {
      "type": "string",
      "description": "Google Drive folder URL or bare folder ID. Accepts https://drive.google.com/drive/folders/FOLDER_ID or just FOLDER_ID."
    }
  }
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
    "file_paths": {
      "type": "array",
      "items": {
        "type": "string"
      },
      "description": "Local /tmp paths of downloaded files. Pass directly to document_intelligence_ingest file_paths."
    },
    "s3_paths": {
      "type": "array",
      "items": {
        "type": "string"
      },
      "description": "S3 keys for each downloaded file, in the same order as file_paths. Empty string for any file where S3 upload failed."
    },
    "filenames": {
      "type": "array",
      "items": {
        "type": "string"
      },
      "description": "Original filenames from Google Drive."
    },
    "files_downloaded": {
      "type": "integer"
    },
    "files_failed": {
      "type": "integer"
    },
    "folder_id": {
      "type": "string",
      "description": "Bare Google Drive folder ID extracted from the folder URL. Use as collection_name for document_intelligence_ingest to ensure consistent collection naming."
    }
  }
}
```

## gdrive_upload_to_folder
**Input schema:**
```json
{
  "type": "object",
  "required": [
    "folder_url",
    "file_path"
  ],
  "properties": {
    "folder_url": {
      "type": "string",
      "description": "Destination Google Drive folder URL or bare folder ID. Accepts https://drive.google.com/drive/folders/FOLDER_ID or just FOLDER_ID."
    },
    "file_path": {
      "type": "string",
      "description": "Local file path of the file to upload."
    },
    "name": {
      "type": "string",
      "description": "Name for the file in Google Drive. Defaults to the local filename."
    }
  }
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
    "file_id": {
      "type": "string",
      "description": "Google Drive file ID of the uploaded file."
    },
    "name": {
      "type": "string",
      "description": "Name of the uploaded file in Drive."
    },
    "web_view_link": {
      "type": "string",
      "description": "Link to view or download the file in Google Drive."
    },
    "error": {
      "type": "string"
    }
  }
}
```
