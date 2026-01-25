(module
 (type $0 (func (param i32 i32) (result i32)))
 (type $1 (func))
 (type $2 (func (param i32 i32)))
 (type $3 (func (param i32) (result i32)))
 (type $4 (func (param i32 i32 i32)))
 (type $5 (func (param i32)))
 (type $6 (func (param i32 i32 i32) (result i32)))
 (type $7 (func (param i32 i32 i32 i32)))
 (type $8 (func (param i32 i32 i64)))
 (type $9 (func (result i32)))
 (import "env" "abort" (func $~lib/builtins/abort (param i32 i32 i32 i32)))
 (global $~lib/memory/__stack_pointer (mut i32) (i32.const 34020))
 (global $~lib/symbol/Symbol.nextId (mut i32) (i32.const 2))
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
 (global $~lib/symbol/idToDesc (mut i32) (i32.const 0))
 (global $std/symbol/sym1 (mut i32) (i32.const 0))
 (global $std/symbol/sym2 (mut i32) (i32.const 0))
 (global $~lib/symbol/stringToId (mut i32) (i32.const 0))
 (global $~lib/symbol/idToString (mut i32) (i32.const 0))
 (global $std/symbol/sym3 (mut i32) (i32.const 0))
 (global $std/symbol/sym4 (mut i32) (i32.const 0))
 (global $std/symbol/key1 (mut i32) (i32.const 0))
 (global $std/symbol/key2 (mut i32) (i32.const 0))
 (global $std/symbol/key3 (mut i32) (i32.const 0))
 (global $std/symbol/key4 (mut i32) (i32.const 0))
 (global $~lib/symbol/Symbol.iterator (mut i32) (i32.const 0))
 (global $std/symbol/iterator (mut i32) (i32.const 0))
 (global $~started (mut i32) (i32.const 0))
 (memory $0 1)
 (data $0 (i32.const 12) "\1c")
 (data $0.1 (i32.const 24) "\02\00\00\00\06\00\00\001\002\003")
 (data $1 (i32.const 44) "<")
 (data $1.1 (i32.const 56) "\02\00\00\00(\00\00\00A\00l\00l\00o\00c\00a\00t\00i\00o\00n\00 \00t\00o\00o\00 \00l\00a\00r\00g\00e")
 (data $2 (i32.const 108) "<")
 (data $2.1 (i32.const 120) "\02\00\00\00 \00\00\00~\00l\00i\00b\00/\00r\00t\00/\00i\00t\00c\00m\00s\00.\00t\00s")
 (data $5 (i32.const 236) "<")
 (data $5.1 (i32.const 248) "\02\00\00\00$\00\00\00I\00n\00d\00e\00x\00 \00o\00u\00t\00 \00o\00f\00 \00r\00a\00n\00g\00e")
 (data $6 (i32.const 300) ",")
 (data $6.1 (i32.const 312) "\02\00\00\00\14\00\00\00~\00l\00i\00b\00/\00r\00t\00.\00t\00s")
 (data $8 (i32.const 380) "<")
 (data $8.1 (i32.const 392) "\02\00\00\00\1e\00\00\00~\00l\00i\00b\00/\00r\00t\00/\00t\00l\00s\00f\00.\00t\00s")
 (data $9 (i32.const 444) ",")
 (data $9.1 (i32.const 456) "\02\00\00\00\1c\00\00\00I\00n\00v\00a\00l\00i\00d\00 \00l\00e\00n\00g\00t\00h")
 (data $10 (i32.const 492) "<")
 (data $10.1 (i32.const 504) "\02\00\00\00&\00\00\00~\00l\00i\00b\00/\00a\00r\00r\00a\00y\00b\00u\00f\00f\00e\00r\00.\00t\00s")
 (data $11 (i32.const 556) ",")
 (data $11.1 (i32.const 568) "\02\00\00\00\1a\00\00\00s\00t\00d\00/\00s\00y\00m\00b\00o\00l\00.\00t\00s")
 (data $12 (i32.const 604) "<")
 (data $12.1 (i32.const 616) "\02\00\00\00$\00\00\00K\00e\00y\00 \00d\00o\00e\00s\00 \00n\00o\00t\00 \00e\00x\00i\00s\00t")
 (data $13 (i32.const 668) ",")
 (data $13.1 (i32.const 680) "\02\00\00\00\16\00\00\00~\00l\00i\00b\00/\00m\00a\00p\00.\00t\00s")
 (data $14 (i32.const 716) "|")
 (data $14.1 (i32.const 728) "\02\00\00\00^\00\00\00U\00n\00e\00x\00p\00e\00c\00t\00e\00d\00 \00\'\00n\00u\00l\00l\00\'\00 \00(\00n\00o\00t\00 \00a\00s\00s\00i\00g\00n\00e\00d\00 \00o\00r\00 \00f\00a\00i\00l\00e\00d\00 \00c\00a\00s\00t\00)")
 (data $15 (i32.const 844) ",")
 (data $15.1 (i32.const 856) "\02\00\00\00\10\00\00\00S\00y\00m\00b\00o\00l\00(\00)")
 (data $16 (i32.const 892) ",")
 (data $16.1 (i32.const 904) "\02\00\00\00\0e\00\00\00S\00y\00m\00b\00o\00l\00(")
 (data $17 (i32.const 940) "\1c")
 (data $17.1 (i32.const 952) "\02\00\00\00\02\00\00\00)")
 (data $18 (i32.const 972) "\1c\00\00\00\03\00\00\00\00\00\00\00\0b\00\00\00\0c\00\00\00\90\03\00\00\00\00\00\00\c0\03")
 (data $19 (i32.const 1004) "\1c")
 (data $19.1 (i32.const 1016) "\02")
 (data $20 (i32.const 1036) ",")
 (data $20.1 (i32.const 1048) "\02\00\00\00\16\00\00\00S\00y\00m\00b\00o\00l\00(\001\002\003\00)")
 (data $21 (i32.const 1084) ",")
 (data $21.1 (i32.const 1096) "\02\00\00\00\10\00\00\00i\00t\00e\00r\00a\00t\00o\00r")
 (data $22 (i32.const 1132) "<")
 (data $22.1 (i32.const 1144) "\02\00\00\00 \00\00\00S\00y\00m\00b\00o\00l\00(\00i\00t\00e\00r\00a\00t\00o\00r\00)")
 (data $23 (i32.const 1200) "\0c\00\00\00 \00\00\00 \00\00\00 \00\00\00\00\00\00\00\10a\02\00\00\00\00\00 \00\00\00\10\01\82\00 \00\00\00\10A\02\00 \00\00\00\04A")
 (export "memory" (memory $0))
 (export "_start" (func $~start))
 (func $~lib/rt/itcms/visitRoots
  (local $0 i32)
  (local $1 i32)
  global.get $~lib/symbol/stringToId
  local.tee $0
  if
   local.get $0
   call $~lib/rt/itcms/__visit
  end
  global.get $~lib/symbol/idToString
  local.tee $0
  if
   local.get $0
   call $~lib/rt/itcms/__visit
  end
  global.get $~lib/symbol/idToDesc
  local.tee $0
  if
   local.get $0
   call $~lib/rt/itcms/__visit
  end
  global.get $std/symbol/key1
  local.tee $0
  if
   local.get $0
   call $~lib/rt/itcms/__visit
  end
  global.get $std/symbol/key2
  local.tee $0
  if
   local.get $0
   call $~lib/rt/itcms/__visit
  end
  global.get $std/symbol/key3
  local.tee $0
  if
   local.get $0
   call $~lib/rt/itcms/__visit
  end
  global.get $std/symbol/key4
  local.tee $0
  if
   local.get $0
   call $~lib/rt/itcms/__visit
  end
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
     i32.const 128
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
    i32.const 128
    i32.const 147
    i32.const 30
    call $~lib/builtins/abort
    unreachable
   end
   global.set $~lib/rt/itcms/iter
  end
  block $__inlined_func$~lib/rt/itcms/Object#unlink$177
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
    i32.const 34020
    i32.lt_u
    i32.and
    i32.eqz
    if
     i32.const 0
     i32.const 128
     i32.const 127
     i32.const 18
     call $~lib/builtins/abort
     unreachable
    end
    br $__inlined_func$~lib/rt/itcms/Object#unlink$177
   end
   local.get $0
   i32.load offset=8
   local.tee $1
   i32.eqz
   if
    i32.const 0
    i32.const 128
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
   i32.const 1200
   i32.load
   i32.gt_u
   if
    i32.const 256
    i32.const 320
    i32.const 22
    i32.const 28
    call $~lib/builtins/abort
    unreachable
   end
   local.get $0
   i32.const 2
   i32.shl
   i32.const 1204
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
   i32.const 400
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
   i32.const 400
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
   i32.const 400
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
   i32.const 400
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
   i32.const 400
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
    i32.const 400
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
   i32.const 400
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
   i32.const 400
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
   i32.const 400
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
    i32.const 400
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
     i32.const 400
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
     i32.const 400
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
  i32.const 34032
  i32.const 0
  i32.store
  i32.const 35600
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
    i32.const 34032
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
      i32.const 34032
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
  i32.const 34032
  i32.const 35604
  memory.size
  i64.extend_i32_s
  i64.const 16
  i64.shl
  call $~lib/rt/tlsf/addMemory
  i32.const 34032
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
   i32.const 400
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
     i32.const 400
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
   i32.const 64
   i32.const 128
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
     block $__inlined_func$~lib/rt/itcms/step$182 (result i32)
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
         br $__inlined_func$~lib/rt/itcms/step$182
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
           br $__inlined_func$~lib/rt/itcms/step$182
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
          i32.const 34020
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
        br $__inlined_func$~lib/rt/itcms/step$182
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
         i32.const 128
         i32.const 229
         i32.const 20
         call $~lib/builtins/abort
         unreachable
        end
        local.get $3
        i32.const 34020
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
         i32.const 34020
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
           i32.const 400
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
        br $__inlined_func$~lib/rt/itcms/step$182
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
   i32.const 64
   i32.const 400
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
    i32.const 400
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
   i32.const 400
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
   i32.const 400
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
 (func $~lib/arraybuffer/ArrayBuffer#constructor (param $0 i32) (result i32)
  local.get $0
  i32.const 1073741820
  i32.gt_u
  if
   i32.const 464
   i32.const 512
   i32.const 50
   i32.const 43
   call $~lib/builtins/abort
   unreachable
  end
  local.get $0
  i32.const 1
  call $~lib/rt/itcms/__new
 )
 (func $~lib/rt/itcms/__link (param $0 i32) (param $1 i32) (param $2 i32)
  (local $3 i32)
  local.get $1
  if
   local.get $0
   i32.eqz
   if
    i32.const 0
    i32.const 128
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
    local.tee $0
    i32.load offset=4
    i32.const 3
    i32.and
    local.tee $3
    global.get $~lib/rt/itcms/white
    i32.eqz
    i32.eq
    if
     local.get $0
     local.get $1
     local.get $2
     select
     call $~lib/rt/itcms/Object#makeGray
    else
     global.get $~lib/rt/itcms/state
     i32.const 1
     i32.eq
     local.get $3
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
 (func $"~lib/map/Map<usize,~lib/string/String|null>#set:buckets" (param $0 i32) (param $1 i32)
  local.get $0
  local.get $1
  i32.store
  local.get $0
  local.get $1
  i32.const 0
  call $~lib/rt/itcms/__link
 )
 (func $"~lib/map/Map<usize,~lib/string/String|null>#set:entries" (param $0 i32) (param $1 i32)
  local.get $0
  local.get $1
  i32.store offset=8
  local.get $0
  local.get $1
  i32.const 0
  call $~lib/rt/itcms/__link
 )
 (func $"~lib/map/Map<usize,~lib/string/String|null>#find" (param $0 i32) (param $1 i32) (param $2 i32) (result i32)
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
 (func $"~lib/map/Map<usize,~lib/string/String|null>#set" (param $0 i32) (param $1 i32) (param $2 i32)
  (local $3 i32)
  (local $4 i32)
  (local $5 i32)
  (local $6 i32)
  (local $7 i32)
  (local $8 i32)
  (local $9 i32)
  (local $10 i32)
  (local $11 i32)
  local.get $0
  local.get $1
  local.get $1
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
  local.tee $9
  call $"~lib/map/Map<usize,~lib/string/String|null>#find"
  local.tee $3
  if
   local.get $3
   local.get $2
   i32.store offset=4
   local.get $0
   local.get $2
   i32.const 1
   call $~lib/rt/itcms/__link
  else
   local.get $0
   i32.load offset=16
   local.get $0
   i32.load offset=12
   i32.eq
   if
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
    local.set $7
    call $~lib/rt/__decrease_sp
    local.get $7
    i32.const 1
    i32.add
    local.tee $3
    i32.const 2
    i32.shl
    call $~lib/arraybuffer/ArrayBuffer#constructor
    local.set $8
    global.get $~lib/memory/__stack_pointer
    local.get $8
    i32.store align=1
    local.get $3
    i32.const 3
    i32.shl
    i32.const 3
    i32.div_s
    local.tee $10
    i32.const 12
    i32.mul
    call $~lib/arraybuffer/ArrayBuffer#constructor
    local.set $6
    local.get $0
    i32.load offset=8
    local.tee $5
    local.get $0
    i32.load offset=16
    i32.const 12
    i32.mul
    i32.add
    local.set $11
    local.get $6
    local.set $3
    loop $while-continue|0
     local.get $5
     local.get $11
     i32.ne
     if
      local.get $5
      i32.load offset=8
      i32.const 1
      i32.and
      i32.eqz
      if
       local.get $3
       local.get $5
       i32.load
       local.tee $4
       i32.store
       local.get $3
       local.get $5
       i32.load offset=4
       i32.store offset=4
       local.get $3
       local.get $8
       local.get $7
       local.get $4
       i32.const -1028477379
       i32.mul
       i32.const 374761397
       i32.add
       i32.const 17
       i32.rotl
       i32.const 668265263
       i32.mul
       local.tee $4
       i32.const 15
       i32.shr_u
       local.get $4
       i32.xor
       i32.const -2048144777
       i32.mul
       local.tee $4
       i32.const 13
       i32.shr_u
       local.get $4
       i32.xor
       i32.const -1028477379
       i32.mul
       local.tee $4
       i32.const 16
       i32.shr_u
       local.get $4
       i32.xor
       i32.and
       i32.const 2
       i32.shl
       i32.add
       local.tee $4
       i32.load
       i32.store offset=8
       local.get $4
       local.get $3
       i32.store
       local.get $3
       i32.const 12
       i32.add
       local.set $3
      end
      local.get $5
      i32.const 12
      i32.add
      local.set $5
      br $while-continue|0
     end
    end
    local.get $0
    local.get $8
    call $"~lib/map/Map<usize,~lib/string/String|null>#set:buckets"
    local.get $0
    local.get $7
    i32.store offset=4
    local.get $0
    local.get $6
    call $"~lib/map/Map<usize,~lib/string/String|null>#set:entries"
    local.get $0
    local.get $10
    i32.store offset=12
    local.get $0
    local.get $0
    i32.load offset=20
    i32.store offset=16
    global.get $~lib/memory/__stack_pointer
    i32.const 4
    i32.add
    global.set $~lib/memory/__stack_pointer
   end
   local.get $0
   i32.load offset=8
   local.set $3
   local.get $0
   local.get $0
   i32.load offset=16
   local.tee $6
   i32.const 1
   i32.add
   i32.store offset=16
   local.get $3
   local.get $6
   i32.const 12
   i32.mul
   i32.add
   local.tee $3
   local.get $1
   i32.store
   local.get $3
   local.get $2
   i32.store offset=4
   local.get $0
   local.get $2
   i32.const 1
   call $~lib/rt/itcms/__link
   local.get $0
   local.get $0
   i32.load offset=20
   i32.const 1
   i32.add
   i32.store offset=20
   local.get $3
   local.get $0
   i32.load
   local.get $9
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
   local.get $3
   i32.store
  end
 )
 (func $~lib/util/hash/HASH<~lib/string/String> (param $0 i32) (result i32)
  (local $1 i32)
  (local $2 i32)
  (local $3 i32)
  (local $4 i32)
  (local $5 i32)
  (local $6 i32)
  (local $7 i32)
  local.get $0
  if (result i32)
   local.get $0
   local.tee $1
   i32.const 20
   i32.sub
   i32.load offset=16
   i32.const -2
   i32.and
   local.tee $3
   i32.const 16
   i32.ge_u
   if (result i32)
    i32.const 606290984
    local.set $2
    i32.const -2048144777
    local.set $4
    i32.const 1640531535
    local.set $5
    local.get $1
    local.get $3
    i32.add
    i32.const 16
    i32.sub
    local.set $7
    loop $while-continue|0
     local.get $1
     local.get $7
     i32.le_u
     if
      local.get $2
      local.get $1
      i32.load
      i32.const -2048144777
      i32.mul
      i32.add
      i32.const 13
      i32.rotl
      i32.const -1640531535
      i32.mul
      local.set $2
      local.get $4
      local.get $1
      i32.load offset=4
      i32.const -2048144777
      i32.mul
      i32.add
      i32.const 13
      i32.rotl
      i32.const -1640531535
      i32.mul
      local.set $4
      local.get $6
      local.get $1
      i32.load offset=8
      i32.const -2048144777
      i32.mul
      i32.add
      i32.const 13
      i32.rotl
      i32.const -1640531535
      i32.mul
      local.set $6
      local.get $5
      local.get $1
      i32.load offset=12
      i32.const -2048144777
      i32.mul
      i32.add
      i32.const 13
      i32.rotl
      i32.const -1640531535
      i32.mul
      local.set $5
      local.get $1
      i32.const 16
      i32.add
      local.set $1
      br $while-continue|0
     end
    end
    local.get $3
    local.get $2
    i32.const 1
    i32.rotl
    local.get $4
    i32.const 7
    i32.rotl
    i32.add
    local.get $6
    i32.const 12
    i32.rotl
    i32.add
    local.get $5
    i32.const 18
    i32.rotl
    i32.add
    i32.add
   else
    local.get $3
    i32.const 374761393
    i32.add
   end
   local.set $2
   local.get $0
   local.get $3
   i32.add
   i32.const 4
   i32.sub
   local.set $4
   loop $while-continue|1
    local.get $1
    local.get $4
    i32.le_u
    if
     local.get $2
     local.get $1
     i32.load
     i32.const -1028477379
     i32.mul
     i32.add
     i32.const 17
     i32.rotl
     i32.const 668265263
     i32.mul
     local.set $2
     local.get $1
     i32.const 4
     i32.add
     local.set $1
     br $while-continue|1
    end
   end
   local.get $0
   local.get $3
   i32.add
   local.set $0
   loop $while-continue|2
    local.get $0
    local.get $1
    i32.gt_u
    if
     local.get $2
     local.get $1
     i32.load8_u
     i32.const 374761393
     i32.mul
     i32.add
     i32.const 11
     i32.rotl
     i32.const -1640531535
     i32.mul
     local.set $2
     local.get $1
     i32.const 1
     i32.add
     local.set $1
     br $while-continue|2
    end
   end
   local.get $2
   local.get $2
   i32.const 15
   i32.shr_u
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
  else
   i32.const 0
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
  block $__inlined_func$~lib/util/string/compareImpl$110 (result i32)
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
      br $__inlined_func$~lib/util/string/compareImpl$110
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
 (func $"~lib/map/Map<~lib/string/String,usize>#find" (param $0 i32) (param $1 i32) (param $2 i32) (result i32)
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
     local.get $0
     i32.load
     local.get $1
     call $~lib/string/String.__eq
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
 (func $~lib/symbol/ensureToMap (param $0 i32) (param $1 i32) (result i32)
  (local $2 i32)
  (local $3 i32)
  (local $4 i32)
  (local $5 i32)
  (local $6 i32)
  (local $7 i32)
  (local $8 i32)
  (local $9 i32)
  (local $10 i32)
  (local $11 i32)
  local.get $0
  local.set $5
  global.get $~lib/symbol/stringToId
  local.tee $2
  local.get $1
  local.get $1
  call $~lib/util/hash/HASH<~lib/string/String>
  local.tee $9
  call $"~lib/map/Map<~lib/string/String,usize>#find"
  local.tee $0
  if
   local.get $0
   local.get $5
   i32.store offset=4
  else
   local.get $2
   i32.load offset=16
   local.get $2
   i32.load offset=12
   i32.eq
   if
    local.get $2
    i32.load offset=20
    local.get $2
    i32.load offset=12
    i32.const 3
    i32.mul
    i32.const 4
    i32.div_s
    i32.lt_s
    if (result i32)
     local.get $2
     i32.load offset=4
    else
     local.get $2
     i32.load offset=4
     i32.const 1
     i32.shl
     i32.const 1
     i32.or
    end
    local.set $6
    call $~lib/rt/__decrease_sp
    local.get $6
    i32.const 1
    i32.add
    local.tee $0
    i32.const 2
    i32.shl
    call $~lib/arraybuffer/ArrayBuffer#constructor
    local.set $7
    global.get $~lib/memory/__stack_pointer
    local.get $7
    i32.store align=1
    local.get $0
    i32.const 3
    i32.shl
    i32.const 3
    i32.div_s
    local.tee $10
    i32.const 12
    i32.mul
    call $~lib/arraybuffer/ArrayBuffer#constructor
    local.set $3
    local.get $2
    i32.load offset=8
    local.tee $4
    local.get $2
    i32.load offset=16
    i32.const 12
    i32.mul
    i32.add
    local.set $11
    local.get $3
    local.set $0
    loop $while-continue|0
     local.get $4
     local.get $11
     i32.ne
     if
      local.get $4
      i32.load offset=8
      i32.const 1
      i32.and
      i32.eqz
      if
       local.get $0
       local.get $4
       i32.load
       local.tee $8
       i32.store
       local.get $0
       local.get $4
       i32.load offset=4
       i32.store offset=4
       local.get $0
       local.get $7
       local.get $8
       call $~lib/util/hash/HASH<~lib/string/String>
       local.get $6
       i32.and
       i32.const 2
       i32.shl
       i32.add
       local.tee $8
       i32.load
       i32.store offset=8
       local.get $8
       local.get $0
       i32.store
       local.get $0
       i32.const 12
       i32.add
       local.set $0
      end
      local.get $4
      i32.const 12
      i32.add
      local.set $4
      br $while-continue|0
     end
    end
    local.get $2
    local.get $7
    call $"~lib/map/Map<usize,~lib/string/String|null>#set:buckets"
    local.get $2
    local.get $6
    i32.store offset=4
    local.get $2
    local.get $3
    call $"~lib/map/Map<usize,~lib/string/String|null>#set:entries"
    local.get $2
    local.get $10
    i32.store offset=12
    local.get $2
    local.get $2
    i32.load offset=20
    i32.store offset=16
    global.get $~lib/memory/__stack_pointer
    i32.const 4
    i32.add
    global.set $~lib/memory/__stack_pointer
   end
   local.get $2
   i32.load offset=8
   local.set $0
   local.get $2
   local.get $2
   i32.load offset=16
   local.tee $3
   i32.const 1
   i32.add
   i32.store offset=16
   local.get $0
   local.get $3
   i32.const 12
   i32.mul
   i32.add
   local.tee $0
   local.get $1
   i32.store
   local.get $2
   local.get $1
   i32.const 1
   call $~lib/rt/itcms/__link
   local.get $0
   local.get $5
   i32.store offset=4
   local.get $2
   local.get $2
   i32.load offset=20
   i32.const 1
   i32.add
   i32.store offset=20
   local.get $0
   local.get $2
   i32.load
   local.get $9
   local.get $2
   i32.load offset=4
   i32.and
   i32.const 2
   i32.shl
   i32.add
   local.tee $3
   i32.load
   i32.store offset=8
   local.get $3
   local.get $0
   i32.store
  end
  global.get $~lib/symbol/idToString
  local.get $5
  local.get $1
  call $"~lib/map/Map<usize,~lib/string/String|null>#set"
  local.get $5
 )
 (func $~lib/symbol/Symbol.for (result i32)
  (local $0 i32)
  global.get $~lib/symbol/stringToId
  i32.const 32
  i32.const 32
  call $~lib/util/hash/HASH<~lib/string/String>
  call $"~lib/map/Map<~lib/string/String,usize>#find"
  if
   global.get $~lib/symbol/stringToId
   i32.const 32
   i32.const 32
   call $~lib/util/hash/HASH<~lib/string/String>
   call $"~lib/map/Map<~lib/string/String,usize>#find"
   local.tee $0
   i32.eqz
   if
    i32.const 624
    i32.const 688
    i32.const 143
    i32.const 17
    call $~lib/builtins/abort
    unreachable
   end
   local.get $0
   i32.load offset=4
   return
  end
  global.get $~lib/symbol/Symbol.nextId
  local.tee $0
  i32.const 1
  i32.add
  global.set $~lib/symbol/Symbol.nextId
  local.get $0
  i32.eqz
  if
   unreachable
  end
  local.get $0
  i32.const 32
  call $~lib/symbol/ensureToMap
 )
 (func $"~lib/map/Map<usize,~lib/string/String>#get" (param $0 i32) (param $1 i32) (result i32)
  local.get $0
  local.get $1
  local.get $1
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
  call $"~lib/map/Map<usize,~lib/string/String|null>#find"
  local.tee $0
  i32.eqz
  if
   i32.const 624
   i32.const 688
   i32.const 143
   i32.const 17
   call $~lib/builtins/abort
   unreachable
  end
  local.get $0
  i32.load offset=4
 )
 (func $~lib/symbol/Symbol.keyFor (param $0 i32) (result i32)
  (local $1 i32)
  global.get $~lib/symbol/idToString
  local.get $0
  local.get $0
  i32.const -1028477379
  i32.mul
  i32.const 374761397
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
  call $"~lib/map/Map<usize,~lib/string/String|null>#find"
  if (result i32)
   global.get $~lib/symbol/idToString
   local.get $0
   call $"~lib/map/Map<usize,~lib/string/String>#get"
  else
   i32.const 0
  end
 )
 (func $~lib/symbol/symbol#toString (param $0 i32) (result i32)
  (local $1 i32)
  (local $2 i32)
  (local $3 i32)
  (local $4 i32)
  (local $5 i32)
  global.get $~lib/symbol/idToString
  local.get $0
  local.get $0
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
  call $"~lib/map/Map<usize,~lib/string/String|null>#find"
  if (result i32)
   global.get $~lib/symbol/idToString
   local.get $0
   call $"~lib/map/Map<usize,~lib/string/String>#get"
  else
   global.get $~lib/symbol/idToDesc
   local.get $0
   call $"~lib/map/Map<usize,~lib/string/String>#get"
  end
  local.tee $0
  i32.const 0
  call $~lib/string/String.__eq
  if
   i32.const 864
   return
  end
  call $~lib/rt/__decrease_sp
  i32.const 996
  local.get $0
  i32.store
  i32.const 992
  local.get $0
  i32.const 1
  call $~lib/rt/itcms/__link
  global.get $~lib/memory/__stack_pointer
  i32.const 992
  i32.store align=1
  i32.const 0
  local.set $0
  block $__inlined_func$~lib/util/string/joinStringArray$150 (result i32)
   i32.const 1024
   i32.const 988
   i32.load
   i32.const 2
   i32.shr_u
   local.tee $3
   i32.const 1
   i32.sub
   local.tee $2
   i32.const 0
   i32.lt_s
   br_if $__inlined_func$~lib/util/string/joinStringArray$150
   drop
   local.get $2
   i32.eqz
   if
    i32.const 992
    i32.load
    local.tee $0
    if (result i32)
     local.get $0
    else
     i32.const 1024
    end
    br $__inlined_func$~lib/util/string/joinStringArray$150
   end
   loop $for-loop|0
    local.get $0
    local.get $3
    i32.lt_s
    if
     local.get $0
     i32.const 2
     i32.shl
     i32.const 992
     i32.add
     i32.load
     local.tee $4
     if
      local.get $1
      local.get $4
      i32.const 20
      i32.sub
      i32.load offset=16
      i32.const 1
      i32.shr_u
      i32.add
      local.set $1
     end
     local.get $0
     i32.const 1
     i32.add
     local.set $0
     br $for-loop|0
    end
   end
   i32.const 0
   local.set $0
   local.get $1
   i32.const 1020
   i32.load
   i32.const 1
   i32.shr_u
   local.tee $4
   local.get $2
   i32.mul
   i32.add
   i32.const 1
   i32.shl
   i32.const 2
   call $~lib/rt/itcms/__new
   local.set $3
   i32.const 0
   local.set $1
   loop $for-loop|1
    local.get $1
    local.get $2
    i32.lt_s
    if
     local.get $1
     i32.const 2
     i32.shl
     i32.const 992
     i32.add
     i32.load
     local.tee $5
     if
      local.get $3
      local.get $0
      i32.const 1
      i32.shl
      i32.add
      local.get $5
      local.get $5
      i32.const 20
      i32.sub
      i32.load offset=16
      i32.const 1
      i32.shr_u
      local.tee $5
      i32.const 1
      i32.shl
      memory.copy
      local.get $0
      local.get $5
      i32.add
      local.set $0
     end
     local.get $4
     if
      local.get $3
      local.get $0
      i32.const 1
      i32.shl
      i32.add
      i32.const 1024
      local.get $4
      i32.const 1
      i32.shl
      memory.copy
      local.get $0
      local.get $4
      i32.add
      local.set $0
     end
     local.get $1
     i32.const 1
     i32.add
     local.set $1
     br $for-loop|1
    end
   end
   local.get $2
   i32.const 2
   i32.shl
   i32.const 992
   i32.add
   i32.load
   local.tee $1
   if
    local.get $3
    local.get $0
    i32.const 1
    i32.shl
    i32.add
    local.get $1
    local.get $1
    i32.const 20
    i32.sub
    i32.load offset=16
    i32.const -2
    i32.and
    memory.copy
   end
   local.get $3
  end
  local.set $0
  global.get $~lib/memory/__stack_pointer
  i32.const 4
  i32.add
  global.set $~lib/memory/__stack_pointer
  local.get $0
 )
 (func $~lib/rt/__visit_members (param $0 i32)
  (local $1 i32)
  (local $2 i32)
  (local $3 i32)
  (local $4 i64)
  block $invalid
   block $~lib/staticarray/StaticArray<~lib/string/String>
    block $"~lib/iterator/Iterable<[usize, ~lib/string/String]>"
     block $"~lib/map/Map<usize,~lib/string/String>"
      block $"~lib/iterator/Iterable<[~lib/string/String, usize]>"
       block $"~lib/map/Map<~lib/string/String,usize>"
        block $"~lib/iterator/Iterable<[usize, ~lib/string/String|null]>"
         block $~lib/tuple/SmallTuple
          block $"~lib/map/Map<usize,~lib/string/String|null>"
           block $~lib/arraybuffer/ArrayBufferView
            block $~lib/string/String
             block $~lib/arraybuffer/ArrayBuffer
              block $~lib/object/Object
               local.get $0
               i32.const 8
               i32.sub
               i32.load
               br_table $~lib/object/Object $~lib/arraybuffer/ArrayBuffer $~lib/string/String $~lib/arraybuffer/ArrayBufferView $"~lib/map/Map<usize,~lib/string/String|null>" $~lib/tuple/SmallTuple $"~lib/iterator/Iterable<[usize, ~lib/string/String|null]>" $"~lib/map/Map<~lib/string/String,usize>" $"~lib/iterator/Iterable<[~lib/string/String, usize]>" $"~lib/map/Map<usize,~lib/string/String>" $"~lib/iterator/Iterable<[usize, ~lib/string/String]>" $~lib/staticarray/StaticArray<~lib/string/String> $invalid
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
          local.get $0
          i32.load offset=8
          local.tee $2
          local.tee $1
          local.get $0
          i32.load offset=16
          i32.const 12
          i32.mul
          i32.add
          local.set $0
          loop $while-continue|0
           local.get $0
           local.get $1
           i32.gt_u
           if
            local.get $1
            i32.load offset=8
            i32.const 1
            i32.and
            i32.eqz
            if
             local.get $1
             i32.load offset=4
             local.tee $3
             if
              local.get $3
              call $~lib/rt/itcms/__visit
             end
            end
            local.get $1
            i32.const 12
            i32.add
            local.set $1
            br $while-continue|0
           end
          end
          local.get $2
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
         local.set $4
         i32.const 0
         local.set $1
         loop $for-loop|0
          local.get $1
          local.get $2
          i32.lt_u
          if
           local.get $4
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
        return
       end
       local.get $0
       i32.load
       call $~lib/rt/itcms/__visit
       local.get $0
       i32.load offset=8
       local.tee $2
       local.tee $1
       local.get $0
       i32.load offset=16
       i32.const 12
       i32.mul
       i32.add
       local.set $0
       loop $while-continue|00
        local.get $0
        local.get $1
        i32.gt_u
        if
         local.get $1
         i32.load offset=8
         i32.const 1
         i32.and
         i32.eqz
         if
          local.get $1
          i32.load
          call $~lib/rt/itcms/__visit
         end
         local.get $1
         i32.const 12
         i32.add
         local.set $1
         br $while-continue|00
        end
       end
       local.get $2
       call $~lib/rt/itcms/__visit
       return
      end
      return
     end
     local.get $0
     i32.load
     call $~lib/rt/itcms/__visit
     local.get $0
     i32.load offset=8
     local.tee $2
     local.tee $1
     local.get $0
     i32.load offset=16
     i32.const 12
     i32.mul
     i32.add
     local.set $0
     loop $while-continue|01
      local.get $0
      local.get $1
      i32.gt_u
      if
       local.get $1
       i32.load offset=8
       i32.const 1
       i32.and
       i32.eqz
       if
        local.get $1
        i32.load offset=4
        call $~lib/rt/itcms/__visit
       end
       local.get $1
       i32.const 12
       i32.add
       local.set $1
       br $while-continue|01
      end
     end
     local.get $2
     call $~lib/rt/itcms/__visit
     return
    end
    return
   end
   local.get $0
   local.get $0
   i32.const 20
   i32.sub
   i32.load offset=16
   i32.add
   local.set $1
   loop $while-continue|02
    local.get $0
    local.get $1
    i32.lt_u
    if
     local.get $0
     i32.load
     local.tee $2
     if
      local.get $2
      call $~lib/rt/itcms/__visit
     end
     local.get $0
     i32.const 4
     i32.add
     local.set $0
     br $while-continue|02
    end
   end
   return
  end
  unreachable
 )
 (func $~start
  (local $0 i32)
  global.get $~started
  i32.eqz
  if
   i32.const 1
   global.set $~started
   memory.size
   i32.const 16
   i32.shl
   i32.const 34020
   i32.sub
   i32.const 1
   i32.shr_u
   global.set $~lib/rt/itcms/threshold
   i32.const 180
   i32.const 176
   i32.store
   i32.const 184
   i32.const 176
   i32.store
   i32.const 176
   global.set $~lib/rt/itcms/pinSpace
   i32.const 212
   i32.const 208
   i32.store
   i32.const 216
   i32.const 208
   i32.store
   i32.const 208
   global.set $~lib/rt/itcms/toSpace
   i32.const 356
   i32.const 352
   i32.store
   i32.const 360
   i32.const 352
   i32.store
   i32.const 352
   global.set $~lib/rt/itcms/fromSpace
   call $~lib/rt/__decrease_sp
   i32.const 24
   i32.const 4
   call $~lib/rt/itcms/__new
   local.set $0
   global.get $~lib/memory/__stack_pointer
   local.get $0
   i32.store align=1
   local.get $0
   i32.const 16
   call $~lib/arraybuffer/ArrayBuffer#constructor
   call $"~lib/map/Map<usize,~lib/string/String|null>#set:buckets"
   local.get $0
   i32.const 3
   i32.store offset=4
   local.get $0
   i32.const 48
   call $~lib/arraybuffer/ArrayBuffer#constructor
   call $"~lib/map/Map<usize,~lib/string/String|null>#set:entries"
   local.get $0
   i32.const 4
   i32.store offset=12
   global.get $~lib/memory/__stack_pointer
   i32.const 4
   i32.add
   global.set $~lib/memory/__stack_pointer
   local.get $0
   global.set $~lib/symbol/idToDesc
   global.get $~lib/symbol/Symbol.nextId
   local.tee $0
   i32.const 1
   i32.add
   global.set $~lib/symbol/Symbol.nextId
   local.get $0
   i32.eqz
   if
    unreachable
   end
   global.get $~lib/symbol/idToDesc
   local.get $0
   i32.const 32
   call $"~lib/map/Map<usize,~lib/string/String|null>#set"
   local.get $0
   global.set $std/symbol/sym1
   global.get $~lib/symbol/Symbol.nextId
   local.tee $0
   i32.const 1
   i32.add
   global.set $~lib/symbol/Symbol.nextId
   local.get $0
   i32.eqz
   if
    unreachable
   end
   global.get $~lib/symbol/idToDesc
   local.get $0
   i32.const 32
   call $"~lib/map/Map<usize,~lib/string/String|null>#set"
   local.get $0
   global.set $std/symbol/sym2
   global.get $std/symbol/sym1
   global.get $std/symbol/sym2
   i32.eq
   if
    i32.const 0
    i32.const 576
    i32.const 4
    i32.const 1
    call $~lib/builtins/abort
    unreachable
   end
   call $~lib/rt/__decrease_sp
   i32.const 24
   i32.const 7
   call $~lib/rt/itcms/__new
   local.set $0
   global.get $~lib/memory/__stack_pointer
   local.get $0
   i32.store align=1
   local.get $0
   i32.const 16
   call $~lib/arraybuffer/ArrayBuffer#constructor
   call $"~lib/map/Map<usize,~lib/string/String|null>#set:buckets"
   local.get $0
   i32.const 3
   i32.store offset=4
   local.get $0
   i32.const 48
   call $~lib/arraybuffer/ArrayBuffer#constructor
   call $"~lib/map/Map<usize,~lib/string/String|null>#set:entries"
   local.get $0
   i32.const 4
   i32.store offset=12
   global.get $~lib/memory/__stack_pointer
   i32.const 4
   i32.add
   global.set $~lib/memory/__stack_pointer
   local.get $0
   global.set $~lib/symbol/stringToId
   call $~lib/rt/__decrease_sp
   i32.const 24
   i32.const 9
   call $~lib/rt/itcms/__new
   local.set $0
   global.get $~lib/memory/__stack_pointer
   local.get $0
   i32.store align=1
   local.get $0
   i32.const 16
   call $~lib/arraybuffer/ArrayBuffer#constructor
   call $"~lib/map/Map<usize,~lib/string/String|null>#set:buckets"
   local.get $0
   i32.const 3
   i32.store offset=4
   local.get $0
   i32.const 48
   call $~lib/arraybuffer/ArrayBuffer#constructor
   call $"~lib/map/Map<usize,~lib/string/String|null>#set:entries"
   local.get $0
   i32.const 4
   i32.store offset=12
   global.get $~lib/memory/__stack_pointer
   i32.const 4
   i32.add
   global.set $~lib/memory/__stack_pointer
   local.get $0
   global.set $~lib/symbol/idToString
   call $~lib/symbol/Symbol.for
   global.set $std/symbol/sym3
   call $~lib/symbol/Symbol.for
   global.set $std/symbol/sym4
   global.get $std/symbol/sym3
   global.get $std/symbol/sym4
   i32.ne
   if
    i32.const 0
    i32.const 576
    i32.const 9
    i32.const 1
    call $~lib/builtins/abort
    unreachable
   end
   global.get $std/symbol/sym1
   call $~lib/symbol/Symbol.keyFor
   global.set $std/symbol/key1
   global.get $std/symbol/sym2
   call $~lib/symbol/Symbol.keyFor
   global.set $std/symbol/key2
   global.get $std/symbol/key1
   i32.const 0
   call $~lib/string/String.__eq
   i32.eqz
   if
    i32.const 0
    i32.const 576
    i32.const 14
    i32.const 1
    call $~lib/builtins/abort
    unreachable
   end
   global.get $std/symbol/key2
   i32.const 0
   call $~lib/string/String.__eq
   i32.eqz
   if
    i32.const 0
    i32.const 576
    i32.const 15
    i32.const 1
    call $~lib/builtins/abort
    unreachable
   end
   global.get $std/symbol/sym3
   call $~lib/symbol/Symbol.keyFor
   local.tee $0
   if (result i32)
    local.get $0
   else
    i32.const 736
    i32.const 576
    i32.const 17
    i32.const 12
    call $~lib/builtins/abort
    unreachable
   end
   global.set $std/symbol/key3
   global.get $std/symbol/sym4
   call $~lib/symbol/Symbol.keyFor
   local.tee $0
   if (result i32)
    local.get $0
   else
    i32.const 736
    i32.const 576
    i32.const 18
    i32.const 12
    call $~lib/builtins/abort
    unreachable
   end
   global.set $std/symbol/key4
   global.get $std/symbol/key3
   i32.const 32
   call $~lib/string/String.__eq
   i32.eqz
   if
    i32.const 0
    i32.const 576
    i32.const 20
    i32.const 1
    call $~lib/builtins/abort
    unreachable
   end
   global.get $std/symbol/key3
   global.get $std/symbol/key4
   call $~lib/string/String.__eq
   i32.eqz
   if
    i32.const 0
    i32.const 576
    i32.const 21
    i32.const 1
    call $~lib/builtins/abort
    unreachable
   end
   global.get $~lib/symbol/Symbol.nextId
   local.tee $0
   i32.const 1
   i32.add
   global.set $~lib/symbol/Symbol.nextId
   local.get $0
   i32.eqz
   if
    unreachable
   end
   global.get $~lib/symbol/idToDesc
   local.get $0
   i32.const 0
   call $"~lib/map/Map<usize,~lib/string/String|null>#set"
   local.get $0
   call $~lib/symbol/symbol#toString
   i32.const 864
   call $~lib/string/String.__eq
   i32.eqz
   if
    i32.const 0
    i32.const 576
    i32.const 23
    i32.const 1
    call $~lib/builtins/abort
    unreachable
   end
   global.get $std/symbol/sym3
   call $~lib/symbol/symbol#toString
   i32.const 1056
   call $~lib/string/String.__eq
   i32.eqz
   if
    i32.const 0
    i32.const 576
    i32.const 24
    i32.const 1
    call $~lib/builtins/abort
    unreachable
   end
   i32.const 1
   i32.const 1104
   call $~lib/symbol/ensureToMap
   global.set $~lib/symbol/Symbol.iterator
   global.get $~lib/symbol/Symbol.iterator
   global.set $std/symbol/iterator
   global.get $std/symbol/iterator
   call $~lib/symbol/symbol#toString
   i32.const 1152
   call $~lib/string/String.__eq
   i32.eqz
   if
    i32.const 0
    i32.const 576
    i32.const 27
    i32.const 1
    call $~lib/builtins/abort
    unreachable
   end
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
  i32.const 1252
  i32.lt_s
  if
   unreachable
  end
 )
)
