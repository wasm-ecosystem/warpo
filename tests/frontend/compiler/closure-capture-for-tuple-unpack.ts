let first: (() => i32) | null = null;
let second: (() => i32) | null = null;

function makePair(): [i32, string] {
  return [10, "abc"];
}

export function outer(): void {
  for (let [value, text] = makePair(); value <= 20; value += 10) {
    function inner(): i32 {
      return value + text.length;
    }
    if (value == 10) {
      first = inner;
    } else {
      second = inner;
    }
  }
}

outer();

assert(first != null);
assert(second != null);
assert(first!() == 13);
assert(second!() == 23);
