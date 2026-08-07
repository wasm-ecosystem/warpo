// @ts-nocheck

export function _start(): i32 {
  return trap(42);
}

function trap(input: i32): i32 {
  const local = input + 1;
  return local / 0;
}
