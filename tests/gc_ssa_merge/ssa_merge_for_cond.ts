//! { "func": "^.*_start$" }

import { Normal } from "../common_lib/normal";

function foo(v: Normal | null): void {}
let g = 0;

export function _start(): void {
  let v: Normal | null = null;
  if (g) {
    v = new Normal();
  }
  foo(v);
}
