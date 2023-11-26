#!/usr/bin/env python3

import os
from sys import argv
from time import sleep

OUT_DIR = "~/.cache/alarm/alarm-state"
ALARM_DIR = "~/.scripts/statusbar/alarm/alarm.mp3"

def secondsTo(endHour, startHour):
    """
    Return the amount of seconds between the two hours in format hh:mm:ss
    """

    curr_seconds = int(startHour[0])
    curr_minutes = int(startHour[1])
    curr_hours = int(startHour[2])

    end_date = endHour.split(":")
    end_seconds = int(end_date[0])
    end_minutes = int(end_date[1])
    end_hours = int(end_date[2])

    return (end_seconds - curr_seconds +\
            end_minutes * 60 - curr_minutes * 60 +\
            end_hours * 3600 - curr_hours * 3600)

def convert(seconds):
    """
    Convert seconds to a better fomat
    """

    minutes = seconds // 60 
    hours = seconds // 3600

    if seconds < 60:
       return (f'{seconds}s')
    elif seconds < 3600:
       return (f'{minutes}m{seconds - minutes * 60}s')
    else:
       return (f'{hours}h{minutes - hours * 60}')

def playAlarm():
    os.system('printf "0s\\n" > ' + OUT_DIR)
    os.system('mpv --no-video ~/.scripts/media/alarm.*')

def main(argv):
    index = seconds = minutes = hours = 0
    end = start = ""

    for i in argv:
        # All possible arguments
        if i == "-s":
            seconds = int(argv[index + 1])
        elif i == "-m":
            minutes = int(argv[index + 1])
        elif i == "-h":
            hours = int(argv[index + 1])
        elif i == "-e":
            end = argv[index + 1]
        elif i == "-s":
            start = argv[index + 1]
        elif i == "clear":
            os.system('printf "0s\\n" > ' + OUT_DIR)
            exit(0)

        index += 1

    if end != "":
        start = os.popen('date | cut -f 4 -d " "').read.split(":")
        totalSeconds = secondsTo(end, start)
    else:
        totalSeconds = (seconds + minutes * 60 + hours * 3600)

    while totalSeconds > 0:
        os.system("printf " + str(convert(totalSeconds)) + " > " + OUT_DIR)
        totalSeconds -= 1
        sleep(1)
    playAlarm()

if len(argv) > 1:
    main(argv)
else:
    os.system(f"cat {OUT_DIR}")
