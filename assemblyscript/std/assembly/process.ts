export namespace process {
  // @ts-ignore: decorator
  @lazy export const arch = sizeof<usize>() == 4 ? "wasm32" : "wasm64";

  // @ts-ignore: decorator
  @lazy export const platform = "wasm";
}
