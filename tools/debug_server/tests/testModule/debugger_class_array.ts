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
  let children = [new Child(21), new Child(34)];
  return children[0].value + children[1].value;
}
