// Copyright (C) 2026 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

export interface ULEB128Result {
  value: number;
  nextOffset: number;
}

export function readULEB128(bytes: Uint8Array, offset: number): ULEB128Result {
  const startOffset = offset;
  let value = 0;
  let shift = 0;

  while (offset < bytes.byteLength) {
    const byte = bytes[offset++];
    value |= (byte & 0x7f) << shift;
    shift += 7;
    if ((byte & 0x80) === 0) {
      return { value: value >>> 0, nextOffset: offset };
    }
  }

  throw new Error(`ULEB128 read past end of buffer at offset ${startOffset}`);
}
