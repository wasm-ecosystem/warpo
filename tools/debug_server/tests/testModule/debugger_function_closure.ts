// Copyright (C) 2026 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0
// @ts-nocheck

class C10 {
  a: i32 = 5;
}

function outer(a: i32): () => i32 {
  let c = new C10();
  c.a += a;
  const inner = (): i32 => {
    return a + 1 + c.a;
  };
  return inner;
}

export function _start(): i32 {
  const f1 = outer(5);
  const f2 = outer(10);

  const res = f1() + f2();
  return res;
}
