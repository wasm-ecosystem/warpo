function testTupleTypeError(): void {
  type TupleType = [number, TupleType]; // error for recursive tuple type
}
testTupleTypeError();
