// @ts-nocheck

class Child {
  value: i32;

  constructor(value: i32) {
    this.value = value;
  }
}

export function _start(): i32 {
  return run();
}

function run(): i32 {
  let outerA: i32 = 1;
  let child = new Child(77);
  let runNotCaptured: i32 = 3;

  function middle(): i32 {
    let middleA: i32 = 10;
    let middleNotCaptured: i32 = 7;

    function inner(): i32 {
      let innerA: i32 = 100;
      let result: i32 = 0;

      if (innerA > 0) {
        let scopeNotCaptured: i32 = 11;
        for (let i: i32 = 0; i < 1; i++) {
          let loopA: i32 = 1000;
          if (innerA > 0) {
            let ifA: i32 = 10000;
            const readCaptured = (delta: i32): i32 => {
              let inside: i32 = outerA + child.value + middleA + innerA + loopA + ifA + delta;
              if (inside > 0) {
                return inside;
              }
              return 0;
            };
            result = applyClosure(readCaptured, 5);
          }
        }
        result += scopeNotCaptured;
      }

      return result;
    }

    return inner() + middleNotCaptured;
  }

  return middle() + runNotCaptured;
}

function applyClosure(fn: (delta: i32) => i32, delta: i32): i32 {
  return fn(delta);
}
