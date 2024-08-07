#!/usr/bin/bash

[ -d ~/Pictures ] && mkdir -p "$HOME/Pictures"
picture="$HOME/Pictures/$(date +%F_%T).png"
slurp | grim -g - "$picture" &&
wl-copy < "$picture" &&
notify-send -i $picture "Slurp 📷" "Screenshot taken!"
