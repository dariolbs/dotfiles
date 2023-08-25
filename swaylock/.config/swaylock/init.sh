#!/usr/bin/bash

swayidle -w \
    timeout 300 'swaylock -i "~/.config/swaylock/images/0301.jpg" -f -c 000000' \
    timeout 600 'hyprctl dispatch dpms off' \
    resume 'hyprctl dispatch dpms on'
