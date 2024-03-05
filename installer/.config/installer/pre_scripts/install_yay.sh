#!/usr/bin/bash

mkdir -p ~/.gitclones/
cd ~/.gitclones
pacman -S --needed git base-devel
git clone https://aur.archlinux.org/yay-bin.git
cd yay-bin
makepkg -si
