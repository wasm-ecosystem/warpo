// @ts-nocheck

class Counter {
  value: i32;

  constructor(value: i32) {
    this.value = value;
  }

  add(delta: i32): i32 {
    const current = this.value;
    return current + delta;
  }
}

export function _start(): i32 {
  const counter = new Counter(40);
  return counter.add(2);
}
