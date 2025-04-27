//! { "func": "^.*foo_.*$" }

import { Normal } from "../common_lib/normal";

let v = 0;
export function foo_true(): Normal {
  let normal = new Normal();
  if (v) {
    //@ts-ignore
    __collect();
  }
  return normal;
}

export function foo_false(): Normal {
  let normal = new Normal();
  if (v) {
  } else {
    //@ts-ignore
    __collect();
  }
  return normal;
}

export function foo_other_branch(): Normal | null {
  let normal = new Normal();
  if (v) {
    return normal;
  } else {
    //@ts-ignore
    __collect();
  }
  return null;
}
