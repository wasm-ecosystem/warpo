(module
 (type $0 (func (param i32) (result i32)))
 (global $~lib/memory/__stack_pointer (mut i32) (i32.const 32776))
 (memory $0 0)
 (export "test" (func $resolve-localortype/test))
 (export "memory" (memory $0))
 (func $resolve-localortype/test (param $0 i32) (result i32)
  global.get $~lib/memory/__stack_pointer
  i32.const 4
  i32.sub
  global.set $~lib/memory/__stack_pointer
  global.get $~lib/memory/__stack_pointer
  i32.const 0
  i32.store align=1
  global.get $~lib/memory/__stack_pointer
  i32.const 8
  i32.lt_s
  if
   unreachable
  end
  global.get $~lib/memory/__stack_pointer
  local.get $0
  i32.store align=1
  global.get $~lib/memory/__stack_pointer
  i32.const 4
  i32.add
  global.set $~lib/memory/__stack_pointer
  local.get $0
 )
)
