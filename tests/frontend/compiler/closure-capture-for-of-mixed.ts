let funcA1: (() => i32) | null = null;
let funcB1: (() => i32) | null = null;
let funcB2: (() => i32) | null = null;

export function outer(): void {
  let x: i32 = 42;
  let arr: i32[] = [0, 1];
  // First loop: captures only outer variable x, no loop-scoped capture
  for (let v of arr) {
    function innerA(): i32 {
      return x;
    }
    if (v == 0) {
      funcA1 = innerA;
    }
  }
  // Second loop: captures loop-body variable y (per-iteration)
  for (let v of arr) {
    let y: i32 = v * 10;
    function innerB(): i32 {
      return y;
    }
    if (v == 0) {
      funcB1 = innerB;
    } else {
      funcB2 = innerB;
    }
  }
}

outer();

assert(funcA1 != null);
assert(funcA1!() == 42); // x=42

assert(funcB1 != null);
assert(funcB2 != null);
assert(funcB1!() == 0); // v=0, y=0
assert(funcB2!() == 10); // v=1, y=10
