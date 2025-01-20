#!/usr/bin/env bash

WIREGUARD_RUNNING="$(ls /var/run/wireguard)"

if [ -n "$WIREGUARD_RUNNING" ]; then
  sketchybar --set "$NAME" icon=
else
  sketchybar --set "$NAME" icon=
fi
