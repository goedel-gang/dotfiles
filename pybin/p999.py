#!/usr/bin/env python3

#         ________  ________  ________
# ______ /   __   \/   __   \/   __   \
# \____ \\____    /\____    /\____    /
# |  |_> >  /    /    /    /    /    /
# |   __/  /____/    /____/    /____/
# |__|
# FIGMENTIZE: p999

"""
This is a script that does some drawing with truecolor escape codes in the
terminal. It's a nice little exercise in using truecolor escape codes, and in
generating a colour wheel. It's also "useful" for testing the capabilities of
your current terminal. For example, the output breaks hilariously in URxvt, and
if you've got tmux set up to override truecolor, will look blocky in tmux. It
should look like a smooth colour wheel in that fits on the screen.

It tries to make the circle the right aspect ratio by querying the pixel
dimensions of the current window. If this literally breaks, it will fall back to
the assumption that its output is roughly 1x2 (for example if you don't have
xwininfo or you're running in tmux). However, if you've got some other
circumstance that's causing the pixel dimensions to not be the same as the
actual screen real estate available to the terminal, this circle will probably
be squashed a little.

If you stare into the centre of the pattern closely for a couple of seconds, and
then quickly switch to something with a white background (like a wall or a
browser), you're in for a trip.

It will need Python 3.5+ to run.
"""

# TODO: let's make this really fast.
#       Also add options for explicit ratios, or something else idk
#       make clearing the screen optional
#       add option for background colour
#       option to toggle antialiasing?
#       generally read arguments, show help

import sys

from pathlib import Path
from colorsys import hsv_to_rgb
from math import pi, sqrt, atan2
from shutil import get_terminal_size, copyfileobj
# this will need python 3.5+
try:
    from subprocess import run, CalledProcessError, PIPE
except ImportError:
    sys.exit("Geriatric snake? Get with the times")
from itertools import groupby
from os import getenv
from os.path import getmtime
from re import findall

if getenv("XDG_CACHE_HOME"):
    CACHE_HOME = Path(getenv("XDG_CACHE_HOME"))
else:
    CACHE_HOME = Path.home() / ".cache"

CACHE_DIR = CACHE_HOME / "p999"

def get_window_id():
    """
    Get current window id.
    """
    if getenv("WINDOWID"):
        return getenv("WINDOWID")
    else:
        try:
            result = run(["xdotool", "getactivewindow"],
                    check=True, stdout=PIPE)
            return result.stdout.decode().strip()
        except (CalledProcessError, FileNotFoundError) as e:
            raise FileNotFoundError("Cannot get window id")

def get_win_dimensions():
    """
    Get the width and height in pixels of the current window.
    It is only really used for aspect ratio purposes, so the fallback is to just
    say the number of lines by twice the number of columns.
    """
    try:
        result = run(["xwininfo", "-id", get_window_id()],
                check=True, stdout=PIPE)
        wininfo_lines = [l.strip() for l in result.stdout.decode().split("\n")]
    except (CalledProcessError, FileNotFoundError) as e:
        print("not using xwininfo: {}".format(e), file=sys.stderr, flush=True)
        w, h = get_terminal_size()
        return w, h * 2
    try:
        # this is better because xterm gives its geometry in characters
        d_result = run(["xdotool", "getdisplaygeometry"],
                check=True, stdout=PIPE)
        d_w, d_h = map(int, d_result.stdout.decode().split())
        corner_text, = (line for line in wininfo_lines
                if line.startswith("Corners:"))
        # NOT A LIST, AN ITERABLE THAT IS CONSUMED
        # separate variable just for intermediate computation
        corners = map(int, findall(r"[-+]\d+", corner_text))
        x_l, y_t, x_r, _, _, y_b, *_ = corners
        print("situation normal", file=sys.stderr, flush=True)
        # - 1 + 1 so that a full screen window is calculated correctly.
        return (x_r - x_l - 1) % d_w + 1, (y_b - y_t - 1) % d_h + 1
    except (CalledProcessError, FileNotFoundError) as e:
        print("not using xdotool: {}".format(e), file=sys.stderr, flush=True)
        geom, = (line for line in wininfo_lines if line.startswith("-geometry"))
        w, h, *_ = map(int, findall(r"\d+", geom))
        return w, h

def get_dimensions():
    """
    Determine the dimensions in characters of the block of colour to draw
    """
    px_w, px_h = get_win_dimensions()
    w, h = get_terminal_size()
    # determine the aspect ratio of one character, in order to print as much of
    # a square as possible.
    ratio = (px_h * w) / (px_w * h)
    # leave either 4 extra lines or 1 blank column
    w, h = w - 1, h - 4
    if w < h * ratio:
        return w, int(w / ratio)
    return int(h * ratio), h

def get_rgb(x, y, w, h, tol):
    """
    Get a truecolor RGB triple to set the colour to. Also does some antialiasing
    - will be black if fully outside circle.
    """
    dist = 2 * sqrt((x * h) ** 2 + (y * w) ** 2) / (h * w)
    if dist < 1 - tol:
        v = 1
    elif dist < 1 + tol:
        v = (1 - dist) / (2 * tol) + 0.5
    else:
        # used to be v = 0, but we can prematurely optimise this case
        return 0, 0, 0
    hu = atan2(y * w, x * h) / (2 * pi) + 0.5
    s = min(dist, 1)
    return tuple(int(i * 255) for i in hsv_to_rgb(hu, s, v))

def build_line(y, w, h, tol):
    """
    Build a whole line of the circle, minimising redundancy and encapsulating
    the line-buffering

    It prints unicode upper half-blocks. This means I can set the foreground for
    one colour and the background for another, doubling my effective vertical
    resolution.
    """
    # odd number of columns on purpose
    codes = groupby(
            ((get_rgb(x, y - 0.5, w, h, tol), get_rgb(x, y, w, h, tol))
                    for x in range(-w // 2, 1 + w // 2)))
    return "{}\x1b[0m".format("".join(
                "\x1b[38;2;{}m\x1b[48;2;{}m{}"
                    .format(";".join(map(str, top_rgb)),
                            ";".join(map(str, bot_rgb)),
                            "▀" * sum(1 for _ in grouper))
                    for (top_rgb, bot_rgb), grouper in codes))

def _p999(w, h, file):
    """
    Draw a colour wheel of w by h in `file`
    """
    # clear the screen
    print("\x1b[H\x1b[2J", end="", file=file)
    # the range from 1 within which to do antialiasing
    tol = sqrt((1 / w) ** 2 + (1 / (2 * h)) ** 2) / 2
    for y in range(-h // 2, 1 + h // 2):
        print(build_line(y, w, h, tol), file=file)

def p999(w, h):
    """
    A caching wrapper around _p999.
    """
    CACHE_DIR.mkdir(exist_ok=True, parents=True)
    cache_path = CACHE_DIR / "{}x{}.p999".format(w, h)
    if (not cache_path.exists() or
            getmtime(cache_path) < getmtime(__file__)):
        print("writing cache to {}".format(cache_path),
                file=sys.stderr, flush=True)
        with cache_path.open("w") as cache_file:
            _p999(w, h, cache_file)
    with cache_path.open("r") as cache_file:
        copyfileobj(cache_file, sys.stdout)

if __name__ == "__main__":
    w, h = (i // 2 * 2 for i in get_dimensions())
    p999(w, h)
