#!/usr/bin/env bash

# This requires running: sudo ipconfig setverbose 1
SSID="$(ipconfig getsummary en0 | awk -F' : ' '/ SSID/ { print $2 }')"

if [ "$SSID" = "" ]; then
  sketchybar --set "$NAME" label="Disconnected" icon=󰖪
else
  sketchybar --set "$NAME" label="$SSID" icon=󰖩
fi
