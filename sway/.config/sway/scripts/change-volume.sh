#!/usr/bin/sh -eu
# Get volume
vol="$(wpctl get-volume @DEFAULT_AUDIO_SINK@)"
[ "$vol" != "${vol%\[MUTED\]}" ] && (printf " "; printf "^fg()^lm()^rm()^us()^ds()"; exit)
vol="${vol#Volume: }"
split() {
	# For ommiting the . without calling and external program.
	IFS=$2
	set -- $1
	printf '%s' "$@"
}
vol="$(printf "%.0f" "$(split "$vol" ".")")"
vol=$((vol $@))
if [ $vol -gt 100 ]; then vol=100; fi
pactl set-sink-volume @DEFAULT_SINK@ $((vol - (vol %  5) ))%
kill -44 $(pidof i3blocks)
