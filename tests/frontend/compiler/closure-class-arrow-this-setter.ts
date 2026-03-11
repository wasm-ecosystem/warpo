class FromSetter {
  value: i32;
  stored: i32;

  set update(v: i32) {
    let apply = (): void => {
      this.stored = this.value + v;
    };
    apply();
  }
}

let s = new FromSetter();
s.value = 40;
s.update = 2;
assert(s.stored == 42);
