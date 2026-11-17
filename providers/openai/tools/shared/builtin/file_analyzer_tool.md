# file_analyzer_tool

## analyze_files
Analyze one or more files using a natural-language prompt. Uses a multi-turn agentic loop (grep, head, tail, python in sandbox) to build context without overflowing the LLM context window. Handles files of any size. Returns summary, key findings, and extracted data.

**Input schema:**
```json
{}
```
