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
  let values = new Set<i32>();
  values.add(5);
  values.add(8);
  values.add(13);
  let children = new Set<Child>();
  let first = new Child(61);
  let second = new Child(89);
  children.add(first);
  children.add(second);
  return values.size + first.value + second.value;
}
