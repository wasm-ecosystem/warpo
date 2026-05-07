export function test(): i32 {
  const m = new Map<i32, string>();
  m.set(1, "a");
  m.set(2, "b");
  assert(m.get(1) == "a");
  return m.size;
}
