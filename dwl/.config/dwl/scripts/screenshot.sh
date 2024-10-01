#!/usr/bin/sh

[ -d ~/Pictures ] && mkdir -p ~/Pictures
picture="$HOME/Pictures/$(date +%F_%T).png"
slurp -o | grim -g - "$picture" &&
wl-copy < $picture &&
notify-send -i $picture "Slurp 📷" "Screenshot taken!"
