class Base {
  id: i32;
  name: string;

  constructor(id: i32, name: string) {
    this.id = id;
    this.name = name;
  }
}

class Derived extends Base {
  value: f32;

  constructor(id: i32, name: string, value: f32) {
    super(id, name);
    this.value = value;
  }
}

export function test(): f32 {
  const d = new Derived(1, "test", 3.14);
  return <f32>d.id + <f32>d.name.length + d.value;
}