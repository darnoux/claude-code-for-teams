#!/bin/bash
# block-destructive.sh
# Blocks dangerous Bash commands before they run.
# Wired in .claude/settings.json under PreToolUse matcher "Bash".
# Exit 2 = block (Claude Code requires exit 2, not exit 1).

set -euo pipefail

COMMAND=$(jq -r '.tool_input.command // ""')

DANGER_PATTERNS=(
  'rm -rf'
  'rm -fr'
  'sudo'
  'mkfs'
  'dd if=/dev/zero'
  'dd if=/dev/random'
  ':(){:|:&};:'
  'chmod -R 777'
  'chown -R'
  '> /dev/sd'
  'shutdown'
  'reboot'
  'halt'
)

for pattern in "${DANGER_PATTERNS[@]}"; do
  if echo "$COMMAND" | grep -qE "$pattern"; then
    echo "BLOCKED: destructive command detected ($pattern)." >&2
    echo "Use 'trash' for deletion, git for history rewrite, ask a human for sudo." >&2
    exit 2
  fi
done

exit 0
