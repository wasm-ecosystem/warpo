(module
 (type $0 (func (param i32)))
 (type $1 (func (param i32 i32)))
 (type $2 (func))
 (global $~lib/memory/__stack_pointer (mut i32) (i32.const 32776))
 (memory $0 0)
 (export "testTrue" (func $possibly-null/testTrue))
 (export "testFalseElse" (func $possibly-null/testTrue))
 (export "testFalseContinuation" (func $possibly-null/testTrue))
 (export "testNeNull" (func $possibly-null/testTrue))
 (export "testEqNullElse" (func $possibly-null/testTrue))
 (export "testEqNullContinuation" (func $possibly-null/testTrue))
 (export "testNotEqNull" (func $possibly-null/testTrue))
 (export "testNotNeNullElse" (func $possibly-null/testTrue))
 (export "testNotNeNullContinuation" (func $possibly-null/testTrue))
 (export "testWhile" (func $possibly-null/testWhile))
 (export "testWhile2" (func $possibly-null/testWhile2))
 (export "testWhile3" (func $possibly-null/testWhile3))
 (export "testLogicalAnd" (func $possibly-null/testLogicalAnd))
 (export "testLogicalOr" (func $possibly-null/testLogicalOr))
 (export "testLogicalAndMulti" (func $possibly-null/testLogicalAndMulti))
 (export "testLogicalOrMulti" (func $possibly-null/testLogicalAndMulti))
 (export "testAssign" (func $possibly-null/testAssign))
 (export "testNeverNull" (func $possibly-null/testTrue))
 (export "memory" (memory $0))
 (func $possibly-null/testTrue (param $0 i32)
  nop
 )
 (func $possibly-null/testWhile (param $0 i32)
  call $~lib/rt/__decrease_sp
  loop $while-continue|0
   local.get $0
   if
    global.get $~lib/memory/__stack_pointer
    i32.const 0
    i32.store align=1
    i32.const 0
    local.set $0
    br $while-continue|0
   end
  end
  global.get $~lib/memory/__stack_pointer
  i32.const 4
  i32.add
  global.set $~lib/memory/__stack_pointer
 )
 (func $possibly-null/testWhile2 (param $0 i32) (param $1 i32)
  call $~lib/rt/__decrease_sp
  loop $while-continue|0
   local.get $0
   if
    global.get $~lib/memory/__stack_pointer
    local.get $1
    i32.store align=1
    local.get $1
    local.set $0
    br $while-continue|0
   end
  end
  global.get $~lib/memory/__stack_pointer
  i32.const 4
  i32.add
  global.set $~lib/memory/__stack_pointer
 )
 (func $possibly-null/testWhile3 (param $0 i32) (param $1 i32)
  call $~lib/rt/__decrease_sp
  loop $while-continue|0
   local.get $0
   if
    local.get $1
    if
     global.get $~lib/memory/__stack_pointer
     local.get $1
     i32.store align=1
     local.get $1
     local.set $0
    end
    br $while-continue|0
   end
  end
  global.get $~lib/memory/__stack_pointer
  i32.const 4
  i32.add
  global.set $~lib/memory/__stack_pointer
 )
 (func $possibly-null/testLogicalAnd (param $0 i32)
  call $~lib/rt/__decrease_sp
  local.get $0
  if
   global.get $~lib/memory/__stack_pointer
   local.get $0
   i32.store align=1
  end
  global.get $~lib/memory/__stack_pointer
  i32.const 4
  i32.add
  global.set $~lib/memory/__stack_pointer
 )
 (func $possibly-null/testLogicalOr (param $0 i32)
  call $~lib/rt/__decrease_sp
  local.get $0
  if (result i32)
   global.get $~lib/memory/__stack_pointer
   local.get $0
   i32.store align=1
   i32.const 0
  else
   i32.const 1
  end
  drop
  global.get $~lib/memory/__stack_pointer
  i32.const 4
  i32.add
  global.set $~lib/memory/__stack_pointer
 )
 (func $possibly-null/testLogicalAndMulti (param $0 i32) (param $1 i32)
  nop
 )
 (func $possibly-null/testAssign (param $0 i32) (param $1 i32)
  call $~lib/rt/__decrease_sp
  global.get $~lib/memory/__stack_pointer
  local.get $1
  i32.store align=1
  global.get $~lib/memory/__stack_pointer
  i32.const 4
  i32.add
  global.set $~lib/memory/__stack_pointer
 )
 (func $~lib/rt/__decrease_sp
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
 )
)
