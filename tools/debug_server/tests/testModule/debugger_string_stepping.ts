// Copyright (C) 2026 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0
// @ts-nocheck

export function _start(): i32 {
  let message: string = "hello";
  let character: string = message.charAt(1);
  return character.length;
}
