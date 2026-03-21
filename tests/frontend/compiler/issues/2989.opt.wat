(module
 (type $0 (func (param i32)))
 (type $1 (func (param i32 i32 i32 i32)))
 (type $2 (func))
 (import "env" "abort" (func $~lib/builtins/abort (param i32 i32 i32 i32)))
 (global $issues/2989/value (mut i32) (i32.const 0))
 (global $issues/2989/fn (mut i32) (i32.const 32))
 (memory $0 1)
 (data $0 (i32.const 12) "\1c")
 (data $0.1 (i32.const 24) "\04\00\00\00\08\00\00\00\01")
 (data $1 (i32.const 44) "\1c")
 (data $1.1 (i32.const 56) "\04\00\00\00\08\00\00\00\02")
 (data $2 (i32.const 76) ",")
 (data $2.1 (i32.const 88) "\02\00\00\00\1c\00\00\00i\00s\00s\00u\00e\00s\00/\002\009\008\009\00.\00t\00s")
 (table $0 3 3 funcref)
 (elem $0 (i32.const 1) $issues/2989/logA $issues/2989/logB)
 (export "memory" (memory $0))
 (start $~start)
 (func $issues/2989/logA (param $0 i32)
  i32.const 100
  global.set $issues/2989/value
 )
 (func $issues/2989/logB (param $0 i32)
  i32.const 200
  global.set $issues/2989/value
 )
 (func $~start
  (local $0 i32)
  global.get $issues/2989/fn
  local.set $0
  i32.const 64
  global.set $issues/2989/fn
  i32.const 42
  local.get $0
  i32.load
  call_indirect (type $0)
  global.get $issues/2989/value
  i32.const 100
  i32.ne
  if
   i32.const 0
   i32.const 96
   i32.const 20
   i32.const 1
   call $~lib/builtins/abort
   unreachable
  end
 )
)
