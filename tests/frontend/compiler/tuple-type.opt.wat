(module
 (type $0 (func (param i32 i32) (result i32)))
 (type $1 (func (param i32)))
 (type $2 (func))
 (type $3 (func (param i32 i32 i32)))
 (type $4 (func (param i32 i32)))
 (type $5 (func (param i32) (result i32)))
 (type $6 (func (param i32 i32 i32 i32)))
 (type $7 (func (param i32 i32 i64)))
 (type $8 (func (param i32 i64) (result i32)))
 (type $9 (func (param i32 i32 i32) (result i32)))
 (import "env" "abort" (func $~lib/builtins/abort (param i32 i32 i32 i32)))
 (global $~lib/memory/__stack_pointer (mut i32) (i32.const 33928))
 (global $tuple-type/disableScriptMode i32 (i32.const 1))
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
 (data $8 (i32.const 412) "\1c")
 (data $8.1 (i32.const 424) "\02\00\00\00\02\00\00\002")
 (data $9 (i32.const 444) ",")
 (data $9.1 (i32.const 456) "\02\00\00\00\1a\00\00\00t\00u\00p\00l\00e\00-\00t\00y\00p\00e\00.\00t\00s")
 (data $10 (i32.const 492) "\1c")
 (data $10.1 (i32.const 504) "\02\00\00\00\02\00\00\004")
 (data $11 (i32.const 524) "\1c")
 (data $11.1 (i32.const 536) "\02\00\00\00\06\00\00\00a\00b\00c")
 (data $12 (i32.const 556) "\1c")
 (data $12.1 (i32.const 568) "\02\00\00\00\04\00\00\00z\00z")
 (data $13 (i32.const 588) "\1c")
 (data $13.1 (i32.const 600) "\02\00\00\00\02\00\00\00d")
 (data $14 (i32.const 620) "\1c")
 (data $14.1 (i32.const 632) "\02")
 (data $15 (i32.const 652) "\1c")
 (data $15.1 (i32.const 664) "\02\00\00\00\08\00\00\00a\00b\00c\00d")
 (data $16 (i32.const 684) "\1c")
 (data $16.1 (i32.const 696) "\02\00\00\00\n\00\00\00h\00e\00l\00l\00o")
 (data $17 (i32.const 716) "\1c")
 (data $17.1 (i32.const 728) "\02\00\00\00\02\00\00\00x")
 (data $18 (i32.const 748) "\1c")
 (data $18.1 (i32.const 760) "\02\00\00\00\04\00\00\00o\00k")
 (data $19 (i32.const 780) "\1c")
 (data $19.1 (i32.const 792) "\02\00\00\00\06\00\00\00y\00e\00s")
 (data $20 (i32.const 812) "\1c")
 (data $20.1 (i32.const 824) "\02\00\00\00\02\00\00\00k")
 (data $21 (i32.const 844) "\1c")
 (data $21.1 (i32.const 856) "\02\00\00\00\04\00\00\00h\00i")
 (data $22 (i32.const 876) "\1c")
 (data $22.1 (i32.const 888) "\02\00\00\00\02\00\00\00z")
 (data $23 (i32.const 908) "\1c")
 (data $23.1 (i32.const 920) "\02\00\00\00\02\00\00\00a")
 (data $24 (i32.const 940) "\1c")
 (data $24.1 (i32.const 952) "\02\00\00\00\02\00\00\00b")
 (data $25 (i32.const 972) "\1c")
 (data $25.1 (i32.const 984) "\02\00\00\00\04\00\00\00a\00b")
 (data $26 (i32.const 1004) "\1c")
 (data $26.1 (i32.const 1016) "\02\00\00\00\06\00\00\00h\00e\00y")
 (data $27 (i32.const 1036) "\1c")
 (data $27.1 (i32.const 1048) "\02\00\00\00\06\00\00\00c\00c\00c")
 (data $28 (i32.const 1068) "\1c")
 (data $28.1 (i32.const 1080) "\02\00\00\00\08\00\00\00d\00d\00d\00d")
 (data $29 (i32.const 1100) "\1c")
 (data $29.1 (i32.const 1112) "\02\00\00\00\04\00\00\00x\00y")
 (data $30 (i32.const 1136) "\05\00\00\00 \00\00\00 \00\00\00 ")
 (export "disableScriptMode" (global $tuple-type/disableScriptMode))
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
  block $__inlined_func$~lib/rt/itcms/Object#unlink$130
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
    i32.const 33928
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
    br $__inlined_func$~lib/rt/itcms/Object#unlink$130
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
   i32.const 1136
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
   i32.const 1140
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
  i32.const 33936
  i32.const 0
  i32.store
  i32.const 35504
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
    i32.const 33936
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
      i32.const 33936
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
  i32.const 33936
  i32.const 35508
  memory.size
  i64.extend_i32_s
  i64.const 16
  i64.shl
  call $~lib/rt/tlsf/addMemory
  i32.const 33936
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
     block $__inlined_func$~lib/rt/itcms/step$135 (result i32)
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
         br $__inlined_func$~lib/rt/itcms/step$135
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
           br $__inlined_func$~lib/rt/itcms/step$135
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
          i32.const 33928
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
        br $__inlined_func$~lib/rt/itcms/step$135
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
        i32.const 33928
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
         i32.const 33928
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
        br $__inlined_func$~lib/rt/itcms/step$135
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
 (func $~lib/rt/__newTuple (param $0 i32) (param $1 i64) (result i32)
  (local $2 i32)
  local.get $0
  local.get $0
  i32.const 8
  i32.add
  i32.const 4
  call $~lib/rt/itcms/__new
  local.tee $2
  i32.add
  local.get $1
  i64.store
  local.get $2
 )
 (func $~lib/tuple/SmallTuple#__set<~lib/string/String> (param $0 i32) (param $1 i32) (param $2 i32)
  local.get $0
  local.get $1
  i32.add
  local.get $2
  i32.store
  local.get $2
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
   local.get $2
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
  block $__inlined_func$~lib/util/string/compareImpl$74 (result i32)
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
      br $__inlined_func$~lib/util/string/compareImpl$74
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
 (func $tuple-type/takeTuple (param $0 i32) (result i32)
  local.get $0
  i32.load
  i32.const 0
  i32.le_s
  if
   i32.const 0
   i32.const 464
   i32.const 15
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  local.get $0
  i32.const 4
  i32.add
  i32.load
  i32.const 20
  i32.sub
  i32.load offset=16
  i32.const 1
  i32.shr_u
  i32.eqz
  if
   i32.const 0
   i32.const 464
   i32.const 16
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  local.get $0
  i32.load
 )
 (func $tuple-type/makeTuple (param $0 i32) (param $1 i32) (result i32)
  (local $2 i32)
  i32.const 8
  i64.const 2
  call $~lib/rt/__newTuple
  local.tee $2
  local.get $0
  i32.store
  local.get $2
  i32.const 4
  local.get $1
  call $~lib/tuple/SmallTuple#__set<~lib/string/String>
  local.get $2
 )
 (func $~lib/string/String.__concat (param $0 i32) (param $1 i32) (result i32)
  (local $2 i32)
  (local $3 i32)
  (local $4 i32)
  local.get $0
  i32.const 20
  i32.sub
  i32.load offset=16
  i32.const -2
  i32.and
  local.tee $3
  local.get $1
  i32.const 20
  i32.sub
  i32.load offset=16
  i32.const -2
  i32.and
  local.tee $4
  i32.add
  local.tee $2
  if (result i32)
   local.get $2
   i32.const 2
   call $~lib/rt/itcms/__new
   local.tee $2
   local.get $0
   local.get $3
   memory.copy
   local.get $2
   local.get $3
   i32.add
   local.get $1
   local.get $4
   memory.copy
   local.get $2
  else
   i32.const 640
  end
 )
 (func $tuple-type/makeTriple (param $0 i32) (param $1 i32) (param $2 i32) (result i32)
  (local $3 i32)
  i32.const 12
  i64.const 4
  call $~lib/rt/__newTuple
  local.tee $3
  local.get $0
  i32.store
  local.get $3
  i32.const 4
  i32.add
  local.get $1
  i32.store8
  local.get $3
  i32.const 8
  local.get $2
  call $~lib/tuple/SmallTuple#__set<~lib/string/String>
  local.get $3
 )
 (func $tuple-type/scoreTriple (param $0 i32) (result i32)
  local.get $0
  i32.const 4
  i32.add
  i32.load8_u
  if
   local.get $0
   i32.load
   local.get $0
   i32.const 8
   i32.add
   i32.load
   i32.const 20
   i32.sub
   i32.load offset=16
   i32.const 1
   i32.shr_u
   i32.add
   return
  end
  local.get $0
  i32.load
  local.get $0
  i32.const 8
  i32.add
  i32.load
  i32.const 20
  i32.sub
  i32.load offset=16
  i32.const 1
  i32.shr_u
  i32.sub
 )
 (func $~lib/rt/__visit_members (param $0 i32)
  (local $1 i32)
  (local $2 i32)
  (local $3 i64)
  block $invalid
   block $~lib/tuple/SmallTuple
    block $~lib/arraybuffer/ArrayBufferView
     block $~lib/string/String
      local.get $0
      i32.const 8
      i32.sub
      i32.load
      br_table $~lib/string/String $~lib/string/String $~lib/string/String $~lib/arraybuffer/ArrayBufferView $~lib/tuple/SmallTuple $invalid
     end
     return
    end
    local.get $0
    i32.load
    call $~lib/rt/itcms/__visit
    return
   end
   local.get $0
   i32.const 20
   i32.sub
   i32.load offset=16
   local.tee $1
   i32.const 8
   i32.sub
   i32.const 2
   i32.shr_u
   local.set $2
   local.get $0
   local.get $1
   i32.add
   i32.const 8
   i32.sub
   i64.load
   local.set $3
   i32.const 0
   local.set $1
   loop $for-loop|0
    local.get $1
    local.get $2
    i32.lt_u
    if
     local.get $3
     i64.const 1
     local.get $1
     i64.extend_i32_u
     i64.shl
     i64.and
     i64.const 0
     i64.ne
     if
      local.get $0
      local.get $1
      i32.const 2
      i32.shl
      i32.add
      i32.load
      call $~lib/rt/itcms/__visit
     end
     local.get $1
     i32.const 1
     i32.add
     local.set $1
     br $for-loop|0
    end
   end
   return
  end
  unreachable
 )
 (func $~start
  (local $0 i32)
  (local $1 i32)
  (local $2 i32)
  memory.size
  i32.const 16
  i32.shl
  i32.const 33928
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
  i32.const 8
  i64.const 2
  call $~lib/rt/__newTuple
  local.tee $0
  i32.const 1
  i32.store
  local.get $0
  i32.const 4
  i32.const 432
  call $~lib/tuple/SmallTuple#__set<~lib/string/String>
  local.get $0
  i32.load
  i32.const 1
  i32.ne
  if
   i32.const 0
   i32.const 464
   i32.const 5
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  local.get $0
  i32.const 4
  i32.add
  i32.load
  i32.const 432
  call $~lib/string/String.__eq
  i32.eqz
  if
   i32.const 0
   i32.const 464
   i32.const 6
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  local.get $0
  i32.const 3
  i32.store
  local.get $0
  i32.const 4
  i32.const 512
  call $~lib/tuple/SmallTuple#__set<~lib/string/String>
  local.get $0
  i32.load
  i32.const 3
  i32.ne
  if
   i32.const 0
   i32.const 464
   i32.const 10
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  local.get $0
  i32.const 4
  i32.add
  i32.load
  i32.const 512
  call $~lib/string/String.__eq
  i32.eqz
  if
   i32.const 0
   i32.const 464
   i32.const 11
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  i32.const 4
  call $~lib/rt/__decrease_sp
  i32.const 8
  i64.const 2
  call $~lib/rt/__newTuple
  local.tee $0
  i32.const 7
  i32.store
  local.get $0
  i32.const 4
  i32.const 544
  call $~lib/tuple/SmallTuple#__set<~lib/string/String>
  global.get $~lib/memory/__stack_pointer
  local.get $0
  i32.store align=1
  local.get $0
  call $tuple-type/takeTuple
  i32.const 7
  i32.ne
  if
   i32.const 0
   i32.const 464
   i32.const 30
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  i32.const 9
  i32.const 576
  call $tuple-type/makeTuple
  local.tee $1
  i32.load
  i32.const 9
  i32.ne
  if
   i32.const 0
   i32.const 464
   i32.const 33
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  local.get $1
  i32.const 4
  i32.add
  i32.load
  i32.const 576
  call $~lib/string/String.__eq
  i32.eqz
  if
   i32.const 0
   i32.const 464
   i32.const 34
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  local.get $0
  i32.load
  i32.const 1
  i32.add
  global.get $~lib/memory/__stack_pointer
  local.get $0
  i32.const 4
  i32.add
  i32.load
  local.tee $0
  i32.store align=1
  local.get $0
  i32.const 608
  call $~lib/string/String.__concat
  local.set $0
  global.get $~lib/memory/__stack_pointer
  local.get $0
  i32.store align=1
  local.get $0
  call $tuple-type/makeTuple
  local.tee $0
  i32.load
  i32.const 8
  i32.ne
  if
   i32.const 0
   i32.const 464
   i32.const 37
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  local.get $0
  i32.const 4
  i32.add
  i32.load
  i32.const 672
  call $~lib/string/String.__eq
  i32.eqz
  if
   i32.const 0
   i32.const 464
   i32.const 38
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  global.get $~lib/memory/__stack_pointer
  i32.const 4
  i32.add
  global.set $~lib/memory/__stack_pointer
  i32.const 8
  i64.const 2
  call $~lib/rt/__newTuple
  local.tee $0
  i32.const 5
  i32.store
  local.get $0
  i32.const 4
  i32.const 704
  call $~lib/tuple/SmallTuple#__set<~lib/string/String>
  local.get $0
  i32.load
  local.get $0
  i32.const 4
  i32.add
  i32.load
  i32.const 20
  i32.sub
  i32.load offset=16
  i32.const 1
  i32.shr_u
  i32.add
  i32.const 10
  i32.ne
  if
   i32.const 0
   i32.const 464
   i32.const 43
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  local.get $0
  i32.const 1
  i32.store
  local.get $0
  i32.const 4
  i32.const 736
  call $~lib/tuple/SmallTuple#__set<~lib/string/String>
  local.get $0
  i32.load
  local.get $0
  i32.const 4
  i32.add
  i32.load
  i32.const 20
  i32.sub
  i32.load offset=16
  i32.const 1
  i32.shr_u
  i32.add
  i32.const 2
  i32.ne
  if
   i32.const 0
   i32.const 464
   i32.const 46
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  i32.const 4
  call $~lib/rt/__decrease_sp
  i32.const 8
  i64.const 2
  call $~lib/rt/__newTuple
  local.set $0
  global.get $~lib/memory/__stack_pointer
  local.get $0
  i32.store align=1
  local.get $0
  i32.const 1
  i32.store
  i32.const 8
  i64.const 2
  call $~lib/rt/__newTuple
  local.tee $1
  i32.const 2
  i32.store
  local.get $1
  i32.const 4
  i32.const 768
  call $~lib/tuple/SmallTuple#__set<~lib/string/String>
  local.get $0
  i32.const 4
  local.get $1
  call $~lib/tuple/SmallTuple#__set<~lib/string/String>
  local.get $0
  i32.load
  i32.const 1
  i32.ne
  if
   i32.const 0
   i32.const 464
   i32.const 51
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  local.get $0
  i32.const 4
  i32.add
  i32.load
  i32.load
  i32.const 2
  i32.ne
  if
   i32.const 0
   i32.const 464
   i32.const 52
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  local.get $0
  i32.const 4
  i32.add
  i32.load
  i32.const 4
  i32.add
  i32.load
  i32.const 768
  call $~lib/string/String.__eq
  i32.eqz
  if
   i32.const 0
   i32.const 464
   i32.const 53
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  local.get $0
  i32.const 4
  i32.add
  i32.load
  i32.const 3
  i32.store
  local.get $0
  i32.const 4
  i32.add
  i32.load
  i32.const 4
  i32.const 800
  call $~lib/tuple/SmallTuple#__set<~lib/string/String>
  local.get $0
  i32.const 4
  i32.add
  i32.load
  i32.load
  i32.const 3
  i32.ne
  if
   i32.const 0
   i32.const 464
   i32.const 57
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  local.get $0
  i32.const 4
  i32.add
  i32.load
  i32.const 4
  i32.add
  i32.load
  i32.const 800
  call $~lib/string/String.__eq
  i32.eqz
  if
   i32.const 0
   i32.const 464
   i32.const 58
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  global.get $~lib/memory/__stack_pointer
  i32.const 4
  i32.add
  global.set $~lib/memory/__stack_pointer
  i32.const 8
  i64.const 2
  call $~lib/rt/__newTuple
  local.tee $0
  i32.const 11
  i32.store
  local.get $0
  i32.const 4
  i32.const 832
  call $~lib/tuple/SmallTuple#__set<~lib/string/String>
  local.get $0
  call $tuple-type/takeTuple
  i32.const 11
  i32.ne
  if
   i32.const 0
   i32.const 464
   i32.const 83
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  i32.const 4
  call $~lib/rt/__decrease_sp
  i32.const 8
  i64.const 2
  call $~lib/rt/__newTuple
  local.set $0
  global.get $~lib/memory/__stack_pointer
  local.get $0
  i32.store align=1
  local.get $0
  i32.const 1
  i32.store
  local.get $0
  i32.const 4
  i32.const 736
  call $~lib/tuple/SmallTuple#__set<~lib/string/String>
  i32.const 8
  i64.const 2
  call $~lib/rt/__newTuple
  local.tee $1
  local.get $0
  i32.load
  i32.const 4
  i32.add
  i32.store
  local.get $1
  i32.const 4
  local.get $0
  i32.const 4
  i32.add
  i32.load
  call $~lib/tuple/SmallTuple#__set<~lib/string/String>
  local.get $1
  local.tee $0
  i32.load
  i32.const 5
  i32.ne
  local.set $1
  global.get $~lib/memory/__stack_pointer
  i32.const 4
  i32.add
  global.set $~lib/memory/__stack_pointer
  local.get $1
  if
   i32.const 0
   i32.const 464
   i32.const 86
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  local.get $0
  i32.const 4
  i32.add
  i32.load
  i32.const 736
  call $~lib/string/String.__eq
  i32.eqz
  if
   i32.const 0
   i32.const 464
   i32.const 87
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  i32.const 8
  i64.const 2
  call $~lib/rt/__newTuple
  local.tee $0
  i32.const 2
  i32.store
  local.get $0
  i32.const 4
  i32.const 864
  call $~lib/tuple/SmallTuple#__set<~lib/string/String>
  local.get $0
  i32.load
  i32.const 2
  i32.ne
  if
   i32.const 0
   i32.const 464
   i32.const 93
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  local.get $0
  i32.const 4
  i32.add
  i32.load
  i32.const 864
  call $~lib/string/String.__eq
  i32.eqz
  if
   i32.const 0
   i32.const 464
   i32.const 94
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  i32.const 9
  i32.const 896
  call $tuple-type/makeTuple
  call $tuple-type/takeTuple
  i32.const 9
  i32.ne
  if
   i32.const 0
   i32.const 464
   i32.const 96
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  i32.const 8
  call $~lib/rt/__decrease_sp
  i32.const 1
  i32.const 928
  call $tuple-type/makeTuple
  local.set $1
  global.get $~lib/memory/__stack_pointer
  local.get $1
  i32.store offset=4 align=1
  i32.const 2
  i32.const 960
  call $tuple-type/makeTuple
  local.set $2
  global.get $~lib/memory/__stack_pointer
  local.get $2
  i32.store align=1
  i32.const 12
  call $~lib/rt/__decrease_sp
  i32.const 8
  i64.const 2
  call $~lib/rt/__newTuple
  local.set $0
  global.get $~lib/memory/__stack_pointer
  local.get $0
  i32.store align=1
  local.get $0
  local.get $1
  i32.load
  local.get $2
  i32.load
  i32.add
  i32.store
  global.get $~lib/memory/__stack_pointer
  local.get $1
  i32.const 4
  i32.add
  i32.load
  local.tee $1
  i32.store offset=4 align=1
  local.get $0
  i32.const 4
  local.get $1
  global.get $~lib/memory/__stack_pointer
  local.get $2
  i32.const 4
  i32.add
  i32.load
  local.tee $1
  i32.store offset=8 align=1
  local.get $1
  call $~lib/string/String.__concat
  call $~lib/tuple/SmallTuple#__set<~lib/string/String>
  global.get $~lib/memory/__stack_pointer
  i32.const 12
  i32.add
  global.set $~lib/memory/__stack_pointer
  local.get $0
  i32.load
  i32.const 3
  i32.ne
  local.set $1
  global.get $~lib/memory/__stack_pointer
  i32.const 8
  i32.add
  global.set $~lib/memory/__stack_pointer
  local.get $1
  if
   i32.const 0
   i32.const 464
   i32.const 98
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  local.get $0
  i32.const 4
  i32.add
  i32.load
  i32.const 992
  call $~lib/string/String.__eq
  i32.eqz
  if
   i32.const 0
   i32.const 464
   i32.const 99
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  i32.const 5
  i32.const 1024
  call $tuple-type/makeTuple
  i32.load
  local.set $0
  local.get $0
  i32.const 5
  i32.const 1024
  call $tuple-type/makeTuple
  i32.const 4
  i32.add
  i32.load
  i32.const 20
  i32.sub
  i32.load offset=16
  i32.const 1
  i32.shr_u
  i32.add
  i32.const 8
  i32.ne
  if
   i32.const 0
   i32.const 464
   i32.const 101
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  i32.const 8
  i64.const 2
  call $~lib/rt/__newTuple
  local.tee $0
  i32.const 1
  i32.store
  local.get $0
  i32.const 4
  i32.const 928
  call $~lib/tuple/SmallTuple#__set<~lib/string/String>
  i32.const 2
  i32.const 960
  call $tuple-type/makeTuple
  local.tee $0
  i32.load
  i32.const 2
  i32.ne
  if
   i32.const 0
   i32.const 464
   i32.const 107
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  local.get $0
  i32.const 4
  i32.add
  i32.load
  i32.const 960
  call $~lib/string/String.__eq
  i32.eqz
  if
   i32.const 0
   i32.const 464
   i32.const 108
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  i32.const 3
  i32.const 1056
  call $tuple-type/makeTuple
  local.tee $0
  i32.load
  i32.const 3
  i32.ne
  if
   i32.const 0
   i32.const 464
   i32.const 112
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  local.get $0
  i32.const 4
  i32.add
  i32.load
  i32.const 1056
  call $~lib/string/String.__eq
  i32.eqz
  if
   i32.const 0
   i32.const 464
   i32.const 113
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  i32.const 10
  i32.const 1
  i32.const 672
  call $tuple-type/makeTriple
  local.tee $0
  i32.load
  i32.const 10
  i32.ne
  if
   i32.const 0
   i32.const 464
   i32.const 118
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  local.get $0
  i32.const 4
  i32.add
  i32.load8_u
  i32.eqz
  if
   i32.const 0
   i32.const 464
   i32.const 119
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  local.get $0
  i32.const 8
  i32.add
  i32.load
  i32.const 672
  call $~lib/string/String.__eq
  i32.eqz
  if
   i32.const 0
   i32.const 464
   i32.const 120
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  local.get $0
  i32.const 3
  i32.store
  local.get $0
  i32.const 4
  i32.add
  i32.const 0
  i32.store8
  local.get $0
  i32.const 8
  i32.const 736
  call $~lib/tuple/SmallTuple#__set<~lib/string/String>
  local.get $0
  i32.load
  i32.const 3
  i32.ne
  if
   i32.const 0
   i32.const 464
   i32.const 125
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  local.get $0
  i32.const 4
  i32.add
  i32.load8_u
  if
   i32.const 0
   i32.const 464
   i32.const 126
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  local.get $0
  i32.const 8
  i32.add
  i32.load
  i32.const 736
  call $~lib/string/String.__eq
  i32.eqz
  if
   i32.const 0
   i32.const 464
   i32.const 127
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  i32.const 7
  i32.const 1
  i32.const 576
  call $tuple-type/makeTriple
  call $tuple-type/scoreTriple
  i32.const 9
  i32.ne
  if
   i32.const 0
   i32.const 464
   i32.const 129
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  i32.const 7
  i32.const 0
  i32.const 576
  call $tuple-type/makeTriple
  call $tuple-type/scoreTriple
  i32.const 5
  i32.ne
  if
   i32.const 0
   i32.const 464
   i32.const 130
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  i32.const 8
  call $~lib/rt/__decrease_sp
  i32.const 4
  call $~lib/rt/__decrease_sp
  i32.const 8
  i64.const 2
  call $~lib/rt/__newTuple
  local.set $0
  global.get $~lib/memory/__stack_pointer
  local.get $0
  i32.store align=1
  local.get $0
  i32.const 5
  i32.store
  i32.const 8
  i64.const 2
  call $~lib/rt/__newTuple
  local.tee $1
  i32.const 6
  i32.store
  local.get $1
  i32.const 4
  i32.const 1120
  call $~lib/tuple/SmallTuple#__set<~lib/string/String>
  local.get $0
  i32.const 4
  local.get $1
  call $~lib/tuple/SmallTuple#__set<~lib/string/String>
  global.get $~lib/memory/__stack_pointer
  i32.const 4
  i32.add
  global.set $~lib/memory/__stack_pointer
  global.get $~lib/memory/__stack_pointer
  local.get $0
  i32.store offset=4 align=1
  local.get $0
  i32.load
  i32.const 5
  i32.ne
  if
   i32.const 0
   i32.const 464
   i32.const 139
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  local.get $0
  i32.const 4
  i32.add
  i32.load
  i32.load
  i32.const 6
  i32.ne
  if
   i32.const 0
   i32.const 464
   i32.const 140
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  local.get $0
  i32.const 4
  i32.add
  i32.load
  i32.const 4
  i32.add
  i32.load
  i32.const 1120
  call $~lib/string/String.__eq
  i32.eqz
  if
   i32.const 0
   i32.const 464
   i32.const 141
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  local.get $0
  i32.const 4
  i32.add
  i32.load
  call $tuple-type/takeTuple
  i32.const 6
  i32.ne
  if
   i32.const 0
   i32.const 464
   i32.const 143
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  global.get $~lib/memory/__stack_pointer
  local.get $0
  i32.const 4
  i32.add
  i32.load
  local.tee $1
  i32.store align=1
  i32.const 8
  i64.const 2
  call $~lib/rt/__newTuple
  local.tee $2
  local.get $1
  i32.load
  i32.const 2
  i32.add
  i32.store
  local.get $2
  i32.const 4
  local.get $1
  i32.const 4
  i32.add
  i32.load
  call $~lib/tuple/SmallTuple#__set<~lib/string/String>
  local.get $2
  local.tee $1
  i32.load
  i32.const 8
  i32.ne
  if
   i32.const 0
   i32.const 464
   i32.const 146
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  local.get $1
  i32.const 4
  i32.add
  i32.load
  i32.const 1120
  call $~lib/string/String.__eq
  i32.eqz
  if
   i32.const 0
   i32.const 464
   i32.const 147
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  local.get $0
  i32.const 4
  i32.add
  i32.load
  local.tee $0
  i32.const 4
  i32.add
  i32.load
  i32.const 20
  i32.sub
  i32.load offset=16
  i32.const 1
  i32.shr_u
  local.get $0
  i32.load
  i32.add
  i32.const 8
  i32.ne
  if
   i32.const 0
   i32.const 464
   i32.const 149
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
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
  i32.const 1160
  i32.lt_s
  if
   unreachable
  end
 )
)
