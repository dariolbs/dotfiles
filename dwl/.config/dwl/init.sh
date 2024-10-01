#!/usr/bin/bash

export GTK_THEME="Adwaita-dark"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CURRENT_DESKTOP=dwl
export XDG_SESSION_DESKTOP=dwl
export XDG_CURRENT_SESSION_TYPE=wayland
export QT_QPA_PLATFORM=wayland
export TERMINAL="foot"
export _JAVA_AWT_WM_NONREPARENTING=1

dbus-run-session cat | dwl -s "$HOME/.config/dwl/startup.sh"
