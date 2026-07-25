class C1 {
  a: i32 = 1;
  b: i32 = 2;
}

export function main(): void {
  let x: i32 = 1;
  let y: i32 = 2;
  let c: C1 = new C1();
  c.a = 3;
  let z: i32 = x + y + c.a + c.b;
}
