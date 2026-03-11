class FromStatic {
  static value: i32;

  static run(): i32 {
    let getValue = (): i32 => {
      return this.value;
    };
    return getValue();
  }
}

FromStatic.value = 50;
assert(FromStatic.run() == 50);
