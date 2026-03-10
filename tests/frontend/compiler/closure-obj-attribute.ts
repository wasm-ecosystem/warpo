class Point {
  x: i32;
  y: i32;
}

export function outer(): i32 {
  let obj = new Point();
  obj.x = 10;
  obj.y = 20;
  function modify(): void {
    obj.x = obj.x + 1;
    obj.y = obj.y + 2;
  }
  modify();
  return obj.x + obj.y;
}

assert(outer() == 33);
