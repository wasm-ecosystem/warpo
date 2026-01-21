export const disableScriptMode = true;

class A {
  field: [i32, string];

  constructor(p0: i32, p1: string) {
    this.field = [p0, p1];
  }
}

const a = new A(10, "test");
assert(a.field[0] == 10);
assert(a.field[1] == "test");
