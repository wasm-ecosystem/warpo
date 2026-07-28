// @ts-nocheck
import { arrayValues, calculate, classArrayValues, stringValues, tupleValues } from "./debugger_callee";

export function _start(): i32 {
  let callerSeed = 23;
  return calculate(callerSeed);
}

export function branchEntry(): i32 {
  return branchLocals(1);
}

export function stringEntry(): i32 {
  return stringValues();
}

export function arrayEntry(): i32 {
  return arrayValues();
}

export function classArrayEntry(): i32 {
  return classArrayValues();
}

export function tupleEntry(): i32 {
  return tupleValues();
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
