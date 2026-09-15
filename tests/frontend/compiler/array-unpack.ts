export function _start(): i32 {
  let values: i32[] = [10, 20];
  let [a, b] = values;
  let [c, d]: i32[] = [30, 40];
  assert(a == 10);
  assert(b == 20);
  assert(c == 30);
  assert(d == 40);
  return a + b + c + d;
}

assert(_start() == 100);
