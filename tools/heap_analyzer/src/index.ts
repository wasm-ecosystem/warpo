// Copyright (C) 2026 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

import { parseDumpFile } from "./dumpReader.js";
import { analyzeHeap } from "./snapshot.js";
import type { HeapSnapshot } from "./types.js";

export function analyzeDump(dumpBuffer: ArrayBuffer, wasmBinary: Uint8Array | ArrayBuffer): HeapSnapshot {
  const dumpedMemory = parseDumpFile(dumpBuffer);
  return analyzeHeap(dumpedMemory.memory, dumpedMemory.rtGlobals, wasmBinary);
}

export { analyzeHeap } from "./snapshot.js";
export { parseDumpFile } from "./dumpReader.js";
export type {
  BuiltinContainerKind,
  ClassField,
  ClassLayout,
  DumpedMemory,
  EntryLayout,
  GlobalRoot,
  HeapObject,
  HeapSnapshot,
  ObjectHeader,
  RootInfo,
  RootType,
  RuntimeGlobalValues,
  SnapshotSummaryEntry,
} from "./types.js";
