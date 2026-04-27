let fn0: (() => i32) | null = null;
let fn1: (() => i32) | null = null;
let fn2: (() => i32) | null = null;

export function withContinueAndBreak(): void {
  let count = 0;
  for (let i = 0; i < 5; i++) {
    let val = i * 10;
    if (i == 2) continue;
    if (i == 4) break;
    let captured = (): i32 => val;
    if (count == 0) fn0 = captured;
    else if (count == 1) fn1 = captured;
    else fn2 = captured;
    count++;
  }
}

withContinueAndBreak();

assert(fn0 != null);
assert(fn1 != null);
assert(fn2 != null);
assert(fn0!() == 0);
assert(fn1!() == 10);
assert(fn2!() == 30);
