(module
 (type $0 (func (param i32) (result i32)))
 (type $1 (func (result i32)))
 (type $2 (func))
 (type $3 (func (param i32 i32 i32 i32)))
 (type $4 (func (param i32)))
 (import "env" "abort" (func $~lib/builtins/abort (param i32 i32 i32 i32)))
 (import "as-builtin-fn" "~lib/rt/closure/setClosureEnv" (func $~lib/rt/closure/setClosureEnv (param i32)))
 (import "as-builtin-fn" "~lib/rt/__localtostack" (func $~lib/rt/__localtostack (param i32) (result i32)))
 (import "as-builtin-fn" "~lib/rt/__tmptostack" (func $~lib/rt/__tmptostack (param i32) (result i32)))
 (global $asi/i (mut i32) (i32.const 0))
 (global $asi/j (mut i32) (i32.const 7))
 (global $asi/k (mut i32) (i32.const 1))
 (global $asi/invokeCallbackCalls (mut i32) (i32.const 0))
 (global $asi/callbackCalls (mut i32) (i32.const 0))
 (global $~argumentsLength (mut i32) (i32.const 0))
 (global $asi/callbackResult (mut i32) (i32.const 0))
 (global $~lib/memory/__data_end i32 (i32.const 76))
 (global $~lib/memory/__stack_pointer (mut i32) (i32.const 32844))
 (global $~lib/memory/__heap_base i32 (i32.const 32844))
 (memory $0 1)
 (data $0 (i32.const 12) "\1c\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\0c\00\00\00a\00s\00i\00.\00t\00s\00")
 (data $1 (i32.const 44) "\1c\00\00\00\00\00\00\00\00\00\00\00\04\00\00\00\08\00\00\00\01\00\00\00\00\00\00\00\00\00\00\00")
 (table $0 2 2 funcref)
 (elem $0 (i32.const 1) $start:asi~anonymous|0)
 (export "memory" (memory $0))
 (start $~start)
 (func $start:asi~anonymous|0 (result i32)
  (global.set $asi/callbackCalls
   (i32.add
    (global.get $asi/callbackCalls)
    (i32.const 1)
   )
  )
  (return
   (i32.const 1)
  )
 )
 (func $asi/invokeCallback (param $callback i32) (result i32)
  (global.set $asi/invokeCallbackCalls
   (i32.add
    (global.get $asi/invokeCallbackCalls)
    (i32.const 1)
   )
  )
  (return
   (local.get $callback)
  )
 )
 (func $start:asi
  (local $0 i32)
  (global.set $asi/i
   (global.get $asi/j)
  )
  (global.set $asi/k
   (i32.add
    (global.get $asi/k)
    (i32.const 1)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (global.get $asi/i)
     (i32.const 7)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 8)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (global.get $asi/k)
     (i32.const 2)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 9)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (global.set $asi/callbackResult
   (block (result i32)
    (local.set $0
     (call $asi/invokeCallback
      (call $~lib/rt/__tmptostack
       (i32.const 64)
      )
     )
    )
    (call_indirect (type $1)
     (block (result i32)
      (call $~lib/rt/closure/setClosureEnv
       (i32.load offset=4
        (local.get $0)
       )
      )
      (global.set $~argumentsLength
       (i32.const 0)
      )
      (i32.load
       (local.get $0)
      )
     )
    )
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (global.get $asi/callbackResult)
     (i32.const 1)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 22)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (global.get $asi/invokeCallbackCalls)
     (i32.const 1)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 23)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (global.get $asi/callbackCalls)
     (i32.const 1)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 24)
     (i32.const 1)
    )
    (unreachable)
   )
  )
 )
 (func $~start
  (call $start:asi)
 )
)
