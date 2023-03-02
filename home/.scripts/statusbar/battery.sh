#!/bin/sh
 [ $(cat /sys/class/power_supply/BAT?/status) = "Charging" ] ||
	[ $(cat /sys/class/power_supply/BAT?/status) = "Full" ] &&
	printf " %s%%" $(cat /sys/class/power_supply/BAT?/capacity) ||
	printf "󰁹 %s%%" $(cat /sys/class/power_supply/BAT?/capacity)
