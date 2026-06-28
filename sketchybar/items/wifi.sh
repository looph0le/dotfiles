#!/usr/bin/env bash

sketchybar --add item wifi right \
  --subscribe wifi wifi_change \
  --set wifi \
    icon=$ICON_WIFI \
    icon.color=$LAVENDER \
    label.color=$LAVENDER \
    background.drawing=on \
    script="$PLUGIN_DIR/wifi.sh"
