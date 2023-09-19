#!/usr/bin/env bash

PERCENTAGE=$(pmset -g batt | grep -Eo "\d+%" | cut -d% -f1)
CHARGING=$(pmset -g batt | grep 'AC Power')

if [ $PERCENTAGE = "" ]; then
    exit 0
fi

case ${PERCENTAGE} in
[8-9][0-9] | 100)
    if [[ $CHARGING != "" ]]; then
      ICON="󱊦"
    else
      ICON="󱊣"
    fi
    ;;
7[0-9])
    if [[ $CHARGING != "" ]]; then
      ICON="󱊥"
    else
      ICON="󱊢"
    fi
    ;;
[4-6][0-9])
    if [[ $CHARGING != "" ]]; then
      ICON="󱊥"
    else
      ICON="󱊢"
    fi
    ;;
[1-3][0-9])
    if [[ $CHARGING != "" ]]; then
      ICON="󱊤"
    else
      ICON="󱊡"
    fi
    ;;
[0-9])
    if [[ $CHARGING != "" ]]; then
      ICON="󰢟"
    else
      ICON="󰂎"
    fi
    ;;
esac

sketchybar --set $NAME icon="$ICON" label="${PERCENTAGE}%"
