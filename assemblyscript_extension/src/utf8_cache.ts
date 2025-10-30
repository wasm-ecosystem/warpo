// Copyright (C) 2024 Bayerische Motoren Werke Aktiengesellschaft (BMW AG)
// Copyright (C) 2025 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

import { Compiler } from "../../assemblyscript/src/compiler";
import { Class, Program } from "../../assemblyscript/src/program";

class Utf8Cache {
  cache: Map<string, i32> = new Map();

  constructor(
    private constStrClass: Class,
    private compiler: Compiler,
    private program: Program
  ) {}
  ensure(str: string): i32 {
    const cache = this.cache;
    if (cache.has(str)) return cache.get(str);
    let stringBuf = Uint8Array.wrap(String.UTF8.encode(str, /* nullTerminated= */ false));
    const totalOverhead = <usize>this.program.totalOverhead;
    let buf = this.constStrClass.createBuffer(stringBuf.length);
    memory.copy(totalOverhead + buf.dataStart, stringBuf.dataStart, stringBuf.length);
    const stringPtr = <i32>this.compiler.addRuntimeMemorySegment(buf).offset + <i32>totalOverhead;
    cache.set(str, stringPtr);
    return stringPtr;
  }
}

let utf8Cache: Utf8Cache | null = null;
export function getUtf8Cache(constStrClass: Class, compiler: Compiler, program: Program): Utf8Cache {
  if (utf8Cache == null) utf8Cache = new Utf8Cache(constStrClass, compiler, program);
  return utf8Cache as Utf8Cache;
}
