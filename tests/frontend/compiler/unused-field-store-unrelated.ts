class Base {
  value: i32;
}

class Derived extends Base {
  value: i32;
}

class Unrelated {
  value: i32;
}

function writeBase(object: Base): void {
  object.value = 1;
}

function readUnrelated(object: Unrelated): i32 {
  return object.value;
}

writeBase(new Base());
assert(readUnrelated(new Unrelated()) == 0);
