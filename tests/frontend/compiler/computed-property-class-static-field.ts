namespace computed_property_class_static_field {
  class SymbolWrapper {
    static symbol: symbol = Symbol.for("fn");
  }

  interface IFn {
    [SymbolWrapper.symbol](): string;
  }

  class Fn implements IFn {
    [SymbolWrapper.symbol](): string {
      return "Hello, World!";
    }
  }

  export function test(): void {
    let myfn: IFn = new Fn();
    assert(myfn[SymbolWrapper.symbol]() === "Hello, World!");
  }
}

computed_property_class_static_field.test();
