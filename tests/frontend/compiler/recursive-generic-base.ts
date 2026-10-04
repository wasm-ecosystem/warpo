class A<T> {
  value: T | null;
}

class B extends A<B> {}

const b = new B();
b.value = b;
assert(b.value === b);
