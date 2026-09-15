function run(): void {
  let values: i32[] = [1];
  let [a, b] = values;
  assert(a + b == 3);
}

run();
