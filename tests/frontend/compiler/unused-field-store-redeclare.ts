class UsedBase {
  value: i32;
}

class UsedMiddle extends UsedBase {
  value: i32;
}

class UsedLeaf extends UsedMiddle {
  value: i32;
}

class UnusedBase {
  value: i32;
}

class UnusedDerived extends UnusedBase {
  value: i32;
}

function writeUsed(object: UsedBase): void {
  object.value = 1;
}

function readUsed(object: UsedLeaf): i32 {
  return object.value;
}

function writeUnused(object: UnusedBase): i32 {
  object.value = 2;
  return 2;
}

const usedObject = new UsedLeaf();
writeUsed(usedObject);
assert(readUsed(usedObject) == 1);

assert(writeUnused(new UnusedDerived()) == 2);
