#!/bin/sh

# Close stdin
exec <&-

# Default startup programs
dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=dwl
dunst -config "$HOME/.config/dwl/configs/dunstrc" &

# Per-device script
local_script="$HOME/.dwl_local.sh"

[ -x "$local_script" ] && eval "$local_script $PPID"  # Run local config if it exists

# Generate config if it doesnt exist
if [ ! -f "$local_script" ]; then

touch $local_script 
chmod 755 $local_script
cat << EOF > $local_script
# EXAMPLES
#
# MUSIC PLAYER DAEMON
# [ ! -s "\$HOME/.config/mpd/pid" ] && mpd &
#
# XDG DESKTOP PORTAL FOR SCREENSHARING
# /usr/lib/xdg-desktop-portal-wlr -r &
# /usr/lib/xdg-desktop-portal-gtk --config "\$HOME/.config/dwl/configs/xdg-desktop-portal-wlr.ini" -r &
# /usr/lib/xdg-desktop-portal -r &
#
# WALLPAPER
# eval "\$HOME/.config/dwl/wallpaper/init_wallpaper.sh" &
#
# MONITOR CONFIGURATION
# wlr-randr\
#   --output DP-1\
#   --mode 1920x1080@165.003006Hz\
#   --pos 1920,0\
#   --scale 1\
#   --adaptive-sync enabled\
#   --output HDMI-A-1\
#   --mode 1920x1080@60.000000Hz\
#   --pos 0,0\
#   --scale 1\
#   --adaptive-sync disabled
#
# BAR SCRIPT
# getvol()
# {
#     vol="\$(wpctl get-volume @DEFAULT_AUDIO_SINK@)"
#     [ "\$vol" != "\${vol%\[MUTED\]}" ] && printf " muted" && exit
#     vol="\${vol#Volume: }"
#     split() {
#         # For ommiting the . without calling and external program.
#         IFS=\$2
#         set -- \$1
#         printf '%s' "\$@"
#     }
#     vol="\$(printf "%.0f" "\$(split "\$vol" ".")")"
#     echo \$vol
# }
# 
# barscript()
# {
#     while true; do
#         printf "vol: %s%% | cpu: %s | mem: %s | %s"\
#             "\$(getvol)"\
#             "\$(awk '{print \$1, \$2, \$3}' < /proc/loadavg)"\
#             "\$(free -h | awk '/^Mem/ { print \$3"/"\$2 }' | sed s/i//g)"\
#             "\$(date '+%b %d (%a) %H:%M')"
#             sleep 10
#         done
# }
# 
# barscript > /proc/\$dwlpid/fd/0
EOF
fi
