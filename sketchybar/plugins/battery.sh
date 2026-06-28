#!/usr/bin/env bash

source "$CONFIG_DIR/colors.sh"
source "$CONFIG_DIR/icons.sh"

BATT_INFO=$(pmset -g batt 2>/dev/null)
PERCENTAGE=$(echo "$BATT_INFO" | grep -Eo "\d+%" | cut -d% -f1)
CHARGING=$(echo "$BATT_INFO" | grep "AC Power")
STATUS=$(echo "$BATT_INFO" | grep -Eo "'.*?'" | tr -d "'")

if [[ -z "$PERCENTAGE" ]]; then
  sketchybar --set $NAME drawing=off
  exit 0
fi

if [[ -n "$CHARGING" ]]; then
  ICON=$ICON_BATTERY_CHARGING
  COLOR=$MAGENTA
elif [[ "$PERCENTAGE" -ge 75 ]]; then
  ICON=$ICON_BATTERY_100
  COLOR=$PURPLE
elif [[ "$PERCENTAGE" -ge 50 ]]; then
  ICON=$ICON_BATTERY_75
  COLOR=$PURPLE
elif [[ "$PERCENTAGE" -ge 25 ]]; then
  ICON=$ICON_BATTERY_50
  COLOR=$YELLOW
else
  ICON=$ICON_BATTERY_25
  COLOR=$RED
fi

sketchybar --set $NAME icon="$ICON" icon.color="$COLOR" label="${PERCENTAGE}%"
