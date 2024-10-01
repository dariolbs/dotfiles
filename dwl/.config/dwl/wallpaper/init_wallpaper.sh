#!/bin/bash
wpfile="$HOME/.config/dwl/wallpaper/wallpaper"
[ -L $wpfile ] && { 
    pidof swaybg &> /dev/null && killall swaybg
    swaybg -i $wpfile -m fit
}
