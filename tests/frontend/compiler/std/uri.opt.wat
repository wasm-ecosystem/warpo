(module
 (type $0 (func (param i32 i32) (result i32)))
 (type $1 (func (param i32) (result i32)))
 (type $2 (func))
 (type $3 (func (param i32 i32 i32)))
 (type $4 (func (param i32)))
 (type $5 (func (param i32 i32)))
 (type $6 (func (param i32 i32 i32) (result i32)))
 (type $7 (func (param i32 i32 i32 i32)))
 (type $8 (func (param i32 i32 i64)))
 (type $9 (func (result i32)))
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
 (data $0.1 (i32.const 24) "\02")
 (data $1 (i32.const 45) "\01\01\01\01\01\00\00\00\00\01\01\00\00\01")
 (data $1.1 (i32.const 69) "\01\01\01\01\01\01\01")
 (data $1.2 (i32.const 102) "\01\01\01\01\00\01")
 (data $1.3 (i32.const 134) "\01\01\01")
 (data $2 (i32.const 140) "<")
 (data $2.1 (i32.const 152) "\02\00\00\00(\00\00\00A\00l\00l\00o\00c\00a\00t\00i\00o\00n\00 \00t\00o\00o\00 \00l\00a\00r\00g\00e")
 (data $3 (i32.const 204) "<")
 (data $3.1 (i32.const 216) "\02\00\00\00 \00\00\00~\00l\00i\00b\00/\00r\00t\00/\00i\00t\00c\00m\00s\00.\00t\00s")
 (data $6 (i32.const 332) "<")
 (data $6.1 (i32.const 344) "\02\00\00\00$\00\00\00I\00n\00d\00e\00x\00 \00o\00u\00t\00 \00o\00f\00 \00r\00a\00n\00g\00e")
 (data $7 (i32.const 396) ",")
 (data $7.1 (i32.const 408) "\02\00\00\00\14\00\00\00~\00l\00i\00b\00/\00r\00t\00.\00t\00s")
 (data $9 (i32.const 476) "<")
 (data $9.1 (i32.const 488) "\02\00\00\00\1e\00\00\00~\00l\00i\00b\00/\00r\00t\00/\00t\00l\00s\00f\00.\00t\00s")
 (data $10 (i32.const 540) ",")
 (data $10.1 (i32.const 552) "\02\00\00\00\1a\00\00\00U\00R\00I\00 \00m\00a\00l\00f\00o\00r\00m\00e\00d")
 (data $11 (i32.const 588) "<")
 (data $11.1 (i32.const 600) "\02\00\00\00 \00\00\00~\00l\00i\00b\00/\00u\00t\00i\00l\00/\00u\00r\00i\00.\00t\00s")
 (data $12 (i32.const 652) "0123456789ABCDEF")
 (data $13 (i32.const 668) ",")
 (data $13.1 (i32.const 680) "\02\00\00\00\14\00\00\00s\00t\00d\00/\00u\00r\00i\00.\00t\00s")
 (data $14 (i32.const 716) "\1c")
 (data $14.1 (i32.const 728) "\02\00\00\00\02\00\00\00a")
 (data $15 (i32.const 748) "\1c")
 (data $15.1 (i32.const 760) "\02\00\00\00\04\00\00\00a\001")
 (data $16 (i32.const 780) "\1c")
 (data $16.1 (i32.const 792) "\02\00\00\00\06\00\00\00a\00b\00_")
 (data $17 (i32.const 812) "\\")
 (data $17.1 (i32.const 824) "\02\00\00\00H\00\00\00A\00B\00C\00D\00X\00Y\00Z\00a\00f\00g\00k\00l\00m\00n\00w\00y\00z\000\001\002\003\004\005\006\007\008\009\00-\00_\00.\00!\00~\00*\00\'\00(\00)")
 (data $18 (i32.const 908) "\1c")
 (data $18.1 (i32.const 920) "\02\00\00\00\02")
 (data $19 (i32.const 940) "\1c")
 (data $19.1 (i32.const 952) "\02\00\00\00\06\00\00\00%\000\000")
 (data $20 (i32.const 972) "\1c")
 (data $20.1 (i32.const 984) "\02\00\00\00\02\00\00\00+")
 (data $21 (i32.const 1004) "\1c")
 (data $21.1 (i32.const 1016) "\02\00\00\00\06\00\00\00%\002\00B")
 (data $22 (i32.const 1036) "\1c")
 (data $22.1 (i32.const 1048) "\02\00\00\00\06\00\00\00#\000\00=")
 (data $23 (i32.const 1068) ",")
 (data $23.1 (i32.const 1080) "\02\00\00\00\0e\00\00\00%\002\003\000\00%\003\00D")
 (data $24 (i32.const 1116) "\1c")
 (data $24.1 (i32.const 1128) "\02\00\00\00\n\00\00\00 \001\002\003\00 ")
 (data $25 (i32.const 1148) ",")
 (data $25.1 (i32.const 1160) "\02\00\00\00\12\00\00\00%\002\000\001\002\003\00%\002\000")
 (data $26 (i32.const 1196) "\1c")
 (data $26.1 (i32.const 1208) "\02\00\00\00\04\00\00\00?\00+")
 (data $27 (i32.const 1228) "\1c")
 (data $27.1 (i32.const 1240) "\02\00\00\00\0c\00\00\00%\003\00F\00%\002\00B")
 (data $28 (i32.const 1260) "\1c")
 (data $28.1 (i32.const 1272) "\02\00\00\00\n\00\00\00-\00?\001\00.\00-")
 (data $29 (i32.const 1292) ",")
 (data $29.1 (i32.const 1304) "\02\00\00\00\0e\00\00\00-\00%\003\00F\001\00.\00-")
 (data $30 (i32.const 1340) "\1c")
 (data $30.1 (i32.const 1352) "\02\00\00\00\0c\00\00\00<\d8\ed\dd<\d8\fa\dd<\d8N\df")
 (data $31 (i32.const 1372) "\\")
 (data $31.1 (i32.const 1384) "\02\00\00\00H\00\00\00%\00F\000\00%\009\00F\00%\008\007\00%\00A\00D\00%\00F\000\00%\009\00F\00%\008\007\00%\00B\00A\00%\00F\000\00%\009\00F\00%\008\00D\00%\008\00E")
 (data $32 (i32.const 1468) "\1c")
 (data $32.1 (i32.const 1480) "\02\00\00\00\n\00\00\00H\c5U\b1X\d58\c1\94\c6")
 (data $33 (i32.const 1500) "l")
 (data $33.1 (i32.const 1512) "\02\00\00\00Z\00\00\00%\00E\00C\00%\009\005\00%\008\008\00%\00E\00B\00%\008\005\00%\009\005\00%\00E\00D\00%\009\005\00%\009\008\00%\00E\00C\00%\008\004\00%\00B\008\00%\00E\00C\00%\009\00A\00%\009\004")
 (data $34 (i32.const 1612) "\1c")
 (data $34.1 (i32.const 1624) "\02\00\00\00\06\00\00\00~\00\7f\00\80")
 (data $35 (i32.const 1644) ",")
 (data $35.1 (i32.const 1656) "\02\00\00\00\14\00\00\00~\00%\007\00F\00%\00C\002\00%\008\000")
 (data $36 (i32.const 1692) "\1c")
 (data $36.1 (i32.const 1704) "\02\00\00\00\04\00\00\00\00\d8\ff\df")
 (data $37 (i32.const 1724) ",")
 (data $37.1 (i32.const 1736) "\02\00\00\00\18\00\00\00%\00F\000\00%\009\000\00%\008\00F\00%\00B\00F")
 (data $38 (i32.const 1772) "\1c")
 (data $38.1 (i32.const 1784) "\02\00\00\00\n\00\00\00{\da\01\dc-\00P\da\02\dc")
 (data $39 (i32.const 1804) "L")
 (data $39.1 (i32.const 1816) "\02\00\00\002\00\00\00%\00F\002\00%\00A\00E\00%\00B\000\00%\008\001\00-\00%\00F\002\00%\00A\004\00%\008\000\00%\008\002")
 (data $40 (i32.const 1884) "\1c")
 (data $40.1 (i32.const 1896) "\02\00\00\00\n\00\00\00\n\00\t\00\0b\00\0c\00\r")
 (data $41 (i32.const 1916) "<")
 (data $41.1 (i32.const 1928) "\02\00\00\00\1e\00\00\00%\000\00A\00%\000\009\00%\000\00B\00%\000\00C\00%\000\00D")
 (data $42 (i32.const 1980) ",")
 (data $42.1 (i32.const 1992) "\02\00\00\00\14\00\00\00;\00/\00?\00:\00@\00&\00=\00+\00$\00,")
 (data $43 (i32.const 2028) "L")
 (data $43.1 (i32.const 2040) "\02\00\00\00<\00\00\00%\003\00B\00%\002\00F\00%\003\00F\00%\003\00A\00%\004\000\00%\002\006\00%\003\00D\00%\002\00B\00%\002\004\00%\002\00C")
 (data $44 (i32.const 2108) "l")
 (data $44.1 (i32.const 2120) "\02\00\00\00\\\00\00\00h\00t\00t\00p\00:\00/\00/\00e\00n\00.\00w\00i\00k\00i\00p\00e\00d\00i\00a\00.\00o\00r\00g\00/\00w\00i\00k\00i\00/\00U\00T\00F\00-\008\00#\00D\00e\00s\00c\00r\00i\00p\00t\00i\00o\00n")
 (data $45 (i32.const 2220) "\8c")
 (data $45.1 (i32.const 2232) "\02\00\00\00t\00\00\00h\00t\00t\00p\00%\003\00A\00%\002\00F\00%\002\00F\00e\00n\00.\00w\00i\00k\00i\00p\00e\00d\00i\00a\00.\00o\00r\00g\00%\002\00F\00w\00i\00k\00i\00%\002\00F\00U\00T\00F\00-\008\00%\002\003\00D\00e\00s\00c\00r\00i\00p\00t\00i\00o\00n")
 (data $46 (i32.const 2365) "\01\00\00\01")
 (data $46.1 (i32.const 2391) "\01\00\01")
 (data $46.2 (i32.const 2422) "\01\01\01\01\00\01")
 (data $46.3 (i32.const 2454) "\01\01\01")
 (data $47 (i32.const 2460) ",")
 (data $47.1 (i32.const 2472) "\02\00\00\00\16\00\00\00;\00,\00/\00?\00:\00@\00&\00=\00+\00$\00#")
 (data $48 (i32.const 2508) "\1c")
 (data $48.1 (i32.const 2520) "\02\00\00\00\02\00\00\00 ")
 (data $49 (i32.const 2540) "\1c")
 (data $49.1 (i32.const 2552) "\02\00\00\00\06\00\00\00%\002\000")
 (data $50 (i32.const 2572) "\01\01\00\01\00\00\00\00\01\01\00\00\01")
 (data $50.1 (i32.const 2595) "\01\01\00\01\00\01\01")
 (data $51 (i32.const 2604) "\1c")
 (data $51.1 (i32.const 2616) "\02\00\00\00\06\00\00\00%\002\006")
 (data $52 (i32.const 2636) "\1c")
 (data $52.1 (i32.const 2648) "\02\00\00\00\02\00\00\00&")
 (data $53 (i32.const 2668) "\1c")
 (data $53.1 (i32.const 2680) "\02\00\00\00\06\00\00\00%\005\00E")
 (data $54 (i32.const 2700) "\1c")
 (data $54.1 (i32.const 2712) "\02\00\00\00\02\00\00\00^")
 (data $55 (i32.const 2732) "\1c")
 (data $55.1 (i32.const 2744) "\02\00\00\00\02\00\00\00\00\d8")
 (data $56 (i32.const 2764) "L")
 (data $56.1 (i32.const 2776) "\02\00\00\00<\00\00\00%\003\00b\00%\002\00f\00%\003\00f\00%\003\00a\00%\004\000\00%\003\00d\00%\002\00b\00%\002\004\00%\002\00c\00%\002\003")
 (data $57 (i32.const 2844) ",")
 (data $57.1 (i32.const 2856) "\02\00\00\00\14\00\00\00;\00/\00?\00:\00@\00=\00+\00$\00,\00#")
 (data $58 (i32.const 2892) "L")
 (data $58.1 (i32.const 2904) "\02\00\00\00<\00\00\00%\003\00B\00%\002\00F\00%\003\00F\00%\003\00A\00%\004\000\00%\003\00D\00%\002\00B\00%\002\004\00%\002\00C\00%\002\003")
 (data $59 (i32.const 2972) "|")
 (data $59.1 (i32.const 2984) "\02\00\00\00h\00\00\00h\00t\00t\00p\00:\00%\002\00F\00%\002\00F\00e\00n\00.\00w\00i\00k\00i\00p\00e\00d\00i\00a\00.\00o\00r\00g\00/\00w\00i\00k\00i\00/\00U\00T\00F\00-\008\00%\002\003\00D\00e\00s\00c\00r\00i\00p\00t\00i\00o\00n")
 (data $60 (i32.const 3100) "\1c")
 (data $60.1 (i32.const 3112) "\02\00\00\00\0c\00\00\00%\00D\00F\00%\008\000")
 (data $61 (i32.const 3132) "\1c")
 (data $61.1 (i32.const 3144) "\02\00\00\00\02\00\00\00\c0\07")
 (data $62 (i32.const 3164) "\1c")
 (data $62.1 (i32.const 3176) "\02\00\00\00\0c\00\00\00%\00C\002\00%\00B\00F")
 (data $63 (i32.const 3196) "\1c")
 (data $63.1 (i32.const 3208) "\02\00\00\00\02\00\00\00\bf")
 (data $64 (i32.const 3228) ",")
 (data $64.1 (i32.const 3240) "\02\00\00\00\0e\00\00\00\f7\00\b8\00W\00\ef\00\0f\00\f4\00V")
 (data $65 (i32.const 3276) "\1c")
 (data $65.1 (i32.const 3288) "\02\00\00\00\06\00\00\00\f4\00\b8\00\ef")
 (data $66 (i32.const 3312) "\04\00\00\00 \00\00\00 \00\00\00 ")
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
     i32.const 224
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
      i32.const 224
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
      i32.const 36100
      i32.lt_u
      i32.and
      i32.eqz
      if
       i32.const 0
       i32.const 224
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
      i32.const 224
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
     i32.const 3312
     i32.load
     i32.gt_u
     if
      i32.const 352
      i32.const 416
      i32.const 22
      i32.const 28
      call $~lib/builtins/abort
      unreachable
     end
     local.get $0
     i32.const 2
     i32.shl
     i32.const 3316
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
   i32.const 496
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
   i32.const 496
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
   i32.const 496
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
   i32.const 496
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
   i32.const 496
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
    i32.const 496
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
   i32.const 496
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
   i32.const 496
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
   i32.const 496
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
    i32.const 496
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
     i32.const 496
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
     i32.const 496
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
  i32.const 36112
  i32.const 0
  i32.store
  i32.const 37680
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
    i32.const 36112
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
      i32.const 36112
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
  i32.const 36112
  i32.const 37684
  memory.size
  i64.extend_i32_s
  i64.const 16
  i64.shl
  call $~lib/rt/tlsf/addMemory
  i32.const 36112
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
     i32.const 36100
     local.set $0
     loop $while-continue|0
      local.get $0
      i32.const 36100
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
     i32.const 224
     i32.const 229
     i32.const 20
     call $~lib/builtins/abort
     unreachable
    end
    local.get $0
    i32.const 36100
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
     i32.const 36100
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
       i32.const 496
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
   i32.const 496
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
     i32.const 496
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
   i32.const 160
   i32.const 224
   i32.const 262
   i32.const 31
   call $~lib/builtins/abort
   unreachable
  end
  global.get $~lib/rt/itcms/total
  global.get $~lib/rt/itcms/threshold
  i32.ge_u
  if
   block $__inlined_func$~lib/rt/itcms/interrupt$69
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
      br $__inlined_func$~lib/rt/itcms/interrupt$69
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
   i32.const 160
   i32.const 496
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
    i32.const 496
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
   i32.const 496
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
   i32.const 496
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
 (func $~lib/rt/itcms/__renew (param $0 i32) (param $1 i32) (result i32)
  (local $2 i32)
  (local $3 i32)
  local.get $1
  local.get $0
  i32.const 20
  i32.sub
  local.tee $2
  i32.load
  i32.const -4
  i32.and
  i32.const 16
  i32.sub
  i32.le_u
  if
   local.get $2
   local.get $1
   i32.store offset=16
   local.get $0
   return
  end
  local.get $1
  local.get $2
  i32.load offset=12
  call $~lib/rt/itcms/__new
  local.tee $3
  local.get $0
  local.get $1
  local.get $2
  i32.load offset=16
  local.tee $0
  local.get $0
  local.get $1
  i32.gt_u
  select
  memory.copy
  local.get $3
 )
 (func $~lib/util/uri/storeHex (param $0 i32) (param $1 i32) (param $2 i32)
  local.get $0
  local.get $1
  i32.add
  local.tee $0
  i32.const 37
  i32.store16
  local.get $0
  local.get $2
  i32.const 4
  i32.shr_u
  i32.const 15
  i32.and
  i32.const 652
  i32.add
  i32.load8_u
  local.get $2
  i32.const 15
  i32.and
  i32.const 652
  i32.add
  i32.load8_u
  i32.const 16
  i32.shl
  i32.or
  i32.store offset=2
 )
 (func $~lib/util/uri/encode (param $0 i32) (param $1 i32) (param $2 i32) (result i32)
  (local $3 i32)
  (local $4 i32)
  (local $5 i32)
  (local $6 i32)
  (local $7 i32)
  (local $8 i32)
  (local $9 i32)
  local.get $1
  i32.eqz
  if
   local.get $0
   return
  end
  local.get $1
  i32.const 1
  i32.shl
  local.tee $8
  i32.const 2
  call $~lib/rt/itcms/__new
  local.set $5
  loop $while-continue|0
   local.get $1
   local.get $6
   i32.gt_u
   if
    block $while-break|0
     local.get $6
     local.set $7
     loop $do-loop|1
      block $do-break|1
       local.get $0
       local.get $6
       i32.const 1
       i32.shl
       i32.add
       i32.load16_u
       local.tee $3
       i32.const 33
       i32.sub
       i32.const 94
       i32.ge_u
       br_if $do-break|1
       local.get $2
       local.get $3
       i32.const 33
       i32.sub
       i32.add
       i32.load8_u
       br_if $do-break|1
       local.get $6
       i32.const 1
       i32.add
       local.tee $6
       local.get $1
       i32.lt_u
       br_if $do-loop|1
      end
     end
     local.get $6
     local.get $7
     i32.gt_u
     if
      local.get $6
      local.get $7
      i32.sub
      i32.const 1
      i32.shl
      local.tee $9
      local.get $4
      i32.add
      local.get $8
      i32.gt_u
      if
       local.get $5
       local.get $4
       local.get $9
       i32.add
       local.tee $8
       call $~lib/rt/itcms/__renew
       local.set $5
      end
      local.get $4
      local.get $5
      i32.add
      local.get $0
      local.get $7
      i32.const 1
      i32.shl
      i32.add
      local.get $9
      memory.copy
      local.get $4
      local.get $9
      i32.add
      local.set $4
      local.get $1
      local.get $6
      i32.le_u
      br_if $while-break|0
     end
     local.get $3
     i32.const 55296
     i32.ge_u
     if
      local.get $3
      i32.const 57343
      i32.le_u
      local.get $3
      i32.const 56320
      i32.ge_u
      i32.and
      if
       i32.const 560
       i32.const 608
       i32.const 73
       i32.const 9
       call $~lib/builtins/abort
       unreachable
      end
      local.get $3
      i32.const 56319
      i32.le_u
      if (result i32)
       local.get $1
       local.get $6
       i32.le_u
       if
        i32.const 560
        i32.const 608
        i32.const 77
        i32.const 11
        call $~lib/builtins/abort
        unreachable
       end
       local.get $0
       local.get $6
       i32.const 1
       i32.add
       local.tee $6
       i32.const 1
       i32.shl
       i32.add
       i32.load16_u
       local.tee $7
       i32.const 56320
       i32.lt_u
       local.get $7
       i32.const 57343
       i32.gt_u
       i32.or
       if
        i32.const 560
        i32.const 608
        i32.const 81
        i32.const 11
        call $~lib/builtins/abort
        unreachable
       end
       local.get $7
       i32.const 1023
       i32.and
       local.get $3
       i32.const 1023
       i32.and
       i32.const 10
       i32.shl
       i32.or
       i32.const 65536
       i32.add
      else
       local.get $3
      end
      local.set $3
     end
     local.get $4
     i32.const 6
     i32.const 24
     local.get $3
     i32.const 128
     i32.lt_u
     select
     i32.add
     local.tee $7
     local.get $8
     i32.gt_u
     if
      local.get $5
      local.get $7
      i32.const 1
      i32.shl
      local.get $7
      local.get $1
      i32.const 1
      i32.gt_u
      select
      local.tee $8
      call $~lib/rt/itcms/__renew
      local.set $5
     end
     local.get $3
     i32.const 128
     i32.lt_u
     if
      local.get $5
      local.get $4
      local.get $3
      call $~lib/util/uri/storeHex
     else
      local.get $3
      i32.const 2048
      i32.lt_u
      if
       local.get $5
       local.get $4
       local.get $3
       i32.const 6
       i32.shr_u
       i32.const 192
       i32.or
       call $~lib/util/uri/storeHex
      else
       local.get $5
       local.get $3
       i32.const 65536
       i32.lt_u
       if (result i32)
        local.get $5
        local.get $4
        local.get $3
        i32.const 12
        i32.shr_u
        i32.const 224
        i32.or
        call $~lib/util/uri/storeHex
        local.get $4
        i32.const 6
        i32.add
       else
        local.get $5
        local.get $4
        local.get $3
        i32.const 18
        i32.shr_u
        i32.const 240
        i32.or
        call $~lib/util/uri/storeHex
        local.get $5
        local.get $4
        i32.const 6
        i32.add
        local.tee $7
        local.get $3
        i32.const 12
        i32.shr_u
        i32.const 63
        i32.and
        i32.const 128
        i32.or
        call $~lib/util/uri/storeHex
        local.get $7
        i32.const 6
        i32.add
       end
       local.tee $4
       local.get $3
       i32.const 6
       i32.shr_u
       i32.const 63
       i32.and
       i32.const 128
       i32.or
       call $~lib/util/uri/storeHex
      end
      local.get $5
      local.get $4
      i32.const 6
      i32.add
      local.tee $4
      local.get $3
      i32.const 63
      i32.and
      i32.const 128
      i32.or
      call $~lib/util/uri/storeHex
     end
     local.get $4
     i32.const 6
     i32.add
     local.set $4
     local.get $6
     i32.const 1
     i32.add
     local.set $6
     br $while-continue|0
    end
   end
  end
  local.get $4
  local.get $8
  i32.lt_u
  if (result i32)
   local.get $5
   local.get $4
   call $~lib/rt/itcms/__renew
  else
   local.get $5
  end
 )
 (func $~lib/uri/encodeURIComponent (param $0 i32) (result i32)
  local.get $0
  local.get $0
  i32.const 20
  i32.sub
  i32.load offset=16
  i32.const 1
  i32.shr_u
  i32.const 44
  call $~lib/util/uri/encode
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
  block $__inlined_func$~lib/util/string/compareImpl$77 (result i32)
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
      br $__inlined_func$~lib/util/string/compareImpl$77
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
 (func $~lib/uri/encodeURI (param $0 i32) (result i32)
  local.get $0
  local.get $0
  i32.const 20
  i32.sub
  i32.load offset=16
  i32.const 1
  i32.shr_u
  i32.const 2364
  call $~lib/util/uri/encode
 )
 (func $~lib/util/uri/loadHex (param $0 i32) (param $1 i32) (result i32)
  (local $2 i32)
  local.get $0
  local.get $1
  i32.add
  local.tee $0
  i32.load16_u offset=2
  local.tee $1
  i32.const 32
  i32.or
  local.tee $2
  i32.const 97
  i32.sub
  i32.const 6
  i32.lt_u
  local.get $1
  i32.const 48
  i32.sub
  i32.const 10
  i32.lt_u
  i32.or
  local.get $0
  i32.load16_u
  local.tee $0
  i32.const 32
  i32.or
  i32.const 97
  i32.sub
  i32.const 6
  i32.lt_u
  local.get $0
  i32.const 48
  i32.sub
  i32.const 10
  i32.lt_u
  i32.or
  i32.and
  if (result i32)
   local.get $2
   i32.const 39
   i32.rem_u
   i32.const 9
   i32.sub
   local.get $0
   i32.const 32
   i32.or
   i32.const 39
   i32.rem_u
   i32.const 9
   i32.sub
   i32.const 4
   i32.shl
   i32.or
  else
   i32.const -1
  end
 )
 (func $~lib/util/uri/decode (param $0 i32) (param $1 i32) (param $2 i32) (result i32)
  (local $3 i32)
  (local $4 i32)
  (local $5 i32)
  (local $6 i32)
  (local $7 i32)
  (local $8 i32)
  (local $9 i32)
  local.get $1
  i32.eqz
  if
   local.get $0
   return
  end
  local.get $1
  i32.const 1
  i32.shl
  i32.const 2
  call $~lib/rt/itcms/__new
  local.set $7
  loop $while-continue|0
   local.get $1
   local.get $4
   i32.gt_u
   if
    block $while-break|0
     local.get $4
     local.set $5
     loop $while-continue|1
      local.get $1
      local.get $4
      i32.gt_u
      if (result i32)
       local.get $0
       local.get $4
       i32.const 1
       i32.shl
       i32.add
       i32.load16_u
       local.tee $3
       i32.const 37
       i32.ne
      else
       i32.const 0
      end
      if
       local.get $4
       i32.const 1
       i32.add
       local.set $4
       br $while-continue|1
      end
     end
     local.get $4
     local.get $5
     i32.gt_u
     if
      local.get $6
      local.get $7
      i32.add
      local.get $0
      local.get $5
      i32.const 1
      i32.shl
      i32.add
      local.get $4
      local.get $5
      i32.sub
      i32.const 1
      i32.shl
      local.tee $5
      memory.copy
      local.get $5
      local.get $6
      i32.add
      local.set $6
      local.get $1
      local.get $4
      i32.le_u
      br_if $while-break|0
     end
     local.get $3
     i32.const 37
     i32.ne
     local.get $4
     i32.const 2
     i32.add
     local.get $1
     i32.ge_u
     i32.or
     if (result i32)
      i32.const 1
     else
      local.get $0
      local.get $4
      i32.const 1
      i32.add
      i32.const 1
      i32.shl
      call $~lib/util/uri/loadHex
      local.tee $3
      i32.const -1
      i32.eq
     end
     if
      i32.const 560
      i32.const 608
      i32.const 151
      i32.const 7
      call $~lib/builtins/abort
      unreachable
     end
     local.get $4
     i32.const 3
     i32.add
     local.set $4
     local.get $3
     i32.const 128
     i32.lt_u
     if
      local.get $2
      if (result i32)
       i32.const 0
      else
       local.get $3
       i32.const 35
       i32.sub
       local.tee $5
       i32.const 30
       i32.lt_u
       if (result i32)
        local.get $5
        i32.const 2572
        i32.add
        i32.load8_u
       else
        i32.const 0
       end
      end
      if
       i32.const 37
       local.set $3
       local.get $4
       i32.const 2
       i32.sub
       local.set $4
      end
     else
      i32.const 1
      local.get $3
      i32.const 24
      i32.shl
      i32.const -1
      i32.xor
      i32.clz
      i32.const 0
      local.get $3
      i32.const 192
      i32.sub
      i32.const 56
      i32.lt_u
      select
      local.tee $5
      i32.const 17
      i32.mul
      i32.const 2
      i32.shr_u
      i32.const 1
      i32.sub
      i32.shl
      local.set $8
      local.get $3
      i32.const 128
      local.get $5
      i32.shr_u
      i32.const 1
      i32.sub
      i32.const 0
      local.get $5
      select
      i32.and
      local.set $3
      loop $while-continue|2
       local.get $5
       i32.const 1
       i32.sub
       local.tee $5
       if
        block $while-break|2
         local.get $4
         i32.const 2
         i32.add
         local.get $1
         i32.ge_u
         if (result i32)
          i32.const 1
         else
          local.get $0
          local.get $4
          i32.const 1
          i32.shl
          i32.add
          i32.load16_u
          i32.const 37
          i32.ne
         end
         if (result i32)
          i32.const 1
         else
          local.get $0
          local.get $4
          i32.const 1
          i32.add
          i32.const 1
          i32.shl
          call $~lib/util/uri/loadHex
          local.tee $9
          i32.const -1
          i32.eq
         end
         if
          i32.const 560
          i32.const 608
          i32.const 171
          i32.const 11
          call $~lib/builtins/abort
          unreachable
         end
         local.get $4
         i32.const 3
         i32.add
         local.set $4
         local.get $9
         i32.const 192
         i32.and
         i32.const 128
         i32.ne
         if
          i32.const 0
          local.set $3
          br $while-break|2
         end
         local.get $9
         i32.const 63
         i32.and
         local.get $3
         i32.const 6
         i32.shl
         i32.or
         local.set $3
         br $while-continue|2
        end
       end
      end
      local.get $3
      i32.const 57344
      i32.lt_u
      local.get $3
      i32.const 55296
      i32.ge_u
      i32.and
      local.get $8
      i32.const -1
      i32.eq
      local.get $3
      local.get $8
      i32.lt_u
      i32.or
      local.get $3
      i32.const 1114111
      i32.gt_u
      i32.or
      i32.or
      if
       i32.const 560
       i32.const 608
       i32.const 183
       i32.const 9
       call $~lib/builtins/abort
       unreachable
      end
      local.get $3
      i32.const 65536
      i32.ge_u
      if
       local.get $6
       local.get $7
       i32.add
       local.get $3
       i32.const 65536
       i32.sub
       local.tee $3
       i32.const 1023
       i32.and
       i32.const 56320
       i32.or
       i32.const 16
       i32.shl
       local.get $3
       i32.const 10
       i32.shr_u
       i32.const 55296
       i32.or
       i32.or
       i32.store
       local.get $6
       i32.const 4
       i32.add
       local.set $6
       br $while-continue|0
      end
     end
     local.get $6
     local.get $7
     i32.add
     local.get $3
     i32.store16
     local.get $6
     i32.const 2
     i32.add
     local.set $6
     br $while-continue|0
    end
   end
  end
  local.get $1
  i32.const 1
  i32.shl
  local.get $6
  i32.lt_u
  if
   i32.const 0
   i32.const 608
   i32.const 200
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  local.get $1
  i32.const 1
  i32.shl
  local.get $6
  i32.gt_u
  if (result i32)
   local.get $7
   local.get $6
   call $~lib/rt/itcms/__renew
  else
   local.get $7
  end
 )
 (func $~lib/uri/decodeURIComponent (param $0 i32) (result i32)
  local.get $0
  local.get $0
  i32.const 20
  i32.sub
  i32.load offset=16
  i32.const 1
  i32.shr_u
  i32.const 1
  call $~lib/util/uri/decode
 )
 (func $~lib/uri/decodeURI (param $0 i32) (result i32)
  local.get $0
  local.get $0
  i32.const 20
  i32.sub
  i32.load offset=16
  i32.const 1
  i32.shr_u
  i32.const 0
  call $~lib/util/uri/decode
 )
 (func $~lib/rt/__visit_members (param $0 i32)
  block $invalid
   block $~lib/arraybuffer/ArrayBufferView
    block $~lib/string/String
     local.get $0
     i32.const 8
     i32.sub
     i32.load
     br_table $~lib/string/String $~lib/string/String $~lib/string/String $~lib/arraybuffer/ArrayBufferView $invalid
    end
    return
   end
   local.get $0
   i32.load
   call $~lib/rt/itcms/__visit
   return
  end
  unreachable
 )
 (func $~start
  memory.size
  i32.const 16
  i32.shl
  i32.const 36100
  i32.sub
  i32.const 1
  i32.shr_u
  global.set $~lib/rt/itcms/threshold
  i32.const 276
  i32.const 272
  i32.store
  i32.const 280
  i32.const 272
  i32.store
  i32.const 272
  global.set $~lib/rt/itcms/pinSpace
  i32.const 308
  i32.const 304
  i32.store
  i32.const 312
  i32.const 304
  i32.store
  i32.const 304
  global.set $~lib/rt/itcms/toSpace
  i32.const 452
  i32.const 448
  i32.store
  i32.const 456
  i32.const 448
  i32.store
  i32.const 448
  global.set $~lib/rt/itcms/fromSpace
  i32.const 32
  call $~lib/uri/encodeURIComponent
  i32.const 32
  call $~lib/string/String.__eq
  i32.eqz
  if
   i32.const 0
   i32.const 688
   i32.const 3
   i32.const 1
   call $~lib/builtins/abort
   unreachable
  end
  i32.const 736
  call $~lib/uri/encodeURIComponent
  i32.const 736
  call $~lib/string/String.__eq
  i32.eqz
  if
   i32.const 0
   i32.const 688
   i32.const 4
   i32.const 1
   call $~lib/builtins/abort
   unreachable
  end
  i32.const 768
  call $~lib/uri/encodeURIComponent
  i32.const 768
  call $~lib/string/String.__eq
  i32.eqz
  if
   i32.const 0
   i32.const 688
   i32.const 5
   i32.const 1
   call $~lib/builtins/abort
   unreachable
  end
  i32.const 800
  call $~lib/uri/encodeURIComponent
  i32.const 800
  call $~lib/string/String.__eq
  i32.eqz
  if
   i32.const 0
   i32.const 688
   i32.const 6
   i32.const 1
   call $~lib/builtins/abort
   unreachable
  end
  i32.const 832
  call $~lib/uri/encodeURIComponent
  i32.const 832
  call $~lib/string/String.__eq
  i32.eqz
  if
   i32.const 0
   i32.const 688
   i32.const 7
   i32.const 1
   call $~lib/builtins/abort
   unreachable
  end
  i32.const 928
  call $~lib/uri/encodeURIComponent
  i32.const 960
  call $~lib/string/String.__eq
  i32.eqz
  if
   i32.const 0
   i32.const 688
   i32.const 8
   i32.const 1
   call $~lib/builtins/abort
   unreachable
  end
  i32.const 992
  call $~lib/uri/encodeURIComponent
  i32.const 1024
  call $~lib/string/String.__eq
  i32.eqz
  if
   i32.const 0
   i32.const 688
   i32.const 9
   i32.const 1
   call $~lib/builtins/abort
   unreachable
  end
  i32.const 1056
  call $~lib/uri/encodeURIComponent
  i32.const 1088
  call $~lib/string/String.__eq
  i32.eqz
  if
   i32.const 0
   i32.const 688
   i32.const 10
   i32.const 1
   call $~lib/builtins/abort
   unreachable
  end
  i32.const 1136
  call $~lib/uri/encodeURIComponent
  i32.const 1168
  call $~lib/string/String.__eq
  i32.eqz
  if
   i32.const 0
   i32.const 688
   i32.const 11
   i32.const 1
   call $~lib/builtins/abort
   unreachable
  end
  i32.const 1216
  call $~lib/uri/encodeURIComponent
  i32.const 1248
  call $~lib/string/String.__eq
  i32.eqz
  if
   i32.const 0
   i32.const 688
   i32.const 12
   i32.const 1
   call $~lib/builtins/abort
   unreachable
  end
  i32.const 1280
  call $~lib/uri/encodeURIComponent
  i32.const 1312
  call $~lib/string/String.__eq
  i32.eqz
  if
   i32.const 0
   i32.const 688
   i32.const 13
   i32.const 1
   call $~lib/builtins/abort
   unreachable
  end
  i32.const 1360
  call $~lib/uri/encodeURIComponent
  i32.const 1392
  call $~lib/string/String.__eq
  i32.eqz
  if
   i32.const 0
   i32.const 688
   i32.const 14
   i32.const 1
   call $~lib/builtins/abort
   unreachable
  end
  i32.const 1488
  call $~lib/uri/encodeURIComponent
  i32.const 1520
  call $~lib/string/String.__eq
  i32.eqz
  if
   i32.const 0
   i32.const 688
   i32.const 15
   i32.const 1
   call $~lib/builtins/abort
   unreachable
  end
  i32.const 1632
  call $~lib/uri/encodeURIComponent
  i32.const 1664
  call $~lib/string/String.__eq
  i32.eqz
  if
   i32.const 0
   i32.const 688
   i32.const 16
   i32.const 1
   call $~lib/builtins/abort
   unreachable
  end
  i32.const 1712
  call $~lib/uri/encodeURIComponent
  i32.const 1744
  call $~lib/string/String.__eq
  i32.eqz
  if
   i32.const 0
   i32.const 688
   i32.const 17
   i32.const 1
   call $~lib/builtins/abort
   unreachable
  end
  i32.const 1792
  call $~lib/uri/encodeURIComponent
  i32.const 1824
  call $~lib/string/String.__eq
  i32.eqz
  if
   i32.const 0
   i32.const 688
   i32.const 18
   i32.const 1
   call $~lib/builtins/abort
   unreachable
  end
  i32.const 1904
  call $~lib/uri/encodeURIComponent
  i32.const 1936
  call $~lib/string/String.__eq
  i32.eqz
  if
   i32.const 0
   i32.const 688
   i32.const 20
   i32.const 1
   call $~lib/builtins/abort
   unreachable
  end
  i32.const 2000
  call $~lib/uri/encodeURIComponent
  i32.const 2048
  call $~lib/string/String.__eq
  i32.eqz
  if
   i32.const 0
   i32.const 688
   i32.const 22
   i32.const 1
   call $~lib/builtins/abort
   unreachable
  end
  i32.const 2128
  call $~lib/uri/encodeURIComponent
  i32.const 2240
  call $~lib/string/String.__eq
  i32.eqz
  if
   i32.const 0
   i32.const 688
   i32.const 24
   i32.const 1
   call $~lib/builtins/abort
   unreachable
  end
  i32.const 32
  call $~lib/uri/encodeURI
  i32.const 32
  call $~lib/string/String.__eq
  i32.eqz
  if
   i32.const 0
   i32.const 688
   i32.const 34
   i32.const 1
   call $~lib/builtins/abort
   unreachable
  end
  i32.const 736
  call $~lib/uri/encodeURI
  i32.const 736
  call $~lib/string/String.__eq
  i32.eqz
  if
   i32.const 0
   i32.const 688
   i32.const 35
   i32.const 1
   call $~lib/builtins/abort
   unreachable
  end
  i32.const 2480
  call $~lib/uri/encodeURI
  i32.const 2480
  call $~lib/string/String.__eq
  i32.eqz
  if
   i32.const 0
   i32.const 688
   i32.const 36
   i32.const 1
   call $~lib/builtins/abort
   unreachable
  end
  i32.const 832
  call $~lib/uri/encodeURI
  i32.const 832
  call $~lib/string/String.__eq
  i32.eqz
  if
   i32.const 0
   i32.const 688
   i32.const 37
   i32.const 1
   call $~lib/builtins/abort
   unreachable
  end
  i32.const 2528
  call $~lib/uri/encodeURI
  i32.const 2560
  call $~lib/string/String.__eq
  i32.eqz
  if
   i32.const 0
   i32.const 688
   i32.const 38
   i32.const 1
   call $~lib/builtins/abort
   unreachable
  end
  i32.const 1632
  call $~lib/uri/encodeURI
  i32.const 1664
  call $~lib/string/String.__eq
  i32.eqz
  if
   i32.const 0
   i32.const 688
   i32.const 39
   i32.const 1
   call $~lib/builtins/abort
   unreachable
  end
  i32.const 1712
  call $~lib/uri/encodeURI
  i32.const 1744
  call $~lib/string/String.__eq
  i32.eqz
  if
   i32.const 0
   i32.const 688
   i32.const 40
   i32.const 1
   call $~lib/builtins/abort
   unreachable
  end
  i32.const 1904
  call $~lib/uri/encodeURI
  i32.const 1936
  call $~lib/string/String.__eq
  i32.eqz
  if
   i32.const 0
   i32.const 688
   i32.const 42
   i32.const 1
   call $~lib/builtins/abort
   unreachable
  end
  i32.const 2128
  call $~lib/uri/encodeURI
  i32.const 2128
  call $~lib/string/String.__eq
  i32.eqz
  if
   i32.const 0
   i32.const 688
   i32.const 43
   i32.const 1
   call $~lib/builtins/abort
   unreachable
  end
  i32.const 32
  call $~lib/uri/decodeURIComponent
  i32.const 32
  call $~lib/string/String.__eq
  i32.eqz
  if
   i32.const 0
   i32.const 688
   i32.const 50
   i32.const 1
   call $~lib/builtins/abort
   unreachable
  end
  i32.const 736
  call $~lib/uri/decodeURIComponent
  i32.const 736
  call $~lib/string/String.__eq
  i32.eqz
  if
   i32.const 0
   i32.const 688
   i32.const 51
   i32.const 1
   call $~lib/builtins/abort
   unreachable
  end
  i32.const 2624
  call $~lib/uri/decodeURIComponent
  i32.const 2656
  call $~lib/string/String.__eq
  i32.eqz
  if
   i32.const 0
   i32.const 688
   i32.const 52
   i32.const 1
   call $~lib/builtins/abort
   unreachable
  end
  i32.const 2688
  call $~lib/uri/decodeURIComponent
  i32.const 2720
  call $~lib/string/String.__eq
  i32.eqz
  if
   i32.const 0
   i32.const 688
   i32.const 53
   i32.const 1
   call $~lib/builtins/abort
   unreachable
  end
  i32.const 2752
  call $~lib/uri/decodeURIComponent
  i32.const 2752
  call $~lib/string/String.__eq
  i32.eqz
  if
   i32.const 0
   i32.const 688
   i32.const 54
   i32.const 1
   call $~lib/builtins/abort
   unreachable
  end
  i32.const 1712
  call $~lib/uri/decodeURIComponent
  i32.const 1712
  call $~lib/string/String.__eq
  i32.eqz
  if
   i32.const 0
   i32.const 688
   i32.const 55
   i32.const 1
   call $~lib/builtins/abort
   unreachable
  end
  i32.const 2784
  call $~lib/uri/decodeURIComponent
  i32.const 2864
  call $~lib/string/String.__eq
  i32.eqz
  if
   i32.const 0
   i32.const 688
   i32.const 56
   i32.const 1
   call $~lib/builtins/abort
   unreachable
  end
  i32.const 2912
  call $~lib/uri/decodeURIComponent
  i32.const 2864
  call $~lib/string/String.__eq
  i32.eqz
  if
   i32.const 0
   i32.const 688
   i32.const 57
   i32.const 1
   call $~lib/builtins/abort
   unreachable
  end
  i32.const 2992
  call $~lib/uri/decodeURIComponent
  i32.const 2128
  call $~lib/string/String.__eq
  i32.eqz
  if
   i32.const 0
   i32.const 688
   i32.const 58
   i32.const 1
   call $~lib/builtins/abort
   unreachable
  end
  i32.const 1392
  call $~lib/uri/decodeURIComponent
  i32.const 1360
  call $~lib/string/String.__eq
  i32.eqz
  if
   i32.const 0
   i32.const 688
   i32.const 63
   i32.const 1
   call $~lib/builtins/abort
   unreachable
  end
  i32.const 32
  call $~lib/uri/decodeURI
  i32.const 32
  call $~lib/string/String.__eq
  i32.eqz
  if
   i32.const 0
   i32.const 688
   i32.const 73
   i32.const 1
   call $~lib/builtins/abort
   unreachable
  end
  i32.const 736
  call $~lib/uri/decodeURI
  i32.const 736
  call $~lib/string/String.__eq
  i32.eqz
  if
   i32.const 0
   i32.const 688
   i32.const 74
   i32.const 1
   call $~lib/builtins/abort
   unreachable
  end
  i32.const 2624
  call $~lib/uri/decodeURI
  i32.const 2624
  call $~lib/string/String.__eq
  i32.eqz
  if
   i32.const 0
   i32.const 688
   i32.const 75
   i32.const 1
   call $~lib/builtins/abort
   unreachable
  end
  i32.const 3120
  call $~lib/uri/decodeURI
  i32.const 3152
  call $~lib/string/String.__eq
  i32.eqz
  if
   i32.const 0
   i32.const 688
   i32.const 76
   i32.const 1
   call $~lib/builtins/abort
   unreachable
  end
  i32.const 3184
  call $~lib/uri/decodeURI
  i32.const 3216
  call $~lib/string/String.__eq
  i32.eqz
  if
   i32.const 0
   i32.const 688
   i32.const 77
   i32.const 1
   call $~lib/builtins/abort
   unreachable
  end
  i32.const 2752
  call $~lib/uri/decodeURI
  i32.const 2752
  call $~lib/string/String.__eq
  i32.eqz
  if
   i32.const 0
   i32.const 688
   i32.const 78
   i32.const 1
   call $~lib/builtins/abort
   unreachable
  end
  i32.const 1712
  call $~lib/uri/decodeURI
  i32.const 1712
  call $~lib/string/String.__eq
  i32.eqz
  if
   i32.const 0
   i32.const 688
   i32.const 79
   i32.const 1
   call $~lib/builtins/abort
   unreachable
  end
  i32.const 2784
  call $~lib/uri/decodeURI
  i32.const 2784
  call $~lib/string/String.__eq
  i32.eqz
  if
   i32.const 0
   i32.const 688
   i32.const 80
   i32.const 1
   call $~lib/builtins/abort
   unreachable
  end
  i32.const 1392
  call $~lib/uri/decodeURI
  i32.const 1360
  call $~lib/string/String.__eq
  i32.eqz
  if
   i32.const 0
   i32.const 688
   i32.const 81
   i32.const 1
   call $~lib/builtins/abort
   unreachable
  end
  i32.const 3248
  call $~lib/uri/decodeURI
  i32.const 3248
  call $~lib/string/String.__eq
  i32.eqz
  if
   i32.const 0
   i32.const 688
   i32.const 82
   i32.const 1
   call $~lib/builtins/abort
   unreachable
  end
  i32.const 3296
  call $~lib/uri/decodeURI
  i32.const 3296
  call $~lib/string/String.__eq
  i32.eqz
  if
   i32.const 0
   i32.const 688
   i32.const 83
   i32.const 1
   call $~lib/builtins/abort
   unreachable
  end
  i32.const 2992
  call $~lib/uri/decodeURI
  i32.const 2992
  call $~lib/string/String.__eq
  i32.eqz
  if
   i32.const 0
   i32.const 688
   i32.const 84
   i32.const 1
   call $~lib/builtins/abort
   unreachable
  end
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
 )
)
