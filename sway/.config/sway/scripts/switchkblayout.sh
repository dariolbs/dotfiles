#!/usr/bin/sh
swaymsg input "type:keyboard" xkb_switch_layout next; kill -46 $(pidof i3blocks)
kill -46 $(pidof i3blocks)
