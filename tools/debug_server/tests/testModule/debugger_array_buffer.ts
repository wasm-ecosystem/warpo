// @ts-nocheck

export function _start(): i32 {
  return run();
}

function run(): i32 {
  let buffer = new ArrayBuffer(3);
  store<u8>(changetype<usize>(buffer), 13);
  store<u8>(changetype<usize>(buffer) + 1, 21);
  store<u8>(changetype<usize>(buffer) + 2, 34);
  return buffer.byteLength;
}
