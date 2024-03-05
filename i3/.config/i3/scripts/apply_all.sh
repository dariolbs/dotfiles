#!/usr/bin/bash

source "$HOME/.config/i3/configs/xorg/xconfig"
exec "$HOME/.config/i3/scripts/apply_bk_options.sh"
exec "$HOME/.config/i3/scripts/apply_tablet_config.sh"
exec "$HOME/.config/i3/scripts/apply_monitor_config.sh"
