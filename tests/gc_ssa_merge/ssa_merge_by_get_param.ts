//! { "func": "^.*_start$" }

import { Normal } from "../common_lib/normal";

function foo(v: Normal): void {}

export function _start(v: Normal): void {
  foo(v);
}
