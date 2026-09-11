let captured: (() => i32) | null = null;

export function outer(): void {
  let [left, right]: [i32, i32] = [19, 23];
  function inner(): i32 {
    return left + right;
  }
  captured = inner;
}

outer();

assert(captured != null);
assert(captured!() == 42);