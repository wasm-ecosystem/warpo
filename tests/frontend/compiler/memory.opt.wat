(module
 (type $0 (func (param i32 i32 i32 i32)))
 (type $1 (func))
 (import "env" "abort" (func $~lib/builtins/abort (param i32 i32 i32 i32)))
 (global $memory/ptr (mut i32) (i32.const 80))
 (memory $0 1)
 (data $1 (i32.const 28) ",")
 (data $1.1 (i32.const 40) "\02\00\00\00\12\00\00\00m\00e\00m\00o\00r\00y\00.\00t\00s")
 (data $16 (i32.const 161) "\01\02\03")
 (data $17 (i32.const 166) "\c0?\00\00 @\00\00`@")
 (data $19 (i32.const 192) "\01")
 (data $20 (i32.const 200) "\01")
 (data $21 (i32.const 204) "\01")
 (data $22 (i32.const 206) "\01")
 (data $23 (i32.const 207) "\01")
 (data $24 (i32.const 208) "\01")
 (export "memory" (memory $0))
 (start $~start)
 (func $~start
  (local $0 i32)
  i32.const 16
  i32.const 16
  i32.load
  local.tee $0
  i32.const 1
  i32.add
  i32.store
  local.get $0
  if
   i32.const 0
   i32.const 48
   i32.const 12
   i32.const 1
   call $~lib/builtins/abort
   unreachable
  end
  i32.const 16
  i32.const 16
  i32.load
  local.tee $0
  i32.const 1
  i32.add
  i32.store
  local.get $0
  i32.const 1
  i32.ne
  if
   i32.const 0
   i32.const 48
   i32.const 13
   i32.const 1
   call $~lib/builtins/abort
   unreachable
  end
  i32.const 16
  i32.const 16
  i32.load
  local.tee $0
  i32.const 1
  i32.add
  i32.store
  local.get $0
  i32.const 2
  i32.ne
  if
   i32.const 0
   i32.const 48
   i32.const 14
   i32.const 1
   call $~lib/builtins/abort
   unreachable
  end
  global.get $memory/ptr
  i32.const 16
  i32.add
  i32.const 96
  global.set $memory/ptr
  i32.const 96
  i32.ne
  if
   i32.const 0
   i32.const 48
   i32.const 19
   i32.const 1
   call $~lib/builtins/abort
   unreachable
  end
  global.get $memory/ptr
  i32.const 8
  i32.add
  i32.const 104
  global.set $memory/ptr
  i32.const 104
  i32.ne
  if
   i32.const 0
   i32.const 48
   i32.const 20
   i32.const 1
   call $~lib/builtins/abort
   unreachable
  end
  global.get $memory/ptr
  i32.const 4
  i32.add
  i32.const 108
  global.set $memory/ptr
  i32.const 108
  i32.ne
  if
   i32.const 0
   i32.const 48
   i32.const 21
   i32.const 1
   call $~lib/builtins/abort
   unreachable
  end
  global.get $memory/ptr
  i32.const 2
  i32.add
  i32.const 110
  global.set $memory/ptr
  i32.const 110
  i32.ne
  if
   i32.const 0
   i32.const 48
   i32.const 22
   i32.const 1
   call $~lib/builtins/abort
   unreachable
  end
  global.get $memory/ptr
  i32.const 1
  i32.add
  i32.const 111
  global.set $memory/ptr
  i32.const 111
  i32.ne
  if
   i32.const 0
   i32.const 48
   i32.const 23
   i32.const 1
   call $~lib/builtins/abort
   unreachable
  end
  global.get $memory/ptr
  i32.const 111
  i32.ne
  if
   i32.const 0
   i32.const 48
   i32.const 24
   i32.const 1
   call $~lib/builtins/abort
   unreachable
  end
  i32.const 128
  global.set $memory/ptr
  i32.const 144
  global.set $memory/ptr
  i32.const 152
  global.set $memory/ptr
  global.get $memory/ptr
  i32.const 4
  i32.add
  i32.const 156
  global.set $memory/ptr
  i32.const 156
  i32.ne
  if
   i32.const 0
   i32.const 48
   i32.const 36
   i32.const 1
   call $~lib/builtins/abort
   unreachable
  end
  global.get $memory/ptr
  i32.const 2
  i32.add
  i32.const 158
  global.set $memory/ptr
  i32.const 158
  i32.ne
  if
   i32.const 0
   i32.const 48
   i32.const 37
   i32.const 1
   call $~lib/builtins/abort
   unreachable
  end
  global.get $memory/ptr
  i32.const 1
  i32.add
  i32.const 159
  global.set $memory/ptr
  i32.const 159
  i32.ne
  if
   i32.const 0
   i32.const 48
   i32.const 38
   i32.const 1
   call $~lib/builtins/abort
   unreachable
  end
  global.get $memory/ptr
  i32.const 159
  i32.ne
  if
   i32.const 0
   i32.const 48
   i32.const 39
   i32.const 1
   call $~lib/builtins/abort
   unreachable
  end
  i32.const 161
  global.set $memory/ptr
  i32.const 161
  i32.load8_u
  i32.const 1
  i32.ne
  if
   i32.const 0
   i32.const 48
   i32.const 44
   i32.const 1
   call $~lib/builtins/abort
   unreachable
  end
  global.get $memory/ptr
  i32.load8_u offset=1
  i32.const 2
  i32.ne
  if
   i32.const 0
   i32.const 48
   i32.const 45
   i32.const 1
   call $~lib/builtins/abort
   unreachable
  end
  global.get $memory/ptr
  i32.load8_u offset=2
  i32.const 3
  i32.ne
  if
   i32.const 0
   i32.const 48
   i32.const 46
   i32.const 1
   call $~lib/builtins/abort
   unreachable
  end
  i32.const 164
  global.set $memory/ptr
  i32.const 164
  f32.load
  f32.const 1.5
  f32.ne
  if
   i32.const 0
   i32.const 48
   i32.const 49
   i32.const 1
   call $~lib/builtins/abort
   unreachable
  end
  global.get $memory/ptr
  f32.load offset=4
  f32.const 2.5
  f32.ne
  if
   i32.const 0
   i32.const 48
   i32.const 50
   i32.const 1
   call $~lib/builtins/abort
   unreachable
  end
  global.get $memory/ptr
  f32.load offset=8
  f32.const 3.5
  f32.ne
  if
   i32.const 0
   i32.const 48
   i32.const 51
   i32.const 1
   call $~lib/builtins/abort
   unreachable
  end
  i32.const 176
  global.set $memory/ptr
  i32.const 192
  global.set $memory/ptr
  i32.const 200
  global.set $memory/ptr
  global.get $memory/ptr
  i32.const 4
  i32.add
  i32.const 204
  global.set $memory/ptr
  i32.const 204
  i32.ne
  if
   i32.const 0
   i32.const 48
   i32.const 58
   i32.const 1
   call $~lib/builtins/abort
   unreachable
  end
  global.get $memory/ptr
  i32.const 2
  i32.add
  i32.const 206
  global.set $memory/ptr
  i32.const 206
  i32.ne
  if
   i32.const 0
   i32.const 48
   i32.const 59
   i32.const 1
   call $~lib/builtins/abort
   unreachable
  end
  global.get $memory/ptr
  i32.const 1
  i32.add
  i32.const 207
  global.set $memory/ptr
  i32.const 207
  i32.ne
  if
   i32.const 0
   i32.const 48
   i32.const 60
   i32.const 1
   call $~lib/builtins/abort
   unreachable
  end
  global.get $memory/ptr
  i32.const 207
  i32.ne
  if
   i32.const 0
   i32.const 48
   i32.const 61
   i32.const 1
   call $~lib/builtins/abort
   unreachable
  end
 )
)
