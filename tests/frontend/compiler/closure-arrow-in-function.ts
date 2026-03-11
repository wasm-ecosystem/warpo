export function testNormalFunction(): i32 {
  let x: i32 = 41;
  let add = (): i32 => {
    x = x + 1;
    return x;
  };
  return add();
}

assert(testNormalFunction() == 42);
