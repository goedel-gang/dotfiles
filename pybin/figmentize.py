#!/usr/bin/env python3

# ___________.__    ____                           __   .__
# \_   _____/|__|  / ___\  _____    ____    ____ _/  |_ |__|________  ____
#  |    __)  |  | / /_/  >/     \ _/ __ \  /    \\   __\|  |\___   /_/ __ \
#  |     \   |  | \___  /|  Y Y  \\  ___/ |   |  \|  |  |  | /    / \  ___/
#  \___  /   |__|/_____/ |__|_|  / \___  >|___|  /|__|  |__|/_____ \ \___  >
#      \/                      \/      \/      \/                 \/     \/
# FIGMENTIZE: Figmentize

# FIGMENTOFF
# FIGMENTIZE: should not happen

"""
This is a script I've written to automatically insert figlet ASCII art headers
into config files. This allows me to easily maintain a unified config file
header system, and whimsically switch between fonts.

It searches for tags like the one at the top of this file. Note that it will
replace the entire paragraph that the tag is in, so make sure that the tag has
an empty line either side of it.

If you have managed to destroy your files with this script, it should have saved
backups in ~/.figmentize/backup.
"""

import re
import shlex
import itertools
import subprocess
# needs Python 3.5+
try:
    subprocess.run
except NameError:
    sys.exit("Geriatric snake? Get with the times")

import collections
import functools

import sys
import time
import pathlib
import os.path
import json

def get_figlet_default():
    """
    Get figlet's default font directory
    """
    figlet = subprocess.run(["figlet", "-I", "2"],
            check=True, stdout=subprocess.PIPE)
    return figlet.stdout.decode().strip()

# directory to store backup files in, relative to $HOME.
BACKUP_DIR = pathlib.Path.home() / ".figmentize" / "backup"
# location of the figmentizerc file
CONFIG_FILE = pathlib.Path.home() / ".figmentize" / "figmentizerc.json"
DEFAULT_CONFIG = {
        # by default, kern and disable wrapping.
        # TODO: this wrap width seems to work, and if you go much larger it
        #       doesn't. Why?
        "flags": ["-k", "-w", "10000"],
        "font": "standard",
        "dir": get_figlet_default()}

def get_config():
    """
    Read the figmentizerc (located at CONFIG) to obtain default parameters.
    If it doesn't exist, write it with the defaults.
    """
    if not CONFIG_FILE.exists():
        write_defaults(CONFIG_FILE.open("w"))
        return DEFAULT_CONFIG
    with CONFIG_FILE.open("r") as figmentizerc:
        return json.load(figmentizerc)

def write_defaults(file):
    """
    Write default configuration to a file. (as pretty printed json)
    """
    print("writing default config to {}".format(file.name), file=sys.stderr)
    with file:
        json.dump(DEFAULT_CONFIG, file, indent=4)

def dir_arg(s):
    """
    Check if an argparse argument is a valid directory
    """
    if not os.path.isdir(s):
        raise ValueError("Invalid directory: {!r}".format(s))
    return s

def get_args():
    """
    Process argv
    """
    import smartparse as argparse

    config = get_config()
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("file", type=argparse.FileType("r"),
            help="File to process")
    parser.add_argument("--font", type=str, default=config["font"],
            help="Figlet font to use")
    parser.add_argument("--dir", type=dir_arg,
            default=pathlib.Path(config["dir"]).expanduser(),
            help="Font directory to use")
    parser.add_argument("--flags", type=str,
            default=config["flags"],
            help="Figlet flags to use")
    parser.add_argument("--exec", type=str, nargs="+",
            help="Alternative command to run - overrides any figlet config")
    parser.add_argument("--nobackup", dest="backup", action="store_false",
            help="Don't make backups (not recommended)")
    parser.add_argument("--nooverwrite", dest="overwrite", action="store_false",
            help=("Don't overwrite the file, instead write the modified file to"
                  " stdout. For testing purposes mostly."))
    return parser.parse_args()

def make_command(args):
    """
    Make a constructor shell command from the given arguments
    """
    if args.exec:
        return args.exec
    return ["figlet", *args.flags, "-d", args.dir, "-f", args.font]

def read_pars(file):
    """
    Read paragraphs from file
    """
    contents = file.read()
    return contents.split("\n\n"), contents

def roll(iterable, n):
    """
    slide a window of width n across an iterable
    """
    it = iter(iterable)
    window = collections.deque(itertools.islice(it, n), maxlen=n)
    yield window
    for i in it:
        window.append(i)
        yield window

# TODO: add support for flag/command overrides in a figmentize indicator
#       automatically insert the file name from %?
def match_head_par(par):
    """
    Check to see if the paragraph has a figlet heading indicator (that looks
    like the one at the top of this file)

    Use this reduce rather than just any() because I want to get back the truthy
    value itself (which is a match object) rather than the truthy value coerced
    to a boolean.
    """
    return functools.reduce(lambda a, b: a or b,
            (re.match("(.*?)FIGMENTI[ZS]E:\\s*['\"]?(.*?)['\"]?\\s*$", line)
                for prev, line in roll(itertools.chain([""], par.split("\n")),
                                       2)
                if "FIGMENTOFF" not in prev),
            False)

def make_head(prefix, head, command, indicator):
    """
    Create an ASCII header given its text, a prefix, and a constructor shell
    command
    """
    run = [*command, head]
    print("running $ {}".format(" ".join(shlex.quote(str(i)) for i in run)),
            file=sys.stderr)
    figlet = subprocess.run(run, check=True, stdout=subprocess.PIPE)
    return "\n".join(itertools.chain(
        ("{}{}".format(prefix, line).rstrip() for line in
            figlet.stdout.decode().rstrip().split("\n")
            if line.strip()),
        (indicator,)))

def process_file(file, command, backup, overwrite):
    """
    Process some file, replacing all heading indicator tags with ascii headers
    """
    print("Processing {}".format(file.name))
    with file:
        pars, contents = read_pars(file)
    output = []
    modified = False
    for par in pars:
        match = match_head_par(par)
        if match:
            modified = True
            prefix = match.group(1)
            head = match.group(2)
            indicator = match.group(0)
            output.append(make_head(prefix, head, command, indicator))
        else:
            output.append(par)
    if modified:
        if backup:
            make_backup(os.path.abspath(file.name), contents)
        if overwrite:
            file = open(file.name, "w")
        else:
            file = sys.stdout
        # TODO: this is a little dangerous as it can close stdout. Might lead to
        #       bugs
        with file:
            file.write("\n\n".join(output))

def escape(filename):
    """
    Add a timestamp to a filename
    """
    return filename.parent / ("{}.{}.backup".format(filename.name, time.time()))

def make_backup(filename, contents):
    """
    Make a backup of a file
    """
    # make the file path non-absolute in order to join it
    backup_path = escape(BACKUP_DIR
                       / (pathlib.Path(filename)
                          .relative_to(pathlib.Path().absolute().root)))
    backup_path.parent.mkdir(parents=True, exist_ok=True)
    print("writing backup to {!s}".format(backup_path), file=sys.stderr)
    with backup_path.open("w") as backup_file:
        backup_file.write(contents)

if __name__ == "__main__":
    args = get_args()
    command = make_command(args)
    process_file(args.file, command, args.backup, args.overwrite)
