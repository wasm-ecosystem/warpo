(module
 (type $0 (func (param i32 i32) (result i32)))
 (type $1 (func (param i32 i32)))
 (type $2 (func))
 (type $3 (func (param i32 i32 i32 i32)))
 (type $4 (func (param i32 i32 i64)))
 (type $5 (func (param i32 i32 i32)))
 (type $6 (func (param i32) (result i32)))
 (import "env" "abort" (func $~lib/builtins/abort (param i32 i32 i32 i32)))
 (global $~lib/rt/tlsf/ROOT (mut i32) (i32.const 0))
 (global $heap/ptr (mut i32) (i32.const 0))
 (memory $0 1)
 (data $0 (i32.const 12) "<")
 (data $0.1 (i32.const 24) "\02\00\00\00\1e\00\00\00~\00l\00i\00b\00/\00r\00t\00/\00t\00l\00s\00f\00.\00t\00s")
 (data $1 (i32.const 76) "<")
 (data $1.1 (i32.const 88) "\02\00\00\00(\00\00\00A\00l\00l\00o\00c\00a\00t\00i\00o\00n\00 \00t\00o\00o\00 \00l\00a\00r\00g\00e")
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
   i32.const 246
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
   i32.const 248
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
   i32.const 262
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
   i32.const 179
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
   i32.const 181
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
    i32.const 199
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
   i32.const 211
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
   i32.const 212
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
   i32.const 229
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
    i32.const 358
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
     i32.const 366
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
     i32.const 379
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
 (func $~lib/rt/tlsf/initialize
  (local $0 i32)
  (local $1 i32)
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
  i32.const 32912
  i32.const 0
  i32.store
  i32.const 34480
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
    i32.const 32912
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
      i32.const 32912
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
  i32.const 32912
  i32.const 34484
  memory.size
  i64.extend_i32_s
  i64.const 16
  i64.shl
  call $~lib/rt/tlsf/addMemory
  i32.const 32912
  global.set $~lib/rt/tlsf/ROOT
 )
 (func $~lib/rt/tlsf/searchBlock (param $0 i32) (param $1 i32) (result i32)
  (local $2 i32)
  local.get $1
  i32.const 256
  i32.lt_u
  if (result i32)
   local.get $1
   i32.const 4
   i32.shr_u
   local.set $1
   i32.const 0
  else
   i32.const 31
   local.get $1
   i32.const 1
   i32.const 27
   local.get $1
   i32.clz
   i32.sub
   i32.shl
   i32.add
   i32.const 1
   i32.sub
   local.get $1
   local.get $1
   i32.const 536870910
   i32.lt_u
   select
   local.tee $1
   i32.clz
   i32.sub
   local.set $2
   local.get $1
   local.get $2
   i32.const 4
   i32.sub
   i32.shr_u
   i32.const 16
   i32.xor
   local.set $1
   local.get $2
   i32.const 7
   i32.sub
  end
  local.set $2
  local.get $1
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
   i32.const 310
   i32.const 14
   call $~lib/builtins/abort
   unreachable
  end
  local.get $0
  local.get $2
  i32.const 2
  i32.shl
  i32.add
  i32.load offset=4
  i32.const -1
  local.get $1
  i32.shl
  i32.and
  local.tee $1
  if (result i32)
   local.get $0
   local.get $1
   i32.ctz
   local.get $2
   i32.const 4
   i32.shl
   i32.add
   i32.const 2
   i32.shl
   i32.add
   i32.load offset=96
  else
   local.get $0
   i32.load
   i32.const -1
   local.get $2
   i32.const 1
   i32.add
   i32.shl
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
     i32.const 323
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
 (func $~lib/rt/tlsf/prepareBlock (param $0 i32) (param $1 i32) (param $2 i32)
  (local $3 i32)
  (local $4 i32)
  local.get $1
  i32.load
  local.set $3
  local.get $2
  i32.const 4
  i32.add
  i32.const 15
  i32.and
  if
   i32.const 0
   i32.const 32
   i32.const 337
   i32.const 14
   call $~lib/builtins/abort
   unreachable
  end
  local.get $3
  i32.const -4
  i32.and
  local.get $2
  i32.sub
  local.tee $4
  i32.const 16
  i32.ge_u
  if
   local.get $1
   local.get $2
   local.get $3
   i32.const 2
   i32.and
   i32.or
   i32.store
   local.get $1
   i32.const 4
   i32.add
   local.get $2
   i32.add
   local.tee $1
   local.get $4
   i32.const 4
   i32.sub
   i32.const 1
   i32.or
   i32.store
   local.get $0
   local.get $1
   call $~lib/rt/tlsf/insertBlock
  else
   local.get $1
   local.get $3
   i32.const -2
   i32.and
   i32.store
   local.get $1
   i32.const 4
   i32.add
   local.tee $0
   local.get $1
   i32.load
   i32.const -4
   i32.and
   local.tee $1
   i32.add
   local.get $0
   local.get $1
   i32.add
   i32.load
   i32.const -3
   i32.and
   i32.store
  end
 )
 (func $~lib/rt/tlsf/allocateBlock (param $0 i32) (param $1 i32) (result i32)
  (local $2 i32)
  (local $3 i32)
  local.get $1
  i32.const 1073741820
  i32.gt_u
  if
   i32.const 96
   i32.const 32
   i32.const 436
   i32.const 29
   call $~lib/builtins/abort
   unreachable
  end
  local.get $0
  i32.const 12
  local.get $1
  i32.const 19
  i32.add
  i32.const -16
  i32.and
  i32.const 4
  i32.sub
  local.get $1
  i32.const 12
  i32.le_u
  select
  local.tee $2
  call $~lib/rt/tlsf/searchBlock
  local.tee $1
  i32.eqz
  if
   memory.size
   local.tee $3
   local.get $2
   local.tee $1
   i32.const 256
   i32.ge_u
   if (result i32)
    local.get $1
    i32.const 1
    i32.const 27
    local.get $1
    i32.clz
    i32.sub
    i32.shl
    i32.add
    i32.const 1
    i32.sub
    local.get $1
    local.get $1
    i32.const 536870910
    i32.lt_u
    select
   else
    local.get $1
   end
   i32.const 4
   local.get $0
   i32.load offset=1568
   local.get $3
   i32.const 16
   i32.shl
   i32.const 4
   i32.sub
   i32.ne
   i32.shl
   i32.add
   i32.const 65535
   i32.add
   i32.const -65536
   i32.and
   i32.const 16
   i32.shr_u
   local.tee $1
   local.get $1
   local.get $3
   i32.lt_s
   select
   memory.grow
   i32.const 0
   i32.lt_s
   if
    local.get $1
    memory.grow
    i32.const 0
    i32.lt_s
    if
     unreachable
    end
   end
   local.get $0
   local.get $3
   i32.const 16
   i32.shl
   memory.size
   i64.extend_i32_s
   i64.const 16
   i64.shl
   call $~lib/rt/tlsf/addMemory
   local.get $0
   local.get $2
   call $~lib/rt/tlsf/searchBlock
   local.tee $1
   i32.eqz
   if
    i32.const 0
    i32.const 32
    i32.const 474
    i32.const 16
    call $~lib/builtins/abort
    unreachable
   end
  end
  local.get $2
  local.get $1
  i32.load
  i32.const -4
  i32.and
  i32.gt_u
  if
   i32.const 0
   i32.const 32
   i32.const 476
   i32.const 14
   call $~lib/builtins/abort
   unreachable
  end
  local.get $0
  local.get $1
  call $~lib/rt/tlsf/removeBlock
  local.get $0
  local.get $1
  local.get $2
  call $~lib/rt/tlsf/prepareBlock
  local.get $1
 )
 (func $~lib/rt/tlsf/checkUsedBlock (param $0 i32) (result i32)
  (local $1 i32)
  local.get $0
  i32.const 4
  i32.sub
  local.set $1
  local.get $0
  i32.const 15
  i32.and
  i32.const 1
  local.get $0
  select
  if (result i32)
   i32.const 1
  else
   local.get $1
   i32.load
   i32.const 1
   i32.and
  end
  if
   i32.const 0
   i32.const 32
   i32.const 541
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  local.get $1
 )
 (func $~lib/rt/tlsf/moveBlock (param $0 i32) (param $1 i32) (result i32)
  (local $2 i32)
  local.get $0
  i32.const 32
  call $~lib/rt/tlsf/allocateBlock
  local.tee $2
  i32.const 4
  i32.add
  local.get $1
  i32.const 4
  i32.add
  local.get $1
  i32.load
  i32.const -4
  i32.and
  memory.copy
  local.get $1
  i32.const 32908
  i32.ge_u
  if
   local.get $1
   local.get $1
   i32.load
   i32.const 1
   i32.or
   i32.store
   local.get $0
   local.get $1
   call $~lib/rt/tlsf/insertBlock
  end
  local.get $2
 )
 (func $~start
  (local $0 i32)
  (local $1 i32)
  (local $2 i32)
  (local $3 i32)
  (local $4 i32)
  (local $5 i32)
  global.get $~lib/rt/tlsf/ROOT
  i32.eqz
  if
   call $~lib/rt/tlsf/initialize
  end
  global.get $~lib/rt/tlsf/ROOT
  i32.const 16
  call $~lib/rt/tlsf/allocateBlock
  i32.const 4
  i32.add
  global.set $heap/ptr
  global.get $heap/ptr
  local.set $0
  global.get $~lib/rt/tlsf/ROOT
  i32.eqz
  if
   call $~lib/rt/tlsf/initialize
  end
  local.get $0
  i32.const 32908
  i32.lt_u
  if (result i32)
   global.get $~lib/rt/tlsf/ROOT
   local.get $0
   call $~lib/rt/tlsf/checkUsedBlock
   call $~lib/rt/tlsf/moveBlock
  else
   block $__inlined_func$~lib/rt/tlsf/reallocateBlock$51 (result i32)
    global.get $~lib/rt/tlsf/ROOT
    local.set $1
    block $folding-inner0
     local.get $0
     call $~lib/rt/tlsf/checkUsedBlock
     local.tee $0
     i32.load
     local.tee $3
     i32.const -4
     i32.and
     local.tee $2
     i32.const 44
     i32.ge_u
     br_if $folding-inner0
     local.get $0
     i32.const 4
     i32.add
     local.get $0
     i32.load
     i32.const -4
     i32.and
     i32.add
     local.tee $4
     i32.load
     local.tee $5
     i32.const 1
     i32.and
     if
      local.get $2
      i32.const 4
      i32.add
      local.get $5
      i32.const -4
      i32.and
      i32.add
      local.tee $2
      i32.const 44
      i32.ge_u
      if
       local.get $1
       local.get $4
       call $~lib/rt/tlsf/removeBlock
       local.get $0
       local.get $3
       i32.const 3
       i32.and
       local.get $2
       i32.or
       i32.store
       br $folding-inner0
      end
     end
     local.get $1
     local.get $0
     call $~lib/rt/tlsf/moveBlock
     br $__inlined_func$~lib/rt/tlsf/reallocateBlock$51
    end
    local.get $1
    local.get $0
    i32.const 44
    call $~lib/rt/tlsf/prepareBlock
    local.get $0
   end
  end
  i32.const 4
  i32.add
  global.set $heap/ptr
  global.get $heap/ptr
  local.tee $0
  i32.const 32908
  i32.ge_u
  if
   global.get $~lib/rt/tlsf/ROOT
   i32.eqz
   if
    call $~lib/rt/tlsf/initialize
   end
   global.get $~lib/rt/tlsf/ROOT
   local.set $1
   local.get $0
   call $~lib/rt/tlsf/checkUsedBlock
   local.tee $0
   local.get $0
   i32.load
   i32.const 1
   i32.or
   i32.store
   local.get $1
   local.get $0
   call $~lib/rt/tlsf/insertBlock
  end
 )
)
