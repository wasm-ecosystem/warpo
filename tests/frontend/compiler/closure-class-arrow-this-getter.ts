class FromGetter {
  value: i32;

  get result(): i32 {
    let getValue = (): i32 => {
      return this.value;
    };
    return getValue();
  }
}

let g = new FromGetter();
g.value = 30;
assert(g.result == 30);
