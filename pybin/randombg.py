#!/usr/bin/env python3

#                             .___               ___.       ____
# _______ _____     ____    __| _/ ____    _____ \_ |__    / ___\
# \_  __ \\__  \   /    \  / __ | /  _ \  /     \ | __ \  / /_/  >
#  |  | \/ / __ \_|   |  \/ /_/ |(  <_> )|  Y Y  \| \_\ \ \___  /
#  |__|   (____  /|___|  /\____ | \____/ |__|_|  /|___  //_____/
#              \/      \/      \/              \/     \/
# FIGMENTIZE: randombg

"""
Stateful random background setter

This is a python script that uses feh to set the background on a computer
running X. It keeps track of a "stack" of previous backgrounds, which it can
traverse, so strictly speaking it's a list.
"""

# TODO add option for a literal path
# TODO add command line options for wallpaper directory, stack location, max
#      stack size
# TODO add mechanism for toggling cycling on and off (through some signpost
#      file or flag in the pickle stack, presumably)

import os
import sys
import pickle
import collections
import random
import subprocess
import pathlib
import shutil

import smartparse as argparse

import gi
gi.require_version('Notify', '0.7')
from gi.repository import Notify
Notify.init("backgrounds")

WALLPAPERS = pathlib.Path.home() / "Pictures" / "wallpapers"
if os.getenv("XDG_CACHE_HOME"):
    CACHE_HOME = pathlib.Path(os.getenv("XDG_CACHE_HOME"))
else:
    CACHE_HOME = pathlib.Path.home() / ".cache"
STACK = CACHE_HOME / "randombg" / "stack.pickle"
MAX_STACK = 100

def ensure_cache():
    if not STACK.exists():
        Notify.Notification.new(
                "randombg",
                "Creating {!s}".format(stack))
    STACK.parent.mkdir(parents=True, exist_ok=True)
    return STACK

class BackgroundStack:
    def __init__(self):
        self.stack = collections.deque(maxlen=MAX_STACK)
        self.random_bg()

    def set_bg(self, choice):
        if not isinstance(choice, pathlib.Path):
            notif = Notify.Notification.new(
                    "randombg",
                    "Your cache is out of date - not using pathlib")
            notif.set_urgency(Notify.Urgency.CRITICAL)
            notif.show()
            print("Cache out of date", file=sys.stderr)
            sys.exit(1)
        else:
            if shutil.which("feh"):
                Notify.Notification.new(
                        "randombg",
                        "{} (s:{})".format(choice, self.pos)).show()
                subprocess.call(
                        ["feh", "--bg-scale", choice])
            else:
                notif = Notify.Notification.new(
                        "randombg",
                        "Feh executable not present")
                notif.set_urgency(Notify.Urgency.CRITICAL)
                notif.show()
                print("No feh executable", file=sys.stderr)
                sys.exit(1)

    def random_bg(self):
        # TODO: prevent repetition
        choice = random.choice(list(WALLPAPERS.iterdir()))
        self.stack.append(choice)
        self.pos = len(self.stack) - 1
        self.set_bg(choice)

    def prev_bg(self):
        if self.pos > 0:
            self.pos -= 1
            self.set_bg(self.stack[self.pos])
        else:
            Notify.Notification.new("randombg", "stack underflow").show()

    def next_bg(self):
        if self.pos < len(self.stack) - 1:
            self.pos += 1
            self.set_bg(self.stack[self.pos])
        else:
            Notify.Notification.new("randombg", "stack overflow").show()

def get_args():
    parser = argparse.ArgumentParser(description=__doc__)
    action = parser.add_mutually_exclusive_group(required=True)
    action.add_argument("--random", action="store_true",
            help="choose random next background and move to top of stack")
    action.add_argument("--next", action="store_true",
            help="move to next background in stack")
    action.add_argument("--prev", action="store_true",
            help="move to previous background in stack")
    action.add_argument("--init", action="store_true",
            help="initialise the background stack")
    return parser.parse_args()

if __name__ == "__main__":
    args = get_args()
    if args.init:
        stack = BackgroundStack()
        with ensure_cache().open("wb") as stackfile:
            pickle.dump(stack, stackfile)
    else:
        try:
            with ensure_cache().open("rb") as stackfile:
                stack = pickle.load(stackfile)
        # TODO: just make this automatic
        except Exception:
            print("ERROR: you may need to initialise with --init\n\n")
            raise
        if args.random:
            stack.random_bg()
        elif args.prev:
            stack.prev_bg()
        elif args.next:
            stack.next_bg()
        else:
            print("unimplemented option")

        with ensure_cache().open("wb") as stackfile:
            pickle.dump(stack, stackfile)
