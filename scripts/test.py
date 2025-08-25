# - name: codegen test
#   shell: bash
#   run: python3 scripts/code_gen_test.py --no-color
# - name: debug info test
#   shell: bash
#   run: python3 scripts/debug_info_gen_test.py --no-color
import os
import argparse

parser = argparse.ArgumentParser()
parser.add_argument(
    "--no-color", action="store_false", dest="color", help="Disable color output"
)

args = parser.parse_args()

has_color = "" if args.color else " --no-color"

if os.system(f"python3 scripts/code_gen_test.py {has_color}") != 0:
    print("Code generation test failed.")
    exit(1)
if os.system(f"python3 scripts/debug_info_gen_test.py {has_color}") != 0:
    print("Debug info generation test failed.")
    exit(1)
