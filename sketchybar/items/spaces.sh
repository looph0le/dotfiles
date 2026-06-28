#!/usr/bin/env bash

source "$CONFIG_DIR/icons.sh"

for sid in $(aerospace list-workspaces --all 2>/dev/null); do
  case $sid in
    1)  icon=$ICON_WORK_1 ;;
    2)  icon=$ICON_WORK_2 ;;
    3)  icon=$ICON_WORK_3 ;;
    4)  icon=$ICON_WORK_4 ;;
    5)  icon=$ICON_WORK_5 ;;
    6)  icon=$ICON_WORK_6 ;;
    7)  icon=$ICON_WORK_7 ;;
    8)  icon=$ICON_WORK_8 ;;
    9)  icon=$ICON_WORK_9 ;;
    10) icon=$ICON_WORK_10 ;;
    *)  icon=$sid ;;
  esac

  sketchybar --add item space.$sid left \
    --subscribe space.$sid aerospace_workspace_change \
    --set space.$sid \
      background.drawing=off \
      label="$icon" \
      label.padding_left=4 \
      label.padding_right=4 \
      label.font="JetBrainsMono Nerd Font:Bold:16" \
      click_script="aerospace workspace $sid" \
      script="$PLUGIN_DIR/aerospace.sh $sid"
done
