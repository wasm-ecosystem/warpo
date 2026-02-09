
export function foo(): i64{
    let pair: [i32, i64] = [1, 2];
    let aaa = pair[0];
    let bbb = pair[1];
    let pair2: [i32, i64] = [1, 2];
    return aaa + bbb + pair2[0] + pair2[1];
}

class ClassWithTupleMember {
    member: [i32, i64];
    
    constructor() {
        this.member = [3, 4];
    }
}

export function bar(): i64 {
    let obj = new ClassWithTupleMember();
    let val1 = obj.member[0];
    let val2 = obj.member[1];
    return val1 + val2;
}