(module
 (type $0 (func (param i32) (result i32)))
 (type $1 (func (param i32 i32 i32 i32)))
 (type $2 (func))
 (import "env" "abort" (func $~lib/builtins/abort (param i32 i32 i32 i32)))
 (global $~lib/memory/__stack_pointer (mut i32) (i32.const 32908))
 (memory $0 1)
 (data $0 (i32.const 12) "\1c")
 (data $0.1 (i32.const 24) "\04\00\00\00\08\00\00\00\01")
 (data $1 (i32.const 44) "\\")
 (data $1.1 (i32.const 56) "\02\00\00\00B\00\00\00c\00l\00o\00s\00u\00r\00e\00-\00p\00a\00r\00a\00m\00-\00s\00h\00a\00d\00o\00w\00s\00-\00c\00a\00p\00t\00u\00r\00e\00d\00.\00t\00s")
 (table $0 2 2 funcref)
 (elem $0 (i32.const 1) $closure-param-shadows-captured/test~inner)
 (export "test" (func $closure-param-shadows-captured/test))
 (export "memory" (memory $0))
 (func $closure-param-shadows-captured/test~inner (param $0 i32) (result i32)
  local.get $0
 )
 (func $closure-param-shadows-captured/test
  global.get $~lib/memory/__stack_pointer
  i32.const 4
  i32.sub
  global.set $~lib/memory/__stack_pointer
  global.get $~lib/memory/__stack_pointer
  i32.const 0
  i32.store align=1
  global.get $~lib/memory/__stack_pointer
  i32.const 140
  i32.lt_s
  if
   unreachable
  end
  global.get $~lib/memory/__stack_pointer
  i32.const 32
  i32.store align=1
  i32.const 1
  call $closure-param-shadows-captured/test~inner
  i32.const 1
  i32.ne
  if
   i32.const 0
   i32.const 64
   i32.const 8
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  i32.const 42
  call $closure-param-shadows-captured/test~inner
  i32.const 42
  i32.ne
  if
   i32.const 0
   i32.const 64
   i32.const 9
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  global.get $~lib/memory/__stack_pointer
  i32.const 4
  i32.add
  global.set $~lib/memory/__stack_pointer
 )
)
