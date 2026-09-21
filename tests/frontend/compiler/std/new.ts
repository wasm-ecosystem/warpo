class AClass {
  static aStaticField: i32 = 0;
  aField: i32 = 1;
  anotherField: f32 = 2;
  constructor(value: f32) {
    this.aField += 1;
    this.anotherField = value;
  }
}

var aClass = new AClass(3);

assert(AClass.aStaticField == 0);
assert(aClass.aField == 2);
assert(aClass.anotherField == 3.0);
