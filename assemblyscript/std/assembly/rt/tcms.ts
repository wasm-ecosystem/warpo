import { BLOCK, BLOCK_OVERHEAD, OBJECT_OVERHEAD, OBJECT_MAXSIZE, TOTAL_OVERHEAD, DEBUG } from "./common";
import { E_ALLOCATION_TOO_LARGE, E_ALREADY_PINNED, E_NOT_PINNED } from "../util/error";

// === TCMS: A Two-Color Mark & Sweep garbage collector ===

// ╒═════════════╤══════════════ Colors ═══════════════════════════╕
// │ Color       │ Meaning                                         │
// ├─────────────┼─────────────────────────────────────────────────┤
// │ WHITE*      │ Unprocessed or Unreachable                      │
// │ BLACK*      │ Reachable                                       │
// │ TRANSPARENT │ Manually pinned (always reachable)              │
// └─────────────┴─────────────────────────────────────────────────┘
// * flipped between cycles

// @ts-ignore: decorator
@lazy let white = 0;
// @ts-ignore: decorator
@inline const transparent = 3;
// @ts-ignore: decorator
@inline const COLOR_MASK = 3;

/** Size in memory of all objects currently managed by the GC. */
// @ts-ignore: decorator
@lazy let total: usize = 0;

// @ts-ignore: decorator
@lazy let fromSpace = initLazy(changetype<Object>(memory.data(offsetof<Object>())));
// @ts-ignore: decorator
@lazy let toSpace = initLazy(changetype<Object>(memory.data(offsetof<Object>())));
// @ts-ignore: decorator
@lazy let pinSpace = initLazy(changetype<Object>(memory.data(offsetof<Object>())));

function initLazy(space: Object): Object {
  space.nextWithColor = changetype<usize>(space);
  space.prev = space;
  return space;
}

/** Visit cookie indicating scanning of an object. */
// @ts-ignore: decorator
@inline const VISIT_SCAN = 0;

// ╒═══════════════ Managed object layout (32-bit) ════════════════╕
//    3                   2                   1
//  1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0  bits
// ├─┴─┴─┴─┴─┴─┴─┴─┴─┴─┴─┴─┴─┴─┴─┴─┴─┴─┴─┴─┴─┴─┴─┴─┴─┴─┴─┴─┴─┴─┴─┴─┤
// │                      Memory manager block                     │
// ╞═══════════════════════════════════════════════════════════╤═══╡
// │                              next                         │ C │ = nextWithColor
// ├───────────────────────────────────────────────────────────┴───┤
// │                              prev                             │
// ├───────────────────────────────────────────────────────────────┤
// │                              rtId                             │
// ├───────────────────────────────────────────────────────────────┤
// │                              rtSize                           │
// ╞>ptr═══════════════════════════════════════════════════════════╡
// │                               ...                             │
// C: color

/** @ts-ignore: object. Represents a managed object in memory, consisting of a header followed by the object's data. */
@unmanaged class Object extends BLOCK {
  /** @ts-ignore:no initializer. Pointer to the next object with color flags stored in the alignment bits. */
  nextWithColor: usize; // *u32
  /** @ts-ignore:no initializer. Pointer to the previous object. */
  prev: Object; // *u32
  /** @ts-ignore:no initializer. Runtime id. */
  rtId: u32;
  /** @ts-ignore:no initializer. Runtime size. */
  rtSize: u32;

  /** Gets the pointer to the next object. */
  get next(): Object {
    return changetype<Object>(this.nextWithColor & ~COLOR_MASK);
  }

  /** Sets the pointer to the next object. */
  set next(obj: Object) {
    this.nextWithColor = changetype<usize>(obj) | (this.nextWithColor & COLOR_MASK);
  }

  /** Gets this object's color. */
  get color(): i32 {
    return i32(this.nextWithColor & COLOR_MASK);
  }

  /** Sets this object's color. */
  set color(color: i32) {
    this.nextWithColor = (this.nextWithColor & ~COLOR_MASK) | color;
  }

  /** Gets the size of this object in memory. */
  get size(): usize {
    return BLOCK_OVERHEAD + (this.mmInfo & ~3);
  }

  /** Unlinks this object from its list. */
  unlink(): void {
    let next = this.next;
    if (next == null) {
      if (DEBUG) assert(this.prev == null && changetype<usize>(this) < __heap_base);
      return; // static data not yet linked
    }
    let prev = this.prev;
    if (DEBUG) assert(prev);
    next.prev = prev;
    prev.next = next;
  }

  /** Links this object to the specified list, with the given color. */
  linkTo(list: Object, withColor: i32): void {
    let prev = list.prev;
    this.nextWithColor = changetype<usize>(list) | withColor;
    this.prev = prev;
    prev.next = this;
    list.prev = this;
  }
}

/** Frees an object. */
function free(obj: Object): void {
  if (changetype<usize>(obj) < __heap_base) {
    obj.nextWithColor = 0; // may become linked again
    obj.prev = changetype<Object>(0);
  } else {
    if (isDefined(ASC_GC_TESTING)) memory.fill(changetype<usize>(obj) + TOTAL_OVERHEAD, 0xde, obj.rtSize);
    total -= obj.size;
    __free(changetype<usize>(obj) + BLOCK_OVERHEAD);
  }
}

