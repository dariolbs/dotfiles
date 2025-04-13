#!/bin/python3
from json import loads
from os import popen
from os import system

def get_current_output():
    json = loads(popen("swaymsg -t get_outputs -r").read())
    for d in json:
        if d["type"] == "output":
            if d["focused"]:
                return d["name"].rstrip()
    return None

if __name__ == "__main__":
    system("[ ! -d ~/Pictures ] && mkdir -p ~/Pictures")
    picture_path = f"~/Pictures/{popen("date +%F_%T").read().rstrip()}.png"
    system(f'grim -o {get_current_output()} {picture_path}')
    system(f'wl-copy < {picture_path}')
    system(f'notify-send -i {picture_path} "Screenshots" "Screenshot taken!"')
