// Copyright (C) 2025 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

// This file is shared with the compiler and must remain portable

/** Host APIs. */
export enum Host {
  /** No host APIs. */
  None = 0,
  /** WASI Snapshot Preview 1. */
  WasiSnapshotPreview1 = 1,
}
