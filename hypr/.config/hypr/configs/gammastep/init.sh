#!/usr/bin/bash

lat="39.10421426592896"
long="-9.281352667975755"
temp_day="6500"
temp_night="4500"

if ! command -v gammastep; then
    # Gammastep is not installed
    notify-send "Hyprland" "gammastep is not installed"
else
    gammastep -l "$lat:$long" -t "$temp_day:$temp_night"
fi
