//! { "func": "^.*_start$" }

import { Normal } from "../common_lib/normal";

export function _start(): Normal {
  let normal = new Normal();
  //@ts-ignore
  __collect();
  return normal;
}
