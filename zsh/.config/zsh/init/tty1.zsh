if [[ "$(tty)" == "/dev/tty1" ]]; then
    if [[ ! -f "$TTY1_SCRIPT" ]]; then
        printf "#!/usr/bin/sh\nstartx\n" > "$TTY1_SCRIPT"
        echo "Generated default startup script at $TTY1_SCRIPT"
        echo "Change it to your needs!"
        sleep 1
    fi
    exec "$TTY1_SCRIPT"
fi
