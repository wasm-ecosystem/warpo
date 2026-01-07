export let aaa = 10;
export function foo(): i32 {
  for (let iii = 0; iii < 10; iii++) {
    let ddd = 2;
    if (iii % 2 == 0) {
      let bbb = iii * ddd;
      aaa += bbb;
    } else {
      let ccc = iii + 3;
      aaa += ccc;
    }
  }
  return aaa;
}
foo();
