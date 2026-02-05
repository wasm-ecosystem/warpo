class C1 {
  f1: () => void;
  constructor(fx: () => void) {
    this.f1 = fx;
  }
}

let fn = (): void => {};
export const c1 = new C1(fn);
