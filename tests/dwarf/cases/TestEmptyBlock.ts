export function test(): i32 {
  let value = 1;

  {
    type LocalAlias = i32;
  }

  return value;
}
