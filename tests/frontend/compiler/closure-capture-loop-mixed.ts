let funcA1: (() => i32) | null = null;
let funcB1: (() => i32) | null = null;
let funcB2: (() => i32) | null = null;

export function outer(): void {
  let x: i32 = 42;
  // First loop: captures only outer variable x, no loop-scoped capture
  for (let i = 0; i < 2; i++) {
    function innerA(): i32 {
      return x;
    }
    if (i == 0) {
      funcA1 = innerA;
    }
  }
  // Second loop: captures loop-body variable y (per-iteration)
  for (let j = 0; j < 2; j++) {
    let y: i32 = j * 10;
    function innerB(): i32 {
      return y;
    }
    if (j == 0) {
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
assert(funcB1!() == 0); // j=0, y=0
assert(funcB2!() == 10); // j=1, y=10
