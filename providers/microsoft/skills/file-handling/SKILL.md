---
name: file-handling
description: >
  Read and analyze files uploaded by the user. Use when the user references
  a file, data, document, CSV, or PDF, or when uploaded files are relevant
  to the current request. Files are at /files/, workspace cache at /workspace/.
compatibility: Agent Builder V2
---

## When to Use

Use this skill when the user references a file or data, or when file content
is needed to complete your task. Skip it when the question is clearly
unrelated to files or documents.

## Reading Files

Use `read_file` for all file types — PDF, CSV, Excel, Word, and text files
are all supported. Always use `limit` to avoid flooding context.

```
CSV / JSON / text:  read_file("/files/{filename}", offset=0, limit=100)
PDF / Excel / Word: read_file("/files/{filename}", offset=0, limit=50)
```

Use `offset` to read further sections if the initial view is insufficient.

## Workspace Cache

<constraints>
Always write analysis to /workspace/ after reading any file from /files/.
This is required — not optional.
</constraints>

After reading a file, write to `/workspace/analysis_{filename}.md`:
- Structural information: column names, data types, document sections, key topics
- Key facts and insights from the content that may be referenced again
- Do NOT copy raw data rows — summarise what matters

**Before reading a raw file, always check the cache first:**
```
ls /workspace/
→ analysis_{filename}.md found → read_file("/workspace/analysis_{filename}.md", limit=100)
→ not found → read raw file with limit → write analysis to workspace → respond
```

**Naming convention** — lowercase, replace dots and spaces with underscores:
```
clients.csv             → /workspace/analysis_clients_csv.md
Factory.pdf             → /workspace/analysis_factory_pdf.md
Patricia's Client Data.xlsx → /workspace/analysis_patricias_client_data_xlsx.md
```

If a question requires specific data not in the cache, re-read the file
directly with targeted offset/limit — but still keep the cache updated.

## File Path

Uploaded files live at `/files/` — always use this path, not `/`.

```
ls /files/                                 → list all uploaded files
read_file("/files/clients.csv", limit=100) → read first 100 lines
read_file("/files/Factory.pdf")            → read PDF (sent natively to model)
read_file("/files/data.xlsx")              → read Excel as text
```

The root path `/` shows top-level directories. Always navigate to `/files/`
specifically to find user uploads.

## Write Restrictions

Only write to `/workspace/`. Do not write to `/skills/`, `/files/`, or `/memory/`.
