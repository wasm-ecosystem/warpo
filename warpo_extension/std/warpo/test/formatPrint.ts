// Copyright (C) 2025 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

export function toJson<T>(v: T): string {
  if (isNullable(v) && v == null) {
    return "null";
  }
  if (isBoolean<T>(v)) {
    return v ? "true" : "false";
  }
  if (isInteger<T>(v) || isFloat<T>(v) || isFunction<T>(v)) {
    return v.toString();
  }
  if (isString<T>(v)) {
    const str: string = v.toString();
    const jsonChars: string[] = [];
    for (let i = 0; i < str.length; i++) {
      const charCode = str.charCodeAt(i);
      if (
        (charCode >= 0x20 && charCode <= 0x21) ||
        (charCode >= 0x23 && charCode <= 0x5b) ||
        (charCode >= 0x5d && charCode <= 0xffff)
      ) {
        jsonChars.push(str.charAt(i));
      } else {
        switch (charCode) {
          case 0x00:
            jsonChars.push("\\0");
            break;
          case 0x07:
            jsonChars.push("\\a");
            break;
          case 0x08:
            jsonChars.push("\\b");
            break;
          case 0x09:
            jsonChars.push("\\t");
            break;
          case 0x0a:
            jsonChars.push("\\n");
            break;
          case 0x0b:
            jsonChars.push("\\v");
            break;
          case 0x0c:
            jsonChars.push("\\f");
            break;
          case 0x0d:
            jsonChars.push("\\r");
            break;
          case 0x22:
            jsonChars.push('\\"');
            break;
          case 0x5c:
            jsonChars.push("\\\\");
            break;
          default: {
            // unknown control code
            const charCodeStr = charCode.toString();
            jsonChars.push("\\u");
            for (let i = charCodeStr.length; i < 4; i++) {
              jsonChars.push("0");
            }
            jsonChars.push(charCodeStr);
          }
        }
      }
    }
    return '"' + jsonChars.join("") + '"';
  }
  if (v instanceof ArrayBuffer) {
    const tmpArray = Uint8Array.wrap(v);
    const tmpStrArray = new Array<string>(tmpArray.length);
    for (let i = 0; i < tmpArray.length; i++) {
      tmpStrArray[i] = tmpArray[i].toString();
    }
    return `[${tmpStrArray.join(", ")}]`;
  }
  if (isArray<T>(v) || isArrayLike<T>(v)) {
    const tempStrArray = new Array<string>(v.length);
    for (let i = 0, k = v.length; i < k; i++) {
      tempStrArray[i] = toJson(v[i]);
    }
    return `[${tempStrArray.join(", ")}]`;
  }
  if (v instanceof Set) {
    return toJson(v.values());
  }
  if (v instanceof Map) {
    const key = v.keys();
    const value = v.values();
    const tempStrArray = new Array<string>();
    for (let i = 0; i < key.length; i++) {
      tempStrArray[i] = toJson(key[i]) + " : " + toJson(value[i]);
    }
    return `{ ${tempStrArray.join(", ")} }`;
  }
  return "[Object " + nameof<T>(v) + "]";
}
