let func1: (() => i32) | null = null;
let func2: (() => i32) | null = null;

export function outer(): void {
  let arr: i32[] = [10, 20];
  for (let v of arr) {
    function inner(): i32 {
      return v;
    }
    if (v == 10) {
      func1 = inner;
    } else {
      func2 = inner;
    }
  }
}

outer();

assert(func1 != null);
assert(func2 != null);
assert(func1!() == 10);
assert(func2!() == 20);
