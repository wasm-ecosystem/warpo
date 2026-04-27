export function outer(): () => i32 {
  let x: i32 = 0;

  {
    let x: i32 = 42;

    function innerA(): i32 {
      return x;
    }
    return innerA;
  }
}

assert(outer()() == 42);
