import os
from sys import argv
from tcolors import tcolors as tc
from count_days import daysin

DEF_STREAKS_DIR = f'{os.environ["HOME"]}/.local/share/stk'
DEF_STREAK_FILE = f'{DEF_STREAKS_DIR}/streaks'
DATE = os.popen("date +%d/%m/%Y")

# Create needed directories if they don't exist yet
os.system(f"mkdir -p {DEF_STREAKS_DIR}")
os.system(f"[ -f {DEF_STREAK_FILE} ] || touch {DEF_STREAK_FILE}")

def getStreaks(streak_file = DEF_STREAK_FILE) -> dict:
    streaks = {}
    with open(streak_file, "w") as file:
        for line in file.readlines():
            separated = line.split(" -> ")
            streaks[separated[0]] = separated[1]
    return streaks

def addStreak(streak_file, name, date = DATE):
    os.system(f"echo {name} -> {date} >> {streak_file}")

def printPhrase(name: str, days:int) -> None:

    STATEMENTS = {
            10: f"{tc.BLUE}{name} {tc.ENDC}->{tc.BLUE} " +\
                    f"{days} days{tc.ENDC}",
            20: f"{tc.GREEN}{name} {tc.ENDC}->{tc.GREEN} " +\
                    f"{days} days{tc.ENDC}",
            30: f"{tc.YELLOW}{name} {tc.ENDC}->{tc.YELLOW} " +\
                    f"{days} days{tc.ENDC}",
            100: f"{tc.BOLD_BLUE}{name} {tc.ENDC}-->{tc.BOLD_BLUE} " +\
                    f"{days} days 😁{tc.ENDC}",
            365: f"{tc.BOLD_GREEN}{name} {tc.ENDC}-->${tc.BOLD_GREEN} " +\
                    f"{days} days 😎{tc.ENDC}",
            730: f"{tc.BOLD_YELLOW}{name} {tc.ENDC}=>{tc.BOLD_YELLOW} " +\
                    f"{days} days 🤩{tc.ENDC}",
            1000: f"{tc.BOLD_RED}{name} {tc.ENDC}==>{tc.BOLD_RED} " +\
                    f"{days} days! 🔥{tc.ENDC}",
    }

    for i in STATEMENTS.keys():
        if days <= i:
            print(STATEMENTS[i])
            return

for i in range(0, len(argv)):
    if argv[i] == "add":
        name = input("Name of the streak: ")
        date = input("Starting date: ")
        if date == "":
            date = DATE
        addStreak(DEF_STREAK_FILE, name, date)
    else:
        streaks = getStreaks(DEF_STREAK_FILE)
        for i in streaks.keys():
            printPhrase(i, daysin(DATE) - daysin(streaks[i]))
