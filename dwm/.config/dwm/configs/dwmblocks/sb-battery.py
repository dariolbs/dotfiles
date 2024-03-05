from os import popen, system
import re

names = {
        "^ps-controller": "PS controller",
        "^BAT[0-9]": "Battery"
        }

def optName(string, maxsize) -> str:

    if len(string) > maxsize:
        return string[:maxsize] + "..."
    else:
        return string

def drawBattery(sign, percentage, size) -> str:

    n = int (size / (100/percentage))
    bat = "["
    bat += sign * n
    bat += " " * (size - n)
    bat += "]"

    return bat

for dev in popen("ls /sys/class/power_supply/").readlines():

    p = f"/sys/class/power_supply/{dev.rstrip()}"

    capacity = int(open(f"{p}/capacity", "r").readline().rstrip())
    status = open(f"{p}/status", "r").readline().rstrip()

    print(f'{optName(dev, 10)} {drawBattery("*", capacity, 20)} {capacity}% {status}')
