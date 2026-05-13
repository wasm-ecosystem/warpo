class FnFieldClass {
  fnField: (() => void) | null = null;
}

export const v = new FnFieldClass();
v.fnField = (): void => {};
const f = v.fnField;
f();
