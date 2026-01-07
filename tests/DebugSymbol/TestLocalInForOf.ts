let rrr = 0;
export function foo(): void {
  let aaa: i32[] = [1, 2, 3];
  for (const v of aaa) {
    for (const v of aaa) {
      for (const v of aaa) {
        for (const v of aaa) {
          rrr += v;
        }
      }
    }
  }
}
