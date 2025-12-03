export function test(): i32 {
  let aaa = 1;

  // This standalone block triggers compileBlockStatement
  {
    let bbb = 2;
    aaa += bbb;
  }

  return aaa;
}
