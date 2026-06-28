#!/usr/bin/env bash

source "$CONFIG_DIR/colors.sh"

if [ "$1" = "$FOCUSED" ]; then
  sketchybar --set $NAME \
    label.color=$CYAN \
    background.drawing=off
else
  sketchybar --set $NAME \
    label.color=$LABEL_DIM \
    background.drawing=off
fi
