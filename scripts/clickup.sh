#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
ENV_FILE="$ROOT/.env"
FALLBACK="$ROOT/DAILY-SUMMARY.md"

if [[ -f "$ENV_FILE" ]]; then
  set -a
  # shellcheck disable=SC1090
  source "$ENV_FILE"
  set +a
fi

if [[ $# -gt 0 ]]; then
  msg="$*"
else
  msg="$(cat)"
fi

if [[ -z "${msg// /}" ]]; then
  echo 'usage: bash scripts/clickup.sh "<message>"' >&2
  exit 1
fi

stamp="$(date '+%Y-%m-%d %H:%M %Z')"

if [[ -z "${CLICKUP_API_KEY:-}" || -z "${CLICKUP_LIST_ID:-}" ]]; then
  printf "\n---\n## %s (fallback — ClickUp not configured)\n%s\n" "$stamp" "$msg" >> "$FALLBACK"
  echo "[clickup fallback] appended to DAILY-SUMMARY.md"
  echo "$msg"
  exit 0
fi

# Extract first line as title
title=$(echo "$msg" | head -1)

# Escape JSON special characters: quote, backslash, newline, carriage return, tab
escaped_title="${title//\\/\\\\}"
escaped_title="${escaped_title//\"/\\\"}"

# Build simple JSON payload with title only (newlines not supported in task names)
payload="{\"name\": \"$escaped_title\"}"

curl -fsS -X POST \
  "https://api.clickup.com/api/v2/list/$CLICKUP_LIST_ID/task" \
  -H "Authorization: $CLICKUP_API_KEY" \
  -H "Content-Type: application/json" \
  -d "$payload"
