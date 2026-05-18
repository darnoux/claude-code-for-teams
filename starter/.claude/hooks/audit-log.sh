#!/bin/bash
# audit-log.sh
# Non-blocking PostToolUse hook. Appends every tool call to a JSONL log
# rotated monthly. Ship this to your SIEM / log aggregator quarterly.

set -euo pipefail

LOG_DIR="${CLAUDE_AUDIT_LOG_DIR:-$HOME/.claude/audit}"
mkdir -p "$LOG_DIR"
LOG_FILE="$LOG_DIR/audit-$(date +%Y-%m).jsonl"

INPUT=$(cat)

# Extract a compact record and append
echo "$INPUT" | jq -c '{
  ts: now,
  tool: .tool_name,
  session: .session_id,
  cwd: .cwd,
  user: env.USER,
  project: (.cwd | split("/") | last)
}' >> "$LOG_FILE" 2>/dev/null || true

exit 0
