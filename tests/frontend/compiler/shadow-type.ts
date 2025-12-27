// issue: https://github.com/wasm-ecosystem/warpo/issues/207

class ShadowTypeC {
  [ShadowTypeNS.g](): i32 {
    return 1;
  }
}

class _ShadowTypeA {}

// shadow type
type ShadowTypeNS = _ShadowTypeA;

// merge function to class
function ShadowTypeNS(): _ShadowTypeA {
  return new _ShadowTypeA();
}

// merge namespace to class with static field
namespace ShadowTypeNS {
  export const g: i32 = 1;
}
