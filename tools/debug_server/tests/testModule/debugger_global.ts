// @ts-nocheck

let globalCounter: i32 = 23;
let globalMessage = "global debugger";
let globalValues = [13, 21];
let globalEntries = new Map<i32, i32>();

export function _start(): i32 {
  globalEntries.set(5, 34);
  globalCounter += 1;
  return globalCounter + globalMessage.length + globalValues[0] + globalEntries.size;
}
