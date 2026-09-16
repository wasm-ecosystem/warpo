function checkReadonlyArray(values: ReadonlyArray<i32>): void {
  assert(values.length == 4);
  assert(values[1] == 2);
  assert(values.at(-1) == 2);
  assert(
    values.findIndex((value: i32, index: i32, array: ReadonlyArray<i32>) => {
      assert(array[index] == value);
      return value == 3;
    }) == 2
  );
  assert(values.findLastIndex((value) => value == 2) == 3);
  assert(values.includes(3, 0));
  assert(values.indexOf(2, 0) == 1);
  assert(values.lastIndexOf(2, i32.MAX_VALUE) == 3);

  let sum = 0;
  let count = 0;
  values.forEach((value, index, array) => {
    assert(array[index] == value);
    sum += value;
    ++count;
  });
  assert(sum == 8);
  assert(count == values.length);

  assert(values.every((value) => value > 0));
  assert(values.some((value) => value == 3));

  let filtered = values.filter((value) => value % 2 == 0);
  assert(filtered.length == 3);
  assert(filtered[0] == 2);
  assert(filtered[1] == 4);
  assert(filtered[2] == 2);

  let sliced = values.slice(1, 3);
  assert(sliced.length == 2);
  assert(sliced[0] == 2);
  assert(sliced[1] == 3);

  let concatenated = values.concat(values as Array<i32>);
  assert(concatenated.length == 8);
  assert(concatenated[4] == 1);

  assert(values.join("-") == "1-2-3-2");
  assert(values.toString() == "1,2,3,2");

  let iterated = 0;
  for (const value of values) {
    assert(value == values[iterated]);
    ++iterated;
  }
  assert(iterated == values.length);
}

let source = new Array<i32>();
source.push(1);
source.push(2);
source.push(3);
source.push(2);

let values: ReadonlyArray<i32> = source;
checkReadonlyArray(values);

let nestedSource = new Array<Array<i32>>();
nestedSource.push([1, 2]);
nestedSource.push([3, 4]);
let nested: ReadonlyArray<Array<i32>> = nestedSource;
let flattened = nested.flat();
assert(flattened.length == 4);
assert(flattened[0] == 1);
assert(flattened[3] == 4);
