(module
 (type $0 (func (param i32 i32 i32 i32)))
 (type $1 (func))
 (import "env" "abort" (func $~lib/builtins/abort (param i32 i32 i32 i32)))
 (global $asi/k (mut i32) (i32.const 1))
 (global $asi/invokeCallbackCalls (mut i32) (i32.const 0))
 (global $asi/callbackCalls (mut i32) (i32.const 0))
 (memory $0 1)
 (data $0 (i32.const 12) "\1c")
 (data $0.1 (i32.const 24) "\02\00\00\00\0c\00\00\00a\00s\00i\00.\00t\00s\00\1c")
 (data $1.1 (i32.const 56) "\04\00\00\00\08\00\00\00\01")
 (export "memory" (memory $0))
 (start $~start)
 (func $~start
  global.get $asi/k
  i32.const 1
  i32.add
  global.set $asi/k
  global.get $asi/k
  i32.const 2
  i32.ne
  if
   i32.const 0
   i32.const 32
   i32.const 9
   i32.const 1
   call $~lib/builtins/abort
   unreachable
  end
  global.get $asi/invokeCallbackCalls
  i32.const 1
  i32.add
  global.set $asi/invokeCallbackCalls
  global.get $asi/callbackCalls
  i32.const 1
  i32.add
  global.set $asi/callbackCalls
  global.get $asi/invokeCallbackCalls
  i32.const 1
  i32.ne
  if
   i32.const 0
   i32.const 32
   i32.const 23
   i32.const 1
   call $~lib/builtins/abort
   unreachable
  end
  global.get $asi/callbackCalls
  i32.const 1
  i32.ne
  if
   i32.const 0
   i32.const 32
   i32.const 24
   i32.const 1
   call $~lib/builtins/abort
   unreachable
  end
 )
)
