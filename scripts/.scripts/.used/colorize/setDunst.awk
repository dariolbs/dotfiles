#!/usr/bin/awk -f

FILENAME ~ /.*\.conf/ { reading_colorschemes = 1; dunst = 0 }

FILENAME ~ /.*\/dunst\/dunstrc/ { dunst = 1; reading_colorschemes = 0 }

reading_colorschemes == 1 && reading == 1 && /^$/ { next }

reading_colorschemes == 1 && /dunst-config/ { reading_dunst = 1; next }

reading_colorschemes == 1 && /.*-config/ { reading_dunst = 0; next }

reading_colorschemes == 1 && $0 ~ /END/ && reading == 1 {
    reading = 0
    next
}

reading_colorschemes == 1 && $0 == "COLORSCHEME " colorscheme {
    reading = 1
    next
}

reading_dunst == 1 && reading_colorschemes == 1 && reading == 1 {
    type = substr($1, 1, length($1)-1)
    pallet[type] = substr($0, length($1) + 10)
    next
}

##-------------------------------------------------------------------------
##                              Waybar Config
##-------------------------------------------------------------------------

dunst == 1 && /^\[urgency_normal\]/ {
    writing = 1
    print
    next
}

dunst == 1 && /^\[urgency_critical\]/ {
    writing = 0
    print
    next
}

writing == 1 && dunst == 1 {
    sub($3, "\"" pallet[$1] "\"")
    print
    next
}

dunst == 1 { print }
