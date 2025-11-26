(module
 (type $0 (func))
 (type $1 (func (param i32 i32 i32) (result i32)))
 (type $2 (func (param i32)))
 (type $3 (func (param i32 i32)))
 (memory $0 1)
 (data $0 (i32.const 12) "\1c")
 (data $0.1 (i32.const 24) "\02\00\00\00\02\00\00\00a")
 (table $0 1 1 funcref)
 (export "test" (func $ternary/test))
 (export "testDropWithTypeMismatch" (func $ternary/testDropWithTypeMismatch))
 (export "testVoidInclTypeMismatch" (func $ternary/testVoidInclTypeMismatch))
 (export "memory" (memory $0))
 (func $ternary/test (param $0 i32) (param $1 i32) (param $2 i32) (result i32)
  local.get $1
  local.get $2
  local.get $0
  select
 )
 (func $ternary/testDropWithTypeMismatch (param $0 i32)
  nop
 )
 (func $ternary/testVoidInclTypeMismatch (param $0 i32) (param $1 i32)
  local.get $1
  i32.load
  call_indirect (type $0)
  local.get $0
  if
   local.get $1
   i32.load
   call_indirect (type $0)
  end
  local.get $0
  i32.eqz
  if
   local.get $1
   i32.load
   call_indirect (type $0)
  end
 )
)
