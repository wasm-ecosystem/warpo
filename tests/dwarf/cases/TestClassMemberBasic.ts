class C1 {
  x: i32;
  y: i32[] = [];
}

class CT<T> {
  a: T;
}

export function test(): i32 {
  var c1 = new C1();
  c1.x = 123;
  c1.y = [1, 2, 3];
  const ct = new CT<i32>();
  ct.a = 400;
  return c1.x + c1.y[0] + ct.a;
}
