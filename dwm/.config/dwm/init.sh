#!/usr/bin/bash
# Shell script that starts dwm
# This is the real deal

# Environment variables
export GTK_THEME="Adwaita-dark"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CURRENT_DESKTOP="dwm"

# Start Services
dunst -config "$HOME/.config/dwm/dunstrc" &
sxhkd -c "$HOME/.config/dwm/sxhkd/sxhkdrc" &
nm-applet &
xrdb -load "$HOME/.config/dwm/Xresources"
dwmblocks &
[ ! -s "$HOME/.config/mpd/pid" ] && mpd &

# Source variables
[ -f "$HOME/.profile" ] && source "$HOME/.profile"

# Apply xconfig
eval "$HOME/.Xapply"

# Wallpaper
eval "$HOME/.config/dwm/wallpaper/init_wallpaper.sh"

# Redshift
eval "$HOME/.config/dwm/configs/redshift.sh" &

exec dwm 2>> "$HOME/.dwm.log"
