from os import popen, environ

CURRENT_DATE = popen("date +%m/%d/%Y").read().rstrip()
DATABASE_DIR = f'{environ["HOME"]}/.local/share/journal/databases'
