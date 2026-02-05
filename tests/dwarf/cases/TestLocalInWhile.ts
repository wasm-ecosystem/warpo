export let g1 = 0;
export function foo(): i32 {
  while (g1 > 0) {
    let aaa = 1;
    g1 -= aaa;
  }
  return g1;
}

export function goo(): i32 {
  do {
    let bbb = 1;
    g1 -= bbb;
  } while (g1 > 0);
  return g1;
}
