let func1: (() => i32) | null = null;
let func2: (() => i32) | null = null;

export function outer(): void {
  let i = 0;
  do {
    let idx = i;
    function inner(): i32 {
      return idx;
    }
    if (i == 0) {
      func1 = inner;
    } else {
      func2 = inner;
    }
    i++;
  } while (i < 2);
}

outer();

assert(func1 != null);
assert(func2 != null);
assert(func1!() == 0);
assert(func2!() == 1);
