import { ffi } from "warpo/ffi";

declare function multi_return_api(): ffi.MultiReturn<[i32, i32]>;

let inferredGlobal = multi_return_api();
let annotatedGlobal: ffi.MultiReturn<[i32, i32]> = multi_return_api();

class C {
  f: ffi.MultiReturn<[i32, i32]>;
}

function annotatedLocal(): void {
  let x: ffi.MultiReturn<[i32, i32]>;
}

function inferredLocal(): void {
  let x = multi_return_api();
}

function annotatedParam(x: ffi.MultiReturn<[i32, i32]>): void {}

function annotatedReturn(): ffi.MultiReturn<[i32, i32]> {
  return multi_return_api();
}

annotatedLocal();
inferredLocal();
annotatedParam(multi_return_api());
annotatedReturn();
new C();

ERROR("EOF");
