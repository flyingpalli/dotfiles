#!/usr/bin/env python3
import os
import subprocess
from argparse import ArgumentParser
from typing import Any, Dict, Optional


def check_third_line(value):
    try:
        with open("autostart", "r") as file:
            lines = [next(file) for _ in range(3)]
            if value in lines[2]:
                return True
                print("i returned true")
            else:
                return False
                print("i returned false")
    except FileNotFoundError:
        print("something went horribly wrong")
        return


def main():
    parser = ArgumentParser(prog="switcher.py")
    parser.add_argument("value", type=str)
    args = parser.parse_args()

    if args.value == "laptop":
        subprocess.run(
            args=["python", "/home/pth/pallisupercoding/fontsize/fontsize.py", "8"]
        )
    elif args.value == "desktop":
        subprocess.run(
            args=["python", "/home/pth/pallisupercoding/fontsize/fontsize.py", "11"]
        )

    if check_third_line(args.value):
        return
    os.rename("autostart", "temp_autostart")
    os.rename("other_autostart", "autostart")
    os.rename("temp_autostart", "other_autostart")

    # os.chdir("/home/pth/.config/rofi")
    # os.rename("config.rasi", "temp_config.rasi")
    # os.rename("other_config.rasi", "config.rasi")
    # os.rename("temp_config.rasi", "other_config.rasi")


if __name__ == "__main__":
    os.chdir("/home/pth/.config/herbstluftwm")
    main()
