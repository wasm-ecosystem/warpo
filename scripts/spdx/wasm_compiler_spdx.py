from BerkeleySoftFloatSPDX import BerkeleySoftFloatSPDX
import os
import argparse

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Process spdx generate args.")
    parser.add_argument(
        "-o", "--output_dir", type=str, help="output spdx file dir", default=os.getcwd()
    )
    args = parser.parse_args()
    berkeley_soft_float_spdx_creator = BerkeleySoftFloatSPDX(args.output_dir)
    berkeley_soft_float_spdx_creator.create_spdx_file()
