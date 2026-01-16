(module
 (type $0 (func (param i32) (result i32)))
 (type $1 (func))
 (type $2 (func (param i32)))
 (type $3 (func (param i32 i32)))
 (type $4 (func (param i32 i32 i32 i32)))
 (type $5 (func (param i32 i32 i32)))
 (type $6 (func (param i32 i32 i64)))
 (type $7 (func (param i32 i32) (result i32)))
 (import "env" "abort" (func $~lib/builtins/abort (param i32 i32 i32 i32)))
 (global $~lib/rt/itcms/toSpace (mut i32) (i32.const 0))
 (global $~lib/rt/itcms/total (mut i32) (i32.const 0))
 (global $~lib/rt/itcms/threshold (mut i32) (i32.const 0))
 (global $~lib/rt/itcms/state (mut i32) (i32.const 0))
 (global $~lib/rt/itcms/visitCount (mut i32) (i32.const 0))
 (global $~lib/rt/itcms/pinSpace (mut i32) (i32.const 0))
 (global $~lib/rt/itcms/iter (mut i32) (i32.const 0))
 (global $~lib/rt/itcms/white (mut i32) (i32.const 0))
 (global $~lib/rt/itcms/fromSpace (mut i32) (i32.const 0))
 (global $~lib/rt/tlsf/ROOT (mut i32) (i32.const 0))
 (memory $0 1)
 (data $0 (i32.const 12) "\1c")
 (data $0.1 (i32.const 24) "\04\00\00\00\08\00\00\00\01")
 (data $1 (i32.const 44) "L")
 (data $1.1 (i32.const 56) "\02\00\00\00<\00\00\00r\00e\00s\00o\00l\00v\00e\00-\00f\00u\00n\00c\00t\00i\00o\00n\00-\00e\00x\00p\00r\00e\00s\00s\00i\00o\00n\00.\00t\00s")
 (data $2 (i32.const 124) "\1c")
 (data $2.1 (i32.const 136) "\04\00\00\00\08\00\00\00\02")
 (data $3 (i32.const 156) "\1c")
 (data $3.1 (i32.const 168) "\04\00\00\00\08\00\00\00\03")
 (data $4 (i32.const 188) "|")
 (data $4.1 (i32.const 200) "\02\00\00\00d\00\00\00t\00o\00S\00t\00r\00i\00n\00g\00(\00)\00 \00r\00a\00d\00i\00x\00 \00a\00r\00g\00u\00m\00e\00n\00t\00 \00m\00u\00s\00t\00 \00b\00e\00 \00b\00e\00t\00w\00e\00e\00n\00 \002\00 \00a\00n\00d\00 \003\006")
 (data $5 (i32.const 316) "<")
 (data $5.1 (i32.const 328) "\02\00\00\00&\00\00\00~\00l\00i\00b\00/\00u\00t\00i\00l\00/\00n\00u\00m\00b\00e\00r\00.\00t\00s")
 (data $6 (i32.const 380) "\1c")
 (data $6.1 (i32.const 392) "\02\00\00\00\02\00\00\000")
 (data $7 (i32.const 412) "<")
 (data $7.1 (i32.const 424) "\02\00\00\00(\00\00\00A\00l\00l\00o\00c\00a\00t\00i\00o\00n\00 \00t\00o\00o\00 \00l\00a\00r\00g\00e")
 (data $8 (i32.const 476) "<")
 (data $8.1 (i32.const 488) "\02\00\00\00 \00\00\00~\00l\00i\00b\00/\00r\00t\00/\00i\00t\00c\00m\00s\00.\00t\00s")
 (data $11 (i32.const 604) "<")
 (data $11.1 (i32.const 616) "\02\00\00\00$\00\00\00I\00n\00d\00e\00x\00 \00o\00u\00t\00 \00o\00f\00 \00r\00a\00n\00g\00e")
 (data $12 (i32.const 668) ",")
 (data $12.1 (i32.const 680) "\02\00\00\00\14\00\00\00~\00l\00i\00b\00/\00r\00t\00.\00t\00s")
 (data $14 (i32.const 748) "<")
 (data $14.1 (i32.const 760) "\02\00\00\00\1e\00\00\00~\00l\00i\00b\00/\00r\00t\00/\00t\00l\00s\00f\00.\00t\00s")
 (data $15 (i32.const 812) "0\000\000\001\000\002\000\003\000\004\000\005\000\006\000\007\000\008\000\009\001\000\001\001\001\002\001\003\001\004\001\005\001\006\001\007\001\008\001\009\002\000\002\001\002\002\002\003\002\004\002\005\002\006\002\007\002\008\002\009\003\000\003\001\003\002\003\003\003\004\003\005\003\006\003\007\003\008\003\009\004\000\004\001\004\002\004\003\004\004\004\005\004\006\004\007\004\008\004\009\005\000\005\001\005\002\005\003\005\004\005\005\005\006\005\007\005\008\005\009\006\000\006\001\006\002\006\003\006\004\006\005\006\006\006\007\006\008\006\009\007\000\007\001\007\002\007\003\007\004\007\005\007\006\007\007\007\008\007\009\008\000\008\001\008\002\008\003\008\004\008\005\008\006\008\007\008\008\008\009\009\000\009\001\009\002\009\003\009\004\009\005\009\006\009\007\009\008\009\009")
 (data $16 (i32.const 1212) "\1c\04")
 (data $16.1 (i32.const 1224) "\02\00\00\00\00\04\00\000\000\000\001\000\002\000\003\000\004\000\005\000\006\000\007\000\008\000\009\000\00a\000\00b\000\00c\000\00d\000\00e\000\00f\001\000\001\001\001\002\001\003\001\004\001\005\001\006\001\007\001\008\001\009\001\00a\001\00b\001\00c\001\00d\001\00e\001\00f\002\000\002\001\002\002\002\003\002\004\002\005\002\006\002\007\002\008\002\009\002\00a\002\00b\002\00c\002\00d\002\00e\002\00f\003\000\003\001\003\002\003\003\003\004\003\005\003\006\003\007\003\008\003\009\003\00a\003\00b\003\00c\003\00d\003\00e\003\00f\004\000\004\001\004\002\004\003\004\004\004\005\004\006\004\007\004\008\004\009\004\00a\004\00b\004\00c\004\00d\004\00e\004\00f\005\000\005\001\005\002\005\003\005\004\005\005\005\006\005\007\005\008\005\009\005\00a\005\00b\005\00c\005\00d\005\00e\005\00f\006\000\006\001\006\002\006\003\006\004\006\005\006\006\006\007\006\008\006\009\006\00a\006\00b\006\00c\006\00d\006\00e\006\00f\007\000\007\001\007\002\007\003\007\004\007\005\007\006\007\007\007\008\007\009\007\00a\007\00b\007\00c\007\00d\007\00e\007\00f\008\000\008\001\008\002\008\003\008\004\008\005\008\006\008\007\008\008\008\009\008\00a\008\00b\008\00c\008\00d\008\00e\008\00f\009\000\009\001\009\002\009\003\009\004\009\005\009\006\009\007\009\008\009\009\009\00a\009\00b\009\00c\009\00d\009\00e\009\00f\00a\000\00a\001\00a\002\00a\003\00a\004\00a\005\00a\006\00a\007\00a\008\00a\009\00a\00a\00a\00b\00a\00c\00a\00d\00a\00e\00a\00f\00b\000\00b\001\00b\002\00b\003\00b\004\00b\005\00b\006\00b\007\00b\008\00b\009\00b\00a\00b\00b\00b\00c\00b\00d\00b\00e\00b\00f\00c\000\00c\001\00c\002\00c\003\00c\004\00c\005\00c\006\00c\007\00c\008\00c\009\00c\00a\00c\00b\00c\00c\00c\00d\00c\00e\00c\00f\00d\000\00d\001\00d\002\00d\003\00d\004\00d\005\00d\006\00d\007\00d\008\00d\009\00d\00a\00d\00b\00d\00c\00d\00d\00d\00e\00d\00f\00e\000\00e\001\00e\002\00e\003\00e\004\00e\005\00e\006\00e\007\00e\008\00e\009\00e\00a\00e\00b\00e\00c\00e\00d\00e\00e\00e\00f\00f\000\00f\001\00f\002\00f\003\00f\004\00f\005\00f\006\00f\007\00f\008\00f\009\00f\00a\00f\00b\00f\00c\00f\00d\00f\00e\00f\00f")
 (data $17 (i32.const 2268) "\\")
 (data $17.1 (i32.const 2280) "\02\00\00\00H\00\00\000\001\002\003\004\005\006\007\008\009\00a\00b\00c\00d\00e\00f\00g\00h\00i\00j\00k\00l\00m\00n\00o\00p\00q\00r\00s\00t\00u\00v\00w\00x\00y\00z")
 (data $18 (i32.const 2364) "\1c")
 (data $18.1 (i32.const 2376) "\02\00\00\00\04\00\00\004\002")
 (data $19 (i32.const 2400) "\05\00\00\00 \00\00\00 \00\00\00 ")
 (table $0 4 4 funcref)
 (elem $0 (i32.const 1) $start:resolve-function-expression~anonymous|0 $start:resolve-function-expression~anonymous|1 $start:resolve-function-expression~anonymous|2)
 (export "memory" (memory $0))
 (start $~start)
 (func $start:resolve-function-expression~anonymous|0 (param $0 i32) (result i32)
  local.get $0
  i32.const 40
  i32.add
 )
 (func $start:resolve-function-expression~anonymous|1 (param $0 i32) (result i32)
  local.get $0
  i32.const 41
  i32.add
 )
 (func $start:resolve-function-expression~anonymous|2 (param $0 i32) (result i32)
  local.get $0
  i32.const 42
  i32.add
 )
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
     i32.const 496
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
 (func $~lib/rt/itcms/__visit (param $0 i32)
  (local $1 i32)
  (local $2 i32)
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
      i32.const 496
      i32.const 147
      i32.const 30
      call $~lib/builtins/abort
      unreachable
     end
     global.set $~lib/rt/itcms/iter
    end
    block $__inlined_func$~lib/rt/itcms/Object#unlink$81
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
      i32.const 35192
      i32.lt_u
      i32.and
      i32.eqz
      if
       i32.const 0
       i32.const 496
       i32.const 127
       i32.const 18
       call $~lib/builtins/abort
       unreachable
      end
      br $__inlined_func$~lib/rt/itcms/Object#unlink$81
     end
     local.get $0
     i32.load offset=8
     local.tee $1
     i32.eqz
     if
      i32.const 0
      i32.const 496
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
     i32.const 2400
     i32.load
     i32.gt_u
     if
      i32.const 624
      i32.const 688
      i32.const 21
      i32.const 28
      call $~lib/builtins/abort
      unreachable
     end
     local.get $0
     i32.const 2
     i32.shl
     i32.const 2404
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
   i32.const 768
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
   i32.const 768
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
   i32.const 768
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
   i32.const 768
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
   i32.const 768
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
    i32.const 768
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
   i32.const 768
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
   i32.const 768
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
   i32.const 768
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
    i32.const 768
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
     i32.const 768
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
     i32.const 768
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
  i32.const 35200
  i32.const 0
  i32.store
  i32.const 36768
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
    i32.const 35200
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
      i32.const 35200
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
  i32.const 35200
  i32.const 36772
  memory.size
  i64.extend_i32_s
  i64.const 16
  i64.shl
  call $~lib/rt/tlsf/addMemory
  i32.const 35200
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
   i32.const 768
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
     i32.const 768
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
 (func $~lib/rt/__visit_members (param $0 i32)
  block $invalid
   block $~lib/function/Function<%28i32%29=>i32>
    block $~lib/arraybuffer/ArrayBufferView
     block $~lib/string/String
      block $~lib/arraybuffer/ArrayBuffer
       block $~lib/object/Object
        local.get $0
        i32.const 8
        i32.sub
        i32.load
        br_table $~lib/object/Object $~lib/arraybuffer/ArrayBuffer $~lib/string/String $~lib/arraybuffer/ArrayBufferView $~lib/function/Function<%28i32%29=>i32> $invalid
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
   i32.load offset=4
   call $~lib/rt/itcms/__visit
   return
  end
  unreachable
 )
 (func $~start
  (local $0 i32)
  (local $1 i32)
  (local $2 i32)
  (local $3 i32)
  (local $4 i32)
  (local $5 i32)
  (local $6 i32)
  (local $7 i32)
  (local $8 i32)
  i32.const 2
  call $start:resolve-function-expression~anonymous|0
  i32.const 42
  i32.ne
  if
   i32.const 0
   i32.const 64
   i32.const 1
   i32.const 1
   call $~lib/builtins/abort
   unreachable
  end
  i32.const 1
  call $start:resolve-function-expression~anonymous|1
  i32.const 42
  i32.ne
  if
   i32.const 0
   i32.const 64
   i32.const 2
   i32.const 1
   call $~lib/builtins/abort
   unreachable
  end
  memory.size
  i32.const 16
  i32.shl
  i32.const 35192
  i32.sub
  i32.const 1
  i32.shr_u
  global.set $~lib/rt/itcms/threshold
  i32.const 548
  i32.const 544
  i32.store
  i32.const 552
  i32.const 544
  i32.store
  i32.const 544
  global.set $~lib/rt/itcms/pinSpace
  i32.const 580
  i32.const 576
  i32.store
  i32.const 584
  i32.const 576
  i32.store
  i32.const 576
  global.set $~lib/rt/itcms/toSpace
  i32.const 724
  i32.const 720
  i32.store
  i32.const 728
  i32.const 720
  i32.store
  i32.const 720
  global.set $~lib/rt/itcms/fromSpace
  block $__inlined_func$~lib/string/String.__eq$88 (result i32)
   i32.const 1
   i32.const 0
   call $start:resolve-function-expression~anonymous|2
   local.tee $0
   if (result i32)
    i32.const 0
    local.get $0
    i32.sub
    local.get $0
    local.get $0
    i32.const 31
    i32.shr_u
    i32.const 1
    i32.shl
    local.tee $6
    select
    local.set $2
    local.get $2
    i32.const 10
    i32.ge_u
    i32.const 1
    i32.add
    local.get $2
    i32.const 10000
    i32.ge_u
    i32.const 3
    i32.add
    local.get $2
    i32.const 1000
    i32.ge_u
    i32.add
    local.get $2
    i32.const 100
    i32.lt_u
    select
    local.get $2
    i32.const 1000000
    i32.ge_u
    i32.const 6
    i32.add
    local.get $2
    i32.const 1000000000
    i32.ge_u
    i32.const 8
    i32.add
    local.get $2
    i32.const 100000000
    i32.ge_u
    i32.add
    local.get $2
    i32.const 10000000
    i32.lt_u
    select
    local.get $2
    i32.const 100000
    i32.lt_u
    select
    local.tee $3
    i32.const 1
    i32.shl
    local.get $6
    i32.add
    local.tee $7
    i32.const 1073741804
    i32.ge_u
    if
     i32.const 432
     i32.const 496
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
      local.set $0
      loop $do-loop|0
       local.get $0
       block $__inlined_func$~lib/rt/itcms/step$86 (result i32)
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
           br $__inlined_func$~lib/rt/itcms/step$86
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
             br $__inlined_func$~lib/rt/itcms/step$86
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
           i32.const 35192
           local.set $0
           loop $while-continue|0
            local.get $0
            i32.const 35192
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
          br $__inlined_func$~lib/rt/itcms/step$86
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
           i32.const 496
           i32.const 229
           i32.const 20
           call $~lib/builtins/abort
           unreachable
          end
          local.get $0
          i32.const 35192
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
           i32.const 35192
           i32.ge_u
           if
            global.get $~lib/rt/tlsf/ROOT
            i32.eqz
            if
             call $~lib/rt/tlsf/initialize
            end
            global.get $~lib/rt/tlsf/ROOT
            local.set $4
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
             i32.const 768
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
            local.get $4
            local.get $0
            call $~lib/rt/tlsf/insertBlock
           end
          end
          i32.const 10
          br $__inlined_func$~lib/rt/itcms/step$86
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
       local.set $0
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
       local.get $0
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
    local.set $4
    local.get $7
    i32.const 16
    i32.add
    local.tee $0
    i32.const 1073741820
    i32.gt_u
    if
     i32.const 432
     i32.const 768
     i32.const 435
     i32.const 29
     call $~lib/builtins/abort
     unreachable
    end
    local.get $4
    i32.const 12
    local.get $0
    i32.const 19
    i32.add
    i32.const -16
    i32.and
    i32.const 4
    i32.sub
    local.get $0
    i32.const 12
    i32.le_u
    select
    local.tee $1
    call $~lib/rt/tlsf/searchBlock
    local.tee $0
    i32.eqz
    if
     memory.size
     local.tee $5
     local.get $1
     local.tee $0
     i32.const 256
     i32.ge_u
     if (result i32)
      local.get $0
      i32.const 1
      i32.const 27
      local.get $0
      i32.clz
      i32.sub
      i32.shl
      i32.add
      i32.const 1
      i32.sub
      local.get $0
      local.get $0
      i32.const 536870910
      i32.lt_u
      select
     else
      local.get $0
     end
     i32.const 4
     local.get $4
     i32.load offset=1568
     local.get $5
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
     local.tee $0
     local.get $0
     local.get $5
     i32.lt_s
     select
     memory.grow
     i32.const 0
     i32.lt_s
     if
      local.get $0
      memory.grow
      i32.const 0
      i32.lt_s
      if
       unreachable
      end
     end
     local.get $4
     local.get $5
     i32.const 16
     i32.shl
     memory.size
     i64.extend_i32_s
     i64.const 16
     i64.shl
     call $~lib/rt/tlsf/addMemory
     local.get $4
     local.get $1
     call $~lib/rt/tlsf/searchBlock
     local.tee $0
     i32.eqz
     if
      i32.const 0
      i32.const 768
      i32.const 472
      i32.const 16
      call $~lib/builtins/abort
      unreachable
     end
    end
    local.get $1
    local.get $0
    i32.load
    i32.const -4
    i32.and
    i32.gt_u
    if
     i32.const 0
     i32.const 768
     i32.const 474
     i32.const 14
     call $~lib/builtins/abort
     unreachable
    end
    local.get $4
    local.get $0
    call $~lib/rt/tlsf/removeBlock
    local.get $0
    i32.load
    local.set $5
    local.get $1
    i32.const 4
    i32.add
    i32.const 15
    i32.and
    if
     i32.const 0
     i32.const 768
     i32.const 336
     i32.const 14
     call $~lib/builtins/abort
     unreachable
    end
    local.get $5
    i32.const -4
    i32.and
    local.get $1
    i32.sub
    local.tee $8
    i32.const 16
    i32.ge_u
    if
     local.get $0
     local.get $1
     local.get $5
     i32.const 2
     i32.and
     i32.or
     i32.store
     local.get $0
     i32.const 4
     i32.add
     local.get $1
     i32.add
     local.tee $1
     local.get $8
     i32.const 4
     i32.sub
     i32.const 1
     i32.or
     i32.store
     local.get $4
     local.get $1
     call $~lib/rt/tlsf/insertBlock
    else
     local.get $0
     local.get $5
     i32.const -2
     i32.and
     i32.store
     local.get $0
     i32.const 4
     i32.add
     local.tee $1
     local.get $0
     i32.load
     i32.const -4
     i32.and
     local.tee $4
     i32.add
     local.get $1
     local.get $4
     i32.add
     i32.load
     i32.const -3
     i32.and
     i32.store
    end
    local.get $0
    i32.const 2
    i32.store offset=12
    local.get $0
    local.get $7
    i32.store offset=16
    local.get $0
    global.get $~lib/rt/itcms/fromSpace
    global.get $~lib/rt/itcms/white
    call $~lib/rt/itcms/Object#linkTo
    global.get $~lib/rt/itcms/total
    local.get $0
    i32.load
    i32.const -4
    i32.and
    i32.const 4
    i32.add
    i32.add
    global.set $~lib/rt/itcms/total
    local.get $0
    i32.const 20
    i32.add
    local.tee $1
    i32.const 0
    local.get $7
    memory.fill
    local.get $1
    local.get $6
    i32.add
    local.set $0
    loop $while-continue|00
     local.get $2
     i32.const 10000
     i32.ge_u
     if
      local.get $2
      i32.const 10000
      i32.rem_u
      local.set $4
      local.get $2
      i32.const 10000
      i32.div_u
      local.set $2
      local.get $0
      local.get $3
      i32.const 4
      i32.sub
      local.tee $3
      i32.const 1
      i32.shl
      i32.add
      local.get $4
      i32.const 100
      i32.div_u
      i32.const 2
      i32.shl
      i32.const 812
      i32.add
      i64.load32_u
      local.get $4
      i32.const 100
      i32.rem_u
      i32.const 2
      i32.shl
      i32.const 812
      i32.add
      i64.load32_u
      i64.const 32
      i64.shl
      i64.or
      i64.store
      br $while-continue|00
     end
    end
    local.get $2
    i32.const 100
    i32.ge_u
    if
     local.get $0
     local.get $3
     i32.const 2
     i32.sub
     local.tee $3
     i32.const 1
     i32.shl
     i32.add
     local.get $2
     i32.const 100
     i32.rem_u
     i32.const 2
     i32.shl
     i32.const 812
     i32.add
     i32.load
     i32.store
     local.get $2
     i32.const 100
     i32.div_u
     local.set $2
    end
    local.get $2
    i32.const 10
    i32.ge_u
    if
     local.get $0
     local.get $3
     i32.const 2
     i32.sub
     i32.const 1
     i32.shl
     i32.add
     local.get $2
     i32.const 2
     i32.shl
     i32.const 812
     i32.add
     i32.load
     i32.store
    else
     local.get $0
     local.get $3
     i32.const 1
     i32.sub
     i32.const 1
     i32.shl
     i32.add
     local.get $2
     i32.const 48
     i32.add
     i32.store16
    end
    local.get $6
    if
     local.get $1
     i32.const 45
     i32.store16
    end
    local.get $1
   else
    i32.const 400
   end
   local.tee $3
   i32.const 2384
   i32.eq
   br_if $__inlined_func$~lib/string/String.__eq$88
   drop
   i32.const 0
   local.get $3
   i32.eqz
   br_if $__inlined_func$~lib/string/String.__eq$88
   drop
   i32.const 0
   local.get $3
   i32.const 20
   i32.sub
   i32.load offset=16
   i32.const 1
   i32.shr_u
   local.tee $2
   i32.const 2380
   i32.load
   i32.const 1
   i32.shr_u
   i32.ne
   br_if $__inlined_func$~lib/string/String.__eq$88
   drop
   block $__inlined_func$~lib/util/string/compareImpl$75 (result i32)
    i32.const 2384
    local.set $1
    local.get $3
    i32.const 7
    i32.and
    i32.eqz
    local.get $2
    i32.const 4
    i32.ge_u
    i32.and
    if
     loop $do-loop|01
      local.get $3
      i64.load
      local.get $1
      i64.load
      i64.eq
      if
       local.get $3
       i32.const 8
       i32.add
       local.set $3
       local.get $1
       i32.const 8
       i32.add
       local.set $1
       local.get $2
       i32.const 4
       i32.sub
       local.tee $2
       i32.const 4
       i32.ge_u
       br_if $do-loop|01
      end
     end
    end
    loop $while-continue|12
     local.get $2
     local.tee $0
     i32.const 1
     i32.sub
     local.set $2
     local.get $0
     if
      local.get $3
      i32.load16_u
      local.tee $0
      local.get $1
      i32.load16_u
      local.tee $4
      i32.ne
      if
       local.get $0
       local.get $4
       i32.sub
       br $__inlined_func$~lib/util/string/compareImpl$75
      end
      local.get $3
      i32.const 2
      i32.add
      local.set $3
      local.get $1
      i32.const 2
      i32.add
      local.set $1
      br $while-continue|12
     end
    end
    i32.const 0
   end
   i32.eqz
  end
  i32.eqz
  if
   i32.const 0
   i32.const 64
   i32.const 7
   i32.const 1
   call $~lib/builtins/abort
   unreachable
  end
 )
)
