export function add(a: i32, b: i32): i32 {
  return a + b;
}

export const callee = (): i32 => {
  return 100;
};

export function caller(cb: () => i32): i32 {
  return cb();
}

export function incr(value: u32, offset: u32 = 1): u32 {
  return value + offset;
}

export function call_incr(cb: (value: u32, offset?: u32) => u32): u32 {
  return cb(100) + cb(100, 20);
}

function print(msg: string): string {
  return `mock class: ${msg}`;
}

export class MockClass {
  myLog: (msg: string) => string;

  constructor() {
    this.myLog = (msg: string): string => {
      return print("[debug] " + msg);
    };
  }
}
