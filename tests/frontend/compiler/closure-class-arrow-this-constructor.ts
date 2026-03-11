class FromConstructor {
  value: i32;
  fn: () => i32;

  constructor(v: i32) {
    this.value = v;
    this.fn = (): i32 => {
      return this.value;
    };
  }
}

let c = new FromConstructor(20);
assert(c.fn() == 20);
