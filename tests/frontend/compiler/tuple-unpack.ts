let makePairCalls: i32 = 0;

function makePair(value: i32): [i32, string] {
  ++makePairCalls;
  return [value, "tuple"];
}

export function _start(): i32 {
  let [value, text]: [i32, string] = makePair(10);
  assert(makePairCalls == 1);
  assert(text == "tuple");
  return value + text.length + makePairCalls;
}

assert(_start() == 16);
