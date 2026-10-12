let first: (() => i32) | null = null;
let second: (() => i32) | null = null;

export function outer(): void {
  let values: [i32, string][] = [
    [10, "abc"],
    [20, "de"],
  ];
  for (let [value, text] of values) {
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
assert(second!() == 22);
