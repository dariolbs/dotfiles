#!/bin/sh

split() {
	# For ommiting the . without calling and external program.
	IFS=$2
	set -- $1
	printf '%s' "$@"
}

vol="$(wpctl get-volume @DEFAULT_AUDIO_SINK@)"
vol="${vol#Volume: }"
vol="$(printf "%.0f" "$(split "$vol" ".")")"
notify-send "vol: ${vol}" -r 100 -t 700 -h int:value:$((vol))

