// @ts-nocheck

export function _start(): i32 {
  const values = [3, 5, 8];
  return values.every((value: i32) => value > 0) ? 1 : 0;
}
