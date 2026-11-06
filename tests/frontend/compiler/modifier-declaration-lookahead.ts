namespace N {
  export export type();
  export export namespace();
  declare declare type();
  declare declare import { a as value } from "./export";
}

export export type();
export export namespace();

declare declare type();
declare declare import { a as value } from "./export";

function laterError(): i32 {
  return "bad";
}

laterError();
ERROR("EOF");