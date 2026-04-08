// Regression test: closure created from a non-closure context whose parameter
// is captured by an inner closure. Previously crashed with:
// "abort: <<NULL>> in compiler.ts:2186" because the creation context had no
// heapLocalsStorage.
function call(fn: (cb: () => i32) => i32): i32 {
  return fn(() => 42);
}

export function test(): i32 {
  return call((resolve: () => i32) => {
    let inner = (): i32 => {
      return resolve();
    };
    return inner();
  });
}

assert(test() == 42);
