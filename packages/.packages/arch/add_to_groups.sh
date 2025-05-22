#!/usr/bin/bash

groups=(
    "video"
    "audio"
    "realtime"
    "realtime"
    )

for g in ${groups[@]}; do
    usermod -aG $g $(whoami)
done
