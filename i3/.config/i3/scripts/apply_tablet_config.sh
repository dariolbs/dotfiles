#!/usr/bin/bash

source "$HOME/.config/i3/configs/xorg/xconfig"

$has_tablet || exit 0

# Fallback
if [ "$tablet" = "" ]; then
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
