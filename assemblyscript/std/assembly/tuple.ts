/// <reference path="./rt/index.d.ts" />

import { OBJECT, TOTAL_OVERHEAD } from "rt/common";

// @ts-ignore: decorator
@final export class SmallTuple {
  // | element 0 | element 1 | ... | element n | bitmap (u64) |
  // each element use 1 bit in bitmap to indicate its type:
  // 0 = non-reference
  // 1 = reference

  private __get<T>(offset: usize): T {
    const elementPtr = changetype<usize>(this) + offset;
    return load<T>(elementPtr);
  }

  private __set<T>(offset: usize, value: T): void {
    const elementPtr = changetype<usize>(this) + offset;
    store<T>(elementPtr, value);
    if (isReference<T>()) {
      __link(changetype<usize>(this), changetype<usize>(value), false);
    }
  }

  // RT integration
  private __visit(cookie: u32): void {
    const rtSize = <usize>changetype<OBJECT>(changetype<usize>(this) - TOTAL_OVERHEAD).rtSize;
    const bitmapSize = sizeof<u64>();
    const elementCount = (rtSize - bitmapSize) >>> alignof<usize>();
    let remaining = load<u64>(changetype<usize>(this) + rtSize - sizeof<u64>());
    while (remaining != 0) {
      const index = <usize>ctz(remaining);
      if (index >= elementCount) break;
      const elementPtr = changetype<usize>(this) + (index << alignof<usize>());
      __visit(changetype<usize>(load<usize>(elementPtr)), cookie);
      remaining &= remaining - 1; // Equals to remaining &= ~((<u64>1) << index)
    }
  }
}
