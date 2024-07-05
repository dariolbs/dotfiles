#!/usr/bin/bash
# Initializes the wallpaper for I3

command="xwallpaper --focus"
fallback_wp="$HOME/.config/dwm/wallpaper/default_wallpaper.jpg"
default_wp="$HOME/.config/dwm/wallpaper/wallpaper"

# Check if there is $default_wp exists as a symlink
if [ -h "$default_wp" ]; then
    eval "$command $default_wp"
else
    eval "$command $fallback_wp"
fi
