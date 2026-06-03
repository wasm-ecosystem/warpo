// Copyright (C) 2026 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

import { DUMP_MAGIC, DUMP_VERSION, DUMP_HEADER_SIZE } from "./constants.js";
import { DumpedMemory } from "./types.js";

export function parseDumpFile(buffer: ArrayBuffer): DumpedMemory {
  if (buffer.byteLength < DUMP_HEADER_SIZE) {
    throw new Error(`Dump file too small: expected at least ${DUMP_HEADER_SIZE} bytes, got ${buffer.byteLength}`);
  }

  const view = new DataView(buffer);

  const magic = view.getUint32(0, true);
  if (magic !== DUMP_MAGIC) {
    throw new Error(
      `Invalid dump magic: expected 0x${DUMP_MAGIC.toString(16).toUpperCase()}, got 0x${magic.toString(16).toUpperCase()}`
    );
  }

  const version = view.getUint32(4, true);
  if (version !== DUMP_VERSION) {
    throw new Error(`Unsupported dump version: expected ${DUMP_VERSION}, got ${version}`);
  }

  const dataEnd = view.getUint32(8, true);
  const heapBase = view.getUint32(12, true);
  const stackPointer = view.getUint32(16, true);
  const numMutableI32GlobalValues = view.getUint32(20, true);
  const memoryOffset = DUMP_HEADER_SIZE + numMutableI32GlobalValues * 4;

  if (buffer.byteLength < memoryOffset) {
    throw new Error(
      `Dump file too small for ${numMutableI32GlobalValues} mutable i32 global values: expected at least ${memoryOffset} bytes, got ${buffer.byteLength}`
    );
  }

  const mutableI32GlobalValues = new Array<number>(numMutableI32GlobalValues);
  for (let index = 0; index < numMutableI32GlobalValues; index++) {
    mutableI32GlobalValues[index] = view.getUint32(DUMP_HEADER_SIZE + index * 4, true);
  }

  return {
    rtGlobals: { dataEnd, heapBase, stackPointer, mutableI32GlobalValues },
    memory: new DataView(buffer, memoryOffset),
  };
}
