#!/bin/bash

# Read JSON input
input=$(cat)

# Extract values
cwd=$(echo "$input" | jq -r '.workspace.current_dir')
model_name=$(echo "$input" | jq -r '.model.display_name')

# Get token usage
context_size=$(echo "$input" | jq -r '.context_window.context_window_size // 0')
usage=$(echo "$input" | jq '.context_window.current_usage // null')

token_display=""
if [ "$usage" != "null" ] && [ "$context_size" != "0" ]; then
  input_tokens=$(echo "$usage" | jq -r '.input_tokens // 0')
  cache_creation=$(echo "$usage" | jq -r '.cache_creation_input_tokens // 0')
  cache_read=$(echo "$usage" | jq -r '.cache_read_input_tokens // 0')
  current_tokens=$((input_tokens + cache_creation + cache_read))

  # Format as k (thousands)
  if [ "$current_tokens" -ge 1000 ]; then
    current_k=$((current_tokens / 1000))
  else
    current_k=0
  fi

  if [ "$context_size" -ge 1000 ]; then
    context_k=$((context_size / 1000))
  else
    context_k=$context_size
  fi

  token_display=" ${current_k}k/${context_k}k"
fi

# Get session duration
duration_ms=$(echo "$input" | jq -r '.cost.total_duration_ms // 0')
duration_display=""
if [ "$duration_ms" != "0" ] && [ "$duration_ms" != "null" ]; then
  total_seconds=$((duration_ms / 1000))
  hours=$((total_seconds / 3600))
  minutes=$(((total_seconds % 3600) / 60))

  if [ "$hours" -gt 0 ]; then
    duration_display=" ${hours}h${minutes}m"
  elif [ "$minutes" -gt 0 ]; then
    duration_display=" ${minutes}m"
  else
    duration_display=" <1m"
  fi
fi

# Get just the directory name
dir_display=$(basename "$cwd")

# Get git information
cd "$cwd" 2>/dev/null || exit 0

# Git branch
git_branch=$(git --no-optional-locks branch --show-current 2>/dev/null)

if [ -n "$git_branch" ]; then
  printf "[%s%s%s] | %s (%s)" "$model_name" "$token_display" "$duration_display" "$dir_display" "$git_branch"
else
  printf "[%s%s%s] | %s" "$model_name" "$token_display" "$duration_display" "$dir_display"
fi
