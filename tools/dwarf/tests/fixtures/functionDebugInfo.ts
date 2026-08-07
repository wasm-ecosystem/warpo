// Copyright (C) 2026 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

// @ts-nocheck

let globalCount: i32 = 7;

export function compute(input: i32): i32 {
  const outer = input + 1;
  if (outer > 0) {
    const inner = outer + 2;
    return inner;
  }
  return outer;
}

export function withClosure(input: i32): i32 {
  const base = input + 3;
  const add = (delta: i32): i32 => {
    const captured = base + delta;
    return captured;
  };
  return add(4);
}

export function _start(): i32 {
  return compute(1) + withClosure(2) + globalCount;
}
