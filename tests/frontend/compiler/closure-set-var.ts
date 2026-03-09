export function outer(x: i32): i32 {
  let val = x;
  function inc(): void {
    val = val + 1;
  }
  inc();
  inc();
  return val;
}

assert(outer(5) == 7);
