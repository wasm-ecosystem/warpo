// Copyright (C) 2026 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

export namespace ffi {
  // @ts-ignore: decorator
  @unsafe @external("as-builtin-fn", "set_ffi_closure_env")
  export declare function set_ffi_closure_env(value: i32): void;

  // @ts-ignore: decorator
  @unsafe @builtin
  export declare function multi_return_to_tuple<T>(value: MultiReturn<T>): T;

  // @ts-ignore: decorator
  @unmanaged
  export class MultiReturn<T> {}
}
