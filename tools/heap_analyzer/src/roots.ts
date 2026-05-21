// Copyright (C) 2026 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

import { GC_COLOR_TRANSPARENT } from "./constants.js";
import type { ObjectHeader, RootInfo, RuntimeGlobals } from "./types.js";

/**
 * Identify GC roots that can be recovered reliably from the current dump model.
 *
 * Currently supported:
 * - shadow stack roots
 * - pinned objects (transparent GC color)
 *
 * Precise GC global-root detection is intentionally not implemented yet.
 * Scanning arbitrary words in the static region would misclassify incidental
 * pointer-like bytes from static strings or static arrays as semantic globals.
 */
export function findRoots(memory: DataView, rtGlobals: RuntimeGlobals, objects: ObjectHeader[]): RootInfo[] {
  const validPtrs = new Set(objects.map((obj) => obj.payloadPtr));
  const roots: RootInfo[] = [];

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
