import subprocess
import re
import argparse
import threading
import tempfile
import shutil
import os
import sys
import binascii


def run_fuzz(fuzz_path, timeout, is_failed):
    try:
        temp_dir = tempfile.mkdtemp(dir="/dev/shm")
        with subprocess.Popen([fuzz_path, temp_dir]) as process:
            try:
                print("Running in process", process.pid)
                process.wait(timeout=timeout)
            except subprocess.TimeoutExpired:
                print("Timed out - killing", process.pid)
                process.kill()
                print(f"Done {fuzz_path}")

            if process.returncode:
                print("Abnormal fuzz:")
                with open(os.path.join(temp_dir, "seed.txt"), "r") as f:
                    seed = f.read()
                    print(seed + "\n")

                with open(os.path.join(temp_dir, "fuzz.wasm"), "rb") as f:
                    wasm = f.read()
                    print("Wasm module:")
                    print(binascii.hexlify(wasm, b" ") + "\n")
                is_failed[fuzz_path] = True

            failed_seeds_path = os.path.join(temp_dir, "failedseeds.txt")
            if os.path.exists(failed_seeds_path):
                with open(failed_seeds_path, "r") as f:
                    failedseeds = f.read()
                    print(failedseeds)
                print(f"Failed {fuzz_path}")
                is_failed[fuzz_path] = True
    except Exception as e:
        print(e)
        is_failed[fuzz_path] = True


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Run fuzz timeout.")
    parser.add_argument("--fuzz_path", help="fuzz binary path", nargs="+")
    parser.add_argument("--timeout", help="timeout", type=int, default=10)

    is_failed = {}

    args = parser.parse_args()
    threads = []
    for fuzz_path in args.fuzz_path:
        is_failed[fuzz_path] = False
        thread = threading.Thread(
            target=run_fuzz,
            args=(fuzz_path, args.timeout, is_failed),
        )
        thread.start()
        threads.append(thread)

    for thread in threads:
        thread.join()

    if True in is_failed.values():
        sys.exit(-1)
