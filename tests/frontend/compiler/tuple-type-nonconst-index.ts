export function testTupleNonConstIndex(): void {
  let t: [i32, string] = [1, "2"];
  let i = 0;
  t[i];
}
