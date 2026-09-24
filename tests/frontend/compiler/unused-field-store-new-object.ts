class A {
  data: i32 = 1;
}

class B {
  a: A = new A();
  v: i32 = 2;
}

let bbb = new B();
assert(bbb.v == 2);