// Garbage collector interface

// @ts-ignore: decorator
@global @unsafe
export function __new(size: usize, id: i32): usize {
  if (size >= OBJECT_MAXSIZE) throw new Error(E_ALLOCATION_TOO_LARGE);
  if (total >= threshold) __collect();
  let obj = changetype<Object>(__alloc(OBJECT_OVERHEAD + size) - BLOCK_OVERHEAD);
  obj.rtId = id;
  obj.rtSize = <u32>size;
  obj.linkTo(fromSpace, white);
  total += obj.size;
  let ptr = changetype<usize>(obj) + TOTAL_OVERHEAD;
  // may be visited before being fully initialized, so must fill
  memory.fill(ptr, 0, size);
  return ptr;
}

// @ts-ignore: decorator
@global @unsafe
export function __renew(oldPtr: usize, size: usize): usize {
  let oldObj = changetype<Object>(oldPtr - TOTAL_OVERHEAD);
  // Update object size if its block is large enough
  if (size <= (oldObj.mmInfo & ~3) - OBJECT_OVERHEAD) {
    oldObj.rtSize = <u32>size;
    return oldPtr;
  }
  // we cannot reuse the old object anymore.
  // shadow stack may still contain references to it, so we must not free it yet.
  let newPtr = __new(size, oldObj.rtId);
  if (DEBUG) assert(size > oldObj.rtSize);
  memory.copy(newPtr, oldPtr, oldObj.rtSize);
  return newPtr;
}

// @ts-ignore: decorator
@global @unsafe
export function __link(parentPtr: usize, childPtr: usize, expectMultiple: bool): void {
  // nop
}

// @ts-ignore: decorator
@global @unsafe
export function __visit(ptr: usize, cookie: i32): void {
  if (!ptr) return;
  let obj = changetype<Object>(ptr - TOTAL_OVERHEAD);
  if (obj.color == white) {
    obj.unlink(); // from fromSpace
    obj.linkTo(toSpace, i32(!white));
  }
}

// @ts-ignore: decorator
@global @unsafe
export function __pin(ptr: usize): usize {
  if (ptr) {
    let obj = changetype<Object>(ptr - TOTAL_OVERHEAD);
    if (obj.color == transparent) {
      throw new Error(E_ALREADY_PINNED);
    }
    obj.unlink(); // from fromSpace
    obj.linkTo(pinSpace, transparent);
  }
  return ptr;
}

// @ts-ignore: decorator
@global @unsafe
export function __unpin(ptr: usize): void {
  if (!ptr) return;
  let obj = changetype<Object>(ptr - TOTAL_OVERHEAD);
  if (obj.color != transparent) {
    throw new Error(E_NOT_PINNED);
  }
  obj.unlink(); // from pinSpace
  obj.linkTo(fromSpace, white);
}

// Garbage collector automation

/** How often to interrupt. The default of 16384 means "interrupt each 16KiB allocated". */
// @ts-ignore: decorator
@inline const GRANULARITY: usize = isDefined(ASC_GC_GRANULARITY) ? ASC_GC_GRANULARITY : 16 * 1024;

/** Threshold of memory used by objects to exceed before interrupting again. */
// @ts-ignore: decorator
@lazy let threshold: usize = GRANULARITY;

/** Visits all objects on the stack. */
function visitStack(): void {
  let ptr = __stack_pointer;
  while (ptr < __heap_base) {
    __visit(load<usize>(ptr), VISIT_SCAN);
    ptr += sizeof<usize>();
  }
}

function visitPinned(): void {
  let pn = pinSpace;
  let iter: Object = pn.next;
  while (iter != pn) {
    __visit_members(changetype<usize>(iter) + TOTAL_OVERHEAD, VISIT_SCAN);
    iter = iter.next;
  }
}

// @ts-ignore: decorator
@global @unsafe
export function __collect(): void {
  const beforeTotal = total;

  __visit_globals(VISIT_SCAN);
  visitStack();
  visitPinned();

  let iter: Object;
  iter = toSpace.next;
  while (iter != toSpace) {
    if (DEBUG) assert(iter.color != white);
    __visit_members(changetype<usize>(iter) + TOTAL_OVERHEAD, VISIT_SCAN);
    // __visit will insert object at the end of toSpace, so we must advance after visiting.
    iter = iter.next;
  }

  // clean up fromSpace
  iter = fromSpace.next;
  while (iter != fromSpace) {
    const next = iter.next;
    free(iter);
    iter = next;
  }
  fromSpace.nextWithColor = changetype<usize>(fromSpace);
  fromSpace.prev = fromSpace;

  // Flip spaces and colors
  const tmp = fromSpace;
  fromSpace = toSpace;
  toSpace = tmp;
  white = i32(!white);

  const collected = beforeTotal - total;
  // when collected > GRANULARITY, we collect more objects than expect.
  // In this case increasing threshold will increase ram usage, otherwise we should increase threshold.
  // Then we will use roughtly real RAM usage + GRANULARITY totally.
  threshold = select(beforeTotal, beforeTotal + GRANULARITY, collected > GRANULARITY);
}
