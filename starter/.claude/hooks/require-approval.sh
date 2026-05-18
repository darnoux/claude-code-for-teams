#!/bin/bash
# require-approval.sh
# Forces a human-approval prompt for write ops on production MCPs.
# Wired in .claude/settings.json under PreToolUse matcher "mcp__.*".

set -euo pipefail

TOOL=$(jq -r '.tool_name // ""')

# MCPs that should never write without approval
PROD_SERVERS_REGEX='mcp__(supabase|postgres|github|linear|notion|hubspot|stripe|sentry)__'

# Tool name patterns that mean a write op
WRITE_OPS_REGEX='(write|create|update|delete|merge|publish|execute_sql|insert|drop|truncate|push|deploy)'

if echo "$TOOL" | grep -qE "$PROD_SERVERS_REGEX"; then
  if echo "$TOOL" | grep -qiE "$WRITE_OPS_REGEX"; then
    cat <<EOF
{"hookSpecificOutput":{"hookEventName":"PreToolUse","permissionDecision":"ask","permissionDecisionReason":"Write operation on production MCP server. Requires human approval before proceeding."}}
EOF
    exit 0
  fi
fi

exit 0
