#!/usr/bin/bash

setxkbmap pt
setxkbmap -option caps:escape
source $HOME/.profile
exec apply_sys_config &
sxhkd -c ~/.config/sxhkd/sxhkdrc &
exec apply_wallpapers &
picom &
dunst -config ~/.config/dunst/dunstrc.i3 &
mpd &
exec i3

# Old Stuff

# redshift &
# exec startdwm
