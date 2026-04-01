import { __pin, __unpin } from "rt/index";
import { ffi } from "warpo/ffi";

export function ffi_wrapper(cb: () => i32): i32 {
  const wrapper = (userData: i32): i32 => {
    ffi.set_ffi_closure_env(userData);
    __unpin(userData);
    return cb();
  };
  __pin(wrapper.env);
  return call_indirect<i32>(wrapper.index, wrapper.env);
}

function outer(): i32 {
  let x: i32 = 41;
  function inner(): i32 {
    x = x + 1;
    return x;
  }
  return ffi_wrapper(inner);
}

assert(outer() == 42);
