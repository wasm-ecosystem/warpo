export const disableScriptMode = true;

function id<T>(x: T): T {
  return x;
}

function testTupleIndexGenericInference(): void {
  let t: [i32, string] = [1, "abc"];

  let s0: string = t[1];
  assert(s0.length == 3);

  let s1 = id(t[1]);
  assert(s1.length == 3);

  let n0: i32 = t[0];
  assert(n0 == 1);

  let n1 = id(t[0]);
  assert(n1 == 1);
}
