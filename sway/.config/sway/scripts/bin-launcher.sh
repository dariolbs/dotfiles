#!/bin/sh
find $(echo $PATH | tr ":" " ") -type f -executable -maxdepth 1\
    2> /dev/null | awk '/\[/{next}; {sub(/.*\//, "", $0); print}'\
    | sort | uniq
