#!/usr/bin/bash

lat="39.10421426592896"
long="-9.281352667975755"
temp_day="8500"
temp_night="6500"

if ! command -v redshift; then
    # Redshift is not installed
    notify-send "i3" "redshift is not installed"
    exit 1
else
    redshift -l "$lat:$long" -t "$temp_day:$temp_night"
fi
