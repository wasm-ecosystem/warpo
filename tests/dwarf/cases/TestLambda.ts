class C1 {
  f1: () => i32;
  constructor(fx: () => i32) {
    this.f1 = fx;
  }
}

let fn = (): i32 => {
  return 1;
};
export const c1 = new C1(fn);
