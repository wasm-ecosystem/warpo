import { Source } from "./ast";
import { Range } from "./diagnostics";

export abstract class JsonValue {
  range: Range = Source.native.range;
}

// we don't support full json RFC yet.
// mark the rest of object as JsonUnknown  
export class JsonUnknown extends JsonValue {}

export class JsonObject extends JsonValue {
  constructor(
    public key: string[],
    public value: JsonValue[],
  ) {
    super();
  }
}

export class JsonNumber extends JsonValue {
  constructor(
    public value: f64 = 0
  ) {
    super();
  }
}

export class JsonString extends JsonValue {
  constructor(
    public value: string
  ) {
    super();
  }
}
