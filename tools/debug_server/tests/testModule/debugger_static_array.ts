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
  let values = new StaticArray<i32>(3);
  values[0] = 13;
  values[1] = 21;
  values[2] = 34;
  let children = new StaticArray<Child>(2);
  children[0] = new Child(44);
  children[1] = new Child(55);
  return values[0] + values[1] + values[2] + children[0].value + children[1].value;
}
