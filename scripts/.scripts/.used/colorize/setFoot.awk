#!/usr/bin/awk -f

FILENAME ~ /.*\/colorschemes\.conf/ { reading_colorschemes = 1 }

reading_colorschemes == 1 && reading == 1 && /^$/ { next }

reading_colorschemes == 1 && /foot-config/ { reading_foot = 1; next }

reading_colorschemes == 1 && /.*-config/ { reading_foot = 0; next }

reading_colorschemes == 1 && $0 ~ /END/ && reading == 1 {
    reading = 0
    next
}

reading_foot == 1 && reading_colorschemes == 1 && reading == 1 {
    type = substr($1, 1, length($1)-1)
    pallet[type] = substr($0, length($1) + 10)
    next
}

reading_colorschemes == 1 && $0 == "COLORSCHEME " colorscheme {
    reading = 1
    next
}

##-------------------------------------------------------------------------
##                              Foot Config
##-------------------------------------------------------------------------

foot == 1 && /\[colors\]/ { reading_colors = 1; FS = "="; print; next }

foot == 1 && reading_colors == 1 && /^(regular|bright|background|foreground)/ {
    sub(/=.*/, "=" substr(pallet[$1], 2))
    print
    next
}

reading_colors == 1 && /^$/ { FS = " "; print; next }

FILENAME ~ /.*\/foot\.ini/ { foot = 1; print }
