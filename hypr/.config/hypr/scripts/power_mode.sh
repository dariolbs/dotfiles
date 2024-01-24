#!/usr/bin/bash

tofi_options=(
"--width 100%"
"--height 100%"
"--border-width 0"
"--outline-width 0"
"--padding-left 40%"
"--padding-top 20%"
"--result-spacing 30"
"--num-results 5"
"--font JetBrainsMono"
"--font-size 60"
"--background-color \#000A"
"--selection-color \#7daea3"
)

tofi="$HOME/.config/hypr/scripts/tofi/tofi.sh"

IFS=":"

swaylock="$HOME/.config/hypr/configs/swaylock/init.sh"

options=(
    "󰐥 Poweroff:"
    "󰦛 Restart:"
    " Lock"
)

option=$(for o in ${options[@]}; do printf "$o\n"; done | $tofi ${tofi_options[@]} --prompt-text \"\")

case "$option" in
    *Poweroff) poweroff ;;
    *Restart) reboot ;;
    *Lock) eval "$swaylock";;
end
