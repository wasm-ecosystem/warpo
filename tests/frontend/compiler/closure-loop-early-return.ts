// loop-exit: closure access in a block that exits the loop (return) should NOT be hoisted
export function loopEarlyReturn(n: i32, flag: bool): i32 {
  let x = n + 1;
  function inner(): i32 {
    let sum: i32 = 0;
    for (let i: i32 = 0; i < n; i++) {
      if (flag) {
        // x is at level 1, but this block returns — it runs at most once
        return x;
      }
      sum += i;
    }
    return sum;
  }
  return inner();
}

// loopEarlyReturn(3, true): x=4, returns immediately
assert(loopEarlyReturn(3, true) == 4);
// loopEarlyReturn(3, false): sum = 0+1+2 = 3
assert(loopEarlyReturn(3, false) == 3);

// closure var used both in the loop body and in an early-return branch
// the loop body use triggers hoisting; the return branch use should also use the cached local
export function loopUseAndEarlyReturn(n: i32, flag: bool): i32 {
  let x = n + 1;
  function inner(): i32 {
    let sum: i32 = 0;
    for (let i: i32 = 0; i < n; i++) {
      sum += x;
      if (flag) {
        return x;
      }
    }
    return sum;
  }
  return inner();
}

// loopUseAndEarlyReturn(3, true): x=4, sum=4, then returns x=4
assert(loopUseAndEarlyReturn(3, true) == 4);
// loopUseAndEarlyReturn(3, false): sum = 4+4+4 = 12
assert(loopUseAndEarlyReturn(3, false) == 12);
