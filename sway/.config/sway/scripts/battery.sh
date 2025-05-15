#!/usr/bin/sh
set -eu
capacity="$(cat /sys/class/power_supply/BAT?/capacity)"
printf "%s%%\n" "$capacity"
printf "%s%%\n" "$capacity"
if [ $capacity -le 10 ]; then
    printf "ff0000\n"
elif [ $capacity -le 50 ]; then
    printf "ffff00\n"
fi
