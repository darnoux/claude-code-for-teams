#!/bin/bash
# scan-write-for-secrets.sh
# Blocks file writes that contain hardcoded API keys, or writes to known
# secret-bearing files. Wired under PreToolUse matcher "Write|Edit".

set -euo pipefail

PATH_BEING_WRITTEN=$(jq -r '.tool_input.file_path // ""')
CONTENT=$(jq -r '.tool_input.content // .tool_input.new_string // ""')

# Block writes to known secret-bearing files
if echo "$PATH_BEING_WRITTEN" | grep -qE '\.(env|pem|key|credentials|p12|pfx)$'; then
  echo "BLOCKED: writes to secret-bearing file extensions require manual edit." >&2
  echo "Path: $PATH_BEING_WRITTEN" >&2
  exit 2
fi

# Block writes to common secret directories
if echo "$PATH_BEING_WRITTEN" | grep -qE '/(secrets|credentials|private-keys)/'; then
  echo "BLOCKED: writes to secret directories require manual edit." >&2
  exit 2
fi

# Block known API key patterns in content
KEY_PATTERNS=(
  'sk-[a-zA-Z0-9]{20,}'         # OpenAI / Anthropic style
  'ghp_[a-zA-Z0-9]{20,}'         # GitHub personal access token
  'github_pat_[a-zA-Z0-9_]{20,}' # GitHub fine-grained PAT
  'AKIA[0-9A-Z]{16}'             # AWS access key
  'AIza[a-zA-Z0-9_-]{35}'        # Google API key
  'xox[abp]-[a-zA-Z0-9-]+'       # Slack bot/user token
  'rk_[a-zA-Z0-9_-]{20,}'        # Stripe restricted key
  'sk_(live|test)_[a-zA-Z0-9]{20,}' # Stripe secret key
)

for pattern in "${KEY_PATTERNS[@]}"; do
  if echo "$CONTENT" | grep -qE "$pattern"; then
    echo "BLOCKED: looks like a hardcoded API key in the content." >&2
    echo "Use environment variables and reference them via process.env / os.getenv." >&2
    exit 2
  fi
done

exit 0
