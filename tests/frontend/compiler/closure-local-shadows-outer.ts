// Closure where inner function explicitly declares a local with the
// same name as a variable captured from the outer scope.
export function test(): i32 {
  let x: i32 = 42;

  function inner(): i32 {
    let x: i32 = 10;
    return x;
  }

  return inner();
}

assert(test() == 10);
