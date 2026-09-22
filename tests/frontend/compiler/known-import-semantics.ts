
@external("builtin", "getF32FromLinkedMemory")
declare function getF32FromLinkedMemory(offset: u32): f32;

function bswap_f32(value: f32): f32 {
  return reinterpret<f32>(bswap<i32>(reinterpret<i32>(value)));
}

export function discardDecodedValue(): void {
  bswap_f32(getF32FromLinkedMemory(0));
}

export function keepDecodedValue(): f32 {
  return bswap_f32(getF32FromLinkedMemory(4));
}
