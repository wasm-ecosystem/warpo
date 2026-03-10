export function outer<T>(x: T): T {
  let val = x;
  function inner(): T {
    return val;
  }
  return inner();
}

assert(outer<i32>(42) == 42);

assert(outer<f32>(42) == 42);
