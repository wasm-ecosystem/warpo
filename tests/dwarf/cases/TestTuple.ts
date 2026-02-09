export function foo(): i64 {
  let pair: [i32, i64] = [1, 2];
  let aaa = pair[0];
  let bbb = pair[1];
  let pair2: [i32, i64] = [1, 2];
  return aaa + bbb + pair2[0] + pair2[1];
}

class ClassWithTupleMember {
  member: [i32, i64];

  constructor() {
    this.member = [3, 4];
  }
}

export function bar(): i64 {
  let obj = new ClassWithTupleMember();
  let val1 = obj.member[0];
  let val2 = obj.member[1];
  return val1 + val2;
}

export function baz(): i32 {
  let pair: [Array<i32>, i64] = [[1, 2, 3], 4];
  let arr = pair[0];
  let num = pair[1];
  return arr[0] + <i32>num;
}

export function nullableElement(): i32 {
  let pair: [Array<i32> | null, i64] = [null, 4];
  return <i32>pair[1];
}

export function functionElement(): i32 {
  let cb: (a: i32) => i32 = (x: i32): i32 => x;
  let pair: [(a: i32) => i32, i64] = [cb, 4];
  return pair[0](1) + <i32>pair[1];
}
