#! /usr/bin/env bash

is_focused=$(yabai -m query --windows --window | jq -re ".id")
if [[ -z "$is_focused" ]]; then # -z >> true if it's null
    $(yabai -m window --focus $(yabai -m query --windows | jq -re ".[] | select((.visible == 1) and .focused != 1).id" | head -n 1))
fi
