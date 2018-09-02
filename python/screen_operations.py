#! /usr/bin/env python3
import sys
from video import xrandr
import subprocess

xr = xrandr.Xrandr()
def main():
    if len(sys.argv) > 1:
        if sys.argv[1] == "auto":
            if len(xr.get_outputs_info_connected()) >= 2:
                xr.deactDisplay("eDP1")
                xr.set_primary_output("DP1")
                xr.actDisplay("DP1")
            else:
                activate_default()

        elif sys.argv[1] == "toggle":
            outputs_info = xr.get_outputs_info_connected()
            if len(outputs_info) >= 2:
                other_output = ""
                current_output_name = xr.get_primary_output_info().name
                for output in outputs_info:
                    if output.name != current_output_name:
                        other_output = output.name
                        break
                xr.set_primary_output(other_output)
                xr.deactDisplay(current_output_name)
                xr.actDisplay(other_output)
            else:
                activate_default()

    subprocess.call(["feh","--bg-fill","/home/robban/.config/wallpaper.jpg"])

    # subprocess.check_output(["pactl","list","short","cards"]).decode("utf-8").split()

def activate_default():
    xr.set_primary_output("eDP1")
    xr.actDisplay("eDP1")

if __name__ == "__main__":
    main()

