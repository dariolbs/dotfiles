#!/usr/bin/bash

source "$HOME/.config/dwm/configs/xorg/xconfig"
exec "$HOME/.config/dwm/scripts/apply_bk_options.sh"
exec "$HOME/.config/dwm/scripts/apply_tablet_config.sh"
exec "$HOME/.config/dwm/scripts/apply_monitor_config.sh"
