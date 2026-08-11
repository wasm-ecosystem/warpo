// @ts-nocheck

function identity<T>(value: T): T {
  return value;
}

export function main(): i32 {
  const integer = identity<i32>(42);
  const floating = identity<f64>(3.14);
  return integer + <i32>floating;
}
