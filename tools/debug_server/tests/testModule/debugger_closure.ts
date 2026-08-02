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
  let base = 21;
  let label = "closure label";
  let child = new Child(77);
  const readCaptured = (delta: i32): i32 => {
    let inside = base + delta;
    return inside + label.length + child.value;
  };
  return readCaptured(5);
}
