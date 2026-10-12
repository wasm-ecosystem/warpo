(module
 (type $0 (func (param i32) (result i32)))
 (type $1 (func (param i32 i32 i32 i32)))
 (type $2 (func))
 (import "env" "abort" (func $~lib/builtins/abort (param i32 i32 i32 i32)))
 (memory $0 1)
 (data $0 (i32.const 12) "l")
 (data $0.1 (i32.const 24) "\02\00\00\00P\00\00\00s\00w\00i\00t\00c\00h\00-\00u\00n\00r\00e\00a\00c\00h\00a\00b\00l\00e\00-\00b\00r\00e\00a\00k\00-\00a\00f\00t\00e\00r\00-\00r\00e\00t\00u\00r\00n\00.\00t\00s")
 (export "main" (func $switch-unreachable-break-after-return/main))
 (export "memory" (memory $0))
 (start $~start)
 (func $switch-unreachable-break-after-return/main (param $0 i32) (result i32)
  local.get $0
  if
   i32.const 0
   return
  end
  i32.const 1
 )
 (func $~start
  i32.const 1
  call $switch-unreachable-break-after-return/main
  if
   i32.const 0
   i32.const 32
   i32.const 10
   i32.const 1
   call $~lib/builtins/abort
   unreachable
  end
  i32.const 0
  call $switch-unreachable-break-after-return/main
  i32.const 1
  i32.ne
  if
   i32.const 0
   i32.const 32
   i32.const 11
   i32.const 1
   call $~lib/builtins/abort
   unreachable
  end
 )
)
