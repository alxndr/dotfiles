#!/bin/bash

# largely written by Claude 🤖

# Input: JSON text via stdin (see Claude Code statusLine documentation)

input=$(cat)

# Nothing to show before the first API response
if [[ -z "${input}" ]]; then
  exit 0
fi

function j() {
  echo "$input" | jq -r "$1 // empty"
}

function jNum() {
  printf "%d" $(j $1)
}
function jPct() {
  printf "%d%%" $(j $1)
}

ANSI_RESET='\033[0m'
ANSI_BRIGHT_RED='\033[1;31m'
ANSI_ORANGE='\033[0;33m'   # standard terminal "yellow" renders as orange
ANSI_YELLOW='\033[1;33m'   # bright yellow
ANSI_DARK_GREEN='\033[0;32m'

function pct_with_color() {
  # Returns a colorful "XX%" string based on thresholds
  local num=$(printf "%d" "$1")
  local color=""
  if [ "$num" -ge 79 ]; then
    color="$ANSI_BRIGHT_RED"
  elif [ "$num" -ge 69 ]; then
    color="$ANSI_ORANGE"
  elif [ "$num" -gt 50 ]; then
    color="$ANSI_YELLOW"
  else
    color="$ANSI_DARK_GREEN"
  fi
  printf "${color}%d%%${ANSI_RESET}" "$num"
}

function format_date() {
  TZ=America/Los_Angeles date -r "$1" '+%-m/%-d %-H:%M'
}

output=$(printf "%s₸ … 5hr %s [%s], 7d %s [%s] … TUI %s, %s " \
  "$(pct_with_color "$(j '.context_window.used_percentage')")" \
  "$(pct_with_color "$(j '.rate_limits.five_hour.used_percentage')")" \
  "$(format_date "$(j '.rate_limits.five_hour.resets_at')")" \
  "$(pct_with_color "$(j '.rate_limits.seven_day.used_percentage')")" \
  "$(format_date "$(j '.rate_limits.seven_day.resets_at')")" \
  "$(j '.version')" \
  "$(j '.model.display_name')" \
)

printf "%b" "$output"
