// @ts-nocheck

export function _start(): i32 {
  let callerSeed: i32 = 23;
  return calculate(callerSeed);
}

export function calculate(seed: i32): i32 {
  let a: i32 = 1;
  let b: f32 = 2.5;
  let c: i64 = 3;
  let d: f64 = 4.5;
  let sum: i32 = seed + a + i32(b) + i32(c) + i32(d);
  return sum;
}
