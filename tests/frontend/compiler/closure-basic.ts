export function outer(x: i32): i32 {
  let aaa = x;
  function inner(): i32 {
    return aaa + 1;
  }
  return inner();
}

assert(outer(5) == 6);
