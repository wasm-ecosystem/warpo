Currently debug symbols has two parts:
1. typescript source map file, which represents the mapping between source code and bytecode, this part is carried over from assemblyscript
2. Dwarf, which represents the class information, variable information.
They are in following Wasm custom sections sections.
debug_info
debug_abbrev
debug_str


Detailed dwarf debug symbol is [here](./debugSymbol.excalidraw.svg)