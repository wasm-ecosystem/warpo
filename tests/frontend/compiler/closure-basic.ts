export function outer(x: i32): i32 {
  let aaa = x;
  function inner(): i32 {
    return aaa + 1;
  }
  return inner();
}

assert(outer(5) == 6);

function createReaderCapturing(capturedValue: i32): () => i32 {
  return (): i32 => capturedValue;
}

const globallyRootedClosure = createReaderCapturing(7);
let replacementClosure: (() => i32) | null = null;

assert(globallyRootedClosure() == 7);
// The global function reference must keep its closure and captured environment alive.
__collect();
// A new closure can reuse storage released by the collection.
replacementClosure = createReaderCapturing(99);
assert(globallyRootedClosure() == 7);
