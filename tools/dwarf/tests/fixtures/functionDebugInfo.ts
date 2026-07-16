// Copyright (C) 2026 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

// @ts-nocheck

export function compute(input: i32): i32 {
  const outer = input + 1;
  if (outer > 0) {
    const inner = outer + 2;
    return inner;
  }
  return outer;
}

export function _start(): i32 {
  return compute(1);
}
