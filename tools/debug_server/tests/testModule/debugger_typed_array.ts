// @ts-nocheck

export function _start(): i32 {
  return run();
}

function run(): i32 {
  let int8 = new Int8Array(2);
  int8[0] = -8;
  int8[1] = 8;
  let uint8 = new Uint8Array(2);
  uint8[0] = 9;
  uint8[1] = 19;
  let uint8Clamped = new Uint8ClampedArray(2);
  uint8Clamped[0] = 29;
  uint8Clamped[1] = 39;
  let int16 = new Int16Array(2);
  int16[0] = -49;
  int16[1] = 49;
  let uint16 = new Uint16Array(2);
  uint16[0] = 59;
  uint16[1] = 69;
  let int32 = new Int32Array(2);
  int32[0] = -79;
  int32[1] = 79;
  let uint32 = new Uint32Array(2);
  uint32[0] = 89;
  uint32[1] = 99;
  let int64 = new Int64Array(2);
  int64[0] = -109;
  int64[1] = 109;
  let uint64 = new Uint64Array(2);
  uint64[0] = 119;
  uint64[1] = 129;
  let float32 = new Float32Array(2);
  float32[0] = 1.5;
  float32[1] = 2.5;
  let float64 = new Float64Array(2);
  float64[0] = 3.5;
  float64[1] = 4.5;
  let result: i32 =
    <i32>int8[0] +
    <i32>uint8[0] +
    <i32>uint8Clamped[0] +
    <i32>int16[0] +
    <i32>uint16[0] +
    <i32>int32[0] +
    <i32>uint32[0] +
    <i32>int64[0] +
    <i32>uint64[0] +
    <i32>float32[0] +
    <i32>float64[0];
  return result;
}
