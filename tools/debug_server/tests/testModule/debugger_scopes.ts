// @ts-nocheck

export function _start(): i32 {
  return nestedScopes(5);
}

function nestedScopes(x: i32): i32 {
  let a: i32 = 1;
  let b: i32 = 2;
  if (x > 0) {
    let a: i32 = 10;
    b += a;
    if (x > 10) {
      let a: i32 = 100;
      b += a;
    }
  } else {
    let a: i32 = 20;
    b -= a;
  }
  return b;
}
