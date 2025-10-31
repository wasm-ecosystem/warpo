class C1 {
  a: i32;
}

let c1 = new C1();
let b: i32 = 1;

export function test(): i32 {
  return c1.a + b;
}
