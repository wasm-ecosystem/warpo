let abstract = 1;
// prettier-ignore
abstract
class C {
  value: i32 = 42;
}

assert(abstract == 1);
assert(new C().value == 42);
