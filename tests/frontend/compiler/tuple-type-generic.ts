export const disableScriptMode = true;

function testTupleInGeneric<T>(t: T): i32 {
  // @ts-ignore
  return <i32>t[0];
}

assert(testTupleInGeneric<[i32, string]>([42, ""]) == 42);
assert(testTupleInGeneric<[i64, i32]>([4294967296, 42]) == 0);
