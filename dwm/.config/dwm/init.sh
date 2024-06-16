#!/usr/bin/bash
# Shell script that starts dwm
# This is the real deal

# Environment variables
export GTK_THEME="Adwaita-dark"
export DESKTOP_TYPE="ddwm"

# Start Services
dunst -config "$HOME/.config/dwm/configs/dunst/dunstrc" &
sxhkd -c "$HOME/.config/dwm/configs/sxhkd/sxhkdrc" &
# picom --config "$HOME/.config/dwm/configs/picom/picom.conf" &
nm-applet &
mpd &
xrdb -load ~/.Xresources
dwmblocks &

logs_dir="$HOME/.logs"
awk_fallback_script="$HOME/.config/dwm/scripts/fallback_config.awk"
xconfig="$HOME/.Xconfig"
xhash="$HOME/.config/dwm/configs/xorg/.xrandr.md5"
mons="$(xrandr | awk '$2 == "connected" {print $1}')"

# Source variables
[ -f "$HOME/.profile" ] && source "$HOME/.profile"
[ -f "$xconfig" ] && source "$xconfig"
[ ! -d $logs_dir ] && mkdir -p $logs_dir

# Generate fallback config
if ! [ -f "$xconfig" ] || ! (echo "${mons[@]}" | md5sum -c "$xhash" &> /dev/null) ; then
    [ -f "$xconfig" ] && rm "$xconfig"
    xrandr | awk -f "$awk_fallback_script" > $xconfig
    echo "Config file generated in $xconfig, change it to your needs!"
    # Create a hash to chech if the monitor config has changed
    echo "${mons[@]}" | md5sum > "$xhash"
fi

# Apply xconfig
eval "$HOME/.Xapply"

# Wallpaper
eval "$HOME/.config/dwm/configs/wallpaper/init_wallpaper.sh"

# Redshift
eval "$HOME/.config/dwm/configs/redshift/init.sh" &

exec dwm 2>> $logs_dir/dwm.log
