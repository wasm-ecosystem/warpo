//! { "func": "^.*_start$" }

import { Normal } from "../common_lib/normal";

export function _start(): Normal | null {
  let normal: Normal | null = null;
  normal = new Normal();
  return normal;
}
