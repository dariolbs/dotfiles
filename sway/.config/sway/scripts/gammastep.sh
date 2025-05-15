#!/usr/bin/sh
lat="39.10421426592896"
long="-9.281352667975755"
temp_day="6500"
temp_night="3500"
gammastep -l "$lat:$long" -t "$temp_day:$temp_night" &
