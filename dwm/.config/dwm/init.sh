#!/usr/bin/bash
# Shell script that starts dwm
# This is the real deal

# Environment variables
export GTK_THEME="Adwaita-dark"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CURRENT_DESKTOP="dwm"
export TERMINAL="st"
export PATH="${PATH}:$HOME/.config/dwm/statusbar"

# Source variables
[ -f "$HOME/.profile" ] && source "$HOME/.profile"

# Execute default script
eval "$HOME/.dwm.sh" &

exec dwm 2>> "$HOME/.dwm.log"
