let buffer = new ArrayBuffer(4);

// The element count overflows i32 byte-length arithmetic.
// Warpo must reject the view instead of creating an invalid negative length.
Int32Array.wrap(buffer, 0, i32.MAX_VALUE);
