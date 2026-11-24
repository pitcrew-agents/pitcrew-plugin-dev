#!/usr/bin/env bash
# Copy the top-level skills/ (the single source of truth) into each provider bundle.
# Each provider keeps a committed copy because marketplaces can install straight from
# that provider's folder on GitHub.
# Usage: scripts/sync-providers.sh             every provider under providers/
#        scripts/sync-providers.sh microsoft   only the named providers
set -euo pipefail
REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"

if [ "$#" -gt 0 ]; then
  providers=("$@")
else
  providers=()
  for dir in "$REPO_ROOT"/providers/*/; do
    providers+=("$(basename "$dir")")
  done
fi

for provider in "${providers[@]}"; do
  dest="$REPO_ROOT/providers/$provider"
  if [ ! -d "$dest" ]; then
    echo "No such provider: $provider" >&2
    exit 1
  fi
  rsync -a --delete --exclude ".DS_Store" "$REPO_ROOT/skills/" "$dest/skills/"
  echo "Synced skills/ into providers/$provider/skills/"
done
