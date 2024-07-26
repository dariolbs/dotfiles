#!/usr/bin/bash

[ ! -f "$BOOKMARKS_FILE" ] && exit 1

tofi_opitons=(
"--width 100%"
"--height 100%"
"--border-width 0"
"--outline-width 0"
"--padding-left 35%"
"--padding-top 15%"
"--result-spacing 20"
"--num-results 11"
"--font JetBrainsMonoNerdFont"
"--background-color 000A"
"--selection-color 11ff25"
"--text-color ffffff"
)

bookmark="$(cat $BOOKMARKS_FILE | grep -v "^#" | grep -v "^$" | tofi ${tofi_opitons[@]} --prompt-text "" | cut -f 1 -d " ")"
echo $bookmark | tr -d "\n" | wl-copy
