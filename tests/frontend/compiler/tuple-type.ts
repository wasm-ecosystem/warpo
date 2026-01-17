function testTupleType(): void {
  let tuple: [i32, string] = [1, "2"];
  assert(tuple[0] == 1);
  assert(tuple[1] == "2");

  tuple[0] = 3;
  tuple[1] = "4";
  assert(tuple[0] == 3);
  assert(tuple[1] == "4");
}
testTupleType();
