#!/usr/bin/python3
from sys import argv

def daysin(date) -> int:
    """
    Returns the amount of days from 00/00/0000 to the "date" in format dd/mm/yyyy
    """
    days = int(date.split("/")[0])
    months = int(date.split("/")[1]) - 1
    years = int(date.split("/")[2]) - 1

    total_days = days

    while months > 0:
        if months == 2:
            if years % 4 == 0:
                total_days += 60
                months = 0
            else:
                total_days += 59
                months = 0
        elif months % 2 == 0:
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
