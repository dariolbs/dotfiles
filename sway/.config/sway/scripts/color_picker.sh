#!/usr/bin/sh
set -eu
color="$(hyprpicker 2> /dev/null | tail -1 | tr -d '\n')"
wl-copy -- $color
