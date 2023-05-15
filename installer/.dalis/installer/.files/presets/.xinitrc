#!/usr/bin/bash
source $HOME/.profile
setxkbmap pt &
exec apply_sys_config &
xwallpaper --zoom ~/.config/wallpaper/wallpaper &
sxhkd -c ~/.config/sxhkd/sxhkdrc &
#setxkbmap -option caps:escape_shifted_caps &
#redshift &
slstatus &
#picom &
mpd &
mpDris &
dunst &
exec startdwm
