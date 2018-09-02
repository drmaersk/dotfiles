#! /usr/bin/env python3

from subprocess import run, PIPE
import os
import bluetooth
from bluetooth_config_parser import cfg_parser

class rofi(object):
    def __init__(self, options_list=list(), title = "No title"):
        self.title = title
        self.options_list = options_list

    def show(self):
        my_env = os.environ.copy()
        my_env["XENVIRONMENT"]="/home/robban/dev/res/rofi.config"

        input_string = ""
        for item in self.options_list:
            input_string += item + "\n"

        value = run(['rofi','-dmenu','-p',self.title, '-hide-scrollbar'],stdout=PIPE, input=input_string, encoding='utf-8', env=my_env).stdout
        return value.rstrip("\n\r");

    def set_title(self, new_title):
        self.title = new_title

    def set_list(self, new_options_list):
        self.options_list = new_options_list

def main():
    R = rofi()
    P = cfg_parser()
    current_device = P.get_current_device()
    R.set_title("Bluetooth ["+current_device+"]")
    BtOp = bluetooth.Operation()
    operations = {"Connect" : lambda : BtOp.connect(current_device),
                  "Reconnect" : lambda : BtOp.reconnect(current_device),
                  "Disconnect": lambda : BtOp.disconnect(),
                  "Change current device": lambda : print("Chnge"),
                  "Add new device": lambda : print("Add")}
    R.set_list(list(operations.keys()))
    operation = R.show()
    if operation:
        operations[operation]()


if __name__ == "__main__":
    main()
