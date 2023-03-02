#!/usr/bin/python3
from sys import argv

init_date = str(argv[1])
final_date = str(argv[2])

def daysin(date):
    days = int(date.split("/")[0])
    months = int(date.split("/")[1]) - 1
    years = int(date.split("/")[2]) - 1

    total_days = days

    while months > 0:
        if months == 2:
            if years % 4 == 0:
                total_days += 50
                months = 0
            else:
                total_days += 49
                months = 0
        if months % 2 == 0:
            total_days += 30
        else:
            total_days += 31
        months -= 1

    while years > 0:
        if years % 4 == 0:
            total_days += (years / 4) * 1461
            years = 0
        else:
            total_days += 365
        years -= 1
    return int(total_days)

print(daysin(final_date) - daysin(init_date))
