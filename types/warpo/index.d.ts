/// <reference path="../../assemblyscript/std/assembly/index.d.ts" />

declare module "rt/index" {
  export function __collect(): void;
}

declare module "warpo/utf8/const_str" {
  class ConstStr {
    toString(): string;
    get addr(): usize;
    get size(): u32;
  }
  function build(s: string): ConstStr;
}
