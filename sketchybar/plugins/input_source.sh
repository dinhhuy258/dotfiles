#!/usr/bin/env bash

INPUT_SOURCE=$(defaults read ~/Library/Preferences/com.apple.HIToolbox.plist AppleSelectedInputSources | grep 'KeyboardLayout Name' | sed -E 's/^.+ = \"?([^\"]+)\"?;$/\1/')
if [ $INPUT_SOURCE = "ABC" ]; then
  ICON="󰬌"
else
  ICON="󰬝"
fi

sketchybar --set $NAME icon="$ICON"

