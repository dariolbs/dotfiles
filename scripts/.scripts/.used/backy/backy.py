#!/usr/bin/python3

import os
from sys import argv
from tcolors import tcolors

CACHE_DIR = f'{os.environ["HOME"]}/.cache/backy'

CONFIG_DIR = f'{os.environ["HOME"]}/.config/backy'

config = CONFIG_DEF = f"{CONFIG_DIR}/config"

CACHE_FILE = f'{os.environ["HOME"]}/.cache/backy/path'

add = ( None, None )

do_update = list_config = verbose = notify = False

# Create config and cache directories if they still don't exist
os.system(f"mkdir -p {CACHE_DIR}")
os.system(f"mkdir -p {CONFIG_DIR}")

def readConfig(config = CONFIG_DEF, verbose = False) -> dict[str, str]:
    """
    Reads the config file and returns a dictonary with its keys as source paths
    and values as the corresponding destionation path
    """
    file = open(f"{config}", "r")
    if verbose:
        print(f"Reading {config}...\n")

    paths = {}

    for line in file.readlines():
        if line[0] == "#":
            continue
        separated = line.split(" ==> ")
        paths[separated[0]] = separated[1].rstrip()

    return paths

def copyAll(paths, verbose = False, notify = False, config = CONFIG_DEF) -> None:
    for path in paths.keys():
        os.system(f"rsync -uvrP {path} {paths[path]}")
        if verbose:
            print(f"{path} {tcolors.GREEN}==>{tcolors.ENDC} {paths[path]}")
        if notify:
            os.system(f"notify-send \"Backy\" \"Completed backup using {config}\"")
    return

def addPath(source, destination, config = CONFIG_DEF) -> None:
    os.system(f'printf "{source} ==> {destination}\n" >> {config}')

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

    elif argv[i] == "update":
        do_update = True
        i += 1

    elif argv[i] == "ls":
        list_config = True
        i += 1

    elif argv[i] == "add":
        try:
            add = ( argv[i+1] + argv[i+2] )
        except IndexError:
            print("\"add\" requires 2 arguments")
            exit(1)
        i += 3

    else:
        print(f"Uknown option {argv[i]}")
        exit(1)

if do_update:
    paths = readConfig(config, verbose)
    copyAll(paths, verbose, notify, config)

if list_config:
    paths = readConfig(config, verbose)
    for i in paths.keys():
        print(f"{i} ==> {paths[i]}")

if add[0]:
    addPath(add[0], add[1])
    if verbose:
        print(f"Added {add[0]} ==> {add[1]} to {config}\n")
