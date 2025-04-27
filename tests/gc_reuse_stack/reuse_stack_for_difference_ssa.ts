//! { "func": "^.*_start$" }

import { Normal } from "../common_lib/normal";

function foo(v: Normal): void {}

export function _start(): void {
  {
    let v0 = new Normal();
    foo(v0);
  }
  {
    let v1 = new Normal();
    foo(v1);
  }
}
