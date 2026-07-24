// Copyright (C) 2026 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

import type { ClassField, ClassLayout } from "../../dwarf/classDebugInfo.js";
export { BuiltinContainerKind } from "../../dwarf/classDebugInfo.js";
export type { ClassField, ClassLayout, EntryLayout } from "../../dwarf/classDebugInfo.js";

export interface ObjectHeader {
  mmInfo: number;
  rtId: number;
  rtSize: number;
  payloadPtr: number; // Block address + BLOCK_OVERHEAD + OBJECT_OVERHEAD
  gcColor: number; // nextWithColor & COLOR_MASK
}

/** Runtime-captured values for the globals tracked in the dump header. */
export interface RuntimeGlobalValues {
  dataEnd: number;
  heapBase: number;
  stackPointer: number;
  /** Serialized values of mutable i32 wasm globals in module order. */
  mutableI32GlobalValues: number[];
}

export interface GlobalRoot {
  name: string;
  className: string;
  globalIndex: number;
  value: number;
}

export interface DumpedMemory {
  rtGlobals: RuntimeGlobalValues;
  memory: DataView;
}

export function isPointerfree(classLayout: ClassLayout): boolean {
  if (classLayout.templateTypeIsReference === true) {
    return false;
  }

  for (const field of classLayout.fields) {
    if (field.isReference) {
      return false;
    }
  }

  return true;
}

export function getReferenceFields(classLayout: ClassLayout): ClassField[] {
  return classLayout.fields.filter((field) => field.isReference);
}

export type RootType = "global" | "local" | "pinned";

export interface RootInfo {
  objectPtr: number; // payloadPtr of the referenced object
  className: string; // resolved class name
  rootType: RootType;
  sourceAddress: number; // stack address, wasm global index, or 0 for pinned
}

export interface HeapObject {
  address: number; // Payload pointer
  classId: number;
  className: string;
  shallowSize: number;
  retainedSize: number;
}

export interface ConstructorInstance {
  address: number;
  shallowSize: number;
  retainedSize: number;
}

export interface ConstructorEntry {
  className: string;
  count: number;
  totalShallowSize: number;
  totalRetainedSize: number;
  instances: ConstructorInstance[];
}

export type ComparisonInstanceChangeKind = "new" | "delete";

export interface ComparisonInstance extends ConstructorInstance {
  changeKind: ComparisonInstanceChangeKind;
}

export interface ConstructorComparisonEntry {
  className: string;
  newCount: number;
  deletedCount: number;
  countDelta: number;
  allocatedSize: number;
  freedSize: number;
  sizeDelta: number;
  instances: ComparisonInstance[];
}

export interface HeapSnapshot {
  constructors: ConstructorEntry[];
  totalHeapSize: number;
  totalLiveSize: number;
}

export interface HeapComparison {
  beforeTotalHeapSize: number;
  afterTotalHeapSize: number;
  totalHeapSizeDelta: number;
  beforeTotalLiveSize: number;
  afterTotalLiveSize: number;
  totalLiveSizeDelta: number;
  constructors: ConstructorComparisonEntry[];
}
