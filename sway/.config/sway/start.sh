#!/usr/bin/bash

config="$HOME/.config/sway/config"
wallpaper="$HOME/.config/sway/configs/wallpaper/"

source ~/.config/sway/env

if [ ! -L $config ]; then
    echo "You have to set a symlink to $config"
    echo "Default configurations are on $HOME/.config/sway/configs"
    exit 1
else if [ ! -L $wallpaper ]; then
    ln -sf "$wallpaper/wallpaper_default.jpg" "$wallpaper/wallpaper"
fi

echo "Starting Sway..."
exec sway
