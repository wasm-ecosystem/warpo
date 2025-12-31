/// <reference path="../../assemblyscript/std/assembly/index.d.ts" />

declare module "rt/index" {
  // allocate new object with size and rtid
  function __new(size: usize, id: u32): usize;
  // re-allocate a object
  function __renew(ptr: usize, size: usize): usize;
  // insert write barrier (only useful for incremental runtime)
  function __link(parentPtr: usize, childPtr: usize, expectMultiple: bool): void;
  // trigger full GC manually
  function __collect(): void;
  // pin an object to prevent being garbage collected
  function __pin(ptr: usize): usize;
  // cancel the pin operation
  function __unpin(ptr: usize): void;
}

declare module "warpo/utf8/const_str" {
  class ConstStr {
    toString(): string;
    get addr(): usize;
    get size(): u32;
  }
  function build(s: string): ConstStr;
}
