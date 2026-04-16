export enum TypeinfoFlags {
  NONE = 0,
  ARRAYBUFFERVIEW = 1 << 0,
  ARRAY = 1 << 1,
  STATICARRAY = 1 << 2,
  SET = 1 << 3,
  MAP = 1 << 4,
  POINTERFREE = 1 << 10,
  VALUE_ALIGN_0 = 1 << 11,
  VALUE_ALIGN_1 = 1 << 12,
  VALUE_ALIGN_2 = 1 << 13,
  VALUE_ALIGN_3 = 1 << 14,
  VALUE_ALIGN_4 = 1 << 15,
  VALUE_SIGNED = 1 << 16,
  VALUE_FLOAT = 1 << 17,
  VALUE_MANAGED = 1 << 18,
  VALUE_NULLABLE = 1 << 19,
  KEY_ALIGN_0 = 1 << 20,
  KEY_ALIGN_1 = 1 << 21,
  KEY_ALIGN_2 = 1 << 22,
  KEY_ALIGN_3 = 1 << 23,
  KEY_ALIGN_4 = 1 << 24,
  KEY_SIGNED = 1 << 25,
  KEY_FLOAT = 1 << 26,
  KEY_MANAGED = 1 << 27,
  KEY_NULLABLE = 1 << 28,
}

export interface ObjectHeader {
  mmInfo: number;
  rtId: number;
  rtSize: number;
  payloadPtr: number; // Block address + BLOCK_OVERHEAD + OBJECT_OVERHEAD
  gcColor: number; // nextWithColor & COLOR_MASK
}

export interface DumpMetadata {
  dataEnd: number;
  heapBase: number;
  stackPointer: number;
}

export interface ParsedDump {
  metadata: DumpMetadata;
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

export interface ClassDef {
  rtid: number;
  name: string;
  base: string | null;
  fields: ClassField[];
  templateType?: string;
  elementIsReference?: boolean;
  /** For Set/Map: describes the layout of entries inside the backing ArrayBuffer. */
  entryLayout?: EntryLayout;
}

export interface DebugInfo {
  version: number;
  classes: ClassDef[];
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
