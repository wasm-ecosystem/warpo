class Box {
    value: i32;

    constructor(value: i32) {
        this.value = value;
    }
}

function churn(): void {
    for (let i = 0; i < 128; ++i) {
        let box = new Box(i);
        if (box.value == -1) unreachable();
    }
}

function sumTupleRefs(tuple: [i32, i32, i32, Box, i32, i32, Box]): i32 {
    __collect();
    churn();
    return tuple[3].value + tuple[6].value;
}

for (let i = 0; i < 32; ++i) {
    let tuple: [i32, i32, i32, Box, i32, i32, Box] = [1, 2, 3, new Box(10), 4, 5, new Box(20)];
    assert(sumTupleRefs(tuple) == 30);
}