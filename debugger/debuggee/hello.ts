// @ts-nocheck

class Child {
  value: i32;

  constructor(value: i32) {
    this.value = value;
  }
}

export function main(): i32 {
  return run();
}

function run(): i32 {
  let outerA: i32 = 1;
  let child = new Child(77);

  function middle(): i32 {
    let middleA: i32 = 10;

    function inner(): i32 {
      let innerA: i32 = 100;
      let result: i32 = 0;

      for (let i: i32 = 0; i < 1; i++) {
        let loopA: i32 = 1000;
        if (innerA > 0) {
          let ifA: i32 = 10000;
          const readCaptured = (delta: i32): i32 => {
            let inside: i32 = outerA + child.value + middleA + innerA + loopA + ifA + delta;
            return inside;
          };
          result = applyClosure(readCaptured, 5);
        }
      }

      return result;
    }

    return inner();
  }

  return middle();
}

function applyClosure(fn: (delta: i32) => i32, delta: i32): i32 {
  return fn(delta);
}
