from typing import Any, cast
import wasmtime

store = wasmtime.Store()
# https://github.com/wasm-ecosystem/wasm-dwarf-lib
module = wasmtime.Module.from_file(store.engine, "scripts/wasm_dwarf_lib.wasm")
instance = wasmtime.Instance(store, module, [])
exports = instance.exports(store)
linear_memory = cast(wasmtime.Memory, exports["memory"])


def call_func(func_name: str, *args: Any) -> Any:
    return cast(wasmtime.Func, exports[func_name])(store, *args)


def read_from_linear_memory(ptr: int, size: int) -> bytes:
    linear_memory = cast(wasmtime.Memory, exports["memory"])
    l = []
    for i in range(size):
        l.append(linear_memory.data_ptr(store)[ptr + i])
    return bytes(l)


def write_to_linear_memory(ptr: int, data: bytes) -> None:
    linear_memory = cast(wasmtime.Memory, exports["memory"])
    for i in range(len(data)):
        linear_memory.data_ptr(store)[ptr + i] = data[i]


class DWO:
    def __init__(self, bin: bytes):
        self.bin = bin
        self.dwo = None

    def __enter__(self) -> int:
        dwarf_ptr = call_func("cabi_realloc", 0, 0, 4, len(self.bin))
        write_to_linear_memory(dwarf_ptr, self.bin)
        self.dwo = call_func("dwo-create", dwarf_ptr, len(self.bin))
        return self.dwo

    def __exit__(self, exc_type, exc_val, exc_tb):
        call_func("dwo-destroy", self.dwo)


def get_wasm_wat_mapping(binary: bytes) -> str:
    with DWO(binary) as dwo:
        json_struct_ptr = call_func("dwo-get-line-map", dwo)
        json_ptr = int.from_bytes(read_from_linear_memory(json_struct_ptr, 4), "little")
        json_length = int.from_bytes(
            read_from_linear_memory(json_struct_ptr + 4, 4), "little"
        )
        debug_line = read_from_linear_memory(json_ptr, json_length).decode("utf-8")
        call_func("cabi_post_dwo-get-line-map", json_struct_ptr)
    return debug_line
