//! { "func": "^.*_start$" }

// it should be inlined since it is called only once
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
}
