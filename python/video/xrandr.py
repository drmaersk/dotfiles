import subprocess
from Xlib import X, display
from Xlib.ext import randr

class Xrandr(object):
    def __init__(self):
        scr = display.Display().screen()
        self.window = scr.root.create_window(0, 0, 1, 1, 1, scr.root_depth)
        self.outputs = randr.get_screen_resources(self.window).outputs

    def valid_display_name(self, displayName):
        for output in self.outputs:
            if randr.get_output_info(self.window, output, 0).name == displayName:
                return True, output
        return False

    def get_outputs_info(self):
        outputs_info = list()
        for output in self.outputs:
            outputs_info.append(randr.get_output_info(self.window, output, 0))
        return outputs_info

    def get_outputs_info_connected(self):
        outputs_info = list()
        for output in filter(lambda oi: oi.connection == 0, self.get_outputs_info()):
            outputs_info.append(output)
        return outputs_info

    def get_primary_output_info(self):
        return randr.get_output_info(self.window, randr.get_output_primary(self.window).output, 0)

    def set_primary_output(self, displayName):
        is_valid, output = self.valid_display_name(displayName)
        if is_valid:
            randr.set_output_primary(self.window, output)

    def actDisplay(self, displayName):
        if self.valid_display_name(displayName):
            subprocess.call(["xrandr","--output", displayName, "--auto"])

    def deactDisplay(self, displayName):
        if self.valid_display_name(displayName):
            subprocess.call(["xrandr","--output", displayName, "--off"])




