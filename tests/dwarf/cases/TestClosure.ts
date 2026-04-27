export function outer(base: i32, scale: i32): (delta: i32) => i32 {
  let runningTotal = base;
  let fixedOffset = 10;

  return (delta: i32): i32 => {
    let stepValue = (delta + fixedOffset) * scale;
    runningTotal += stepValue;
    return runningTotal;
  };
}

class Counter {
  bias: i32 = 1;

  makeAdder(base: i32): (delta: i32) => i32 {
    let accumulator = base;
    let biasSnapshot = this.bias;

    return (delta: i32): i32 => {
      let adjustedDelta = delta + biasSnapshot;
      accumulator += adjustedDelta;
      return accumulator + this.bias;
    };
  }
}

export function memberOuter(base: i32): (delta: i32) => i32 {
  return new Counter().makeAdder(base);
}

export function loopCapture(n: i32): i32 {
  let sum = 0;
  const fns = new Array<(v: i32) => i32>(n);
  for (let i = 0; i < n; i++) {
    let offset = i * 2;
    fns[i] = (v: i32): i32 => v + i + offset + sum;
  }
  return fns[0](1);
}
