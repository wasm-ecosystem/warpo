// Closure with mixed captured and non-captured parameters,
// where the captured parameter has duplicate name with a local
export function test(): void {
  let x: i32 = 0;
  function inner(x: i32): i32 {
    return x;
  }
  assert(inner(1) == 1);
  assert(inner(42) == 42);
}
