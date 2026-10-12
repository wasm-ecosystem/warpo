let values = new Int32Array(5);
values[0] = 1;
values[1] = 2;
values[2] = 3;
values[3] = 4;
values[4] = 5;

// An end index before the start index produces an empty source range.
// The operation must be a no-op and leave every element unchanged.
values.copyWithin(0, 3, 2);

assert(values[0] == 1);
assert(values[1] == 2);
assert(values[2] == 3);
assert(values[3] == 4);
assert(values[4] == 5);
