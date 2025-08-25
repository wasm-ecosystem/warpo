# @copyright Copyright (C) 2025 BMW Group

import subprocess


def wat_to_wasm(*, path: str | None = None, wat: bytes | None = None) -> bytes:
    """
    generate wasm binary from wat file or wat string
    """
    if path is not None:
        assert wat is None
        proc = subprocess.run(
            f"wasm-tools parse --generate-dwarf=lines -o /dev/stdout '{path}'",
            shell=True,
            stdout=subprocess.PIPE,
            stderr=subprocess.PIPE,
        )
        if proc.returncode != 0:
            raise Exception(proc.stderr.decode())
        return proc.stdout
    elif wat is not None:
        assert path is None
        proc = subprocess.run(
            f"wasm-tools parse --generate-dwarf=lines -o /dev/stdout /dev/stdin",
            shell=True,
            stdout=subprocess.PIPE,
            stderr=subprocess.PIPE,
            input=wat,
        )
        if proc.returncode != 0:
            raise Exception(proc.stderr.decode())
        return proc.stdout
    else:
        assert False


def load_wasm_or_wat(path: str) -> bytes:
    """
    load wasm binary from path
    """
    if path.endswith(".wasm"):
        with open(path, "rb") as f:
            return f.read()
    elif path.endswith(".wat"):
        return wat_to_wasm(path=path)
    else:
        raise Exception("Invalid wasm extension")
