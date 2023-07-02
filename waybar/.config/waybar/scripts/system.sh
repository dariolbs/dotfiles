#!/usr/bin/bash
old_ifs="$IFS"
IFS=":"
font="JetBrainsMono:size=15"
options="󰖌 Exit Hyprland: Lock: Reboot: Poweroff"
pkill wofi ||
    case $(for option in ${options[@]}; do printf "$option\n";done | wofi -n -W 20% -H 20% -d ) in
        *"Exit Hyprland") killall hyprctl exit || killall Hyprland;;
        *"Poweroff") poweroff;;
        *"Reboot") reboot;;
        *"Lock") notify-send "nao tens locker";;
    esac

