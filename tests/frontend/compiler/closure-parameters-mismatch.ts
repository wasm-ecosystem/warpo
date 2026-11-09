// Supported:
// - Fewer parameters: target (i32) => i32, closure () => i32 (tested below).
// - Matching parameters: target (i32) => i32, closure (i32) => i32.
// Rejected:
// - More required parameters: target (i32) => i32, closure (i32, i32) => i32.
// - Incompatible parameter type: target (i32) => i32, closure (string) => i32.
// Parameter types need not be identical, but the closure must accept every target input.
// Rejected cases: [closure-type-errors.ts](./closure-type-errors.ts).
// The closure below captures an outer variable and ignores the target's argument.
function testFewerParameters(): void {
  const value = 42;
  const fn: (unused: i32) => i32 = (): i32 => value;
  assert(fn(0) == 42);
}

testFewerParameters();
