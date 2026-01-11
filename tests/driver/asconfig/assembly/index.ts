/// <reference path="./index.d.ts" />

export function _start(): void {
  assert(USE_VALUE == 10, "USE_VALUE should be 10");
  assert(ASC_FEATURE_NONTRAPPING_F2I == false, "NONTRAPPING_F2I should be disabled");
  trace("asconfig ready");
}
