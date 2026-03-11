class Box {
  value: i32;
}

export function outer(): i32 {
  let obj = new Box();
  obj.value = 10;
  function reassign(): void {
    let newObj = new Box();
    newObj.value = 42;
    obj = newObj;
  }
  reassign();
  return obj.value;
}

assert(outer() == 42);
