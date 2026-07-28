// @ts-nocheck
import { calculate } from "./debugger_callee";

export function _start(): i32 {
  let callerSeed = 23;
  return calculate(callerSeed);
}

export function branchEntry(): i32 {
  return branchLocals(1);
}

function branchLocals(flag: i32): i32 {
  if (flag > 0) {
    let ifOnly = 31;
    return ifOnly;
  } else {
    let elseOnly = 41;
    return elseOnly;
  }
}
