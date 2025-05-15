#!/usr/bin/bash
# Creates all symlinks for my dotfiles

if ! command -v stow &> /dev/null; then
    echo "Stow is not installed, exiting..."
    exit 1
fi

stow --target=$HOME --verbose */
