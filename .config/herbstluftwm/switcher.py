#!/usr/bin/env python3
import os
import subprocess
from argparse import ArgumentParser
from typing import Any, Dict, Optional


def main():
    parser = ArgumentParser(prog="switcher.py")
    parser.add_argument("value", type=str)
    args = parser.parse_args()

    if args.value not in ["laptop", "desktop", "mirror"]:
        return

    if args.value == "laptop":
        subprocess.run(
            args=["python", "/home/pth/pallisupercoding/fontsize/fontsize.py", "10"]
        )
    elif args.value in ["mirror", "desktop"]:
        subprocess.run(
            args=["python", "/home/pth/pallisupercoding/fontsize/fontsize.py", "11"]
        )

    os.system(f"cp {args.value}_autostart autostart")

    os.chdir("/home/pth/.config/rofi")
    os.system(f"cp {args.value}_config.rasi config.rasi")


if __name__ == "__main__":
    os.chdir("/home/pth/.config/herbstluftwm")
    main()
