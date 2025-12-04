// This file is shared with the compiler and must remain portable

/** Runtime types. */
export enum Runtime {
  /** simple bump allocator without GC. */
  Stub = 0,
  /** radical GC with stopping the world. */
  Radical = 1,
  /** incremental GC. */
  Incremental = 2,
}
