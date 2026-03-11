class MultiLevel {
  value: i32;

  run(): i32 {
    let outer = (): i32 => {
      let inner = (): i32 => {
        return this.value;
      };
      return inner();
    };
    return outer();
  }
}

let m = new MultiLevel();
m.value = 50;
assert(m.run() == 50);
