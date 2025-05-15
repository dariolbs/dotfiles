#!/usr/bin/sh
tmpdir="$XDG_RUNTIME_DIR/sway-screenshot.tmp"
if [ ! -f $tmpdir ]; then
    touch "$tmpdir"
else
    exit 1
fi
[ ! -d ~/Pictures ] && mkdir -p "$HOME/Pictures"
picture="$HOME/Pictures/$(date +%F_%T).png"
slurp -d | grim -g - "$picture" &&
wl-copy < $picture &&
notify-send -i $picture "Screenshots" "Screenshot taken!"
rm "$tmpdir"
