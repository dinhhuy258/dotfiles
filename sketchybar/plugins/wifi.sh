#!/usr/bin/env bash

CURRENT_WIFI="$(/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport -I)"
SSID="$(echo "$CURRENT_WIFI" | grep -o "SSID: .*" | sed 's/^SSID: //')"

if [ "$SSID" = "" ]; then
  sketchybar --set $NAME label="Disconnected" icon=󰖪
else
  sketchybar --set $NAME label="$SSID" icon=󰖩
fi
