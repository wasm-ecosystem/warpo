// TS and AS reject more required parameters than the target promises to supply.
export function testTooManyParams(): void {
  let x: i32 = 0;
  let fn: (a: i32) => i32 = (a: i32, b: i32): i32 => x + a + b;
}

// AS-specific numeric return mismatch: tsc models both i32 and f64 as number.
export function testReturnTypeMismatch(): void {
  let x: i32 = 0;
  let fn: (a: i32) => i32 = (a: i32): f64 => <f64>(x + a);
}

// AS-specific numeric parameter mismatch: tsc models both i32 and f64 as number.
export function testParamTypeMismatch(): void {
  let x: i32 = 0;
  let fn: (a: i32) => i32 = (a: f64): i32 => x + <i32>a;
}

// TS and AS reject a callback expecting a string when the target supplies a number.
export function testIncompatibleParamType(): void {
  const offset = 40;
  const fn: (value: i32) => i32 = (value: string): i32 => offset + value.length;
}

// A callback accepting only string cannot handle the null allowed by the target.
export function testNarrowerParamType(): void {
  const offset = 40;
  const fn: (value: string | null) => i32 = (value: string): i32 => offset + value.length;
}
