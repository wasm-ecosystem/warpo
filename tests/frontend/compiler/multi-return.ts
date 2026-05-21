import { ffi } from "warpo/ffi";
// @ts-ignore: decorator
@external("env", "multi_return_api")
declare function multi_return_api(): ffi.MultiReturn<[i32, i32]>;

export function _start(): i32 {
  let result = ffi.multi_return_to_tuple<[i32, i32]>(multi_return_api());
  return result[0] + result[1];
}

assert(_start() === 30);