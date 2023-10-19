if [[ "$(tty)" == "/dev/tty1" ]]; then

        # neofetch
        source "$HOME/.profile"
        printf "Welcome back brother\n"
        printf "Logging in 1 second...\n"

        sleep 1

        exec "$HOME/.config/sway/init/init.sh"
fi
