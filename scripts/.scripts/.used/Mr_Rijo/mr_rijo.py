from os import system, environ, popen
import random

HOUR    = popen("date +%H").read().rstrip()
DAY     = popen("date +%a").read().rstrip()

CONFIG_DIR  = f'{environ["HOME"]}/.config/mr_rijo'
CONFIG      = f"{CONFIG_DIR}/config"

ICONS    = [ 
            f'{environ["HOME"]}/.icons/mr_rijo/mr_rijo0.png',
            f'{environ["HOME"]}/.icons/mr_rijo/mr_rijo1.png',
            f'{environ["HOME"]}/.icons/mr_rijo/mr_rijo2.png',
            f'{environ["HOME"]}/.icons/mr_rijo/mr_rijo3.png',
            f'{environ["HOME"]}/.icons/mr_rijo/mr_rijo4.png',
            ]

def notify(message: str) -> None:

    icon = random.choice(ICONS)

    system(f"notify-send -u critical -i {icon} \"Mr Rijo 💪\"" +
            f" \"{message}\" ")

DAYS = {
        "1": "Sun",
        "2": "Mon",
        "3": "Tue",
        "4": "Wed",
        "5": "Thu",
        "6": "Fri",
        "7": "Sat"
        }

file = open(f"{CONFIG}", "r")

for line in file.readlines():

    if line == "\n" or line[0] == "#":
        continue

    splitted = line.rstrip().split()

    if len(splitted[0]) == 1:
        if splitted[0] in DAYS.keys():
            print(HOUR)
            print(DAY)
            print(splitted[0])
            print(splitted[1])
            if HOUR == splitted[1] and DAY == DAYS[splitted[0]]:
                notify("Chegou a hora de ficar rijo!\nSai do computador")

    elif len(splitted[0]) == 3:
        for i in range(int(splitted[0][0]), int(splitted[0][2]) + 1):
            if HOUR == splitted[1] and DAY == DAYS[splitted[0]]:
                notify("Chegou a hora de ficar rijo!\nSai do computador")

    elif splitted[0] == "everyday":
        if HOUR == splitted[1]:
                notify("Chegou a hora de ficar rijo!\nSai do computador!")

    else:
        print(f"Error in line \"{line}\" -> Unrecognized command")
