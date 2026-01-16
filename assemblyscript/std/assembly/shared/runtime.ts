// This file is shared with the compiler and must remain portable

/** Runtime types. */
export enum Runtime {
  /** radical GC with stopping the world. */
  Radical = 1,
  /** incremental GC. */
  Incremental = 2,
}
