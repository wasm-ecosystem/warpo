// @ts-nocheck
class Child {
  value: i32;

  constructor(value: i32) {
    this.value = value;
  }
}

class Holder {
  count: i32;
  child: Child;

  constructor(count: i32, child: Child) {
    this.count = count;
    this.child = child;
  }
}

class BaseBox {
  base: i32;

  constructor(base: i32) {
    this.base = base;
  }
}

class DerivedBox extends BaseBox {
  extra: i32;

  constructor(base: i32, extra: i32) {
    super(base);
    this.extra = extra;
  }
}

export function calculate(seed: i32): i32 {
  let a = 1;
  let holder = new Holder(7, new Child(11));
  let box: BaseBox = new DerivedBox(3, 17);
  let first = holder.count + holder.child.value + box.base;
  holder = new Holder(9, new Child(13));
  return seed + a + first + holder.count + holder.child.value;
}

class StringHolder {
  label: string;

  constructor(label: string) {
    this.label = label;
  }
}

export function stringValues(): i32 {
  let message = "hello debugger";
  let holder = new StringHolder("first holder");
  return message.length + holder.label.length;
}

export function arrayValues(): i32 {
  let values = [3, 5, 8];
  return values[0] + values[1] + values[2];
}

export function classArrayValues(): i32 {
  let children = [new Child(21), new Child(34)];
  return children[0].value + children[1].value;
}

export function tupleValues(): i32 {
  let values: [i32, string, Child] = [89, "tuple value", new Child(55)];
  return values[0] + values[1].length + values[2].value;
}

export function staticArrayValues(): i32 {
  let values = new StaticArray<i32>(3);
  values[0] = 13;
  values[1] = 21;
  values[2] = 34;
  let children = new StaticArray<Child>(2);
  children[0] = new Child(44);
  children[1] = new Child(55);
  return values[0] + values[1] + values[2] + children[0].value + children[1].value;
}

export function setValues(): i32 {
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

export function mapValues(): i32 {
  let values = new Map<i32, Child>();
  let first = new Child(144);
  let second = new Child(233);
  values.set(5, first);
  values.set(8, second);
  return values.size + first.value + second.value;
}

export function numericMapValues(): i32 {
  let values = new Map<number, number>();
  values.set(1, 100);
  values.set(2, 200);
  return values.size;
}

export function closureValues(): i32 {
  let base = 21;
  let label = "closure label";
  let child = new Child(77);
  const readCaptured = (delta: i32): i32 => {
    let inside = base + delta;
    return inside + label.length + child.value;
  };
  return readCaptured(5);
}
