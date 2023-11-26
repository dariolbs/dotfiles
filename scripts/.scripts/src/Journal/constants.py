from os import environ
from datetime import date

TEMP_FOLDER     = f'{environ["XDG_RUNTIME_DIR"]}/journal'
JOURNAL_FOLDER  = f'{environ["HOME"]}/.local/share/journal'
DATE     = f"{date.today()}"
