#! /usr/bin/env python3

# from subprocess import run, PIPE
# import os
# import bluetooth
import configparser

config_file_path = "/home/robban/.config/robban_audio.ini"

class cfg_parser:
    def __init__(self):
        #create file if not exist
        try:
            self.file = open(config_file_path, 'r')
        except IOError:
            self.file = open(config_file_path, 'w')
        self.config = configparser.ConfigParser()
        self.read_config_file()

    def get_current_device(self):
        return str(self.config['devices']['current'])

    def set_current_device(self, device):
        if device in self.device_list:
            self.config['devices']['current'] = device
            self.refresh_config_file()

    def get_devices(self):
        return self.device_list

    def add_device(self, new_device_name):
        if new_device_name not in self.device_list:
            new_device_list = str()
            for device in self.device_list:
                new_device_list = new_device_list + device + ","
            new_device_list = new_device_list + new_device_name
            self.config['devices']['list'] = new_device_list
            self.refresh_config_file()

    def refresh_config_file(self):
        self.write_config_file()
        self.read_config_file()

    def read_config_file(self):
        self.config.read(self.file.name)
        self.file.close()
        self.device_list = list(str(self.config['devices']['list']).split(","))

    def write_config_file(self):
        with open(config_file_path, 'w') as configfile:
            self.config.write(configfile)

