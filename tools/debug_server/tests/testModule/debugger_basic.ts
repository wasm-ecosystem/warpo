// @ts-nocheck
import {
  arrayValues,
  calculate,
  classArrayValues,
  closureValues,
  mapValues,
  numericMapValues,
  setValues,
  staticArrayValues,
  stringValues,
  tupleValues,
} from "./debugger_callee";

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

export function staticArrayEntry(): i32 {
  return staticArrayValues();
}

export function setEntry(): i32 {
  return setValues();
}

export function mapEntry(): i32 {
  return mapValues();
}

export function numericMapEntry(): i32 {
  return numericMapValues();
}

export function closureEntry(): i32 {
  return closureValues();
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
