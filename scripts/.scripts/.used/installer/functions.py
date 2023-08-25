#!/usr/bin/python3

from os import environ, system, popen
from consants import *

def tutorial() -> None:
    """
    Prints the tutorial
    """
    print(
        "Easily modifiable Arch Linux install script\n" +\
        "1 - Install dependencies in config/dependencies.conf\n" +\
        "2 - Run pre-install scripts in config/pre-scripts\n" +\
        "3 - Install all packages in the package list of choice\n" +\
        "4 - Run post-install scripts in config/post-scripts\n" +\
        "5 - Enable all services in config/daemons.conf using systemd"
            )

def getPackageLists() -> list:
    lists = []

    for line in popen(f'ls {PACKAGE_LIST_DIR}').readlines():
        lists.append(line.rstrip())

    return lists

def execute(command: str) -> None:
    """
    Executes a command, used for debugging
    """
    if DEBUG:
        print(command)
    else:
        system(command)

def getList(filepath: str) -> list:
    """
    Get all the text on a file in a list format
    """

    file = open(filepath, "r")
    lst = []

    for line in file.readlines():

        #Check if lines are either empty or commented
        if line[0] == "+":
            addon = line.rstrip()[1:]
            print(addon)

            # Try using the name of the package list without ".conf" at the end
            try:
                lst += getList(f'{PACKAGE_LIST_DIR}/{addon}')
            except FileNotFoundError:

                # If it fails, try using it with ".conf" at the end
                try:
                    lst += getList(f'{PACKAGE_LIST_DIR}/{addon}.conf')

                # Fail in case the file does not exist
                except FileNotFoundError:
                    print(f"Package list {addon} not found")
                    exit(1)

        elif line != "\n" and line[0] != "#":
            lst.append(line.rstrip())

    return lst

def installDependencies() -> None:
    """
    Installs all dependencies needed for the install to work
    All dependencies are stored in config/dependencies.conf
    """
    dependencies = ""
    
    for dep in getList(DEPENDENCIES_FILE):
        dependencies += f"{dep} "

    execute(f"sudo pacman -S --needed {dependencies}")

def installPackages(packageListFile) -> None:
    """
    Installs all dependencies needed for the install to work
    All dependencies are stored in config/dependencies.conf
    """

    packages = ""

    for p in getList(packageListFile):
        packages += f"{p} "

    execute(f"yay -S --needed {packages}")

def activateDaemons() -> None:
    """
    Activates all daemons specified in the config file using systemd
    """

    daemons = []
    
    for dae in getList(DAEMONS_FILE):
        daemons.append(dae)
        
    for daemon in daemons:
        execute(f"sudo systemctl start {daemon}")
        execute(f"sudo systemctl enable {daemon}")

def installYay() -> None:
    execute("mkdir -p $HOME/.gitclones")
    execute("cd $HOME/.gitclones")
    execute("sudo git clone https://aur.archlinux.org/yay-git.git")
    execute("sudo chown -R $USER:$USER ./yay-git")
    execute("cd yay-git")
    execute("makepkg -si")
    execute("cd")
