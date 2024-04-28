#!/usr/bin/bash

config="$HOME/.swayrc"
wallpaperd="$HOME/.config/sway/configs/wallpaper"

source ~/.config/sway/env

if [ ! -L $config ]; then
    echo "You have to set a symlink to $config"
    echo "Default configurations are on $HOME/.config/sway/configs"
    exit 1
fi

if [ ! -L $wallpaperd/wallpaper ]; then
    ln -sf "$wallpaperd/wallpaper_default.jpg" "$wallpaper/wallpaper"
fi

echo "Starting Sway..."
exec sway --config "$config" $sway_args
