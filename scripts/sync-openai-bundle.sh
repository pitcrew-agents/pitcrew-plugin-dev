#!/usr/bin/env bash
# Sync the top-level skills/ and tools/ folders into the OpenAI plugin bundle.
# Skills are identical in format between Claude and the agent-plugins.org
# standard, and the plan-mode skill greps /tools/ for the workflow builder's
# tool catalog. Both must sit inside providers/openai/ for the ChatGPT bundle,
# since only files under that path get packaged. We keep a single source of
# truth at ./skills/ and ./tools/ and copy into the OpenAI bundle before
# packaging.
set -euo pipefail
REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
rsync -a --delete "$REPO_ROOT/skills/" "$REPO_ROOT/providers/openai/skills/"
echo "Synced skills/ into providers/openai/skills/"
rsync -a --delete "$REPO_ROOT/tools/" "$REPO_ROOT/providers/openai/tools/"
echo "Synced tools/ into providers/openai/tools/"
