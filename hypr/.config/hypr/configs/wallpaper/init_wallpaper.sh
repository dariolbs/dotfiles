#!/usr/bin/bash
# Initializes the wallpaper for Hyprland

options=(
    "--transition-type wipe"
    "--transition-angle 30"
    "--transition-step 10"
)

command="swww img"
fallback_wp="$HOME/.config/hypr/configs/wallpaper/wallpaper_default.jpg"
default_wp="$HOME/.config/hypr/configs/wallpaper/wallpaper"

# Check if there is $default_wp exists as a symlink
if [ -h "$default_wp" ]; then
    eval "$command $default_wp"
else
    eval "$command $fallback_wp"
fi
