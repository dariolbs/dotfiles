#!/usr/bin/python3

from os import environ
from functions import *
from tcolors import tcolors
from logging import inform

def main():
    """
    The main function
    """

    print(f"\n{tcolors.BLUE}Arch Linux{tcolors.ENDC} install wizard version {tcolors.UNDERLINE}{VERSION}{tcolors.ENDC}\n")

    print(f"For this install wizard to work, you need to have {tcolors.RED}sudo{tcolors.ENDC} installed and {tcolors.RED}multilib repository{tcolors.ENDC} enabled.\n")
    if input(f"Are you sure you want to proceed? (yes/no)\n") != "yes":
        exit(1)

    # Install dependencies
    inform(f"Installing Dependencies using {tcolors.UNDERLINE}{DEPENDENCIES_FILE}{tcolors.ENDC}")
    execute("sleep 1")
    installDependencies()   

    # Execute pre install script
    inform(f"Executing pre install scripts in {tcolors.UNDERLINE}{PRE_SCRIPTS_DIR}{tcolors.ENDC}")
    execute("sleep 1")
    execute(f"for script in {PRE_SCRIPTS_DIR}/*; do bash \"$script\"; done")  

    # Get all package lists avaliable
    package_lists = getPackageLists()

    print(f"\nAll avaliable {tcolors.BLUE}package lists{tcolors.ENDC} in {PACKAGE_LIST_DIR}:\n")

    n = 1
    for p in package_lists:

        print(f"{n} -> {tcolors.GREEN}{p}{tcolors.ENDC}")
        n += 1

    chosen = 0

    # Select a package list
    while int(chosen) <= 0 or int(chosen) > len(package_lists):
        chosen = input(f"\nChoose a package list. From 1 to {len(package_lists)}\nNumber chosen: ")

    # Install the package list
    installPackages(f'{environ["HOME"]}/.config/installer/package_lists/{package_lists[int(chosen) - 1]}')

    # Activate daemons
    inform(f"Activating daemons using {tcolors.UNDERLINE}{DAEMONS_FILE}{tcolors.ENDC}")
    execute("sleep 1")
    activateDaemons()

    # Execute post install scripts
    inform(f"Executing post install scripts in {tcolors.UNDERLINE}{POST_SCRIPTS_DIR}{tcolors.ENDC}")
    execute("sleep 1")
    execute(f"for script in {POST_SCRIPTS_DIR}/*; do bash \"$script\"; done")  

main()
