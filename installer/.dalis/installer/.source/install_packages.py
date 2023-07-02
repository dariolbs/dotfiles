import os
from sys import argv

def install(pkg_array: list):
    pkg_str = ""
    for i in pkg_array:
        pkg_str += f'{i} '
    os.system(f"yay -S {pkg_str}")

def read_pkg_list(pkg_list: str):
    file = open(pkg_list, "r")
    pkg_array = []

    for line in file.readlines():
        if line[0] != "#":
            pkg_array.append(line.rstrip())
    return pkg_array

pkg_array = read_pkg_list(argv[1])

install(pkg_array)
