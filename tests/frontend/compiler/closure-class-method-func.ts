class Counter {
  value: i32;

  run(): i32 {
    let delta: i32 = 10;
    function modify(): void {
      delta = delta + 1;
    }
    modify();
    return this.value + delta;
  }
}

export function test(): i32 {
  let c = new Counter();
  c.value = 5;
  return c.run();
}

assert(test() == 16);
