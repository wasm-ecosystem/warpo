export function getFunction(): () => i32 {
  let aaa = 5;
  return (): i32 => {
    return aaa + 1;
  };
}

export function foo(): i32 {
  return getFunction()();
}

assert(foo() == 6);
