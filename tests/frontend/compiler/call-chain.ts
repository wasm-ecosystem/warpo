class A {
  num: i32 = 0;
  foo(): A {
    this.num += 1;
    return this;
  }
  bar(): A {
    this.num += 2;
    return this;
  }
}

export function main(): void {
  let a = new A();
  a.foo().foo().bar();
  assert(a.num == 4);
}
