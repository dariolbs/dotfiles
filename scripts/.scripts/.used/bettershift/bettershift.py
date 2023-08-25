#!/usr/bin/python3
import os
from sys import argv

user_id = USER_ID_DEF = "1000"
ICON = f'/home/dario/.icons/anime/AwOo.png'
DATE = os.popen("date +%d-%m-%Y").read().rstrip()

config = CONFIG_DEF = f'{os.environ["HOME"]}/.config/bettershift/config'

def readConfig(config = config) -> dict:
    """
    Reads the configuration file and returns a dictionary with its keys as
    the subvolume to snapshot and its values as a tuple with format
    (<path to snapshot>, <max number of snapshots>)
    """
    file = open(config, "r")
    subv = {}
    for i in file.readlines():
        if not (i == "\n" or i[0] == "#"):
            splitted = i.rstrip().split(" -> ") 
            subv[splitted[0]] = (splitted[1], int(splitted[2]))
    return subv

def createSnapshots(subv) -> None:
    """
    Creates the snapshots and notifies the user
    """
    for i in subv.keys():
        while checkLimit(subv[i][0], subv[i][1]):

            # Remove old snapshots
            os.system(f"btrfs subvolume delete {subv[i][0]}/$(ls -rt {subv[i][0]} | head -1 )")

        # Create a snapshot for each subvolume
        os.system(f"btrfs subvolume snapshot {i} {subv[i][0]}/{DATE}-snapshot")

    # Send a notificatio
    os.system(f"sudo -u $(id -nu {user_id}) DISPLAY=:0 " +\
            f"DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/{user_id}/bus notify-send -i {ICON} " +\
            f"\"BetterShift ⌛\" \"Created Snapshots using {config}\"")

def checkLimit(location, max) -> bool:
    """
    Returns a boolean value representing if the the number of folders in <location>
    is greater than <max>
    """
    snapList = os.popen(f"ls -l {location}").readlines()
    return len(snapList) > max + 1

for i in range(1, len(argv)):
    if argv[i] == "-c":

        config = argv[i+1]
        i += 2

    if argv[i] == "-u":

        user_id = os.popen(f"id -u {argv[i+1]}").read().rstrip()
        i += 2

    elif argv[i] == "create":

        subv = readConfig(config)
        createSnapshots(subv)
        exit(0)

    elif argv[i] == "example":

        print("#Example Bettershift configuration:\n\n" +\
        "#Create a snapshot of the root subvolume on /etc/snapshots with a maximum of 5 snapshots\n" +\
        "/ -> /etc/snapshots -> 5\n")

    else:
        print(f"Unknown argumernt {argv[i]}")
        i += 1
