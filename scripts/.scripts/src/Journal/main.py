from os import popen, system, environ
from random import randrange
import sys
from constants import *
from tcolors import tcolors

def logo() -> None:
    print(
        "\n" +\
        "    /$$$$$                                                   /$$\n" +\
        "   |__  $$                                                  | $$\n" +\
        "      | $$  /$$$$$$  /$$   /$$  /$$$$$$  /$$$$$$$   /$$$$$$ | $$\n" +\
        "      | $$ /$$__  $$| $$  | $$ /$$__  $$| $$__  $$ |____  $$| $$\n" +\
        " /$$  | $$| $$  \\ $$| $$  | $$| $$  \\__/| $$  \\ $$  /$$$$$$$| $$\n" +\
        "| $$  | $$| $$  | $$| $$  | $$| $$      | $$  | $$ /$$__  $$| $$\n" +\
        "|  $$$$$$/|  $$$$$$/|  $$$$$$/| $$      | $$  | $$|  $$$$$$$| $$\n" +\
        " \\______/  \\______/  \\______/ |__/      |__/  |__/ \\_______/|__/\n"
            )

def write( existing_file = None ) -> str:
    """
    Puts the user writing in a temporary file and returns its object
    """

    if existing_file == None:
        filepath = f"{TEMP_FOLDER}/journal_runtime_{randrange(10000, 99999)}.txt"
        system(f"$EDITOR {filepath}")
        return filepath
    else:
        filepath = f"{TEMP_FOLDER}/journal_runtime_{randrange(10000, 99999)}.txt"
        system(f"cp {existing_file} {filepath}")
        system(f"$EDITOR {filepath}")
        return filepath



def main():
    """
    Main function
    """

    system(f"mkdir -p {TEMP_FOLDER}")
    system(f"mkdir -p {JOURNAL_FOLDER}")

    date = DATE

    logo()

    file_check = f"~/.local/share/journal/{DATE}.txt"

    # Check if file exists
    if system(f"[ -f {file_check} ]") == 0:

        response = input(f"File {tcolors.UNDERLINE}{file_check}{tcolors.ENDC} already exists.\n\n1 - {tcolors.GREEN}Change/Check{tcolors.ENDC} file\n2 - {tcolors.RED}Delete{tcolors.ENDC} file\n")

        if int(response) == 1:
            filename = write(file_check)
            if system(f"rm {file_check} && cp {filename} {file_check}") == 0:
                print(f"{tcolors.YELLOW}Updated{tcolors.ENDC} journal entry {tcolors.UNDERLINE}{filename}{tcolors.ENDC} with success")
            else:
                print(f"{tcolors.RED}Errors ocurred{tcolors.ENDC} copying journal entry {tcolors.UNDERLINE}{filename}{tcolors.ENDC}")
            exit(0)

        elif int(response) == 2:
            system(f"rm {file_check}")
            print(f"File {file_check} deleted")
            exit(0)

        else:
            print("Uknown option")
            exit(1)

    print(f"Current date: {DATE}\n")
    d = input(f"Type the date of the journal entry in yyyy-mm-dd format (defaults to current date)\n")

    if d != "":
        date = d


    response = filename = ""

    while response != "yes":
        if filename :
            system(f"$EDITOR {filename}")
        else:
            filename = write()
        response = input("Are you sure you want to write it? yes/no | quit\n")
        if response == "quit":
            exit(0)

    system(f"cp {filename} {JOURNAL_FOLDER}/{date}.txt")
    print(f"{tcolors.GREEN}Added{tcolors.ENDC} journal entry {filename} with success")

    # Remove old  folder
    system(f"rm {TEMP_FOLDER}/*")

main()
