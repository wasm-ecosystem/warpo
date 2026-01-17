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
    const elemntCount = (rtSize - bitmapSize) >>> alignof<usize>();
    const bitmap = load<u64>(changetype<usize>(this) + rtSize - sizeof<u64>());
    for (let i: usize = 0; i < elemntCount; ++i) {
      if ((bitmap & ((<u64>1) << (<u64>i))) != 0) {
        const elementPtr = changetype<usize>(this) + (i << alignof<usize>());
        __visit(changetype<usize>(load<usize>(elementPtr)), cookie);
      }
    }
  }
}
