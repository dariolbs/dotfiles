#!/usr/bin/python3

from os import system
from os import environ
from stats import increment, getStats
from sys import argv
from tcolors import tcolors

global icon
global user_id

STATS_FILE = f'{environ["HOME"]}/.local/share/backy/stats'
CONFIG_DIR = f'{environ["HOME"]}/.config/backy'
STATS_DIR = f'{environ["HOME"]}/.local/share/backy'
config = CONFIG_DEF = f"{CONFIG_DIR}/config"
icon = ICON_DEF = f'{environ["HOME"]}/.icons/anime/Ryukosip.png'
ICON_ERROR_DEF = f'{environ["HOME"]}/.icons/anime/aquacry.png'
LOG_FILE = f"{CONFIG_DIR}/.logs"

add = ( None, None )

do_update = list_config = verbose = notify = False

# Create config and cache directories if they still don't exist
system(f"mkdir -p {CONFIG_DIR}")
system(f"mkdir -p {STATS_DIR}")

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
    if system(f"[ -f {config} ]") != 0:
        print(f"Configuration file {config} does not exist")
        exit(1)

    file = open(f"{config}", "r")
    if verbose:
        print(f"Reading {config}...\n")

    paths = {}

    for line in file.readlines():
        if line[0] == "#" or line == "\n":
            continue
        separated = line.split(" ==> ")
        paths[separated[0]] = separated[1].rstrip()

    return paths

def copyAll(paths, verbose = False, notify = False, config = CONFIG_DEF) -> None:
    error = False
    n_backups = 0
    for path in paths.keys():
        if system(f"rsync -uvrP --delete {path} {paths[path]} 2>> {LOG_FILE}") != 0:
            error = True

        if verbose:
            print(f"{path} {tcolors.GREEN}==>{tcolors.ENDC} {paths[path]}")

        n_backups += 1

    if notify:
        if not error:
            system(f"notify-send -i {icon} \"Backy 🎒\" \"Completed backup using {config}\"")

        else:
            system(f"notify-send -u critical -i {ICON_ERROR_DEF} \"Backy 🎒\" \"Errors occured using {config}!\nCheck the logs!\"")

    increment(config, 1, n_backups)

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

    elif argv[i] == "-i":
        icon = argv[i + 1]
        i += 1

    elif argv[i] == "update":
        paths = readConfig(config, verbose)
        copyAll(paths, verbose, notify, config)
        exit(0)

    elif argv[i] == "ls":
        paths = readConfig(config, verbose)
        print(f"All paths configured in {tcolors.UNDERLINE}{config}{tcolors.ENDC}")
        for i in paths.keys():
            print(f"{i} {tcolors.BOLD}{tcolors.BLUE}==> {tcolors.ENDC}" +
                  f"{tcolors.BOLD}{paths[i]}{tcolors.ENDC}")
        exit(0)

    elif argv[i] == "stats":
        stats = getStats()
        for i in stats.keys():
            print(
                    f"Configuration file {i}\n" + 
                    f"Ran {stats[i][0]} times\n" +
                    f"{stats[i][1]} backups completed\n"
                )
        exit(0)

    else:
        help()
        exit(0)
