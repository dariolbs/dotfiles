#!/usr/bin/sh
set -eu
# Get volume
vol="$(wpctl get-volume @DEFAULT_AUDIO_SINK@)"
if [ "$vol" != "${vol%\[MUTED\]}" ]; then
    printf "muted\n"
    printf "muted\n"
    printf "ffff00\n"
fi
vol="${vol#Volume: }"
split() {
	# For ommiting the . without calling and external program.
	IFS=$2
	set -- $1
	printf '%s' "$@"
}
vol="$(printf "%.0f" "$(split "$vol" ".")")"
printf "%s%%\n" "$vol"
printf "%s%%\n" "$vol"
if [ $vol -eq 100 ]; then
    printf "ffff00\n"
fi
