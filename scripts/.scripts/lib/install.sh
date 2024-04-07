#!/usr/bin/bash

if [ $(id -u) -ne 0 ]; then
    echo "You have to run this as root"
    exit 1
fi

for f in */ ; do
    fol="${f//\/}"
    lib_fol="/usr/lib/$fol/dario"
    # Remove previous libraries
    # if they exist
    if [ -d $lib_fol ]; then
        rm -vrf "$lib_fol"
    fi
    mkdir -p "$lib_fol"
    cp -v $fol/* "$lib_fol"

done
