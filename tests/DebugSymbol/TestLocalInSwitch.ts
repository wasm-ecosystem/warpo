export function test(x: i32): i32 {
  let result: i32 = 0;
  
  switch (x) {
    case 1:
      let aaa = 10;
      result = aaa;
      break;
    case 2:{
      let bbb = 20;
      result = bbb;
      break;
    }
    default:
      let ccc = 30;
      result = ccc;
      break;
  }
  
  return result;
}
