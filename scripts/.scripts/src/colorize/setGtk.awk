#!/usr/bin/awk -f

FILENAME ~ /.*\.conf/ { reading_colorschemes = 1; gtk = 0 }

FILENAME ~ /.*\/settings\.ini/ { gtk = 1; reading_colorschemes = 0 }

reading_colorschemes == 1 && reading == 1 && /^$/ { next }

reading_colorschemes == 1 && /gtk-config/ { reading_dunst = 1; next }

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
    print type
    print pallet[type]
    next
}

##-------------------------------------------------------------------------
##                              Waybar Config
##-------------------------------------------------------------------------

/\[Settings\]/ {
        reading_settings = 1
        FS = "="
        print
        next
}

gtk and reading_settings == 1 { sub(/=.*/, "=" pallet[$1]); print; next }

gtk == 1 { print }
