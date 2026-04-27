export interface ObjectHeader {
  mmInfo: number;
  rtId: number;
  rtSize: number;
  payloadPtr: number; // Block address + BLOCK_OVERHEAD + OBJECT_OVERHEAD
  gcColor: number; // nextWithColor & COLOR_MASK
}

export interface RuntimeGlobals {
  dataEnd: number;
  heapBase: number;
  stackPointer: number;
}

export interface DumpedMemory {
  rtGlobals: RuntimeGlobals;
  memory: DataView;
}

export interface ClassField {
  name: string;
  offset: number;
  size: number;
  isReference: boolean;
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
  fields: ClassField[];
  templateType?: string;
  elementIsReference?: boolean;
  /** For Set/Map: describes the layout of entries inside the backing ArrayBuffer. */
  entryLayout?: EntryLayout;
}

export type RootType = "global" | "local" | "pinned" | "unknown";

export interface RootInfo {
  objectPtr: number; // payloadPtr of the referenced object
  className: string; // resolved class name
  rootType: RootType; // 'global' | 'local' | 'pinned'
  sourceAddress: number; // address where pointer was found (0 for pinned)
}

export interface HeapObject {
  address: number; // Payload pointer
  classId: number;
  className: string;
  shallowSize: number;
  retainedSize: number;
  rootType: RootType;
}

export interface SnapshotSummaryEntry {
  className: string;
  classId: number;
  count: number;
  totalShallowSize: number;
  totalRetainedSize: number;
}

export interface HeapSnapshot {
  objects: HeapObject[];
  summary: SnapshotSummaryEntry[];
  roots: RootInfo[];
  totalHeapSize: number;
  totalLiveSize: number;
  totalFreeSize: number;
  objectCount: number;
}
