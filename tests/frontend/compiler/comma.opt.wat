(module
 (type $0 (func (param i32 i32 i32 i32)))
 (type $1 (func))
 (import "env" "abort" (func $~lib/builtins/abort (param i32 i32 i32 i32)))
 (global $comma/a (mut i32) (i32.const 0))
 (global $comma/b (mut i32) (i32.const 0))
 (memory $0 1)
 (data $0 (i32.const 12) ",")
 (data $0.1 (i32.const 24) "\02\00\00\00\10\00\00\00c\00o\00m\00m\00a\00.\00t\00s")
 (export "memory" (memory $0))
 (start $~start)
 (func $~start
  (local $0 i32)
  global.get $comma/a
  local.tee $0
  i32.const 1
  i32.add
  global.set $comma/a
  local.get $0
  global.set $comma/b
  global.get $comma/a
  i32.const 1
  i32.ne
  if
   i32.const 0
   i32.const 32
   i32.const 5
   i32.const 1
   call $~lib/builtins/abort
   unreachable
  end
  global.get $comma/b
  if
   i32.const 0
   i32.const 32
   i32.const 6
   i32.const 1
   call $~lib/builtins/abort
   unreachable
  end
  global.get $comma/a
  i32.const 1
  i32.add
  global.set $comma/a
  global.get $comma/a
  global.set $comma/b
  global.get $comma/a
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
  global.get $comma/b
  i32.const 2
  i32.ne
  if
   i32.const 0
   i32.const 32
   i32.const 10
   i32.const 1
   call $~lib/builtins/abort
   unreachable
  end
  i32.const 0
  global.set $comma/b
  i32.const 0
  global.set $comma/a
  i32.const 1
  global.set $comma/a
  i32.const 1
  global.set $comma/b
  global.get $comma/b
  i32.const 1
  i32.ne
  if
   i32.const 0
   i32.const 32
   i32.const 16
   i32.const 1
   call $~lib/builtins/abort
   unreachable
  end
  global.get $comma/a
  i32.const 1
  i32.add
  global.set $comma/a
  global.get $comma/a
  global.set $comma/b
  global.get $comma/b
  global.set $comma/a
  global.get $comma/a
  i32.const 2
  i32.ne
  if
   i32.const 0
   i32.const 32
   i32.const 19
   i32.const 1
   call $~lib/builtins/abort
   unreachable
  end
  global.get $comma/b
  i32.const 2
  i32.ne
  if
   i32.const 0
   i32.const 32
   i32.const 20
   i32.const 1
   call $~lib/builtins/abort
   unreachable
  end
  i32.const 0
  local.set $0
  loop $for-loop|0
   local.get $0
   global.get $comma/a
   i32.lt_s
   if
    global.get $comma/a
    i32.const 1
    i32.sub
    global.set $comma/a
    local.get $0
    i32.const 1
    i32.add
    local.set $0
    br $for-loop|0
   end
  end
  local.get $0
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
 )
)
