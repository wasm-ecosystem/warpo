const computed_property_symbol = Symbol.for("fn");

interface IComputedPropertyFn {
  [computed_property_symbol](): string;
}

class ComputedPropertyFn implements IComputedPropertyFn {
  [computed_property_symbol](): string {
    return "Hello, World!";
  }
}

let myfn: IComputedPropertyFn = new ComputedPropertyFn();
assert(myfn[computed_property_symbol]() === "Hello, World!");
