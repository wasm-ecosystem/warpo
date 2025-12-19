/// <reference path="../../assemblyscript/std/assembly/index.d.ts" />

declare module "rt/index" {
  export function __collect(): void;
}

declare module "utf8_const_str" {
  namespace utf8 {
    class ConstStr {
      toString(): string;
      get addr(): usize;
      get size(): u32;
    }
    function build(s: string): ConstStr;
  }
}
