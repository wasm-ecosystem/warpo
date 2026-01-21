export const disableScriptMode = true;

function testTupleType(): void {
  let tuple: [i32, string] = [1, "2"];
  assert(tuple[0] == 1);
  assert(tuple[1] == "2");

  tuple[0] = 3;
  tuple[1] = "4";
  assert(tuple[0] == 3);
  assert(tuple[1] == "4");
}

function takeTuple(t: [i32, string]): i32 {
  assert(t[0] > 0);
  assert(t[1].length > 0);
  return t[0];
}

function makeTuple(a: i32, b: string): [i32, string] {
  return [a, b];
}

function sumLen(a: i32, b: string): i32 {
  return a + b.length;
}

function testTupleTypeAsParamAndResult(): void {
  let t0: [i32, string] = [7, "abc"];
  assert(takeTuple(t0) == 7);

  let t1: [i32, string] = makeTuple(9, "zz");
  assert(t1[0] == 9);
  assert(t1[1] == "zz");

  let t2: [i32, string] = makeTuple(t0[0] + 1, t0[1] + "d");
  assert(t2[0] == 8);
  assert(t2[1] == "abcd");
}

function testTupleElementsAsArguments(): void {
  let t: [i32, string] = [5, "hello"];
  assert(sumLen(t[0], t[1]) == 10);
  t[0] = 1;
  t[1] = "x";
  assert(sumLen(t[0], t[1]) == 2);
}

function testNestedTupleType(): void {
  let nested: [i32, [i32, string]] = [1, [2, "ok"]];
  assert(nested[0] == 1);
  assert(nested[1][0] == 2);
  assert(nested[1][1] == "ok");

  nested[1][0] = 3;
  nested[1][1] = "yes";
  assert(nested[1][0] == 3);
  assert(nested[1][1] == "yes");
}

function idTuple(t: [i32, string]): [i32, string] {
  return t;
}

function incFirst(t: [i32, string], delta: i32): [i32, string] {
  return [t[0] + delta, t[1]];
}

function combineTuples(a: [i32, string], b: [i32, string]): [i32, string] {
  return [a[0] + b[0], a[1] + b[1]];
}

function makeTriple(a: i32, b: bool, c: string): [i32, bool, string] {
  return [a, b, c];
}

function scoreTriple(t: [i32, bool, string]): i32 {
  if (t[1]) return t[0] + t[2].length;
  return t[0] - t[2].length;
}

function testTupleLiteralAsParameter(): void {
  assert(takeTuple([11, "k"]) == 11);

  let t: [i32, string] = incFirst([1, "x"], 4);
  assert(t[0] == 5);
  assert(t[1] == "x");
}

function testTuplePassThroughAndComposition(): void {
  let t0: [i32, string] = [2, "hi"];
  let t1: [i32, string] = idTuple(t0);
  assert(t1[0] == 2);
  assert(t1[1] == "hi");

  assert(takeTuple(makeTuple(9, "z")) == 9);
  let t2: [i32, string] = combineTuples(makeTuple(1, "a"), makeTuple(2, "b"));
  assert(t2[0] == 3);
  assert(t2[1] == "ab");

  assert(sumLen(makeTuple(5, "hey")[0], makeTuple(5, "hey")[1]) == 8);
}

function testWholeTupleReassignAndConditional(): void {
  let t: [i32, string] = [1, "a"];
  t = makeTuple(2, "b");
  assert(t[0] == 2);
  assert(t[1] == "b");

  let pick: bool = true;
  let t2: [i32, string] = pick ? makeTuple(3, "ccc") : makeTuple(4, "dddd");
  assert(t2[0] == 3);
  assert(t2[1] == "ccc");
}

function testTripleElementTuple(): void {
  let t: [i32, bool, string] = makeTriple(10, true, "abcd");
  assert(t[0] == 10);
  assert(t[1] == true);
  assert(t[2] == "abcd");

  t[0] = 3;
  t[1] = false;
  t[2] = "x";
  assert(t[0] == 3);
  assert(t[1] == false);
  assert(t[2] == "x");

  assert(scoreTriple(makeTriple(7, true, "zz")) == 9);
  assert(scoreTriple(makeTriple(7, false, "zz")) == 5);
}

function makeNested(a: i32, b: i32, s: string): [i32, [i32, string]] {
  return [a, [b, s]];
}

function testNestedTupleAsResultAndArgument(): void {
  let n: [i32, [i32, string]] = makeNested(5, 6, "xy");
  assert(n[0] == 5);
  assert(n[1][0] == 6);
  assert(n[1][1] == "xy");

  assert(takeTuple(n[1]) == 6);

  let t: [i32, string] = incFirst(n[1], 2);
  assert(t[0] == 8);
  assert(t[1] == "xy");

  assert(sumLen(n[1][0], n[1][1]) == 8);
}

testTupleType();
testTupleTypeAsParamAndResult();
testTupleElementsAsArguments();
testNestedTupleType();
testTupleLiteralAsParameter();
testTuplePassThroughAndComposition();
testWholeTupleReassignAndConditional();
testTripleElementTuple();
testNestedTupleAsResultAndArgument();
