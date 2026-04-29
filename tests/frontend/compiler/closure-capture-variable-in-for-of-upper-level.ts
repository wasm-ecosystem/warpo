let func1: (() => i32) | null = null;
let func2: (() => i32) | null = null;

export function outer(): i32 {
  let x = 100;
  let arr: i32[] = [0, 1];
  for (let v of arr) {
    let idx = x + v;
    function inner(): i32 {
      return x + idx;
    }
    if (v == 0) {
      func1 = inner;
    } else {
      func2 = inner;
    }
  }
  return x;
}

assert(outer() == 100);

assert(func1 != null);
assert(func2 != null);
assert(func1!() == 200); // x=100, idx=100+0=100, x+idx=200
assert(func2!() == 201); // x=100, idx=100+1=101, x+idx=201
