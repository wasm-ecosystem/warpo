abstract class Base {
  value: string;

  constructor(value: string) {
    this.value = value;
  }
}

class Derived extends Base {
  extra: string;

  constructor() {
    super("base");
    this.extra = "derived";
  }
}

const derived = new Derived();
assert(derived.value == "base");
assert(derived.extra == "derived");
