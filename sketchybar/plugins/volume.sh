#!/usr/bin/env bash

source "$CONFIG_DIR/colors.sh"
source "$CONFIG_DIR/icons.sh"

VOLUME=$(osascript -e "output volume of (get volume settings)")
MUTED=$(osascript -e "output muted of (get volume settings)")

if [[ "$MUTED" == "true" ]]; then
  sketchybar --set $NAME icon=$ICON_VOLUME_MUTED icon.color=$RED label="0%" label.color=$RED
else
  sketchybar --set $NAME icon=$ICON_VOLUME icon.color=$MAGENTA label="${VOLUME}%" label.color=$MAGENTA
fi
