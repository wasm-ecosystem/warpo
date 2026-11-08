import { __pin, __unpin } from "rt/index";
import { ffi } from "warpo/ffi";

let observed = "";
const globalValue = "global";

function use(value: string): void {
  observed = value;
}


@noinline
function setT(callback: (event: u64) => void, event: u64): void {
  callback(event);
}

function testConstCapture(): void {
  const value = "abc";
  setT(() => {
    use(value);
  }, 0);
}

function testLetCapture(): void {
  let value = "before";
  const callback: (event: u64) => void = () => {
    use(value);
  };
  value = "after";
  setT(callback, 0);
}

function testParameterCapture(value: string): void {
  setT(() => {
    use(value);
  }, 0);
}

function testMatchingArity(): void {
  const value = "matching";
  setT((event: u64) => {
    assert(event == 42);
    use(value);
  }, 42);
}

function testNonCapturing(): void {
  setT(() => {
    use("literal");
  }, 0);
}

function testGlobalCapture(): void {
  setT(() => {
    use(globalValue);
  }, 0);
}


@noinline
function invokeMixed(callback: (value: i32, extra: u64, unused: f64) => i32): i32 {
  return callback(2, 3, 4.5);
}

function testZeroParameters(): i32 {
  const value = 42;
  const callback: (value: i32, extra: u64, unused: f64) => i32 = (): i32 => value;
  return invokeMixed(callback);
}

function testOneParameter(): i32 {
  const offset = 40;
  const callback: (value: i32, extra: u64, unused: f64) => i32 = (value: i32): i32 => offset + value;
  return invokeMixed(callback);
}

function testFunctionExpression(): i32 {
  const offset = 40;
  const callback: (value: i32, extra: u64, unused: f64) => i32 = function (value: i32): i32 {
    return offset + value;
  };
  return invokeMixed(callback);
}

function makeCallback(offset: i32): (value: i32, extra: u64, unused: f64) => i32 {
  return (value: i32): i32 => offset + value;
}

function testNestedParameterCapture(): i32 {
  const offset = 40;
  const callback: (value: i32, extra: u64, unused: f64) => i32 = (value: i32): i32 => {
    const inner = (): i32 => {
      value = value + 1;
      return offset + value;
    };
    return inner() + inner();
  };
  return invokeMixed(callback);
}

function testTwoParameters(): i32 {
  const offset = 37;
  const callback: (value: i32, extra: u64, unused: f64) => i32 = (value: i32, extra: u64): i32 => {
    const inner = (): i32 => offset + value + <i32>extra;
    return inner();
  };
  return invokeMixed(callback);
}

class ArityCapture {
  constructor(private value: i32) {}

  makeCallback(): (value: i32, extra: u64, unused: f64) => i32 {
    return (): i32 => this.value;
  }
}

function ffiWrapper(cb: (event: u64, unused: f64) => i32): i32 {
  const wrapper = (userData: i32): i32 => {
    ffi.set_ffi_closure_env(userData);
    __unpin(userData);
    return cb(2, 4.5);
  };
  __pin(wrapper.env);
  return call_indirect<i32>(wrapper.index, wrapper.env);
}

function testZeroParameterFFI(): i32 {
  const value = 42;
  return ffiWrapper((): i32 => value);
}

function testOneParameterFFI(): i32 {
  const offset = 40;
  return ffiWrapper((event: u64): i32 => offset + <i32>event);
}

testConstCapture();
assert(observed == "abc");
testLetCapture();
assert(observed == "after");
testParameterCapture("parameter");
assert(observed == "parameter");
testMatchingArity();
assert(observed == "matching");
testNonCapturing();
assert(observed == "literal");
testGlobalCapture();
assert(observed == "global");
assert(testZeroParameters() == 42);
assert(testOneParameter() == 42);
assert(testFunctionExpression() == 42);
const firstCallback = makeCallback(40);
const secondCallback = makeCallback(100);
assert(invokeMixed(firstCallback) == 42);
assert(invokeMixed(secondCallback) == 102);
assert(invokeMixed(firstCallback) == 42);
assert(testNestedParameterCapture() == 87);
assert(testTwoParameters() == 42);
assert(invokeMixed(new ArityCapture(42).makeCallback()) == 42);
assert(testZeroParameterFFI() == 42);
assert(testOneParameterFFI() == 42);
