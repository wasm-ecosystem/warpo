export function main(condition: bool): i32 {
  switch (condition) {
    case true:
      return 0;
    default:
      return 1;
      break;
  }
}
assert(main(true) == 0);
assert(main(false) == 1);
