import { ffi } from "warpo/ffi";
// @ts-ignore: decorator
@external("env", "multi_return_api")
declare function multi_return_api(): ffi.MultiReturn<[i32, i32]>;

function testMultiReturnUnpack(): void {
  let [firstValue, secondValue] = ffi.multi_return_to_tuple<[i32, i32]>(multi_return_api());
  assert(firstValue === 10);
  assert(secondValue === 20);
}

export function _start(): i32 {
  testMultiReturnUnpack();
  let result = ffi.multi_return_to_tuple<[i32, i32]>(multi_return_api());
  return result[0] + result[1];
}

assert(_start() === 30);