export function level0(a: i32): i32 {
  function level1(b: i32): i32 {
    function level2(): i32 {
      return a + b;
    }
    return level2();
  }
  return level1(10);
}

assert(level0(5) == 15);
