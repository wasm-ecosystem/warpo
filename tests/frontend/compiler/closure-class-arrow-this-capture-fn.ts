class CaptureFunc {
  value: i32;

  run(): i32 {
    let offset: i32 = 5;
    let add = (a: i32): i32 => {
      return a + offset;
    };
    let compute = (): i32 => {
      return add(this.value);
    };
    return compute();
  }
}

let c = new CaptureFunc();
c.value = 100;
assert(c.run() == 105);
