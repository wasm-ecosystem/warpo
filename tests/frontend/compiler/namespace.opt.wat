(module
 (type $0 (func (param i32 i32 i32 i32)))
 (type $1 (func))
 (import "env" "abort" (func $~lib/builtins/abort (param i32 i32 i32 i32)))
 (global $namespace/aaa (mut i32) (i32.const 0))
 (memory $0 1)
 (data $0 (i32.const 12) ",")
 (data $0.1 (i32.const 24) "\02\00\00\00\18\00\00\00n\00a\00m\00e\00s\00p\00a\00c\00e\00.\00t\00s")
 (export "memory" (memory $0))
 (start $~start)
 (func $~start
  global.get $namespace/aaa
  i32.const 1
  i32.add
  global.set $namespace/aaa
  global.get $namespace/aaa
  i32.const 1
  i32.ne
  if
   i32.const 0
   i32.const 32
   i32.const 42
   i32.const 1
   call $~lib/builtins/abort
   unreachable
  end
 )
)
