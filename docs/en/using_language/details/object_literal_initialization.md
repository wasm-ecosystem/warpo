# Class Object Literal Initialization Order

<p style="display: flex; gap: 10px;">
	<img src="/version/nightly.svg" alt="nightly" />
	<img src="/stability/experimental.svg" alt="experimental" />
</p>

Both WARPO and AssemblyScript support class object literal initialization. WARPO fixes an AssemblyScript bug and changes the initialization order, making this a breaking bug fix.

## Evaluation Order

WARPO initializes a class-backed object literal in this order:

1. Allocate the instance and run its generated constructor, applying declared field initializers.
2. Initialize omitted fields that have no declared initializer with their defaults, such as zero for numeric fields.
3. Evaluate each literal member from left to right and immediately write the field or call its setter.
4. Return the initialized instance.

For example:

```ts
class Record {
  field: i32;
  defaultField: i32 = 7;
  private stored: i32 = 0;

  set value(next: i32) {
    this.stored = next + this.defaultField;
    this.field = next;
  }

  get value(): i32 {
    return this.stored;
  }
}

let record = { value: 2, defaultField: 20, field: 3 } as Record;
```

When the `value` setter runs, `defaultField` still has its declared default of `7`, so `stored` becomes `9` and `field` becomes `2`. The literal then assigns `defaultField: 20` and `field: 3`. The final values are `record.value == 9`, `record.defaultField == 20`, and `record.field == 3`.

Each setter completes before the next member's value expression is evaluated. Later value expressions can observe earlier setter side effects, and later explicit fields can overwrite values written by an earlier setter.
