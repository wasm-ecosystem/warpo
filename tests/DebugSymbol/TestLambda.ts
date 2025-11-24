class C {
  f: () => void;
  constructor(f: () => void) {
    this.f = f;
  }
}

let fn = (): void => {};
export const c = new C(fn);
