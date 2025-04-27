//! { "func": "^.*_start$" }

import { Normal } from "../common_lib/normal";

function foo(v: Normal): void {}

export function _start(): void {
  let normal = new Normal();
  foo(normal);
}
