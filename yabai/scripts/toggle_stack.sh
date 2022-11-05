#! /usr/bin/env bash

current_layout="$(yabai -m query --spaces --space | jq -re .type)"

target_layout="bsp"

[ "${current_layout}" = "bsp" ] && target_layout="stack"

yabai -m space --layout $target_layout
