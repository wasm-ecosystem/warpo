function test_string(): void {
  var a = "a";
  var b = "b";
  assert(`${a}` == "a");
  assert(`${a}${b}` == "ab");
  assert(`(A=${a}, B=${b})` == "(A=a, B=b)");
}
test_string();

function test_integer(): void {
  var a = 1;
  var b = 2;
  assert(`${a}` == "1");
  assert(`${a}${b}` == "12");
  assert(`(A=${a}, B=${b})` == "(A=1, B=2)");
}
test_integer();

function test_float(): void {
  var a = 1.0;
  var b = 2.0;
  assert(`${a}` == "1.0");
  assert(`${a}${b}` == "1.02.0");
  assert(`(A=${a}, B=${b})` == "(A=1.0, B=2.0)");
}
test_float();

function test_fast_paths_string(): void {
  var a = 2;
  var b = "b";
  assert(`${a}` == "2");
  assert(`${b}` == "b");
  assert(`pref${a}` == "pref2");
  assert(`pref${b}` == "prefb");
  assert(`${a}suff` == "2suff");
  assert(`${b}suff` == "bsuff");
  assert(`${a}${b}` == "2b");
}
test_fast_paths_string();

class Ref {
  constructor(public value: i32) {}
  toString(): string {
    return "ref#" + this.value.toString();
  }
}

function test_ref(): void {
  var a = new Ref(1);
  var b = new Ref(2);
  assert(`${a}` == "ref#1");
  assert(`${a}${b}` == "ref#1ref#2");
  assert(`(A=${a}, B=${b})` == "(A=ref#1, B=ref#2)");
}
test_ref();

function test_null(): void {
  var c: Ref | null = new Ref(3);
  var d: Ref | null = null;
  assert(`c: ${c}; d: ${d}` == "c: ref#3; d: null");
}
test_null();

function tag(parts: TemplateStringsArray, a: i32, b: i32): string {
  var raw = parts.raw;
  assert(parts.length == 3);
  assert(raw.length == 3);
  assert(parts[0] == "a");
  assert(raw[0] == "a");
  assert(parts[1] == "b");
  assert(raw[1] == "b");
  assert(parts[2] == "a");
  assert(raw[2] == "a");
  assert(parts.at(-1) == "a");
  assert(raw.at(1) == "b");

  assert(
    parts.findIndex((value: string, index: i32, array: ReadonlyArray<string>) => {
      assert(array[index] == value);
      return value == "b";
    }) == 1
  );
  assert(parts.findLastIndex((value) => value == "a") == 2);
  assert(parts.includes("b", 0));
  assert(parts.indexOf("a", 0) == 0);
  assert(parts.lastIndexOf("a", i32.MAX_VALUE) == 2);

  var forEachResult = "";
  var count = 0;
  parts.forEach((value, index, array) => {
    assert(array[index] == value);
    forEachResult += value + index.toString();
    ++count;
  });
  assert(forEachResult == "a0b1a2");
  assert(count == parts.length);

  var mapped = parts.map<string>((value, index, array) => {
    assert(array[index] == value);
    return value + index.toString();
  });
  assert(mapped.join("") == "a0b1a2");

  var filtered = parts.filter((value) => value == "a");
  assert(filtered.length == 2);
  assert(filtered[0] == "a");
  assert(filtered[1] == "a");

  var reduced = parts.reduce<string>(
    (previousValue, currentValue, currentIndex) => previousValue + currentValue + currentIndex.toString(),
    ""
  );
  assert(reduced == "a0b1a2");

  var reducedRight = parts.reduceRight<string>(
    (previousValue, currentValue, currentIndex) => previousValue + currentValue + currentIndex.toString(),
    ""
  );
  assert(reducedRight == "a2b1a0");

  assert(parts.every((value) => value.length > 0));
  assert(parts.some((value) => value == "b"));

  var other = new Array<string>();
  other.push("c");
  var concatenated = parts.concat(other);
  assert(concatenated.length == 4);
  assert(concatenated[3] == "c");

  var sliced = parts.slice(1, 3);
  assert(sliced.length == 2);
  assert(sliced[0] == "b");
  assert(sliced[1] == "a");

  assert(parts.join("-") == "a-b-a");
  assert(parts.toString() == "a,b,a");

  var iterated = "";
  for (const value of parts) iterated += value;
  assert(iterated == "aba");
  assert(a == 1);
  assert(b == 2);
  return parts[0] + a.toString() + parts[1] + b.toString() + parts[2];
}

function test_tag(): void {
  assert(tag`a${1}b${2}a` == "a1b2a");
}
test_tag();

function tagGeneric<T, U>(strings: T, val: U): string {
  assert(nameof<T>() == nameof<TemplateStringsArray>());
  assert(nameof<U>() == nameof<i32>());
  return "generic";
}

let num: i32 = 123;
assert(tagGeneric`Count: ${num}` == "generic");

function identity_tag(parts: TemplateStringsArray): TemplateStringsArray {
  return parts;
}

function test_tag_template_identity(): void {
  var first: TemplateStringsArray | null = null;
  for (var i: i32 = 0; i < 2; ++i) {
    var current = identity_tag`identity`;
    if (first != null) assert(first === current);
    first = current;
  }
}
test_tag_template_identity();

function raw(parts: TemplateStringsArray): string {
  return parts.raw.join("");
}

function test_raw(): void {
  assert(raw`` == "");
  assert(raw`\u` == "\\u");
  assert(raw`\u1` == "\\u1");
  assert(raw`\u1000` == "\\u1000");
}
test_raw();

class RecursiveObject {
  constructor(
    public key: string,
    public val: RecursiveObject | null = null
  ) {}
  toString(): string {
    let val = this.val;
    if (!val) return this.key;
    // see: https://github.com/AssemblyScript/assemblyscript/issues/1944
    // trigger general case by wrapping three times below (2x with value)
    return `${this.key}:${val}`;
  }
}

function test_recursive(): void {
  const c = new RecursiveObject("c");
  const b = new RecursiveObject("b", c);
  const a = new RecursiveObject("a", b);
  assert(a.toString() == "a:b:c");
}
test_recursive();
