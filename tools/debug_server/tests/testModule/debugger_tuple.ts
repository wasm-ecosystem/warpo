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
  let values: [i32, string, Child] = [89, "tuple value", new Child(55)];
  return values[0] + values[1].length + values[2].value;
}
