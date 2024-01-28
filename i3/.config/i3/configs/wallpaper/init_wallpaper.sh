#!/usr/bin/bash
# Initializes the wallpaper for I3

command="xwallpaper --focus"
fallback_wp="$HOME/.config/i3/configs/wallpaper/wallpaper_default.jpg"
default_wp="$HOME/.config/i3/configs/wallpaper/wallpaper"

# Check if there is $default_wp exists as a symlink
if [ -h "$default_wp" ]; then
    eval "$command $default_wp"
else
    eval "$command $fallback_wp"
fi
