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

# Extract first line as title, rest as description
title=$(echo "$msg" | head -1)
description=$(echo "$msg" | tail -n +2)

# Escape JSON special characters in title: backslash first, then quote, then newline
escaped_title="${title//\\/\\\\}"
escaped_title="${escaped_title//\"/\\\"}"
escaped_title="${escaped_title//$'\n'/\\n}"
escaped_title="${escaped_title//$'\r'/\\r}"
escaped_title="${escaped_title//$'\t'/\\t}"

# Escape description similarly (preserve intended newlines by escaping them to \n for JSON)
escaped_desc="${description//\\/\\\\}"
escaped_desc="${escaped_desc//\"/\\\"}"
escaped_desc="${escaped_desc//$'\n'/\\n}"
escaped_desc="${escaped_desc//$'\r'/\\r}"
escaped_desc="${escaped_desc//$'\t'/\\t}"

# Build JSON payload with title and description
if [[ -n "$description" ]]; then
  payload="{\"name\": \"$escaped_title\", \"description\": \"$escaped_desc\"}"
else
  payload="{\"name\": \"$escaped_title\"}"
fi

curl -fsS -X POST \
  "https://api.clickup.com/api/v2/list/$CLICKUP_LIST_ID/task" \
  -H "Authorization: $CLICKUP_API_KEY" \
  -H "Content-Type: application/json" \
  -d "$payload"
