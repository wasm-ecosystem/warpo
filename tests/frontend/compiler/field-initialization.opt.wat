(module
 (type $0 (func))
 (type $1 (func (param i32 i32)))
 (type $2 (func (param i32)))
 (type $3 (func (param i32 i32) (result i32)))
 (type $4 (func (param i32) (result i32)))
 (type $5 (func (param i32 i32 i32 i32)))
 (type $6 (func (param i32 i32 i32)))
 (type $7 (func (param i32 i32 i64)))
 (import "env" "abort" (func $~lib/builtins/abort (param i32 i32 i32 i32)))
 (global $~lib/memory/__stack_pointer (mut i32) (i32.const 33644))
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
 (data $8 (i32.const 412) "L")
 (data $8.1 (i32.const 424) "\02\00\00\00.\00\00\00f\00i\00e\00l\00d\00-\00i\00n\00i\00t\00i\00a\00l\00i\00z\00a\00t\00i\00o\00n\00.\00t\00s")
 (data $9 (i32.const 492) ",")
 (data $9.1 (i32.const 504) "\02\00\00\00\1c\00\00\00I\00n\00v\00a\00l\00i\00d\00 \00l\00e\00n\00g\00t\00h")
 (data $10 (i32.const 540) "<")
 (data $10.1 (i32.const 552) "\02\00\00\00&\00\00\00~\00l\00i\00b\00/\00a\00r\00r\00a\00y\00b\00u\00f\00f\00e\00r\00.\00t\00s")
 (data $11 (i32.const 604) "\1c")
 (data $11.1 (i32.const 616) "\02\00\00\00\02\00\00\00b")
 (data $12 (i32.const 636) "\1c")
 (data $12.1 (i32.const 648) "\02\00\00\00\04\00\00\00b\00b")
 (data $13 (i32.const 668) "\1c")
 (data $13.1 (i32.const 680) "\02\00\00\00\02\00\00\00c")
 (data $14 (i32.const 700) "\1c")
 (data $14.1 (i32.const 712) "\02\00\00\00\06\00\00\00b\00b\00b")
 (data $15 (i32.const 732) "\1c")
 (data $15.1 (i32.const 744) "\02\00\00\00\04\00\00\00c\00c")
 (data $16 (i32.const 768) "\1a\00\00\00 \00\00\00 \00\00\00 \00\00\00\00\00\00\00 \00\00\00 ")
 (data $16.1 (i32.const 808) " \00\00\00 \00\00\00 ")
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
    i32.const 96
    i32.const 147
    i32.const 30
    call $~lib/builtins/abort
    unreachable
   end
   global.set $~lib/rt/itcms/iter
  end
  block $__inlined_func$~lib/rt/itcms/Object#unlink$133
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
    i32.const 33644
    i32.lt_u
    i32.and
    i32.eqz
    if
     i32.const 0
     i32.const 96
     i32.const 127
     i32.const 18
     call $~lib/builtins/abort
     unreachable
    end
    br $__inlined_func$~lib/rt/itcms/Object#unlink$133
   end
   local.get $0
   i32.load offset=8
   local.tee $1
   i32.eqz
   if
    i32.const 0
    i32.const 96
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
   i32.const 768
   i32.load
   i32.gt_u
   if
    i32.const 224
    i32.const 288
    i32.const 22
    i32.const 28
    call $~lib/builtins/abort
    unreachable
   end
   local.get $0
   i32.const 2
   i32.shl
   i32.const 772
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
   i32.const 368
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
   i32.const 368
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
   i32.const 368
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
   i32.const 368
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
    i32.const 368
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
   i32.const 368
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
   i32.const 368
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
   i32.const 368
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
    i32.const 368
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
     i32.const 368
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
     i32.const 368
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
  i32.const 33648
  i32.const 0
  i32.store
  i32.const 35216
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
    i32.const 33648
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
      i32.const 33648
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
  i32.const 33648
  i32.const 35220
  memory.size
  i64.extend_i32_s
  i64.const 16
  i64.shl
  call $~lib/rt/tlsf/addMemory
  i32.const 33648
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
   i32.const 368
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
     i32.const 368
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
   i32.const 32
   i32.const 96
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
    local.set $2
    loop $do-loop|0
     local.get $2
     block $__inlined_func$~lib/rt/itcms/step$138 (result i32)
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
         br $__inlined_func$~lib/rt/itcms/step$138
        end
        global.get $~lib/rt/itcms/white
        i32.eqz
        local.set $4
        global.get $~lib/rt/itcms/iter
        i32.load offset=4
        i32.const -4
        i32.and
        local.set $2
        loop $while-continue|1
         local.get $2
         global.get $~lib/rt/itcms/toSpace
         i32.ne
         if
          local.get $2
          global.set $~lib/rt/itcms/iter
          local.get $4
          local.get $2
          i32.load offset=4
          i32.const 3
          i32.and
          i32.ne
          if
           local.get $2
           local.get $2
           i32.load offset=4
           i32.const -4
           i32.and
           local.get $4
           i32.or
           i32.store offset=4
           i32.const 0
           global.set $~lib/rt/itcms/visitCount
           local.get $2
           i32.const 20
           i32.add
           call $~lib/rt/__visit_members
           global.get $~lib/rt/itcms/visitCount
           br $__inlined_func$~lib/rt/itcms/step$138
          end
          local.get $2
          i32.load offset=4
          i32.const -4
          i32.and
          local.set $2
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
         local.set $2
         loop $while-continue|0
          local.get $2
          i32.const 33644
          i32.lt_u
          if
           local.get $2
           i32.load
           call $~lib/rt/itcms/__visit
           local.get $2
           i32.const 4
           i32.add
           local.set $2
           br $while-continue|0
          end
         end
         global.get $~lib/rt/itcms/iter
         i32.load offset=4
         i32.const -4
         i32.and
         local.set $2
         loop $while-continue|2
          local.get $2
          global.get $~lib/rt/itcms/toSpace
          i32.ne
          if
           local.get $4
           local.get $2
           i32.load offset=4
           i32.const 3
           i32.and
           i32.ne
           if
            local.get $2
            local.get $2
            i32.load offset=4
            i32.const -4
            i32.and
            local.get $4
            i32.or
            i32.store offset=4
            local.get $2
            i32.const 20
            i32.add
            call $~lib/rt/__visit_members
           end
           local.get $2
           i32.load offset=4
           i32.const -4
           i32.and
           local.set $2
           br $while-continue|2
          end
         end
         global.get $~lib/rt/itcms/fromSpace
         local.set $3
         global.get $~lib/rt/itcms/toSpace
         global.set $~lib/rt/itcms/fromSpace
         local.get $3
         global.set $~lib/rt/itcms/toSpace
         local.get $4
         global.set $~lib/rt/itcms/white
         local.get $3
         i32.load offset=4
         i32.const -4
         i32.and
         global.set $~lib/rt/itcms/iter
         i32.const 2
         global.set $~lib/rt/itcms/state
        end
        global.get $~lib/rt/itcms/visitCount
        br $__inlined_func$~lib/rt/itcms/step$138
       end
       global.get $~lib/rt/itcms/iter
       local.tee $3
       global.get $~lib/rt/itcms/toSpace
       i32.ne
       if
        local.get $3
        i32.load offset=4
        i32.const -4
        i32.and
        global.set $~lib/rt/itcms/iter
        global.get $~lib/rt/itcms/white
        i32.eqz
        local.get $3
        i32.load offset=4
        i32.const 3
        i32.and
        i32.ne
        if
         i32.const 0
         i32.const 96
         i32.const 229
         i32.const 20
         call $~lib/builtins/abort
         unreachable
        end
        local.get $3
        i32.const 33644
        i32.lt_u
        if
         local.get $3
         i32.const 0
         i32.store offset=4
         local.get $3
         i32.const 0
         i32.store offset=8
        else
         global.get $~lib/rt/itcms/total
         local.get $3
         i32.load
         i32.const -4
         i32.and
         i32.const 4
         i32.add
         i32.sub
         global.set $~lib/rt/itcms/total
         local.get $3
         i32.const 4
         i32.add
         local.tee $2
         i32.const 33644
         i32.ge_u
         if
          global.get $~lib/rt/tlsf/ROOT
          i32.eqz
          if
           call $~lib/rt/tlsf/initialize
          end
          global.get $~lib/rt/tlsf/ROOT
          local.set $3
          local.get $2
          i32.const 4
          i32.sub
          local.set $4
          local.get $2
          i32.const 15
          i32.and
          i32.const 1
          local.get $2
          select
          if (result i32)
           i32.const 1
          else
           local.get $4
           i32.load
           i32.const 1
           i32.and
          end
          if
           i32.const 0
           i32.const 368
           i32.const 532
           i32.const 3
           call $~lib/builtins/abort
           unreachable
          end
          local.get $4
          local.get $4
          i32.load
          i32.const 1
          i32.or
          i32.store
          local.get $3
          local.get $4
          call $~lib/rt/tlsf/insertBlock
         end
        end
        i32.const 10
        br $__inlined_func$~lib/rt/itcms/step$138
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
     end
     i32.sub
     local.set $2
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
     local.get $2
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
    i32.const 368
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
   i32.const 368
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
   i32.const 368
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
 (func $~lib/object/Object#constructor (param $0 i32) (result i32)
  local.get $0
  if (result i32)
   local.get $0
  else
   i32.const 0
   i32.const 0
   call $~lib/rt/itcms/__new
  end
 )
 (func $~lib/rt/itcms/__link (param $0 i32) (param $1 i32)
  local.get $1
  if
   local.get $0
   i32.eqz
   if
    i32.const 0
    i32.const 96
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
 (func $field-initialization/Ref_Init#set:a (param $0 i32) (param $1 i32)
  local.get $0
  local.get $1
  i32.store
  local.get $0
  local.get $1
  call $~lib/rt/itcms/__link
 )
 (func $field-initialization/Inherit_Base#constructor (param $0 i32) (result i32)
  call $~lib/rt/__decrease_sp
  local.get $0
  i32.eqz
  if
   i32.const 4
   i32.const 19
   call $~lib/rt/itcms/__new
   local.set $0
   global.get $~lib/memory/__stack_pointer
   local.get $0
   i32.store align=1
  end
  local.get $0
  call $~lib/object/Object#constructor
  local.set $0
  global.get $~lib/memory/__stack_pointer
  local.get $0
  i32.store align=1
  local.get $0
  i32.const 0
  i32.const 1
  call $~lib/rt/itcms/__new
  call $field-initialization/Ref_Init#set:a
  global.get $~lib/memory/__stack_pointer
  i32.const 4
  i32.add
  global.set $~lib/memory/__stack_pointer
  local.get $0
 )
 (func $field-initialization/SomeObject#constructor (param $0 i32) (result i32)
  call $~lib/rt/__decrease_sp
  local.get $0
  i32.eqz
  if
   i32.const 8
   i32.const 21
   call $~lib/rt/itcms/__new
   local.set $0
   global.get $~lib/memory/__stack_pointer
   local.get $0
   i32.store align=1
  end
  local.get $0
  call $~lib/object/Object#constructor
  local.set $0
  global.get $~lib/memory/__stack_pointer
  i32.const 4
  i32.add
  global.set $~lib/memory/__stack_pointer
  local.get $0
 )
 (func $~lib/string/String.__eq (param $0 i32) (param $1 i32) (result i32)
  (local $2 i32)
  (local $3 i32)
  (local $4 i32)
  local.get $0
  local.get $1
  i32.eq
  if
   i32.const 1
   return
  end
  local.get $1
  i32.eqz
  local.get $0
  i32.eqz
  i32.or
  if
   i32.const 0
   return
  end
  local.get $0
  i32.const 20
  i32.sub
  i32.load offset=16
  i32.const 1
  i32.shr_u
  local.tee $3
  local.get $1
  i32.const 20
  i32.sub
  i32.load offset=16
  i32.const 1
  i32.shr_u
  i32.ne
  if
   i32.const 0
   return
  end
  block $__inlined_func$~lib/util/string/compareImpl$76 (result i32)
   local.get $0
   local.tee $2
   i32.const 7
   i32.and
   local.get $1
   i32.const 7
   i32.and
   i32.or
   i32.eqz
   local.get $3
   local.tee $0
   i32.const 4
   i32.ge_u
   i32.and
   if
    loop $do-loop|0
     local.get $2
     i64.load
     local.get $1
     i64.load
     i64.eq
     if
      local.get $2
      i32.const 8
      i32.add
      local.set $2
      local.get $1
      i32.const 8
      i32.add
      local.set $1
      local.get $0
      i32.const 4
      i32.sub
      local.tee $0
      i32.const 4
      i32.ge_u
      br_if $do-loop|0
     end
    end
   end
   loop $while-continue|1
    local.get $0
    local.tee $3
    i32.const 1
    i32.sub
    local.set $0
    local.get $3
    if
     local.get $2
     i32.load16_u
     local.tee $3
     local.get $1
     i32.load16_u
     local.tee $4
     i32.ne
     if
      local.get $3
      local.get $4
      i32.sub
      br $__inlined_func$~lib/util/string/compareImpl$76
     end
     local.get $2
     i32.const 2
     i32.add
     local.set $2
     local.get $1
     i32.const 2
     i32.add
     local.set $1
     br $while-continue|1
    end
   end
   i32.const 0
  end
  i32.eqz
 )
 (func $~lib/rt/__visit_members (param $0 i32)
  block $folding-inner0
   block $invalid
    block $field-initialization/SomeOtherObject
     block $field-initialization/SomeObject
      block $field-initialization/Inherit_Ctor
       block $field-initialization/Inherit
        block $field-initialization/Value_Ctor_Init
         block $field-initialization/Value_Init_Ctor
          block $field-initialization/Value_Ctor
           block $field-initialization/Value
            block $field-initialization/Value_Init
             block $~lib/string/String
              block $~lib/arraybuffer/ArrayBuffer
               block $~lib/object/Object
                local.get $0
                i32.const 8
                i32.sub
                i32.load
                br_table $~lib/object/Object $~lib/arraybuffer/ArrayBuffer $~lib/string/String $folding-inner0 $field-initialization/Value_Init $field-initialization/Value $folding-inner0 $folding-inner0 $folding-inner0 $field-initialization/Value_Ctor $field-initialization/Value_Init_Ctor $field-initialization/Value_Ctor_Init $folding-inner0 $folding-inner0 $folding-inner0 $folding-inner0 $folding-inner0 $folding-inner0 $field-initialization/Inherit $folding-inner0 $field-initialization/Inherit_Ctor $field-initialization/SomeObject $field-initialization/SomeOtherObject $folding-inner0 $folding-inner0 $folding-inner0 $invalid
               end
               return
              end
              return
             end
             return
            end
            return
           end
           return
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
      local.get $0
      i32.load
      call $~lib/rt/itcms/__visit
      return
     end
     local.get $0
     i32.load offset=4
     call $~lib/rt/itcms/__visit
     return
    end
    local.get $0
    i32.load offset=4
    call $~lib/rt/itcms/__visit
    local.get $0
    i32.load offset=8
    call $~lib/rt/itcms/__visit
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
  memory.size
  i32.const 16
  i32.shl
  i32.const 33644
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
  call $~lib/rt/__decrease_sp
  i32.const 4
  i32.const 4
  call $~lib/rt/itcms/__new
  local.set $0
  global.get $~lib/memory/__stack_pointer
  local.get $0
  i32.store align=1
  local.get $0
  call $~lib/object/Object#constructor
  local.tee $0
  i32.const 1
  i32.store
  global.get $~lib/memory/__stack_pointer
  i32.const 4
  i32.add
  global.set $~lib/memory/__stack_pointer
  local.get $0
  i32.load
  i32.const 1
  i32.ne
  if
   i32.const 0
   i32.const 432
   i32.const 8
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  call $~lib/rt/__decrease_sp
  i32.const 4
  i32.const 5
  call $~lib/rt/itcms/__new
  local.set $0
  global.get $~lib/memory/__stack_pointer
  local.get $0
  i32.store align=1
  local.get $0
  call $~lib/object/Object#constructor
  local.set $0
  global.get $~lib/memory/__stack_pointer
  i32.const 4
  i32.add
  global.set $~lib/memory/__stack_pointer
  local.get $0
  i32.load
  if
   i32.const 0
   i32.const 432
   i32.const 16
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  call $~lib/rt/__decrease_sp
  i32.const 4
  i32.const 6
  call $~lib/rt/itcms/__new
  local.set $0
  global.get $~lib/memory/__stack_pointer
  local.get $0
  i32.store align=1
  local.get $0
  call $~lib/object/Object#constructor
  local.set $0
  global.get $~lib/memory/__stack_pointer
  local.get $0
  i32.store align=1
  local.get $0
  i32.const 0
  i32.const 1
  call $~lib/rt/itcms/__new
  call $field-initialization/Ref_Init#set:a
  global.get $~lib/memory/__stack_pointer
  i32.const 4
  i32.add
  global.set $~lib/memory/__stack_pointer
  local.get $0
  i32.load
  i32.eqz
  if
   i32.const 0
   i32.const 432
   i32.const 24
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  call $~lib/rt/__decrease_sp
  i32.const 4
  i32.const 7
  call $~lib/rt/itcms/__new
  local.set $0
  global.get $~lib/memory/__stack_pointer
  local.get $0
  i32.store align=1
  local.get $0
  call $~lib/object/Object#constructor
  local.set $0
  global.get $~lib/memory/__stack_pointer
  local.get $0
  i32.store align=1
  local.get $0
  i32.const 0
  i32.const 1
  call $~lib/rt/itcms/__new
  call $field-initialization/Ref_Init#set:a
  global.get $~lib/memory/__stack_pointer
  i32.const 4
  i32.add
  global.set $~lib/memory/__stack_pointer
  local.get $0
  i32.load
  i32.eqz
  if
   i32.const 0
   i32.const 432
   i32.const 32
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  call $~lib/rt/__decrease_sp
  i32.const 4
  i32.const 8
  call $~lib/rt/itcms/__new
  local.set $0
  global.get $~lib/memory/__stack_pointer
  local.get $0
  i32.store align=1
  local.get $0
  call $~lib/object/Object#constructor
  local.set $0
  global.get $~lib/memory/__stack_pointer
  i32.const 4
  i32.add
  global.set $~lib/memory/__stack_pointer
  local.get $0
  i32.load
  if
   i32.const 0
   i32.const 432
   i32.const 40
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  i32.const 4
  i32.const 9
  call $~lib/rt/itcms/__new
  i32.load
  if
   i32.const 0
   i32.const 432
   i32.const 51
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  i32.const 4
  i32.const 10
  call $~lib/rt/itcms/__new
  local.tee $0
  i32.const 1
  i32.store
  local.get $0
  i32.load
  i32.const 1
  i32.ne
  if
   i32.const 0
   i32.const 432
   i32.const 60
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  i32.const 4
  i32.const 11
  call $~lib/rt/itcms/__new
  local.tee $0
  i32.const 1
  i32.store
  local.get $0
  i32.load
  i32.const 1
  i32.ne
  if
   i32.const 0
   i32.const 432
   i32.const 71
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  call $~lib/rt/__decrease_sp
  i32.const 4
  i32.const 12
  call $~lib/rt/itcms/__new
  local.set $0
  global.get $~lib/memory/__stack_pointer
  local.get $0
  i32.store align=1
  local.get $0
  i32.const 0
  i32.const 1
  call $~lib/rt/itcms/__new
  call $field-initialization/Ref_Init#set:a
  global.get $~lib/memory/__stack_pointer
  i32.const 4
  i32.add
  global.set $~lib/memory/__stack_pointer
  local.get $0
  i32.load
  i32.eqz
  if
   i32.const 0
   i32.const 432
   i32.const 80
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  call $~lib/rt/__decrease_sp
  i32.const 4
  i32.const 13
  call $~lib/rt/itcms/__new
  local.set $0
  global.get $~lib/memory/__stack_pointer
  local.get $0
  i32.store align=1
  local.get $0
  i32.const 0
  i32.const 1
  call $~lib/rt/itcms/__new
  call $field-initialization/Ref_Init#set:a
  global.get $~lib/memory/__stack_pointer
  i32.const 4
  i32.add
  global.set $~lib/memory/__stack_pointer
  local.get $0
  i32.load
  i32.eqz
  if
   i32.const 0
   i32.const 432
   i32.const 91
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  call $~lib/rt/__decrease_sp
  i32.const 0
  i32.const 1
  call $~lib/rt/itcms/__new
  local.set $0
  global.get $~lib/memory/__stack_pointer
  local.get $0
  i32.store align=1
  i32.const 4
  i32.const 14
  call $~lib/rt/itcms/__new
  local.tee $1
  local.get $0
  call $field-initialization/Ref_Init#set:a
  local.get $0
  local.get $1
  i32.load
  i32.ne
  if
   i32.const 0
   i32.const 432
   i32.const 102
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  i32.const 4
  i32.const 15
  call $~lib/rt/itcms/__new
  i32.load
  if
   i32.const 0
   i32.const 432
   i32.const 111
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  call $~lib/rt/__decrease_sp
  i32.const 4
  i32.const 16
  call $~lib/rt/itcms/__new
  local.set $0
  global.get $~lib/memory/__stack_pointer
  local.get $0
  i32.store align=1
  local.get $0
  i32.const 0
  i32.const 1
  call $~lib/rt/itcms/__new
  call $field-initialization/Ref_Init#set:a
  global.get $~lib/memory/__stack_pointer
  i32.const 4
  i32.add
  global.set $~lib/memory/__stack_pointer
  local.get $0
  i32.load
  i32.eqz
  if
   i32.const 0
   i32.const 432
   i32.const 120
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  call $~lib/rt/__decrease_sp
  i32.const 4
  i32.const 17
  call $~lib/rt/itcms/__new
  local.set $0
  global.get $~lib/memory/__stack_pointer
  local.get $0
  i32.store align=1
  local.get $0
  i32.const 0
  i32.const 1
  call $~lib/rt/itcms/__new
  call $field-initialization/Ref_Init#set:a
  global.get $~lib/memory/__stack_pointer
  i32.const 4
  i32.add
  global.set $~lib/memory/__stack_pointer
  local.get $0
  i32.load
  i32.eqz
  if
   i32.const 0
   i32.const 432
   i32.const 131
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  call $~lib/rt/__decrease_sp
  i32.const 4
  i32.const 18
  call $~lib/rt/itcms/__new
  local.set $0
  global.get $~lib/memory/__stack_pointer
  local.get $0
  i32.store align=1
  local.get $0
  call $field-initialization/Inherit_Base#constructor
  local.set $0
  global.get $~lib/memory/__stack_pointer
  i32.const 4
  i32.add
  global.set $~lib/memory/__stack_pointer
  local.get $0
  i32.load
  i32.eqz
  if
   i32.const 0
   i32.const 432
   i32.const 142
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  call $~lib/rt/__decrease_sp
  i32.const 4
  i32.const 20
  call $~lib/rt/itcms/__new
  local.set $0
  global.get $~lib/memory/__stack_pointer
  local.get $0
  i32.store align=1
  local.get $0
  call $field-initialization/Inherit_Base#constructor
  local.set $0
  global.get $~lib/memory/__stack_pointer
  i32.const 4
  i32.add
  global.set $~lib/memory/__stack_pointer
  local.get $0
  i32.load
  i32.eqz
  if
   i32.const 0
   i32.const 432
   i32.const 147
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  i32.const 0
  call $field-initialization/SomeObject#constructor
  local.tee $0
  i32.const 0
  i32.store
  local.get $0
  i32.const 0
  i32.store offset=4
  local.get $0
  i32.load
  if
   i32.const 0
   i32.const 432
   i32.const 158
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  local.get $0
  i32.load offset=4
  i32.const 0
  call $~lib/string/String.__eq
  i32.eqz
  if
   i32.const 0
   i32.const 432
   i32.const 159
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  i32.const 0
  call $field-initialization/SomeObject#constructor
  local.tee $0
  i32.const 1
  i32.store
  local.get $0
  i32.const 0
  i32.store offset=4
  local.get $0
  i32.load
  i32.const 1
  i32.ne
  if
   i32.const 0
   i32.const 432
   i32.const 161
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  local.get $0
  i32.load offset=4
  i32.const 0
  call $~lib/string/String.__eq
  i32.eqz
  if
   i32.const 0
   i32.const 432
   i32.const 162
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  i32.const 0
  call $field-initialization/SomeObject#constructor
  local.tee $0
  i32.const 624
  i32.store offset=4
  local.get $0
  i32.const 624
  call $~lib/rt/itcms/__link
  local.get $0
  i32.const 0
  i32.store
  local.get $0
  i32.load
  if
   i32.const 0
   i32.const 432
   i32.const 164
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  local.get $0
  i32.load offset=4
  i32.const 624
  call $~lib/string/String.__eq
  i32.eqz
  if
   i32.const 0
   i32.const 432
   i32.const 165
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  i32.const 0
  call $field-initialization/SomeObject#constructor
  local.tee $0
  i32.const 2
  i32.store
  local.get $0
  i32.const 656
  i32.store offset=4
  local.get $0
  i32.const 656
  call $~lib/rt/itcms/__link
  local.get $0
  i32.load
  i32.const 2
  i32.ne
  if
   i32.const 0
   i32.const 432
   i32.const 167
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  local.get $0
  i32.load offset=4
  i32.const 656
  call $~lib/string/String.__eq
  i32.eqz
  if
   i32.const 0
   i32.const 432
   i32.const 168
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  call $~lib/rt/__decrease_sp
  i32.const 12
  i32.const 22
  call $~lib/rt/itcms/__new
  local.set $0
  global.get $~lib/memory/__stack_pointer
  local.get $0
  i32.store align=1
  local.get $0
  call $field-initialization/SomeObject#constructor
  local.set $0
  global.get $~lib/memory/__stack_pointer
  i32.const 4
  i32.add
  global.set $~lib/memory/__stack_pointer
  local.get $0
  i32.const 688
  i32.store offset=8
  local.get $0
  i32.const 688
  call $~lib/rt/itcms/__link
  local.get $0
  i32.const 0
  i32.store
  local.get $0
  i32.const 0
  i32.store offset=4
  local.get $0
  i32.load
  if
   i32.const 0
   i32.const 432
   i32.const 176
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  local.get $0
  i32.load offset=4
  i32.const 0
  call $~lib/string/String.__eq
  i32.eqz
  if
   i32.const 0
   i32.const 432
   i32.const 177
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  local.get $0
  i32.load offset=8
  i32.const 688
  call $~lib/string/String.__eq
  i32.eqz
  if
   i32.const 0
   i32.const 432
   i32.const 178
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  call $~lib/rt/__decrease_sp
  i32.const 12
  i32.const 22
  call $~lib/rt/itcms/__new
  local.set $0
  global.get $~lib/memory/__stack_pointer
  local.get $0
  i32.store align=1
  local.get $0
  call $field-initialization/SomeObject#constructor
  local.set $0
  global.get $~lib/memory/__stack_pointer
  i32.const 4
  i32.add
  global.set $~lib/memory/__stack_pointer
  local.get $0
  i32.const 3
  i32.store
  local.get $0
  i32.const 720
  i32.store offset=4
  local.get $0
  i32.const 720
  call $~lib/rt/itcms/__link
  local.get $0
  i32.const 752
  i32.store offset=8
  local.get $0
  i32.const 752
  call $~lib/rt/itcms/__link
  local.get $0
  i32.load
  i32.const 3
  i32.ne
  if
   i32.const 0
   i32.const 432
   i32.const 180
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  local.get $0
  i32.load offset=4
  i32.const 720
  call $~lib/string/String.__eq
  i32.eqz
  if
   i32.const 0
   i32.const 432
   i32.const 181
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  local.get $0
  i32.load offset=8
  i32.const 752
  call $~lib/string/String.__eq
  i32.eqz
  if
   i32.const 0
   i32.const 432
   i32.const 182
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  call $~lib/rt/__decrease_sp
  i32.const 4
  i32.const 23
  call $~lib/rt/itcms/__new
  local.set $0
  global.get $~lib/memory/__stack_pointer
  local.get $0
  i32.store align=1
  local.get $0
  i32.const 0
  i32.const 1
  call $~lib/rt/itcms/__new
  call $field-initialization/Ref_Init#set:a
  global.get $~lib/memory/__stack_pointer
  i32.const 4
  i32.add
  global.set $~lib/memory/__stack_pointer
  local.get $0
  i32.load
  i32.eqz
  if
   i32.const 0
   i32.const 432
   i32.const 199
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  i32.const 4
  i32.const 24
  call $~lib/rt/itcms/__new
  local.set $0
  global.get $~lib/memory/__stack_pointer
  local.get $0
  i32.store align=1
  local.get $0
  i32.const 0
  i32.const 1
  call $~lib/rt/itcms/__new
  call $field-initialization/Ref_Init#set:a
  local.get $0
  i32.load
  i32.eqz
  if
   i32.const 0
   i32.const 432
   i32.const 212
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  i32.const 4
  i32.const 25
  call $~lib/rt/itcms/__new
  local.set $0
  global.get $~lib/memory/__stack_pointer
  local.get $0
  i32.store align=1
  local.get $0
  i32.const 0
  i32.const 1
  call $~lib/rt/itcms/__new
  call $field-initialization/Ref_Init#set:a
  local.get $0
  i32.load
  i32.eqz
  local.set $0
  global.get $~lib/memory/__stack_pointer
  i32.const 4
  i32.add
  global.set $~lib/memory/__stack_pointer
  local.get $0
  if
   i32.const 0
   i32.const 432
   i32.const 225
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
 )
 (func $~lib/rt/__decrease_sp
  global.get $~lib/memory/__stack_pointer
  i32.const 4
  i32.sub
  global.set $~lib/memory/__stack_pointer
  global.get $~lib/memory/__stack_pointer
  i32.const 0
  i32.store align=1
  global.get $~lib/memory/__stack_pointer
  i32.const 876
  i32.lt_s
  if
   unreachable
  end
 )
)
