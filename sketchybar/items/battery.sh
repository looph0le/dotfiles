#!/usr/bin/env bash

sketchybar --add item battery right \
  --subscribe battery system_woke power_source_change \
  --set battery \
    update_freq=120 \
    icon=$ICON_BATTERY \
    icon.color=$PURPLE \
    label.color=$PURPLE \
    background.drawing=on \
    script="$PLUGIN_DIR/battery.sh"
