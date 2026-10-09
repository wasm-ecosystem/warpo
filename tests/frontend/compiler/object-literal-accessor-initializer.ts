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
// The setter must receive 9, not the preceding field's value (7).
export function accessorInitializer(): i32 {
  return ({ field: 7, value: 9 } as Record).value;
}
// Increment count before field reads it, even though the setter call is deferred.
export function accessorEvaluationOrder(): i32 {
  let count = 0;
  let record = { value: ++count, field: count } as Record;
  return record.field * 10 + record.value;
}
// Each deferred setter must retain its own argument: value gets 2, other gets 3.
export function multipleAccessorInitializers(): i32 {
  let record = { field: 1, value: 2, other: 3 } as Record;
  return record.value * 10 + record.other;
}

class SetterInitializedRecord {
  field!: i32;
  floatingField!: f64;

  set value(next: i32) {
    assert(this.field == 0);
    assert(this.floatingField == 0);
    this.field = next;
    this.floatingField = <f64>next + 0.5;
  }
}

export function accessorInitializesOmittedFields(): i32 {
  let record = { value: 7 } as SetterInitializedRecord;
  assert(record.floatingField == 7.5);
  return record.field;
}

assert(accessorInitializer() == 9);
assert(accessorEvaluationOrder() == 11);
assert(multipleAccessorInitializers() == 23);
assert(accessorInitializesOmittedFields() == 7);
