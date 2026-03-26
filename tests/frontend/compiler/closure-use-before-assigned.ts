export function readAfterAssign(): i32 {
  let value: i32;

  function inner(): i32 {
    return value;
  }

  value = 1;
  return inner();
}

export function readBeforeAssign(): i32 {
  let value: i32;

  function inner(): i32 {
    return value;
  }

  const before = inner();
  value = 1;
  const after = inner();
  assert(after == 1);
  return before;
}

assert(readAfterAssign() == 1);
assert(readBeforeAssign() == 0);
