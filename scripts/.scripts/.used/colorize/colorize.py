#!/usr/bin/env python3
import os
from sys import argv

CONF_DIR = f'{os.environ["HOME"]}/.config/colorschemes/colorschemes.conf'
AWK_DIR = f'{os.environ["HOME"]}/.scripts/.used/colorize'

# Dictionary with its keys as the awk script relative to its configuration file
AWK_SCRIPTS = {
        "setFoot.awk": (f'{os.environ["HOME"]}/.config/foot/foot.ini', "foot.ini"),
        "setHyprland.awk": (f'{os.environ["HOME"]}/.config/hypr/hyprland.conf', "hyprland.conf"),
        "setWaybar.awk": (f'{os.environ["HOME"]}/.config/waybar/style.css', "style.css"),
        }

def getColorschemes() -> list:
    file = open(CONF_DIR, "r")
    lst = []
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

def main(colorscheme):
    """
    Main function
    """
    prepare()
    if checkColorscheme(colorscheme):
        for script in AWK_SCRIPTS.keys():
            os.system(f'awk -f {AWK_DIR}/{script} -v colorscheme={colorscheme} {CONF_DIR}\
 {AWK_SCRIPTS[script][0]} > /tmp/Colorize/{AWK_SCRIPTS[script][1]}')
    else:
        print(f"\"{colorscheme}\" is not in the list.\nAvaliable schemes:\n")
        for i in getColorschemes():
            print(i)
        exit(1)

main(argv[1])
