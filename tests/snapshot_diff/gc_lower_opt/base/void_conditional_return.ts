//! { "func": "^.*_start$" }

import { Normal } from "../../common_lib/normal";

export let shouldReturn: bool;

export function use(value: Normal): void {
  new Normal();
}

export function _start(): void {
  let value = new Normal();
  if (shouldReturn) return;
  use(value);
}
