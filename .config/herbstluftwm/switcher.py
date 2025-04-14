#!/usr/bin/env python3
import os
import subprocess
from argparse import ArgumentParser


def main():
    parser = ArgumentParser(prog="switcher.py")
    parser.add_argument("value", type=str)
    args = parser.parse_args()
    val = args.value.lower()

    if val not in ["laptop", "desktop", "mirror"]:
        return

    if val == "laptop":
        subprocess.run(
            args=["python", "/home/paskal/pallisupercoding/fontsize/fontsize.py", "14"]
        )
    elif val in ["desktop", "mirror"]:
        subprocess.run(
            args=["python", "/home/paskal/pallisupercoding/fontsize/fontsize.py", "11"]
        )

    os.system(f"cp {val}_autostart autostart")

    os.chdir("/home/paskal/.config/rofi")
    os.system(f"cp {val}_config.rasi config.rasi")


if __name__ == "__main__":
    os.chdir("/home/paskal/.config/herbstluftwm")
    main()
