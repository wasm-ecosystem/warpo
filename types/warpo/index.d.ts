/// <reference path="../../assemblyscript/std/assembly/index.d.ts" />

declare namespace utf8 {
  class ConstStr {
    toString(): string;
    get addr(): usize;
    get size(): u32;
  }
  function build(s: string): ConstStr;
}

declare module "rt/itcms" {
  export function __collect(): void;
}
