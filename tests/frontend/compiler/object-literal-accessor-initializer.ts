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
// Increment count and call the setter before field reads count.
export function accessorEvaluationOrder(): i32 {
  let count = 0;
  let record = { value: ++count, field: count } as Record;
  return record.field * 10 + record.value;
}
// Each setter receives its own initializer: value gets 2, other gets 3.
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

let setterEffects: i32 = 0;

class OrderedRecord {
  field!: i32;
  defaultField: i32 = 7;
  private stored: i32 = 0;

  set value(next: i32) {
    assert(this.field == 0);
    assert(this.defaultField == 7);
    this.stored = next + this.defaultField;
    this.field = next;
    setterEffects = next;
  }

  get value(): i32 {
    return this.stored;
  }

  set other(next: i32) {
    this.stored += next;
    setterEffects += next;
  }
}

// A later RHS observes the preceding setter's side effects.
export function accessorSetterBeforeLaterInitializer(): i32 {
  setterEffects = 0;
  let record = { value: 2, field: setterEffects } as OrderedRecord;
  return record.field;
}

// Setters see class defaults, not values from later explicit members.
export function accessorReadsLaterFieldDefaults(): i32 {
  let record = { value: 2, defaultField: 20, field: 3 } as OrderedRecord;
  assert(record.defaultField == 20);
  assert(record.field == 3);
  return record.value;
}

// Later explicit writes override values written by a preceding setter.
export function accessorBeforeLaterFieldWrite(): i32 {
  let record = { value: 2, field: 3 } as OrderedRecord;
  return record.field;
}

// Setter calls and RHS evaluations interleave in source order.
export function accessorSetterEvaluationOrder(): i32 {
  setterEffects = 0;
  let record = { value: 2, other: setterEffects } as OrderedRecord;
  assert(setterEffects == 4);
  return record.value;
}

assert(accessorInitializer() == 9);
assert(accessorEvaluationOrder() == 11);
assert(multipleAccessorInitializers() == 23);
assert(accessorInitializesOmittedFields() == 7);
assert(accessorSetterBeforeLaterInitializer() == 2);
assert(accessorReadsLaterFieldDefaults() == 9);
assert(accessorBeforeLaterFieldWrite() == 3);
assert(accessorSetterEvaluationOrder() == 11);
