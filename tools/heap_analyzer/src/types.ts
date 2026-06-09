// Copyright (C) 2026 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

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

export interface ClassField {
  name: string;
  offset: number;
  size: number;
  isReference: boolean;
}

export enum BuiltinContainerKind {
  Array,
  StaticArray,
  MapOrSet,
  SmallTuple,
  Function,
}

/** Layout of a single entry in a Set or Map's entries ArrayBuffer. */
export interface EntryLayout {
  /** Total byte size of one entry (stride). */
  size: number;
  /** Fields within the entry that are managed references. */
  referenceOffsets: number[];
}

export interface ClassLayout {
  rtid: number;
  name: string;
  base: string | null;
  byteSize: number;
  fields: ClassField[];
  builtinKind?: BuiltinContainerKind;
  templateType?: string;
  templateTypeIsReference?: boolean;
  /** For Set/Map: describes the layout of entries inside the backing ArrayBuffer. */
  entryLayout?: EntryLayout;
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
  rootType: RootType;
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

export interface HeapSnapshot {
  constructors: ConstructorEntry[];
  totalHeapSize: number;
  totalLiveSize: number;
}
