//! { "func": "^.*_start$" }

// it should not be inlined since it is called multiple times
function bigFunc(a: i32, b: i32): void {
  a + b;
  a + b;
  a + b;
  a + b;
  a + b;
  a + b;
  a + b;
  a + b;
  a + b;
  a + b;
  a + b;
  a + b;
  a + b;
  a + b;
  a + b;
  a + b;
  a + b;
  a + b;
  a + b;
  a + b;
  a + b;
  a + b;
  a + b;
  a + b;
  a + b;
  a + b;
  a + b;
  a + b;
  a + b;
  a + b;
  a + b;
  a + b;
  a + b;
  a + b;
  a + b;
  a + b;
  a + b;
  a + b;
  a + b;
}

export function _start(): void {
  bigFunc(1, 2);
  bigFunc(1, 2);
  bigFunc(1, 2);
  bigFunc(1, 2);
  bigFunc(1, 2);
  bigFunc(1, 2);
  bigFunc(1, 2);
  bigFunc(1, 2);
  bigFunc(1, 2);
  bigFunc(1, 2);
  bigFunc(1, 2);
  bigFunc(1, 2);
  bigFunc(1, 2);
}
