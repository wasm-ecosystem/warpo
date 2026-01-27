import { equal, isNull } from "./comparison";
import { assertResult } from "./env";
import { toJson } from "./formatPrint";

// @ts-ignore
@inline
const EXPECT_MAX_INDEX = 2147483647;

export class Value<T> {
  reversed: bool = false;
  data: T;
  constructor(_data: T) {
    this.data = _data;
  }

  private collect(
    result: bool,
    codeInfoIndex: number,
    actualValue: string,
    expectValue: string,
  ): void {
    assertResult.collectCheckResult(
      this.reversed ? !result : result,
      codeInfoIndex,
      actualValue,
      expectValue,
    );
  }

  get not(): Value<T> {
    this.reversed = !this.reversed;
    return this;
  }

  isNull(codeInfoIndex: u32 = EXPECT_MAX_INDEX): Value<T> {
    this.collect(
      isNull<T>(this.data),
      codeInfoIndex,
      toJson(this.data),
      "to be null",
    );
    return this;
  }
  notNull(codeInfoIndex: u32 = EXPECT_MAX_INDEX): Value<T> {
    this.collect(
      !isNull<T>(this.data),
      codeInfoIndex,
      toJson(this.data),
      "notNull",
    );
    return this;
  }

  equal(checkValue: T, codeInfoIndex: u32 = EXPECT_MAX_INDEX): Value<T> {
    this.collect(
      equal<T>(this.data, checkValue),
      codeInfoIndex,
      toJson(this.data),
      "= " + toJson(checkValue),
    );
    return this;
  }
  notEqual(checkValue: T, codeInfoIndex: u32 = EXPECT_MAX_INDEX): Value<T> {
    this.collect(
      !equal<T>(this.data, checkValue),
      codeInfoIndex,
      toJson(this.data),
      " != " + toJson(checkValue),
    );
    return this;
  }

  greaterThan(checkValue: T, codeInfoIndex: u32 = EXPECT_MAX_INDEX): Value<T> {
    this.collect(
      this.data > checkValue,
      codeInfoIndex,
      toJson(this.data),
      " > " + toJson(checkValue),
    );
    return this;
  }
  greaterThanOrEqual(
    checkValue: T,
    codeInfoIndex: u32 = EXPECT_MAX_INDEX,
  ): Value<T> {
    this.collect(
      this.data >= checkValue,
      codeInfoIndex,
      toJson(this.data),
      " >= " + toJson(checkValue),
    );
    return this;
  }
  lessThan(checkValue: T, codeInfoIndex: u32 = EXPECT_MAX_INDEX): Value<T> {
    this.collect(
      this.data < checkValue,
      codeInfoIndex,
      toJson(this.data),
      " < " + toJson(checkValue),
    );
    return this;
  }
  lessThanOrEqual(
    checkValue: T,
    codeInfoIndex: u32 = EXPECT_MAX_INDEX,
  ): Value<T> {
    this.collect(
      this.data <= checkValue,
      codeInfoIndex,
      toJson(this.data),
      " <= " + toJson(checkValue),
    );
    return this;
  }

  closeTo(
    checkValue: T,
    delta: number,
    codeInfoIndex: u32 = EXPECT_MAX_INDEX,
  ): Value<T> {
    const data = this.data;
    if (isFloat<T>(checkValue) && isFloat<T>(data)) {
      this.collect(
        abs(data - checkValue) < delta,
        codeInfoIndex,
        toJson(this.data),
        " closeTo " + toJson(checkValue),
      );
    } else {
      ERROR("closeTo should only be used in f32 | f64");
    }
    return this;
  }

  isa<ExpectType>(codeInfoIndex: u32 = EXPECT_MAX_INDEX): Value<T> {
    this.collect(
      // @ts-ignore
      this.data instanceof ExpectType,
      codeInfoIndex,
      // TODO: need extend chain information
      `RTID<${load<u32>(changetype<usize>(this.data) - 8)}>`,
      `RTID<${idof<ExpectType>()}>`,
    );
    return this;
  }

  isExactly<ExpectType>(codeInfoIndex: u32 = EXPECT_MAX_INDEX): Value<T> {
    if (isNullable<T>()) {
      if (this.data == null) {
        this.collect(
          false,
          codeInfoIndex,
          `<<null>>`,
          `RTID<${idof<ExpectType>()}>`,
        );
        return this;
      }
    }
    const rtid = load<u32>(changetype<usize>(this.data) - 8);
    this.collect(
      rtid == idof<ExpectType>(),
      codeInfoIndex,
      `RTID<${rtid}>`,
      `RTID<${idof<ExpectType>()}>`,
    );
    return this;
  }
}
