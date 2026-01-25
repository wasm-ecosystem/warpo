(module
 (type $0 (func (param i32 i32 i32) (result i32)))
 (type $1 (func (param i32)))
 (type $2 (func (param i32 i32) (result i32)))
 (type $3 (func (param i32 i32 i32 i32)))
 (type $4 (func))
 (type $5 (func (param i32 i32)))
 (type $6 (func (param i32 i32 i32)))
 (type $7 (func (param i32 i32) (result i64)))
 (type $8 (func (param i32 i32 i64)))
 (type $9 (func (result i32)))
 (type $10 (func (param i32 i32 i32) (result f32)))
 (type $11 (func (param i32 i32) (result f64)))
 (type $12 (func (param i32 f32 i32)))
 (type $13 (func (param i32 f64 i32)))
 (type $14 (func (param i32 i64 i32 i32)))
 (import "env" "abort" (func $~lib/builtins/abort (param i32 i32 i32 i32)))
 (global $~lib/memory/__stack_pointer (mut i32) (i32.const 33520))
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
 (data $0 (i32.const 12) ",")
 (data $0.1 (i32.const 24) "\02\00\00\00\1c\00\00\00I\00n\00v\00a\00l\00i\00d\00 \00l\00e\00n\00g\00t\00h")
 (data $1 (i32.const 60) "<")
 (data $1.1 (i32.const 72) "\02\00\00\00&\00\00\00~\00l\00i\00b\00/\00a\00r\00r\00a\00y\00b\00u\00f\00f\00e\00r\00.\00t\00s")
 (data $2 (i32.const 124) "<")
 (data $2.1 (i32.const 136) "\02\00\00\00(\00\00\00A\00l\00l\00o\00c\00a\00t\00i\00o\00n\00 \00t\00o\00o\00 \00l\00a\00r\00g\00e")
 (data $3 (i32.const 188) "<")
 (data $3.1 (i32.const 200) "\02\00\00\00 \00\00\00~\00l\00i\00b\00/\00r\00t\00/\00i\00t\00c\00m\00s\00.\00t\00s")
 (data $6 (i32.const 316) "<")
 (data $6.1 (i32.const 328) "\02\00\00\00$\00\00\00I\00n\00d\00e\00x\00 \00o\00u\00t\00 \00o\00f\00 \00r\00a\00n\00g\00e")
 (data $7 (i32.const 380) ",")
 (data $7.1 (i32.const 392) "\02\00\00\00\14\00\00\00~\00l\00i\00b\00/\00r\00t\00.\00t\00s")
 (data $9 (i32.const 460) "<")
 (data $9.1 (i32.const 472) "\02\00\00\00\1e\00\00\00~\00l\00i\00b\00/\00r\00t\00/\00t\00l\00s\00f\00.\00t\00s")
 (data $10 (i32.const 524) "<")
 (data $10.1 (i32.const 536) "\02\00\00\00$\00\00\00~\00l\00i\00b\00/\00t\00y\00p\00e\00d\00a\00r\00r\00a\00y\00.\00t\00s")
 (data $11 (i32.const 588) "<")
 (data $11.1 (i32.const 600) "\02\00\00\00 \00\00\00~\00l\00i\00b\00/\00d\00a\00t\00a\00v\00i\00e\00w\00.\00t\00s")
 (data $12 (i32.const 652) "<")
 (data $12.1 (i32.const 664) "\02\00\00\00\1e\00\00\00s\00t\00d\00/\00d\00a\00t\00a\00v\00i\00e\00w\00.\00t\00s")
 (data $13 (i32.const 720) "\07\00\00\00 \00\00\00 \00\00\00 \00\00\00\00\00\00\00A\00\00\00 ")
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
     i32.const 208
     i32.const 159
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
    i32.const 208
    i32.const 147
    i32.const 30
    call $~lib/builtins/abort
    unreachable
   end
   global.set $~lib/rt/itcms/iter
  end
  block $__inlined_func$~lib/rt/itcms/Object#unlink$136
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
    i32.const 33520
    i32.lt_u
    i32.and
    i32.eqz
    if
     i32.const 0
     i32.const 208
     i32.const 127
     i32.const 18
     call $~lib/builtins/abort
     unreachable
    end
    br $__inlined_func$~lib/rt/itcms/Object#unlink$136
   end
   local.get $0
   i32.load offset=8
   local.tee $1
   i32.eqz
   if
    i32.const 0
    i32.const 208
    i32.const 131
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
   i32.const 720
   i32.load
   i32.gt_u
   if
    i32.const 336
    i32.const 400
    i32.const 22
    i32.const 28
    call $~lib/builtins/abort
    unreachable
   end
   local.get $0
   i32.const 2
   i32.shl
   i32.const 724
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
   i32.const 480
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
   i32.const 480
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
   i32.const 480
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
   i32.const 480
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
   i32.const 480
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
    i32.const 480
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
   i32.const 480
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
   i32.const 480
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
   i32.const 480
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
    i32.const 480
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
     i32.const 480
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
     i32.const 480
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
  i32.const 33520
  i32.const 0
  i32.store
  i32.const 35088
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
    i32.const 33520
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
      i32.const 33520
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
  i32.const 33520
  i32.const 35092
  memory.size
  i64.extend_i32_s
  i64.const 16
  i64.shl
  call $~lib/rt/tlsf/addMemory
  i32.const 33520
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
      i32.const 33520
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
     i32.const 208
     i32.const 229
     i32.const 20
     call $~lib/builtins/abort
     unreachable
    end
    local.get $0
    i32.const 33520
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
     i32.const 33520
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
       i32.const 480
       i32.const 532
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
   i32.const 480
   i32.const 309
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
     i32.const 480
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
   i32.const 144
   i32.const 208
   i32.const 262
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
   i32.const 144
   i32.const 480
   i32.const 435
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
    i32.const 480
    i32.const 472
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
   i32.const 480
   i32.const 474
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
   i32.const 480
   i32.const 336
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
 (func $~lib/arraybuffer/ArrayBufferView#set:buffer (param $0 i32) (param $1 i32)
  local.get $0
  local.get $1
  i32.store
  local.get $1
  if
   local.get $0
   i32.eqz
   if
    i32.const 0
    i32.const 208
    i32.const 296
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
 (func $~lib/typedarray/Uint8Array#__set (param $0 i32) (param $1 i32) (param $2 i32)
  local.get $1
  local.get $0
  i32.load offset=8
  i32.ge_u
  if
   i32.const 336
   i32.const 544
   i32.const 193
   i32.const 45
   call $~lib/builtins/abort
   unreachable
  end
  local.get $1
  local.get $0
  i32.load offset=4
  i32.add
  local.get $2
  i32.store8
 )
 (func $~lib/dataview/DataView#constructor (param $0 i32) (param $1 i32) (param $2 i32) (result i32)
  (local $3 i32)
  i32.const 12
  i32.const 6
  call $~lib/rt/itcms/__new
  local.set $3
  local.get $0
  i32.const 20
  i32.sub
  i32.load offset=16
  local.get $1
  local.get $2
  i32.add
  i32.lt_u
  local.get $2
  i32.const 1073741820
  i32.gt_u
  i32.or
  if
   i32.const 32
   i32.const 608
   i32.const 20
   i32.const 7
   call $~lib/builtins/abort
   unreachable
  end
  local.get $3
  local.get $0
  call $~lib/arraybuffer/ArrayBufferView#set:buffer
  local.get $3
  local.get $0
  local.get $1
  i32.add
  i32.store offset=4
  local.get $3
  local.get $2
  i32.store offset=8
  local.get $3
 )
 (func $~lib/dataview/DataView#getFloat32 (param $0 i32) (param $1 i32) (param $2 i32) (result f32)
  local.get $1
  i32.const 31
  i32.shr_u
  local.get $0
  i32.load offset=8
  local.get $1
  i32.const 4
  i32.add
  i32.lt_s
  i32.or
  if
   i32.const 336
   i32.const 608
   i32.const 28
   i32.const 70
   call $~lib/builtins/abort
   unreachable
  end
  local.get $2
  if (result f32)
   local.get $1
   local.get $0
   i32.load offset=4
   i32.add
   f32.load
  else
   local.get $1
   local.get $0
   i32.load offset=4
   i32.add
   i32.load
   local.tee $0
   i32.const -16711936
   i32.and
   i32.const 8
   i32.rotl
   local.get $0
   i32.const 16711935
   i32.and
   i32.const 8
   i32.rotr
   i32.or
   f32.reinterpret_i32
  end
 )
 (func $~lib/dataview/DataView#getFloat64 (param $0 i32) (param $1 i32) (result f64)
  (local $2 i64)
  local.get $0
  i32.load offset=8
  i32.const 8
  i32.lt_s
  if
   i32.const 336
   i32.const 608
   i32.const 35
   i32.const 70
   call $~lib/builtins/abort
   unreachable
  end
  local.get $1
  if (result f64)
   local.get $0
   i32.load offset=4
   f64.load
  else
   local.get $0
   i32.load offset=4
   i64.load
   local.tee $2
   i64.const 8
   i64.shr_u
   i64.const 71777214294589695
   i64.and
   local.get $2
   i64.const 71777214294589695
   i64.and
   i64.const 8
   i64.shl
   i64.or
   local.tee $2
   i64.const 16
   i64.shr_u
   i64.const 281470681808895
   i64.and
   local.get $2
   i64.const 281470681808895
   i64.and
   i64.const 16
   i64.shl
   i64.or
   i64.const 32
   i64.rotr
   f64.reinterpret_i64
  end
 )
 (func $~lib/dataview/DataView#getInt8 (param $0 i32) (param $1 i32) (result i32)
  local.get $1
  local.get $0
  i32.load offset=8
  i32.ge_u
  if
   i32.const 336
   i32.const 608
   i32.const 42
   i32.const 50
   call $~lib/builtins/abort
   unreachable
  end
  local.get $1
  local.get $0
  i32.load offset=4
  i32.add
  i32.load8_s
 )
 (func $~lib/dataview/DataView#getInt16 (param $0 i32) (param $1 i32) (param $2 i32) (result i32)
  local.get $1
  i32.const 31
  i32.shr_u
  local.get $0
  i32.load offset=8
  local.get $1
  i32.const 2
  i32.add
  i32.lt_s
  i32.or
  if
   i32.const 336
   i32.const 608
   i32.const 47
   i32.const 70
   call $~lib/builtins/abort
   unreachable
  end
  local.get $1
  local.get $0
  i32.load offset=4
  i32.add
  i32.load16_s
  local.tee $0
  local.get $0
  i32.const 8
  i32.shl
  local.get $0
  i32.const 65535
  i32.and
  i32.const 8
  i32.shr_u
  i32.or
  local.get $2
  select
 )
 (func $~lib/dataview/DataView#getInt32 (param $0 i32) (param $1 i32) (param $2 i32) (result i32)
  local.get $1
  i32.const 31
  i32.shr_u
  local.get $0
  i32.load offset=8
  local.get $1
  i32.const 4
  i32.add
  i32.lt_s
  i32.or
  if
   i32.const 336
   i32.const 608
   i32.const 53
   i32.const 70
   call $~lib/builtins/abort
   unreachable
  end
  local.get $1
  local.get $0
  i32.load offset=4
  i32.add
  i32.load
  local.tee $0
  local.get $0
  i32.const -16711936
  i32.and
  i32.const 8
  i32.rotl
  local.get $0
  i32.const 16711935
  i32.and
  i32.const 8
  i32.rotr
  i32.or
  local.get $2
  select
 )
 (func $~lib/dataview/DataView#getInt64 (param $0 i32) (param $1 i32) (result i64)
  (local $2 i64)
  local.get $0
  i32.load offset=8
  i32.const 8
  i32.lt_s
  if
   i32.const 336
   i32.const 608
   i32.const 120
   i32.const 70
   call $~lib/builtins/abort
   unreachable
  end
  local.get $0
  i32.load offset=4
  i64.load
  local.set $2
  local.get $1
  if (result i64)
   local.get $2
  else
   local.get $2
   i64.const 8
   i64.shr_u
   i64.const 71777214294589695
   i64.and
   local.get $2
   i64.const 71777214294589695
   i64.and
   i64.const 8
   i64.shl
   i64.or
   local.tee $2
   i64.const 16
   i64.shr_u
   i64.const 281470681808895
   i64.and
   local.get $2
   i64.const 281470681808895
   i64.and
   i64.const 16
   i64.shl
   i64.or
   i64.const 32
   i64.rotr
  end
 )
 (func $~lib/dataview/DataView#getUint8 (param $0 i32) (param $1 i32) (result i32)
  local.get $1
  local.get $0
  i32.load offset=8
  i32.ge_u
  if
   i32.const 336
   i32.const 608
   i32.const 59
   i32.const 50
   call $~lib/builtins/abort
   unreachable
  end
  local.get $1
  local.get $0
  i32.load offset=4
  i32.add
  i32.load8_u
 )
 (func $~lib/dataview/DataView#getUint16 (param $0 i32) (param $1 i32) (param $2 i32) (result i32)
  local.get $1
  i32.const 31
  i32.shr_u
  local.get $0
  i32.load offset=8
  local.get $1
  i32.const 2
  i32.add
  i32.lt_s
  i32.or
  if
   i32.const 336
   i32.const 608
   i32.const 64
   i32.const 70
   call $~lib/builtins/abort
   unreachable
  end
  local.get $1
  local.get $0
  i32.load offset=4
  i32.add
  i32.load16_u
  local.tee $0
  local.get $0
  i32.const 8
  i32.shl
  local.get $0
  i32.const 65535
  i32.and
  i32.const 8
  i32.shr_u
  i32.or
  local.get $2
  select
 )
 (func $~lib/dataview/DataView#getUint32 (param $0 i32) (param $1 i32) (param $2 i32) (result i32)
  local.get $1
  i32.const 31
  i32.shr_u
  local.get $0
  i32.load offset=8
  local.get $1
  i32.const 4
  i32.add
  i32.lt_s
  i32.or
  if
   i32.const 336
   i32.const 608
   i32.const 70
   i32.const 70
   call $~lib/builtins/abort
   unreachable
  end
  local.get $1
  local.get $0
  i32.load offset=4
  i32.add
  i32.load
  local.tee $0
  local.get $0
  i32.const -16711936
  i32.and
  i32.const 8
  i32.rotl
  local.get $0
  i32.const 16711935
  i32.and
  i32.const 8
  i32.rotr
  i32.or
  local.get $2
  select
 )
 (func $~lib/dataview/DataView#getUint64 (param $0 i32) (param $1 i32) (result i64)
  (local $2 i64)
  local.get $0
  i32.load offset=8
  i32.const 8
  i32.lt_s
  if
   i32.const 336
   i32.const 608
   i32.const 126
   i32.const 70
   call $~lib/builtins/abort
   unreachable
  end
  local.get $0
  i32.load offset=4
  i64.load
  local.set $2
  local.get $1
  if (result i64)
   local.get $2
  else
   local.get $2
   i64.const 8
   i64.shr_u
   i64.const 71777214294589695
   i64.and
   local.get $2
   i64.const 71777214294589695
   i64.and
   i64.const 8
   i64.shl
   i64.or
   local.tee $2
   i64.const 16
   i64.shr_u
   i64.const 281470681808895
   i64.and
   local.get $2
   i64.const 281470681808895
   i64.and
   i64.const 16
   i64.shl
   i64.or
   i64.const 32
   i64.rotr
  end
 )
 (func $~lib/dataview/DataView#setFloat32 (param $0 i32) (param $1 f32) (param $2 i32)
  local.get $0
  i32.load offset=8
  i32.const 4
  i32.lt_s
  if
   i32.const 336
   i32.const 608
   i32.const 76
   i32.const 70
   call $~lib/builtins/abort
   unreachable
  end
  local.get $2
  if
   local.get $0
   i32.load offset=4
   local.get $1
   f32.store
  else
   local.get $0
   i32.load offset=4
   local.get $1
   i32.reinterpret_f32
   local.tee $0
   i32.const -16711936
   i32.and
   i32.const 8
   i32.rotl
   local.get $0
   i32.const 16711935
   i32.and
   i32.const 8
   i32.rotr
   i32.or
   i32.store
  end
 )
 (func $~lib/dataview/DataView#setFloat64 (param $0 i32) (param $1 f64) (param $2 i32)
  (local $3 i64)
  local.get $0
  i32.load offset=8
  i32.const 8
  i32.lt_s
  if
   i32.const 336
   i32.const 608
   i32.const 82
   i32.const 70
   call $~lib/builtins/abort
   unreachable
  end
  local.get $2
  if
   local.get $0
   i32.load offset=4
   local.get $1
   f64.store
  else
   local.get $0
   i32.load offset=4
   local.get $1
   i64.reinterpret_f64
   local.tee $3
   i64.const 8
   i64.shr_u
   i64.const 71777214294589695
   i64.and
   local.get $3
   i64.const 71777214294589695
   i64.and
   i64.const 8
   i64.shl
   i64.or
   local.tee $3
   i64.const 16
   i64.shr_u
   i64.const 281470681808895
   i64.and
   local.get $3
   i64.const 281470681808895
   i64.and
   i64.const 16
   i64.shl
   i64.or
   i64.const 32
   i64.rotr
   i64.store
  end
 )
 (func $~lib/rt/__visit_members (param $0 i32)
  block $folding-inner0
   block $invalid
    block $~lib/iterator/Iterable<u8>
     block
      block $~lib/string/String
       block $~lib/arraybuffer/ArrayBuffer
        block $~lib/object/Object
         local.get $0
         i32.const 8
         i32.sub
         i32.load
         br_table $~lib/object/Object $~lib/arraybuffer/ArrayBuffer $~lib/string/String $folding-inner0 $folding-inner0 $~lib/iterator/Iterable<u8> $folding-inner0 $invalid
        end
        return
       end
       return
      end
      return
     end
     unreachable
    end
    return
   end
   unreachable
  end
  local.get $0
  i32.load
  call $~lib/rt/itcms/__visit
 )
 (func $~start
  (local $0 i32)
  (local $1 i32)
  i32.const 8
  call $~lib/rt/__decrease_sp
  memory.size
  i32.const 16
  i32.shl
  i32.const 33520
  i32.sub
  i32.const 1
  i32.shr_u
  global.set $~lib/rt/itcms/threshold
  i32.const 260
  i32.const 256
  i32.store
  i32.const 264
  i32.const 256
  i32.store
  i32.const 256
  global.set $~lib/rt/itcms/pinSpace
  i32.const 292
  i32.const 288
  i32.store
  i32.const 296
  i32.const 288
  i32.store
  i32.const 288
  global.set $~lib/rt/itcms/toSpace
  i32.const 436
  i32.const 432
  i32.store
  i32.const 440
  i32.const 432
  i32.store
  i32.const 432
  global.set $~lib/rt/itcms/fromSpace
  i32.const 4
  call $~lib/rt/__decrease_sp
  i32.const 12
  i32.const 4
  call $~lib/rt/itcms/__new
  local.set $1
  global.get $~lib/memory/__stack_pointer
  local.get $1
  i32.store align=1
  i32.const 4
  call $~lib/rt/__decrease_sp
  local.get $1
  i32.eqz
  if
   i32.const 12
   i32.const 3
   call $~lib/rt/itcms/__new
   local.set $1
   global.get $~lib/memory/__stack_pointer
   local.get $1
   i32.store align=1
  end
  local.get $1
  i32.const 8
  i32.const 1
  call $~lib/rt/itcms/__new
  local.tee $0
  call $~lib/arraybuffer/ArrayBufferView#set:buffer
  local.get $1
  local.get $0
  i32.store offset=4
  local.get $1
  i32.const 8
  i32.store offset=8
  global.get $~lib/memory/__stack_pointer
  i32.const 4
  i32.add
  global.set $~lib/memory/__stack_pointer
  global.get $~lib/memory/__stack_pointer
  i32.const 4
  i32.add
  global.set $~lib/memory/__stack_pointer
  global.get $~lib/memory/__stack_pointer
  local.get $1
  i32.store offset=4 align=1
  local.get $1
  i32.const 0
  i32.const 246
  call $~lib/typedarray/Uint8Array#__set
  local.get $1
  i32.const 1
  i32.const 224
  call $~lib/typedarray/Uint8Array#__set
  local.get $1
  i32.const 2
  i32.const 88
  call $~lib/typedarray/Uint8Array#__set
  local.get $1
  i32.const 3
  i32.const 159
  call $~lib/typedarray/Uint8Array#__set
  local.get $1
  i32.const 4
  i32.const 130
  call $~lib/typedarray/Uint8Array#__set
  local.get $1
  i32.const 5
  i32.const 101
  call $~lib/typedarray/Uint8Array#__set
  local.get $1
  i32.const 6
  i32.const 67
  call $~lib/typedarray/Uint8Array#__set
  local.get $1
  i32.const 7
  i32.const 95
  call $~lib/typedarray/Uint8Array#__set
  global.get $~lib/memory/__stack_pointer
  local.get $1
  i32.load
  local.tee $0
  i32.store align=1
  local.get $0
  local.get $1
  i32.load offset=4
  local.get $1
  i32.load
  i32.sub
  local.get $1
  i32.load offset=8
  call $~lib/dataview/DataView#constructor
  local.tee $0
  i32.const 0
  i32.const 1
  call $~lib/dataview/DataView#getFloat32
  f32.const -4.592586247781397e-20
  f32.ne
  if
   i32.const 0
   i32.const 672
   i32.const 15
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  local.get $0
  i32.const 1
  i32.const 1
  call $~lib/dataview/DataView#getFloat32
  f32.const -2.3413961970849473e-37
  f32.ne
  if
   i32.const 0
   i32.const 672
   i32.const 16
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  local.get $0
  i32.const 2
  i32.const 1
  call $~lib/dataview/DataView#getFloat32
  f32.const 77105877018631129268224
  f32.ne
  if
   i32.const 0
   i32.const 672
   i32.const 17
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  local.get $0
  i32.const 3
  i32.const 1
  call $~lib/dataview/DataView#getFloat32
  f32.const 229.51023864746094
  f32.ne
  if
   i32.const 0
   i32.const 672
   i32.const 18
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  local.get $0
  i32.const 4
  i32.const 1
  call $~lib/dataview/DataView#getFloat32
  f32.const 14079802746555334656
  f32.ne
  if
   i32.const 0
   i32.const 672
   i32.const 19
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  local.get $0
  i32.const 0
  i32.const 0
  call $~lib/dataview/DataView#getFloat32
  f32.const -2275140518817895515269171e9
  f32.ne
  if
   i32.const 0
   i32.const 672
   i32.const 21
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  local.get $0
  i32.const 1
  i32.const 0
  call $~lib/dataview/DataView#getFloat32
  f32.const -62437351080004157440
  f32.ne
  if
   i32.const 0
   i32.const 672
   i32.const 22
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  local.get $0
  i32.const 2
  i32.const 0
  call $~lib/dataview/DataView#getFloat32
  f32.const 1403059112509440
  f32.ne
  if
   i32.const 0
   i32.const 672
   i32.const 23
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  local.get $0
  i32.const 3
  i32.const 0
  call $~lib/dataview/DataView#getFloat32
  f32.const -5.522466503261712e-20
  f32.ne
  if
   i32.const 0
   i32.const 672
   i32.const 24
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  local.get $0
  i32.const 4
  i32.const 0
  call $~lib/dataview/DataView#getFloat32
  f32.const -1.6843597451835358e-37
  f32.ne
  if
   i32.const 0
   i32.const 672
   i32.const 25
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  local.get $0
  i32.const 1
  call $~lib/dataview/DataView#getFloat64
  f64.const 7936550095674706383278551e126
  f64.ne
  if
   i32.const 0
   i32.const 672
   i32.const 27
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  local.get $0
  i32.const 0
  call $~lib/dataview/DataView#getFloat64
  f64.const -411777475818852546741639e241
  f64.ne
  if
   i32.const 0
   i32.const 672
   i32.const 28
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  local.get $0
  i32.const 0
  call $~lib/dataview/DataView#getInt8
  i32.const -10
  i32.ne
  if
   i32.const 0
   i32.const 672
   i32.const 30
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  local.get $0
  i32.const 1
  call $~lib/dataview/DataView#getInt8
  i32.const -32
  i32.ne
  if
   i32.const 0
   i32.const 672
   i32.const 31
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  local.get $0
  i32.const 2
  call $~lib/dataview/DataView#getInt8
  i32.const 88
  i32.ne
  if
   i32.const 0
   i32.const 672
   i32.const 32
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  local.get $0
  i32.const 3
  call $~lib/dataview/DataView#getInt8
  i32.const -97
  i32.ne
  if
   i32.const 0
   i32.const 672
   i32.const 33
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  local.get $0
  i32.const 4
  call $~lib/dataview/DataView#getInt8
  i32.const -126
  i32.ne
  if
   i32.const 0
   i32.const 672
   i32.const 34
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  local.get $0
  i32.const 5
  call $~lib/dataview/DataView#getInt8
  i32.const 101
  i32.ne
  if
   i32.const 0
   i32.const 672
   i32.const 35
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  local.get $0
  i32.const 6
  call $~lib/dataview/DataView#getInt8
  i32.const 67
  i32.ne
  if
   i32.const 0
   i32.const 672
   i32.const 36
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  local.get $0
  i32.const 7
  call $~lib/dataview/DataView#getInt8
  i32.const 95
  i32.ne
  if
   i32.const 0
   i32.const 672
   i32.const 37
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  local.get $0
  i32.const 0
  i32.const 1
  call $~lib/dataview/DataView#getInt16
  i32.const 65535
  i32.and
  i32.const 57590
  i32.ne
  if
   i32.const 0
   i32.const 672
   i32.const 39
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  local.get $0
  i32.const 1
  i32.const 1
  call $~lib/dataview/DataView#getInt16
  i32.const 65535
  i32.and
  i32.const 22752
  i32.ne
  if
   i32.const 0
   i32.const 672
   i32.const 40
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  local.get $0
  i32.const 2
  i32.const 1
  call $~lib/dataview/DataView#getInt16
  i32.const 65535
  i32.and
  i32.const 40792
  i32.ne
  if
   i32.const 0
   i32.const 672
   i32.const 41
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  local.get $0
  i32.const 3
  i32.const 1
  call $~lib/dataview/DataView#getInt16
  i32.const 65535
  i32.and
  i32.const 33439
  i32.ne
  if
   i32.const 0
   i32.const 672
   i32.const 42
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  local.get $0
  i32.const 4
  i32.const 1
  call $~lib/dataview/DataView#getInt16
  i32.const 65535
  i32.and
  i32.const 25986
  i32.ne
  if
   i32.const 0
   i32.const 672
   i32.const 43
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  local.get $0
  i32.const 5
  i32.const 1
  call $~lib/dataview/DataView#getInt16
  i32.const 65535
  i32.and
  i32.const 17253
  i32.ne
  if
   i32.const 0
   i32.const 672
   i32.const 44
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  local.get $0
  i32.const 6
  i32.const 1
  call $~lib/dataview/DataView#getInt16
  i32.const 65535
  i32.and
  i32.const 24387
  i32.ne
  if
   i32.const 0
   i32.const 672
   i32.const 45
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  local.get $0
  i32.const 0
  i32.const 0
  call $~lib/dataview/DataView#getInt16
  i32.const 65535
  i32.and
  i32.const 63200
  i32.ne
  if
   i32.const 0
   i32.const 672
   i32.const 47
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  local.get $0
  i32.const 1
  i32.const 0
  call $~lib/dataview/DataView#getInt16
  i32.const 65535
  i32.and
  i32.const 57432
  i32.ne
  if
   i32.const 0
   i32.const 672
   i32.const 48
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  local.get $0
  i32.const 2
  i32.const 0
  call $~lib/dataview/DataView#getInt16
  i32.const 65535
  i32.and
  i32.const 22687
  i32.ne
  if
   i32.const 0
   i32.const 672
   i32.const 49
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  local.get $0
  i32.const 3
  i32.const 0
  call $~lib/dataview/DataView#getInt16
  i32.const 65535
  i32.and
  i32.const 40834
  i32.ne
  if
   i32.const 0
   i32.const 672
   i32.const 50
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  local.get $0
  i32.const 4
  i32.const 0
  call $~lib/dataview/DataView#getInt16
  i32.const 65535
  i32.and
  i32.const 33381
  i32.ne
  if
   i32.const 0
   i32.const 672
   i32.const 51
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  local.get $0
  i32.const 5
  i32.const 0
  call $~lib/dataview/DataView#getInt16
  i32.const 65535
  i32.and
  i32.const 25923
  i32.ne
  if
   i32.const 0
   i32.const 672
   i32.const 52
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  local.get $0
  i32.const 6
  i32.const 0
  call $~lib/dataview/DataView#getInt16
  i32.const 65535
  i32.and
  i32.const 17247
  i32.ne
  if
   i32.const 0
   i32.const 672
   i32.const 53
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  local.get $0
  i32.const 0
  i32.const 1
  call $~lib/dataview/DataView#getInt32
  i32.const -1621565194
  i32.ne
  if
   i32.const 0
   i32.const 672
   i32.const 55
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  local.get $0
  i32.const 1
  i32.const 1
  call $~lib/dataview/DataView#getInt32
  i32.const -2103486240
  i32.ne
  if
   i32.const 0
   i32.const 672
   i32.const 56
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  local.get $0
  i32.const 2
  i32.const 1
  call $~lib/dataview/DataView#getInt32
  i32.const 1703059288
  i32.ne
  if
   i32.const 0
   i32.const 672
   i32.const 57
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  local.get $0
  i32.const 3
  i32.const 1
  call $~lib/dataview/DataView#getInt32
  i32.const 1130726047
  i32.ne
  if
   i32.const 0
   i32.const 672
   i32.const 58
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  local.get $0
  i32.const 4
  i32.const 1
  call $~lib/dataview/DataView#getInt32
  i32.const 1598252418
  i32.ne
  if
   i32.const 0
   i32.const 672
   i32.const 59
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  local.get $0
  i32.const 0
  i32.const 0
  call $~lib/dataview/DataView#getInt32
  i32.const -153069409
  i32.ne
  if
   i32.const 0
   i32.const 672
   i32.const 61
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  local.get $0
  i32.const 1
  i32.const 0
  call $~lib/dataview/DataView#getInt32
  i32.const -531062910
  i32.ne
  if
   i32.const 0
   i32.const 672
   i32.const 62
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  local.get $0
  i32.const 2
  i32.const 0
  call $~lib/dataview/DataView#getInt32
  i32.const 1486848613
  i32.ne
  if
   i32.const 0
   i32.const 672
   i32.const 63
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  local.get $0
  i32.const 3
  i32.const 0
  call $~lib/dataview/DataView#getInt32
  i32.const -1618844349
  i32.ne
  if
   i32.const 0
   i32.const 672
   i32.const 64
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  local.get $0
  i32.const 4
  i32.const 0
  call $~lib/dataview/DataView#getInt32
  i32.const -2107292833
  i32.ne
  if
   i32.const 0
   i32.const 672
   i32.const 65
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  local.get $0
  i32.const 1
  call $~lib/dataview/DataView#getInt64
  i64.const 6864441868736323830
  i64.ne
  if
   i32.const 0
   i32.const 672
   i32.const 67
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  local.get $0
  i32.const 0
  call $~lib/dataview/DataView#getInt64
  i64.const -657428103485373601
  i64.ne
  if
   i32.const 0
   i32.const 672
   i32.const 68
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  local.get $0
  i32.const 0
  call $~lib/dataview/DataView#getUint8
  i32.const 246
  i32.ne
  if
   i32.const 0
   i32.const 672
   i32.const 70
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  local.get $0
  i32.const 1
  call $~lib/dataview/DataView#getUint8
  i32.const 224
  i32.ne
  if
   i32.const 0
   i32.const 672
   i32.const 71
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  local.get $0
  i32.const 2
  call $~lib/dataview/DataView#getUint8
  i32.const 88
  i32.ne
  if
   i32.const 0
   i32.const 672
   i32.const 72
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  local.get $0
  i32.const 3
  call $~lib/dataview/DataView#getUint8
  i32.const 159
  i32.ne
  if
   i32.const 0
   i32.const 672
   i32.const 73
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  local.get $0
  i32.const 4
  call $~lib/dataview/DataView#getUint8
  i32.const 130
  i32.ne
  if
   i32.const 0
   i32.const 672
   i32.const 74
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  local.get $0
  i32.const 5
  call $~lib/dataview/DataView#getUint8
  i32.const 101
  i32.ne
  if
   i32.const 0
   i32.const 672
   i32.const 75
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  local.get $0
  i32.const 6
  call $~lib/dataview/DataView#getUint8
  i32.const 67
  i32.ne
  if
   i32.const 0
   i32.const 672
   i32.const 76
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  local.get $0
  i32.const 7
  call $~lib/dataview/DataView#getUint8
  i32.const 95
  i32.ne
  if
   i32.const 0
   i32.const 672
   i32.const 77
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  local.get $0
  i32.const 0
  i32.const 1
  call $~lib/dataview/DataView#getUint16
  i32.const 65535
  i32.and
  i32.const 57590
  i32.ne
  if
   i32.const 0
   i32.const 672
   i32.const 79
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  local.get $0
  i32.const 1
  i32.const 1
  call $~lib/dataview/DataView#getUint16
  i32.const 65535
  i32.and
  i32.const 22752
  i32.ne
  if
   i32.const 0
   i32.const 672
   i32.const 80
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  local.get $0
  i32.const 2
  i32.const 1
  call $~lib/dataview/DataView#getUint16
  i32.const 65535
  i32.and
  i32.const 40792
  i32.ne
  if
   i32.const 0
   i32.const 672
   i32.const 81
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  local.get $0
  i32.const 3
  i32.const 1
  call $~lib/dataview/DataView#getUint16
  i32.const 65535
  i32.and
  i32.const 33439
  i32.ne
  if
   i32.const 0
   i32.const 672
   i32.const 82
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  local.get $0
  i32.const 4
  i32.const 1
  call $~lib/dataview/DataView#getUint16
  i32.const 65535
  i32.and
  i32.const 25986
  i32.ne
  if
   i32.const 0
   i32.const 672
   i32.const 83
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  local.get $0
  i32.const 5
  i32.const 1
  call $~lib/dataview/DataView#getUint16
  i32.const 65535
  i32.and
  i32.const 17253
  i32.ne
  if
   i32.const 0
   i32.const 672
   i32.const 84
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  local.get $0
  i32.const 6
  i32.const 1
  call $~lib/dataview/DataView#getUint16
  i32.const 65535
  i32.and
  i32.const 24387
  i32.ne
  if
   i32.const 0
   i32.const 672
   i32.const 85
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  local.get $0
  i32.const 0
  i32.const 0
  call $~lib/dataview/DataView#getUint16
  i32.const 65535
  i32.and
  i32.const 63200
  i32.ne
  if
   i32.const 0
   i32.const 672
   i32.const 87
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  local.get $0
  i32.const 1
  i32.const 0
  call $~lib/dataview/DataView#getUint16
  i32.const 65535
  i32.and
  i32.const 57432
  i32.ne
  if
   i32.const 0
   i32.const 672
   i32.const 88
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  local.get $0
  i32.const 2
  i32.const 0
  call $~lib/dataview/DataView#getUint16
  i32.const 65535
  i32.and
  i32.const 22687
  i32.ne
  if
   i32.const 0
   i32.const 672
   i32.const 89
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  local.get $0
  i32.const 3
  i32.const 0
  call $~lib/dataview/DataView#getUint16
  i32.const 65535
  i32.and
  i32.const 40834
  i32.ne
  if
   i32.const 0
   i32.const 672
   i32.const 90
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  local.get $0
  i32.const 4
  i32.const 0
  call $~lib/dataview/DataView#getUint16
  i32.const 65535
  i32.and
  i32.const 33381
  i32.ne
  if
   i32.const 0
   i32.const 672
   i32.const 91
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  local.get $0
  i32.const 5
  i32.const 0
  call $~lib/dataview/DataView#getUint16
  i32.const 65535
  i32.and
  i32.const 25923
  i32.ne
  if
   i32.const 0
   i32.const 672
   i32.const 92
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  local.get $0
  i32.const 6
  i32.const 0
  call $~lib/dataview/DataView#getUint16
  i32.const 65535
  i32.and
  i32.const 17247
  i32.ne
  if
   i32.const 0
   i32.const 672
   i32.const 93
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  local.get $0
  i32.const 0
  i32.const 1
  call $~lib/dataview/DataView#getUint32
  i32.const -1621565194
  i32.ne
  if
   i32.const 0
   i32.const 672
   i32.const 95
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  local.get $0
  i32.const 1
  i32.const 1
  call $~lib/dataview/DataView#getUint32
  i32.const -2103486240
  i32.ne
  if
   i32.const 0
   i32.const 672
   i32.const 96
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  local.get $0
  i32.const 2
  i32.const 1
  call $~lib/dataview/DataView#getUint32
  i32.const 1703059288
  i32.ne
  if
   i32.const 0
   i32.const 672
   i32.const 97
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  local.get $0
  i32.const 3
  i32.const 1
  call $~lib/dataview/DataView#getUint32
  i32.const 1130726047
  i32.ne
  if
   i32.const 0
   i32.const 672
   i32.const 98
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  local.get $0
  i32.const 4
  i32.const 1
  call $~lib/dataview/DataView#getUint32
  i32.const 1598252418
  i32.ne
  if
   i32.const 0
   i32.const 672
   i32.const 99
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  local.get $0
  i32.const 0
  i32.const 0
  call $~lib/dataview/DataView#getUint32
  i32.const -153069409
  i32.ne
  if
   i32.const 0
   i32.const 672
   i32.const 101
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  local.get $0
  i32.const 1
  i32.const 0
  call $~lib/dataview/DataView#getUint32
  i32.const -531062910
  i32.ne
  if
   i32.const 0
   i32.const 672
   i32.const 102
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  local.get $0
  i32.const 2
  i32.const 0
  call $~lib/dataview/DataView#getUint32
  i32.const 1486848613
  i32.ne
  if
   i32.const 0
   i32.const 672
   i32.const 103
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  local.get $0
  i32.const 3
  i32.const 0
  call $~lib/dataview/DataView#getUint32
  i32.const -1618844349
  i32.ne
  if
   i32.const 0
   i32.const 672
   i32.const 104
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  local.get $0
  i32.const 4
  i32.const 0
  call $~lib/dataview/DataView#getUint32
  i32.const -2107292833
  i32.ne
  if
   i32.const 0
   i32.const 672
   i32.const 105
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  local.get $0
  i32.const 1
  call $~lib/dataview/DataView#getUint64
  i64.const 6864441868736323830
  i64.ne
  if
   i32.const 0
   i32.const 672
   i32.const 107
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  local.get $0
  i32.const 0
  call $~lib/dataview/DataView#getUint64
  i64.const -657428103485373601
  i64.ne
  if
   i32.const 0
   i32.const 672
   i32.const 108
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  local.get $0
  f32.const 1.5976661625240943e-18
  i32.const 1
  call $~lib/dataview/DataView#setFloat32
  local.get $0
  i32.const 0
  i32.const 1
  call $~lib/dataview/DataView#getFloat32
  f32.const 1.5976661625240943e-18
  f32.ne
  if
   i32.const 0
   i32.const 672
   i32.const 111
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  local.get $0
  f32.const 1976281973381696323584
  i32.const 0
  call $~lib/dataview/DataView#setFloat32
  local.get $0
  i32.const 0
  i32.const 0
  call $~lib/dataview/DataView#getFloat32
  f32.const 1976281973381696323584
  f32.ne
  if
   i32.const 0
   i32.const 672
   i32.const 114
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  local.get $0
  f64.const -1094252199637739024055454e124
  i32.const 1
  call $~lib/dataview/DataView#setFloat64
  local.get $0
  i32.const 1
  call $~lib/dataview/DataView#getFloat64
  f64.const -1094252199637739024055454e124
  f64.ne
  if
   i32.const 0
   i32.const 672
   i32.const 117
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  local.get $0
  f64.const 6.022586634778589e-103
  i32.const 0
  call $~lib/dataview/DataView#setFloat64
  local.get $0
  i32.const 0
  call $~lib/dataview/DataView#getFloat64
  f64.const 6.022586634778589e-103
  f64.ne
  if
   i32.const 0
   i32.const 672
   i32.const 120
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  local.get $0
  i32.load offset=8
  i32.eqz
  if
   i32.const 336
   i32.const 608
   i32.const 88
   i32.const 50
   call $~lib/builtins/abort
   unreachable
  end
  local.get $0
  i32.load offset=4
  i32.const 108
  i32.store8
  local.get $0
  i32.const 0
  call $~lib/dataview/DataView#getInt8
  i32.const 108
  i32.ne
  if
   i32.const 0
   i32.const 672
   i32.const 123
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  local.get $0
  i32.const -13360
  i32.const 1
  i32.const 93
  call $byn$mgfn-shared$~lib/dataview/DataView#setInt16
  local.get $0
  i32.const 0
  i32.const 1
  call $~lib/dataview/DataView#getInt16
  i32.const 65535
  i32.and
  i32.const 52176
  i32.ne
  if
   i32.const 0
   i32.const 672
   i32.const 126
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  local.get $0
  i32.const 14689
  i32.const 0
  i32.const 93
  call $byn$mgfn-shared$~lib/dataview/DataView#setInt16
  local.get $0
  i32.const 0
  i32.const 0
  call $~lib/dataview/DataView#getInt16
  i32.const 65535
  i32.and
  i32.const 14689
  i32.ne
  if
   i32.const 0
   i32.const 672
   i32.const 129
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  local.get $0
  i32.const 1204680201
  i32.const 1
  i32.const 98
  call $byn$mgfn-shared$~lib/dataview/DataView#setInt32
  local.get $0
  i32.const 0
  i32.const 1
  call $~lib/dataview/DataView#getInt32
  i32.const 1204680201
  i32.ne
  if
   i32.const 0
   i32.const 672
   i32.const 132
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  local.get $0
  i32.const 660673230
  i32.const 0
  i32.const 98
  call $byn$mgfn-shared$~lib/dataview/DataView#setInt32
  local.get $0
  i32.const 0
  i32.const 0
  call $~lib/dataview/DataView#getInt32
  i32.const 660673230
  i32.ne
  if
   i32.const 0
   i32.const 672
   i32.const 135
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  local.get $0
  i64.const -3290739641816099749
  i32.const 1
  i32.const 132
  call $byn$mgfn-shared$~lib/dataview/DataView#setInt64
  local.get $0
  i32.const 1
  call $~lib/dataview/DataView#getInt64
  i64.const -3290739641816099749
  i64.ne
  if
   i32.const 0
   i32.const 672
   i32.const 138
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  local.get $0
  i64.const 8178932412950708047
  i32.const 0
  i32.const 132
  call $byn$mgfn-shared$~lib/dataview/DataView#setInt64
  local.get $0
  i32.const 0
  call $~lib/dataview/DataView#getInt64
  i64.const 8178932412950708047
  i64.ne
  if
   i32.const 0
   i32.const 672
   i32.const 141
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  local.get $0
  i32.load offset=8
  i32.eqz
  if
   i32.const 336
   i32.const 608
   i32.const 103
   i32.const 50
   call $~lib/builtins/abort
   unreachable
  end
  local.get $0
  i32.load offset=4
  i32.const 238
  i32.store8
  local.get $0
  i32.const 0
  call $~lib/dataview/DataView#getUint8
  i32.const 238
  i32.ne
  if
   i32.const 0
   i32.const 672
   i32.const 144
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  local.get $0
  i32.const 58856
  i32.const 1
  i32.const 108
  call $byn$mgfn-shared$~lib/dataview/DataView#setInt16
  local.get $0
  i32.const 0
  i32.const 1
  call $~lib/dataview/DataView#getUint16
  i32.const 65535
  i32.and
  i32.const 58856
  i32.ne
  if
   i32.const 0
   i32.const 672
   i32.const 147
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  local.get $0
  i32.const 60400
  i32.const 0
  i32.const 108
  call $byn$mgfn-shared$~lib/dataview/DataView#setInt16
  local.get $0
  i32.const 0
  i32.const 0
  call $~lib/dataview/DataView#getUint16
  i32.const 65535
  i32.and
  i32.const 60400
  i32.ne
  if
   i32.const 0
   i32.const 672
   i32.const 150
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  local.get $0
  i32.const -846805744
  i32.const 1
  i32.const 113
  call $byn$mgfn-shared$~lib/dataview/DataView#setInt32
  local.get $0
  i32.const 0
  i32.const 1
  call $~lib/dataview/DataView#getUint32
  i32.const -846805744
  i32.ne
  if
   i32.const 0
   i32.const 672
   i32.const 153
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  local.get $0
  i32.const -1510791631
  i32.const 0
  i32.const 113
  call $byn$mgfn-shared$~lib/dataview/DataView#setInt32
  local.get $0
  i32.const 0
  i32.const 0
  call $~lib/dataview/DataView#getUint32
  i32.const -1510791631
  i32.ne
  if
   i32.const 0
   i32.const 672
   i32.const 156
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  local.get $0
  i64.const 2334704782995986958
  i32.const 1
  i32.const 137
  call $byn$mgfn-shared$~lib/dataview/DataView#setInt64
  local.get $0
  i32.const 1
  call $~lib/dataview/DataView#getUint64
  i64.const 2334704782995986958
  i64.ne
  if
   i32.const 0
   i32.const 672
   i32.const 159
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  local.get $0
  i64.const -7123186897289856329
  i32.const 0
  i32.const 137
  call $byn$mgfn-shared$~lib/dataview/DataView#setInt64
  local.get $0
  i32.const 0
  call $~lib/dataview/DataView#getUint64
  i64.const -7123186897289856329
  i64.ne
  if
   i32.const 0
   i32.const 672
   i32.const 162
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  global.get $~lib/memory/__stack_pointer
  local.get $1
  i32.load
  local.tee $0
  i32.store align=1
  local.get $0
  i32.const 0
  local.get $0
  i32.const 20
  i32.sub
  i32.load offset=16
  call $~lib/dataview/DataView#constructor
  local.tee $0
  i32.load offset=4
  local.get $0
  i32.load
  i32.sub
  if
   i32.const 0
   i32.const 672
   i32.const 165
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  local.get $0
  i32.load offset=8
  i32.const 8
  i32.ne
  if
   i32.const 0
   i32.const 672
   i32.const 166
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  i32.const 33520
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
  global.get $~lib/memory/__stack_pointer
  i32.const 8
  i32.add
  global.set $~lib/memory/__stack_pointer
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
  i32.const 752
  i32.lt_s
  if
   unreachable
  end
 )
 (func $byn$mgfn-shared$~lib/dataview/DataView#setInt16 (param $0 i32) (param $1 i32) (param $2 i32) (param $3 i32)
  local.get $0
  i32.load offset=8
  i32.const 2
  i32.lt_s
  if
   i32.const 336
   i32.const 608
   local.get $3
   i32.const 70
   call $~lib/builtins/abort
   unreachable
  end
  local.get $0
  i32.load offset=4
  local.get $1
  local.get $1
  i32.const 8
  i32.shl
  local.get $1
  i32.const 65535
  i32.and
  i32.const 8
  i32.shr_u
  i32.or
  local.get $2
  select
  i32.store16
 )
 (func $byn$mgfn-shared$~lib/dataview/DataView#setInt32 (param $0 i32) (param $1 i32) (param $2 i32) (param $3 i32)
  local.get $0
  i32.load offset=8
  i32.const 4
  i32.lt_s
  if
   i32.const 336
   i32.const 608
   local.get $3
   i32.const 70
   call $~lib/builtins/abort
   unreachable
  end
  local.get $0
  i32.load offset=4
  local.get $1
  local.get $1
  i32.const -16711936
  i32.and
  i32.const 8
  i32.rotl
  local.get $1
  i32.const 16711935
  i32.and
  i32.const 8
  i32.rotr
  i32.or
  local.get $2
  select
  i32.store
 )
 (func $byn$mgfn-shared$~lib/dataview/DataView#setInt64 (param $0 i32) (param $1 i64) (param $2 i32) (param $3 i32)
  local.get $0
  i32.load offset=8
  i32.const 8
  i32.lt_s
  if
   i32.const 336
   i32.const 608
   local.get $3
   i32.const 70
   call $~lib/builtins/abort
   unreachable
  end
  local.get $0
  i32.load offset=4
  local.get $2
  if (result i64)
   local.get $1
  else
   local.get $1
   i64.const 8
   i64.shr_u
   i64.const 71777214294589695
   i64.and
   local.get $1
   i64.const 71777214294589695
   i64.and
   i64.const 8
   i64.shl
   i64.or
   local.tee $1
   i64.const 16
   i64.shr_u
   i64.const 281470681808895
   i64.and
   local.get $1
   i64.const 281470681808895
   i64.and
   i64.const 16
   i64.shl
   i64.or
   i64.const 32
   i64.rotr
  end
  i64.store
 )
)
