#!/usr/bin/sh

tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
export EDITOR=nvim
yazi "$@" --cwd-file="$tmp"
if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
    cd -- "$cwd"
fi
rm -f -- "$tmp"
zsh
