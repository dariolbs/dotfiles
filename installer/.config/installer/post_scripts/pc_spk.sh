#!/usr/bin/bash

if [[ -f /etc/modprobe.d/nobeep.conf ]]; then

    sudo cat << EOF >> /etc/modprobe.d/nobeep.conf
    blacklist pcspkr
    blacklist snd_pcsp
    EOF

fi
