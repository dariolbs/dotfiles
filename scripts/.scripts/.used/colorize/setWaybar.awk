#!/usr/bin/awk -f

FILENAME ~ /.*\.conf/ { reading_colorschemes = 1; waybar = 0 }

FILENAME ~ /.*\/waybar\/style\.css/ { waybar = 1; reading_colorschemes = 0 }

reading_colorschemes == 1 && reading == 1 && /^$/ { next }

reading_colorschemes == 1 && /waybar-config/ { reading_waybar = 1; next }

reading_colorschemes == 1 && /.*-config/ { reading_waybar = 0; next }

reading_colorschemes == 1 && $0 ~ /END/ && reading == 1 {
    reading = 0
    next
}

reading_colorschemes == 1 && $0 == "COLORSCHEME " colorscheme {
    reading = 1
    next
}

reading_waybar == 1 && reading_colorschemes == 1 && reading == 1 {
    type = substr($1, 1, length($1)-1)
    pallet[type] = substr($0, length($1) + 10)
    next
}

##-------------------------------------------------------------------------
##                              Waybar Config
##-------------------------------------------------------------------------

waybar == 1 && /^@define-color/ {
    sub($3, pallet[$2] ";")
    print
    next
}

waybar == 1 { print }
