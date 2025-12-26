# Computed Property Names

Computed Property Names is a feature in TypeScript/JavaScript that allows us to use expressions to dynamically define property names within object literals. This is particularly useful when you need to dynamically create methods based on runtime conditions.

In AssemblyScript, everything should be static, it is hard to implement computed property name as powerful as TypeScript.<br/>
However, we can combine it with symbols to avoid the problem of duplicated function names for some special functions.<br/>
It can give user change to create their own standard libarary.

## Limitation

In AssemblyScript, we hope everything is static, TS/JS computed property name will break this assumption. So we will limit it to fulfill static requirements.

- computed property name must be referenced to a const global.<br/>
  Actually, warpo implement computed property name according to global's unique name instead of the runtime value.<br/>
  For example, computed property name is referenced `a` in `assembly/index.ts`, it will be convert to a unique name `[assembly/index/a]`.

## Usage

### Computed Property Names as Method Name

<p style="display: flex; gap: 10px;">
  <img src="/version/nightly.svg" />
  <img src="/stability/stable.svg"  />
</p>

Here is an example to declare a interface `IComputedPropertyFn` which requires a special method `[computed_property_symbol]`.<br/>
Then `ComputedPropertyFn` implements `IComputedPropertyFn`.<br/>
The method can only be accessed via the symbol reference `computed_property_symbol`.

```ts
const computed_property_symbol = Symbol.for("fn");

interface IComputedPropertyFn {
  [computed_property_symbol](): string;
}
class ComputedPropertyFn implements IComputedPropertyFn {
  [computed_property_symbol](): string {
    return "Hello, World!";
  }
}
let f: IComputedPropertyFn = new ComputedPropertyFn();
assert(f[computed_property_symbol]() === "Hello, World!");
```

It is useful for internal APIs where method names shouldn't conflict with other code

### other

not yet implemented.
