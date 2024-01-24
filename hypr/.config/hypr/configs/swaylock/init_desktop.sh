#!/usr/bin/bash

swayidle -w \
    timeout 1000 'swaylock -i "~/.config/hypr/configs/wallpaper/wallpaper" -f -c 000000 -s fit' \
    timeout 1300 'hyprctl dispatch dpms off' \
    resume 'hyprctl dispatch dpms on'
