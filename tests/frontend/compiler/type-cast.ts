function typecast(): void {
  let a: u32 = 256;
  let b: u8 = <u8>a;
  assert(b == 0);
}
typecast();

function typpecastWithUnaryPrefix(): void {
  let a: i32 = -100;
  let b: i8 = <i8>-a;
  assert(b == 100);
}
typpecastWithUnaryPrefix();

function typpecastWithUnaryPostfix(): void {
  let a: i32 = 127;
  let b: i8 = <i8>a++;
  assert(a == 128);
  assert(b == 127);
}
typpecastWithUnaryPostfix();
