// closure variable access inside a nested loop: getClosureEnvByLevel should be hoisted past all loop levels
export function loopAccess(n: i32, m: i32): i32 {
  let x = n + 1;
  function inner(): i32 {
    let sum: i32 = 0;
    for (let i: i32 = 0; i < n; i++) {
      for (let j: i32 = 0; j < m; j++) {
        // x is at level 1, should be hoisted out of both loops
        sum += x;
      }
    }
    return sum;
  }
  return inner();
}

// loopAccess(2,3): x=3, sum = 2*3*3 = 18
assert(loopAccess(2, 3) == 18);
assert(loopAccess(0, 5) == 0);

// multi-level closure access inside a loop: both level 1 (y) and level 2 (x)
// should be hoisted out, and level 2 should chain through level 1
export function loopMultiLevel(n: i32): i32 {
  let x = n + 1;
  function middle(): i32 {
    let y = x + 2;
    function inner(): i32 {
      let sum: i32 = 0;
      for (let i: i32 = 0; i < y; i++) {
        // x is at level 2, y is at level 1 — both inside the loop
        sum += x;
      }
      return sum;
    }
    return inner();
  }
  return middle();
}

// loopMultiLevel(3): x=4, y=6, sum = 6*4 = 24
assert(loopMultiLevel(3) == 24);
assert(loopMultiLevel(0) == 3);
