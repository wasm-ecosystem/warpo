class RootedValue {
  constructor(public value: i32) {}
}

function staticReader(): i32 {
  return 7;
}


@inline
const inlineStaticReader: () => i32 = staticReader;
const constantStaticReader: () => i32 = staticReader;
let mutableStaticReader: () => i32 = staticReader;

class ReadonlyFunctions {
  static readonly reader: () => i32 = staticReader;
}


@noinline
function invokeAfterGC(reader: () => i32, allocated: RootedValue): i32 {
  __collect();
  return reader() + allocated.value;
}

function createObjectReader(value: i32): () => i32 {
  const captured = new RootedValue(value);
  return (): i32 => captured.value;
}

const dynamicallyInitializedReader: () => i32 = createObjectReader(200);

assert(invokeAfterGC(staticReader, new RootedValue(35)) == 42);
assert(invokeAfterGC(inlineStaticReader, new RootedValue(35)) == 42);
assert(invokeAfterGC(constantStaticReader, new RootedValue(35)) == 42);
assert(invokeAfterGC(ReadonlyFunctions.reader, new RootedValue(35)) == 42);
assert(invokeAfterGC(mutableStaticReader, new RootedValue(35)) == 42);

__collect();
assert(dynamicallyInitializedReader() == 200);

mutableStaticReader = createObjectReader(123);
__collect();
assert(mutableStaticReader() == 123);
assert(invokeAfterGC(mutableStaticReader, new RootedValue(35)) == 158);
