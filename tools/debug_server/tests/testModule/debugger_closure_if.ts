// @ts-nocheck

export function _start(): i32 {
  return foo();
}

function foo(): i32 {
  let a = 1;
  if (a > 0) {
    let b = 2;
    function inner(): i32 {
      return a + b;
    }
    return inner();
  }
  return 0;
}
