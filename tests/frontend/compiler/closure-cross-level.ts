export function outer(a: i32): i32 {
  let x = a;
  function middle(): i32 {
    let y = x + 1;
    function inner(): i32 {
      return x + y;
    }
    return inner();
  }
  return middle();
}
