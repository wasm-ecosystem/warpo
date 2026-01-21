/// <reference path="./index.d.ts" />

export function _start(): void {
  assert(U1 == 11, "U1 should be 11");
  assert(U2 == 12, "U2 should be 12");
  assert(ASC_FEATURE_NONTRAPPING_F2I == false, "NONTRAPPING_F2I should be disabled");
  trace("asconfig ready");
}
