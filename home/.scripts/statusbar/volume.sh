#!/bin/sh
numb=1
volume=0
case $1 in
	"")
        while [ $volume -eq 0 ] && [ $numb -lt 7 ]; do
            volume=$(pactl list sinks | grep '^[[:space:]]Volume:' | \
                head -n $(( $SINK + $numb )) | tail -n 1 | sed -e 's,.* \([0-9][0-9]*\)%.*,\1,')
            numb=$(($numb + 1))
        done
        printf "$volume\n"
		;;
	*)
		sed -i "s/numb=$numb/numb=$1/" /home/$USER/.scripts/statusbar/volume.sh && exit 0
		;;
esac
