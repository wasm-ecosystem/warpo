(module
 (type $0 (func (param i32 i32)))
 (type $1 (func (param i32 i32) (result i32)))
 (type $2 (func (param i32 i32 i32) (result i32)))
 (type $3 (func (param i32 i32 i32)))
 (type $4 (func (param i32)))
 (type $5 (func (param i32) (result i32)))
 (type $6 (func (param i32 i64)))
 (type $7 (func))
 (type $8 (func (param i32 i32 i32 i32)))
 (type $9 (func (param i32 i32 i64)))
 (type $10 (func (param i32 i64 i32) (result i32)))
 (type $11 (func (param i32 i64) (result i32)))
 (type $12 (func (param i32 f32)))
 (type $13 (func (param i32 f64)))
 (type $14 (func (result i32)))
 (type $15 (func (param i64) (result i32)))
 (type $16 (func (param i32 f32 i32) (result i32)))
 (type $17 (func (param i32 f32) (result i32)))
 (type $18 (func (param f64) (result i32)))
 (type $19 (func (param i32 f64 i32) (result i32)))
 (type $20 (func (param i32 f64) (result i32)))
 (import "env" "abort" (func $~lib/builtins/abort (param i32 i32 i32 i32)))
 (global $~lib/memory/__stack_pointer (mut i32) (i32.const 33492))
 (global $~lib/rt/itcms/total (mut i32) (i32.const 0))
 (global $~lib/rt/itcms/threshold (mut i32) (i32.const 0))
 (global $~lib/rt/itcms/state (mut i32) (i32.const 0))
 (global $~lib/rt/itcms/visitCount (mut i32) (i32.const 0))
 (global $~lib/rt/itcms/pinSpace (mut i32) (i32.const 0))
 (global $~lib/rt/itcms/iter (mut i32) (i32.const 0))
 (global $~lib/rt/itcms/toSpace (mut i32) (i32.const 0))
 (global $~lib/rt/itcms/white (mut i32) (i32.const 0))
 (global $~lib/rt/itcms/fromSpace (mut i32) (i32.const 0))
 (global $~lib/rt/tlsf/ROOT (mut i32) (i32.const 0))
 (memory $0 1)
 (data $0 (i32.const 12) "<")
 (data $0.1 (i32.const 24) "\02\00\00\00(\00\00\00A\00l\00l\00o\00c\00a\00t\00i\00o\00n\00 \00t\00o\00o\00 \00l\00a\00r\00g\00e")
 (data $1 (i32.const 76) "<")
 (data $1.1 (i32.const 88) "\02\00\00\00 \00\00\00~\00l\00i\00b\00/\00r\00t\00/\00i\00t\00c\00m\00s\00.\00t\00s")
 (data $4 (i32.const 204) "<")
 (data $4.1 (i32.const 216) "\02\00\00\00$\00\00\00I\00n\00d\00e\00x\00 \00o\00u\00t\00 \00o\00f\00 \00r\00a\00n\00g\00e")
 (data $5 (i32.const 268) ",")
 (data $5.1 (i32.const 280) "\02\00\00\00\14\00\00\00~\00l\00i\00b\00/\00r\00t\00.\00t\00s")
 (data $7 (i32.const 348) "<")
 (data $7.1 (i32.const 360) "\02\00\00\00\1e\00\00\00~\00l\00i\00b\00/\00r\00t\00/\00t\00l\00s\00f\00.\00t\00s")
 (data $8 (i32.const 412) ",")
 (data $8.1 (i32.const 424) "\02\00\00\00\1c\00\00\00I\00n\00v\00a\00l\00i\00d\00 \00l\00e\00n\00g\00t\00h")
 (data $9 (i32.const 460) "<")
 (data $9.1 (i32.const 472) "\02\00\00\00&\00\00\00~\00l\00i\00b\00/\00a\00r\00r\00a\00y\00b\00u\00f\00f\00e\00r\00.\00t\00s")
 (data $10 (i32.const 524) ",")
 (data $10.1 (i32.const 536) "\02\00\00\00\14\00\00\00s\00t\00d\00/\00s\00e\00t\00.\00t\00s")
 (data $11 (i32.const 572) ",")
 (data $11.1 (i32.const 584) "\02\00\00\00\1a\00\00\00~\00l\00i\00b\00/\00a\00r\00r\00a\00y\00.\00t\00s")
 (data $12 (i32.const 624) "\18\00\00\00 \00\00\00 \00\00\00 \00\00\00\00\00\00\00H\08\00\00B\08\00\00H\00\00\00B\00\00\00\88\08\00\00\82\08\00\00\88\00\00\00\82\00\00\00\08\t\00\00\02\t\00\00\08\01\00\00\02\01\00\00\08\n\00\00\02\n\00\00\08\02\00\00\02\02\00\00\08\19\00\00\02\19\00\00\08\1a\00\00\02\1a")
 (export "memory" (memory $0))
 (start $~start)
 (func $~lib/rt/itcms/visitRoots
  (local $0 i32)
  (local $1 i32)
  global.get $~lib/rt/itcms/pinSpace
  local.tee $1
  i32.load offset=4
  i32.const -4
  i32.and
  local.set $0
  loop $while-continue|0
   local.get $0
   local.get $1
   i32.ne
   if
    local.get $0
    i32.load offset=4
    i32.const 3
    i32.and
    i32.const 3
    i32.ne
    if
     i32.const 0
     i32.const 96
     i32.const 170
     i32.const 16
     call $~lib/builtins/abort
     unreachable
    end
    local.get $0
    i32.const 20
    i32.add
    call $~lib/rt/__visit_members
    local.get $0
    i32.load offset=4
    i32.const -4
    i32.and
    local.set $0
    br $while-continue|0
   end
  end
 )
 (func $~lib/rt/itcms/Object#linkTo (param $0 i32) (param $1 i32) (param $2 i32)
  (local $3 i32)
  local.get $1
  i32.load offset=8
  local.set $3
  local.get $0
  local.get $1
  local.get $2
  i32.or
  i32.store offset=4
  local.get $0
  local.get $3
  i32.store offset=8
  local.get $3
  local.get $0
  local.get $3
  i32.load offset=4
  i32.const 3
  i32.and
  i32.or
  i32.store offset=4
  local.get $1
  local.get $0
  i32.store offset=8
 )
 (func $~lib/rt/itcms/Object#makeGray (param $0 i32)
  (local $1 i32)
  (local $2 i32)
  local.get $0
  global.get $~lib/rt/itcms/iter
  i32.eq
  if
   local.get $0
   i32.load offset=8
   local.tee $1
   if (result i32)
    local.get $1
   else
    i32.const 0
    i32.const 96
    i32.const 158
    i32.const 30
    call $~lib/builtins/abort
    unreachable
   end
   global.set $~lib/rt/itcms/iter
  end
  block $__inlined_func$~lib/rt/itcms/Object#unlink$608
   local.get $0
   i32.load offset=4
   i32.const -4
   i32.and
   local.tee $2
   i32.eqz
   if
    local.get $0
    i32.load offset=8
    i32.eqz
    local.get $0
    i32.const 33492
    i32.lt_u
    i32.and
    i32.eqz
    if
     i32.const 0
     i32.const 96
     i32.const 138
     i32.const 18
     call $~lib/builtins/abort
     unreachable
    end
    br $__inlined_func$~lib/rt/itcms/Object#unlink$608
   end
   local.get $0
   i32.load offset=8
   local.tee $1
   i32.eqz
   if
    i32.const 0
    i32.const 96
    i32.const 142
    i32.const 16
    call $~lib/builtins/abort
    unreachable
   end
   local.get $2
   local.get $1
   i32.store offset=8
   local.get $1
   local.get $2
   local.get $1
   i32.load offset=4
   i32.const 3
   i32.and
   i32.or
   i32.store offset=4
  end
  local.get $0
  global.get $~lib/rt/itcms/toSpace
  local.get $0
  i32.load offset=12
  local.tee $0
  i32.const 2
  i32.le_u
  if (result i32)
   i32.const 1
  else
   local.get $0
   i32.const 624
   i32.load
   i32.gt_u
   if
    i32.const 224
    i32.const 288
    i32.const 21
    i32.const 28
    call $~lib/builtins/abort
    unreachable
   end
   local.get $0
   i32.const 2
   i32.shl
   i32.const 628
   i32.add
   i32.load
   i32.const 32
   i32.and
  end
  if (result i32)
   global.get $~lib/rt/itcms/white
   i32.eqz
  else
   i32.const 2
  end
  call $~lib/rt/itcms/Object#linkTo
 )
 (func $~lib/rt/itcms/__visit (param $0 i32)
  local.get $0
  if
   global.get $~lib/rt/itcms/white
   local.get $0
   i32.const 20
   i32.sub
   local.tee $0
   i32.load offset=4
   i32.const 3
   i32.and
   i32.eq
   if
    local.get $0
    call $~lib/rt/itcms/Object#makeGray
    global.get $~lib/rt/itcms/visitCount
    i32.const 1
    i32.add
    global.set $~lib/rt/itcms/visitCount
   end
  end
 )
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
   i32.const 368
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
   i32.const 368
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
   i32.const 368
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
   i32.const 368
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
   i32.const 368
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
    i32.const 368
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
   i32.const 368
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
   i32.const 368
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
   i32.const 368
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
    i32.const 368
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
     i32.const 368
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
     i32.const 368
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
  i32.const 33504
  i32.const 0
  i32.store
  i32.const 35072
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
    i32.const 33504
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
      i32.const 33504
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
  i32.const 33504
  i32.const 35076
  memory.size
  i64.extend_i32_s
  i64.const 16
  i64.shl
  call $~lib/rt/tlsf/addMemory
  i32.const 33504
  global.set $~lib/rt/tlsf/ROOT
 )
 (func $~lib/rt/itcms/step (result i32)
  (local $0 i32)
  (local $1 i32)
  (local $2 i32)
  block $break|0
   block $case2|0
    block $case1|0
     block $case0|0
      global.get $~lib/rt/itcms/state
      br_table $case0|0 $case1|0 $case2|0 $break|0
     end
     i32.const 1
     global.set $~lib/rt/itcms/state
     i32.const 0
     global.set $~lib/rt/itcms/visitCount
     call $~lib/rt/itcms/visitRoots
     global.get $~lib/rt/itcms/toSpace
     global.set $~lib/rt/itcms/iter
     global.get $~lib/rt/itcms/visitCount
     return
    end
    global.get $~lib/rt/itcms/white
    i32.eqz
    local.set $1
    global.get $~lib/rt/itcms/iter
    i32.load offset=4
    i32.const -4
    i32.and
    local.set $0
    loop $while-continue|1
     local.get $0
     global.get $~lib/rt/itcms/toSpace
     i32.ne
     if
      local.get $0
      global.set $~lib/rt/itcms/iter
      local.get $1
      local.get $0
      i32.load offset=4
      i32.const 3
      i32.and
      i32.ne
      if
       local.get $0
       local.get $0
       i32.load offset=4
       i32.const -4
       i32.and
       local.get $1
       i32.or
       i32.store offset=4
       i32.const 0
       global.set $~lib/rt/itcms/visitCount
       local.get $0
       i32.const 20
       i32.add
       call $~lib/rt/__visit_members
       global.get $~lib/rt/itcms/visitCount
       return
      end
      local.get $0
      i32.load offset=4
      i32.const -4
      i32.and
      local.set $0
      br $while-continue|1
     end
    end
    i32.const 0
    global.set $~lib/rt/itcms/visitCount
    call $~lib/rt/itcms/visitRoots
    global.get $~lib/rt/itcms/toSpace
    global.get $~lib/rt/itcms/iter
    i32.load offset=4
    i32.const -4
    i32.and
    i32.eq
    if
     global.get $~lib/memory/__stack_pointer
     local.set $0
     loop $while-continue|0
      local.get $0
      i32.const 33492
      i32.lt_u
      if
       local.get $0
       i32.load
       call $~lib/rt/itcms/__visit
       local.get $0
       i32.const 4
       i32.add
       local.set $0
       br $while-continue|0
      end
     end
     global.get $~lib/rt/itcms/iter
     i32.load offset=4
     i32.const -4
     i32.and
     local.set $0
     loop $while-continue|2
      local.get $0
      global.get $~lib/rt/itcms/toSpace
      i32.ne
      if
       local.get $1
       local.get $0
       i32.load offset=4
       i32.const 3
       i32.and
       i32.ne
       if
        local.get $0
        local.get $0
        i32.load offset=4
        i32.const -4
        i32.and
        local.get $1
        i32.or
        i32.store offset=4
        local.get $0
        i32.const 20
        i32.add
        call $~lib/rt/__visit_members
       end
       local.get $0
       i32.load offset=4
       i32.const -4
       i32.and
       local.set $0
       br $while-continue|2
      end
     end
     global.get $~lib/rt/itcms/fromSpace
     local.set $0
     global.get $~lib/rt/itcms/toSpace
     global.set $~lib/rt/itcms/fromSpace
     local.get $0
     global.set $~lib/rt/itcms/toSpace
     local.get $1
     global.set $~lib/rt/itcms/white
     local.get $0
     i32.load offset=4
     i32.const -4
     i32.and
     global.set $~lib/rt/itcms/iter
     i32.const 2
     global.set $~lib/rt/itcms/state
    end
    global.get $~lib/rt/itcms/visitCount
    return
   end
   global.get $~lib/rt/itcms/iter
   local.tee $0
   global.get $~lib/rt/itcms/toSpace
   i32.ne
   if
    local.get $0
    i32.load offset=4
    i32.const -4
    i32.and
    global.set $~lib/rt/itcms/iter
    global.get $~lib/rt/itcms/white
    i32.eqz
    local.get $0
    i32.load offset=4
    i32.const 3
    i32.and
    i32.ne
    if
     i32.const 0
     i32.const 96
     i32.const 240
     i32.const 20
     call $~lib/builtins/abort
     unreachable
    end
    local.get $0
    i32.const 33492
    i32.lt_u
    if
     local.get $0
     i32.const 0
     i32.store offset=4
     local.get $0
     i32.const 0
     i32.store offset=8
    else
     global.get $~lib/rt/itcms/total
     local.get $0
     i32.load
     i32.const -4
     i32.and
     i32.const 4
     i32.add
     i32.sub
     global.set $~lib/rt/itcms/total
     local.get $0
     i32.const 4
     i32.add
     local.tee $1
     i32.const 33492
     i32.ge_u
     if
      global.get $~lib/rt/tlsf/ROOT
      i32.eqz
      if
       call $~lib/rt/tlsf/initialize
      end
      global.get $~lib/rt/tlsf/ROOT
      local.set $2
      local.get $1
      i32.const 4
      i32.sub
      local.set $0
      local.get $1
      i32.const 15
      i32.and
      i32.const 1
      local.get $1
      select
      if (result i32)
       i32.const 1
      else
       local.get $0
       i32.load
       i32.const 1
       i32.and
      end
      if
       i32.const 0
       i32.const 368
       i32.const 541
       i32.const 3
       call $~lib/builtins/abort
       unreachable
      end
      local.get $0
      local.get $0
      i32.load
      i32.const 1
      i32.or
      i32.store
      local.get $2
      local.get $0
      call $~lib/rt/tlsf/insertBlock
     end
    end
    i32.const 10
    return
   end
   global.get $~lib/rt/itcms/toSpace
   global.get $~lib/rt/itcms/toSpace
   i32.store offset=4
   global.get $~lib/rt/itcms/toSpace
   global.get $~lib/rt/itcms/toSpace
   i32.store offset=8
   i32.const 0
   global.set $~lib/rt/itcms/state
  end
  i32.const 0
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
   i32.const 368
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
     i32.const 368
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
 (func $~lib/rt/itcms/__new (param $0 i32) (param $1 i32) (result i32)
  (local $2 i32)
  (local $3 i32)
  (local $4 i32)
  (local $5 i32)
  (local $6 i32)
  local.get $0
  i32.const 1073741804
  i32.ge_u
  if
   i32.const 32
   i32.const 96
   i32.const 273
   i32.const 31
   call $~lib/builtins/abort
   unreachable
  end
  global.get $~lib/rt/itcms/total
  global.get $~lib/rt/itcms/threshold
  i32.ge_u
  if
   block $__inlined_func$~lib/rt/itcms/interrupt$68
    i32.const 2048
    local.set $3
    loop $do-loop|0
     local.get $3
     call $~lib/rt/itcms/step
     i32.sub
     local.set $3
     global.get $~lib/rt/itcms/state
     i32.eqz
     if
      global.get $~lib/rt/itcms/total
      i64.extend_i32_u
      i64.const 200
      i64.mul
      i64.const 100
      i64.div_u
      i32.wrap_i64
      i32.const 1024
      i32.add
      global.set $~lib/rt/itcms/threshold
      br $__inlined_func$~lib/rt/itcms/interrupt$68
     end
     local.get $3
     i32.const 0
     i32.gt_s
     br_if $do-loop|0
    end
    global.get $~lib/rt/itcms/total
    global.get $~lib/rt/itcms/total
    global.get $~lib/rt/itcms/threshold
    i32.sub
    i32.const 1024
    i32.lt_u
    i32.const 10
    i32.shl
    i32.add
    global.set $~lib/rt/itcms/threshold
   end
  end
  global.get $~lib/rt/tlsf/ROOT
  i32.eqz
  if
   call $~lib/rt/tlsf/initialize
  end
  global.get $~lib/rt/tlsf/ROOT
  local.set $5
  local.get $0
  i32.const 16
  i32.add
  local.tee $3
  i32.const 1073741820
  i32.gt_u
  if
   i32.const 32
   i32.const 368
   i32.const 436
   i32.const 29
   call $~lib/builtins/abort
   unreachable
  end
  local.get $5
  i32.const 12
  local.get $3
  i32.const 19
  i32.add
  i32.const -16
  i32.and
  i32.const 4
  i32.sub
  local.get $3
  i32.const 12
  i32.le_u
  select
  local.tee $3
  call $~lib/rt/tlsf/searchBlock
  local.tee $2
  i32.eqz
  if
   memory.size
   local.tee $4
   local.get $3
   local.tee $2
   i32.const 256
   i32.ge_u
   if (result i32)
    local.get $2
    i32.const 1
    i32.const 27
    local.get $2
    i32.clz
    i32.sub
    i32.shl
    i32.add
    i32.const 1
    i32.sub
    local.get $2
    local.get $2
    i32.const 536870910
    i32.lt_u
    select
   else
    local.get $2
   end
   i32.const 4
   local.get $5
   i32.load offset=1568
   local.get $4
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
   local.tee $2
   local.get $2
   local.get $4
   i32.lt_s
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
   local.get $5
   local.get $4
   i32.const 16
   i32.shl
   memory.size
   i64.extend_i32_s
   i64.const 16
   i64.shl
   call $~lib/rt/tlsf/addMemory
   local.get $5
   local.get $3
   call $~lib/rt/tlsf/searchBlock
   local.tee $2
   i32.eqz
   if
    i32.const 0
    i32.const 368
    i32.const 474
    i32.const 16
    call $~lib/builtins/abort
    unreachable
   end
  end
  local.get $3
  local.get $2
  i32.load
  i32.const -4
  i32.and
  i32.gt_u
  if
   i32.const 0
   i32.const 368
   i32.const 476
   i32.const 14
   call $~lib/builtins/abort
   unreachable
  end
  local.get $5
  local.get $2
  call $~lib/rt/tlsf/removeBlock
  local.get $2
  i32.load
  local.set $6
  local.get $3
  i32.const 4
  i32.add
  i32.const 15
  i32.and
  if
   i32.const 0
   i32.const 368
   i32.const 337
   i32.const 14
   call $~lib/builtins/abort
   unreachable
  end
  local.get $6
  i32.const -4
  i32.and
  local.get $3
  i32.sub
  local.tee $4
  i32.const 16
  i32.ge_u
  if
   local.get $2
   local.get $3
   local.get $6
   i32.const 2
   i32.and
   i32.or
   i32.store
   local.get $2
   i32.const 4
   i32.add
   local.get $3
   i32.add
   local.tee $3
   local.get $4
   i32.const 4
   i32.sub
   i32.const 1
   i32.or
   i32.store
   local.get $5
   local.get $3
   call $~lib/rt/tlsf/insertBlock
  else
   local.get $2
   local.get $6
   i32.const -2
   i32.and
   i32.store
   local.get $2
   i32.const 4
   i32.add
   local.tee $4
   local.get $2
   i32.load
   i32.const -4
   i32.and
   local.tee $3
   i32.add
   local.get $3
   local.get $4
   i32.add
   i32.load
   i32.const -3
   i32.and
   i32.store
  end
  local.get $2
  local.get $1
  i32.store offset=12
  local.get $2
  local.get $0
  i32.store offset=16
  local.get $2
  global.get $~lib/rt/itcms/fromSpace
  global.get $~lib/rt/itcms/white
  call $~lib/rt/itcms/Object#linkTo
  global.get $~lib/rt/itcms/total
  local.get $2
  i32.load
  i32.const -4
  i32.and
  i32.const 4
  i32.add
  i32.add
  global.set $~lib/rt/itcms/total
  local.get $2
  i32.const 20
  i32.add
  local.tee $1
  i32.const 0
  local.get $0
  memory.fill
  local.get $1
 )
 (func $~lib/arraybuffer/ArrayBuffer#constructor (param $0 i32) (result i32)
  local.get $0
  i32.const 1073741820
  i32.gt_u
  if
   i32.const 432
   i32.const 480
   i32.const 53
   i32.const 43
   call $~lib/builtins/abort
   unreachable
  end
  local.get $0
  i32.const 1
  call $~lib/rt/itcms/__new
 )
 (func $~lib/rt/itcms/__link (param $0 i32) (param $1 i32)
  local.get $1
  if
   local.get $0
   i32.eqz
   if
    i32.const 0
    i32.const 96
    i32.const 307
    i32.const 14
    call $~lib/builtins/abort
    unreachable
   end
   global.get $~lib/rt/itcms/white
   local.get $1
   i32.const 20
   i32.sub
   local.tee $1
   i32.load offset=4
   i32.const 3
   i32.and
   i32.eq
   if
    local.get $0
    i32.const 20
    i32.sub
    i32.load offset=4
    i32.const 3
    i32.and
    local.tee $0
    global.get $~lib/rt/itcms/white
    i32.eqz
    i32.eq
    if
     local.get $1
     call $~lib/rt/itcms/Object#makeGray
    else
     global.get $~lib/rt/itcms/state
     i32.const 1
     i32.eq
     local.get $0
     i32.const 3
     i32.eq
     i32.and
     if
      local.get $1
      call $~lib/rt/itcms/Object#makeGray
     end
    end
   end
  end
 )
 (func $~lib/set/Set<i8>#set:buckets (param $0 i32) (param $1 i32)
  local.get $0
  local.get $1
  i32.store
  local.get $0
  local.get $1
  call $~lib/rt/itcms/__link
 )
 (func $~lib/set/Set<i8>#set:entries (param $0 i32) (param $1 i32)
  local.get $0
  local.get $1
  i32.store offset=8
  local.get $0
  local.get $1
  call $~lib/rt/itcms/__link
 )
 (func $~lib/set/Set<i8>#find (param $0 i32) (param $1 i32) (param $2 i32) (result i32)
  local.get $0
  i32.load
  local.get $2
  local.get $0
  i32.load offset=4
  i32.and
  i32.const 2
  i32.shl
  i32.add
  i32.load
  local.set $0
  loop $while-continue|0
   local.get $0
   if
    local.get $0
    i32.load offset=4
    local.tee $2
    i32.const 1
    i32.and
    if (result i32)
     i32.const 0
    else
     local.get $0
     i32.load8_u
     local.get $1
     i32.const 255
     i32.and
     i32.eq
    end
    if
     local.get $0
     return
    end
    local.get $2
    i32.const -2
    i32.and
    local.set $0
    br $while-continue|0
   end
  end
  i32.const 0
 )
 (func $~lib/set/Set<i8>#has (param $0 i32) (param $1 i32) (result i32)
  local.get $0
  local.get $1
  local.get $1
  i32.extend8_s
  i32.const -1028477379
  i32.mul
  i32.const 374761394
  i32.add
  i32.const 17
  i32.rotl
  i32.const 668265263
  i32.mul
  local.tee $0
  i32.const 15
  i32.shr_u
  local.get $0
  i32.xor
  i32.const -2048144777
  i32.mul
  local.tee $0
  i32.const 13
  i32.shr_u
  local.get $0
  i32.xor
  i32.const -1028477379
  i32.mul
  local.tee $0
  i32.const 16
  i32.shr_u
  local.get $0
  i32.xor
  call $~lib/set/Set<i8>#find
  i32.const 0
  i32.ne
 )
 (func $~lib/set/Set<i8>#rehash (param $0 i32) (param $1 i32)
  (local $2 i32)
  (local $3 i32)
  (local $4 i32)
  (local $5 i32)
  (local $6 i32)
  (local $7 i32)
  (local $8 i32)
  i32.const 4
  call $~lib/rt/__decrease_sp
  local.get $1
  i32.const 1
  i32.add
  local.tee $3
  i32.const 2
  i32.shl
  call $~lib/arraybuffer/ArrayBuffer#constructor
  local.set $5
  global.get $~lib/memory/__stack_pointer
  local.get $5
  i32.store align=1
  local.get $3
  i32.const 3
  i32.shl
  i32.const 3
  i32.div_s
  local.tee $7
  i32.const 3
  i32.shl
  call $~lib/arraybuffer/ArrayBuffer#constructor
  local.set $6
  local.get $0
  i32.load offset=8
  local.tee $4
  local.get $0
  i32.load offset=16
  i32.const 3
  i32.shl
  i32.add
  local.set $8
  local.get $6
  local.set $3
  loop $while-continue|0
   local.get $4
   local.get $8
   i32.ne
   if
    local.get $4
    i32.load offset=4
    i32.const 1
    i32.and
    i32.eqz
    if
     local.get $3
     local.get $4
     i32.load8_s
     local.tee $2
     i32.store8
     local.get $3
     local.get $5
     local.get $1
     local.get $2
     i32.extend8_s
     i32.const -1028477379
     i32.mul
     i32.const 374761394
     i32.add
     i32.const 17
     i32.rotl
     i32.const 668265263
     i32.mul
     local.tee $2
     i32.const 15
     i32.shr_u
     local.get $2
     i32.xor
     i32.const -2048144777
     i32.mul
     local.tee $2
     i32.const 13
     i32.shr_u
     local.get $2
     i32.xor
     i32.const -1028477379
     i32.mul
     local.tee $2
     i32.const 16
     i32.shr_u
     local.get $2
     i32.xor
     i32.and
     i32.const 2
     i32.shl
     i32.add
     local.tee $2
     i32.load
     i32.store offset=4
     local.get $2
     local.get $3
     i32.store
     local.get $3
     i32.const 8
     i32.add
     local.set $3
    end
    local.get $4
    i32.const 8
    i32.add
    local.set $4
    br $while-continue|0
   end
  end
  local.get $0
  local.get $5
  call $~lib/set/Set<i8>#set:buckets
  local.get $0
  local.get $1
  i32.store offset=4
  local.get $0
  local.get $6
  call $~lib/set/Set<i8>#set:entries
  local.get $0
  local.get $7
  i32.store offset=12
  local.get $0
  local.get $0
  i32.load offset=20
  i32.store offset=16
  global.get $~lib/memory/__stack_pointer
  i32.const 4
  i32.add
  global.set $~lib/memory/__stack_pointer
 )
 (func $~lib/set/Set<i8>#add (param $0 i32) (param $1 i32)
  (local $2 i32)
  (local $3 i32)
  local.get $0
  local.get $1
  local.get $1
  i32.extend8_s
  i32.const -1028477379
  i32.mul
  i32.const 374761394
  i32.add
  i32.const 17
  i32.rotl
  i32.const 668265263
  i32.mul
  local.tee $2
  i32.const 15
  i32.shr_u
  local.get $2
  i32.xor
  i32.const -2048144777
  i32.mul
  local.tee $2
  i32.const 13
  i32.shr_u
  local.get $2
  i32.xor
  i32.const -1028477379
  i32.mul
  local.tee $2
  i32.const 16
  i32.shr_u
  local.get $2
  i32.xor
  local.tee $3
  call $~lib/set/Set<i8>#find
  i32.eqz
  if
   local.get $0
   i32.load offset=16
   local.get $0
   i32.load offset=12
   i32.eq
   if
    local.get $0
    local.get $0
    i32.load offset=20
    local.get $0
    i32.load offset=12
    i32.const 3
    i32.mul
    i32.const 4
    i32.div_s
    i32.lt_s
    if (result i32)
     local.get $0
     i32.load offset=4
    else
     local.get $0
     i32.load offset=4
     i32.const 1
     i32.shl
     i32.const 1
     i32.or
    end
    call $~lib/set/Set<i8>#rehash
   end
   local.get $0
   i32.load offset=8
   local.get $0
   local.get $0
   i32.load offset=16
   local.tee $2
   i32.const 1
   i32.add
   i32.store offset=16
   local.get $2
   i32.const 3
   i32.shl
   i32.add
   local.tee $2
   local.get $1
   i32.store8
   local.get $0
   local.get $0
   i32.load offset=20
   i32.const 1
   i32.add
   i32.store offset=20
   local.get $2
   local.get $0
   i32.load
   local.get $3
   local.get $0
   i32.load offset=4
   i32.and
   i32.const 2
   i32.shl
   i32.add
   local.tee $0
   i32.load
   i32.store offset=4
   local.get $0
   local.get $2
   i32.store
  end
 )
 (func $~lib/array/ensureCapacity (param $0 i32) (param $1 i32) (param $2 i32) (param $3 i32)
  (local $4 i32)
  local.get $1
  local.get $0
  i32.load offset=8
  local.tee $4
  local.get $2
  i32.shr_u
  i32.gt_u
  if
   local.get $1
   i32.const 1073741820
   local.get $2
   i32.shr_u
   i32.gt_u
   if
    i32.const 432
    i32.const 592
    i32.const 30
    i32.const 48
    call $~lib/builtins/abort
    unreachable
   end
   i32.const 8
   local.get $1
   local.get $1
   i32.const 8
   i32.le_u
   select
   local.get $2
   i32.shl
   local.set $1
   local.get $0
   i32.load
   local.tee $2
   block $__inlined_func$~lib/rt/itcms/__renew$613 (result i32)
    local.get $3
    if
     i32.const 1073741820
     local.get $4
     i32.const 1
     i32.shl
     local.tee $3
     local.get $3
     i32.const 1073741820
     i32.ge_u
     select
     local.tee $3
     local.get $1
     local.get $1
     local.get $3
     i32.lt_u
     select
     local.set $1
    end
    local.get $2
    i32.const 20
    i32.sub
    local.tee $3
    i32.load
    i32.const -4
    i32.and
    i32.const 16
    i32.sub
    local.get $1
    i32.ge_u
    if
     local.get $3
     local.get $1
     i32.store offset=16
     local.get $2
     br $__inlined_func$~lib/rt/itcms/__renew$613
    end
    local.get $1
    local.get $3
    i32.load offset=12
    call $~lib/rt/itcms/__new
    local.tee $4
    local.get $2
    local.get $1
    local.get $3
    i32.load offset=16
    local.tee $2
    local.get $1
    local.get $2
    i32.lt_u
    select
    memory.copy
    local.get $4
   end
   local.tee $2
   i32.ne
   if
    local.get $0
    local.get $2
    i32.store
    local.get $0
    local.get $2
    i32.store offset=4
    local.get $0
    local.get $2
    call $~lib/rt/itcms/__link
   end
   local.get $0
   local.get $1
   i32.store offset=8
  end
 )
 (func $~lib/array/Array<i8>#__set (param $0 i32) (param $1 i32) (param $2 i32)
  (local $3 i32)
  local.get $1
  local.get $0
  i32.load offset=12
  i32.ge_u
  if
   local.get $1
   i32.const 0
   i32.lt_s
   if
    i32.const 224
    i32.const 592
    i32.const 147
    i32.const 22
    call $~lib/builtins/abort
    unreachable
   end
   local.get $0
   local.get $1
   i32.const 1
   i32.add
   local.tee $3
   i32.const 0
   i32.const 1
   call $~lib/array/ensureCapacity
   local.get $0
   local.get $3
   i32.store offset=12
  end
  local.get $1
  local.get $0
  i32.load offset=4
  i32.add
  local.get $2
  i32.store8
 )
 (func $~lib/set/Set<i8>#delete (param $0 i32) (param $1 i32)
  (local $2 i32)
  local.get $0
  local.get $1
  local.get $1
  i32.extend8_s
  i32.const -1028477379
  i32.mul
  i32.const 374761394
  i32.add
  i32.const 17
  i32.rotl
  i32.const 668265263
  i32.mul
  local.tee $1
  i32.const 15
  i32.shr_u
  local.get $1
  i32.xor
  i32.const -2048144777
  i32.mul
  local.tee $1
  i32.const 13
  i32.shr_u
  local.get $1
  i32.xor
  i32.const -1028477379
  i32.mul
  local.tee $1
  i32.const 16
  i32.shr_u
  local.get $1
  i32.xor
  call $~lib/set/Set<i8>#find
  local.tee $1
  if
   local.get $1
   local.get $1
   i32.load offset=4
   i32.const 1
   i32.or
   i32.store offset=4
   local.get $0
   local.get $0
   i32.load offset=20
   i32.const 1
   i32.sub
   i32.store offset=20
   local.get $0
   i32.load offset=4
   i32.const 1
   i32.shr_u
   local.tee $1
   i32.const 1
   i32.add
   i32.const 4
   local.get $0
   i32.load offset=20
   local.tee $2
   local.get $2
   i32.const 4
   i32.lt_u
   select
   i32.ge_u
   if (result i32)
    local.get $0
    i32.load offset=20
    local.get $0
    i32.load offset=12
    i32.const 3
    i32.mul
    i32.const 4
    i32.div_s
    i32.lt_s
   else
    i32.const 0
   end
   if
    local.get $0
    local.get $1
    call $~lib/set/Set<i8>#rehash
   end
  end
 )
 (func $~lib/util/hash/HASH<u8> (param $0 i32) (result i32)
  local.get $0
  i32.const 374761394
  i32.const 255
  call $byn$mgfn-shared$~lib/util/hash/HASH<u8>
 )
 (func $~lib/set/Set<u8>#has (param $0 i32) (param $1 i32) (result i32)
  local.get $0
  local.get $1
  local.get $1
  call $~lib/util/hash/HASH<u8>
  call $~lib/set/Set<i8>#find
  i32.const 0
  i32.ne
 )
 (func $~lib/set/Set<u8>#rehash (param $0 i32) (param $1 i32)
  (local $2 i32)
  (local $3 i32)
  (local $4 i32)
  (local $5 i32)
  (local $6 i32)
  (local $7 i32)
  (local $8 i32)
  i32.const 4
  call $~lib/rt/__decrease_sp
  local.get $1
  i32.const 1
  i32.add
  local.tee $2
  i32.const 2
  i32.shl
  call $~lib/arraybuffer/ArrayBuffer#constructor
  local.set $4
  global.get $~lib/memory/__stack_pointer
  local.get $4
  i32.store align=1
  local.get $2
  i32.const 3
  i32.shl
  i32.const 3
  i32.div_s
  local.tee $7
  i32.const 3
  i32.shl
  call $~lib/arraybuffer/ArrayBuffer#constructor
  local.set $6
  local.get $0
  i32.load offset=8
  local.tee $3
  local.get $0
  i32.load offset=16
  i32.const 3
  i32.shl
  i32.add
  local.set $8
  local.get $6
  local.set $2
  loop $while-continue|0
   local.get $3
   local.get $8
   i32.ne
   if
    local.get $3
    i32.load offset=4
    i32.const 1
    i32.and
    i32.eqz
    if
     local.get $2
     local.get $3
     i32.load8_u
     local.tee $5
     i32.store8
     local.get $2
     local.get $4
     local.get $5
     call $~lib/util/hash/HASH<u8>
     local.get $1
     i32.and
     i32.const 2
     i32.shl
     i32.add
     local.tee $5
     i32.load
     i32.store offset=4
     local.get $5
     local.get $2
     i32.store
     local.get $2
     i32.const 8
     i32.add
     local.set $2
    end
    local.get $3
    i32.const 8
    i32.add
    local.set $3
    br $while-continue|0
   end
  end
  local.get $0
  local.get $4
  call $~lib/set/Set<i8>#set:buckets
  local.get $0
  local.get $1
  i32.store offset=4
  local.get $0
  local.get $6
  call $~lib/set/Set<i8>#set:entries
  local.get $0
  local.get $7
  i32.store offset=12
  local.get $0
  local.get $0
  i32.load offset=20
  i32.store offset=16
  global.get $~lib/memory/__stack_pointer
  i32.const 4
  i32.add
  global.set $~lib/memory/__stack_pointer
 )
 (func $~lib/set/Set<u8>#add (param $0 i32) (param $1 i32)
  (local $2 i32)
  (local $3 i32)
  local.get $0
  local.get $1
  local.get $1
  call $~lib/util/hash/HASH<u8>
  local.tee $3
  call $~lib/set/Set<i8>#find
  i32.eqz
  if
   local.get $0
   i32.load offset=16
   local.get $0
   i32.load offset=12
   i32.eq
   if
    local.get $0
    local.get $0
    i32.load offset=20
    local.get $0
    i32.load offset=12
    i32.const 3
    i32.mul
    i32.const 4
    i32.div_s
    i32.lt_s
    if (result i32)
     local.get $0
     i32.load offset=4
    else
     local.get $0
     i32.load offset=4
     i32.const 1
     i32.shl
     i32.const 1
     i32.or
    end
    call $~lib/set/Set<u8>#rehash
   end
   local.get $0
   i32.load offset=8
   local.get $0
   local.get $0
   i32.load offset=16
   local.tee $2
   i32.const 1
   i32.add
   i32.store offset=16
   local.get $2
   i32.const 3
   i32.shl
   i32.add
   local.tee $2
   local.get $1
   i32.store8
   local.get $0
   local.get $0
   i32.load offset=20
   i32.const 1
   i32.add
   i32.store offset=20
   local.get $2
   local.get $0
   i32.load
   local.get $3
   local.get $0
   i32.load offset=4
   i32.and
   i32.const 2
   i32.shl
   i32.add
   local.tee $0
   i32.load
   i32.store offset=4
   local.get $0
   local.get $2
   i32.store
  end
 )
 (func $~lib/set/Set<u8>#delete (param $0 i32) (param $1 i32)
  (local $2 i32)
  local.get $0
  local.get $1
  local.get $1
  call $~lib/util/hash/HASH<u8>
  call $~lib/set/Set<i8>#find
  local.tee $1
  if
   local.get $1
   local.get $1
   i32.load offset=4
   i32.const 1
   i32.or
   i32.store offset=4
   local.get $0
   local.get $0
   i32.load offset=20
   i32.const 1
   i32.sub
   i32.store offset=20
   local.get $0
   i32.load offset=4
   i32.const 1
   i32.shr_u
   local.tee $1
   i32.const 1
   i32.add
   i32.const 4
   local.get $0
   i32.load offset=20
   local.tee $2
   local.get $2
   i32.const 4
   i32.lt_u
   select
   i32.ge_u
   if (result i32)
    local.get $0
    i32.load offset=20
    local.get $0
    i32.load offset=12
    i32.const 3
    i32.mul
    i32.const 4
    i32.div_s
    i32.lt_s
   else
    i32.const 0
   end
   if
    local.get $0
    local.get $1
    call $~lib/set/Set<u8>#rehash
   end
  end
 )
 (func $~lib/set/Set<i16>#find (param $0 i32) (param $1 i32) (param $2 i32) (result i32)
  local.get $0
  i32.load
  local.get $2
  local.get $0
  i32.load offset=4
  i32.and
  i32.const 2
  i32.shl
  i32.add
  i32.load
  local.set $0
  loop $while-continue|0
   local.get $0
   if
    local.get $0
    i32.load offset=4
    local.tee $2
    i32.const 1
    i32.and
    if (result i32)
     i32.const 0
    else
     local.get $0
     i32.load16_u
     local.get $1
     i32.const 65535
     i32.and
     i32.eq
    end
    if
     local.get $0
     return
    end
    local.get $2
    i32.const -2
    i32.and
    local.set $0
    br $while-continue|0
   end
  end
  i32.const 0
 )
 (func $~lib/set/Set<i16>#has (param $0 i32) (param $1 i32) (result i32)
  local.get $0
  local.get $1
  local.get $1
  i32.extend16_s
  i32.const -1028477379
  i32.mul
  i32.const 374761395
  i32.add
  i32.const 17
  i32.rotl
  i32.const 668265263
  i32.mul
  local.tee $0
  i32.const 15
  i32.shr_u
  local.get $0
  i32.xor
  i32.const -2048144777
  i32.mul
  local.tee $0
  i32.const 13
  i32.shr_u
  local.get $0
  i32.xor
  i32.const -1028477379
  i32.mul
  local.tee $0
  i32.const 16
  i32.shr_u
  local.get $0
  i32.xor
  call $~lib/set/Set<i16>#find
  i32.const 0
  i32.ne
 )
 (func $~lib/set/Set<i16>#rehash (param $0 i32) (param $1 i32)
  (local $2 i32)
  (local $3 i32)
  (local $4 i32)
  (local $5 i32)
  (local $6 i32)
  (local $7 i32)
  (local $8 i32)
  i32.const 4
  call $~lib/rt/__decrease_sp
  local.get $1
  i32.const 1
  i32.add
  local.tee $3
  i32.const 2
  i32.shl
  call $~lib/arraybuffer/ArrayBuffer#constructor
  local.set $5
  global.get $~lib/memory/__stack_pointer
  local.get $5
  i32.store align=1
  local.get $3
  i32.const 3
  i32.shl
  i32.const 3
  i32.div_s
  local.tee $7
  i32.const 3
  i32.shl
  call $~lib/arraybuffer/ArrayBuffer#constructor
  local.set $6
  local.get $0
  i32.load offset=8
  local.tee $4
  local.get $0
  i32.load offset=16
  i32.const 3
  i32.shl
  i32.add
  local.set $8
  local.get $6
  local.set $3
  loop $while-continue|0
   local.get $4
   local.get $8
   i32.ne
   if
    local.get $4
    i32.load offset=4
    i32.const 1
    i32.and
    i32.eqz
    if
     local.get $3
     local.get $4
     i32.load16_s
     local.tee $2
     i32.store16
     local.get $3
     local.get $5
     local.get $1
     local.get $2
     i32.extend16_s
     i32.const -1028477379
     i32.mul
     i32.const 374761395
     i32.add
     i32.const 17
     i32.rotl
     i32.const 668265263
     i32.mul
     local.tee $2
     i32.const 15
     i32.shr_u
     local.get $2
     i32.xor
     i32.const -2048144777
     i32.mul
     local.tee $2
     i32.const 13
     i32.shr_u
     local.get $2
     i32.xor
     i32.const -1028477379
     i32.mul
     local.tee $2
     i32.const 16
     i32.shr_u
     local.get $2
     i32.xor
     i32.and
     i32.const 2
     i32.shl
     i32.add
     local.tee $2
     i32.load
     i32.store offset=4
     local.get $2
     local.get $3
     i32.store
     local.get $3
     i32.const 8
     i32.add
     local.set $3
    end
    local.get $4
    i32.const 8
    i32.add
    local.set $4
    br $while-continue|0
   end
  end
  local.get $0
  local.get $5
  call $~lib/set/Set<i8>#set:buckets
  local.get $0
  local.get $1
  i32.store offset=4
  local.get $0
  local.get $6
  call $~lib/set/Set<i8>#set:entries
  local.get $0
  local.get $7
  i32.store offset=12
  local.get $0
  local.get $0
  i32.load offset=20
  i32.store offset=16
  global.get $~lib/memory/__stack_pointer
  i32.const 4
  i32.add
  global.set $~lib/memory/__stack_pointer
 )
 (func $~lib/set/Set<i16>#add (param $0 i32) (param $1 i32)
  (local $2 i32)
  (local $3 i32)
  local.get $0
  local.get $1
  local.get $1
  i32.extend16_s
  i32.const -1028477379
  i32.mul
  i32.const 374761395
  i32.add
  i32.const 17
  i32.rotl
  i32.const 668265263
  i32.mul
  local.tee $2
  i32.const 15
  i32.shr_u
  local.get $2
  i32.xor
  i32.const -2048144777
  i32.mul
  local.tee $2
  i32.const 13
  i32.shr_u
  local.get $2
  i32.xor
  i32.const -1028477379
  i32.mul
  local.tee $2
  i32.const 16
  i32.shr_u
  local.get $2
  i32.xor
  local.tee $3
  call $~lib/set/Set<i16>#find
  i32.eqz
  if
   local.get $0
   i32.load offset=16
   local.get $0
   i32.load offset=12
   i32.eq
   if
    local.get $0
    local.get $0
    i32.load offset=20
    local.get $0
    i32.load offset=12
    i32.const 3
    i32.mul
    i32.const 4
    i32.div_s
    i32.lt_s
    if (result i32)
     local.get $0
     i32.load offset=4
    else
     local.get $0
     i32.load offset=4
     i32.const 1
     i32.shl
     i32.const 1
     i32.or
    end
    call $~lib/set/Set<i16>#rehash
   end
   local.get $0
   i32.load offset=8
   local.get $0
   local.get $0
   i32.load offset=16
   local.tee $2
   i32.const 1
   i32.add
   i32.store offset=16
   local.get $2
   i32.const 3
   i32.shl
   i32.add
   local.tee $2
   local.get $1
   i32.store16
   local.get $0
   local.get $0
   i32.load offset=20
   i32.const 1
   i32.add
   i32.store offset=20
   local.get $2
   local.get $0
   i32.load
   local.get $3
   local.get $0
   i32.load offset=4
   i32.and
   i32.const 2
   i32.shl
   i32.add
   local.tee $0
   i32.load
   i32.store offset=4
   local.get $0
   local.get $2
   i32.store
  end
 )
 (func $~lib/array/Array<i16>#__set (param $0 i32) (param $1 i32) (param $2 i32)
  (local $3 i32)
  local.get $1
  local.get $0
  i32.load offset=12
  i32.ge_u
  if
   local.get $1
   i32.const 0
   i32.lt_s
   if
    i32.const 224
    i32.const 592
    i32.const 147
    i32.const 22
    call $~lib/builtins/abort
    unreachable
   end
   local.get $0
   local.get $1
   i32.const 1
   i32.add
   local.tee $3
   i32.const 1
   i32.const 1
   call $~lib/array/ensureCapacity
   local.get $0
   local.get $3
   i32.store offset=12
  end
  local.get $0
  i32.load offset=4
  local.get $1
  i32.const 1
  i32.shl
  i32.add
  local.get $2
  i32.store16
 )
 (func $~lib/set/Set<i16>#delete (param $0 i32) (param $1 i32)
  (local $2 i32)
  local.get $0
  local.get $1
  local.get $1
  i32.extend16_s
  i32.const -1028477379
  i32.mul
  i32.const 374761395
  i32.add
  i32.const 17
  i32.rotl
  i32.const 668265263
  i32.mul
  local.tee $1
  i32.const 15
  i32.shr_u
  local.get $1
  i32.xor
  i32.const -2048144777
  i32.mul
  local.tee $1
  i32.const 13
  i32.shr_u
  local.get $1
  i32.xor
  i32.const -1028477379
  i32.mul
  local.tee $1
  i32.const 16
  i32.shr_u
  local.get $1
  i32.xor
  call $~lib/set/Set<i16>#find
  local.tee $1
  if
   local.get $1
   local.get $1
   i32.load offset=4
   i32.const 1
   i32.or
   i32.store offset=4
   local.get $0
   local.get $0
   i32.load offset=20
   i32.const 1
   i32.sub
   i32.store offset=20
   local.get $0
   i32.load offset=4
   i32.const 1
   i32.shr_u
   local.tee $1
   i32.const 1
   i32.add
   i32.const 4
   local.get $0
   i32.load offset=20
   local.tee $2
   local.get $2
   i32.const 4
   i32.lt_u
   select
   i32.ge_u
   if (result i32)
    local.get $0
    i32.load offset=20
    local.get $0
    i32.load offset=12
    i32.const 3
    i32.mul
    i32.const 4
    i32.div_s
    i32.lt_s
   else
    i32.const 0
   end
   if
    local.get $0
    local.get $1
    call $~lib/set/Set<i16>#rehash
   end
  end
 )
 (func $~lib/util/hash/HASH<u16> (param $0 i32) (result i32)
  local.get $0
  i32.const 374761395
  i32.const 65535
  call $byn$mgfn-shared$~lib/util/hash/HASH<u8>
 )
 (func $~lib/set/Set<u16>#has (param $0 i32) (param $1 i32) (result i32)
  local.get $0
  local.get $1
  local.get $1
  call $~lib/util/hash/HASH<u16>
  call $~lib/set/Set<i16>#find
  i32.const 0
  i32.ne
 )
 (func $~lib/set/Set<u16>#rehash (param $0 i32) (param $1 i32)
  (local $2 i32)
  (local $3 i32)
  (local $4 i32)
  (local $5 i32)
  (local $6 i32)
  (local $7 i32)
  (local $8 i32)
  i32.const 4
  call $~lib/rt/__decrease_sp
  local.get $1
  i32.const 1
  i32.add
  local.tee $2
  i32.const 2
  i32.shl
  call $~lib/arraybuffer/ArrayBuffer#constructor
  local.set $4
  global.get $~lib/memory/__stack_pointer
  local.get $4
  i32.store align=1
  local.get $2
  i32.const 3
  i32.shl
  i32.const 3
  i32.div_s
  local.tee $7
  i32.const 3
  i32.shl
  call $~lib/arraybuffer/ArrayBuffer#constructor
  local.set $6
  local.get $0
  i32.load offset=8
  local.tee $3
  local.get $0
  i32.load offset=16
  i32.const 3
  i32.shl
  i32.add
  local.set $8
  local.get $6
  local.set $2
  loop $while-continue|0
   local.get $3
   local.get $8
   i32.ne
   if
    local.get $3
    i32.load offset=4
    i32.const 1
    i32.and
    i32.eqz
    if
     local.get $2
     local.get $3
     i32.load16_u
     local.tee $5
     i32.store16
     local.get $2
     local.get $4
     local.get $5
     call $~lib/util/hash/HASH<u16>
     local.get $1
     i32.and
     i32.const 2
     i32.shl
     i32.add
     local.tee $5
     i32.load
     i32.store offset=4
     local.get $5
     local.get $2
     i32.store
     local.get $2
     i32.const 8
     i32.add
     local.set $2
    end
    local.get $3
    i32.const 8
    i32.add
    local.set $3
    br $while-continue|0
   end
  end
  local.get $0
  local.get $4
  call $~lib/set/Set<i8>#set:buckets
  local.get $0
  local.get $1
  i32.store offset=4
  local.get $0
  local.get $6
  call $~lib/set/Set<i8>#set:entries
  local.get $0
  local.get $7
  i32.store offset=12
  local.get $0
  local.get $0
  i32.load offset=20
  i32.store offset=16
  global.get $~lib/memory/__stack_pointer
  i32.const 4
  i32.add
  global.set $~lib/memory/__stack_pointer
 )
 (func $~lib/set/Set<u16>#add (param $0 i32) (param $1 i32)
  (local $2 i32)
  (local $3 i32)
  local.get $0
  local.get $1
  local.get $1
  call $~lib/util/hash/HASH<u16>
  local.tee $3
  call $~lib/set/Set<i16>#find
  i32.eqz
  if
   local.get $0
   i32.load offset=16
   local.get $0
   i32.load offset=12
   i32.eq
   if
    local.get $0
    local.get $0
    i32.load offset=20
    local.get $0
    i32.load offset=12
    i32.const 3
    i32.mul
    i32.const 4
    i32.div_s
    i32.lt_s
    if (result i32)
     local.get $0
     i32.load offset=4
    else
     local.get $0
     i32.load offset=4
     i32.const 1
     i32.shl
     i32.const 1
     i32.or
    end
    call $~lib/set/Set<u16>#rehash
   end
   local.get $0
   i32.load offset=8
   local.get $0
   local.get $0
   i32.load offset=16
   local.tee $2
   i32.const 1
   i32.add
   i32.store offset=16
   local.get $2
   i32.const 3
   i32.shl
   i32.add
   local.tee $2
   local.get $1
   i32.store16
   local.get $0
   local.get $0
   i32.load offset=20
   i32.const 1
   i32.add
   i32.store offset=20
   local.get $2
   local.get $0
   i32.load
   local.get $3
   local.get $0
   i32.load offset=4
   i32.and
   i32.const 2
   i32.shl
   i32.add
   local.tee $0
   i32.load
   i32.store offset=4
   local.get $0
   local.get $2
   i32.store
  end
 )
 (func $~lib/set/Set<u16>#delete (param $0 i32) (param $1 i32)
  (local $2 i32)
  local.get $0
  local.get $1
  local.get $1
  call $~lib/util/hash/HASH<u16>
  call $~lib/set/Set<i16>#find
  local.tee $1
  if
   local.get $1
   local.get $1
   i32.load offset=4
   i32.const 1
   i32.or
   i32.store offset=4
   local.get $0
   local.get $0
   i32.load offset=20
   i32.const 1
   i32.sub
   i32.store offset=20
   local.get $0
   i32.load offset=4
   i32.const 1
   i32.shr_u
   local.tee $1
   i32.const 1
   i32.add
   i32.const 4
   local.get $0
   i32.load offset=20
   local.tee $2
   local.get $2
   i32.const 4
   i32.lt_u
   select
   i32.ge_u
   if (result i32)
    local.get $0
    i32.load offset=20
    local.get $0
    i32.load offset=12
    i32.const 3
    i32.mul
    i32.const 4
    i32.div_s
    i32.lt_s
   else
    i32.const 0
   end
   if
    local.get $0
    local.get $1
    call $~lib/set/Set<u16>#rehash
   end
  end
 )
 (func $~lib/util/hash/HASH<i32> (param $0 i32) (result i32)
  local.get $0
  i32.const -1028477379
  i32.mul
  i32.const 374761397
  i32.add
  i32.const 17
  i32.rotl
  i32.const 668265263
  i32.mul
  local.tee $0
  i32.const 15
  i32.shr_u
  local.get $0
  i32.xor
  i32.const -2048144777
  i32.mul
  local.tee $0
  i32.const 13
  i32.shr_u
  local.get $0
  i32.xor
  i32.const -1028477379
  i32.mul
  local.tee $0
  i32.const 16
  i32.shr_u
  local.get $0
  i32.xor
 )
 (func $~lib/set/Set<i32>#find (param $0 i32) (param $1 i32) (param $2 i32) (result i32)
  local.get $0
  i32.load
  local.get $2
  local.get $0
  i32.load offset=4
  i32.and
  i32.const 2
  i32.shl
  i32.add
  i32.load
  local.set $0
  loop $while-continue|0
   local.get $0
   if
    local.get $0
    i32.load offset=4
    local.tee $2
    i32.const 1
    i32.and
    if (result i32)
     i32.const 0
    else
     local.get $1
     local.get $0
     i32.load
     i32.eq
    end
    if
     local.get $0
     return
    end
    local.get $2
    i32.const -2
    i32.and
    local.set $0
    br $while-continue|0
   end
  end
  i32.const 0
 )
 (func $~lib/set/Set<i32>#has (param $0 i32) (param $1 i32) (result i32)
  local.get $0
  local.get $1
  local.get $1
  call $~lib/util/hash/HASH<i32>
  call $~lib/set/Set<i32>#find
  i32.const 0
  i32.ne
 )
 (func $~lib/set/Set<i32>#rehash (param $0 i32) (param $1 i32)
  (local $2 i32)
  (local $3 i32)
  (local $4 i32)
  (local $5 i32)
  (local $6 i32)
  (local $7 i32)
  (local $8 i32)
  i32.const 4
  call $~lib/rt/__decrease_sp
  local.get $1
  i32.const 1
  i32.add
  local.tee $2
  i32.const 2
  i32.shl
  call $~lib/arraybuffer/ArrayBuffer#constructor
  local.set $4
  global.get $~lib/memory/__stack_pointer
  local.get $4
  i32.store align=1
  local.get $2
  i32.const 3
  i32.shl
  i32.const 3
  i32.div_s
  local.tee $7
  i32.const 3
  i32.shl
  call $~lib/arraybuffer/ArrayBuffer#constructor
  local.set $6
  local.get $0
  i32.load offset=8
  local.tee $3
  local.get $0
  i32.load offset=16
  i32.const 3
  i32.shl
  i32.add
  local.set $8
  local.get $6
  local.set $2
  loop $while-continue|0
   local.get $3
   local.get $8
   i32.ne
   if
    local.get $3
    i32.load offset=4
    i32.const 1
    i32.and
    i32.eqz
    if
     local.get $2
     local.get $3
     i32.load
     local.tee $5
     i32.store
     local.get $2
     local.get $4
     local.get $5
     call $~lib/util/hash/HASH<i32>
     local.get $1
     i32.and
     i32.const 2
     i32.shl
     i32.add
     local.tee $5
     i32.load
     i32.store offset=4
     local.get $5
     local.get $2
     i32.store
     local.get $2
     i32.const 8
     i32.add
     local.set $2
    end
    local.get $3
    i32.const 8
    i32.add
    local.set $3
    br $while-continue|0
   end
  end
  local.get $0
  local.get $4
  call $~lib/set/Set<i8>#set:buckets
  local.get $0
  local.get $1
  i32.store offset=4
  local.get $0
  local.get $6
  call $~lib/set/Set<i8>#set:entries
  local.get $0
  local.get $7
  i32.store offset=12
  local.get $0
  local.get $0
  i32.load offset=20
  i32.store offset=16
  global.get $~lib/memory/__stack_pointer
  i32.const 4
  i32.add
  global.set $~lib/memory/__stack_pointer
 )
 (func $~lib/set/Set<i32>#add (param $0 i32) (param $1 i32)
  (local $2 i32)
  (local $3 i32)
  local.get $0
  local.get $1
  local.get $1
  call $~lib/util/hash/HASH<i32>
  local.tee $3
  call $~lib/set/Set<i32>#find
  i32.eqz
  if
   local.get $0
   i32.load offset=16
   local.get $0
   i32.load offset=12
   i32.eq
   if
    local.get $0
    local.get $0
    i32.load offset=20
    local.get $0
    i32.load offset=12
    i32.const 3
    i32.mul
    i32.const 4
    i32.div_s
    i32.lt_s
    if (result i32)
     local.get $0
     i32.load offset=4
    else
     local.get $0
     i32.load offset=4
     i32.const 1
     i32.shl
     i32.const 1
     i32.or
    end
    call $~lib/set/Set<i32>#rehash
   end
   local.get $0
   i32.load offset=8
   local.get $0
   local.get $0
   i32.load offset=16
   local.tee $2
   i32.const 1
   i32.add
   i32.store offset=16
   local.get $2
   i32.const 3
   i32.shl
   i32.add
   local.tee $2
   local.get $1
   i32.store
   local.get $0
   local.get $0
   i32.load offset=20
   i32.const 1
   i32.add
   i32.store offset=20
   local.get $2
   local.get $0
   i32.load
   local.get $3
   local.get $0
   i32.load offset=4
   i32.and
   i32.const 2
   i32.shl
   i32.add
   local.tee $0
   i32.load
   i32.store offset=4
   local.get $0
   local.get $2
   i32.store
  end
 )
 (func $~lib/array/Array<i32>#__set (param $0 i32) (param $1 i32) (param $2 i32)
  (local $3 i32)
  local.get $1
  local.get $0
  i32.load offset=12
  i32.ge_u
  if
   local.get $1
   i32.const 0
   i32.lt_s
   if
    i32.const 224
    i32.const 592
    i32.const 147
    i32.const 22
    call $~lib/builtins/abort
    unreachable
   end
   local.get $0
   local.get $1
   i32.const 1
   i32.add
   local.tee $3
   i32.const 2
   i32.const 1
   call $~lib/array/ensureCapacity
   local.get $0
   local.get $3
   i32.store offset=12
  end
  local.get $0
  i32.load offset=4
  local.get $1
  i32.const 2
  i32.shl
  i32.add
  local.get $2
  i32.store
 )
 (func $~lib/set/Set<i32>#delete (param $0 i32) (param $1 i32)
  (local $2 i32)
  local.get $0
  local.get $1
  local.get $1
  call $~lib/util/hash/HASH<i32>
  call $~lib/set/Set<i32>#find
  local.tee $1
  if
   local.get $1
   local.get $1
   i32.load offset=4
   i32.const 1
   i32.or
   i32.store offset=4
   local.get $0
   local.get $0
   i32.load offset=20
   i32.const 1
   i32.sub
   i32.store offset=20
   local.get $0
   i32.load offset=4
   i32.const 1
   i32.shr_u
   local.tee $1
   i32.const 1
   i32.add
   i32.const 4
   local.get $0
   i32.load offset=20
   local.tee $2
   local.get $2
   i32.const 4
   i32.lt_u
   select
   i32.ge_u
   if (result i32)
    local.get $0
    i32.load offset=20
    local.get $0
    i32.load offset=12
    i32.const 3
    i32.mul
    i32.const 4
    i32.div_s
    i32.lt_s
   else
    i32.const 0
   end
   if
    local.get $0
    local.get $1
    call $~lib/set/Set<i32>#rehash
   end
  end
 )
 (func $~lib/set/Set<u32>#find (param $0 i32) (param $1 i32) (param $2 i32) (result i32)
  local.get $0
  i32.load
  local.get $2
  local.get $0
  i32.load offset=4
  i32.and
  i32.const 2
  i32.shl
  i32.add
  i32.load
  local.set $0
  loop $while-continue|0
   local.get $0
   if
    local.get $0
    i32.load offset=4
    local.tee $2
    i32.const 1
    i32.and
    if (result i32)
     i32.const 0
    else
     local.get $1
     local.get $0
     i32.load
     i32.eq
    end
    if
     local.get $0
     return
    end
    local.get $2
    i32.const -2
    i32.and
    local.set $0
    br $while-continue|0
   end
  end
  i32.const 0
 )
 (func $~lib/set/Set<u32>#has (param $0 i32) (param $1 i32) (result i32)
  local.get $0
  local.get $1
  local.get $1
  call $~lib/util/hash/HASH<i32>
  call $~lib/set/Set<u32>#find
  i32.const 0
  i32.ne
 )
 (func $~lib/set/Set<u32>#rehash (param $0 i32) (param $1 i32)
  (local $2 i32)
  (local $3 i32)
  (local $4 i32)
  (local $5 i32)
  (local $6 i32)
  (local $7 i32)
  (local $8 i32)
  i32.const 4
  call $~lib/rt/__decrease_sp
  local.get $1
  i32.const 1
  i32.add
  local.tee $2
  i32.const 2
  i32.shl
  call $~lib/arraybuffer/ArrayBuffer#constructor
  local.set $4
  global.get $~lib/memory/__stack_pointer
  local.get $4
  i32.store align=1
  local.get $2
  i32.const 3
  i32.shl
  i32.const 3
  i32.div_s
  local.tee $7
  i32.const 3
  i32.shl
  call $~lib/arraybuffer/ArrayBuffer#constructor
  local.set $6
  local.get $0
  i32.load offset=8
  local.tee $3
  local.get $0
  i32.load offset=16
  i32.const 3
  i32.shl
  i32.add
  local.set $8
  local.get $6
  local.set $2
  loop $while-continue|0
   local.get $3
   local.get $8
   i32.ne
   if
    local.get $3
    i32.load offset=4
    i32.const 1
    i32.and
    i32.eqz
    if
     local.get $2
     local.get $3
     i32.load
     local.tee $5
     i32.store
     local.get $2
     local.get $4
     local.get $5
     call $~lib/util/hash/HASH<i32>
     local.get $1
     i32.and
     i32.const 2
     i32.shl
     i32.add
     local.tee $5
     i32.load
     i32.store offset=4
     local.get $5
     local.get $2
     i32.store
     local.get $2
     i32.const 8
     i32.add
     local.set $2
    end
    local.get $3
    i32.const 8
    i32.add
    local.set $3
    br $while-continue|0
   end
  end
  local.get $0
  local.get $4
  call $~lib/set/Set<i8>#set:buckets
  local.get $0
  local.get $1
  i32.store offset=4
  local.get $0
  local.get $6
  call $~lib/set/Set<i8>#set:entries
  local.get $0
  local.get $7
  i32.store offset=12
  local.get $0
  local.get $0
  i32.load offset=20
  i32.store offset=16
  global.get $~lib/memory/__stack_pointer
  i32.const 4
  i32.add
  global.set $~lib/memory/__stack_pointer
 )
 (func $~lib/set/Set<u32>#add (param $0 i32) (param $1 i32)
  (local $2 i32)
  (local $3 i32)
  local.get $0
  local.get $1
  local.get $1
  call $~lib/util/hash/HASH<i32>
  local.tee $3
  call $~lib/set/Set<u32>#find
  i32.eqz
  if
   local.get $0
   i32.load offset=16
   local.get $0
   i32.load offset=12
   i32.eq
   if
    local.get $0
    local.get $0
    i32.load offset=20
    local.get $0
    i32.load offset=12
    i32.const 3
    i32.mul
    i32.const 4
    i32.div_s
    i32.lt_s
    if (result i32)
     local.get $0
     i32.load offset=4
    else
     local.get $0
     i32.load offset=4
     i32.const 1
     i32.shl
     i32.const 1
     i32.or
    end
    call $~lib/set/Set<u32>#rehash
   end
   local.get $0
   i32.load offset=8
   local.get $0
   local.get $0
   i32.load offset=16
   local.tee $2
   i32.const 1
   i32.add
   i32.store offset=16
   local.get $2
   i32.const 3
   i32.shl
   i32.add
   local.tee $2
   local.get $1
   i32.store
   local.get $0
   local.get $0
   i32.load offset=20
   i32.const 1
   i32.add
   i32.store offset=20
   local.get $2
   local.get $0
   i32.load
   local.get $3
   local.get $0
   i32.load offset=4
   i32.and
   i32.const 2
   i32.shl
   i32.add
   local.tee $0
   i32.load
   i32.store offset=4
   local.get $0
   local.get $2
   i32.store
  end
 )
 (func $~lib/set/Set<u32>#delete (param $0 i32) (param $1 i32)
  (local $2 i32)
  local.get $0
  local.get $1
  local.get $1
  call $~lib/util/hash/HASH<i32>
  call $~lib/set/Set<u32>#find
  local.tee $1
  if
   local.get $1
   local.get $1
   i32.load offset=4
   i32.const 1
   i32.or
   i32.store offset=4
   local.get $0
   local.get $0
   i32.load offset=20
   i32.const 1
   i32.sub
   i32.store offset=20
   local.get $0
   i32.load offset=4
   i32.const 1
   i32.shr_u
   local.tee $1
   i32.const 1
   i32.add
   i32.const 4
   local.get $0
   i32.load offset=20
   local.tee $2
   local.get $2
   i32.const 4
   i32.lt_u
   select
   i32.ge_u
   if (result i32)
    local.get $0
    i32.load offset=20
    local.get $0
    i32.load offset=12
    i32.const 3
    i32.mul
    i32.const 4
    i32.div_s
    i32.lt_s
   else
    i32.const 0
   end
   if
    local.get $0
    local.get $1
    call $~lib/set/Set<u32>#rehash
   end
  end
 )
 (func $~lib/util/hash/HASH<i64> (param $0 i64) (result i32)
  (local $1 i32)
  local.get $0
  i64.const 32
  i64.shr_u
  i32.wrap_i64
  i32.const -1028477379
  i32.mul
  local.get $0
  i32.wrap_i64
  i32.const -1028477379
  i32.mul
  i32.const 374761401
  i32.add
  i32.const 17
  i32.rotl
  i32.const 668265263
  i32.mul
  i32.add
  i32.const 17
  i32.rotl
  i32.const 668265263
  i32.mul
  local.tee $1
  i32.const 15
  i32.shr_u
  local.get $1
  i32.xor
  i32.const -2048144777
  i32.mul
  local.tee $1
  i32.const 13
  i32.shr_u
  local.get $1
  i32.xor
  i32.const -1028477379
  i32.mul
  local.tee $1
  i32.const 16
  i32.shr_u
  local.get $1
  i32.xor
 )
 (func $~lib/set/Set<i64>#find (param $0 i32) (param $1 i64) (param $2 i32) (result i32)
  local.get $0
  i32.load
  local.get $2
  local.get $0
  i32.load offset=4
  i32.and
  i32.const 2
  i32.shl
  i32.add
  i32.load
  local.set $0
  loop $while-continue|0
   local.get $0
   if
    local.get $0
    i32.load offset=8
    local.tee $2
    i32.const 1
    i32.and
    if (result i32)
     i32.const 0
    else
     local.get $1
     local.get $0
     i64.load
     i64.eq
    end
    if
     local.get $0
     return
    end
    local.get $2
    i32.const -2
    i32.and
    local.set $0
    br $while-continue|0
   end
  end
  i32.const 0
 )
 (func $~lib/set/Set<i64>#has (param $0 i32) (param $1 i64) (result i32)
  local.get $0
  local.get $1
  local.get $1
  call $~lib/util/hash/HASH<i64>
  call $~lib/set/Set<i64>#find
  i32.const 0
  i32.ne
 )
 (func $~lib/set/Set<i64>#rehash (param $0 i32) (param $1 i32)
  (local $2 i32)
  (local $3 i32)
  (local $4 i32)
  (local $5 i32)
  (local $6 i32)
  (local $7 i32)
  (local $8 i64)
  (local $9 i32)
  i32.const 4
  call $~lib/rt/__decrease_sp
  local.get $1
  i32.const 1
  i32.add
  local.tee $2
  i32.const 2
  i32.shl
  call $~lib/arraybuffer/ArrayBuffer#constructor
  local.set $4
  global.get $~lib/memory/__stack_pointer
  local.get $4
  i32.store align=1
  local.get $2
  i32.const 3
  i32.shl
  i32.const 3
  i32.div_s
  local.tee $6
  i32.const 4
  i32.shl
  call $~lib/arraybuffer/ArrayBuffer#constructor
  local.set $5
  local.get $0
  i32.load offset=8
  local.tee $3
  local.get $0
  i32.load offset=16
  i32.const 4
  i32.shl
  i32.add
  local.set $7
  local.get $5
  local.set $2
  loop $while-continue|0
   local.get $3
   local.get $7
   i32.ne
   if
    local.get $3
    i32.load offset=8
    i32.const 1
    i32.and
    i32.eqz
    if
     local.get $2
     local.get $3
     i64.load
     local.tee $8
     i64.store
     local.get $2
     local.get $4
     local.get $8
     call $~lib/util/hash/HASH<i64>
     local.get $1
     i32.and
     i32.const 2
     i32.shl
     i32.add
     local.tee $9
     i32.load
     i32.store offset=8
     local.get $9
     local.get $2
     i32.store
     local.get $2
     i32.const 16
     i32.add
     local.set $2
    end
    local.get $3
    i32.const 16
    i32.add
    local.set $3
    br $while-continue|0
   end
  end
  local.get $0
  local.get $4
  call $~lib/set/Set<i8>#set:buckets
  local.get $0
  local.get $1
  i32.store offset=4
  local.get $0
  local.get $5
  call $~lib/set/Set<i8>#set:entries
  local.get $0
  local.get $6
  i32.store offset=12
  local.get $0
  local.get $0
  i32.load offset=20
  i32.store offset=16
  global.get $~lib/memory/__stack_pointer
  i32.const 4
  i32.add
  global.set $~lib/memory/__stack_pointer
 )
 (func $~lib/set/Set<i64>#add (param $0 i32) (param $1 i64)
  (local $2 i32)
  (local $3 i32)
  local.get $0
  local.get $1
  local.get $1
  call $~lib/util/hash/HASH<i64>
  local.tee $3
  call $~lib/set/Set<i64>#find
  i32.eqz
  if
   local.get $0
   i32.load offset=16
   local.get $0
   i32.load offset=12
   i32.eq
   if
    local.get $0
    local.get $0
    i32.load offset=20
    local.get $0
    i32.load offset=12
    i32.const 3
    i32.mul
    i32.const 4
    i32.div_s
    i32.lt_s
    if (result i32)
     local.get $0
     i32.load offset=4
    else
     local.get $0
     i32.load offset=4
     i32.const 1
     i32.shl
     i32.const 1
     i32.or
    end
    call $~lib/set/Set<i64>#rehash
   end
   local.get $0
   i32.load offset=8
   local.get $0
   local.get $0
   i32.load offset=16
   local.tee $2
   i32.const 1
   i32.add
   i32.store offset=16
   local.get $2
   i32.const 4
   i32.shl
   i32.add
   local.tee $2
   local.get $1
   i64.store
   local.get $0
   local.get $0
   i32.load offset=20
   i32.const 1
   i32.add
   i32.store offset=20
   local.get $2
   local.get $0
   i32.load
   local.get $3
   local.get $0
   i32.load offset=4
   i32.and
   i32.const 2
   i32.shl
   i32.add
   local.tee $0
   i32.load
   i32.store offset=8
   local.get $0
   local.get $2
   i32.store
  end
 )
 (func $~lib/array/Array<i64>#__set (param $0 i32) (param $1 i32) (param $2 i64)
  (local $3 i32)
  local.get $1
  local.get $0
  i32.load offset=12
  i32.ge_u
  if
   local.get $1
   i32.const 0
   i32.lt_s
   if
    i32.const 224
    i32.const 592
    i32.const 147
    i32.const 22
    call $~lib/builtins/abort
    unreachable
   end
   local.get $0
   local.get $1
   i32.const 1
   i32.add
   local.tee $3
   i32.const 3
   i32.const 1
   call $~lib/array/ensureCapacity
   local.get $0
   local.get $3
   i32.store offset=12
  end
  local.get $0
  i32.load offset=4
  local.get $1
  i32.const 3
  i32.shl
  i32.add
  local.get $2
  i64.store
 )
 (func $~lib/set/Set<i64>#delete (param $0 i32) (param $1 i64)
  (local $2 i32)
  (local $3 i32)
  local.get $0
  local.get $1
  local.get $1
  call $~lib/util/hash/HASH<i64>
  call $~lib/set/Set<i64>#find
  local.tee $2
  if
   local.get $2
   local.get $2
   i32.load offset=8
   i32.const 1
   i32.or
   i32.store offset=8
   local.get $0
   local.get $0
   i32.load offset=20
   i32.const 1
   i32.sub
   i32.store offset=20
   local.get $0
   i32.load offset=4
   i32.const 1
   i32.shr_u
   local.tee $2
   i32.const 1
   i32.add
   i32.const 4
   local.get $0
   i32.load offset=20
   local.tee $3
   local.get $3
   i32.const 4
   i32.lt_u
   select
   i32.ge_u
   if (result i32)
    local.get $0
    i32.load offset=20
    local.get $0
    i32.load offset=12
    i32.const 3
    i32.mul
    i32.const 4
    i32.div_s
    i32.lt_s
   else
    i32.const 0
   end
   if
    local.get $0
    local.get $2
    call $~lib/set/Set<i64>#rehash
   end
  end
 )
 (func $~lib/set/Set<u64>#find (param $0 i32) (param $1 i64) (param $2 i32) (result i32)
  local.get $0
  i32.load
  local.get $2
  local.get $0
  i32.load offset=4
  i32.and
  i32.const 2
  i32.shl
  i32.add
  i32.load
  local.set $0
  loop $while-continue|0
   local.get $0
   if
    local.get $0
    i32.load offset=8
    local.tee $2
    i32.const 1
    i32.and
    if (result i32)
     i32.const 0
    else
     local.get $1
     local.get $0
     i64.load
     i64.eq
    end
    if
     local.get $0
     return
    end
    local.get $2
    i32.const -2
    i32.and
    local.set $0
    br $while-continue|0
   end
  end
  i32.const 0
 )
 (func $~lib/set/Set<u64>#has (param $0 i32) (param $1 i64) (result i32)
  local.get $0
  local.get $1
  local.get $1
  call $~lib/util/hash/HASH<i64>
  call $~lib/set/Set<u64>#find
  i32.const 0
  i32.ne
 )
 (func $~lib/set/Set<u64>#rehash (param $0 i32) (param $1 i32)
  (local $2 i32)
  (local $3 i32)
  (local $4 i32)
  (local $5 i32)
  (local $6 i32)
  (local $7 i32)
  (local $8 i64)
  (local $9 i32)
  i32.const 4
  call $~lib/rt/__decrease_sp
  local.get $1
  i32.const 1
  i32.add
  local.tee $2
  i32.const 2
  i32.shl
  call $~lib/arraybuffer/ArrayBuffer#constructor
  local.set $4
  global.get $~lib/memory/__stack_pointer
  local.get $4
  i32.store align=1
  local.get $2
  i32.const 3
  i32.shl
  i32.const 3
  i32.div_s
  local.tee $6
  i32.const 4
  i32.shl
  call $~lib/arraybuffer/ArrayBuffer#constructor
  local.set $5
  local.get $0
  i32.load offset=8
  local.tee $3
  local.get $0
  i32.load offset=16
  i32.const 4
  i32.shl
  i32.add
  local.set $7
  local.get $5
  local.set $2
  loop $while-continue|0
   local.get $3
   local.get $7
   i32.ne
   if
    local.get $3
    i32.load offset=8
    i32.const 1
    i32.and
    i32.eqz
    if
     local.get $2
     local.get $3
     i64.load
     local.tee $8
     i64.store
     local.get $2
     local.get $4
     local.get $8
     call $~lib/util/hash/HASH<i64>
     local.get $1
     i32.and
     i32.const 2
     i32.shl
     i32.add
     local.tee $9
     i32.load
     i32.store offset=8
     local.get $9
     local.get $2
     i32.store
     local.get $2
     i32.const 16
     i32.add
     local.set $2
    end
    local.get $3
    i32.const 16
    i32.add
    local.set $3
    br $while-continue|0
   end
  end
  local.get $0
  local.get $4
  call $~lib/set/Set<i8>#set:buckets
  local.get $0
  local.get $1
  i32.store offset=4
  local.get $0
  local.get $5
  call $~lib/set/Set<i8>#set:entries
  local.get $0
  local.get $6
  i32.store offset=12
  local.get $0
  local.get $0
  i32.load offset=20
  i32.store offset=16
  global.get $~lib/memory/__stack_pointer
  i32.const 4
  i32.add
  global.set $~lib/memory/__stack_pointer
 )
 (func $~lib/set/Set<u64>#add (param $0 i32) (param $1 i64)
  (local $2 i32)
  (local $3 i32)
  local.get $0
  local.get $1
  local.get $1
  call $~lib/util/hash/HASH<i64>
  local.tee $3
  call $~lib/set/Set<u64>#find
  i32.eqz
  if
   local.get $0
   i32.load offset=16
   local.get $0
   i32.load offset=12
   i32.eq
   if
    local.get $0
    local.get $0
    i32.load offset=20
    local.get $0
    i32.load offset=12
    i32.const 3
    i32.mul
    i32.const 4
    i32.div_s
    i32.lt_s
    if (result i32)
     local.get $0
     i32.load offset=4
    else
     local.get $0
     i32.load offset=4
     i32.const 1
     i32.shl
     i32.const 1
     i32.or
    end
    call $~lib/set/Set<u64>#rehash
   end
   local.get $0
   i32.load offset=8
   local.get $0
   local.get $0
   i32.load offset=16
   local.tee $2
   i32.const 1
   i32.add
   i32.store offset=16
   local.get $2
   i32.const 4
   i32.shl
   i32.add
   local.tee $2
   local.get $1
   i64.store
   local.get $0
   local.get $0
   i32.load offset=20
   i32.const 1
   i32.add
   i32.store offset=20
   local.get $2
   local.get $0
   i32.load
   local.get $3
   local.get $0
   i32.load offset=4
   i32.and
   i32.const 2
   i32.shl
   i32.add
   local.tee $0
   i32.load
   i32.store offset=8
   local.get $0
   local.get $2
   i32.store
  end
 )
 (func $~lib/set/Set<u64>#delete (param $0 i32) (param $1 i64)
  (local $2 i32)
  (local $3 i32)
  local.get $0
  local.get $1
  local.get $1
  call $~lib/util/hash/HASH<i64>
  call $~lib/set/Set<u64>#find
  local.tee $2
  if
   local.get $2
   local.get $2
   i32.load offset=8
   i32.const 1
   i32.or
   i32.store offset=8
   local.get $0
   local.get $0
   i32.load offset=20
   i32.const 1
   i32.sub
   i32.store offset=20
   local.get $0
   i32.load offset=4
   i32.const 1
   i32.shr_u
   local.tee $2
   i32.const 1
   i32.add
   i32.const 4
   local.get $0
   i32.load offset=20
   local.tee $3
   local.get $3
   i32.const 4
   i32.lt_u
   select
   i32.ge_u
   if (result i32)
    local.get $0
    i32.load offset=20
    local.get $0
    i32.load offset=12
    i32.const 3
    i32.mul
    i32.const 4
    i32.div_s
    i32.lt_s
   else
    i32.const 0
   end
   if
    local.get $0
    local.get $2
    call $~lib/set/Set<u64>#rehash
   end
  end
 )
 (func $~lib/set/Set<f32>#find (param $0 i32) (param $1 f32) (param $2 i32) (result i32)
  local.get $0
  i32.load
  local.get $2
  local.get $0
  i32.load offset=4
  i32.and
  i32.const 2
  i32.shl
  i32.add
  i32.load
  local.set $0
  loop $while-continue|0
   local.get $0
   if
    local.get $0
    i32.load offset=4
    local.tee $2
    i32.const 1
    i32.and
    if (result i32)
     i32.const 0
    else
     local.get $1
     local.get $0
     f32.load
     f32.eq
    end
    if
     local.get $0
     return
    end
    local.get $2
    i32.const -2
    i32.and
    local.set $0
    br $while-continue|0
   end
  end
  i32.const 0
 )
 (func $~lib/set/Set<f32>#has (param $0 i32) (param $1 f32) (result i32)
  local.get $0
  local.get $1
  local.get $1
  i32.reinterpret_f32
  i32.const -1028477379
  i32.mul
  i32.const 374761397
  i32.add
  i32.const 17
  i32.rotl
  i32.const 668265263
  i32.mul
  local.tee $0
  i32.const 15
  i32.shr_u
  local.get $0
  i32.xor
  i32.const -2048144777
  i32.mul
  local.tee $0
  i32.const 13
  i32.shr_u
  local.get $0
  i32.xor
  i32.const -1028477379
  i32.mul
  local.tee $0
  i32.const 16
  i32.shr_u
  local.get $0
  i32.xor
  call $~lib/set/Set<f32>#find
  i32.const 0
  i32.ne
 )
 (func $~lib/set/Set<f32>#rehash (param $0 i32) (param $1 i32)
  (local $2 i32)
  (local $3 i32)
  (local $4 i32)
  (local $5 i32)
  (local $6 i32)
  (local $7 i32)
  (local $8 i32)
  (local $9 f32)
  i32.const 4
  call $~lib/rt/__decrease_sp
  local.get $1
  i32.const 1
  i32.add
  local.tee $2
  i32.const 2
  i32.shl
  call $~lib/arraybuffer/ArrayBuffer#constructor
  local.set $5
  global.get $~lib/memory/__stack_pointer
  local.get $5
  i32.store align=1
  local.get $2
  i32.const 3
  i32.shl
  i32.const 3
  i32.div_s
  local.tee $7
  i32.const 3
  i32.shl
  call $~lib/arraybuffer/ArrayBuffer#constructor
  local.set $6
  local.get $0
  i32.load offset=8
  local.tee $4
  local.get $0
  i32.load offset=16
  i32.const 3
  i32.shl
  i32.add
  local.set $8
  local.get $6
  local.set $2
  loop $while-continue|0
   local.get $4
   local.get $8
   i32.ne
   if
    local.get $4
    i32.load offset=4
    i32.const 1
    i32.and
    i32.eqz
    if
     local.get $2
     local.get $4
     f32.load
     local.tee $9
     f32.store
     local.get $2
     local.get $5
     local.get $1
     local.get $9
     i32.reinterpret_f32
     i32.const -1028477379
     i32.mul
     i32.const 374761397
     i32.add
     i32.const 17
     i32.rotl
     i32.const 668265263
     i32.mul
     local.tee $3
     i32.const 15
     i32.shr_u
     local.get $3
     i32.xor
     i32.const -2048144777
     i32.mul
     local.tee $3
     i32.const 13
     i32.shr_u
     local.get $3
     i32.xor
     i32.const -1028477379
     i32.mul
     local.tee $3
     i32.const 16
     i32.shr_u
     local.get $3
     i32.xor
     i32.and
     i32.const 2
     i32.shl
     i32.add
     local.tee $3
     i32.load
     i32.store offset=4
     local.get $3
     local.get $2
     i32.store
     local.get $2
     i32.const 8
     i32.add
     local.set $2
    end
    local.get $4
    i32.const 8
    i32.add
    local.set $4
    br $while-continue|0
   end
  end
  local.get $0
  local.get $5
  call $~lib/set/Set<i8>#set:buckets
  local.get $0
  local.get $1
  i32.store offset=4
  local.get $0
  local.get $6
  call $~lib/set/Set<i8>#set:entries
  local.get $0
  local.get $7
  i32.store offset=12
  local.get $0
  local.get $0
  i32.load offset=20
  i32.store offset=16
  global.get $~lib/memory/__stack_pointer
  i32.const 4
  i32.add
  global.set $~lib/memory/__stack_pointer
 )
 (func $~lib/set/Set<f32>#add (param $0 i32) (param $1 f32)
  (local $2 i32)
  (local $3 i32)
  local.get $0
  local.get $1
  local.get $1
  i32.reinterpret_f32
  i32.const -1028477379
  i32.mul
  i32.const 374761397
  i32.add
  i32.const 17
  i32.rotl
  i32.const 668265263
  i32.mul
  local.tee $2
  i32.const 15
  i32.shr_u
  local.get $2
  i32.xor
  i32.const -2048144777
  i32.mul
  local.tee $2
  i32.const 13
  i32.shr_u
  local.get $2
  i32.xor
  i32.const -1028477379
  i32.mul
  local.tee $2
  i32.const 16
  i32.shr_u
  local.get $2
  i32.xor
  local.tee $3
  call $~lib/set/Set<f32>#find
  i32.eqz
  if
   local.get $0
   i32.load offset=16
   local.get $0
   i32.load offset=12
   i32.eq
   if
    local.get $0
    local.get $0
    i32.load offset=20
    local.get $0
    i32.load offset=12
    i32.const 3
    i32.mul
    i32.const 4
    i32.div_s
    i32.lt_s
    if (result i32)
     local.get $0
     i32.load offset=4
    else
     local.get $0
     i32.load offset=4
     i32.const 1
     i32.shl
     i32.const 1
     i32.or
    end
    call $~lib/set/Set<f32>#rehash
   end
   local.get $0
   i32.load offset=8
   local.get $0
   local.get $0
   i32.load offset=16
   local.tee $2
   i32.const 1
   i32.add
   i32.store offset=16
   local.get $2
   i32.const 3
   i32.shl
   i32.add
   local.tee $2
   local.get $1
   f32.store
   local.get $0
   local.get $0
   i32.load offset=20
   i32.const 1
   i32.add
   i32.store offset=20
   local.get $2
   local.get $0
   i32.load
   local.get $3
   local.get $0
   i32.load offset=4
   i32.and
   i32.const 2
   i32.shl
   i32.add
   local.tee $0
   i32.load
   i32.store offset=4
   local.get $0
   local.get $2
   i32.store
  end
 )
 (func $~lib/set/Set<f32>#delete (param $0 i32) (param $1 f32)
  (local $2 i32)
  (local $3 i32)
  local.get $0
  local.get $1
  local.get $1
  i32.reinterpret_f32
  i32.const -1028477379
  i32.mul
  i32.const 374761397
  i32.add
  i32.const 17
  i32.rotl
  i32.const 668265263
  i32.mul
  local.tee $2
  i32.const 15
  i32.shr_u
  local.get $2
  i32.xor
  i32.const -2048144777
  i32.mul
  local.tee $2
  i32.const 13
  i32.shr_u
  local.get $2
  i32.xor
  i32.const -1028477379
  i32.mul
  local.tee $2
  i32.const 16
  i32.shr_u
  local.get $2
  i32.xor
  call $~lib/set/Set<f32>#find
  local.tee $2
  if
   local.get $2
   local.get $2
   i32.load offset=4
   i32.const 1
   i32.or
   i32.store offset=4
   local.get $0
   local.get $0
   i32.load offset=20
   i32.const 1
   i32.sub
   i32.store offset=20
   local.get $0
   i32.load offset=4
   i32.const 1
   i32.shr_u
   local.tee $2
   i32.const 1
   i32.add
   i32.const 4
   local.get $0
   i32.load offset=20
   local.tee $3
   local.get $3
   i32.const 4
   i32.lt_u
   select
   i32.ge_u
   if (result i32)
    local.get $0
    i32.load offset=20
    local.get $0
    i32.load offset=12
    i32.const 3
    i32.mul
    i32.const 4
    i32.div_s
    i32.lt_s
   else
    i32.const 0
   end
   if
    local.get $0
    local.get $2
    call $~lib/set/Set<f32>#rehash
   end
  end
 )
 (func $~lib/util/hash/HASH<f64> (param $0 f64) (result i32)
  (local $1 i32)
  (local $2 i64)
  local.get $0
  i64.reinterpret_f64
  local.tee $2
  i64.const 32
  i64.shr_u
  i32.wrap_i64
  i32.const -1028477379
  i32.mul
  local.get $2
  i32.wrap_i64
  i32.const -1028477379
  i32.mul
  i32.const 374761401
  i32.add
  i32.const 17
  i32.rotl
  i32.const 668265263
  i32.mul
  i32.add
  i32.const 17
  i32.rotl
  i32.const 668265263
  i32.mul
  local.tee $1
  i32.const 15
  i32.shr_u
  local.get $1
  i32.xor
  i32.const -2048144777
  i32.mul
  local.tee $1
  i32.const 13
  i32.shr_u
  local.get $1
  i32.xor
  i32.const -1028477379
  i32.mul
  local.tee $1
  i32.const 16
  i32.shr_u
  local.get $1
  i32.xor
 )
 (func $~lib/set/Set<f64>#find (param $0 i32) (param $1 f64) (param $2 i32) (result i32)
  local.get $0
  i32.load
  local.get $2
  local.get $0
  i32.load offset=4
  i32.and
  i32.const 2
  i32.shl
  i32.add
  i32.load
  local.set $0
  loop $while-continue|0
   local.get $0
   if
    local.get $0
    i32.load offset=8
    local.tee $2
    i32.const 1
    i32.and
    if (result i32)
     i32.const 0
    else
     local.get $1
     local.get $0
     f64.load
     f64.eq
    end
    if
     local.get $0
     return
    end
    local.get $2
    i32.const -2
    i32.and
    local.set $0
    br $while-continue|0
   end
  end
  i32.const 0
 )
 (func $~lib/set/Set<f64>#has (param $0 i32) (param $1 f64) (result i32)
  local.get $0
  local.get $1
  local.get $1
  call $~lib/util/hash/HASH<f64>
  call $~lib/set/Set<f64>#find
  i32.const 0
  i32.ne
 )
 (func $~lib/set/Set<f64>#rehash (param $0 i32) (param $1 i32)
  (local $2 i32)
  (local $3 i32)
  (local $4 i32)
  (local $5 i32)
  (local $6 i32)
  (local $7 i32)
  (local $8 f64)
  (local $9 i32)
  i32.const 4
  call $~lib/rt/__decrease_sp
  local.get $1
  i32.const 1
  i32.add
  local.tee $2
  i32.const 2
  i32.shl
  call $~lib/arraybuffer/ArrayBuffer#constructor
  local.set $4
  global.get $~lib/memory/__stack_pointer
  local.get $4
  i32.store align=1
  local.get $2
  i32.const 3
  i32.shl
  i32.const 3
  i32.div_s
  local.tee $6
  i32.const 4
  i32.shl
  call $~lib/arraybuffer/ArrayBuffer#constructor
  local.set $5
  local.get $0
  i32.load offset=8
  local.tee $3
  local.get $0
  i32.load offset=16
  i32.const 4
  i32.shl
  i32.add
  local.set $7
  local.get $5
  local.set $2
  loop $while-continue|0
   local.get $3
   local.get $7
   i32.ne
   if
    local.get $3
    i32.load offset=8
    i32.const 1
    i32.and
    i32.eqz
    if
     local.get $2
     local.get $3
     f64.load
     local.tee $8
     f64.store
     local.get $2
     local.get $4
     local.get $8
     call $~lib/util/hash/HASH<f64>
     local.get $1
     i32.and
     i32.const 2
     i32.shl
     i32.add
     local.tee $9
     i32.load
     i32.store offset=8
     local.get $9
     local.get $2
     i32.store
     local.get $2
     i32.const 16
     i32.add
     local.set $2
    end
    local.get $3
    i32.const 16
    i32.add
    local.set $3
    br $while-continue|0
   end
  end
  local.get $0
  local.get $4
  call $~lib/set/Set<i8>#set:buckets
  local.get $0
  local.get $1
  i32.store offset=4
  local.get $0
  local.get $5
  call $~lib/set/Set<i8>#set:entries
  local.get $0
  local.get $6
  i32.store offset=12
  local.get $0
  local.get $0
  i32.load offset=20
  i32.store offset=16
  global.get $~lib/memory/__stack_pointer
  i32.const 4
  i32.add
  global.set $~lib/memory/__stack_pointer
 )
 (func $~lib/set/Set<f64>#add (param $0 i32) (param $1 f64)
  (local $2 i32)
  (local $3 i32)
  local.get $0
  local.get $1
  local.get $1
  call $~lib/util/hash/HASH<f64>
  local.tee $3
  call $~lib/set/Set<f64>#find
  i32.eqz
  if
   local.get $0
   i32.load offset=16
   local.get $0
   i32.load offset=12
   i32.eq
   if
    local.get $0
    local.get $0
    i32.load offset=20
    local.get $0
    i32.load offset=12
    i32.const 3
    i32.mul
    i32.const 4
    i32.div_s
    i32.lt_s
    if (result i32)
     local.get $0
     i32.load offset=4
    else
     local.get $0
     i32.load offset=4
     i32.const 1
     i32.shl
     i32.const 1
     i32.or
    end
    call $~lib/set/Set<f64>#rehash
   end
   local.get $0
   i32.load offset=8
   local.get $0
   local.get $0
   i32.load offset=16
   local.tee $2
   i32.const 1
   i32.add
   i32.store offset=16
   local.get $2
   i32.const 4
   i32.shl
   i32.add
   local.tee $2
   local.get $1
   f64.store
   local.get $0
   local.get $0
   i32.load offset=20
   i32.const 1
   i32.add
   i32.store offset=20
   local.get $2
   local.get $0
   i32.load
   local.get $3
   local.get $0
   i32.load offset=4
   i32.and
   i32.const 2
   i32.shl
   i32.add
   local.tee $0
   i32.load
   i32.store offset=8
   local.get $0
   local.get $2
   i32.store
  end
 )
 (func $~lib/set/Set<f64>#delete (param $0 i32) (param $1 f64)
  (local $2 i32)
  (local $3 i32)
  local.get $0
  local.get $1
  local.get $1
  call $~lib/util/hash/HASH<f64>
  call $~lib/set/Set<f64>#find
  local.tee $2
  if
   local.get $2
   local.get $2
   i32.load offset=8
   i32.const 1
   i32.or
   i32.store offset=8
   local.get $0
   local.get $0
   i32.load offset=20
   i32.const 1
   i32.sub
   i32.store offset=20
   local.get $0
   i32.load offset=4
   i32.const 1
   i32.shr_u
   local.tee $2
   i32.const 1
   i32.add
   i32.const 4
   local.get $0
   i32.load offset=20
   local.tee $3
   local.get $3
   i32.const 4
   i32.lt_u
   select
   i32.ge_u
   if (result i32)
    local.get $0
    i32.load offset=20
    local.get $0
    i32.load offset=12
    i32.const 3
    i32.mul
    i32.const 4
    i32.div_s
    i32.lt_s
   else
    i32.const 0
   end
   if
    local.get $0
    local.get $2
    call $~lib/set/Set<f64>#rehash
   end
  end
 )
 (func $~lib/rt/__visit_members (param $0 i32)
  block $folding-inner1
   block $folding-inner0
    block $invalid
     block $~lib/arraybuffer/ArrayBufferView
      block $~lib/string/String
       block $~lib/arraybuffer/ArrayBuffer
        block $~lib/object/Object
         local.get $0
         i32.const 8
         i32.sub
         i32.load
         br_table $~lib/object/Object $~lib/arraybuffer/ArrayBuffer $~lib/string/String $~lib/arraybuffer/ArrayBufferView $folding-inner0 $folding-inner1 $folding-inner0 $folding-inner1 $folding-inner0 $folding-inner1 $folding-inner0 $folding-inner1 $folding-inner0 $folding-inner1 $folding-inner0 $folding-inner1 $folding-inner0 $folding-inner1 $folding-inner0 $folding-inner1 $folding-inner0 $folding-inner1 $folding-inner0 $folding-inner1 $invalid
        end
        return
       end
       return
      end
      return
     end
     local.get $0
     i32.load
     call $~lib/rt/itcms/__visit
     return
    end
    unreachable
   end
   local.get $0
   i32.load
   call $~lib/rt/itcms/__visit
   local.get $0
   i32.load offset=8
   call $~lib/rt/itcms/__visit
   return
  end
  local.get $0
  i32.load
  call $~lib/rt/itcms/__visit
 )
 (func $~start
  (local $0 i32)
  (local $1 i32)
  (local $2 i32)
  (local $3 i32)
  (local $4 i64)
  (local $5 i32)
  (local $6 i32)
  (local $7 f32)
  (local $8 f64)
  (local $9 i32)
  (local $10 i32)
  memory.size
  i32.const 16
  i32.shl
  i32.const 33492
  i32.sub
  i32.const 1
  i32.shr_u
  global.set $~lib/rt/itcms/threshold
  i32.const 148
  i32.const 144
  i32.store
  i32.const 152
  i32.const 144
  i32.store
  i32.const 144
  global.set $~lib/rt/itcms/pinSpace
  i32.const 180
  i32.const 176
  i32.store
  i32.const 184
  i32.const 176
  i32.store
  i32.const 176
  global.set $~lib/rt/itcms/toSpace
  i32.const 324
  i32.const 320
  i32.store
  i32.const 328
  i32.const 320
  i32.store
  i32.const 320
  global.set $~lib/rt/itcms/fromSpace
  i32.const 12
  call $~lib/rt/__decrease_sp
  i32.const 32
  i32.const 4
  call $byn$mgfn-shared$~lib/set/Set<i8>#constructor
  local.set $1
  global.get $~lib/memory/__stack_pointer
  local.get $1
  i32.store offset=8 align=1
  block $folding-inner18
   block $__inlined_func$start:std/set$724
    block $folding-inner17
     block $folding-inner16
      block $folding-inner15
       block $folding-inner14
        block $folding-inner13
         block $folding-inner12
          block $folding-inner11
           block $folding-inner10
            block $folding-inner9
             block $folding-inner8
              block $folding-inner7
               block $folding-inner6
                block $folding-inner5
                 block $folding-inner4
                  block $folding-inner3
                   block $folding-inner2
                    block $folding-inner1
                     block $folding-inner0
                      loop $for-loop|0
                       local.get $0
                       i32.const 100
                       i32.lt_s
                       if
                        local.get $1
                        local.get $0
                        call $~lib/set/Set<i8>#has
                        br_if $folding-inner0
                        local.get $1
                        local.get $0
                        call $~lib/set/Set<i8>#add
                        local.get $1
                        local.get $0
                        call $~lib/set/Set<i8>#has
                        i32.eqz
                        br_if $folding-inner1
                        local.get $0
                        i32.const 1
                        i32.add
                        local.set $0
                        br $for-loop|0
                       end
                      end
                      local.get $1
                      i32.load offset=20
                      i32.const 100
                      i32.ne
                      br_if $folding-inner2
                      i32.const 50
                      local.set $0
                      loop $for-loop|1
                       local.get $0
                       i32.const 100
                       i32.lt_s
                       if
                        local.get $1
                        local.get $0
                        call $~lib/set/Set<i8>#has
                        i32.eqz
                        br_if $folding-inner3
                        local.get $1
                        local.get $0
                        call $~lib/set/Set<i8>#add
                        local.get $1
                        local.get $0
                        call $~lib/set/Set<i8>#has
                        i32.eqz
                        br_if $folding-inner4
                        local.get $0
                        i32.const 1
                        i32.add
                        local.set $0
                        br $for-loop|1
                       end
                      end
                      local.get $1
                      i32.load offset=20
                      i32.const 100
                      i32.ne
                      br_if $folding-inner5
                      i32.const 4
                      call $~lib/rt/__decrease_sp
                      local.get $1
                      i32.load offset=8
                      local.set $9
                      local.get $1
                      i32.load offset=16
                      local.tee $10
                      local.set $0
                      i32.const 4
                      call $~lib/rt/__decrease_sp
                      i32.const 16
                      i32.const 5
                      call $~lib/rt/itcms/__new
                      local.set $2
                      global.get $~lib/memory/__stack_pointer
                      local.get $2
                      i32.store align=1
                      local.get $0
                      i32.const 1073741820
                      i32.gt_u
                      br_if $folding-inner16
                      local.get $2
                      i32.const 8
                      local.get $0
                      local.get $0
                      i32.const 8
                      i32.le_u
                      select
                      local.tee $3
                      i32.const 1
                      call $~lib/rt/itcms/__new
                      local.tee $6
                      call $~lib/set/Set<i8>#set:buckets
                      local.get $2
                      local.get $6
                      i32.store offset=4
                      local.get $2
                      local.get $3
                      i32.store offset=8
                      local.get $2
                      local.get $0
                      i32.store offset=12
                      global.get $~lib/memory/__stack_pointer
                      i32.const 4
                      i32.add
                      global.set $~lib/memory/__stack_pointer
                      global.get $~lib/memory/__stack_pointer
                      local.get $2
                      i32.store align=1
                      i32.const 0
                      local.set $0
                      loop $for-loop|00
                       local.get $5
                       local.get $10
                       i32.lt_s
                       if
                        local.get $9
                        local.get $5
                        i32.const 3
                        i32.shl
                        i32.add
                        local.tee $6
                        i32.load offset=4
                        i32.const 1
                        i32.and
                        i32.eqz
                        if
                         local.get $0
                         local.tee $3
                         i32.const 1
                         i32.add
                         local.set $0
                         local.get $2
                         local.get $3
                         local.get $6
                         i32.load8_s
                         call $~lib/array/Array<i8>#__set
                        end
                        local.get $5
                        i32.const 1
                        i32.add
                        local.set $5
                        br $for-loop|00
                       end
                      end
                      local.get $2
                      local.get $0
                      i32.const 0
                      i32.const 0
                      call $~lib/array/ensureCapacity
                      local.get $2
                      local.get $0
                      i32.store offset=12
                      global.get $~lib/memory/__stack_pointer
                      i32.const 4
                      i32.add
                      global.set $~lib/memory/__stack_pointer
                      global.get $~lib/memory/__stack_pointer
                      local.get $2
                      i32.store offset=4 align=1
                      i32.const 32
                      i32.const 4
                      call $byn$mgfn-shared$~lib/set/Set<i8>#constructor
                      local.set $3
                      global.get $~lib/memory/__stack_pointer
                      local.get $3
                      i32.store align=1
                      i32.const 0
                      local.set $0
                      loop $for-loop|2
                       local.get $0
                       local.get $2
                       i32.load offset=12
                       i32.lt_s
                       if
                        local.get $0
                        local.get $2
                        i32.load offset=12
                        i32.ge_u
                        if
                         br $folding-inner18
                        end
                        local.get $1
                        local.get $0
                        local.get $2
                        i32.load offset=4
                        i32.add
                        i32.load8_s
                        call $~lib/set/Set<i8>#has
                        i32.eqz
                        br_if $folding-inner6
                        local.get $0
                        local.get $2
                        i32.load offset=12
                        i32.ge_u
                        if
                         br $folding-inner18
                        end
                        local.get $3
                        local.get $0
                        local.get $2
                        i32.load offset=4
                        i32.add
                        i32.load8_s
                        call $~lib/set/Set<i8>#add
                        local.get $0
                        i32.const 1
                        i32.add
                        local.set $0
                        br $for-loop|2
                       end
                      end
                      local.get $3
                      i32.load offset=20
                      local.get $1
                      i32.load offset=20
                      i32.ne
                      br_if $folding-inner7
                      i32.const 0
                      local.set $0
                      loop $for-loop|3
                       local.get $0
                       i32.const 50
                       i32.lt_s
                       if
                        local.get $1
                        local.get $0
                        call $~lib/set/Set<i8>#has
                        i32.eqz
                        br_if $folding-inner8
                        local.get $1
                        local.get $0
                        call $~lib/set/Set<i8>#delete
                        local.get $1
                        local.get $0
                        call $~lib/set/Set<i8>#has
                        br_if $folding-inner9
                        local.get $0
                        i32.const 1
                        i32.add
                        local.set $0
                        br $for-loop|3
                       end
                      end
                      local.get $1
                      i32.load offset=20
                      i32.const 50
                      i32.ne
                      br_if $folding-inner10
                      i32.const 0
                      local.set $0
                      loop $for-loop|4
                       local.get $0
                       i32.const 50
                       i32.lt_s
                       if
                        local.get $1
                        local.get $0
                        call $~lib/set/Set<i8>#has
                        br_if $folding-inner11
                        local.get $1
                        local.get $0
                        call $~lib/set/Set<i8>#add
                        local.get $1
                        local.get $0
                        call $~lib/set/Set<i8>#has
                        i32.eqz
                        br_if $folding-inner12
                        local.get $1
                        local.get $0
                        call $~lib/set/Set<i8>#delete
                        local.get $1
                        local.get $0
                        call $~lib/set/Set<i8>#has
                        br_if $folding-inner13
                        local.get $0
                        i32.const 1
                        i32.add
                        local.set $0
                        br $for-loop|4
                       end
                      end
                      local.get $1
                      i32.load offset=20
                      i32.const 50
                      i32.ne
                      br_if $folding-inner14
                      local.get $1
                      i32.const 32
                      call $byn$mgfn-shared$~lib/set/Set<i8>#clear
                      local.get $1
                      i32.load offset=20
                      br_if $folding-inner15
                      global.get $~lib/memory/__stack_pointer
                      i32.const 12
                      i32.add
                      global.set $~lib/memory/__stack_pointer
                      i32.const 0
                      local.set $0
                      i32.const 12
                      call $~lib/rt/__decrease_sp
                      i32.const 32
                      i32.const 6
                      call $byn$mgfn-shared$~lib/set/Set<i8>#constructor
                      local.set $1
                      global.get $~lib/memory/__stack_pointer
                      local.get $1
                      i32.store offset=8 align=1
                      loop $for-loop|001
                       local.get $0
                       i32.const 100
                       i32.lt_u
                       if
                        local.get $1
                        local.get $0
                        call $~lib/set/Set<u8>#has
                        br_if $folding-inner0
                        local.get $1
                        local.get $0
                        call $~lib/set/Set<u8>#add
                        local.get $1
                        local.get $0
                        call $~lib/set/Set<u8>#has
                        i32.eqz
                        br_if $folding-inner1
                        local.get $0
                        i32.const 1
                        i32.add
                        local.set $0
                        br $for-loop|001
                       end
                      end
                      local.get $1
                      i32.load offset=20
                      i32.const 100
                      i32.ne
                      br_if $folding-inner2
                      i32.const 50
                      local.set $0
                      loop $for-loop|11
                       local.get $0
                       i32.const 100
                       i32.lt_u
                       if
                        local.get $1
                        local.get $0
                        call $~lib/set/Set<u8>#has
                        i32.eqz
                        br_if $folding-inner3
                        local.get $1
                        local.get $0
                        call $~lib/set/Set<u8>#add
                        local.get $1
                        local.get $0
                        call $~lib/set/Set<u8>#has
                        i32.eqz
                        br_if $folding-inner4
                        local.get $0
                        i32.const 1
                        i32.add
                        local.set $0
                        br $for-loop|11
                       end
                      end
                      local.get $1
                      i32.load offset=20
                      i32.const 100
                      i32.ne
                      br_if $folding-inner5
                      i32.const 0
                      local.set $5
                      i32.const 4
                      call $~lib/rt/__decrease_sp
                      local.get $1
                      i32.load offset=8
                      local.set $9
                      local.get $1
                      i32.load offset=16
                      local.tee $10
                      local.set $0
                      i32.const 4
                      call $~lib/rt/__decrease_sp
                      i32.const 16
                      i32.const 7
                      call $~lib/rt/itcms/__new
                      local.set $2
                      global.get $~lib/memory/__stack_pointer
                      local.get $2
                      i32.store align=1
                      local.get $0
                      i32.const 1073741820
                      i32.gt_u
                      br_if $folding-inner16
                      local.get $2
                      i32.const 8
                      local.get $0
                      local.get $0
                      i32.const 8
                      i32.le_u
                      select
                      local.tee $3
                      i32.const 1
                      call $~lib/rt/itcms/__new
                      local.tee $6
                      call $~lib/set/Set<i8>#set:buckets
                      local.get $2
                      local.get $6
                      i32.store offset=4
                      local.get $2
                      local.get $3
                      i32.store offset=8
                      local.get $2
                      local.get $0
                      i32.store offset=12
                      global.get $~lib/memory/__stack_pointer
                      i32.const 4
                      i32.add
                      global.set $~lib/memory/__stack_pointer
                      global.get $~lib/memory/__stack_pointer
                      local.get $2
                      i32.store align=1
                      i32.const 0
                      local.set $0
                      loop $for-loop|02
                       local.get $5
                       local.get $10
                       i32.lt_s
                       if
                        local.get $9
                        local.get $5
                        i32.const 3
                        i32.shl
                        i32.add
                        local.tee $6
                        i32.load offset=4
                        i32.const 1
                        i32.and
                        i32.eqz
                        if
                         local.get $0
                         local.tee $3
                         i32.const 1
                         i32.add
                         local.set $0
                         local.get $2
                         local.get $3
                         local.get $6
                         i32.load8_u
                         call $~lib/array/Array<i8>#__set
                        end
                        local.get $5
                        i32.const 1
                        i32.add
                        local.set $5
                        br $for-loop|02
                       end
                      end
                      local.get $2
                      local.get $0
                      i32.const 0
                      i32.const 0
                      call $~lib/array/ensureCapacity
                      local.get $2
                      local.get $0
                      i32.store offset=12
                      global.get $~lib/memory/__stack_pointer
                      i32.const 4
                      i32.add
                      global.set $~lib/memory/__stack_pointer
                      global.get $~lib/memory/__stack_pointer
                      local.get $2
                      i32.store offset=4 align=1
                      i32.const 32
                      i32.const 6
                      call $byn$mgfn-shared$~lib/set/Set<i8>#constructor
                      local.set $3
                      global.get $~lib/memory/__stack_pointer
                      local.get $3
                      i32.store align=1
                      i32.const 0
                      local.set $0
                      loop $for-loop|22
                       local.get $0
                       local.get $2
                       i32.load offset=12
                       i32.lt_s
                       if
                        local.get $0
                        local.get $2
                        i32.load offset=12
                        i32.ge_u
                        if
                         br $folding-inner18
                        end
                        local.get $1
                        local.get $0
                        local.get $2
                        i32.load offset=4
                        i32.add
                        i32.load8_u
                        call $~lib/set/Set<u8>#has
                        i32.eqz
                        br_if $folding-inner6
                        local.get $0
                        local.get $2
                        i32.load offset=12
                        i32.ge_u
                        if
                         br $folding-inner18
                        end
                        local.get $3
                        local.get $0
                        local.get $2
                        i32.load offset=4
                        i32.add
                        i32.load8_u
                        call $~lib/set/Set<u8>#add
                        local.get $0
                        i32.const 1
                        i32.add
                        local.set $0
                        br $for-loop|22
                       end
                      end
                      local.get $3
                      i32.load offset=20
                      local.get $1
                      i32.load offset=20
                      i32.ne
                      br_if $folding-inner7
                      i32.const 0
                      local.set $0
                      loop $for-loop|33
                       local.get $0
                       i32.const 50
                       i32.lt_u
                       if
                        local.get $1
                        local.get $0
                        call $~lib/set/Set<u8>#has
                        i32.eqz
                        br_if $folding-inner8
                        local.get $1
                        local.get $0
                        call $~lib/set/Set<u8>#delete
                        local.get $1
                        local.get $0
                        call $~lib/set/Set<u8>#has
                        br_if $folding-inner9
                        local.get $0
                        i32.const 1
                        i32.add
                        local.set $0
                        br $for-loop|33
                       end
                      end
                      local.get $1
                      i32.load offset=20
                      i32.const 50
                      i32.ne
                      br_if $folding-inner10
                      i32.const 0
                      local.set $0
                      loop $for-loop|44
                       local.get $0
                       i32.const 50
                       i32.lt_u
                       if
                        local.get $1
                        local.get $0
                        call $~lib/set/Set<u8>#has
                        br_if $folding-inner11
                        local.get $1
                        local.get $0
                        call $~lib/set/Set<u8>#add
                        local.get $1
                        local.get $0
                        call $~lib/set/Set<u8>#has
                        i32.eqz
                        br_if $folding-inner12
                        local.get $1
                        local.get $0
                        call $~lib/set/Set<u8>#delete
                        local.get $1
                        local.get $0
                        call $~lib/set/Set<u8>#has
                        br_if $folding-inner13
                        local.get $0
                        i32.const 1
                        i32.add
                        local.set $0
                        br $for-loop|44
                       end
                      end
                      local.get $1
                      i32.load offset=20
                      i32.const 50
                      i32.ne
                      br_if $folding-inner14
                      local.get $1
                      i32.const 32
                      call $byn$mgfn-shared$~lib/set/Set<i8>#clear
                      local.get $1
                      i32.load offset=20
                      br_if $folding-inner15
                      global.get $~lib/memory/__stack_pointer
                      i32.const 12
                      i32.add
                      global.set $~lib/memory/__stack_pointer
                      i32.const 0
                      local.set $0
                      i32.const 12
                      call $~lib/rt/__decrease_sp
                      i32.const 32
                      i32.const 8
                      call $byn$mgfn-shared$~lib/set/Set<i8>#constructor
                      local.set $1
                      global.get $~lib/memory/__stack_pointer
                      local.get $1
                      i32.store offset=8 align=1
                      loop $for-loop|05
                       local.get $0
                       i32.const 100
                       i32.lt_s
                       if
                        local.get $1
                        local.get $0
                        call $~lib/set/Set<i16>#has
                        br_if $folding-inner0
                        local.get $1
                        local.get $0
                        call $~lib/set/Set<i16>#add
                        local.get $1
                        local.get $0
                        call $~lib/set/Set<i16>#has
                        i32.eqz
                        br_if $folding-inner1
                        local.get $0
                        i32.const 1
                        i32.add
                        local.set $0
                        br $for-loop|05
                       end
                      end
                      local.get $1
                      i32.load offset=20
                      i32.const 100
                      i32.ne
                      br_if $folding-inner2
                      i32.const 50
                      local.set $0
                      loop $for-loop|16
                       local.get $0
                       i32.const 100
                       i32.lt_s
                       if
                        local.get $1
                        local.get $0
                        call $~lib/set/Set<i16>#has
                        i32.eqz
                        br_if $folding-inner3
                        local.get $1
                        local.get $0
                        call $~lib/set/Set<i16>#add
                        local.get $1
                        local.get $0
                        call $~lib/set/Set<i16>#has
                        i32.eqz
                        br_if $folding-inner4
                        local.get $0
                        i32.const 1
                        i32.add
                        local.set $0
                        br $for-loop|16
                       end
                      end
                      local.get $1
                      i32.load offset=20
                      i32.const 100
                      i32.ne
                      br_if $folding-inner5
                      i32.const 0
                      local.set $5
                      i32.const 4
                      call $~lib/rt/__decrease_sp
                      local.get $1
                      i32.load offset=8
                      local.set $9
                      local.get $1
                      i32.load offset=16
                      local.tee $10
                      local.set $0
                      i32.const 4
                      call $~lib/rt/__decrease_sp
                      i32.const 16
                      i32.const 9
                      call $~lib/rt/itcms/__new
                      local.set $2
                      global.get $~lib/memory/__stack_pointer
                      local.get $2
                      i32.store align=1
                      local.get $0
                      i32.const 536870910
                      i32.gt_u
                      br_if $folding-inner16
                      local.get $2
                      i32.const 8
                      local.get $0
                      local.get $0
                      i32.const 8
                      i32.le_u
                      select
                      i32.const 1
                      i32.shl
                      local.tee $3
                      i32.const 1
                      call $~lib/rt/itcms/__new
                      local.tee $6
                      call $~lib/set/Set<i8>#set:buckets
                      local.get $2
                      local.get $6
                      i32.store offset=4
                      local.get $2
                      local.get $3
                      i32.store offset=8
                      local.get $2
                      local.get $0
                      i32.store offset=12
                      global.get $~lib/memory/__stack_pointer
                      i32.const 4
                      i32.add
                      global.set $~lib/memory/__stack_pointer
                      global.get $~lib/memory/__stack_pointer
                      local.get $2
                      i32.store align=1
                      i32.const 0
                      local.set $0
                      loop $for-loop|03
                       local.get $5
                       local.get $10
                       i32.lt_s
                       if
                        local.get $9
                        local.get $5
                        i32.const 3
                        i32.shl
                        i32.add
                        local.tee $6
                        i32.load offset=4
                        i32.const 1
                        i32.and
                        i32.eqz
                        if
                         local.get $0
                         local.tee $3
                         i32.const 1
                         i32.add
                         local.set $0
                         local.get $2
                         local.get $3
                         local.get $6
                         i32.load16_s
                         call $~lib/array/Array<i16>#__set
                        end
                        local.get $5
                        i32.const 1
                        i32.add
                        local.set $5
                        br $for-loop|03
                       end
                      end
                      local.get $2
                      local.get $0
                      i32.const 1
                      i32.const 0
                      call $~lib/array/ensureCapacity
                      local.get $2
                      local.get $0
                      i32.store offset=12
                      global.get $~lib/memory/__stack_pointer
                      i32.const 4
                      i32.add
                      global.set $~lib/memory/__stack_pointer
                      global.get $~lib/memory/__stack_pointer
                      local.get $2
                      i32.store offset=4 align=1
                      i32.const 32
                      i32.const 8
                      call $byn$mgfn-shared$~lib/set/Set<i8>#constructor
                      local.set $3
                      global.get $~lib/memory/__stack_pointer
                      local.get $3
                      i32.store align=1
                      i32.const 0
                      local.set $0
                      loop $for-loop|27
                       local.get $0
                       local.get $2
                       i32.load offset=12
                       i32.lt_s
                       if
                        local.get $0
                        local.get $2
                        i32.load offset=12
                        i32.ge_u
                        if
                         br $folding-inner18
                        end
                        local.get $1
                        local.get $2
                        i32.load offset=4
                        local.get $0
                        i32.const 1
                        i32.shl
                        i32.add
                        i32.load16_s
                        call $~lib/set/Set<i16>#has
                        i32.eqz
                        br_if $folding-inner6
                        local.get $0
                        local.get $2
                        i32.load offset=12
                        i32.ge_u
                        if
                         br $folding-inner18
                        end
                        local.get $3
                        local.get $2
                        i32.load offset=4
                        local.get $0
                        i32.const 1
                        i32.shl
                        i32.add
                        i32.load16_s
                        call $~lib/set/Set<i16>#add
                        local.get $0
                        i32.const 1
                        i32.add
                        local.set $0
                        br $for-loop|27
                       end
                      end
                      local.get $3
                      i32.load offset=20
                      local.get $1
                      i32.load offset=20
                      i32.ne
                      br_if $folding-inner7
                      i32.const 0
                      local.set $0
                      loop $for-loop|38
                       local.get $0
                       i32.const 50
                       i32.lt_s
                       if
                        local.get $1
                        local.get $0
                        call $~lib/set/Set<i16>#has
                        i32.eqz
                        br_if $folding-inner8
                        local.get $1
                        local.get $0
                        call $~lib/set/Set<i16>#delete
                        local.get $1
                        local.get $0
                        call $~lib/set/Set<i16>#has
                        br_if $folding-inner9
                        local.get $0
                        i32.const 1
                        i32.add
                        local.set $0
                        br $for-loop|38
                       end
                      end
                      local.get $1
                      i32.load offset=20
                      i32.const 50
                      i32.ne
                      br_if $folding-inner10
                      i32.const 0
                      local.set $0
                      loop $for-loop|49
                       local.get $0
                       i32.const 50
                       i32.lt_s
                       if
                        local.get $1
                        local.get $0
                        call $~lib/set/Set<i16>#has
                        br_if $folding-inner11
                        local.get $1
                        local.get $0
                        call $~lib/set/Set<i16>#add
                        local.get $1
                        local.get $0
                        call $~lib/set/Set<i16>#has
                        i32.eqz
                        br_if $folding-inner12
                        local.get $1
                        local.get $0
                        call $~lib/set/Set<i16>#delete
                        local.get $1
                        local.get $0
                        call $~lib/set/Set<i16>#has
                        br_if $folding-inner13
                        local.get $0
                        i32.const 1
                        i32.add
                        local.set $0
                        br $for-loop|49
                       end
                      end
                      local.get $1
                      i32.load offset=20
                      i32.const 50
                      i32.ne
                      br_if $folding-inner14
                      local.get $1
                      i32.const 32
                      call $byn$mgfn-shared$~lib/set/Set<i8>#clear
                      local.get $1
                      i32.load offset=20
                      br_if $folding-inner15
                      global.get $~lib/memory/__stack_pointer
                      i32.const 12
                      i32.add
                      global.set $~lib/memory/__stack_pointer
                      i32.const 0
                      local.set $0
                      i32.const 12
                      call $~lib/rt/__decrease_sp
                      i32.const 32
                      i32.const 10
                      call $byn$mgfn-shared$~lib/set/Set<i8>#constructor
                      local.set $1
                      global.get $~lib/memory/__stack_pointer
                      local.get $1
                      i32.store offset=8 align=1
                      loop $for-loop|010
                       local.get $0
                       i32.const 100
                       i32.lt_u
                       if
                        local.get $1
                        local.get $0
                        call $~lib/set/Set<u16>#has
                        br_if $folding-inner0
                        local.get $1
                        local.get $0
                        call $~lib/set/Set<u16>#add
                        local.get $1
                        local.get $0
                        call $~lib/set/Set<u16>#has
                        i32.eqz
                        br_if $folding-inner1
                        local.get $0
                        i32.const 1
                        i32.add
                        local.set $0
                        br $for-loop|010
                       end
                      end
                      local.get $1
                      i32.load offset=20
                      i32.const 100
                      i32.ne
                      br_if $folding-inner2
                      i32.const 50
                      local.set $0
                      loop $for-loop|111
                       local.get $0
                       i32.const 100
                       i32.lt_u
                       if
                        local.get $1
                        local.get $0
                        call $~lib/set/Set<u16>#has
                        i32.eqz
                        br_if $folding-inner3
                        local.get $1
                        local.get $0
                        call $~lib/set/Set<u16>#add
                        local.get $1
                        local.get $0
                        call $~lib/set/Set<u16>#has
                        i32.eqz
                        br_if $folding-inner4
                        local.get $0
                        i32.const 1
                        i32.add
                        local.set $0
                        br $for-loop|111
                       end
                      end
                      local.get $1
                      i32.load offset=20
                      i32.const 100
                      i32.ne
                      br_if $folding-inner5
                      i32.const 0
                      local.set $5
                      i32.const 4
                      call $~lib/rt/__decrease_sp
                      local.get $1
                      i32.load offset=8
                      local.set $9
                      local.get $1
                      i32.load offset=16
                      local.tee $10
                      local.set $0
                      i32.const 4
                      call $~lib/rt/__decrease_sp
                      i32.const 16
                      i32.const 11
                      call $~lib/rt/itcms/__new
                      local.set $2
                      global.get $~lib/memory/__stack_pointer
                      local.get $2
                      i32.store align=1
                      local.get $0
                      i32.const 536870910
                      i32.gt_u
                      br_if $folding-inner16
                      local.get $2
                      i32.const 8
                      local.get $0
                      local.get $0
                      i32.const 8
                      i32.le_u
                      select
                      i32.const 1
                      i32.shl
                      local.tee $3
                      i32.const 1
                      call $~lib/rt/itcms/__new
                      local.tee $6
                      call $~lib/set/Set<i8>#set:buckets
                      local.get $2
                      local.get $6
                      i32.store offset=4
                      local.get $2
                      local.get $3
                      i32.store offset=8
                      local.get $2
                      local.get $0
                      i32.store offset=12
                      global.get $~lib/memory/__stack_pointer
                      i32.const 4
                      i32.add
                      global.set $~lib/memory/__stack_pointer
                      global.get $~lib/memory/__stack_pointer
                      local.get $2
                      i32.store align=1
                      i32.const 0
                      local.set $0
                      loop $for-loop|04
                       local.get $5
                       local.get $10
                       i32.lt_s
                       if
                        local.get $9
                        local.get $5
                        i32.const 3
                        i32.shl
                        i32.add
                        local.tee $6
                        i32.load offset=4
                        i32.const 1
                        i32.and
                        i32.eqz
                        if
                         local.get $0
                         local.tee $3
                         i32.const 1
                         i32.add
                         local.set $0
                         local.get $2
                         local.get $3
                         local.get $6
                         i32.load16_u
                         call $~lib/array/Array<i16>#__set
                        end
                        local.get $5
                        i32.const 1
                        i32.add
                        local.set $5
                        br $for-loop|04
                       end
                      end
                      local.get $2
                      local.get $0
                      i32.const 1
                      i32.const 0
                      call $~lib/array/ensureCapacity
                      local.get $2
                      local.get $0
                      i32.store offset=12
                      global.get $~lib/memory/__stack_pointer
                      i32.const 4
                      i32.add
                      global.set $~lib/memory/__stack_pointer
                      global.get $~lib/memory/__stack_pointer
                      local.get $2
                      i32.store offset=4 align=1
                      i32.const 32
                      i32.const 10
                      call $byn$mgfn-shared$~lib/set/Set<i8>#constructor
                      local.set $3
                      global.get $~lib/memory/__stack_pointer
                      local.get $3
                      i32.store align=1
                      i32.const 0
                      local.set $0
                      loop $for-loop|212
                       local.get $0
                       local.get $2
                       i32.load offset=12
                       i32.lt_s
                       if
                        local.get $0
                        local.get $2
                        i32.load offset=12
                        i32.ge_u
                        if
                         br $folding-inner18
                        end
                        local.get $1
                        local.get $2
                        i32.load offset=4
                        local.get $0
                        i32.const 1
                        i32.shl
                        i32.add
                        i32.load16_u
                        call $~lib/set/Set<u16>#has
                        i32.eqz
                        br_if $folding-inner6
                        local.get $0
                        local.get $2
                        i32.load offset=12
                        i32.ge_u
                        if
                         br $folding-inner18
                        end
                        local.get $3
                        local.get $2
                        i32.load offset=4
                        local.get $0
                        i32.const 1
                        i32.shl
                        i32.add
                        i32.load16_u
                        call $~lib/set/Set<u16>#add
                        local.get $0
                        i32.const 1
                        i32.add
                        local.set $0
                        br $for-loop|212
                       end
                      end
                      local.get $3
                      i32.load offset=20
                      local.get $1
                      i32.load offset=20
                      i32.ne
                      br_if $folding-inner7
                      i32.const 0
                      local.set $0
                      loop $for-loop|313
                       local.get $0
                       i32.const 50
                       i32.lt_u
                       if
                        local.get $1
                        local.get $0
                        call $~lib/set/Set<u16>#has
                        i32.eqz
                        br_if $folding-inner8
                        local.get $1
                        local.get $0
                        call $~lib/set/Set<u16>#delete
                        local.get $1
                        local.get $0
                        call $~lib/set/Set<u16>#has
                        br_if $folding-inner9
                        local.get $0
                        i32.const 1
                        i32.add
                        local.set $0
                        br $for-loop|313
                       end
                      end
                      local.get $1
                      i32.load offset=20
                      i32.const 50
                      i32.ne
                      br_if $folding-inner10
                      i32.const 0
                      local.set $0
                      loop $for-loop|414
                       local.get $0
                       i32.const 50
                       i32.lt_u
                       if
                        local.get $1
                        local.get $0
                        call $~lib/set/Set<u16>#has
                        br_if $folding-inner11
                        local.get $1
                        local.get $0
                        call $~lib/set/Set<u16>#add
                        local.get $1
                        local.get $0
                        call $~lib/set/Set<u16>#has
                        i32.eqz
                        br_if $folding-inner12
                        local.get $1
                        local.get $0
                        call $~lib/set/Set<u16>#delete
                        local.get $1
                        local.get $0
                        call $~lib/set/Set<u16>#has
                        br_if $folding-inner13
                        local.get $0
                        i32.const 1
                        i32.add
                        local.set $0
                        br $for-loop|414
                       end
                      end
                      local.get $1
                      i32.load offset=20
                      i32.const 50
                      i32.ne
                      br_if $folding-inner14
                      local.get $1
                      i32.const 32
                      call $byn$mgfn-shared$~lib/set/Set<i8>#clear
                      local.get $1
                      i32.load offset=20
                      br_if $folding-inner15
                      global.get $~lib/memory/__stack_pointer
                      i32.const 12
                      i32.add
                      global.set $~lib/memory/__stack_pointer
                      i32.const 0
                      local.set $0
                      i32.const 12
                      call $~lib/rt/__decrease_sp
                      i32.const 32
                      i32.const 12
                      call $byn$mgfn-shared$~lib/set/Set<i8>#constructor
                      local.set $1
                      global.get $~lib/memory/__stack_pointer
                      local.get $1
                      i32.store offset=8 align=1
                      loop $for-loop|015
                       local.get $0
                       i32.const 100
                       i32.lt_s
                       if
                        local.get $1
                        local.get $0
                        call $~lib/set/Set<i32>#has
                        br_if $folding-inner0
                        local.get $1
                        local.get $0
                        call $~lib/set/Set<i32>#add
                        local.get $1
                        local.get $0
                        call $~lib/set/Set<i32>#has
                        i32.eqz
                        br_if $folding-inner1
                        local.get $0
                        i32.const 1
                        i32.add
                        local.set $0
                        br $for-loop|015
                       end
                      end
                      local.get $1
                      i32.load offset=20
                      i32.const 100
                      i32.ne
                      br_if $folding-inner2
                      i32.const 50
                      local.set $0
                      loop $for-loop|116
                       local.get $0
                       i32.const 100
                       i32.lt_s
                       if
                        local.get $1
                        local.get $0
                        call $~lib/set/Set<i32>#has
                        i32.eqz
                        br_if $folding-inner3
                        local.get $1
                        local.get $0
                        call $~lib/set/Set<i32>#add
                        local.get $1
                        local.get $0
                        call $~lib/set/Set<i32>#has
                        i32.eqz
                        br_if $folding-inner4
                        local.get $0
                        i32.const 1
                        i32.add
                        local.set $0
                        br $for-loop|116
                       end
                      end
                      local.get $1
                      i32.load offset=20
                      i32.const 100
                      i32.ne
                      br_if $folding-inner5
                      i32.const 0
                      local.set $5
                      i32.const 4
                      call $~lib/rt/__decrease_sp
                      local.get $1
                      i32.load offset=8
                      local.set $9
                      local.get $1
                      i32.load offset=16
                      local.tee $10
                      local.set $0
                      i32.const 4
                      call $~lib/rt/__decrease_sp
                      i32.const 16
                      i32.const 13
                      call $~lib/rt/itcms/__new
                      local.set $2
                      global.get $~lib/memory/__stack_pointer
                      local.get $2
                      i32.store align=1
                      local.get $0
                      i32.const 268435455
                      i32.gt_u
                      br_if $folding-inner16
                      local.get $2
                      i32.const 8
                      local.get $0
                      local.get $0
                      i32.const 8
                      i32.le_u
                      select
                      i32.const 2
                      i32.shl
                      local.tee $3
                      i32.const 1
                      call $~lib/rt/itcms/__new
                      local.tee $6
                      call $~lib/set/Set<i8>#set:buckets
                      local.get $2
                      local.get $6
                      i32.store offset=4
                      local.get $2
                      local.get $3
                      i32.store offset=8
                      local.get $2
                      local.get $0
                      i32.store offset=12
                      global.get $~lib/memory/__stack_pointer
                      i32.const 4
                      i32.add
                      global.set $~lib/memory/__stack_pointer
                      global.get $~lib/memory/__stack_pointer
                      local.get $2
                      i32.store align=1
                      i32.const 0
                      local.set $0
                      loop $for-loop|06
                       local.get $5
                       local.get $10
                       i32.lt_s
                       if
                        local.get $9
                        local.get $5
                        i32.const 3
                        i32.shl
                        i32.add
                        local.tee $6
                        i32.load offset=4
                        i32.const 1
                        i32.and
                        i32.eqz
                        if
                         local.get $0
                         local.tee $3
                         i32.const 1
                         i32.add
                         local.set $0
                         local.get $2
                         local.get $3
                         local.get $6
                         i32.load
                         call $~lib/array/Array<i32>#__set
                        end
                        local.get $5
                        i32.const 1
                        i32.add
                        local.set $5
                        br $for-loop|06
                       end
                      end
                      local.get $2
                      local.get $0
                      i32.const 2
                      i32.const 0
                      call $~lib/array/ensureCapacity
                      local.get $2
                      local.get $0
                      i32.store offset=12
                      global.get $~lib/memory/__stack_pointer
                      i32.const 4
                      i32.add
                      global.set $~lib/memory/__stack_pointer
                      global.get $~lib/memory/__stack_pointer
                      local.get $2
                      i32.store offset=4 align=1
                      i32.const 32
                      i32.const 12
                      call $byn$mgfn-shared$~lib/set/Set<i8>#constructor
                      local.set $3
                      global.get $~lib/memory/__stack_pointer
                      local.get $3
                      i32.store align=1
                      i32.const 0
                      local.set $0
                      loop $for-loop|217
                       local.get $0
                       local.get $2
                       i32.load offset=12
                       i32.lt_s
                       if
                        local.get $0
                        local.get $2
                        i32.load offset=12
                        i32.ge_u
                        if
                         br $folding-inner18
                        end
                        local.get $1
                        local.get $2
                        i32.load offset=4
                        local.get $0
                        i32.const 2
                        i32.shl
                        i32.add
                        i32.load
                        call $~lib/set/Set<i32>#has
                        i32.eqz
                        br_if $folding-inner6
                        local.get $0
                        local.get $2
                        i32.load offset=12
                        i32.ge_u
                        if
                         br $folding-inner18
                        end
                        local.get $3
                        local.get $2
                        i32.load offset=4
                        local.get $0
                        i32.const 2
                        i32.shl
                        i32.add
                        i32.load
                        call $~lib/set/Set<i32>#add
                        local.get $0
                        i32.const 1
                        i32.add
                        local.set $0
                        br $for-loop|217
                       end
                      end
                      local.get $3
                      i32.load offset=20
                      local.get $1
                      i32.load offset=20
                      i32.ne
                      br_if $folding-inner7
                      i32.const 0
                      local.set $0
                      loop $for-loop|318
                       local.get $0
                       i32.const 50
                       i32.lt_s
                       if
                        local.get $1
                        local.get $0
                        call $~lib/set/Set<i32>#has
                        i32.eqz
                        br_if $folding-inner8
                        local.get $1
                        local.get $0
                        call $~lib/set/Set<i32>#delete
                        local.get $1
                        local.get $0
                        call $~lib/set/Set<i32>#has
                        br_if $folding-inner9
                        local.get $0
                        i32.const 1
                        i32.add
                        local.set $0
                        br $for-loop|318
                       end
                      end
                      local.get $1
                      i32.load offset=20
                      i32.const 50
                      i32.ne
                      br_if $folding-inner10
                      i32.const 0
                      local.set $0
                      loop $for-loop|419
                       local.get $0
                       i32.const 50
                       i32.lt_s
                       if
                        local.get $1
                        local.get $0
                        call $~lib/set/Set<i32>#has
                        br_if $folding-inner11
                        local.get $1
                        local.get $0
                        call $~lib/set/Set<i32>#add
                        local.get $1
                        local.get $0
                        call $~lib/set/Set<i32>#has
                        i32.eqz
                        br_if $folding-inner12
                        local.get $1
                        local.get $0
                        call $~lib/set/Set<i32>#delete
                        local.get $1
                        local.get $0
                        call $~lib/set/Set<i32>#has
                        br_if $folding-inner13
                        local.get $0
                        i32.const 1
                        i32.add
                        local.set $0
                        br $for-loop|419
                       end
                      end
                      local.get $1
                      i32.load offset=20
                      i32.const 50
                      i32.ne
                      br_if $folding-inner14
                      local.get $1
                      i32.const 32
                      call $byn$mgfn-shared$~lib/set/Set<i8>#clear
                      local.get $1
                      i32.load offset=20
                      br_if $folding-inner15
                      global.get $~lib/memory/__stack_pointer
                      i32.const 12
                      i32.add
                      global.set $~lib/memory/__stack_pointer
                      i32.const 0
                      local.set $0
                      i32.const 12
                      call $~lib/rt/__decrease_sp
                      i32.const 32
                      i32.const 14
                      call $byn$mgfn-shared$~lib/set/Set<i8>#constructor
                      local.set $1
                      global.get $~lib/memory/__stack_pointer
                      local.get $1
                      i32.store offset=8 align=1
                      loop $for-loop|020
                       local.get $0
                       i32.const 100
                       i32.lt_u
                       if
                        local.get $1
                        local.get $0
                        call $~lib/set/Set<u32>#has
                        br_if $folding-inner0
                        local.get $1
                        local.get $0
                        call $~lib/set/Set<u32>#add
                        local.get $1
                        local.get $0
                        call $~lib/set/Set<u32>#has
                        i32.eqz
                        br_if $folding-inner1
                        local.get $0
                        i32.const 1
                        i32.add
                        local.set $0
                        br $for-loop|020
                       end
                      end
                      local.get $1
                      i32.load offset=20
                      i32.const 100
                      i32.ne
                      br_if $folding-inner2
                      i32.const 50
                      local.set $0
                      loop $for-loop|121
                       local.get $0
                       i32.const 100
                       i32.lt_u
                       if
                        local.get $1
                        local.get $0
                        call $~lib/set/Set<u32>#has
                        i32.eqz
                        br_if $folding-inner3
                        local.get $1
                        local.get $0
                        call $~lib/set/Set<u32>#add
                        local.get $1
                        local.get $0
                        call $~lib/set/Set<u32>#has
                        i32.eqz
                        br_if $folding-inner4
                        local.get $0
                        i32.const 1
                        i32.add
                        local.set $0
                        br $for-loop|121
                       end
                      end
                      local.get $1
                      i32.load offset=20
                      i32.const 100
                      i32.ne
                      br_if $folding-inner5
                      i32.const 0
                      local.set $5
                      i32.const 4
                      call $~lib/rt/__decrease_sp
                      local.get $1
                      i32.load offset=8
                      local.set $9
                      local.get $1
                      i32.load offset=16
                      local.tee $10
                      local.set $0
                      i32.const 4
                      call $~lib/rt/__decrease_sp
                      i32.const 16
                      i32.const 15
                      call $~lib/rt/itcms/__new
                      local.set $2
                      global.get $~lib/memory/__stack_pointer
                      local.get $2
                      i32.store align=1
                      local.get $0
                      i32.const 268435455
                      i32.gt_u
                      br_if $folding-inner16
                      local.get $2
                      i32.const 8
                      local.get $0
                      local.get $0
                      i32.const 8
                      i32.le_u
                      select
                      i32.const 2
                      i32.shl
                      local.tee $3
                      i32.const 1
                      call $~lib/rt/itcms/__new
                      local.tee $6
                      call $~lib/set/Set<i8>#set:buckets
                      local.get $2
                      local.get $6
                      i32.store offset=4
                      local.get $2
                      local.get $3
                      i32.store offset=8
                      local.get $2
                      local.get $0
                      i32.store offset=12
                      global.get $~lib/memory/__stack_pointer
                      i32.const 4
                      i32.add
                      global.set $~lib/memory/__stack_pointer
                      global.get $~lib/memory/__stack_pointer
                      local.get $2
                      i32.store align=1
                      i32.const 0
                      local.set $0
                      loop $for-loop|07
                       local.get $5
                       local.get $10
                       i32.lt_s
                       if
                        local.get $9
                        local.get $5
                        i32.const 3
                        i32.shl
                        i32.add
                        local.tee $6
                        i32.load offset=4
                        i32.const 1
                        i32.and
                        i32.eqz
                        if
                         local.get $0
                         local.tee $3
                         i32.const 1
                         i32.add
                         local.set $0
                         local.get $2
                         local.get $3
                         local.get $6
                         i32.load
                         call $~lib/array/Array<i32>#__set
                        end
                        local.get $5
                        i32.const 1
                        i32.add
                        local.set $5
                        br $for-loop|07
                       end
                      end
                      local.get $2
                      local.get $0
                      i32.const 2
                      i32.const 0
                      call $~lib/array/ensureCapacity
                      local.get $2
                      local.get $0
                      i32.store offset=12
                      global.get $~lib/memory/__stack_pointer
                      i32.const 4
                      i32.add
                      global.set $~lib/memory/__stack_pointer
                      global.get $~lib/memory/__stack_pointer
                      local.get $2
                      i32.store offset=4 align=1
                      i32.const 32
                      i32.const 14
                      call $byn$mgfn-shared$~lib/set/Set<i8>#constructor
                      local.set $3
                      global.get $~lib/memory/__stack_pointer
                      local.get $3
                      i32.store align=1
                      i32.const 0
                      local.set $0
                      loop $for-loop|222
                       local.get $0
                       local.get $2
                       i32.load offset=12
                       i32.lt_s
                       if
                        local.get $0
                        local.get $2
                        i32.load offset=12
                        i32.ge_u
                        if
                         br $folding-inner18
                        end
                        local.get $1
                        local.get $2
                        i32.load offset=4
                        local.get $0
                        i32.const 2
                        i32.shl
                        i32.add
                        i32.load
                        call $~lib/set/Set<u32>#has
                        i32.eqz
                        br_if $folding-inner6
                        local.get $0
                        local.get $2
                        i32.load offset=12
                        i32.ge_u
                        if
                         br $folding-inner18
                        end
                        local.get $3
                        local.get $2
                        i32.load offset=4
                        local.get $0
                        i32.const 2
                        i32.shl
                        i32.add
                        i32.load
                        call $~lib/set/Set<u32>#add
                        local.get $0
                        i32.const 1
                        i32.add
                        local.set $0
                        br $for-loop|222
                       end
                      end
                      local.get $3
                      i32.load offset=20
                      local.get $1
                      i32.load offset=20
                      i32.ne
                      br_if $folding-inner7
                      i32.const 0
                      local.set $0
                      loop $for-loop|323
                       local.get $0
                       i32.const 50
                       i32.lt_u
                       if
                        local.get $1
                        local.get $0
                        call $~lib/set/Set<u32>#has
                        i32.eqz
                        br_if $folding-inner8
                        local.get $1
                        local.get $0
                        call $~lib/set/Set<u32>#delete
                        local.get $1
                        local.get $0
                        call $~lib/set/Set<u32>#has
                        br_if $folding-inner9
                        local.get $0
                        i32.const 1
                        i32.add
                        local.set $0
                        br $for-loop|323
                       end
                      end
                      local.get $1
                      i32.load offset=20
                      i32.const 50
                      i32.ne
                      br_if $folding-inner10
                      i32.const 0
                      local.set $0
                      loop $for-loop|424
                       local.get $0
                       i32.const 50
                       i32.lt_u
                       if
                        local.get $1
                        local.get $0
                        call $~lib/set/Set<u32>#has
                        br_if $folding-inner11
                        local.get $1
                        local.get $0
                        call $~lib/set/Set<u32>#add
                        local.get $1
                        local.get $0
                        call $~lib/set/Set<u32>#has
                        i32.eqz
                        br_if $folding-inner12
                        local.get $1
                        local.get $0
                        call $~lib/set/Set<u32>#delete
                        local.get $1
                        local.get $0
                        call $~lib/set/Set<u32>#has
                        br_if $folding-inner13
                        local.get $0
                        i32.const 1
                        i32.add
                        local.set $0
                        br $for-loop|424
                       end
                      end
                      local.get $1
                      i32.load offset=20
                      i32.const 50
                      i32.ne
                      br_if $folding-inner14
                      local.get $1
                      i32.const 32
                      call $byn$mgfn-shared$~lib/set/Set<i8>#clear
                      local.get $1
                      i32.load offset=20
                      br_if $folding-inner15
                      global.get $~lib/memory/__stack_pointer
                      i32.const 12
                      i32.add
                      global.set $~lib/memory/__stack_pointer
                      i32.const 12
                      call $~lib/rt/__decrease_sp
                      i32.const 64
                      i32.const 16
                      call $byn$mgfn-shared$~lib/set/Set<i8>#constructor
                      local.set $1
                      global.get $~lib/memory/__stack_pointer
                      local.get $1
                      i32.store offset=8 align=1
                      loop $for-loop|025
                       local.get $4
                       i64.const 100
                       i64.lt_s
                       if
                        local.get $1
                        local.get $4
                        call $~lib/set/Set<i64>#has
                        br_if $folding-inner0
                        local.get $1
                        local.get $4
                        call $~lib/set/Set<i64>#add
                        local.get $1
                        local.get $4
                        call $~lib/set/Set<i64>#has
                        i32.eqz
                        br_if $folding-inner1
                        local.get $4
                        i64.const 1
                        i64.add
                        local.set $4
                        br $for-loop|025
                       end
                      end
                      local.get $1
                      i32.load offset=20
                      i32.const 100
                      i32.ne
                      br_if $folding-inner2
                      i64.const 50
                      local.set $4
                      loop $for-loop|126
                       local.get $4
                       i64.const 100
                       i64.lt_s
                       if
                        local.get $1
                        local.get $4
                        call $~lib/set/Set<i64>#has
                        i32.eqz
                        br_if $folding-inner3
                        local.get $1
                        local.get $4
                        call $~lib/set/Set<i64>#add
                        local.get $1
                        local.get $4
                        call $~lib/set/Set<i64>#has
                        i32.eqz
                        br_if $folding-inner4
                        local.get $4
                        i64.const 1
                        i64.add
                        local.set $4
                        br $for-loop|126
                       end
                      end
                      local.get $1
                      i32.load offset=20
                      i32.const 100
                      i32.ne
                      br_if $folding-inner5
                      i32.const 0
                      local.set $5
                      i32.const 4
                      call $~lib/rt/__decrease_sp
                      local.get $1
                      i32.load offset=8
                      local.set $9
                      local.get $1
                      i32.load offset=16
                      local.tee $10
                      local.set $0
                      i32.const 4
                      call $~lib/rt/__decrease_sp
                      i32.const 16
                      i32.const 17
                      call $~lib/rt/itcms/__new
                      local.set $2
                      global.get $~lib/memory/__stack_pointer
                      local.get $2
                      i32.store align=1
                      local.get $0
                      i32.const 134217727
                      i32.gt_u
                      br_if $folding-inner16
                      local.get $2
                      i32.const 8
                      local.get $0
                      local.get $0
                      i32.const 8
                      i32.le_u
                      select
                      i32.const 3
                      i32.shl
                      local.tee $3
                      i32.const 1
                      call $~lib/rt/itcms/__new
                      local.tee $6
                      call $~lib/set/Set<i8>#set:buckets
                      local.get $2
                      local.get $6
                      i32.store offset=4
                      local.get $2
                      local.get $3
                      i32.store offset=8
                      local.get $2
                      local.get $0
                      i32.store offset=12
                      global.get $~lib/memory/__stack_pointer
                      i32.const 4
                      i32.add
                      global.set $~lib/memory/__stack_pointer
                      global.get $~lib/memory/__stack_pointer
                      local.get $2
                      i32.store align=1
                      i32.const 0
                      local.set $0
                      loop $for-loop|08
                       local.get $5
                       local.get $10
                       i32.lt_s
                       if
                        local.get $9
                        local.get $5
                        i32.const 4
                        i32.shl
                        i32.add
                        local.tee $6
                        i32.load offset=8
                        i32.const 1
                        i32.and
                        i32.eqz
                        if
                         local.get $0
                         local.tee $3
                         i32.const 1
                         i32.add
                         local.set $0
                         local.get $2
                         local.get $3
                         local.get $6
                         i64.load
                         call $~lib/array/Array<i64>#__set
                        end
                        local.get $5
                        i32.const 1
                        i32.add
                        local.set $5
                        br $for-loop|08
                       end
                      end
                      local.get $2
                      local.get $0
                      i32.const 3
                      i32.const 0
                      call $~lib/array/ensureCapacity
                      local.get $2
                      local.get $0
                      i32.store offset=12
                      global.get $~lib/memory/__stack_pointer
                      i32.const 4
                      i32.add
                      global.set $~lib/memory/__stack_pointer
                      global.get $~lib/memory/__stack_pointer
                      local.get $2
                      i32.store offset=4 align=1
                      i32.const 64
                      i32.const 16
                      call $byn$mgfn-shared$~lib/set/Set<i8>#constructor
                      local.set $3
                      global.get $~lib/memory/__stack_pointer
                      local.get $3
                      i32.store align=1
                      i32.const 0
                      local.set $0
                      loop $for-loop|227
                       local.get $0
                       local.get $2
                       i32.load offset=12
                       i32.lt_s
                       if
                        local.get $0
                        local.get $2
                        i32.load offset=12
                        i32.ge_u
                        if
                         br $folding-inner18
                        end
                        local.get $1
                        local.get $2
                        i32.load offset=4
                        local.get $0
                        i32.const 3
                        i32.shl
                        i32.add
                        i64.load
                        call $~lib/set/Set<i64>#has
                        i32.eqz
                        br_if $folding-inner6
                        local.get $0
                        local.get $2
                        i32.load offset=12
                        i32.ge_u
                        if
                         br $folding-inner18
                        end
                        local.get $3
                        local.get $2
                        i32.load offset=4
                        local.get $0
                        i32.const 3
                        i32.shl
                        i32.add
                        i64.load
                        call $~lib/set/Set<i64>#add
                        local.get $0
                        i32.const 1
                        i32.add
                        local.set $0
                        br $for-loop|227
                       end
                      end
                      local.get $3
                      i32.load offset=20
                      local.get $1
                      i32.load offset=20
                      i32.ne
                      br_if $folding-inner7
                      i64.const 0
                      local.set $4
                      loop $for-loop|328
                       local.get $4
                       i64.const 50
                       i64.lt_s
                       if
                        local.get $1
                        local.get $4
                        call $~lib/set/Set<i64>#has
                        i32.eqz
                        br_if $folding-inner8
                        local.get $1
                        local.get $4
                        call $~lib/set/Set<i64>#delete
                        local.get $1
                        local.get $4
                        call $~lib/set/Set<i64>#has
                        br_if $folding-inner9
                        local.get $4
                        i64.const 1
                        i64.add
                        local.set $4
                        br $for-loop|328
                       end
                      end
                      local.get $1
                      i32.load offset=20
                      i32.const 50
                      i32.ne
                      br_if $folding-inner10
                      i64.const 0
                      local.set $4
                      loop $for-loop|429
                       local.get $4
                       i64.const 50
                       i64.lt_s
                       if
                        local.get $1
                        local.get $4
                        call $~lib/set/Set<i64>#has
                        br_if $folding-inner11
                        local.get $1
                        local.get $4
                        call $~lib/set/Set<i64>#add
                        local.get $1
                        local.get $4
                        call $~lib/set/Set<i64>#has
                        i32.eqz
                        br_if $folding-inner12
                        local.get $1
                        local.get $4
                        call $~lib/set/Set<i64>#delete
                        local.get $1
                        local.get $4
                        call $~lib/set/Set<i64>#has
                        br_if $folding-inner13
                        local.get $4
                        i64.const 1
                        i64.add
                        local.set $4
                        br $for-loop|429
                       end
                      end
                      local.get $1
                      i32.load offset=20
                      i32.const 50
                      i32.ne
                      br_if $folding-inner14
                      local.get $1
                      i32.const 64
                      call $byn$mgfn-shared$~lib/set/Set<i8>#clear
                      local.get $1
                      i32.load offset=20
                      br_if $folding-inner15
                      global.get $~lib/memory/__stack_pointer
                      i32.const 12
                      i32.add
                      global.set $~lib/memory/__stack_pointer
                      i64.const 0
                      local.set $4
                      i32.const 12
                      call $~lib/rt/__decrease_sp
                      i32.const 64
                      i32.const 18
                      call $byn$mgfn-shared$~lib/set/Set<i8>#constructor
                      local.set $1
                      global.get $~lib/memory/__stack_pointer
                      local.get $1
                      i32.store offset=8 align=1
                      loop $for-loop|030
                       local.get $4
                       i64.const 100
                       i64.lt_u
                       if
                        local.get $1
                        local.get $4
                        call $~lib/set/Set<u64>#has
                        br_if $folding-inner0
                        local.get $1
                        local.get $4
                        call $~lib/set/Set<u64>#add
                        local.get $1
                        local.get $4
                        call $~lib/set/Set<u64>#has
                        i32.eqz
                        br_if $folding-inner1
                        local.get $4
                        i64.const 1
                        i64.add
                        local.set $4
                        br $for-loop|030
                       end
                      end
                      local.get $1
                      i32.load offset=20
                      i32.const 100
                      i32.ne
                      br_if $folding-inner2
                      i64.const 50
                      local.set $4
                      loop $for-loop|131
                       local.get $4
                       i64.const 100
                       i64.lt_u
                       if
                        local.get $1
                        local.get $4
                        call $~lib/set/Set<u64>#has
                        i32.eqz
                        br_if $folding-inner3
                        local.get $1
                        local.get $4
                        call $~lib/set/Set<u64>#add
                        local.get $1
                        local.get $4
                        call $~lib/set/Set<u64>#has
                        i32.eqz
                        br_if $folding-inner4
                        local.get $4
                        i64.const 1
                        i64.add
                        local.set $4
                        br $for-loop|131
                       end
                      end
                      local.get $1
                      i32.load offset=20
                      i32.const 100
                      i32.ne
                      br_if $folding-inner5
                      i32.const 0
                      local.set $5
                      i32.const 4
                      call $~lib/rt/__decrease_sp
                      local.get $1
                      i32.load offset=8
                      local.set $9
                      local.get $1
                      i32.load offset=16
                      local.tee $10
                      local.set $0
                      i32.const 4
                      call $~lib/rt/__decrease_sp
                      i32.const 16
                      i32.const 19
                      call $~lib/rt/itcms/__new
                      local.set $2
                      global.get $~lib/memory/__stack_pointer
                      local.get $2
                      i32.store align=1
                      local.get $0
                      i32.const 134217727
                      i32.gt_u
                      br_if $folding-inner16
                      local.get $2
                      i32.const 8
                      local.get $0
                      local.get $0
                      i32.const 8
                      i32.le_u
                      select
                      i32.const 3
                      i32.shl
                      local.tee $3
                      i32.const 1
                      call $~lib/rt/itcms/__new
                      local.tee $6
                      call $~lib/set/Set<i8>#set:buckets
                      local.get $2
                      local.get $6
                      i32.store offset=4
                      local.get $2
                      local.get $3
                      i32.store offset=8
                      local.get $2
                      local.get $0
                      i32.store offset=12
                      global.get $~lib/memory/__stack_pointer
                      i32.const 4
                      i32.add
                      global.set $~lib/memory/__stack_pointer
                      global.get $~lib/memory/__stack_pointer
                      local.get $2
                      i32.store align=1
                      i32.const 0
                      local.set $0
                      loop $for-loop|09
                       local.get $5
                       local.get $10
                       i32.lt_s
                       if
                        local.get $9
                        local.get $5
                        i32.const 4
                        i32.shl
                        i32.add
                        local.tee $6
                        i32.load offset=8
                        i32.const 1
                        i32.and
                        i32.eqz
                        if
                         local.get $0
                         local.tee $3
                         i32.const 1
                         i32.add
                         local.set $0
                         local.get $2
                         local.get $3
                         local.get $6
                         i64.load
                         call $~lib/array/Array<i64>#__set
                        end
                        local.get $5
                        i32.const 1
                        i32.add
                        local.set $5
                        br $for-loop|09
                       end
                      end
                      local.get $2
                      local.get $0
                      i32.const 3
                      i32.const 0
                      call $~lib/array/ensureCapacity
                      local.get $2
                      local.get $0
                      i32.store offset=12
                      global.get $~lib/memory/__stack_pointer
                      i32.const 4
                      i32.add
                      global.set $~lib/memory/__stack_pointer
                      global.get $~lib/memory/__stack_pointer
                      local.get $2
                      i32.store offset=4 align=1
                      i32.const 64
                      i32.const 18
                      call $byn$mgfn-shared$~lib/set/Set<i8>#constructor
                      local.set $3
                      global.get $~lib/memory/__stack_pointer
                      local.get $3
                      i32.store align=1
                      i32.const 0
                      local.set $0
                      loop $for-loop|232
                       local.get $0
                       local.get $2
                       i32.load offset=12
                       i32.lt_s
                       if
                        local.get $0
                        local.get $2
                        i32.load offset=12
                        i32.ge_u
                        if
                         br $folding-inner18
                        end
                        local.get $1
                        local.get $2
                        i32.load offset=4
                        local.get $0
                        i32.const 3
                        i32.shl
                        i32.add
                        i64.load
                        call $~lib/set/Set<u64>#has
                        i32.eqz
                        br_if $folding-inner6
                        local.get $0
                        local.get $2
                        i32.load offset=12
                        i32.ge_u
                        if
                         br $folding-inner18
                        end
                        local.get $3
                        local.get $2
                        i32.load offset=4
                        local.get $0
                        i32.const 3
                        i32.shl
                        i32.add
                        i64.load
                        call $~lib/set/Set<u64>#add
                        local.get $0
                        i32.const 1
                        i32.add
                        local.set $0
                        br $for-loop|232
                       end
                      end
                      local.get $3
                      i32.load offset=20
                      local.get $1
                      i32.load offset=20
                      i32.ne
                      br_if $folding-inner7
                      i64.const 0
                      local.set $4
                      loop $for-loop|333
                       local.get $4
                       i64.const 50
                       i64.lt_u
                       if
                        local.get $1
                        local.get $4
                        call $~lib/set/Set<u64>#has
                        i32.eqz
                        br_if $folding-inner8
                        local.get $1
                        local.get $4
                        call $~lib/set/Set<u64>#delete
                        local.get $1
                        local.get $4
                        call $~lib/set/Set<u64>#has
                        br_if $folding-inner9
                        local.get $4
                        i64.const 1
                        i64.add
                        local.set $4
                        br $for-loop|333
                       end
                      end
                      local.get $1
                      i32.load offset=20
                      i32.const 50
                      i32.ne
                      br_if $folding-inner10
                      i64.const 0
                      local.set $4
                      loop $for-loop|434
                       local.get $4
                       i64.const 50
                       i64.lt_u
                       if
                        local.get $1
                        local.get $4
                        call $~lib/set/Set<u64>#has
                        br_if $folding-inner11
                        local.get $1
                        local.get $4
                        call $~lib/set/Set<u64>#add
                        local.get $1
                        local.get $4
                        call $~lib/set/Set<u64>#has
                        i32.eqz
                        br_if $folding-inner12
                        local.get $1
                        local.get $4
                        call $~lib/set/Set<u64>#delete
                        local.get $1
                        local.get $4
                        call $~lib/set/Set<u64>#has
                        br_if $folding-inner13
                        local.get $4
                        i64.const 1
                        i64.add
                        local.set $4
                        br $for-loop|434
                       end
                      end
                      local.get $1
                      i32.load offset=20
                      i32.const 50
                      i32.ne
                      br_if $folding-inner14
                      local.get $1
                      i32.const 64
                      call $byn$mgfn-shared$~lib/set/Set<i8>#clear
                      local.get $1
                      i32.load offset=20
                      br_if $folding-inner15
                      global.get $~lib/memory/__stack_pointer
                      i32.const 12
                      i32.add
                      global.set $~lib/memory/__stack_pointer
                      i32.const 12
                      call $~lib/rt/__decrease_sp
                      i32.const 32
                      i32.const 20
                      call $byn$mgfn-shared$~lib/set/Set<i8>#constructor
                      local.set $1
                      global.get $~lib/memory/__stack_pointer
                      local.get $1
                      i32.store offset=8 align=1
                      loop $for-loop|035
                       local.get $7
                       f32.const 100
                       f32.lt
                       if
                        local.get $1
                        local.get $7
                        call $~lib/set/Set<f32>#has
                        br_if $folding-inner0
                        local.get $1
                        local.get $7
                        call $~lib/set/Set<f32>#add
                        local.get $1
                        local.get $7
                        call $~lib/set/Set<f32>#has
                        i32.eqz
                        br_if $folding-inner1
                        local.get $7
                        f32.const 1
                        f32.add
                        local.set $7
                        br $for-loop|035
                       end
                      end
                      local.get $1
                      i32.load offset=20
                      i32.const 100
                      i32.ne
                      br_if $folding-inner2
                      f32.const 50
                      local.set $7
                      loop $for-loop|136
                       local.get $7
                       f32.const 100
                       f32.lt
                       if
                        local.get $1
                        local.get $7
                        call $~lib/set/Set<f32>#has
                        i32.eqz
                        br_if $folding-inner3
                        local.get $1
                        local.get $7
                        call $~lib/set/Set<f32>#add
                        local.get $1
                        local.get $7
                        call $~lib/set/Set<f32>#has
                        i32.eqz
                        br_if $folding-inner4
                        local.get $7
                        f32.const 1
                        f32.add
                        local.set $7
                        br $for-loop|136
                       end
                      end
                      local.get $1
                      i32.load offset=20
                      i32.const 100
                      i32.ne
                      br_if $folding-inner5
                      i32.const 0
                      local.set $5
                      i32.const 4
                      call $~lib/rt/__decrease_sp
                      local.get $1
                      i32.load offset=8
                      local.set $9
                      local.get $1
                      i32.load offset=16
                      local.tee $10
                      local.set $0
                      i32.const 4
                      call $~lib/rt/__decrease_sp
                      i32.const 16
                      i32.const 21
                      call $~lib/rt/itcms/__new
                      local.set $2
                      global.get $~lib/memory/__stack_pointer
                      local.get $2
                      i32.store align=1
                      local.get $0
                      i32.const 268435455
                      i32.gt_u
                      br_if $folding-inner16
                      local.get $2
                      i32.const 8
                      local.get $0
                      local.get $0
                      i32.const 8
                      i32.le_u
                      select
                      i32.const 2
                      i32.shl
                      local.tee $3
                      i32.const 1
                      call $~lib/rt/itcms/__new
                      local.tee $6
                      call $~lib/set/Set<i8>#set:buckets
                      local.get $2
                      local.get $6
                      i32.store offset=4
                      local.get $2
                      local.get $3
                      i32.store offset=8
                      local.get $2
                      local.get $0
                      i32.store offset=12
                      global.get $~lib/memory/__stack_pointer
                      i32.const 4
                      i32.add
                      global.set $~lib/memory/__stack_pointer
                      global.get $~lib/memory/__stack_pointer
                      local.get $2
                      i32.store align=1
                      i32.const 0
                      local.set $0
                      loop $for-loop|011
                       local.get $5
                       local.get $10
                       i32.lt_s
                       if
                        local.get $9
                        local.get $5
                        i32.const 3
                        i32.shl
                        i32.add
                        local.tee $6
                        i32.load offset=4
                        i32.const 1
                        i32.and
                        i32.eqz
                        if
                         local.get $0
                         local.tee $3
                         i32.const 1
                         i32.add
                         local.set $0
                         local.get $6
                         f32.load
                         local.set $7
                         local.get $3
                         local.get $2
                         i32.load offset=12
                         i32.ge_u
                         if
                          local.get $3
                          i32.const 0
                          i32.lt_s
                          br_if $folding-inner17
                          local.get $2
                          local.get $3
                          i32.const 1
                          i32.add
                          local.tee $6
                          i32.const 2
                          i32.const 1
                          call $~lib/array/ensureCapacity
                          local.get $2
                          local.get $6
                          i32.store offset=12
                         end
                         local.get $2
                         i32.load offset=4
                         local.get $3
                         i32.const 2
                         i32.shl
                         i32.add
                         local.get $7
                         f32.store
                        end
                        local.get $5
                        i32.const 1
                        i32.add
                        local.set $5
                        br $for-loop|011
                       end
                      end
                      local.get $2
                      local.get $0
                      i32.const 2
                      i32.const 0
                      call $~lib/array/ensureCapacity
                      local.get $2
                      local.get $0
                      i32.store offset=12
                      global.get $~lib/memory/__stack_pointer
                      i32.const 4
                      i32.add
                      global.set $~lib/memory/__stack_pointer
                      global.get $~lib/memory/__stack_pointer
                      local.get $2
                      i32.store offset=4 align=1
                      i32.const 32
                      i32.const 20
                      call $byn$mgfn-shared$~lib/set/Set<i8>#constructor
                      local.set $3
                      global.get $~lib/memory/__stack_pointer
                      local.get $3
                      i32.store align=1
                      i32.const 0
                      local.set $0
                      loop $for-loop|237
                       local.get $0
                       local.get $2
                       i32.load offset=12
                       i32.lt_s
                       if
                        local.get $0
                        local.get $2
                        i32.load offset=12
                        i32.ge_u
                        if
                         br $folding-inner18
                        end
                        local.get $1
                        local.get $2
                        i32.load offset=4
                        local.get $0
                        i32.const 2
                        i32.shl
                        i32.add
                        f32.load
                        call $~lib/set/Set<f32>#has
                        i32.eqz
                        br_if $folding-inner6
                        local.get $0
                        local.get $2
                        i32.load offset=12
                        i32.ge_u
                        if
                         br $folding-inner18
                        end
                        local.get $3
                        local.get $2
                        i32.load offset=4
                        local.get $0
                        i32.const 2
                        i32.shl
                        i32.add
                        f32.load
                        call $~lib/set/Set<f32>#add
                        local.get $0
                        i32.const 1
                        i32.add
                        local.set $0
                        br $for-loop|237
                       end
                      end
                      local.get $3
                      i32.load offset=20
                      local.get $1
                      i32.load offset=20
                      i32.ne
                      br_if $folding-inner7
                      f32.const 0
                      local.set $7
                      loop $for-loop|338
                       local.get $7
                       f32.const 50
                       f32.lt
                       if
                        local.get $1
                        local.get $7
                        call $~lib/set/Set<f32>#has
                        i32.eqz
                        br_if $folding-inner8
                        local.get $1
                        local.get $7
                        call $~lib/set/Set<f32>#delete
                        local.get $1
                        local.get $7
                        call $~lib/set/Set<f32>#has
                        br_if $folding-inner9
                        local.get $7
                        f32.const 1
                        f32.add
                        local.set $7
                        br $for-loop|338
                       end
                      end
                      local.get $1
                      i32.load offset=20
                      i32.const 50
                      i32.ne
                      br_if $folding-inner10
                      f32.const 0
                      local.set $7
                      loop $for-loop|439
                       local.get $7
                       f32.const 50
                       f32.lt
                       if
                        local.get $1
                        local.get $7
                        call $~lib/set/Set<f32>#has
                        br_if $folding-inner11
                        local.get $1
                        local.get $7
                        call $~lib/set/Set<f32>#add
                        local.get $1
                        local.get $7
                        call $~lib/set/Set<f32>#has
                        i32.eqz
                        br_if $folding-inner12
                        local.get $1
                        local.get $7
                        call $~lib/set/Set<f32>#delete
                        local.get $1
                        local.get $7
                        call $~lib/set/Set<f32>#has
                        br_if $folding-inner13
                        local.get $7
                        f32.const 1
                        f32.add
                        local.set $7
                        br $for-loop|439
                       end
                      end
                      local.get $1
                      i32.load offset=20
                      i32.const 50
                      i32.ne
                      br_if $folding-inner14
                      local.get $1
                      i32.const 32
                      call $byn$mgfn-shared$~lib/set/Set<i8>#clear
                      local.get $1
                      i32.load offset=20
                      br_if $folding-inner15
                      global.get $~lib/memory/__stack_pointer
                      i32.const 12
                      i32.add
                      global.set $~lib/memory/__stack_pointer
                      i32.const 12
                      call $~lib/rt/__decrease_sp
                      i32.const 64
                      i32.const 22
                      call $byn$mgfn-shared$~lib/set/Set<i8>#constructor
                      local.set $1
                      global.get $~lib/memory/__stack_pointer
                      local.get $1
                      i32.store offset=8 align=1
                      loop $for-loop|040
                       local.get $8
                       f64.const 100
                       f64.lt
                       if
                        local.get $1
                        local.get $8
                        call $~lib/set/Set<f64>#has
                        br_if $folding-inner0
                        local.get $1
                        local.get $8
                        call $~lib/set/Set<f64>#add
                        local.get $1
                        local.get $8
                        call $~lib/set/Set<f64>#has
                        i32.eqz
                        br_if $folding-inner1
                        local.get $8
                        f64.const 1
                        f64.add
                        local.set $8
                        br $for-loop|040
                       end
                      end
                      local.get $1
                      i32.load offset=20
                      i32.const 100
                      i32.ne
                      br_if $folding-inner2
                      f64.const 50
                      local.set $8
                      loop $for-loop|141
                       local.get $8
                       f64.const 100
                       f64.lt
                       if
                        local.get $1
                        local.get $8
                        call $~lib/set/Set<f64>#has
                        i32.eqz
                        br_if $folding-inner3
                        local.get $1
                        local.get $8
                        call $~lib/set/Set<f64>#add
                        local.get $1
                        local.get $8
                        call $~lib/set/Set<f64>#has
                        i32.eqz
                        br_if $folding-inner4
                        local.get $8
                        f64.const 1
                        f64.add
                        local.set $8
                        br $for-loop|141
                       end
                      end
                      local.get $1
                      i32.load offset=20
                      i32.const 100
                      i32.ne
                      br_if $folding-inner5
                      i32.const 0
                      local.set $5
                      i32.const 4
                      call $~lib/rt/__decrease_sp
                      local.get $1
                      i32.load offset=8
                      local.set $9
                      local.get $1
                      i32.load offset=16
                      local.tee $10
                      local.set $0
                      i32.const 4
                      call $~lib/rt/__decrease_sp
                      i32.const 16
                      i32.const 23
                      call $~lib/rt/itcms/__new
                      local.set $2
                      global.get $~lib/memory/__stack_pointer
                      local.get $2
                      i32.store align=1
                      local.get $0
                      i32.const 134217727
                      i32.gt_u
                      br_if $folding-inner16
                      local.get $2
                      i32.const 8
                      local.get $0
                      local.get $0
                      i32.const 8
                      i32.le_u
                      select
                      i32.const 3
                      i32.shl
                      local.tee $3
                      i32.const 1
                      call $~lib/rt/itcms/__new
                      local.tee $6
                      call $~lib/set/Set<i8>#set:buckets
                      local.get $2
                      local.get $6
                      i32.store offset=4
                      local.get $2
                      local.get $3
                      i32.store offset=8
                      local.get $2
                      local.get $0
                      i32.store offset=12
                      global.get $~lib/memory/__stack_pointer
                      i32.const 4
                      i32.add
                      global.set $~lib/memory/__stack_pointer
                      global.get $~lib/memory/__stack_pointer
                      local.get $2
                      i32.store align=1
                      i32.const 0
                      local.set $0
                      loop $for-loop|012
                       local.get $5
                       local.get $10
                       i32.lt_s
                       if
                        local.get $9
                        local.get $5
                        i32.const 4
                        i32.shl
                        i32.add
                        local.tee $6
                        i32.load offset=8
                        i32.const 1
                        i32.and
                        i32.eqz
                        if
                         local.get $0
                         local.tee $3
                         i32.const 1
                         i32.add
                         local.set $0
                         local.get $6
                         f64.load
                         local.set $8
                         local.get $3
                         local.get $2
                         i32.load offset=12
                         i32.ge_u
                         if
                          local.get $3
                          i32.const 0
                          i32.lt_s
                          br_if $folding-inner17
                          local.get $2
                          local.get $3
                          i32.const 1
                          i32.add
                          local.tee $6
                          i32.const 3
                          i32.const 1
                          call $~lib/array/ensureCapacity
                          local.get $2
                          local.get $6
                          i32.store offset=12
                         end
                         local.get $2
                         i32.load offset=4
                         local.get $3
                         i32.const 3
                         i32.shl
                         i32.add
                         local.get $8
                         f64.store
                        end
                        local.get $5
                        i32.const 1
                        i32.add
                        local.set $5
                        br $for-loop|012
                       end
                      end
                      local.get $2
                      local.get $0
                      i32.const 3
                      i32.const 0
                      call $~lib/array/ensureCapacity
                      local.get $2
                      local.get $0
                      i32.store offset=12
                      global.get $~lib/memory/__stack_pointer
                      i32.const 4
                      i32.add
                      global.set $~lib/memory/__stack_pointer
                      global.get $~lib/memory/__stack_pointer
                      local.get $2
                      i32.store offset=4 align=1
                      i32.const 64
                      i32.const 22
                      call $byn$mgfn-shared$~lib/set/Set<i8>#constructor
                      local.set $3
                      global.get $~lib/memory/__stack_pointer
                      local.get $3
                      i32.store align=1
                      i32.const 0
                      local.set $0
                      loop $for-loop|242
                       local.get $0
                       local.get $2
                       i32.load offset=12
                       i32.lt_s
                       if
                        local.get $0
                        local.get $2
                        i32.load offset=12
                        i32.ge_u
                        if
                         br $folding-inner18
                        end
                        local.get $1
                        local.get $2
                        i32.load offset=4
                        local.get $0
                        i32.const 3
                        i32.shl
                        i32.add
                        f64.load
                        call $~lib/set/Set<f64>#has
                        i32.eqz
                        br_if $folding-inner6
                        local.get $0
                        local.get $2
                        i32.load offset=12
                        i32.ge_u
                        if
                         br $folding-inner18
                        end
                        local.get $3
                        local.get $2
                        i32.load offset=4
                        local.get $0
                        i32.const 3
                        i32.shl
                        i32.add
                        f64.load
                        call $~lib/set/Set<f64>#add
                        local.get $0
                        i32.const 1
                        i32.add
                        local.set $0
                        br $for-loop|242
                       end
                      end
                      local.get $3
                      i32.load offset=20
                      local.get $1
                      i32.load offset=20
                      i32.ne
                      br_if $folding-inner7
                      f64.const 0
                      local.set $8
                      loop $for-loop|343
                       local.get $8
                       f64.const 50
                       f64.lt
                       if
                        local.get $1
                        local.get $8
                        call $~lib/set/Set<f64>#has
                        i32.eqz
                        br_if $folding-inner8
                        local.get $1
                        local.get $8
                        call $~lib/set/Set<f64>#delete
                        local.get $1
                        local.get $8
                        call $~lib/set/Set<f64>#has
                        br_if $folding-inner9
                        local.get $8
                        f64.const 1
                        f64.add
                        local.set $8
                        br $for-loop|343
                       end
                      end
                      local.get $1
                      i32.load offset=20
                      i32.const 50
                      i32.ne
                      br_if $folding-inner10
                      f64.const 0
                      local.set $8
                      loop $for-loop|444
                       local.get $8
                       f64.const 50
                       f64.lt
                       if
                        local.get $1
                        local.get $8
                        call $~lib/set/Set<f64>#has
                        br_if $folding-inner11
                        local.get $1
                        local.get $8
                        call $~lib/set/Set<f64>#add
                        local.get $1
                        local.get $8
                        call $~lib/set/Set<f64>#has
                        i32.eqz
                        br_if $folding-inner12
                        local.get $1
                        local.get $8
                        call $~lib/set/Set<f64>#delete
                        local.get $1
                        local.get $8
                        call $~lib/set/Set<f64>#has
                        br_if $folding-inner13
                        local.get $8
                        f64.const 1
                        f64.add
                        local.set $8
                        br $for-loop|444
                       end
                      end
                      local.get $1
                      i32.load offset=20
                      i32.const 50
                      i32.ne
                      br_if $folding-inner14
                      local.get $1
                      i32.const 64
                      call $byn$mgfn-shared$~lib/set/Set<i8>#clear
                      local.get $1
                      i32.load offset=20
                      br_if $folding-inner15
                      global.get $~lib/memory/__stack_pointer
                      i32.const 12
                      i32.add
                      global.set $~lib/memory/__stack_pointer
                      global.get $~lib/rt/itcms/state
                      i32.const 0
                      i32.gt_s
                      if
                       loop $while-continue|0
                        global.get $~lib/rt/itcms/state
                        if
                         call $~lib/rt/itcms/step
                         drop
                         br $while-continue|0
                        end
                       end
                      end
                      call $~lib/rt/itcms/step
                      drop
                      loop $while-continue|1
                       global.get $~lib/rt/itcms/state
                       if
                        call $~lib/rt/itcms/step
                        drop
                        br $while-continue|1
                       end
                      end
                      global.get $~lib/rt/itcms/total
                      i64.extend_i32_u
                      i64.const 200
                      i64.mul
                      i64.const 100
                      i64.div_u
                      i32.wrap_i64
                      i32.const 1024
                      i32.add
                      global.set $~lib/rt/itcms/threshold
                      br $__inlined_func$start:std/set$724
                     end
                     i32.const 0
                     i32.const 544
                     i32.const 6
                     i32.const 5
                     call $~lib/builtins/abort
                     unreachable
                    end
                    i32.const 0
                    i32.const 544
                    i32.const 8
                    i32.const 5
                    call $~lib/builtins/abort
                    unreachable
                   end
                   i32.const 0
                   i32.const 544
                   i32.const 10
                   i32.const 3
                   call $~lib/builtins/abort
                   unreachable
                  end
                  i32.const 0
                  i32.const 544
                  i32.const 14
                  i32.const 5
                  call $~lib/builtins/abort
                  unreachable
                 end
                 i32.const 0
                 i32.const 544
                 i32.const 16
                 i32.const 5
                 call $~lib/builtins/abort
                 unreachable
                end
                i32.const 0
                i32.const 544
                i32.const 18
                i32.const 3
                call $~lib/builtins/abort
                unreachable
               end
               i32.const 0
               i32.const 544
               i32.const 24
               i32.const 5
               call $~lib/builtins/abort
               unreachable
              end
              i32.const 0
              i32.const 544
              i32.const 27
              i32.const 3
              call $~lib/builtins/abort
              unreachable
             end
             i32.const 0
             i32.const 544
             i32.const 31
             i32.const 5
             call $~lib/builtins/abort
             unreachable
            end
            i32.const 0
            i32.const 544
            i32.const 33
            i32.const 5
            call $~lib/builtins/abort
            unreachable
           end
           i32.const 0
           i32.const 544
           i32.const 35
           i32.const 3
           call $~lib/builtins/abort
           unreachable
          end
          i32.const 0
          i32.const 544
          i32.const 39
          i32.const 5
          call $~lib/builtins/abort
          unreachable
         end
         i32.const 0
         i32.const 544
         i32.const 41
         i32.const 5
         call $~lib/builtins/abort
         unreachable
        end
        i32.const 0
        i32.const 544
        i32.const 43
        i32.const 5
        call $~lib/builtins/abort
        unreachable
       end
       i32.const 0
       i32.const 544
       i32.const 45
       i32.const 3
       call $~lib/builtins/abort
       unreachable
      end
      i32.const 0
      i32.const 544
      i32.const 49
      i32.const 3
      call $~lib/builtins/abort
      unreachable
     end
     i32.const 432
     i32.const 592
     i32.const 84
     i32.const 62
     call $~lib/builtins/abort
     unreachable
    end
    i32.const 224
    i32.const 592
    i32.const 147
    i32.const 22
    call $~lib/builtins/abort
    unreachable
   end
   return
  end
  i32.const 224
  i32.const 592
  i32.const 129
  i32.const 42
  call $~lib/builtins/abort
  unreachable
 )
 (func $~lib/rt/__decrease_sp (param $0 i32)
  global.get $~lib/memory/__stack_pointer
  local.get $0
  i32.sub
  global.set $~lib/memory/__stack_pointer
  global.get $~lib/memory/__stack_pointer
  i32.const 0
  local.get $0
  memory.fill
  global.get $~lib/memory/__stack_pointer
  i32.const 724
  i32.lt_s
  if
   unreachable
  end
 )
 (func $byn$mgfn-shared$~lib/set/Set<i8>#clear (param $0 i32) (param $1 i32)
  local.get $0
  i32.const 16
  call $~lib/arraybuffer/ArrayBuffer#constructor
  call $~lib/set/Set<i8>#set:buckets
  local.get $0
  i32.const 3
  i32.store offset=4
  local.get $0
  local.get $1
  call $~lib/arraybuffer/ArrayBuffer#constructor
  call $~lib/set/Set<i8>#set:entries
  local.get $0
  i32.const 4
  i32.store offset=12
  local.get $0
  i32.const 0
  i32.store offset=16
  local.get $0
  i32.const 0
  i32.store offset=20
 )
 (func $byn$mgfn-shared$~lib/set/Set<i8>#constructor (param $0 i32) (param $1 i32) (result i32)
  i32.const 4
  call $~lib/rt/__decrease_sp
  i32.const 24
  local.get $1
  call $~lib/rt/itcms/__new
  local.set $1
  global.get $~lib/memory/__stack_pointer
  local.get $1
  i32.store align=1
  local.get $1
  i32.const 16
  call $~lib/arraybuffer/ArrayBuffer#constructor
  call $~lib/set/Set<i8>#set:buckets
  local.get $1
  i32.const 3
  i32.store offset=4
  local.get $1
  local.get $0
  call $~lib/arraybuffer/ArrayBuffer#constructor
  call $~lib/set/Set<i8>#set:entries
  local.get $1
  i32.const 4
  i32.store offset=12
  global.get $~lib/memory/__stack_pointer
  i32.const 4
  i32.add
  global.set $~lib/memory/__stack_pointer
  local.get $1
 )
 (func $byn$mgfn-shared$~lib/util/hash/HASH<u8> (param $0 i32) (param $1 i32) (param $2 i32) (result i32)
  local.get $0
  local.get $2
  i32.and
  i32.const -1028477379
  i32.mul
  local.get $1
  i32.add
  i32.const 17
  i32.rotl
  i32.const 668265263
  i32.mul
  local.tee $0
  i32.const 15
  i32.shr_u
  local.get $0
  i32.xor
  i32.const -2048144777
  i32.mul
  local.tee $0
  i32.const 13
  i32.shr_u
  local.get $0
  i32.xor
  i32.const -1028477379
  i32.mul
  local.tee $0
  i32.const 16
  i32.shr_u
  local.get $0
  i32.xor
 )
)
