let target = new Uint8Array(1);
let source = new Uint8Array(1);
source[0] = 7;

// The offset plus source length overflows i32 bounds arithmetic.
// Warpo must reject the write instead of reaching an invalid memory.copy.
target.set(source, i32.MAX_VALUE);
