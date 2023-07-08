import os
from sys import argv

LIST_DIR = "./.package_lists"

def install(pkg_array: list):
    pkg_str = ""
    for i in pkg_array:
        pkg_str += f'{i} '
    os.system(f"yay -S {pkg_str}")

def getAllLists():

    lst = []

    for line in os.popen(f"ls {LIST_DIR}/*").readlines():
        lst.append(str(line[17:].rstrip()))

    return lst

print(getAllLists())

def readPkgList(pkg_list_file: str):
    file = open(pkg_list_file, "r")
    pkg_array = []

    for line in file.readlines():
        if line[0] == "#":
            pass
        elif line[0] == "*":
            filename = line[1:].rstrip()
            if filename in getAllLists():
                for i in readPkgList(f"{LIST_DIR}/{filename}"):
                    pkg_array.append(str(i))
            else:
                print(f"Error in file {pkg_list_file}:\nList {filename} not found\n")
                exit(1)
        else:
            pkg_array.append(str(line.rstrip()))

    return pkg_array

pkg_array = readPkgList(argv[1])

install(pkg_array)
