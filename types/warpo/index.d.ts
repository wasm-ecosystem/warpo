/// <reference path="../../assemblyscript/std/assembly/index.d.ts" />

declare namespace utf8 {
  class ConstStr {
    toString(): string;
    get addr(): usize;
    get size(): u32;
  }
  function build(s: string): ConstStr;
}

declare module "rt/index" {
  export function __collect(): void;
}
