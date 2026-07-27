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
