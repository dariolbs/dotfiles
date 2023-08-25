from constants import *
from hashlib import sha512
from journal_entry import *

class DataBase:
    """
    DataBase class
    A DataBase contains a list of journal entries and requires a password to decrypt
    """

    def __init__(self, owner, hash, start_date = CURRENT_DATE, name = "My Journal", entries = []) -> None:

        self._start_date = start_date
        self._name = name
        self._entries = entries 
        self._owner = owner 
        self._hash = hash 
        self._modified = start_date

    def getName(self) -> str:
        """
        Returns the name of the database
        """
        return self._name

    def getHash(self) -> str:
        """
        Returns the password's hash of the database
        """
        return self._hash

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
        file.write(f"hash -> {self.getHash()}\n")
        for entry in self.getEntries():
            file.write(f"{entry}\n")

def importDB(path) -> DataBase:

    info = open(f"{path}/db_info.txt")

    owner = start_date = name = ""

    entries = []

    reading_entry = False

    for line in info.readlines():

        sep = line.split(" -> ")

        if len(sep) >= 2:
            print("Badly formatted database file")
            exit(1)

        if sep[0] == "start":
            start_date = sep[1]

        elif sep[0] == "name":
            name = sep[1]

        elif sep[0] == "owner":
            owner = sep[1]
