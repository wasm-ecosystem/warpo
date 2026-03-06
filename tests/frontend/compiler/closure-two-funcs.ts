export function outer(x: i32): i32 {
  let val = x;
  function add1(): i32 {
    return val + 1;
  }
  function add2(): i32 {
    return val + 2;
  }
  return add1() + add2();
}
