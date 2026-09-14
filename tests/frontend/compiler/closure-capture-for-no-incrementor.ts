let first: (() => i32) | null = null;
let second: (() => i32) | null = null;

export function outer(): void {
  for (let value = 10; value <= 20; ) {
    function inner(): i32 {
      return value;
    }
    if (value == 10) {
      first = inner;
    } else {
      second = inner;
    }
    value += 10;
  }
}

outer();

assert(first != null);
assert(second != null);
assert(first!() == 20);
assert(second!() == 30);
