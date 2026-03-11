export function outer(a: i32): i32 {
  let x = a;
  function middle(): i32 {
    let y = x + 1;
    function inner(): i32 {
      return y + 2;
    }
    return inner();
  }
  return middle();
}

assert(outer(3) == 6);
