class Adder {
  base: i32;

  run(): i32 {
    let offset: i32 = 10;
    let modify = (): void => {
      offset = offset + 1;
    };
    modify();
    return this.base + offset;
  }
}

export function test(): i32 {
  let a = new Adder();
  a.base = 5;
  return a.run();
}

assert(test() == 16);
