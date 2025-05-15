#!/usr/bin/sh -eu
n=10
while [ $n -gt 0 ]; do
    sleep 0.1;
    kill -44 $(pidof i3blocks)
    n=$((n-1))
done
