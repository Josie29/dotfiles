#!/usr/bin/env bash

input=$(cat)

# --- Parse fields from JSON input ---
cwd=$(echo "$input" | jq -r '.cwd // .workspace.current_dir // ""')
model=$(echo "$input" | jq -r '.model.display_name // ""')
used_pct=$(echo "$input" | jq -r '.context_window.used_percentage // empty')
ctx_used=$(echo "$input" | jq -r '.context_window.current_usage.input_tokens // empty')
ctx_total=$(echo "$input" | jq -r '.context_window.context_window_size // empty')
output_tokens=$(echo "$input" | jq -r '.context_window.current_usage.output_tokens // empty')

# --- Current directory (basename) ---
dir_display=$(basename "$cwd")

# --- Git branch (skip optional locks) ---
git_branch=""
if git -C "$cwd" rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  git_branch=$(git -C "$cwd" symbolic-ref --short HEAD 2>/dev/null || git -C "$cwd" rev-parse --short HEAD 2>/dev/null)
fi

# --- Context usage ---
ctx_display=""
if [ -n "$used_pct" ] && [ -n "$ctx_total" ]; then
  used_fmt=$(printf "%.0f" "$used_pct")
  # Format context_window_size as e.g. 200k
  if [ "$ctx_total" -ge 1000 ]; then
    ctx_total_fmt=$(echo "$ctx_total" | awk '{printf "%dk", $1/1000}')
  else
    ctx_total_fmt="${ctx_total}"
  fi
  ctx_display="${used_fmt}% of ${ctx_total_fmt}"
fi

# --- Timestamp ---
timestamp=$(date +%H:%M:%S)

# --- Assemble status line with ANSI colors ---
# Colors (will be dimmed by the terminal):
#   Cyan    = \033[36m
#   Yellow  = \033[33m
#   Green   = \033[32m
#   Magenta = \033[35m
#   Blue    = \033[34m
#   Reset   = \033[0m

parts=""

# Directory
parts="${parts}\033[36m${dir_display}\033[0m"

# Git branch
if [ -n "$git_branch" ]; then
  parts="${parts}  \033[33m${git_branch}\033[0m"
fi

# Model
if [ -n "$model" ]; then
  parts="${parts}  \033[35m${model}\033[0m"
fi

# Context usage
if [ -n "$ctx_display" ]; then
  parts="${parts}  \033[32mctx: ${ctx_display}\033[0m"
fi

# Output token burn counter (last call output tokens as cost proxy)
if [ -n "$output_tokens" ]; then
  if [ "$output_tokens" -ge 1000 ] 2>/dev/null; then
    out_fmt=$(echo "$output_tokens" | awk '{printf "%.1fk", $1/1000}')
  else
    out_fmt="${output_tokens}"
  fi
  parts="${parts}  \033[33mout: ${out_fmt}\033[0m"
fi

# Timestamp
parts="${parts}  \033[34m${timestamp}\033[0m"

printf "%b" "$parts"
