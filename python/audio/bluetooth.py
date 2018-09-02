# ReachView code is placed under the GPL license.
# Written by Egor Fedorov (egor.fedorov@emlid.com)
# Copyright (c) 2015, Emlid Limited
# All rights reserved.

# If you are interested in using ReachView code as a part of a
# closed source project, please contact Emlid Limited (info@emlid.com).

# This file is part of ReachView.

# ReachView is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.

# ReachView is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with ReachView.  If not, see <http://www.gnu.org/licenses/>.

import time
import pexpect
import subprocess
import sys

class ControlError(Exception):
    """This exception is raised, when bluetoothctl fails to start."""
    pass


class Control:
    """A wrapper for bluetoothctl utility."""

    def __init__(self):
        #out = subprocess.check_output("rfkill unblock bluetooth", shell = True)
        self.child = pexpect.spawnu("bluetoothctl", echo = False)
        self.connected = ""

    def get_output(self, command, pause = 0.5):
        """Run a command in bluetoothctl prompt, return output as a list of lines."""
        self.child.send(command + "\n")
        time.sleep(pause)
        start_failed = self.child.expect(['\[(bluetooth|MDR-1000X)\]', pexpect.EOF]) #FIXME: Hardcoded prompt

        if start_failed:
            raise ControlError("Control failed after running " + command)
        self.connected = self.child.match.group(0)[1:-1]
        return self.child.before.split("\r\n")

    def start_scan(self):
        """Start bluetooth scanning process."""
        try:
            out = self.get_output("scan on")
        except ControlError as e:
            print(e)
            return None

    def make_discoverable(self):
        """Make device discoverable."""
        try:
            out = self.get_output("discoverable on")
        except ControlError as e:
            print(e)
            return None

    def parse_device_info(self, info_string):
        """Parse a string corresponding to a device."""
        device = {}
        block_list = ["[\x1b[0;", "removed"]
        string_valid = not any(keyword in info_string for keyword in block_list)

        if string_valid:
            try:
                device_position = info_string.index("Device")
            except ValueError:
                pass
            else:
                if device_position > -1:
                    attribute_list = info_string[device_position:].split(" ", 2)
                    device = {
                        "mac_address": attribute_list[1],
                        "name": attribute_list[2]
                    }

        return device

    def get_available_devices(self):
        """Return a list of tuples of paired and discoverable devices."""
        try:
            out = self.get_output("devices")
        except ControlError as e:
            print(e)
            return None
        else:
            available_devices = []
            for line in out:
                #print(line)
                device = self.parse_device_info(line)
                if device:
                    available_devices.append(device)

            return available_devices

    def get_paired_devices(self):
        """Return a list of tuples of paired devices."""
        try:
            out = self.get_output("paired-devices")
        except ControlError as e:
            print(e)
            return None
        else:
            paired_devices = []
            for line in out:
                device = self.parse_device_info(line)
                if device:
                    paired_devices.append(device)

            return paired_devices


    def get_discoverable_devices(self):
        """Filter paired devices out of available."""
        available = self.get_available_devices()
        paired = self.get_paired_devices()

        return [d for d in available if d not in paired]

    def get_device_info(self, mac_address):
        """Get device info by mac address."""
        try:
            out = self.get_output("info " + mac_address)
        except ControlError as e:
            print(e)
            return None
        else:
            return out

    def pair(self, mac_address):
        """Try to pair with a device by mac address."""
        try:
            out = self.get_output("pair " + mac_address, 4)
        except ControlError as e:
            print(e)
            return None
        else:
            res = self.child.expect(["Failed to pair", "Pairing successful", pexpect.EOF])
            success = True if res == 1 else False
            return success

    def remove(self, mac_address):
        """Remove paired device by mac address, return success of the operation."""
        try:
            out = self.get_output("remove " + mac_address, 3)
        except ControlError as e:
            print(e)
            return None
        else:
            res = self.child.expect(["not available", "Device has been removed", pexpect.EOF])
            success = True if res == 1 else False
            return success

    def connect(self, mac_address):
        """Try to connect to a device by mac address."""
        try:
            out = self.get_output("connect " + mac_address, 2)
        except ControlError as e:
            print(e)
            return None
        else:
            res = self.child.expect(["Failed to connect", "Connection successful", pexpect.EOF])
            success = True if res == 1 else False
            return success

    def disconnect(self, mac_address):
        """Try to disconnect to a device by mac address."""
        try:
            out = self.get_output("disconnect " + mac_address, 2)
        except ControlError as e:
            print(e)
            return None
        else:
            res = self.child.expect(["Failed to disconnect", "Successful disconnected", pexpect.EOF])
            success = True if res == 1 else False
            return success

    def disconnect_if_connected(self):
        devices = self.get_available_devices()
        for device in devices:
            if device["name"] == self.connected:
                self.disconnect(device["mac_address"])

    def get_connected(self):
        devices = self.get_available_devices() #update connected
        return self.connected


class Operation:
    def __init__(self):
        self.Bt = Control()

    def connect(self, name):
        self.__notify_success("Connecting: "+name, 2000)
        self.Bt.disconnect_if_connected()
        self.__do_connect(name)

    def reconnect(self, name):
        self.__notify_success("Reconnecting: "+name, 2000)
        self.Bt.disconnect_if_connected()
        self.__restart_bt_service()
        self.__do_connect(name)

    def disconnect(self):
        self.__notify_success("Disconnecting")
        self.Bt.disconnect_if_connected()

    def __do_connect(self, name):
        for trys in range (0, 3):
            if self.__connect(name):
                break
            else:
                self.__restart_bt_service()

    def __connect(self, name):
        available_devices = self.Bt.get_available_devices()
        self.Bt.disconnect_if_connected()
        if name != self.Bt.get_connected():
            for device in available_devices:
                if name == device["name"]:
                    if not self.Bt.connect(device["mac_address"]):
                        self.__notify_error("BT connect failure")
                        return False
                    else:
                        self.__notify_success(name + " is connected")
        return True


    def __notify_error(self, message):
        for i in range(0,4):
            subprocess.call(["notify-send","-t","300", message])
            time.sleep(0.5)


    def __notify_success(self, message, duration=2500):
        subprocess.call(["notify-send","-t",str(duration), message])


    def __restart_bt_service(self):
        subprocess.call(["sudo","systemctl","restart", "bluetooth.service"])
        time.sleep(0.5)





