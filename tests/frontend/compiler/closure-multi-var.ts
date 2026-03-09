export function outer(a: i32, b: i32): i32 {
  let x = a;
  let y = b;
  function inner(): i32 {
    return x + y;
  }
  return inner();
}

assert(outer(3, 4) == 7);
