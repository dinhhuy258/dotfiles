#!/usr/bin/env bash

SSID="$(ipconfig getsummary en0 | awk -F ' SSID : '  '/ SSID : / {print $2}')"

if [ "$SSID" = "" ]; then
  sketchybar --set "$NAME" label="Disconnected" icon=󰖪
else
  sketchybar --set "$NAME" label="$SSID" icon=󰖩
fi
