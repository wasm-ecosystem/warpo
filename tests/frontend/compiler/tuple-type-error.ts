function testTupleTypeError(): void {
  let type_mismtach: [i32, i32] = [1, "2"];

  let out_of_index: [i32, string] = [1, "2"];
  out_of_index[3];
}

testTupleTypeError();
