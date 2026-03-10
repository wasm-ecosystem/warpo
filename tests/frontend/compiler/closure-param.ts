export function outer(x: i32, y: i32): i32 {
  let aaa = x;
  function inner(): i32 {
    x = x + 1;
    return aaa + x;
  }
  const a = inner();
  const b = inner();
  return a + b - y;
}

assert(outer(5, 3) == 20);
