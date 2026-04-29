let func1: (() => i32) | null = null;
let func2: (() => i32) | null = null;

export function outer(): void {
  let i = 0;
  while (i < 2) {
    let x: i32 = i * 10;
    function inner(): i32 {
      return x;
    }
    if (i == 0) {
      func1 = inner;
    } else {
      func2 = inner;
    }
    i++;
  }
}

outer();

assert(func1 != null);
assert(func2 != null);
assert(func1!() == 0);
assert(func2!() == 10);
