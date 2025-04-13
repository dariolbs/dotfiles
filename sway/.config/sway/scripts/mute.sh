#!/usr/bin/sh -eu
pactl set-sink-mute \@DEFAULT_SINK@ toggle
kill -44 $(pidof i3blocks)
