//! { "func": "^.*_start$" }

import { Normal } from "../common_lib/normal";

let v = 0;
export function _start(): Normal | null {
  let normal = new Normal();
  if (v) return normal;
  else return null;
}
