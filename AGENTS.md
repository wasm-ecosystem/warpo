# AGENTS.md for warpo project

warpo is a compiler project to compile TS-like language to WebAssembly.

Please follow these instructions after modifying the code.

## Build instructions

- After changing the code, run `npm run build` to make sure project can be built.

## Test instructions

- When the change is not related to generated WebAssembly or DWARF, run `npm run test`.
- When the change is related to generated WebAssembly or DWARF, run `npm run test:update`.

## Quality instructions

- Don't write meaningless comments.
- After changing the C++ code, please use clang-tidy to check code quality. The database file is located in `build` folder.</br>
  Example command is `clang-tidy -p build <file>`.
- Prefer to use east const style.
- Don't touch all files in `third_party` folder.
