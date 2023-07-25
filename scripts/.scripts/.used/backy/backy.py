#!/usr/bin/python3

import os
from sys import argv
from tcolors import tcolors

global icon
global user_id

CONFIG_DIR = f'{os.environ["HOME"]}/.config/backy'

config = CONFIG_DEF = f"{CONFIG_DIR}/config"

icon = ICON_DEF = f'{os.environ["HOME"]}/.icons/anime/Ryukosip.png'

ICON_ERROR_DEF = f'{os.environ["HOME"]}/.icons/anime/aquacry.png'

LOG_FILE = f"{CONFIG_DIR}/.logs"

add = ( None, None )

do_update = list_config = verbose = notify = False

# Create config and cache directories if they still don't exist
os.system(f"mkdir -p {CONFIG_DIR}")

def help():
    print(
            "Backy - Create a stable backup configuration!\n" +\
            "Options:\n" +\
            "backy -c <configuration file> #Selects a backup configuration to use\n" +\
            "backy -n                      #Display a notification when finishing backup, " +\
            "by default, the configuration file is in ~/.config/backy/config.\n" +\
            "backy update                  #Sync backups\n" +\
            "backy ls                      #Check configuration"
        )

def readConfig(config = CONFIG_DEF, verbose = False) -> dict[str, str]:
    """
    Reads the config file and returns a dictonary with its keys as source paths
    and values as the corresponding destionation path
    """

    # Check if the configuration file exists
    if os.system(f"[ -f {config} ]") != 0:
        print(f"Configuration file {config} does not exist")
        exit(1)

    file = open(f"{config}", "r")
    if verbose:
        print(f"Reading {config}...\n")

    paths = {}

    for line in file.readlines():
        if line[0] == "#" or line == "\n":
            continue
        elif line[0] == "ICON":
            icon = line.split(" = ")[2].rstrip()
        separated = line.split(" ==> ")
        paths[separated[0]] = separated[1].rstrip()

    return paths

def copyAll(paths, verbose = False, notify = False, config = CONFIG_DEF) -> None:
    error = False
    for path in paths.keys():
        if os.system(f"rsync -uvrP --delete {path} {paths[path]} 2>> {LOG_FILE}") != 0:
            error = True

        if verbose:
            print(f"{path} {tcolors.GREEN}==>{tcolors.ENDC} {paths[path]}")

    if notify:
        if not error:
            os.system(f"notify-send -i {icon} \"Backy 🎒\" \"Completed backup using {config}\"")

        else:
            os.system(f"notify-send -u critical -i {ICON_ERROR_DEF} \"Backy 🎒\" \"Errors occured using {config}!\nCheck the logs!\"")

    return

# Read arguments
i = 1
while i < len(argv):
    if argv[i] == "-c":
        try:
            config = argv[i + 1]
        except IndexError:
            print("\"-c\" requires 1 argument")
            exit(1)

        i += 2

    elif argv[i] == "-v":
        verbose = True
        i += 1

    elif argv[i] == "-n":
        notify = True
        i += 1

    elif argv[i] == "update":
        paths = readConfig(config, verbose)
        copyAll(paths, verbose, notify, config)
        exit(0)

    elif argv[i] == "ls":
        paths = readConfig(config, verbose)
        for i in paths.keys():
            print(f"{i} ==> {paths[i]}")
        exit(0)

    else:
        help()
        exit(0)
