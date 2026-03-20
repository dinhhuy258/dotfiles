#!/bin/bash
input=$(cat)

MODEL=$(echo "$input" | jq -r '.model.display_name')
PCT=$(echo "$input" | jq -r '.context_window.used_percentage // 0' | cut -d. -f1)
COST=$(echo "$input" | jq -r '.cost.total_cost_usd // 0')
DIR=$(echo "$input" | jq -r '.workspace.current_dir')
DIR_NAME="${DIR##*/}"

# TokyoNight colors (24-bit ANSI)
CYAN='\033[38;2;125;207;255m'    # #7dcfff
GREEN='\033[38;2;158;206;106m'   # #9ece6a
YELLOW='\033[38;2;224;175;104m'  # #e0af68
RED='\033[38;2;247;118;142m'     # #f7768e
MAGENTA='\033[38;2;187;154;247m' # #bb9af7
RESET='\033[0m'

# Color based on percentage threshold
pct_color() {
  local pct=$1
  if [ "$pct" -ge 90 ] 2>/dev/null; then echo "$RED"
  elif [ "$pct" -ge 70 ] 2>/dev/null; then echo "$YELLOW"
  else echo "$GREEN"; fi
}

# Build 20-char progress bar for context
BAR_COLOR=$(pct_color "$PCT")
BAR_WIDTH=20
FILLED=$((PCT * BAR_WIDTH / 100))
EMPTY=$((BAR_WIDTH - FILLED))
BAR=""
[ "$FILLED" -gt 0 ] && BAR=$(printf "%${FILLED}s" | tr ' ' '▓')
[ "$EMPTY" -gt 0 ] && BAR="${BAR}$(printf "%${EMPTY}s" | tr ' ' '░')"

COST_FMT=$(printf '$%.4f' "$COST")

# Rate limits
HOURLY_PCT=$(echo "$input" | jq -r 'if .rate_limits.five_hour.used_percentage != null then (.rate_limits.five_hour.used_percentage | ceil) else "" end')
WEEKLY_PCT=$(echo "$input" | jq -r 'if .rate_limits.seven_day.used_percentage != null then (.rate_limits.seven_day.used_percentage | ceil) else "" end')

RATE_DISPLAY=""
[ -n "$HOURLY_PCT" ] && RATE_DISPLAY=" $(pct_color "$HOURLY_PCT")H:${HOURLY_PCT}%${RESET}"
[ -n "$WEEKLY_PCT" ] && RATE_DISPLAY="${RATE_DISPLAY} $(pct_color "$WEEKLY_PCT")W:${WEEKLY_PCT}%${RESET}"

echo -e "${DIR_NAME} ${CYAN}${MODEL}${RESET} ${BAR_COLOR}${BAR}${RESET} ${PCT}% ${MAGENTA}${COST_FMT}${RESET}${RATE_DISPLAY}"
