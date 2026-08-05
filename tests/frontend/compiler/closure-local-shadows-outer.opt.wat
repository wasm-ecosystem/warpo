(module
 (type $0 (func (result i32)))
 (type $1 (func (param i32 i32 i32 i32)))
 (type $2 (func))
 (import "env" "abort" (func $~lib/builtins/abort (param i32 i32 i32 i32)))
 (memory $0 1)
 (data $0 (i32.const 12) "\1c")
 (data $0.1 (i32.const 24) "\04\00\00\00\08\00\00\00\01")
 (data $1 (i32.const 44) "L")
 (data $1.1 (i32.const 56) "\02\00\00\00<\00\00\00c\00l\00o\00s\00u\00r\00e\00-\00l\00o\00c\00a\00l\00-\00s\00h\00a\00d\00o\00w\00s\00-\00o\00u\00t\00e\00r\00.\00t\00s")
 (table $0 2 2 funcref)
 (elem $0 (i32.const 1) $closure-local-shadows-outer/test~inner)
 (export "test" (func $closure-local-shadows-outer/test))
 (export "memory" (memory $0))
 (start $~start)
 (func $closure-local-shadows-outer/test~inner (result i32)
  i32.const 10
 )
 (func $closure-local-shadows-outer/test (result i32)
  return_call $closure-local-shadows-outer/test~inner
 )
 (func $~start
  call $closure-local-shadows-outer/test~inner
  i32.const 10
  i32.ne
  if
   i32.const 0
   i32.const 64
   i32.const 14
   i32.const 1
   call $~lib/builtins/abort
   unreachable
  end
 )
)
