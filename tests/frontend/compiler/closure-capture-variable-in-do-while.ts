let func1: (() => i32) | null = null;

export function outer(): void {
  do {
    let x = 42;
    function inner(): i32 {
      return x;
    }
    func1 = inner;
    break;
  } while (true);
}

outer();

assert(func1 != null);
assert(func1!() == 42);
