// @ts-nocheck

export function _start(): i32 {
  return run();
}

function run(): i32 {
  let values = new Map<number, number>();
  values.set(1, 100);
  values.set(2, 200);
  return values.size;
}
