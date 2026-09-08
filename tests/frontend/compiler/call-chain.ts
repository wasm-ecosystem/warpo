class B {
  b: i32;
}

class A {
  num: i32 = 0;
  foo(): A {
    let b = new B();
    this.num += b.b;
    this.num += b.b;
    this.num += b.b;
    this.num += b.b;
    this.num += b.b;
    this.num += b.b;
    this.num += b.b;
    this.num += b.b;
    this.num += b.b;
    this.num += b.b;
    this.num += b.b;
    this.num += b.b;
    this.num += b.b;
    this.num += b.b;
    this.num += b.b;
    this.num += b.b;
    this.num += b.b;
    this.num += b.b;
    this.num += b.b;
    this.num += b.b;
    this.num += b.b;
    this.num += b.b;
    this.num += b.b;
    this.num += b.b;
    this.num += b.b;
    this.num += b.b;
    this.num += b.b;
    this.num += b.b;
    this.num += b.b;
    this.num += b.b;
    return this;
  }
  bar(): A {
    let b = new B();
    this.num += b.b + 2;
    this.num += b.b + 2;
    this.num += b.b + 2;
    this.num += b.b + 2;
    this.num += b.b + 2;
    this.num += b.b + 2;
    this.num += b.b + 2;
    this.num += b.b + 2;
    this.num += b.b + 2;
    this.num += b.b + 2;
    this.num += b.b + 2;
    this.num += b.b + 2;
    this.num += b.b + 2;
    this.num += b.b + 2;
    this.num += b.b + 2;
    this.num += b.b + 2;
    this.num += b.b + 2;
    this.num += b.b + 2;
    this.num += b.b + 2;
    this.num += b.b + 2;
    this.num += b.b + 2;
    this.num += b.b + 2;
    this.num += b.b + 2;
    this.num += b.b + 2;
    this.num += b.b + 2;
    this.num += b.b + 2;
    this.num += b.b + 2;
    this.num += b.b + 2;
    this.num += b.b + 2;
    this.num += b.b + 2;
    return this;
  }
  createAnotherObject(): A {
    return new A();
  }
  yoo(): A {
    return this;
  }
}

export function main(): void {
  let a = new A();
  a.foo().foo().bar().createAnotherObject().yoo().yoo().bar();
  assert(a.num == 60);
}
