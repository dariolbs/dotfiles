#!/usr/bin/env python3

import os
from tcolors import tcolors
from sys import argv

CONF_DIR = f'{os.environ["HOME"]}/.config/colorschemes'
AWK_DIR = f'{os.environ["HOME"]}/.scripts/.used/colorize'

# Dictionary with its keys as the awk script relative to its configuration file
AWK_SCRIPTS = {
    "setFoot.awk": (f'{os.environ["HOME"]}/.config/foot/foot.ini', "foot.ini"),
    "setHyprland.awk": (f'{os.environ["HOME"]}/.config/hypr/hyprland.conf', "hyprland.conf"),
    "setWaybar.awk": (f'{os.environ["HOME"]}/.config/waybar/style.css', "style.css"),
    "setDunst.awk": (f'{os.environ["HOME"]}/.config/dunst/dunstrc', "dunstrc")
}

def getAllConfs() -> list:
    return os.popen(f"ls ~/.config/colorschemes/*.conf").readlines()

def getColorschemes() -> list:
    lst = []
    for filename in getAllConfs():
        file = open(filename.rstrip(), "r")
        for line in file:
            if "COLORSCHEME" in line:
                lst.append(line[12:].rstrip())
    return lst

def checkColorscheme(colorscheme) -> bool:
    return colorscheme in getColorschemes()

def prepare():
    """
    Create the directiory in /tmp/Colorize if it doesn't exist yet
    """
    os.system('mkdir -p /tmp/Colorize')

def main(colorscheme, debug = False):
    """
    Main function
    """
    prepare()
    if checkColorscheme(colorscheme):
        for script in AWK_SCRIPTS.keys():
            if debug:
                print(f'awk -f {AWK_DIR}/{script} -v colorscheme={colorscheme}\
 {CONF_DIR}/*.conf {AWK_SCRIPTS[script][0]} > /tmp/Colorize/{AWK_SCRIPTS[script][1]}')
            else:
                os.system(f'awk -f {AWK_DIR}/{script} -v colorscheme={colorscheme}\
 {CONF_DIR}/*.conf {AWK_SCRIPTS[script][0]} > /tmp/Colorize/{AWK_SCRIPTS[script][1]}')
                print(f"{tcolors.GREEN}==>{tcolors.ENDC} Generated configuration file for\
 {tcolors.UNDERLINE}{AWK_SCRIPTS[script][1]}{tcolors.ENDC}")
    else:
        print(f"\"{colorscheme}\" is not on the list.\nAvaliable schemes:\n")
        for i in getColorschemes():
            print(i)
        exit(1)

main(argv[1], False)
