// Copyright (C) 2026 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0
// @ts-nocheck

function outer(a: i32): () => i32 {
  let b = a + 2;
  return (): i32 => b;
}

export function main(): i32 {
  const f = outer(1);
  return f();
}
