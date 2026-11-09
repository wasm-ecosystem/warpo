// @ts-ignore: decorator
@noinline
function invokeMixed(callback: (value: i32, extra: u64, unused: f64) => i32): i32 {
  return callback(2, 3, 4.5);
}

// The target has three parameters, but this capturing closure declares none.
function testZeroParameters(): i32 {
  const value = 42;
  const callback: (value: i32, extra: u64, unused: f64) => i32 = (): i32 => value;
  return invokeMixed(callback);
}

// A declared parameter must still be captured when trailing parameters are omitted.
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

// Control: matching arity preserves parameter values and the outer capture.
function testMatchingArity(): i32 {
  const offset = 40;
  return invokeMixed((value: i32, extra: u64, unused: f64): i32 => {
    assert(extra == 3);
    assert(unused == 4.5);
    return offset + value;
  });
}

// Different types are valid if the callback accepts every value allowed by the target.
function testWiderParameterType(): i32 {
  const offset = 40;
  const callback: (value: string) => i32 = (value: string | null): i32 => {
    return offset + (value ? value.length : 0);
  };
  return callback("ab");
}

assert(testZeroParameters() == 42);
assert(testNestedParameterCapture() == 87);
assert(testMatchingArity() == 42);
assert(testWiderParameterType() == 42);
