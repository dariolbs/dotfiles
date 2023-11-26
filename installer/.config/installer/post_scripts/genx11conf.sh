#!/usr/bin/bash

cat << EOF >> "$HOME/.x11.conf"
#!/usr/bin/bash

# Xkbmap options
# keymap_lang="pt"
# keymap_options="caps:escape"

# Wallpaper config
# wallpaper="$HOME/.config/wallpaper/wallpaper"

# Monitor config
# primary="DP-0"                            # select primary monitor by name
# monitors=("HDMI-0" "DP-0")                # name of the monitors in an array
# resolutions=("1920x1080" "1920x1080")     # resolution config
# refresh_rates=("60" "165")                # refresh rates
# vmonitors=()

# Tablet config
# tablet="HID 256c:006e Pen stylus"
# tablet_offset="1920x1080+1920+0"
# absolute_area="50800"
EOF
