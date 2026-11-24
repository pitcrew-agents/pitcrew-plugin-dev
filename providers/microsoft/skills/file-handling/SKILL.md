---
name: file-handling
description: >
  Read and analyze files the user shares. Use when the user references
  a file, data, document, CSV, or PDF, or when shared files are relevant
  to the current request.
compatibility: Agent Builder V2
---

## When to Use

Use this skill when the user references a file or data, or when file content
is needed to complete your task. Skip it when the question is clearly
unrelated to files or documents.

## Reading Files

Read the file through whatever the host gives you: a file attached to the chat,
or the host's own file-reading tool for a file the user points to. There is no
fixed folder for uploads, so do not look for one.

- Read only what you need. For large files, read the first part (for example the
  first 100 rows of a CSV or the first few pages of a PDF) and read more only if
  the question needs it.
- Do not paste large raw contents back to the user.

## Keep a Summary in the Conversation

After reading a file, note a short summary in your reply so later steps (plan-mode,
edit-mode, chat-mode) can use it without reading the file again:

- Structure: column names and data types, document sections, key topics
- Key facts that the agent's inputs, mappings or tool choices depend on
- Do NOT copy raw data rows

Do not write analysis files to disk. The plan, the agent_spec and file summaries all
live in the conversation.

If a later question needs data that is not in the summary, read the file again with a
targeted range.

## Getting a File into PitCrew

Reading a file in the chat does not send it to PitCrew. When an agent run, a
collection or a form needs the file itself, use PitCrew's upload flow instead of
pasting its contents:

- Collections and forms: `open_upload_ui` (see studio-build-mode)
- Agent run inputs: `open_agent_input_form` (see the orchestrator's runner flow)
