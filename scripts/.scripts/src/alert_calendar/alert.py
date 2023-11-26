import os

CALCURSE_FILE = f'{os.environ["HOME"]}/.local/share/calcurse/apts'
DATE = os.popen("date +%m/%d/%Y").read().rstrip()
HOUR = os.popen("date +%H:%M:%S").read().rstrip().split(":")

file = open(CALCURSE_FILE, "r")
apts = []

ICON = f'{os.environ["HOME"]}/.icons/pepe/monkaS.png'

def earlierThan(hour):

    splitted = hour.split(":")

    if int(splitted[0]) < int(HOUR[0]):
        return False
    elif int(splitted[1]) < int(HOUR[1]):
        return False
    else:
        return True

for line in file.readlines():
    split = line.split(" ")
    hour_name = ""
    for i in split[6:]:
        hour_name += str(i) + " "
    date = split[0]
    hour = hour_name.split("|")[0]
    name = hour_name.split("|")[1]
    split = line.split(" ")

    apts.append((name.rstrip(), date, hour))

for a in apts:
    name = a[0]
    date = a[1]
    hour = a[2]
    print(a)
    if date == DATE and earlierThan(hour):
        os.system(f"notify-send -i {ICON} \"Lembra-te!\" \"{hour} -> {name}\"")
