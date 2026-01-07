//! { "func": "^.*_start$" }

import { Normal } from "../../common_lib/normal";
import { __collect } from "rt/index";

const a: Normal = new Normal();

function bar(a: Normal, b: Normal): void {
  __collect();
}

export function _start(): void {
  bar(a, a);
}
