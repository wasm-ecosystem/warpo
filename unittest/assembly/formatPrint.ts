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
    const jsonchars: string[] = [];
    for (let i = 0; i < str.length; i++) {
      const charCode = str.charCodeAt(i);
      if (
        (charCode >= 0x20 && charCode <= 0x21) ||
        (charCode >= 0x23 && charCode <= 0x5b) ||
        (charCode >= 0x5d && charCode <= 0xffff)
      ) {
        jsonchars.push(str.charAt(i));
      } else {
        switch (charCode) {
          case 0x00:
            jsonchars.push("\\0");
            break;
          case 0x07:
            jsonchars.push("\\a");
            break;
          case 0x08:
            jsonchars.push("\\b");
            break;
          case 0x09:
            jsonchars.push("\\t");
            break;
          case 0x0a:
            jsonchars.push("\\n");
            break;
          case 0x0b:
            jsonchars.push("\\v");
            break;
          case 0x0c:
            jsonchars.push("\\f");
            break;
          case 0x0d:
            jsonchars.push("\\r");
            break;
          case 0x22:
            jsonchars.push('\\"');
            break;
          case 0x5c:
            jsonchars.push("\\\\");
            break;
          default: {
            // unknown control code
            const charCodeStr = charCode.toString();
            jsonchars.push("\\u");
            for (let i = charCodeStr.length; i < 4; i++) {
              jsonchars.push("0");
            }
            jsonchars.push(charCodeStr);
          }
        }
      }
    }
    return '"' + jsonchars.join("") + '"';
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
