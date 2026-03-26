// Closure where the body has a type error in an expression.
// Should produce a user-friendly error, not crash.
export function test(): void {
  let x: i32 = 0;
  function inner(): i32 {
    let obj: string = "hello";
    return x + obj;
  }
  inner();
}
