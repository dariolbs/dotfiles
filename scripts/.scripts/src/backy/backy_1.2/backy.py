#!/usr/bin/python3

from os import system
from os import environ
from sys import argv
from tcolors import tcolors

global icon
global user_id

VERSION = "1.1"

CONFIG_DIR = f'{environ["HOME"]}/.config/backy'
ICON_ERROR_DEF = f'{environ["HOME"]}/.icons/anime/aquacry.png'
LOG_FILE = f"{CONFIG_DIR}/.logs"
DEFAULT_FLAGS = "-uvrP --delete"

config = CONFIG_DEF = f"{CONFIG_DIR}/config"
icon = ICON_DEF = f'{environ["HOME"]}/.icons/anime/Ryukosip.png'

do_update = list_config = verbose = notify = notify_error = False

# Create config and cache directories if they still don't exist
system(f"mkdir -p {CONFIG_DIR}")

def help():
    print(
            "Backy - Create a stable backup configuration!\n" +\
            "Options:\n" +\
            "backy --help                               #Display this page\n" +\
            "backy --config <configuration file>        #Selects a backup configuration to use (~/.config/backy/config by default)\n" +\
            "backy -n                                   #Display a notification when finishing backup, \n" +\
            "backy -v                                   #backup, \n" +\
            "backy -i <icon_path>                       #Select an icon to display with the notification\n\n" +\

            f"This is Backy version {tcolors.UNDERLINE}{VERSION}{tcolors.ENDC}"
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

        if len(separated) > 2:
            paths[separated[0]] = (separated[1].rstrip(), separated[2].rstrip())
        else:
            paths[separated[0]] = (separated[1].rstrip(), DEFAULT_FLAGS)

    return paths

def copyAll(paths, verbose = False, notify = False, config = CONFIG_DEF) -> None:
    """
    Uma função mal feita que não devia existeir. Não retorna nada.
    """

    error = False
    n_backups = 0

    for path in paths.keys():

        command = system(f"rsync {paths[path][1]} {path} {paths[path][0]} 2>> {LOG_FILE} 1>> /dev/null")

        if command != 0:
            error = True

        if verbose:

            # If the command returns success
            if command == 0:
                print(f"{path} {tcolors.GREEN}==>{tcolors.ENDC} {paths[path][0]} {tcolors.YELLOW}flags:{tcolors.ENDC} {paths[path][1]} returned {tcolors.GREEN}{command}{tcolors.ENDC}")

            # If the command doesn't
            else:
                print(f"{path} {tcolors.GREEN}==>{tcolors.ENDC} {paths[path][0]} {tcolors.YELLOW}flags:{tcolors.ENDC} {paths[path][1]} returned {tcolors.RED}{command}{tcolors.ENDC}")

        n_backups += 1

    if notify:
        if not error:
            system(f"notify-send -i {icon} \"Backy 🎒\" \"Completed backup using {config}\"")

        elif notify_error:
            system(f"notify-send -u critical -i {ICON_ERROR_DEF} \"Backy 🎒\" \"Errors occured using {config}!\nCheck the logs!\"")

    return

# In case no arguments are specified, print the help screen

if len(argv) < 2:

    help()
    exit(0)

# Read arguments
n = 0
for a in argv:

    # If arg is a full option
    if a[0:2] == "--":

        option = a[2:]

        # Specify config file
        if option == "config":

            try:
                config = argv[n+1]

            except IndexError:
                print("\"--config\" option requires 1 argument")
                exit(1)


        # In case no option is reconized
        else:
            print(f"Option {option} not reconized")
            exit(1)

    # If arg is a char option
    elif a[0] == "-":

        for char in a[1:]:

            # Verbose output
            if char == "v":
                verbose = True

            # Display notification
            elif char == "n":
                notify = True

            # Display notification
            elif char == "e":
                notify_error = True

            # Select an icon
            elif char == "i":
                icon = argv[n + 1]

            else:
                print(f"Option {char} not reconized")
                exit(1)

    # Increment argv index
    n = n + 1

# Get all paths
paths = readConfig(config, verbose)

# Run the update
copyAll(paths, verbose, notify, config)

# Finish
exit(0)
