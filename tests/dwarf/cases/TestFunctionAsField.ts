class FnFieldClass {
  fnField: (() => i32) | null = null;
}

export const v = new FnFieldClass();
v.fnField = (): i32 => {
  return 0;
};
const f = v.fnField;
f();
