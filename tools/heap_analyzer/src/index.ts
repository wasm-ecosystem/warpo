// Copyright (C) 2026 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

import { compareSnapshots } from "./comparison.js";
import { parseDumpFile } from "./dumpReader.js";
import { analyzeHeap } from "./snapshot.js";
import type { HeapComparison, HeapSnapshot } from "./types.js";

export function analyzeDump(dumpBuffer: ArrayBuffer, wasmBinary: Uint8Array | ArrayBuffer): HeapSnapshot {
  const dumpedMemory = parseDumpFile(dumpBuffer);
  return analyzeHeap(dumpedMemory.memory, dumpedMemory.rtGlobals, wasmBinary);
}

export function compareDumps(
  beforeDumpBuffer: ArrayBuffer,
  afterDumpBuffer: ArrayBuffer,
  wasmBinary: Uint8Array | ArrayBuffer
): HeapComparison {
  return compareSnapshots(analyzeDump(beforeDumpBuffer, wasmBinary), analyzeDump(afterDumpBuffer, wasmBinary));
}

export { analyzeHeap } from "./snapshot.js";
export { compareSnapshots } from "./comparison.js";
export { parseDumpFile } from "./dumpReader.js";
export type {
  BuiltinContainerKind,
  ClassField,
  ClassLayout,
  ComparisonInstance,
  ComparisonInstanceChangeKind,
  ConstructorComparisonEntry,
  ConstructorEntry,
  ConstructorInstance,
  DumpedMemory,
  EntryLayout,
  GlobalRoot,
  HeapComparison,
  HeapObject,
  HeapSnapshot,
  ObjectHeader,
  RootInfo,
  RootType,
  RuntimeGlobalValues,
} from "./types.js";
