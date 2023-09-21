#!/usr/bin/env bash

VOLUME=$(osascript -e "output volume of (get volume settings)")
IS_MUTED=$(osascript -e "output muted of (get volume settings)")

if [ "$IS_MUTED" = "true" ]; then
    ICON="󰝟"
else
  if [ "$VOLUME" = "0" ]; then
    ICON=""
  elif [ "$VOLUME" -lt "50" ]; then
    ICON=""
  else
    ICON=""
  fi
fi

sketchybar --set $NAME icon="$ICON" label="${VOLUME}%"
