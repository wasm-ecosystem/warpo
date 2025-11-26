(module
 (type $0 (func (param i32 i32 i32 i32)))
 (type $1 (func))
 (import "env" "abort" (func $~lib/builtins/abort (param i32 i32 i32 i32)))
 (global $std/pointer/one (mut i32) (i32.const 0))
 (global $std/pointer/two (mut i32) (i32.const 0))
 (global $std/pointer/add (mut i32) (i32.const 0))
 (global $std/pointer/sub (mut i32) (i32.const 0))
 (global $std/pointer/nextOne (mut i32) (i32.const 0))
 (memory $0 1)
 (data $0 (i32.const 12) ",")
 (data $0.1 (i32.const 24) "\02\00\00\00\1c\00\00\00s\00t\00d\00/\00p\00o\00i\00n\00t\00e\00r\00.\00t\00s")
 (export "memory" (memory $0))
 (start $~start)
 (func $~start
  (local $0 i32)
  (local $1 i32)
  i32.const 8
  global.set $std/pointer/one
  i32.const 24
  global.set $std/pointer/two
  global.get $std/pointer/one
  i32.const 1
  i32.store
  global.get $std/pointer/one
  i32.const 2
  i32.store offset=4
  global.get $std/pointer/one
  i32.load
  i32.const 1
  i32.ne
  if
   i32.const 0
   i32.const 32
   i32.const 92
   i32.const 1
   call $~lib/builtins/abort
   unreachable
  end
  global.get $std/pointer/one
  i32.load offset=4
  i32.const 2
  i32.ne
  if
   i32.const 0
   i32.const 32
   i32.const 93
   i32.const 1
   call $~lib/builtins/abort
   unreachable
  end
  global.get $std/pointer/one
  global.get $std/pointer/two
  i32.add
  global.set $std/pointer/add
  global.get $std/pointer/add
  i32.const 32
  i32.ne
  if
   i32.const 0
   i32.const 32
   i32.const 96
   i32.const 1
   call $~lib/builtins/abort
   unreachable
  end
  global.get $std/pointer/two
  global.get $std/pointer/one
  i32.sub
  global.set $std/pointer/sub
  global.get $std/pointer/sub
  i32.const 16
  i32.ne
  if
   i32.const 0
   i32.const 32
   i32.const 99
   i32.const 1
   call $~lib/builtins/abort
   unreachable
  end
  global.get $std/pointer/one
  i32.const 8
  i32.ne
  if
   i32.const 0
   i32.const 32
   i32.const 101
   i32.const 1
   call $~lib/builtins/abort
   unreachable
  end
  global.get $std/pointer/one
  i32.const 8
  i32.add
  global.set $std/pointer/one
  global.get $std/pointer/one
  global.set $std/pointer/nextOne
  global.get $std/pointer/nextOne
  global.get $std/pointer/one
  i32.ne
  if
   i32.const 0
   i32.const 32
   i32.const 103
   i32.const 1
   call $~lib/builtins/abort
   unreachable
  end
  global.get $std/pointer/one
  i32.const 16
  i32.ne
  if
   i32.const 0
   i32.const 32
   i32.const 104
   i32.const 1
   call $~lib/builtins/abort
   unreachable
  end
  global.get $std/pointer/two
  i32.const 24
  i32.ne
  if
   i32.const 0
   i32.const 32
   i32.const 106
   i32.const 1
   call $~lib/builtins/abort
   unreachable
  end
  global.get $std/pointer/two
  i32.const 8
  i32.sub
  global.set $std/pointer/two
  global.get $std/pointer/two
  i32.const 8
  i32.sub
  global.set $std/pointer/two
  global.get $std/pointer/two
  i32.const 8
  i32.ne
  if
   i32.const 0
   i32.const 32
   i32.const 109
   i32.const 1
   call $~lib/builtins/abort
   unreachable
  end
  global.get $std/pointer/two
  i32.load
  i32.const 1
  i32.ne
  if
   i32.const 0
   i32.const 32
   i32.const 110
   i32.const 1
   call $~lib/builtins/abort
   unreachable
  end
  global.get $std/pointer/two
  i32.load offset=4
  i32.const 2
  i32.ne
  if
   i32.const 0
   i32.const 32
   i32.const 111
   i32.const 1
   call $~lib/builtins/abort
   unreachable
  end
  global.get $std/pointer/one
  local.set $0
  global.get $std/pointer/two
  local.tee $1
  if
   local.get $0
   local.get $1
   i64.load align=1
   i64.store align=1
  else
   local.get $0
   i64.const 0
   i64.store align=1
  end
  global.get $std/pointer/one
  global.get $std/pointer/two
  i32.eq
  if
   i32.const 0
   i32.const 32
   i32.const 114
   i32.const 1
   call $~lib/builtins/abort
   unreachable
  end
  global.get $std/pointer/one
  i32.load
  i32.const 1
  i32.ne
  if
   i32.const 0
   i32.const 32
   i32.const 115
   i32.const 1
   call $~lib/builtins/abort
   unreachable
  end
  global.get $std/pointer/one
  i32.load offset=4
  i32.const 2
  i32.ne
  if
   i32.const 0
   i32.const 32
   i32.const 116
   i32.const 1
   call $~lib/builtins/abort
   unreachable
  end
  i32.const 0
  f32.const 1.100000023841858
  f32.store
  i32.const 4
  f32.const 1.2000000476837158
  f32.store
  i32.const 0
  f32.load
  f32.const 1.100000023841858
  f32.ne
  if
   i32.const 0
   i32.const 32
   i32.const 122
   i32.const 1
   call $~lib/builtins/abort
   unreachable
  end
  i32.const 4
  f32.load
  f32.const 1.2000000476837158
  f32.ne
  if
   i32.const 0
   i32.const 32
   i32.const 123
   i32.const 1
   call $~lib/builtins/abort
   unreachable
  end
  i32.const 0
  f32.load
  f32.const 1.100000023841858
  f32.ne
  if
   i32.const 0
   i32.const 32
   i32.const 125
   i32.const 1
   call $~lib/builtins/abort
   unreachable
  end
  i32.const 4
  f32.load
  f32.const 1.2000000476837158
  f32.ne
  if
   i32.const 0
   i32.const 32
   i32.const 126
   i32.const 1
   call $~lib/builtins/abort
   unreachable
  end
  i32.const 0
  f32.load
  f32.const 1.100000023841858
  f32.ne
  if
   i32.const 0
   i32.const 32
   i32.const 128
   i32.const 1
   call $~lib/builtins/abort
   unreachable
  end
  i32.const 4
  f32.load
  f32.const 1.2000000476837158
  f32.ne
  if
   i32.const 0
   i32.const 32
   i32.const 129
   i32.const 1
   call $~lib/builtins/abort
   unreachable
  end
  i32.const 8
  f32.const 1.2999999523162842
  f32.store
  i32.const 8
  f32.load
  f32.const 1.2999999523162842
  f32.ne
  if
   i32.const 0
   i32.const 32
   i32.const 132
   i32.const 1
   call $~lib/builtins/abort
   unreachable
  end
  i32.const 8
  f32.load
  f32.const 1.2999999523162842
  f32.ne
  if
   i32.const 0
   i32.const 32
   i32.const 133
   i32.const 1
   call $~lib/builtins/abort
   unreachable
  end
  i32.const 8
  f32.load
  f32.const 1.2999999523162842
  f32.ne
  if
   i32.const 0
   i32.const 32
   i32.const 134
   i32.const 1
   call $~lib/builtins/abort
   unreachable
  end
  i32.const 0
  f32.const 1.399999976158142
  f32.store
  i32.const 0
  f32.load
  f32.const 1.399999976158142
  f32.ne
  if
   i32.const 0
   i32.const 32
   i32.const 137
   i32.const 1
   call $~lib/builtins/abort
   unreachable
  end
  i32.const 0
  f32.load
  f32.const 1.399999976158142
  f32.ne
  if
   i32.const 0
   i32.const 32
   i32.const 138
   i32.const 1
   call $~lib/builtins/abort
   unreachable
  end
 )
)
