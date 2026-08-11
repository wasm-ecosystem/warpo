// @ts-nocheck

export function _start(): i32 {
  let before: i32 = 1;
  let value: i32 = stepTarget(before);
  let after: i32 = value + 1;
  return after;
}

function stepTarget(value: i32): i32 {
  let doubled: i32 = value * 2;
  return doubled;
}

export function indirectStart(): i32 {
  let before: i32 = 1;
  const target = stepTarget;
  let value: i32 = target(before);
  let after: i32 = value + 1;
  return after;
}
