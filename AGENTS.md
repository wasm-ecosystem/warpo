# AGENTS.md for warpo project

warpo is a compiler project to compile TS-like language to WebAssembly.

Please follow these instructions after modifying the code.

## Basic instructions

- When create new **source code** file (exclude `./tests`), add following license header at the beginning of files.
  ```
  // Copyright (C) 2025 wasm-ecosystem
  // SPDX-License-Identifier: Apache-2.0
  ```

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
- When there is only a simple statement (such as return or break) in the if block, do not add braces.

## How to add test

- When C++ code changed, if needed, add unittest in the same file wrapped with `WARPO_ENABLE_UNIT_TESTS` macro.
- When add a new isolated module in assemblyscript or warpo_extension, add unit test in `tests/assemblyscript` or `tests/warpo_extension`.
- When debug / dwarf related thing changed, create a new test cases in `tests/DebugSymbol`.
- Those test cases will cost lots of time, please add them only when we don't have the other way to test.
  - When project level feature added, create a new test cases in `tests/driver`.
  - When the optimization pass is quite complex and rely on lots of frontend information, create a new test cases in `tests/snapshot_diff`.

## Docs

- When add new features in documents, add version and stability svg also.
  ```html
  <p style="display: flex; gap: 10px;">
    <img src="/version/nightly.svg" alt="nightly" />
    <img src="/stability/experimental.svg" alt="experimental" />
  </p>
  ```
- When add new features in documents, maintain the link in `docs/new_features.md`.
