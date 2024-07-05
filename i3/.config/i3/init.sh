#!/usr/bin/bash

# Environment variables
export GTK_THEME="Adwaita-dark"
export DESKTOP_TYPE="i3"
export XDG_CONFIG_HOME="$HOME/.config"

# For mimeapps
export XDG_CURRENT_DESKTOP="i3"

# Start Services
dunst -config "$HOME/.config/i3/configs/dunst/dunstrc" &
sxhkd -c "$HOME/.config/i3/configs/sxhkd/sxhkdrc" &
# picom --config "$HOME/.config/i3/configs/picom/picom.conf" &
nm-applet &
[ ! -s "$HOME/.config/mpd/pid" ] && mpd &
xrdb -load ~/.config/i3/configs/Xresources

logs_dir="$HOME/.logs"
awk_fallback_script="$HOME/.config/i3/scripts/fallback_config.awk"
xconfig="$HOME/.xconfig"
xhash="$HOME/.config/i3/configs/xorg/.xrandr.md5"
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
eval "$HOME/.config/i3/configs/wallpaper/init_wallpaper.sh"

# Redshift
eval "$HOME/.config/i3/configs/redshift/init.sh" &

if [ ! -f "$HOME/.i3rc" ]; then
    $HOME/.config/i3/scripts/gen_local_i3config.sh > "$HOME/.i3rc" 
    sleep 0.5
fi

exec i3 -c "$HOME/.i3rc" 2>> $logs_dir/i3.log
