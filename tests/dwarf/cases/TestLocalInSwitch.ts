export function test(x: i32): i32 {
  let result: i32 = 0;

  switch (x) {
    case 1: {
      let aaa = 10;
      result = aaa;
      break;
    }
    case 2: {
      let bbb = 20;
      result = bbb;
      break;
    }
    default: {
      let ccc = 30;
      result = ccc;
      break;
    }
  }

  return result;
}

export function goo(x: i32): i32 {
  let rg1: i32 = 0;

  switch (x) {
    case 1:
      let a1 = 10;
      rg1 = a1;
      break;
    case 2: {
      let b1 = 20;
      rg1 = b1;
      break;
    }
    default:
      let c1 = 30;
      rg1 = c1;
      break;
  }

  return rg1;
}
