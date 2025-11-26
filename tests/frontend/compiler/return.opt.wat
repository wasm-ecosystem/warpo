(module
 (type $0 (func))
 (type $1 (func (param i32 i32)))
 (type $2 (func (param i32)))
 (memory $0 1)
 (data $0 (i32.const 12) "\1c")
 (data $0.1 (i32.const 24) "\04\00\00\00\08\00\00\00\01")
 (table $0 2 2 funcref)
 (elem $0 (i32.const 1) $start:return~anonymous|0)
 (export "testVoidReturn" (func $return/testVoidReturn))
 (export "testVoidReturnFunction" (func $return/testVoidReturnFunction))
 (export "memory" (memory $0))
 (start $~start)
 (func $start:return~anonymous|0
  nop
 )
 (func $return/testVoidReturnFunction (param $0 i32) (param $1 i32)
  local.get $0
  if
   local.get $1
   i32.load
   call_indirect (type $0)
   return
  end
  local.get $1
  i32.load
  call_indirect (type $0)
 )
 (func $return/testVoidReturn (param $0 i32)
  nop
 )
 (func $~start
  i32.const 1
  i32.const 32
  call $return/testVoidReturnFunction
 )
)
