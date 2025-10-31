class C2<T> {
  a: T;
}

class C3<T> {
  b: T | null = null;
}

export function test(): i32 {
  let c2 = new C2<i32>();
  let c3 = new C3<C2<i32>>();
  c2.a = 10;

  return c2.a;
}
