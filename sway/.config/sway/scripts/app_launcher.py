#!/usr/bin/python3

from sys import argv
from os import popen, system, getenv
import pickle
import re

LAUNCHER_CMD = 'wmenu -b -i -f "JetBrainsMonoNerdFont 12"'

class DesktopEntry:

    def __init__(self, _type : str,
                 _name : str, 
                 _exec : str, 
                 _tryexec : str, 
                 _nodisplay : bool, 
                 _terminal : bool,
                 _times_used : int = 0
                 ) -> None:

        self._type = _type.rstrip()
        self._name = _name.rstrip()
        self._exec = _exec.rstrip()
        self._tryexec = _tryexec.rstrip()
        self._nodisplay = _nodisplay
        self._terminal = _terminal
        self._times_used = _times_used

    def execute(self) -> int:

        if self._terminal:

            termcmd = getenv("TERMINAL")
            if termcmd == None:
                return 1
            ret = system(self.sanitize(termcmd + " " + self._exec + " &"))

        else:
            ret = system(self.sanitize(self._exec) + " &")
        
        return ret

    def sanitize(self, command) -> str:
        return re.sub(
                "(%u|%U|%f|%F|%d|%D|%n|%N|%i|%c|%k|%v|%m)", 
                "", command)

    def set_times_used(self, newvalue : int):
        self._times_used = newvalue

    def __eq__(self, value) -> bool:
        if type(value) != DesktopEntry:
            return False
        return value._name == self._name and\
                value._times_used == self._times_used

    def __lt__(self, value) -> bool:
        if value._times_used == self._times_used:
            return value._name > self._name
        else:
            return value._times_used < self._times_used

    def __hash__(self):
        return len(self._name)

    def __str__(self) -> str:
        return f'{self._name} -> {self._exec}'


def getEntry(_filename : str) -> DesktopEntry:

    with open(_filename,"r") as f:

        _type = _name = _exec = _tryexec = ""
        _nodisplay = _terminal = reading = False

        for l in f.readlines():

            if l.rstrip() == "[Desktop Entry]":
                reading = True
            elif l[0] == "[":
                reading = False

            if reading:
                if l[:5] == "Name=":
                    _name = l[5:]
                elif l[:5] == "Type=":
                    _type = l[5:]
                elif l[:5] == "Exec=":
                    _exec = l[5:]
                elif l[:8] == "TryExec=":
                    _tryexec = l[8:]
                elif l.rstrip() == "NoDisplay=true":
                    _nodisplay = True
                elif l.rstrip() == "Terminal=true":
                    _terminal = True

        return DesktopEntry(_type, _name, _exec, _tryexec, _nodisplay, _terminal)

def loadCache() -> dict:

    cache_home = getenv("XDG_CACHE_HOME")
    if cache_home:
        cache_path = f'{getenv("XDG_CACHE_HOME")}/sway_app_launcher_cache'
        try:
            with open(cache_path, "rb") as f:
                return pickle.load(f)
        except FileNotFoundError:
            return {}
        
    else:
        return {}

def dumpChance(obj):

    cache_home = getenv("XDG_CACHE_HOME")
    if cache_home:
        cache_path = f'{getenv("XDG_CACHE_HOME")}/sway_app_launcher_cache'
        with open(cache_path, "wb") as f:
            return pickle.dump(obj, f)

def entriesString(_entries) -> str:

    r = ""
    for e in _entries:
        if e._name != "" and e._nodisplay == False:
            r += e._name + "\n"
    return r

if __name__ == "__main__":
                            
    entries = []

    cache = loadCache()

    for file in argv:
        entry = getEntry(file)
        if entry._name in cache.keys():
            entry.set_times_used(cache[entry._name])
        entries.append(entry)

    entries = sorted(set(entries))
    selected = popen(f'printf "{entriesString(entries)}" | {LAUNCHER_CMD}').read().rstrip()

    if selected == '':
        exit(1)

    if selected in cache.keys():
        cache[selected] = cache[selected] + 1
    else:
        cache[selected] = 1

    dumpChance(cache)

    for e in entries:
        if e._name == selected:
            e.execute()
