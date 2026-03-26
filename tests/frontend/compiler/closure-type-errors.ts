// Arrow function closure with more parameters than expected by contextual type
export function testTooManyParams(): void {
  let x: i32 = 0;
  let fn: (a: i32) => i32 = (a: i32, b: i32): i32 => x + a + b;
}

// Arrow function closure with return type mismatch
export function testReturnTypeMismatch(): void {
  let x: i32 = 0;
  let fn: (a: i32) => i32 = (a: i32): f64 => <f64>(x + a);
}

// Arrow function closure with parameter type mismatch
export function testParamTypeMismatch(): void {
  let x: i32 = 0;
  let fn: (a: i32) => i32 = (a: f64): i32 => x + <i32>a;
}
