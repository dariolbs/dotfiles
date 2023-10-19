#!/usr/bin/sh

# Make java GUI applications actually work

NVIDIA_ENV_FILE="$HOME/.config/sway/init/init_nvidia.sh"

# Check if running nvidia

which nvidia-smi

if [ $? -eq 0 ]; then
    NVIDIA=true
else
    NVIDIA=false
fi

if $NVIDIA; then
    echo "Nvidia detected, starting xsession"
    bat ~/.xinitrc
    sleep 1
    startx
    # exec "$NVIDIA_ENV_FILE"
    # echo Starting Sway using nvidia environment variables at $NVIDIA_ENV_FILE...

else

    # Wayland variables

    export _JAVA_AWT_WM_NONREPARENTING=1
    export QT_QPA_PLATFORM=wayland
    export XDG_CURRENT_DESKTOP=sway
    export XDG_SESSION_DESKTOP=sway
    export XDG_CURRENT_SESSION_TYPE=wayland
    export GDK_PACKEND="wayland,x11"

    exec sway
    echo Starting Sway...
    sleep 1
fi
