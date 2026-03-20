// 2-level nesting: multiple variables per level, nested branches
// inner sees y,v at level 1 and x,w,flag1,flag2 at level 2
export function twoLevel(a: i32, b: i32, flag1: bool, flag2: bool): i32 {
  let x = a;
  let w = b;
  function middle(): i32 {
    let y = x + 1;
    let v = w + 2;
    function inner(): i32 {
      // y+v in entry block → level 1 defs (both used, count matters)
      let base = y + v;
      if (flag1) {
        // x and w → level 2 accesses in then-branch
        return base + x + w;
      } else {
        if (flag2) {
          // y reused from dominator, x at level 2
          return y + x;
        } else {
          // v reused from dominator, w at level 2
          return v + w;
        }
      }
    }
    return inner();
  }
  return middle();
}

// twoLevel: x=3, w=7, y=4, v=9
// flag1=true:  base=13, 13+3+7=23
// flag1=false, flag2=true:  4+3=7
// flag1=false, flag2=false: 9+7=16
assert(twoLevel(3, 7, true, false) == 23);
assert(twoLevel(3, 7, false, true) == 7);
assert(twoLevel(3, 7, false, false) == 16);
