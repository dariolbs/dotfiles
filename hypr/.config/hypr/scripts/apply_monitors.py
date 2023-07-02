#!/usr/bin/env python3
import os
from typing import Dict

class Monitor(object):

    def __init__(self, name, res, refresh, wspaces, place) -> None:

        self._name = name
        self._workspaces = wspaces
        self._resolution = res
        self._refresh = refresh
        self._place = place

    def setWorkSpaces(self, workspaces):
        self._workspaces = workspaces

    def setResolution(self, res):
        self._resolution =  res

    def setRefreshRate(self, refresh):
        self._refresh =  refresh

    def getWorkSpaces(self):
        return self._workspaces

    def getPlace(self):
        return self._place

    def getName(self):
        return self._name

    def getResolution(self):
        return self._resolution

    def getRefreshRate(self):
        return self._refresh

    def applyMonitor(self):
        print("hyprctl dispatch monitor=" + self.getName()\
                + "," + self.getResolution() + "@" + self.getRefreshRate()\
                + "," + self.getPlace() + ",1")

        for i in self._workspaces:
            os.system("hyprctl dispatch workspace=" + str(i) + ", monitor:"\
                    + self.getName() + ", default:true" )

    def checkMonitor(self):
        # For debugging
        print("hyprctl dispatch monitor=" + self.getName()\
                + "," + self.getResolution() + "@" + self.getRefreshRate()\
                + "," + self.getPlace() + ",1")

        for i in self._workspaces:
            print("hyprctl dispatch workspace=" + str(i) + ", monitor:"\
                    + self.getName() + ", default:true" )

hostname = os.popen("cat /etc/hostname").read()

monitors = []

# Add your confs here
if hostname == "archlinux\n":
    monitors = [
            Monitor("HDMI-A-2", "1920x1080", "60", range(11, 15), "0x0"),
            Monitor("DP-1", "1920x1080", "165", range(1, 11), "1920x0"),
            Monitor("HDMI-A-1", "1920x1080", "60", range(15, 19), "1920x0")
            ]
elif hostname == "arch\n":
    monitors = [
            Monitor("eDP-1", "1920x1080", "60", range(1, 11), "0x0"),
            ]

for monitor in monitors:
    monitor.applyMonitor()
