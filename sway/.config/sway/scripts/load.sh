#!/usr/bin/sh -eu
set -eu
load="$(cut -f 1 -d " " < /proc/loadavg)"
printf "%s\n%s\n" "$load" "$load"
