#!/usr/bin/env bash
input=$(cat)
cwd=$(echo "$input" | jq -r '.cwd // empty')

# Model name
model=$(echo "$input" | jq -r '.model.display_name // empty')

# Git branch (skip optional locks to avoid blocking)
branch=""
if [ -n "$cwd" ]; then
  branch=$(git -C "$cwd" --no-optional-locks symbolic-ref --short HEAD 2>/dev/null)
fi

# Context usage fields
used=$(echo "$input" | jq -r '.context_window.used_percentage // empty')
total_tokens=$(echo "$input" | jq -r '.context_window.total_input_tokens // empty')
window_size=$(echo "$input" | jq -r '.context_window.context_window_size // empty')

# Rate limit fields
week_pct=$(echo "$input" | jq -r '.rate_limits.seven_day.used_percentage // empty')

# Helper to append a part with a dimmed separator
sep() { printf '\033[2m|\033[0m'; }
append() {
  if [ -n "$out" ]; then
    out="$out $(sep) $1"
  else
    out="$1"
  fi
}

# Build output parts
out=""

if [ -n "$model" ]; then
  append "$(printf '\033[32m%s\033[0m' "$model")"
fi

if [ -n "$branch" ]; then
  append "$(printf '\033[36m %s\033[0m' "$branch")"
fi

if [ -n "$used" ] && [ -n "$total_tokens" ] && [ -n "$window_size" ]; then
  used_k=$(printf '%.0fk' "$(echo "$total_tokens / 1000" | bc -l)")
  max_k=$(printf '%.0fk' "$(echo "$window_size / 1000" | bc -l)")
  append "$(printf '\033[33mctx: %s/%s (%.0f%%)\033[0m' "$used_k" "$max_k" "$used")"
elif [ -n "$used" ]; then
  append "$(printf '\033[33mctx: %.0f%%\033[0m' "$used")"
fi

if [ -n "$week_pct" ]; then
  append "$(printf '\033[35mweek: %.0f%%\033[0m' "$week_pct")"
fi

[ -n "$out" ] && echo "$out"
