class C1 {
  aaa: i32;
}

let c1 = new C1();
let bbb: i32 = 1;

export function test(): i32 {
  return c1.aaa + bbb;
}
