#!/usr/bin/bash

# Environment variables
export GTK_THEME="Adwaita-dark"
export DESKTOP_TYPE="i3"

# Start Services
dunst -config "$HOME/.config/i3/configs/dunst/dunstrc" &
sxhkd -c "$HOME/.config/i3/configs/sxhkd/sxhkdrc" &
# picom --config "$HOME/.config/i3/configs/picom/picom.conf" &
nm-applet &
mpd &
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

setxkbmap "$keymap_lang"

for option in ${keymap_options}; do
    setxkbmap -option "$option"
done

# monitor config
i=0
n=1
command="xrandr"
for mon in ${monitors[@]}; do
    [ "${mon}" = "${primary}" ] && p="--primary "
    [ "${monitors[$n]}" != "" ] && l=" --left-of ${monitors[$n]}"
    command+=" --output ${mon} ${p}--mode ${resolutions[$i]} --rate ${refresh_rates[$i]} ${l[@]}"
    i=$((i+1)); n=$((n+1)); p=""; l="";
done

eval "$command"

# tablet config
if $tablet; then

    # Fallback
    if [ "$tablet_name" = "" ]; then
        tablet="$(xsetwacom list devices | grep stylus)"
        tablet="${tablet%%stylus*}stylus"
    fi

    if [ "$absolute_area" = "" ]; then
        absolute_area="$(xsetwacom get "$tablet" Area | cut -f 3 -d " ")"
    fi

    if [ "$tablet_offset" = "" ]; then
        tablet_offset="1920x1080+0+0"
    fi

    precision=1000000
    def_area=$(($absolute_area*(1080*$precision/1920)))
    def_area=$(($def_area / $precision ))

    # Mapear para o monitor principal
    xsetwacom set "$tablet" MapToOutput "$tablet_offset"

    # Introduzir a area correta
    xsetwacom set "$tablet" Area 0 0 $absolute_area $def_area

fi

# Wallpaper
eval "$HOME/.config/i3/configs/wallpaper/init_wallpaper.sh"

# Redshift
eval "$HOME/.config/i3/configs/redshift/init.sh" &

if [ ! -f "$HOME/.i3rc" ]; then
    $HOME/.config/i3/scripts/gen_local_i3config.sh > "$HOME/.i3rc" 
fi

exec i3 -c "$HOME/.i3rc" 2>> $logs_dir/i3.log
