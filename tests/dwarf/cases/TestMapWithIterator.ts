export function test(): i32 {
  const m = new Map<i32, string>();
  m.set(1, "hello");
  m.set(2, "world");
  let sum: i32 = 0;
  for (let entry of m) {
    sum += entry[0];
  }
  return sum;
}
