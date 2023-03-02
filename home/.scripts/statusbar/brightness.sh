#!/bin/sh
device=$(ls /sys/class/backlight)
current=$(cat /sys/class/backlight/$device/brightness)
max=$(cat /sys/class/backlight/$device/max_brightness)
case $1 in
	+)
		next=$(($current+$3))
		[ $next -gt 10 ] && [ $next -lt $max ] && echo $next > /sys/class/backlight/$device/brightness
		;;
	-)
		next=$(($current-$3))
		[ $next -gt 10 ] && [ $next -lt $max ] && echo $next > /sys/class/backlight/$device/brightness
		;;
	check)
		echo $current
		;;
esac
