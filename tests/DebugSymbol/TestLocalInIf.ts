export let g1 = 0;
export function foo(): i32 {
  if (g1 > 0) {
    let af1 = 0;
    return af1;
  }
  return 1;
}

export function goo(): i32 {
  if (g1 > 100) {
    let aaa = 0;
    return aaa;
  } else if (g1 > 10) {
    let bbb = 2;
    return bbb;
  } else {
    let ccc = 3;
    return ccc;
  }
}
