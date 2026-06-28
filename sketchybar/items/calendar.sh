#!/usr/bin/env bash

sketchybar --add item calendar right \
  --subscribe calendar system_woke \
  --set calendar \
    icon=$ICON_CALENDAR \
    icon.color=$LAVENDER \
    label.color=$LAVENDER \
    update_freq=10 \
    background.drawing=on \
    script="$PLUGIN_DIR/clock.sh"
