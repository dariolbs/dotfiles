#!/usr/bin/bash

config="$HOME/.config/i3/configs/xorg/xconfig"

source "$config"

i=0
n=1

command="xrandr"

for mon in ${monitors[@]}; do

    [ "${mon}" = "${primary}" ] && p="--primary "
    [ "${monitors[n]}" != "" ] && l=" --left-of ${monitors[n]}"

    command+=" --output ${mon} ${p}--mode ${resolutions[i]} --rate ${refresh_rates[i]}${l[@]}"

    i+=1; n+=1; p=""; l="";
done

eval "$command"
