class Record {
  field: i32 = 0;
  private stored: i32 = 0;
  private otherStored: i32 = 0;

  set value(next: i32) {
    this.stored = next;
  }

  get value(): i32 {
    return this.stored;
  }

  set other(next: i32) {
    this.otherStored = next;
  }

  get other(): i32 {
    return this.otherStored;
  }
}

export function accessorInitializer(): i32 {
  return ({ field: 7, value: 9 } as Record).value;
}

export function accessorEvaluationOrder(): i32 {
  let count = 0;
  let record = { value: ++count, field: count } as Record;
  return record.field * 10 + record.value;
}

export function multipleAccessorInitializers(): i32 {
  let record = { field: 1, value: 2, other: 3 } as Record;
  return record.value * 10 + record.other;
}

assert(accessorInitializer() == 9);
assert(accessorEvaluationOrder() == 11);
assert(multipleAccessorInitializers() == 23);
