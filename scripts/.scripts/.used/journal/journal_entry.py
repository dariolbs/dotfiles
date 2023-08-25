from constants import *
from hashlib import sha512

class JournalEntry:

    def __init__(self, date: str, content: str) -> None:
        self._content = content
        self._date = date

    def getContent(self) -> str:
        return self._content

    def getDate(self) -> str:
        return self._date

    def __str__(self) -> str:
        string = f"{self.getDate()}\n" +\
                f"{self.getContent()}\n"
        return string

    def export(self) -> None:
       pass 
