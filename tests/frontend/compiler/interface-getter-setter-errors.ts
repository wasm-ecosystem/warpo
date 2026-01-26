export const disableScriptMode = true;

interface IGetSet {
  get i(): i32;
  set i(value: i32);
}

class MethodInsteadOfProperty implements IGetSet {
  i(): i32 {
    return 1;
  }
}

class WrongType implements IGetSet {
  get i(): string {
    return "1";
  }
  set i(value: string) {}
}

let v: IGetSet = new WrongType();
v.i = 10;
v.i;

interface A {
  get a(): string;
}
class B implements A {
  set a(v: string) {}
}
new B();

interface BaseField {
  a: string;
}
class WithoutField implements BaseField {}
new WithoutField();
