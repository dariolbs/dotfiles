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

class DataBase:
    """
    DataBase class
    A DataBase contains a list of journal entries and requires a password to decrypt
    """

    def __init__(self, owner, start_date = CURRENT_DATE, name = "My Journal", entries = []) -> None:

        self._start_date = CURRENT_DATE
        self._name = name
        self._entries = entries 
        self._owner = owner 

    def getName(self) -> str:
        """
        Returns the name of the database
        """
        return self._name

    def getOwner(self) -> str:
        """
        Returns the name of the database
        """
        return self._owner

    def getEntries(self) -> list:
        """
        Returns all entres of the database as a list
        """
        return self._entries

    def getStartDate(self) -> str:
        """
        Returns the starting date of the database
        """
        return self._start_date

    def addEntry(self, entry: JournalEntry) -> None:
        self._entries.append(entry)

    def export(self, path):

        file = open(path, "w")

        file.write(f"start -> {self.getStartDate()}\n")
        file.write(f"name -> {self.getName()}\n")
        for entry in self.getEntries():
            file.write(f"{entry}\n")
