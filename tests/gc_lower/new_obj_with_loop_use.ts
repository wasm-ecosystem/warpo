//! { "func": "^.*_start$" }

import { Normal } from "../common_lib/normal";

let v = 0;
export function _start(): void {
  let normal: Normal | null = null;
  while (v) {
    let isExist = normal == null;
    normal = new Normal();
  }
}
