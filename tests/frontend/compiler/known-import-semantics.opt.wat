(module
 (type $0 (func (param i32) (result f32)))
 (type $1 (func))
 (type $2 (func (result f32)))
 (import "builtin" "getF32FromLinkedMemory" (@binaryen.removable.if.unused)
 (func $known-import-semantics/getF32FromLinkedMemory (param i32) (result f32)))
 (memory $0 0)
 (export "discardDecodedValue" (func $known-import-semantics/discardDecodedValue))
 (export "keepDecodedValue" (func $known-import-semantics/keepDecodedValue))
 (export "memory" (memory $0))
 (func $known-import-semantics/discardDecodedValue
  nop
 )
 (func $known-import-semantics/keepDecodedValue (result f32)
  (local $0 i32)
  i32.const 4
  call $known-import-semantics/getF32FromLinkedMemory
  i32.reinterpret_f32
  local.tee $0
  i32.const -16711936
  i32.and
  i32.const 8
  i32.rotl
  local.get $0
  i32.const 16711935
  i32.and
  i32.const 8
  i32.rotr
  i32.or
  f32.reinterpret_i32
 )
)
