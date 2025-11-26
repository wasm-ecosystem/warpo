(module
 (type $0 (func))
 (global $~lib/memory/__stack_pointer (mut i32) (i32.const 32860))
 (memory $0 1)
 (data $0 (i32.const 12) ",")
 (data $0.1 (i32.const 24) "\02\00\00\00\1c\00\00\00i\00s\00s\00u\00e\00s\00/\001\007\001\004\00.\00t\00s")
 (data $1 (i32.const 60) "\1c")
 (data $1.1 (i32.const 72) "\02\00\00\00\06\00\00\00i\003\002")
 (export "memory" (memory $0))
 (start $~start)
 (func $~start
  global.get $~lib/memory/__stack_pointer
  i32.const 4
  i32.sub
  global.set $~lib/memory/__stack_pointer
  global.get $~lib/memory/__stack_pointer
  i32.const 0
  i32.store align=1
  global.get $~lib/memory/__stack_pointer
  i32.const 92
  i32.lt_s
  if
   unreachable
  end
  global.get $~lib/memory/__stack_pointer
  i32.const 80
  i32.store align=1
  global.get $~lib/memory/__stack_pointer
  i32.const 8
  i32.sub
  global.set $~lib/memory/__stack_pointer
  global.get $~lib/memory/__stack_pointer
  i64.const 0
  i64.store align=1
  global.get $~lib/memory/__stack_pointer
  i32.const 92
  i32.lt_s
  if
   unreachable
  end
  global.get $~lib/memory/__stack_pointer
  i32.const 8
  i32.add
  global.set $~lib/memory/__stack_pointer
  global.get $~lib/memory/__stack_pointer
  i32.const 4
  i32.add
  global.set $~lib/memory/__stack_pointer
 )
)
