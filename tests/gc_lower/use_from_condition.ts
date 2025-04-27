//! { "func": "^.*_start$" }

import { Normal } from "../common_lib/normal";

let v = 0;
export function _start(): Normal {
  let normal: Normal | null;
  if (v) {
    normal = new Normal();
  } else {
    normal = new Normal();
  }
  return normal;
}
