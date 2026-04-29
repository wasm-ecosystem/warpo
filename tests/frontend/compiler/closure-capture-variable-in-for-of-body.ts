let func1: (() => i32) | null = null;
let func2: (() => i32) | null = null;

export function outer(): void {
  let arr: i32[] = [0, 1];
  for (let v of arr) {
    let idx = v;
    function inner(): i32 {
      return idx;
    }
    if (v == 0) {
      func1 = inner;
    } else {
      func2 = inner;
    }
  }
}

outer();

assert(func1 != null);
assert(func2 != null);
assert(func1!() == 0);
assert(func2!() == 1);
