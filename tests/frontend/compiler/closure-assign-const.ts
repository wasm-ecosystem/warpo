// Closure where the inner function modifies a const captured variable
export function test(): void {
  const x: i32 = 42;
  function inner(): void {
    x = 1;
  }
  inner();
}
