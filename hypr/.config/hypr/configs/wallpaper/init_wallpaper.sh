#!/usr/bin/bash
# Initializes the wallpaper for Hyprland

fallback_wp="$HOME/.config/hypr/configs/wallpaper/wallpaper_default.jpg"
default_wp="$HOME/.config/hypr/configs/wallpaper/wallpaper"

# Check if there is $default_wp exists as a symlink
if [ ! -h "$default_wp" ]; then
    ln -sf $fallback_wp $default_wp
fi

pid="$(pidof swaybg)" && kill $pid

swaybg -i $default_wp & disown
