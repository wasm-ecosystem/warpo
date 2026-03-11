class FromMethod {
  value: i32;

  run(): i32 {
    let getValue = (): i32 => {
      return this.value;
    };
    return getValue();
  }
}

let m = new FromMethod();
m.value = 10;
assert(m.run() == 10);
