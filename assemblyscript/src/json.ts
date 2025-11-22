import { Expression, JsonSource, Node } from "./ast";
import { DiagnosticCode, DiagnosticEmitter, DiagnosticMessage, Range } from "./diagnostics";
import { Token, Tokenizer } from "./tokenizer";
import { CharCode } from "./util";

export enum JsonValueKind {
  Unknown,
  Object,
  Bool,
  I64,
  F64,
  String,
  Array,
}

export abstract class JsonValue {
  constructor(
    public range: Range,
    public kind: JsonValueKind,
  ) {}

  abstract toExpression(): Expression;
}

// we don't support full json RFC yet.
// mark the rest of object as JsonUnknown  
export class JsonUnknown extends JsonValue {
  constructor(range: Range) {
    super(range, JsonValueKind.Unknown);
  }
  override toExpression(): Expression {
    throw new Error("NYI");
  }
}

export class JsonObject extends JsonValue {
  constructor(
    public keys: string[],
    public values: JsonValue[],
    range: Range,
  ) {
    super(range, JsonValueKind.Object);
  }
  override toExpression(): Expression {
    throw new Error("NYI");
  }
}

export class JsonBool extends JsonValue {
  constructor(
    public value: bool,
    range: Range,
  ) {
    super(range, JsonValueKind.Bool);
  }
  override toExpression(): Expression {
    return this.value ? Node.createTrueExpression(this.range) : Node.createFalseExpression(this.range);
  }
}

export class JsonI64 extends JsonValue {
  constructor(
    public value: i64,
    range: Range,
  ) {
    super(range, JsonValueKind.I64);
  }
  override toExpression(): Expression {
    return Node.createIntegerLiteralExpression(this.value, this.range);
  }
}

export class JsonF64 extends JsonValue {
  constructor(
    public value: f64,
    range: Range,
  ) {
    super(range, JsonValueKind.F64);
  }
  override toExpression(): Expression {
    return Node.createFloatLiteralExpression(this.value, this.range);
  }
}

export class JsonString extends JsonValue {
  constructor(
    public value: string,
    range: Range,
  ) {
    super(range, JsonValueKind.String);
  }
  override toExpression(): Expression {
    return Node.createStringLiteralExpression(this.value, this.range);
  }
}

export class JsonArray extends JsonValue {
  constructor(
    public values: JsonValue[],
    range: Range,
  ) {
    super(range, JsonValueKind.Array);
  }

  get uniqueType(): JsonValueKind {
    const length = this.values.length;
    if (length == 0) {
      return JsonValueKind.Unknown;
    }
    const firstKind = this.values[0].kind;
    for (let i = 1; i < length; i++) {
      if (this.values[i].kind != firstKind) {
        return JsonValueKind.Unknown;
      }
    }
    return firstKind;
  }

  override toExpression(): Expression {
    const length = this.values.length;
    let elements = new Array<Expression>(length)
    for (let i = 0; i < length; i++) {
      elements[i] = this.values[i].toExpression();
    }
    return Node.createArrayLiteralExpression(elements, this.range);
  }
}

export class JsonParser extends DiagnosticEmitter {
  constructor(
    public source: JsonSource,
    diagnostics: DiagnosticMessage[],
  ) {
    super(diagnostics);
  }

  parse(): JsonObject | null {
    const tn = new Tokenizer(this.source, this.diagnostics);
    const v = this.parseValue(tn);
    if (v == null) return null;
    if (!(v instanceof JsonObject)) {
      this.error(DiagnosticCode.Not_implemented_0, tn.range(), "top level scalar value");
      return null;
    }
    if (!tn.skip(Token.EndOfFile)) {
      this.error(DiagnosticCode._0_expected, tn.range(), "EOF");
      return null;
    }
    return v as JsonObject;
  }

  private parseValue(tn: Tokenizer): JsonValue | null {
    const tok = tn.next();
    const start = tn.tokenPos;
    if (tok == Token.OpenBrace) {
      return this.parseObject(tn, start);
    }
    if (tok == Token.OpenBracket) {
      return this.parseArray(tn, start);
    }
    if (tok == Token.StringLiteral) {
      let str = this.parseString(tn);
      if (str == null) return null;
      return new JsonString(str, tn.range(start, tn.pos));
    }
    if (tok == Token.IntegerLiteral) {
      let value = tn.readInteger();
      return new JsonI64(value, tn.range(start, tn.pos));
    }
    if (tok == Token.FloatLiteral) {
      let value = tn.readFloat();
      return new JsonF64(value, tn.range(start, tn.pos));
    }
    if (tok == Token.True || tok == Token.False) {
      return new JsonBool(tok == Token.True, tn.range(start, tn.pos));
    }
    if (tok == Token.Null) {
      return new JsonUnknown(tn.range(start, tn.pos));
    }
    this.error(DiagnosticCode.Unexpected_token, tn.range());
    return null;
  }

  private parseString(tn: Tokenizer): string | null {
    if (this.source.text.charCodeAt(tn.pos) != CharCode.DoubleQuote) {
      return null;
    }
    return tn.readString();
  }

  private parseObject(tn: Tokenizer, start: i32): JsonObject | null {
    // consumed: {
    // expected: "key": value, ... }
    let keys: string[] = []
    let values: JsonValue[] = [];
    if (tn.skip(Token.CloseBrace)) {
      return new JsonObject(keys, values, tn.range(start, tn.pos));
    }
    while (true) {
      if (!tn.skip(Token.StringLiteral)) {
        this.error(DiagnosticCode._0_expected, tn.range(), "json key");
        return null;
      }
      let key = this.parseString(tn);
      if (key == null) {
        this.error(DiagnosticCode._0_expected, tn.range(), "json key");
        return null;
      }
      keys.push(key);

      if (!tn.skip(Token.Colon)) {
        this.error(DiagnosticCode._0_expected, tn.range(), ":");
        return null;
      }

      let v = this.parseValue(tn);
      if (v == null) return null;
      values.push(v);

      if (tn.skip(Token.Comma)) {
        continue;
      } else {
        break;
      }
    }
    if (!tn.skip(Token.CloseBrace)) {
      this.error(DiagnosticCode._0_expected, tn.range(), "}");
      return null;
    }
    return new JsonObject(keys, values, tn.range(start, tn.pos));
  }

  private parseArray(tn: Tokenizer, start: i32): JsonArray | null {
    // consumed: [
    // expected: value, ... ]
    if (tn.skip(Token.CloseBracket)) {
      return new JsonArray([], tn.range(start, tn.pos));
    }
    let values: JsonValue[] = [];
    while (true) {
      let v = this.parseValue(tn);
      if (v == null)
        return null;
      values.push(v);
      if (!tn.skip(Token.Comma))
        break;
    }
    if (!tn.skip(Token.CloseBracket)) {
      this.error(DiagnosticCode._0_expected, tn.range(), "]");
      return null;
    }
    return new JsonArray(values ,tn.range(start, tn.pos));
  }
}
