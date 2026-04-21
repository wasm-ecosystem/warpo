class C1 {
  x: i32;
  constructor(x: i32) {
    this.x = x;
  }
}

let stored: Object | null = null;

function run(cb: (fn: (value: Object) => void) => void): void {
  cb((v: Object): void => {
    stored = v;
  });
}

function make<U>(value: U): void {
  // The parameter name `value` in the function type `(value: Object) => void`
  // must not shadow the outer captured variable `value: U`.
  run((fn: (value: Object) => void) => {
    fn(value);
  });
}

let foo = new C1(42);
make<C1>(foo);
assert((stored as C1).x == 42);
