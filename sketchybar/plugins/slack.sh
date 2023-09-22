#!/usr/bin/env bash

STATUS_LABEL=$(lsappinfo info -only StatusLabel "Slack")

if [[ $STATUS_LABEL =~ \"label\"=\"([^\"]*)\" ]]; then
  LABEL="${BASH_REMATCH[1]}"
  ICON="󰒱"
else
  exit 0
fi

sketchybar --set $NAME icon=$ICON label="${LABEL}"
