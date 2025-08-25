#!/usr/bin/python3
"""
This is a replacement version of ./qcc bash in python, just for backup
"""
import sys
import os
import wrapper_command

args = sys.argv[1:]

if "-o" in args:
    o_index = args.index("-o")

    out_file = args[o_index + 1]

    d_file = os.path.splitext(out_file)[0] + ".d"

    f = open(d_file, "w+")
    f.close()

wrapper_command.run_wrapper_command("qcc", args)
