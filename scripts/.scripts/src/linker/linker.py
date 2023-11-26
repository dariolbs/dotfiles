from os import system
from sys import argv
import json

def help():
    print("Give a json file to linker!")

def main(args) -> None:

    if len(args) == 1:
        help()

    for arg in args[1:]:

        cont = ""
        directories = {}

        try:
            cont = open(arg, "r").read()
        except FileNotFoundError:
            print(f"File {arg} was not found")

        try:
            directories = json.loads(cont)

        except Exception:
            print(f"File {arg} is not in json format")

        for l in directories.keys():

            # Check if there is already any symlink/file/directory with that name
            if system(f"[ -h \"{directories[l]}\" ] || [ -f \"{directories[l]}\" ] || [ -d \"{directories[l]}\" ]") == 0:
                system(f"rm -r \"{directories[l]}\"")
                print(f"Removed \"{directories[l]}\"")

            system(f"ln -s \"{l}\" \"{directories[l]}\"")
            print(f"Created symlink from {l} to {directories[l]}")

main(argv)
