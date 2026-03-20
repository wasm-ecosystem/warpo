(module
 (type $0 (func (param i32 i32)))
 (type $1 (func))
 (type $2 (func (param i32 i32 i32 i32)))
 (type $3 (func (param i32 i32 i64)))
 (type $4 (func (param i32) (result i32)))
 (import "env" "abort" (func $~lib/builtins/abort (param i32 i32 i32 i32)))
 (global $std/pointer/one (mut i32) (i32.const 0))
 (global $~lib/rt/tlsf/ROOT (mut i32) (i32.const 0))
 (global $std/pointer/two (mut i32) (i32.const 0))
 (global $std/pointer/add (mut i32) (i32.const 0))
 (global $std/pointer/sub (mut i32) (i32.const 0))
 (global $std/pointer/nextOne (mut i32) (i32.const 0))
 (memory $0 1)
 (data $0 (i32.const 12) "<")
 (data $0.1 (i32.const 24) "\02\00\00\00\1e\00\00\00~\00l\00i\00b\00/\00r\00t\00/\00t\00l\00s\00f\00.\00t\00s")
 (data $1 (i32.const 76) "<")
 (data $1.1 (i32.const 88) "\02\00\00\00(\00\00\00A\00l\00l\00o\00c\00a\00t\00i\00o\00n\00 \00t\00o\00o\00 \00l\00a\00r\00g\00e\00\00\00\00\00,")
 (data $2.1 (i32.const 152) "\02\00\00\00\1c\00\00\00s\00t\00d\00/\00p\00o\00i\00n\00t\00e\00r\00.\00t\00s")
 (export "memory" (memory $0))
 (start $~start)
 (func $~lib/rt/tlsf/removeBlock (param $0 i32) (param $1 i32)
  (local $2 i32)
  (local $3 i32)
  (local $4 i32)
  (local $5 i32)
  local.get $1
  i32.load
  local.tee $2
  i32.const 1
  i32.and
  i32.eqz
  if
   i32.const 0
   i32.const 32
   i32.const 245
   i32.const 14
   call $~lib/builtins/abort
   unreachable
  end
  local.get $2
  i32.const -4
  i32.and
  local.tee $2
  i32.const 12
  i32.lt_u
  if
   i32.const 0
   i32.const 32
   i32.const 247
   i32.const 14
   call $~lib/builtins/abort
   unreachable
  end
  local.get $2
  i32.const 256
  i32.lt_u
  if (result i32)
   local.get $2
   i32.const 4
   i32.shr_u
   local.set $3
   i32.const 0
  else
   i32.const 31
   i32.const 1073741820
   local.get $2
   local.get $2
   i32.const 1073741820
   i32.ge_u
   select
   local.tee $3
   i32.clz
   i32.sub
   local.set $2
   local.get $3
   local.get $2
   i32.const 4
   i32.sub
   i32.shr_u
   i32.const 16
   i32.xor
   local.set $3
   local.get $2
   i32.const 7
   i32.sub
  end
  local.set $4
  local.get $3
  i32.const 16
  i32.lt_u
  local.get $4
  i32.const 23
  i32.lt_u
  i32.and
  i32.eqz
  if
   i32.const 0
   i32.const 32
   i32.const 261
   i32.const 14
   call $~lib/builtins/abort
   unreachable
  end
  local.get $1
  i32.load offset=8
  local.set $2
  local.get $1
  i32.load offset=4
  local.tee $5
  if
   local.get $5
   local.get $2
   i32.store offset=8
  end
  local.get $2
  if
   local.get $2
   local.get $5
   i32.store offset=4
  end
  local.get $1
  local.get $0
  local.get $4
  i32.const 4
  i32.shl
  local.get $3
  i32.add
  i32.const 2
  i32.shl
  i32.add
  local.tee $5
  i32.load offset=96
  i32.eq
  if
   local.get $5
   local.get $2
   i32.store offset=96
   local.get $2
   i32.eqz
   if
    local.get $0
    local.get $4
    i32.const 2
    i32.shl
    i32.add
    local.tee $1
    local.get $1
    i32.load offset=4
    i32.const -2
    local.get $3
    i32.rotl
    i32.and
    local.tee $1
    i32.store offset=4
    local.get $1
    i32.eqz
    if
     local.get $0
     local.get $0
     i32.load
     i32.const -2
     local.get $4
     i32.rotl
     i32.and
     i32.store
    end
   end
  end
 )
 (func $~lib/rt/tlsf/insertBlock (param $0 i32) (param $1 i32)
  (local $2 i32)
  (local $3 i32)
  (local $4 i32)
  (local $5 i32)
  local.get $1
  i32.eqz
  if
   i32.const 0
   i32.const 32
   i32.const 178
   i32.const 14
   call $~lib/builtins/abort
   unreachable
  end
  local.get $1
  i32.load
  local.tee $2
  i32.const 1
  i32.and
  i32.eqz
  if
   i32.const 0
   i32.const 32
   i32.const 180
   i32.const 14
   call $~lib/builtins/abort
   unreachable
  end
  local.get $1
  i32.const 4
  i32.add
  local.tee $5
  local.get $1
  i32.load
  i32.const -4
  i32.and
  i32.add
  local.tee $3
  i32.load
  local.tee $4
  i32.const 1
  i32.and
  if
   local.get $0
   local.get $3
   call $~lib/rt/tlsf/removeBlock
   local.get $1
   local.get $2
   i32.const 4
   i32.add
   local.get $4
   i32.const -4
   i32.and
   i32.add
   local.tee $2
   i32.store
   local.get $1
   i32.load
   i32.const -4
   i32.and
   local.get $5
   i32.add
   local.tee $3
   i32.load
   local.set $4
  end
  local.get $2
  i32.const 2
  i32.and
  if
   local.get $1
   i32.const 4
   i32.sub
   i32.load
   local.tee $1
   i32.load
   local.tee $5
   i32.const 1
   i32.and
   i32.eqz
   if
    i32.const 0
    i32.const 32
    i32.const 198
    i32.const 16
    call $~lib/builtins/abort
    unreachable
   end
   local.get $0
   local.get $1
   call $~lib/rt/tlsf/removeBlock
   local.get $1
   local.get $5
   i32.const 4
   i32.add
   local.get $2
   i32.const -4
   i32.and
   i32.add
   local.tee $2
   i32.store
  end
  local.get $3
  local.get $4
  i32.const 2
  i32.or
  i32.store
  local.get $2
  i32.const -4
  i32.and
  local.tee $2
  i32.const 12
  i32.lt_u
  if
   i32.const 0
   i32.const 32
   i32.const 210
   i32.const 14
   call $~lib/builtins/abort
   unreachable
  end
  local.get $3
  local.get $1
  i32.const 4
  i32.add
  local.get $2
  i32.add
  i32.ne
  if
   i32.const 0
   i32.const 32
   i32.const 211
   i32.const 14
   call $~lib/builtins/abort
   unreachable
  end
  local.get $3
  i32.const 4
  i32.sub
  local.get $1
  i32.store
  local.get $2
  i32.const 256
  i32.lt_u
  if (result i32)
   local.get $2
   i32.const 4
   i32.shr_u
   local.set $3
   i32.const 0
  else
   i32.const 31
   i32.const 1073741820
   local.get $2
   local.get $2
   i32.const 1073741820
   i32.ge_u
   select
   local.tee $3
   i32.clz
   i32.sub
   local.set $2
   local.get $3
   local.get $2
   i32.const 4
   i32.sub
   i32.shr_u
   i32.const 16
   i32.xor
   local.set $3
   local.get $2
   i32.const 7
   i32.sub
  end
  local.set $2
  local.get $3
  i32.const 16
  i32.lt_u
  local.get $2
  i32.const 23
  i32.lt_u
  i32.and
  i32.eqz
  if
   i32.const 0
   i32.const 32
   i32.const 228
   i32.const 14
   call $~lib/builtins/abort
   unreachable
  end
  local.get $0
  local.get $2
  i32.const 4
  i32.shl
  local.get $3
  i32.add
  i32.const 2
  i32.shl
  i32.add
  i32.load offset=96
  local.set $4
  local.get $1
  i32.const 0
  i32.store offset=4
  local.get $1
  local.get $4
  i32.store offset=8
  local.get $4
  if
   local.get $4
   local.get $1
   i32.store offset=4
  end
  local.get $0
  local.get $2
  i32.const 4
  i32.shl
  local.get $3
  i32.add
  i32.const 2
  i32.shl
  i32.add
  local.get $1
  i32.store offset=96
  local.get $0
  local.get $0
  i32.load
  i32.const 1
  local.get $2
  i32.shl
  i32.or
  i32.store
  local.get $0
  local.get $2
  i32.const 2
  i32.shl
  i32.add
  local.tee $0
  local.get $0
  i32.load offset=4
  i32.const 1
  local.get $3
  i32.shl
  i32.or
  i32.store offset=4
 )
 (func $~lib/rt/tlsf/addMemory (param $0 i32) (param $1 i32) (param $2 i64)
  (local $3 i32)
  (local $4 i32)
  (local $5 i32)
  block $CONDITION_RETURN#0
   local.get $2
   local.get $1
   i64.extend_i32_u
   i64.lt_u
   if
    i32.const 0
    i32.const 32
    i32.const 357
    i32.const 14
    call $~lib/builtins/abort
    unreachable
   end
   local.get $1
   i32.const 19
   i32.add
   i32.const -16
   i32.and
   i32.const 4
   i32.sub
   local.set $1
   local.get $0
   i32.load offset=1568
   local.tee $4
   if
    local.get $4
    i32.const 4
    i32.add
    local.get $1
    i32.gt_u
    if
     i32.const 0
     i32.const 32
     i32.const 365
     i32.const 16
     call $~lib/builtins/abort
     unreachable
    end
    local.get $1
    i32.const 16
    i32.sub
    local.tee $3
    local.get $4
    i32.eq
    if
     local.get $4
     i32.load
     local.set $5
     local.get $3
     local.set $1
    end
   else
    local.get $0
    i32.const 1572
    i32.add
    local.get $1
    i32.gt_u
    if
     i32.const 0
     i32.const 32
     i32.const 378
     i32.const 5
     call $~lib/builtins/abort
     unreachable
    end
   end
   local.get $2
   i32.wrap_i64
   i32.const -16
   i32.and
   local.get $1
   i32.sub
   local.tee $3
   i32.const 20
   i32.lt_u
   br_if $CONDITION_RETURN#0
   local.get $1
   local.get $5
   i32.const 2
   i32.and
   local.get $3
   i32.const 8
   i32.sub
   local.tee $3
   i32.const 1
   i32.or
   i32.or
   i32.store
   local.get $1
   i32.const 0
   i32.store offset=4
   local.get $1
   i32.const 0
   i32.store offset=8
   local.get $1
   i32.const 4
   i32.add
   local.get $3
   i32.add
   local.tee $3
   i32.const 2
   i32.store
   local.get $0
   local.get $3
   i32.store offset=1568
   local.get $0
   local.get $1
   call $~lib/rt/tlsf/insertBlock
  end
 )
 (func $~lib/rt/tlsf/searchBlock (param $0 i32) (result i32)
  (local $1 i32)
  (local $2 i32)
  local.get $0
  i32.load offset=4
  local.tee $1
  if (result i32)
   local.get $0
   local.get $1
   i32.ctz
   i32.const 2
   i32.shl
   i32.add
   i32.load offset=96
  else
   local.get $0
   i32.load
   i32.const -2
   i32.and
   local.tee $1
   if (result i32)
    local.get $0
    local.get $1
    i32.ctz
    local.tee $1
    i32.const 2
    i32.shl
    i32.add
    i32.load offset=4
    local.tee $2
    i32.eqz
    if
     i32.const 0
     i32.const 32
     i32.const 322
     i32.const 18
     call $~lib/builtins/abort
     unreachable
    end
    local.get $0
    local.get $2
    i32.ctz
    local.get $1
    i32.const 4
    i32.shl
    i32.add
    i32.const 2
    i32.shl
    i32.add
    i32.load offset=96
   else
    i32.const 0
   end
  end
 )
 (func $~lib/rt/tlsf/__alloc
  (local $0 i32)
  (local $1 i32)
  (local $2 i32)
  (local $3 i32)
  global.get $~lib/rt/tlsf/ROOT
  i32.eqz
  if
   memory.size
   local.tee $0
   i32.const 0
   i32.le_s
   if (result i32)
    i32.const 1
    local.get $0
    i32.sub
    memory.grow
    i32.const 0
    i32.lt_s
   else
    i32.const 0
   end
   if
    unreachable
   end
   i32.const 32960
   i32.const 0
   i32.store
   i32.const 34528
   i32.const 0
   i32.store
   i32.const 0
   local.set $0
   loop $for-loop|0
    local.get $0
    i32.const 23
    i32.lt_u
    if
     local.get $0
     i32.const 2
     i32.shl
     i32.const 32960
     i32.add
     i32.const 0
     i32.store offset=4
     i32.const 0
     local.set $1
     loop $for-loop|1
      local.get $1
      i32.const 16
      i32.lt_u
      if
       local.get $0
       i32.const 4
       i32.shl
       local.get $1
       i32.add
       i32.const 2
       i32.shl
       i32.const 32960
       i32.add
       i32.const 0
       i32.store offset=96
       local.get $1
       i32.const 1
       i32.add
       local.set $1
       br $for-loop|1
      end
     end
     local.get $0
     i32.const 1
     i32.add
     local.set $0
     br $for-loop|0
    end
   end
   i32.const 32960
   i32.const 34532
   memory.size
   i64.extend_i32_s
   i64.const 16
   i64.shl
   call $~lib/rt/tlsf/addMemory
   i32.const 32960
   global.set $~lib/rt/tlsf/ROOT
  end
  global.get $~lib/rt/tlsf/ROOT
  local.tee $1
  call $~lib/rt/tlsf/searchBlock
  local.tee $0
  i32.eqz
  if
   i32.const 4
   local.get $1
   i32.load offset=1568
   memory.size
   local.tee $0
   i32.const 16
   i32.shl
   i32.const 4
   i32.sub
   i32.ne
   i32.shl
   i32.const 65547
   i32.add
   i32.const -65536
   i32.and
   i32.const 16
   i32.shr_u
   local.set $2
   local.get $0
   local.get $2
   local.get $0
   local.get $2
   i32.gt_s
   select
   memory.grow
   i32.const 0
   i32.lt_s
   if
    local.get $2
    memory.grow
    i32.const 0
    i32.lt_s
    if
     unreachable
    end
   end
   local.get $1
   local.get $0
   i32.const 16
   i32.shl
   memory.size
   i64.extend_i32_s
   i64.const 16
   i64.shl
   call $~lib/rt/tlsf/addMemory
   local.get $1
   call $~lib/rt/tlsf/searchBlock
   local.tee $0
   i32.eqz
   if
    i32.const 0
    i32.const 32
    i32.const 472
    i32.const 16
    call $~lib/builtins/abort
    unreachable
   end
  end
  local.get $0
  i32.load
  i32.const -4
  i32.and
  i32.const 12
  i32.lt_u
  if
   i32.const 0
   i32.const 32
   i32.const 474
   i32.const 14
   call $~lib/builtins/abort
   unreachable
  end
  local.get $1
  local.get $0
  call $~lib/rt/tlsf/removeBlock
  local.get $0
  i32.load
  local.tee $2
  i32.const -4
  i32.and
  i32.const 12
  i32.sub
  local.tee $3
  i32.const 16
  i32.ge_u
  if
   local.get $0
   local.get $2
   i32.const 2
   i32.and
   i32.const 12
   i32.or
   i32.store
   local.get $0
   i32.const 16
   i32.add
   local.tee $0
   local.get $3
   i32.const 4
   i32.sub
   i32.const 1
   i32.or
   i32.store
   local.get $1
   local.get $0
   call $~lib/rt/tlsf/insertBlock
  else
   local.get $0
   local.get $2
   i32.const -2
   i32.and
   i32.store
   local.get $0
   i32.const 4
   i32.add
   local.get $0
   i32.load
   i32.const -4
   i32.and
   i32.add
   local.tee $0
   local.get $0
   i32.load
   i32.const -3
   i32.and
   i32.store
  end
 )
 (func $~start
  (local $0 i32)
  (local $1 i32)
  call $~lib/rt/tlsf/__alloc
  i32.const 8
  global.set $std/pointer/one
  call $~lib/rt/tlsf/__alloc
  i32.const 24
  global.set $std/pointer/two
  global.get $std/pointer/one
  i32.const 8
  i32.ne
  if
   i32.const 0
   i32.const 160
   i32.const 87
   i32.const 1
   call $~lib/builtins/abort
   unreachable
  end
  global.get $std/pointer/two
  i32.const 24
  i32.ne
  if
   i32.const 0
   i32.const 160
   i32.const 88
   i32.const 1
   call $~lib/builtins/abort
   unreachable
  end
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
   i32.const 160
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
   i32.const 160
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
   i32.const 160
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
   i32.const 160
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
   i32.const 160
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
   i32.const 160
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
   i32.const 160
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
   i32.const 160
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
   i32.const 160
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
   i32.const 160
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
   i32.const 160
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
   i32.const 160
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
   i32.const 160
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
   i32.const 160
   i32.const 116
   i32.const 1
   call $~lib/builtins/abort
   unreachable
  end
  call $~lib/rt/tlsf/__alloc
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
   i32.const 160
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
   i32.const 160
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
   i32.const 160
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
   i32.const 160
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
   i32.const 160
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
   i32.const 160
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
   i32.const 160
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
   i32.const 160
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
   i32.const 160
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
   i32.const 160
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
   i32.const 160
   i32.const 138
   i32.const 1
   call $~lib/builtins/abort
   unreachable
  end
 )
)
