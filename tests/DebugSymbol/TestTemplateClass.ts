class C2<T> {
  aaa: T;
}

class C3<T> {
  bbb: T | null = null;
}

export function test(): i32 {
  let c2 = new C2<i32>();
  let c3 = new C3<C2<i32>>();
  c2.aaa = 10;

  return c2.aaa;
}
