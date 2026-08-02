// @ts-nocheck
import { calculate } from "./debugger_callee";

export function _start(): i32 {
  let callerSeed: i32 = 23;
  return calculate(callerSeed);
}
