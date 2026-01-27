export function isNull<T>(a: T): bool {
  if (!isReference<T>(a)) {
    ERROR("paramemter of isNull should be a reference type");
  }
  if (!isNullable<T>(a)) {
    ERROR("paramemter of isNull should be nullable");
  }
  return a == null;
}

function includes<T>(set: T[], value: T): bool {
  for (let i = 0; i < set.length; i++) {
    if (equal<T>(set[i], value)) {
      return true;
    }
  }
  return false;
}

function equalArrayBuffer<T>(a: T, b: T): bool {
  if (!(a instanceof ArrayBuffer) || !(b instanceof ArrayBuffer)) {
    return false;
  }
  if (a.byteLength != b.byteLength) {
    return false;
  }
  const aRef = changetype<i32>(a);
  const bRef = changetype<i32>(b);
  const wordSize = a.byteLength / 4;
  const remainder = a.byteLength % 4;
  for (let i = 0; i < wordSize; i++) {
    if (load<u32>(aRef + i * 4) != load<u32>(bRef + i * 4)) {
      return false;
    }
  }
  for (let i = 0; i < remainder; i++) {
    if (
      load<u8>(aRef + wordSize * 4 + i) != load<u8>(bRef + wordSize * 4 + i)
    ) {
      return false;
    }
  }
  return true;
}

function equalArrayLike<T>(a: T, b: T): bool {
  if (!isArrayLike<T>(a) || !isArrayLike<T>(b)) {
    return false;
  }
  if (a.length != b.length) {
    return false;
  }
  for (let i = 0; i < a.length; i++) {
    if (!equal(a[i], b[i])) {
      return false;
    }
  }
  return true;
}

function equalMap<T, U>(a: Map<T, U>, b: Map<T, U>): bool {
  const a_key: T[] = a.keys();
  const b_key: T[] = b.keys();
  if (a_key.length != b_key.length) {
    return false;
  }
  for (let i = 0; i < a_key.length; i++) {
    const k: T = a_key[i];
    if (!includes(b_key, k)) {
      return false;
    }
    if (!equal(a.get(k), b.get(k))) {
      return false;
    }
  }
  return true;
}

function equalSet<T>(a: Set<T>, b: Set<T>): bool {
  if (a.size != b.size) {
    return false;
  }
  const va: T[] = a.values();
  const vb: T[] = b.values();
  for (let i = 0; i < va.length; i++) {
    if (!includes(vb, va[i])) {
      return false;
    }
  }
  return true;
}

export function equal<T>(a: T, b: T): bool {
  if (!isReference<T>() || isString<T>()) {
    return a == b;
  }
  if (isNullable(a) || isNullable(b)) {
    if (isNull(a) && isNull(b)) {
      return true;
    }
    if ((isNull(a) && !isNull(b)) || (!isNull(a) && isNull(b))) {
      return false;
    }
  }
  const nonnull_a = <NonNullable<T>>a;
  const nonnull_b = <NonNullable<T>>b;
  if (nonnull_a instanceof ArrayBuffer && nonnull_b instanceof ArrayBuffer) {
    return equalArrayBuffer<NonNullable<T>>(nonnull_a, nonnull_b);
  }
  if (isArrayLike<T>(nonnull_a) && isArrayLike<T>(nonnull_b)) {
    return equalArrayLike<NonNullable<T>>(nonnull_a, nonnull_b);
  }
  if (nonnull_a instanceof Map && nonnull_b instanceof Map) {
    return equalMap(nonnull_a, nonnull_b);
  }
  if (nonnull_a instanceof Set && nonnull_b instanceof Set) {
    return equalSet(nonnull_a, nonnull_b);
  }
  ERROR(
    "type is not supported to equal, hint: cannot comparison user-defined object",
  );
  return false;
}
