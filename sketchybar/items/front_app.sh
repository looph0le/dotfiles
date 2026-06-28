#!/usr/bin/env bash

sketchybar --add item front_app left \
  --subscribe front_app front_app_switched \
  --set front_app \
    icon.drawing=off \
    background.drawing=on \
    label.font="SF Mono:Bold:12" \
    label.color=$WHITE \
    script="$PLUGIN_DIR/front_app.sh"
