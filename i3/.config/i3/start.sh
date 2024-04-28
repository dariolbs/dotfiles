#!/usr/bin/bash

if ! command -v xrandr &> /dev/null; then
    echo "Command xrandr was not found"
    exit 1
fi

awk_fallback_script="$HOME/.config/i3/scripts/fallback_config.awk"
xconfig="$HOME/.config/i3/configs/xorg/xconfig"
i3config="$HOME/.i3rc"

if ! [ -L "$i3config" ]; then
    echo "You have to set a symlink to $i3config"
    echo "Default configurations are on $HOME/.config/i3/configs"
    exit 1
fi

if ! [ -f "$xconfig" ]; then
    xrandr | awk -f "$awk_fallback_script" > $xconfig
fi

source "$HOME/.config/i3/configs/xorg/xconfig"
source "$HOME/.config/i3/env/variables"

eval "$HOME/.config/i3/scripts/apply_bk_options.sh"
eval "$HOME/.config/i3/scripts/apply_monitor_config.sh"
eval "$HOME/.config/i3/scripts/apply_tablet_config.sh"

exec i3 -c "$HOME/.i3rc"
