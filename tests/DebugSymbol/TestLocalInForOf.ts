let r = 0;
export function foo(): void {
  let a: i32[] = [1, 2, 3];
  for (const v of a) {
    for (const v of a) {
      for (const v of a) {
        for (const v of a) {
          r += v;
        }
      }
    }
  }
}
