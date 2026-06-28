#!/usr/bin/env bash

sketchybar --add item volume right \
  --subscribe volume volume_change \
  --set volume \
    icon=$ICON_VOLUME \
    icon.color=$MAGENTA \
    label.color=$MAGENTA \
    background.drawing=on \
    script="$PLUGIN_DIR/volume.sh" \
    click_script="$PLUGIN_DIR/volume_click.sh"
