#!/usr/bin/python3
from json import loads
from os import popen

# Abreviations
names = {}
names["portuguese"] = "pt"
names["english (us)"] = "us"

if __name__ == "__main__":
    json = loads(popen("swaymsg -t get_inputs -r").read())
    for d in json:
        if d["type"] == "keyboard":
            layout = d["xkb_active_layout_name"].lower()
            if layout in names.keys():
                print(names[layout])
            else:
                print(layout)
            exit(0)
    exit(1)
