import os

CALCURSE_FILE = f'{os.environ["HOME"]}/.local/share/calcurse/apts'

DATE = os.popen("date +%d/%m/%Y").read().rstrip()

file = open(CALCURSE_FILE, "r")

apts = {}

for line in file.readlines():
    split = line.split(" ")
    hour_name = ""
    for i in split[6:]:
        hour_name += str(i) + " "
    date = split[0]
    hour = hour_name.split("|")[0]
    name = hour_name.split("|")[1]

    apts[date] = (name.rstrip(), hour)

for date in apts.keys():
    if date == DATE:
        os.system(f"notify-send \"Lembra-te!\" \"{apts[date][0]} -> {apts[date][1]}\"")
