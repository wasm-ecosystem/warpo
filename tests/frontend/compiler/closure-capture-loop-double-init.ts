let func1: (() => i32) | null = null;
let func2: (() => i32) | null = null;

export function outer(): void {
  for (let i = 0, j = 10; i < 2; i++, j--) {
    function inner(): i32 {
      return i + j;
    }
    if (i == 0) {
      func1 = inner;
    } else {
      func2 = inner;
    }
  }
}

outer();

assert(func1 != null);
assert(func2 != null);
assert(func1!() == 10); // i=0, j=10 => 0+10=10
assert(func2!() == 10); // i=1, j=9 => 1+9=10
