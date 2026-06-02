// Copyright (C) 2026 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

import { GC_COLOR_TRANSPARENT } from "./constants.js";
import type { GlobalRoot, ObjectHeader, RootInfo, RuntimeGlobals } from "./types.js";

/**
 * Identify GC roots that can be recovered reliably from the current dump model.
 *
 * Currently supported:
 * - GC globals identified from DWARF + wasm global metadata
 * - shadow stack roots
 * - pinned objects (transparent GC color)
 */
export function findRoots(
  memory: DataView,
  rtGlobals: RuntimeGlobals,
  objects: ObjectHeader[],
  globalRoots: GlobalRoot[] = []
): RootInfo[] {
  const validPtrs = new Set(objects.map((obj) => obj.payloadPtr));
  const roots: RootInfo[] = [];

  for (const globalRoot of globalRoots) {
    if (globalRoot.value !== 0 && validPtrs.has(globalRoot.value)) {
      roots.push({
        objectPtr: globalRoot.value,
        className: "",
        rootType: "global",
        sourceAddress: globalRoot.globalIndex,
      });
    }
  }

  // Shadow stack in incremental runtime contains managed object pointers.
  for (let addr = rtGlobals.stackPointer; addr < rtGlobals.heapBase; addr += 4) {
    if (addr + 4 > memory.byteLength) {
      break;
    }

    const ptr = memory.getUint32(addr, true);
    if (ptr !== 0 && validPtrs.has(ptr)) {
      roots.push({
        objectPtr: ptr,
        className: "",
        rootType: "local",
        sourceAddress: addr,
      });
    }
  }

  for (const obj of objects) {
    if (obj.gcColor === GC_COLOR_TRANSPARENT) {
      roots.push({
        objectPtr: obj.payloadPtr,
        className: "",
        rootType: "pinned",
        sourceAddress: 0,
      });
    }
  }

  return roots;
}
