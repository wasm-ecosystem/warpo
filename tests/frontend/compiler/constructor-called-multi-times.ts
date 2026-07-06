class Box {
  value: i32;

  constructor(value: i32) {
    this.value = value;
  }
}

class ManyBoxes {
  a: Box = new Box(1);
  b: Box = new Box(2);
  c: Box = new Box(3);
  d: Box = new Box(4);
  e: Box = new Box(5);
  f: Box = new Box(6);
}

var manyBoxes = new ManyBoxes();

assert(manyBoxes.a.value == 1);
assert(manyBoxes.f.value == 6);
