#!/usr/bin/bash

swayidle -w \
    timeout 300 'swaylock -i "~/.config/wallpaper/wallpaper" -f -c 000000 -s fit' \
    timeout 600 'hyprctl dispatch dpms off' \
    resume 'hyprctl dispatch dpms on'
