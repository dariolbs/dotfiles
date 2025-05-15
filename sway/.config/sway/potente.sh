#!/usr/bin/bash

if [ -f "$HOME/.profile" ]; then source "$HOME/.profile"; fi

export GTK_THEME="Adwaita-dark"
export XCURSOR_THEME="Adwaita"
export XCURSOR_SIZE=24
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_CURRENT_DESKTOP=sway
export XDG_SESSION_DESKTOP=sway
export XDG_CURRENT_SESSION_TYPE=wayland
export QT_QPA_PLATFORM=wayland
export TERMINAL="foot"
export _JAVA_AWT_WM_NONREPARENTING=1

sway --unsupported-gpu --config "$HOME/.config/sway/configs/sway-potente.conf"
