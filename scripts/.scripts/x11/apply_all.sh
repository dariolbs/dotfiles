#!/usr/bin/bash

source "$HOME/.x11.conf"

source "$HOME/.scripts/x11/apply_bk_options.sh"
source "$HOME/.scripts/x11/apply_tablet_config.sh"
source "$HOME/.scripts/x11/apply_monitor_config.sh"

xwallpaper --focus "$wallpaper"
