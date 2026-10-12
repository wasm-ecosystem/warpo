(module
 (type $0 (func (param i32 i32) (result i32)))
 (type $1 (func (param i32 i32)))
 (memory $0 0)
 (export "baseToDerived" (func $unused-field-store-generic/baseToDerived))
 (export "derivedToBase" (func $unused-field-store-generic/derivedToBase))
 (export "unusedBaseWrite" (func $unused-field-store-generic/unusedBaseWrite))
 (export "unusedDerivedWrite" (func $unused-field-store-generic/unusedDerivedWrite))
 (export "memory" (memory $0))
 (func $unused-field-store-generic/baseToDerived (param $0 i32) (param $1 i32) (result i32)
  local.get $0
  local.get $1
  i32.store
  local.get $0
  i32.load
 )
 (func $unused-field-store-generic/derivedToBase (param $0 i32) (param $1 i32) (result i32)
  local.get $0
  local.get $1
  i32.store offset=4
  local.get $0
  i32.load offset=4
 )
 (func $unused-field-store-generic/unusedBaseWrite (param $0 i32) (param $1 i32)
  local.get $0
  local.get $1
  i32.store offset=8
 )
 (func $unused-field-store-generic/unusedDerivedWrite (param $0 i32) (param $1 i32)
  local.get $0
  local.get $1
  i32.store offset=12
 )
)
