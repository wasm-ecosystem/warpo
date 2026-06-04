// Copyright (C) 2026 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

import { getReferenceFields, isPointerfree, type ClassLayout, type EntryLayout, type ObjectHeader } from "./types.js";
import type { DebugInfoResolver } from "./debugInfoResolver.js";

function readValidPtr(memory: DataView, addr: number, validPtrs: Set<number>): number | null {
  if (addr + 4 > memory.byteLength) {
    return null;
  }
  const ptr = memory.getUint32(addr, true);
  if (ptr === 0 || !validPtrs.has(ptr)) {
    return null;
  }
  return ptr;
}

function scanReferenceFields(
  memory: DataView,
  obj: ObjectHeader,
  classLayout: ClassLayout,
  validPtrs: Set<number>,
  edges: number[]
): void {
  for (const field of getReferenceFields(classLayout)) {
    if (field.offset + field.size > obj.rtSize) {
      // Skip fields that don't fit within the object's size (could be a broken dumped memory or stale debug info)
      continue;
    }
    const ptr = readValidPtr(memory, obj.payloadPtr + field.offset, validPtrs);
    if (ptr !== null) {
      edges.push(ptr);
    }
  }
}

function scanArrayElements(memory: DataView, obj: ObjectHeader, validPtrs: Set<number>, edges: number[]): void {
  if (obj.rtSize < 16) {
    return;
  }
  const dataStart = memory.getUint32(obj.payloadPtr + 4, true);
  const length = memory.getUint32(obj.payloadPtr + 12, true);
  for (let i = 0; i < length; i++) {
    const ptr = readValidPtr(memory, dataStart + i * 4, validPtrs);
    if (ptr !== null) {
      edges.push(ptr);
    }
  }
}

function scanStaticArrayElements(memory: DataView, obj: ObjectHeader, validPtrs: Set<number>, edges: number[]): void {
  const elementCount = obj.rtSize >>> 2;
  for (let i = 0; i < elementCount; i++) {
    const ptr = readValidPtr(memory, obj.payloadPtr + i * 4, validPtrs);
    if (ptr !== null) {
      edges.push(ptr);
    }
  }
}

function scanSetMapEntries(
  memory: DataView,
  obj: ObjectHeader,
  entryLayout: EntryLayout,
  validPtrs: Set<number>,
  edges: number[]
): void {
  if (entryLayout.referenceOffsets.length === 0) {
    // No reference fields in entries, so we can skip scanning them entirely
    return;
  }
  if (obj.rtSize < 20) {
    // Set/Map objects should have at least 5 u32 fields in their payload.
    // Hitting this means the dump is truncated/corrupted, debug info is stale,
    // or the runtime layout no longer matches the hard-coded offsets below.
    return;
  }

  const entriesPtr = memory.getUint32(obj.payloadPtr + 8, true);
  const entriesOffset = memory.getInt32(obj.payloadPtr + 16, true);
  if (entriesPtr === 0 || !validPtrs.has(entriesPtr)) {
    return;
  }
  const lastReadableU32Addr = memory.byteLength - 4;

  for (let i = 0; i < entriesOffset; i++) {
    const entryBase = entriesPtr + i * entryLayout.size;
    const taggedNextAddr = entryBase + entryLayout.size - 4;
    if (taggedNextAddr > lastReadableU32Addr) {
      break;
    }
    const taggedNext = memory.getUint32(taggedNextAddr, true);
    if (taggedNext & 1) {
      continue;
    }

    for (const refOffset of entryLayout.referenceOffsets) {
      const ptr = readValidPtr(memory, entryBase + refOffset, validPtrs);
      if (ptr !== null) {
        edges.push(ptr);
      }
    }
  }
}

function scanSmallTupleElements(memory: DataView, obj: ObjectHeader, validPtrs: Set<number>, edges: number[]): void {
  const bitmapSize = 8;
  if (obj.rtSize <= bitmapSize) {
    // An empty SmallTuple has no element slots, only the trailing bitmap.
    // This also safely handles malformed dumps that are too small to contain elements.
    return;
  }
  const elementCount = (obj.rtSize - bitmapSize) >>> 2;
  const bitmapAddr = obj.payloadPtr + obj.rtSize - bitmapSize;
  const bitmap = memory.getBigUint64(bitmapAddr, true);

  for (let i = 0; i < elementCount; i++) {
    const isRef = (bitmap & (1n << BigInt(i))) !== 0n;
    if (!isRef) {
      continue;
    }
    const ptr = readValidPtr(memory, obj.payloadPtr + i * 4, validPtrs);
    if (ptr !== null) {
      edges.push(ptr);
    }
  }
}

function scanContainerElements(
  memory: DataView,
  obj: ObjectHeader,
  classLayout: ClassLayout,
  validPtrs: Set<number>,
  edges: number[]
): void {
  const name = classLayout.name;

  if (name.startsWith("~lib/array/Array<")) {
    scanArrayElements(memory, obj, validPtrs, edges);
    return;
  }

  if (name.startsWith("~lib/staticarray/StaticArray<")) {
    scanStaticArrayElements(memory, obj, validPtrs, edges);
    return;
  }

  if (name === "~lib/tuple/SmallTuple") {
    scanSmallTupleElements(memory, obj, validPtrs, edges);
    return;
  }

  if (classLayout.entryLayout) {
    scanSetMapEntries(memory, obj, classLayout.entryLayout, validPtrs, edges);
  }
}

/**
 * Scan object payloads to build a precise reference graph using debug info.
 *
 * @param memory Header-stripped DataView (wasm addr 0 = offset 0)
 * @param objects Parsed object headers from parseAllObjects
 * @param debugInfoResolver DebugInfoResolver built from debug info
 * @returns Adjacency list: payloadPtr → array of referenced payloadPtrs
 */
export function scanReferences(
  memory: DataView,
  objects: ObjectHeader[],
  debugInfoResolver: DebugInfoResolver
): Map<number, number[]> {
  const validPtrs = new Set(objects.map((o) => o.payloadPtr));
  const graph = new Map<number, number[]>();

  for (const obj of objects) {
    const edges: number[] = [];

    const classLayout = debugInfoResolver.getClassDef(obj.rtId);
    if (classLayout && !isPointerfree(classLayout)) {
      scanReferenceFields(memory, obj, classLayout, validPtrs, edges);
      scanContainerElements(memory, obj, classLayout, validPtrs, edges);
    }

    graph.set(obj.payloadPtr, edges);
  }

  return graph;
}
