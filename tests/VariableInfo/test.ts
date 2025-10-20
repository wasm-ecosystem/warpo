class C1{
    x: i32;
}

export function test(): i32 {
    var c1 = new C1();
    c1.x = 123;
    return c1.x;
}