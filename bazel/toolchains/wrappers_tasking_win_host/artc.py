import sys
import os
import subprocess


def append_artc_argument(artc_args, arg):
    if arg == "rcsD":
        artc_args.append("-r")
    else:
        artc_args.append(arg)


def read_file_as_arguments(artc_args, file_path):
    argument_file = open(file_path)

    argument_lines = argument_file.readlines()

    argument_file.close()

    for arg in argument_lines:
        append_artc_argument(artc_args, arg[:-1])


artc_args = ["artc"]

for i in range(1, len(sys.argv)):
    arg = sys.argv[i]
    if arg.startswith("@"):
        read_file_as_arguments(artc_args, arg[1:])
    else:
        append_artc_argument(artc_args, arg)

subprocess.run(
    artc_args, env=os.environ, stdout=sys.stdout, stderr=sys.stderr, check=True
)
