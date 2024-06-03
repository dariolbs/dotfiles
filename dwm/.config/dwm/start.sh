#!/usr/bin/bash

logs_dir="$HOME/.logs"
awk_fallback_script="$HOME/.config/dwm/scripts/fallback_config.awk"
xconfig="$HOME/.config/dwm/configs/xorg/xconfig"
xhash="$HOME/.config/dwm/configs/xorg/.xrandr.md5"
mons="$(xrandr | awk '$2 == "connected" {print $1}')"

[ ! -d $logs_dir ] && mkdir -p $logs_dir

not_installed() {
    name="$1"
    ! command -v $name && {
        echo [dwm config] $name is not installed! >> $logs_dir/dwm-startup.log
    }
}

# System for messaging the user
create_alert_script() {
touch "$HOME/.alert"
chmod +x "$HOME/.alert"
cat << EOF > "$HOME/.alert"
#!/usr/bin/bash
echo "Config file generated in $xconfig because you either didn't have one, or the monitor configuration changed"
# Remove the alert script so it doesn't show up next time
rm "$HOME/.alert"
EOF
}

# All dependencies
deps=(
    "xrandr"
    "picom"
    "dunst"
    "mpd"
    "sxhkd"
    "nm-applet"
    "dwmblocks"
    "xrdb"
)

# Log every dependency taht isn't installed
for d in ${deps[@]}; do
    not_installed $d
done

# get variables
source "$HOME/.profile"
source "$HOME/.config/dwm/configs/xorg/xconfig"
source "$HOME/.config/dwm/env"

# Load xorg config
eval "$HOME/.config/dwm/scripts/apply_monitor_config.sh"
eval "$HOME/.config/dwm/scripts/apply_tablet_config.sh"

# Generate fallback config
if ! [ -f "$xconfig" ] || ! (echo "${mons[@]}" | md5sum -c "$xhash" &> /dev/null) ; then
    [ -f "$xconfig" ] && rm "$xconfig"
    xrandr | awk -f "$awk_fallback_script" > $xconfig
    echo "Config file generated in $xconfig, change it to your needs!"
    # Create a hash to chech if the monitor config has changed
    echo "${mons[@]}" | md5sum > "$xhash"
    create_alert_script
fi

# Wallpaper
eval "$HOME/.config/dwm/configs/wallpaper/init_wallpaper.sh"

# Redshift
eval "$HOME/.config/dwm/configs/redshift/init.sh" &

# Services
dunst -config "$HOME/.config/dwm/configs/dunst/dunstrc" &
sxhkd -c "$HOME/.config/dwm/configs/sxhkd/sxhkdrc" &
# picom --config "$HOME/.config/dwm/configs/picom/picom.conf" &
nm-applet &
mpd &

# Load the Xresources !!!
xrdb -load ~/.config/dwm/configs/xorg/colorschemes/$COLORSCHEME
dwmblocks &

exec dwm 2>> $logs_dir/dwm.log
