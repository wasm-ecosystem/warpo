(module
 (type $0 (func))
 (type $1 (func (param i32 i32)))
 (type $2 (func (param i32)))
 (global $~lib/memory/__stack_pointer (mut i32) (i32.const 32812))
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
  global.get $~lib/memory/__stack_pointer
  i32.const 4
  i32.sub
  global.set $~lib/memory/__stack_pointer
  global.get $~lib/memory/__stack_pointer
  i32.const 0
  i32.store align=1
  global.get $~lib/memory/__stack_pointer
  i32.const 44
  i32.lt_s
  if
   unreachable
  end
  global.get $~lib/memory/__stack_pointer
  i32.const 32
  i32.store align=1
  i32.const 1
  i32.const 32
  call $return/testVoidReturnFunction
  global.get $~lib/memory/__stack_pointer
  i32.const 4
  i32.add
  global.set $~lib/memory/__stack_pointer
 )
)
