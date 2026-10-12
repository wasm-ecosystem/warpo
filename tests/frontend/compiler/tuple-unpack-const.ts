class Box {
  value: i32;

  constructor(value: i32) {
    this.value = value;
  }
}

export function _start(): i32 {
  const [a, b]: [i32, i32] = [10, 20];
  const [c, box]: [i32, Box] = [30, new Box(40)];
  assert(a == 10);
  assert(b == 20);
  assert(c == 30);
  assert(box.value == 40);
  return a + b + c + box.value;
}

assert(_start() == 100);
