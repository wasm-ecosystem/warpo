// @ts-nocheck

class Child {
  value: i32;

  constructor(value: i32) {
    this.value = value;
  }
}

export function _start(): i32 {
  return run();
}

function run(): i32 {
  let values = new Map<i32, Child>();
  let first = new Child(144);
  let second = new Child(233);
  values.set(5, first);
  values.set(8, second);
  return values.size + first.value + second.value;
}
