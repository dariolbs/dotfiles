#!/usr/bin/awk -f

FILENAME ~ /.*\.conf/ { reading_colorschemes = 1; hyprland = 0 }

FILENAME ~ /.*\/hyprland\.conf/ { hyprland = 1; reading_colorschemes = 0; FS = " "}

reading_colorschemes == 1 && reading == 1 && /^$/ { next }

reading_colorschemes == 1 && /hyprland-config/ { reading_hyprland = 1; next }

reading_colorschemes == 1 && /.*-config/ { reading_hyprland = 0; next }

reading_colorschemes == 1 && $0 ~ /END/ && reading == 1 {
    reading = 0
    next
}

reading_hyprland && reading_colorschemes == 1 && reading == 1 {
    type = substr($1, 1, length($1)-1)
    pallet[type] = substr($0, length($1) + 10)
    next
}

reading_colorschemes == 1 && $0 == "COLORSCHEME " colorscheme {
    reading = 1
    next
}

##-------------------------------------------------------------------------
##                              Hyprland Config
##-------------------------------------------------------------------------

hyprland == 1 && /col\.active_border/ {
    sub(/=.*/, "= " pallet["active_border"])
    print
    next
}

hyprland == 1 && /col\.inactive_border/ {
    sub(/=.*/, "= " pallet["inactive_border"])
    print
    next
}

hyprland == 1 { print }
