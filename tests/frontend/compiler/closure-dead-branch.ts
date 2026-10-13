function outerWithUnusedClosure(): i32 {
  let value = 42;
  if (false) {
    // Capture analysis still marks the outer function as closure-related.
    let unused = (): i32 => value;
  }
  return value;
}

assert(outerWithUnusedClosure() == 42);
