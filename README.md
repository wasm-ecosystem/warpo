# WARPO

wasm optimizer designed for wasm-compiler

## build

see [CONTRIBUTING](./CONTRIBUTING.md)

## repo structure

### for dev

- include: header files exposed to other components.
- tests: e2e test cases and scripts.

### major logic

- assemblyscript: code base of assemblyscript, modify from https://github.com/AssemblyScript/assemblyscript/.
- assemblyscript_extension: experimental functions for AS.
- common: function related common code, most of them are cli options.
- frontend: assemblyscript frontend compiler.
- passes: additional optimization passes.
  - passes/GC: lowering passes for GC related operation.
  - passes/helper: compilation and optimization related algorithm.
  - unittests: useful functions for ut.
- support: wasm unrelated common code, contains algorithm, ADT, os abstract layer...
