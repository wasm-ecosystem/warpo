// 3-level nesting: level3 sees z at level 1, y at level 2, x/w at level 3
// exercises deeper dominator chain and cross-level def reuse
export function threeLevel(a: i32, b: i32, flag: bool): i32 {
  let x = a;
  let w = b;
  function level1(): i32 {
    let y = x + 10;
    function level2(): i32 {
      let z = y + 100;
      function level3(): i32 {
        // z+z in entry block → level 1 def in current block (count > 1)
        let base = z + z;
        if (flag) {
          // y (level 2) and x (level 3) → defs at different levels in branch
          return base + y + x;
        } else {
          // w (level 3) → level 3 access, z reused from dominator
          return base + w + z;
        }
      }
      return level3();
    }
    return level2();
  }
  return level1();
}

// threeLevel: x=5, w=2, y=15, z=115
// flag=true:  base=230, 230+15+5=250
// flag=false: base=230, 230+2+115=347
assert(threeLevel(5, 2, true) == 250);
assert(threeLevel(5, 2, false) == 347);
