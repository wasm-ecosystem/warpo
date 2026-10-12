class Box {
  value: i32 = 0;
}

let first = new Box();
let second = new Box();
let receiverCalls = 0;

// A second evaluation selects a different receiver.
function receiver(): Box {
  receiverCalls++;
  return receiverCalls == 1 ? first : second;
}

// Postfix update must evaluate its property receiver once for both load and store.
receiver().value++;

// The update belongs to the receiver selected during the initial evaluation.
assert(receiverCalls == 1);
assert(first.value == 1);
assert(second.value == 0);
