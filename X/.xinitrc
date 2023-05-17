#!/usr/bin/bash
setxkbmap pt
setxkbmap -option caps:escape
source $HOME/.profile
exec apply_sys_config &
exec apply_wallpapers &
sxhkd -c ~/.config/sxhkd/sxhkdrc &
redshift &
picom &
mpd &
dwmblocks &
mpDris &
dunst &
exec startdwm
