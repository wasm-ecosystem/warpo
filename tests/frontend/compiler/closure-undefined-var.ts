// Closure referencing an undefined variable
export function testUndefinedVar(): void {
  function inner(): i32 {
    return undefinedVar;
  }
  inner();
}
