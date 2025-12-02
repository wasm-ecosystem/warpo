export let a = 10;
export function foo(): i32 {
  for (let iii = 0; iii < 10; iii++) {
    if (iii % 2 == 0) {
      let bbb = iii * 2;
      a += bbb;
    } else {
      let ccc = iii + 3;
      a += ccc;
    }
  }
  return a;
}
foo();
