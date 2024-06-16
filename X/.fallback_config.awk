BEGIN {
    getatts = 0
    idx = 0
}

function getBestRefreshRate(){
    max = 0
    for (i=2; i <= NF; i++) {
        number = split($i, a, "\\.")
        if (a[1] > max)
            max = a[1]
    }
    return max
    }

$2 == "connected" {
    monitors[idx] = $1
    getatts = 1
    next
    }

getatts == 1 {

    resolutions[idx] = $1
    rates[idx] = getBestRefreshRate()
    idx++
    getatts = 0
    next
}


END {

    print "#!/usr/bin/bash"
    print "# Configure all X11 options here"

    printf "\n"

    print "# Xkbmap options"
    print "keymap_lang=\"pt\""
    print "keymap_options=\"caps:escape\""

    printf "\n"

    print "# Monitor config"

    print "primary=\"" monitors[0] "\""

    # Monitor array
    printf "monitors=("

    for (i=0; i < idx; i++)
        printf " \"" monitors[i] "\" "

    printf ")\n"

    # Resolution array
    printf "resolutions=("

    for (i=0; i < idx; i++)
        printf " \"" resolutions[i] "\" "

    printf ")\n"
        
    # Refresh rate array
    printf "refresh_rates=("

    for (i=0; i < idx; i++)
        printf " \"" rates[i] "\" "

    printf ")\n"

    printf "\n"

    print "# Tablet config"

    print "tablet=false"
    print "# tablet_name=\"HID 256c:006e Pen stylus\""
    print "# tablet_offset=\"1920x1080+1920+0\""
    print "# absolute_area=\"50800\""
    }
