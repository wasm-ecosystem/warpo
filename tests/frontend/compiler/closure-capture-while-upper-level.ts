let func1: (() => i32) | null = null;
let func2: (() => i32) | null = null;

export function outer(): i32 {
  let x = 100;
  let i = 0;
  while (i < 2) {
    let idx = x + i;
    function inner(): i32 {
      return x + idx;
    }
    if (i == 0) {
      func1 = inner;
    } else {
      func2 = inner;
    }
    i++;
  }
  return x;
}

assert(outer() == 100);

assert(func1 != null);
assert(func2 != null);
assert(func1!() == 200);
assert(func2!() == 201);
