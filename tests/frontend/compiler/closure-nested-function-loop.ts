type i32 = number;

let result1: (() => i32) | null = null;
let result2: (() => i32) | null = null;

function outer(): i32 {
  let a = 1;
  for (let i = 0; i < 2; i++) {
    let b = a + i * 10;
    function middle(): i32 {
      let c = b + 100;
      for (let j = 0; j < 2; j++) {
        let d = c + j;
        function inner(): i32 {
          return a + b + c + d;
        }
        if (j == 1) {
          if (i == 0) {
            result1 = inner;
          } else {
            result2 = inner;
          }
        }
      }
      return c;
    }
    middle();
  }
  return a;
}

assert(outer() == 1);
assert(result1 != null);
assert(result2 != null);
assert(result1!() == 205);
assert(result2!() == 235);
