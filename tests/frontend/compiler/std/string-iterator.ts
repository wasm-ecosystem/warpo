export function string_iterator_basic(): void {
  const s = "abc";
  const it = s[Symbol.iterator]();
  assert(it.next().value == "a");
  assert(it.next().value == "b");
  assert(it.next().value == "c");
  assert(it.next().done);
}
string_iterator_basic();

export function string_iterator_surrogate_pair(): void {
  const grin = String.fromCodePoint(0x1f600);
  const s = "A" + grin + "B";
  const it = s[Symbol.iterator]();
  assert(it.next().value == "A");
  assert(it.next().value == grin);
  assert(it.next().value == "B");
  assert(it.next().done);
}
string_iterator_surrogate_pair();

export function string_iterator_4byte_utf16_char(): void {
  const c = String.fromCodePoint(0x20bb7); // U+20BB7
  const s = "x" + c + "y";
  const it = s[Symbol.iterator]();
  assert(it.next().value == "x");
  assert(it.next().value == c);
  assert(it.next().value == "y");
  assert(it.next().done);
}
string_iterator_4byte_utf16_char();
