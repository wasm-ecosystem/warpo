export function outer(a: i32): i32 {
  let x = a;
  function middle(): i32 {
    let y = 100;
    function inner(): i32 {
      return x + 10;
    }
    return inner() + y;
  }
  return middle();
}

assert(outer(7) == 117);
