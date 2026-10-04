function postfixUpdateCast(): void {
  let v = 1;
  assert(<i32>v++ == 1);
  assert(v == 2);
}

postfixUpdateCast();
