// Arrow function tries to capture `this` in a non-class context.
export function test(): void {
  let x: i32 = 0;
  const fn = (): i32 => {
    return this + x;
  };
}
