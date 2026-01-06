#!/bin/bash

# Cancel Ralph Loop Script for Gemini CLI
# Sets the loop state to inactive

set -euo pipefail

STATE_FILE=".gemini/ralph-loop.local.md"

if [[ ! -f "$STATE_FILE" ]]; then
  echo "❌ No active Ralph loop found" >&2
  echo "   State file not found: $STATE_FILE" >&2
  exit 1
fi

# Read current iteration from state file
ITERATION=$(grep '^iteration:' "$STATE_FILE" | sed 's/iteration: *//')

# Update state file to set active: false
if [[ "$(uname)" == "Darwin" ]]; then
  # macOS sed requires empty string after -i
  sed -i '' 's/^active: true$/active: false/' "$STATE_FILE"
else
  # GNU sed
  sed -i 's/^active: true$/active: false/' "$STATE_FILE"
fi

echo "✅ Ralph loop cancelled"
echo ""
echo "Final iteration: ${ITERATION:-unknown}"
echo "State file: $STATE_FILE"

