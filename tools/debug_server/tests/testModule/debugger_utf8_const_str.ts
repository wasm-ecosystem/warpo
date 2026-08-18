// @ts-nocheck

import * as utf8 from "warpo/utf8/const_str";

export function _start(): i32 {
  return run();
}

function run(): i32 {
  let s: utf8.ConstStr = utf8.build("abcdef");
  return s.size;
}
