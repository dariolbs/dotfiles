#!/usr/bin/sh
set -eu
used="$(free -m | awk "/^Mem/ {print \$3}")"
total="$(free -m | awk "/^Mem/ {print \$2}")"
notation="$(free -mh | awk "/^Mem/ {print \$7}")"
percentage=$(( used * 100 / total))
printf "$notation\n"
printf "$notation\n"
if [ $percentage -ge 70 ]; then
    # Red
    printf "#ff0000\n"
elif [ $percentage -ge 50 ]; then
    # Yellow
    printf "#ffff00\n"
fi
