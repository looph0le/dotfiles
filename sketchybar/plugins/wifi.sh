#!/usr/bin/env bash

source "$CONFIG_DIR/colors.sh"
source "$CONFIG_DIR/icons.sh"

WIFI_INTERFACE=$(networksetup -listallhardwareports | \
  awk '/AirPort|Wi-Fi/{getline; print $NF}')

if [[ -z "$WIFI_INTERFACE" ]]; then
  sketchybar --set $NAME icon=$ICON_WIFI_OFF icon.color=$RED label.drawing=off
  exit 0
fi

POWER=$(networksetup -getairportpower "$WIFI_INTERFACE" | awk '{print $NF}')
SSID=$(networksetup -getairportnetwork "$WIFI_INTERFACE" 2>/dev/null | \
  sed -n 's/^Current Wi-Fi Network: //p')

if [[ "$POWER" == "Off" ]] || [[ -z "$SSID" ]]; then
  sketchybar --set $NAME icon=$ICON_WIFI_OFF icon.color=$RED label.drawing=off
else
  sketchybar --set $NAME icon=$ICON_WIFI icon.color=$LAVENDER label="$SSID" label.drawing=on
fi
