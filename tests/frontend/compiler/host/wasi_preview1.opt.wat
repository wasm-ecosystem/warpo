(module
 (type $0 (func (param i32 i32 i32 i32) (result i32)))
 (type $1 (func (param i32)))
 (type $2 (func (param i32 i32)))
 (type $3 (func))
 (type $4 (func (param i32 i32 i32 i32)))
 (type $5 (func (param i32) (result i32)))
 (type $6 (func (param i32 i32 i64)))
 (type $7 (func (param i32 i32) (result i32)))
 (import "wasi_snapshot_preview1" "fd_write" (func $~lib/wasi_snapshot_preview1/bindings/wasi_snapshot_preview1/fd_write (param i32 i32 i32 i32) (result i32)))
 (import "wasi_snapshot_preview1" "proc_exit" (func $~lib/wasi_snapshot_preview1/bindings/wasi_snapshot_preview1/proc_exit (param i32)))
 (global $~lib/rt/tlsf/ROOT (mut i32) (i32.const 0))
 (global $~argumentsLength (mut i32) (i32.const 0))
 (memory $0 1)
 (data $0 (i32.const 12) "L")
 (data $0.1 (i32.const 24) "\02\00\00\00.\00\00\00w\00a\00s\00i\00_\00p\00r\00e\00v\00i\00e\00w\001\00.\00t\00s\00 \00l\00o\00a\00d\00e\00d")
 (data $2 (i32.const 124) "<")
 (data $2.1 (i32.const 136) "\02\00\00\00$\00\00\00U\00n\00p\00a\00i\00r\00e\00d\00 \00s\00u\00r\00r\00o\00g\00a\00t\00e")
 (data $3 (i32.const 188) ",")
 (data $3.1 (i32.const 200) "\02\00\00\00\1c\00\00\00~\00l\00i\00b\00/\00s\00t\00r\00i\00n\00g\00.\00t\00s")
 (data $4 (i32.const 236) ",")
 (data $4.1 (i32.const 248) "\02\00\00\00\0e\00\00\00S\00U\00C\00C\00E\00S\00S")
 (data $5 (i32.const 284) "\1c")
 (data $5.1 (i32.const 296) "\02\00\00\00\0c\00\00\00T\00O\00O\00B\00I\00G")
 (data $6 (i32.const 316) "\1c")
 (data $6.1 (i32.const 328) "\02\00\00\00\n\00\00\00A\00C\00C\00E\00S")
 (data $7 (i32.const 348) ",")
 (data $7.1 (i32.const 360) "\02\00\00\00\12\00\00\00A\00D\00D\00R\00I\00N\00U\00S\00E")
 (data $8 (i32.const 396) ",")
 (data $8.1 (i32.const 408) "\02\00\00\00\18\00\00\00A\00D\00D\00R\00N\00O\00T\00A\00V\00A\00I\00L")
 (data $9 (i32.const 444) ",")
 (data $9.1 (i32.const 456) "\02\00\00\00\16\00\00\00A\00F\00N\00O\00S\00U\00P\00P\00O\00R\00T")
 (data $10 (i32.const 492) "\1c")
 (data $10.1 (i32.const 504) "\02\00\00\00\n\00\00\00A\00G\00A\00I\00N")
 (data $11 (i32.const 524) ",")
 (data $11.1 (i32.const 536) "\02\00\00\00\0e\00\00\00A\00L\00R\00E\00A\00D\00Y")
 (data $12 (i32.const 572) "\1c")
 (data $12.1 (i32.const 584) "\02\00\00\00\08\00\00\00B\00A\00D\00F")
 (data $13 (i32.const 604) "\1c")
 (data $13.1 (i32.const 616) "\02\00\00\00\0c\00\00\00B\00A\00D\00M\00S\00G")
 (data $14 (i32.const 636) "\1c")
 (data $14.1 (i32.const 648) "\02\00\00\00\08\00\00\00B\00U\00S\00Y")
 (data $15 (i32.const 668) ",")
 (data $15.1 (i32.const 680) "\02\00\00\00\10\00\00\00C\00A\00N\00C\00E\00L\00E\00D")
 (data $16 (i32.const 716) "\1c")
 (data $16.1 (i32.const 728) "\02\00\00\00\n\00\00\00C\00H\00I\00L\00D")
 (data $17 (i32.const 748) ",")
 (data $17.1 (i32.const 760) "\02\00\00\00\16\00\00\00C\00O\00N\00N\00A\00B\00O\00R\00T\00E\00D")
 (data $18 (i32.const 796) ",")
 (data $18.1 (i32.const 808) "\02\00\00\00\16\00\00\00C\00O\00N\00N\00R\00E\00F\00U\00S\00E\00D")
 (data $19 (i32.const 844) ",")
 (data $19.1 (i32.const 856) "\02\00\00\00\12\00\00\00C\00O\00N\00N\00R\00E\00S\00E\00T")
 (data $20 (i32.const 892) "\1c")
 (data $20.1 (i32.const 904) "\02\00\00\00\0c\00\00\00D\00E\00A\00D\00L\00K")
 (data $21 (i32.const 924) ",")
 (data $21.1 (i32.const 936) "\02\00\00\00\16\00\00\00D\00E\00S\00T\00A\00D\00D\00R\00R\00E\00Q")
 (data $22 (i32.const 972) "\1c")
 (data $22.1 (i32.const 984) "\02\00\00\00\06\00\00\00D\00O\00M")
 (data $23 (i32.const 1004) "\1c")
 (data $23.1 (i32.const 1016) "\02\00\00\00\n\00\00\00D\00Q\00U\00O\00T")
 (data $24 (i32.const 1036) "\1c")
 (data $24.1 (i32.const 1048) "\02\00\00\00\n\00\00\00E\00X\00I\00S\00T")
 (data $25 (i32.const 1068) "\1c")
 (data $25.1 (i32.const 1080) "\02\00\00\00\n\00\00\00F\00A\00U\00L\00T")
 (data $26 (i32.const 1100) "\1c")
 (data $26.1 (i32.const 1112) "\02\00\00\00\08\00\00\00F\00B\00I\00G")
 (data $27 (i32.const 1132) ",")
 (data $27.1 (i32.const 1144) "\02\00\00\00\16\00\00\00H\00O\00S\00T\00U\00N\00R\00E\00A\00C\00H")
 (data $28 (i32.const 1180) "\1c")
 (data $28.1 (i32.const 1192) "\02\00\00\00\08\00\00\00I\00D\00R\00M")
 (data $29 (i32.const 1212) "\1c")
 (data $29.1 (i32.const 1224) "\02\00\00\00\n\00\00\00I\00L\00S\00E\00Q")
 (data $30 (i32.const 1244) ",")
 (data $30.1 (i32.const 1256) "\02\00\00\00\14\00\00\00I\00N\00P\00R\00O\00G\00R\00E\00S\00S")
 (data $31 (i32.const 1292) "\1c")
 (data $31.1 (i32.const 1304) "\02\00\00\00\08\00\00\00I\00N\00T\00R")
 (data $32 (i32.const 1324) "\1c")
 (data $32.1 (i32.const 1336) "\02\00\00\00\n\00\00\00I\00N\00V\00A\00L")
 (data $33 (i32.const 1356) "\1c")
 (data $33.1 (i32.const 1368) "\02\00\00\00\04\00\00\00I\00O")
 (data $34 (i32.const 1388) "\1c")
 (data $34.1 (i32.const 1400) "\02\00\00\00\0c\00\00\00I\00S\00C\00O\00N\00N")
 (data $35 (i32.const 1420) "\1c")
 (data $35.1 (i32.const 1432) "\02\00\00\00\n\00\00\00I\00S\00D\00I\00R")
 (data $36 (i32.const 1452) "\1c")
 (data $36.1 (i32.const 1464) "\02\00\00\00\08\00\00\00L\00O\00O\00P")
 (data $37 (i32.const 1484) "\1c")
 (data $37.1 (i32.const 1496) "\02\00\00\00\n\00\00\00M\00F\00I\00L\00E")
 (data $38 (i32.const 1516) "\1c")
 (data $38.1 (i32.const 1528) "\02\00\00\00\n\00\00\00M\00L\00I\00N\00K")
 (data $39 (i32.const 1548) ",")
 (data $39.1 (i32.const 1560) "\02\00\00\00\0e\00\00\00M\00S\00G\00S\00I\00Z\00E")
 (data $40 (i32.const 1596) ",")
 (data $40.1 (i32.const 1608) "\02\00\00\00\10\00\00\00M\00U\00L\00T\00I\00H\00O\00P")
 (data $41 (i32.const 1644) ",")
 (data $41.1 (i32.const 1656) "\02\00\00\00\16\00\00\00N\00A\00M\00E\00T\00O\00O\00L\00O\00N\00G")
 (data $42 (i32.const 1692) ",")
 (data $42.1 (i32.const 1704) "\02\00\00\00\0e\00\00\00N\00E\00T\00D\00O\00W\00N")
 (data $43 (i32.const 1740) ",")
 (data $43.1 (i32.const 1752) "\02\00\00\00\10\00\00\00N\00E\00T\00R\00E\00S\00E\00T")
 (data $44 (i32.const 1788) ",")
 (data $44.1 (i32.const 1800) "\02\00\00\00\14\00\00\00N\00E\00T\00U\00N\00R\00E\00A\00C\00H")
 (data $45 (i32.const 1836) "\1c")
 (data $45.1 (i32.const 1848) "\02\00\00\00\n\00\00\00N\00F\00I\00L\00E")
 (data $46 (i32.const 1868) "\1c")
 (data $46.1 (i32.const 1880) "\02\00\00\00\0c\00\00\00N\00O\00B\00U\00F\00S")
 (data $47 (i32.const 1900) "\1c")
 (data $47.1 (i32.const 1912) "\02\00\00\00\n\00\00\00N\00O\00D\00E\00V")
 (data $48 (i32.const 1932) "\1c")
 (data $48.1 (i32.const 1944) "\02\00\00\00\n\00\00\00N\00O\00E\00N\00T")
 (data $49 (i32.const 1964) "\1c")
 (data $49.1 (i32.const 1976) "\02\00\00\00\0c\00\00\00N\00O\00E\00X\00E\00C")
 (data $50 (i32.const 1996) "\1c")
 (data $50.1 (i32.const 2008) "\02\00\00\00\n\00\00\00N\00O\00L\00C\00K")
 (data $51 (i32.const 2028) "\1c")
 (data $51.1 (i32.const 2040) "\02\00\00\00\0c\00\00\00N\00O\00L\00I\00N\00K")
 (data $52 (i32.const 2060) "\1c")
 (data $52.1 (i32.const 2072) "\02\00\00\00\n\00\00\00N\00O\00M\00E\00M")
 (data $53 (i32.const 2092) "\1c")
 (data $53.1 (i32.const 2104) "\02\00\00\00\n\00\00\00N\00O\00M\00S\00G")
 (data $54 (i32.const 2124) ",")
 (data $54.1 (i32.const 2136) "\02\00\00\00\14\00\00\00N\00O\00P\00R\00O\00T\00O\00O\00P\00T")
 (data $55 (i32.const 2172) "\1c")
 (data $55.1 (i32.const 2184) "\02\00\00\00\n\00\00\00N\00O\00S\00P\00C")
 (data $56 (i32.const 2204) "\1c")
 (data $56.1 (i32.const 2216) "\02\00\00\00\n\00\00\00N\00O\00S\00Y\00S")
 (data $57 (i32.const 2236) ",")
 (data $57.1 (i32.const 2248) "\02\00\00\00\0e\00\00\00N\00O\00T\00C\00O\00N\00N")
 (data $58 (i32.const 2284) "\1c")
 (data $58.1 (i32.const 2296) "\02\00\00\00\0c\00\00\00N\00O\00T\00D\00I\00R")
 (data $59 (i32.const 2316) ",")
 (data $59.1 (i32.const 2328) "\02\00\00\00\10\00\00\00N\00O\00T\00E\00M\00P\00T\00Y")
 (data $60 (i32.const 2364) ",")
 (data $60.1 (i32.const 2376) "\02\00\00\00\1c\00\00\00N\00O\00T\00R\00E\00C\00O\00V\00E\00R\00A\00B\00L\00E")
 (data $61 (i32.const 2412) ",")
 (data $61.1 (i32.const 2424) "\02\00\00\00\0e\00\00\00N\00O\00T\00S\00O\00C\00K")
 (data $62 (i32.const 2460) "\1c")
 (data $62.1 (i32.const 2472) "\02\00\00\00\0c\00\00\00N\00O\00T\00S\00U\00P")
 (data $63 (i32.const 2492) "\1c")
 (data $63.1 (i32.const 2504) "\02\00\00\00\n\00\00\00N\00O\00T\00T\00Y")
 (data $64 (i32.const 2524) "\1c")
 (data $64.1 (i32.const 2536) "\02\00\00\00\08\00\00\00N\00X\00I\00O")
 (data $65 (i32.const 2556) ",")
 (data $65.1 (i32.const 2568) "\02\00\00\00\10\00\00\00O\00V\00E\00R\00F\00L\00O\00W")
 (data $66 (i32.const 2604) ",")
 (data $66.1 (i32.const 2616) "\02\00\00\00\12\00\00\00O\00W\00N\00E\00R\00D\00E\00A\00D")
 (data $67 (i32.const 2652) "\1c")
 (data $67.1 (i32.const 2664) "\02\00\00\00\08\00\00\00P\00E\00R\00M")
 (data $68 (i32.const 2684) "\1c")
 (data $68.1 (i32.const 2696) "\02\00\00\00\08\00\00\00P\00I\00P\00E")
 (data $69 (i32.const 2716) "\1c")
 (data $69.1 (i32.const 2728) "\02\00\00\00\n\00\00\00P\00R\00O\00T\00O")
 (data $70 (i32.const 2748) ",")
 (data $70.1 (i32.const 2760) "\02\00\00\00\1c\00\00\00P\00R\00O\00T\00O\00N\00O\00S\00U\00P\00P\00O\00R\00T")
 (data $71 (i32.const 2796) ",")
 (data $71.1 (i32.const 2808) "\02\00\00\00\12\00\00\00P\00R\00O\00T\00O\00T\00Y\00P\00E")
 (data $72 (i32.const 2844) "\1c")
 (data $72.1 (i32.const 2856) "\02\00\00\00\n\00\00\00R\00A\00N\00G\00E")
 (data $73 (i32.const 2876) "\1c")
 (data $73.1 (i32.const 2888) "\02\00\00\00\08\00\00\00R\00O\00F\00S")
 (data $74 (i32.const 2908) "\1c")
 (data $74.1 (i32.const 2920) "\02\00\00\00\n\00\00\00S\00P\00I\00P\00E")
 (data $75 (i32.const 2940) "\1c")
 (data $75.1 (i32.const 2952) "\02\00\00\00\08\00\00\00S\00R\00C\00H")
 (data $76 (i32.const 2972) "\1c")
 (data $76.1 (i32.const 2984) "\02\00\00\00\n\00\00\00S\00T\00A\00L\00E")
 (data $77 (i32.const 3004) ",")
 (data $77.1 (i32.const 3016) "\02\00\00\00\10\00\00\00T\00I\00M\00E\00D\00O\00U\00T")
 (data $78 (i32.const 3052) "\1c")
 (data $78.1 (i32.const 3064) "\02\00\00\00\0c\00\00\00T\00X\00T\00B\00S\00Y")
 (data $79 (i32.const 3084) "\1c")
 (data $79.1 (i32.const 3096) "\02\00\00\00\08\00\00\00X\00D\00E\00V")
 (data $80 (i32.const 3116) ",")
 (data $80.1 (i32.const 3128) "\02\00\00\00\14\00\00\00N\00O\00T\00C\00A\00P\00A\00B\00L\00E")
 (data $81 (i32.const 3164) ",")
 (data $81.1 (i32.const 3176) "\02\00\00\00\0e\00\00\00U\00N\00K\00N\00O\00W\00N")
 (data $82 (i32.const 3212) "l")
 (data $82.1 (i32.const 3224) "\02\00\00\00V\00\00\00~\00l\00i\00b\00/\00w\00a\00s\00i\00_\00s\00n\00a\00p\00s\00h\00o\00t\00_\00p\00r\00e\00v\00i\00e\00w\001\00/\00w\00a\00s\00i\00_\00p\00r\00o\00c\00e\00s\00s\00.\00t\00s")
 (data $83 (i32.const 3324) "<")
 (data $83.1 (i32.const 3336) "\02\00\00\00\1e\00\00\00~\00l\00i\00b\00/\00r\00t\00/\00t\00l\00s\00f\00.\00t\00s")
 (data $84 (i32.const 3388) "<")
 (data $84.1 (i32.const 3400) "\02\00\00\00(\00\00\00A\00l\00l\00o\00c\00a\00t\00i\00o\00n\00 \00t\00o\00o\00 \00l\00a\00r\00g\00e")
 (data $85 (i32.const 3452) "\1c")
 (data $85.1 (i32.const 3464) "\02\00\00\00\02\00\00\00\n")
 (export "memory" (memory $0))
 (start $~start)
 (func $~lib/string/String.UTF8.encodeUnsafe@varargs (param $0 i32) (param $1 i32) (param $2 i32) (param $3 i32) (result i32)
  (local $4 i32)
  (local $5 i32)
  (local $6 i32)
  block $2of2
   block $1of2
    block $outOfRange
     global.get $~argumentsLength
     i32.const 3
     i32.sub
     br_table $1of2 $1of2 $2of2 $outOfRange
    end
    unreachable
   end
   i32.const 0
   local.set $3
  end
  local.get $0
  local.get $1
  i32.const 1
  i32.shl
  i32.add
  local.set $5
  local.get $2
  local.set $1
  loop $while-continue|0
   local.get $0
   local.get $5
   i32.lt_u
   if
    local.get $0
    i32.load16_u
    local.tee $4
    i32.const 128
    i32.lt_u
    if (result i32)
     local.get $1
     local.get $4
     i32.store8
     local.get $1
     i32.const 1
     i32.add
    else
     local.get $4
     i32.const 2048
     i32.lt_u
     if (result i32)
      local.get $1
      local.get $4
      i32.const 6
      i32.shr_u
      i32.const 192
      i32.or
      local.get $4
      i32.const 63
      i32.and
      i32.const 128
      i32.or
      i32.const 8
      i32.shl
      i32.or
      i32.store16
      local.get $1
      i32.const 2
      i32.add
     else
      local.get $4
      i32.const 63488
      i32.and
      i32.const 55296
      i32.eq
      if
       local.get $4
       i32.const 56320
       i32.lt_u
       local.get $0
       i32.const 2
       i32.add
       local.get $5
       i32.lt_u
       i32.and
       if
        local.get $0
        i32.load16_u offset=2
        local.tee $6
        i32.const 64512
        i32.and
        i32.const 56320
        i32.eq
        if
         local.get $1
         local.get $4
         i32.const 1023
         i32.and
         i32.const 10
         i32.shl
         i32.const 65536
         i32.add
         local.get $6
         i32.const 1023
         i32.and
         i32.or
         local.tee $4
         i32.const 18
         i32.shr_u
         i32.const 240
         i32.or
         local.get $4
         i32.const 63
         i32.and
         i32.const 128
         i32.or
         i32.const 24
         i32.shl
         local.get $4
         i32.const 6
         i32.shr_u
         i32.const 63
         i32.and
         i32.const 128
         i32.or
         i32.const 16
         i32.shl
         i32.or
         local.get $4
         i32.const 12
         i32.shr_u
         i32.const 63
         i32.and
         i32.const 128
         i32.or
         i32.const 8
         i32.shl
         i32.or
         i32.or
         i32.store
         local.get $1
         i32.const 4
         i32.add
         local.set $1
         local.get $0
         i32.const 4
         i32.add
         local.set $0
         br $while-continue|0
        end
       end
       local.get $3
       if (result i32)
        local.get $3
        i32.const 2
        i32.eq
        if
         i32.const 144
         i32.const 208
         i32.const 785
         i32.const 49
         call $~lib/wasi_snapshot_preview1/wasi_internal/wasi_abort
         unreachable
        end
        i32.const 65533
       else
        local.get $4
       end
       local.set $4
      end
      local.get $1
      local.get $4
      i32.const 12
      i32.shr_u
      i32.const 224
      i32.or
      local.get $4
      i32.const 6
      i32.shr_u
      i32.const 63
      i32.and
      i32.const 128
      i32.or
      i32.const 8
      i32.shl
      i32.or
      i32.store16
      local.get $1
      local.get $4
      i32.const 63
      i32.and
      i32.const 128
      i32.or
      i32.store8 offset=2
      local.get $1
      i32.const 3
      i32.add
     end
    end
    local.set $1
    local.get $0
    i32.const 2
    i32.add
    local.set $0
    br $while-continue|0
   end
  end
  local.get $1
  local.get $2
  i32.sub
 )
 (func $~lib/wasi_snapshot_preview1/wasi_internal/wasi_abort (param $0 i32) (param $1 i32) (param $2 i32) (param $3 i32)
  (local $4 i32)
  i32.const 0
  i32.const 12
  i32.store
  i32.const 12
  i64.const 9071471065260641
  i64.store
  i32.const 19
  local.set $4
  local.get $0
  if
   local.get $0
   local.get $0
   i32.const 20
   i32.sub
   i32.load offset=16
   i32.const 1
   i32.shr_u
   i32.const 19
   i32.const 3
   global.set $~argumentsLength
   i32.const 0
   call $~lib/string/String.UTF8.encodeUnsafe@varargs
   i32.const 19
   i32.add
   local.set $4
  end
  local.get $4
  i32.const 544106784
  i32.store
  local.get $4
  i32.const 4
  i32.add
  local.set $4
  local.get $1
  if
   local.get $1
   local.get $1
   i32.const 20
   i32.sub
   i32.load offset=16
   i32.const 1
   i32.shr_u
   local.get $4
   i32.const 3
   global.set $~argumentsLength
   i32.const 0
   call $~lib/string/String.UTF8.encodeUnsafe@varargs
   local.get $4
   i32.add
   local.set $4
  end
  local.get $4
  i32.const 40
  i32.store8
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
  local.tee $0
  local.get $4
  i32.const 1
  i32.add
  i32.add
  local.set $4
  loop $do-loop|0
   local.get $4
   i32.const 1
   i32.sub
   local.tee $4
   local.get $2
   i32.const 10
   i32.rem_u
   i32.const 48
   i32.add
   i32.store8
   local.get $2
   i32.const 10
   i32.div_u
   local.tee $2
   br_if $do-loop|0
  end
  local.get $0
  local.get $4
  i32.add
  local.tee $0
  i32.const 1
  i32.add
  local.set $1
  local.get $0
  i32.const 58
  i32.store8
  local.get $3
  i32.const 10
  i32.ge_u
  i32.const 1
  i32.add
  local.get $3
  i32.const 10000
  i32.ge_u
  i32.const 3
  i32.add
  local.get $3
  i32.const 1000
  i32.ge_u
  i32.add
  local.get $3
  i32.const 100
  i32.lt_u
  select
  local.get $3
  i32.const 1000000
  i32.ge_u
  i32.const 6
  i32.add
  local.get $3
  i32.const 1000000000
  i32.ge_u
  i32.const 8
  i32.add
  local.get $3
  i32.const 100000000
  i32.ge_u
  i32.add
  local.get $3
  i32.const 10000000
  i32.lt_u
  select
  local.get $3
  i32.const 100000
  i32.lt_u
  select
  local.tee $0
  local.get $1
  i32.add
  local.set $4
  loop $do-loop|1
   local.get $4
   i32.const 1
   i32.sub
   local.tee $4
   local.get $3
   i32.const 10
   i32.rem_u
   i32.const 48
   i32.add
   i32.store8
   local.get $3
   i32.const 10
   i32.div_u
   local.tee $3
   br_if $do-loop|1
  end
  local.get $0
  local.get $4
  i32.add
  local.tee $0
  i32.const 2601
  i32.store16
  i32.const 4
  local.get $0
  i32.const 10
  i32.sub
  i32.store
  i32.const 2
  i32.const 0
  i32.const 1
  i32.const 8
  call $~lib/wasi_snapshot_preview1/bindings/wasi_snapshot_preview1/fd_write
  drop
  i32.const 255
  call $~lib/wasi_snapshot_preview1/bindings/wasi_snapshot_preview1/proc_exit
 )
 (func $~lib/wasi_snapshot_preview1/bindings/wasi_snapshot_preview1/errnoToString (param $0 i32) (result i32)
  block $break|0
   block $case76|0
    block $case75|0
     block $case74|0
      block $case73|0
       block $case72|0
        block $case71|0
         block $case70|0
          block $case69|0
           block $case68|0
            block $case67|0
             block $case66|0
              block $case65|0
               block $case64|0
                block $case63|0
                 block $case62|0
                  block $case61|0
                   block $case60|0
                    block $case59|0
                     block $case58|0
                      block $case57|0
                       block $case56|0
                        block $case55|0
                         block $case54|0
                          block $case53|0
                           block $case52|0
                            block $case51|0
                             block $case50|0
                              block $case49|0
                               block $case48|0
                                block $case47|0
                                 block $case46|0
                                  block $case45|0
                                   block $case44|0
                                    block $case43|0
                                     block $case42|0
                                      block $case41|0
                                       block $case40|0
                                        block $case39|0
                                         block $case38|0
                                          block $case37|0
                                           block $case36|0
                                            block $case35|0
                                             block $case34|0
                                              block $case33|0
                                               block $case32|0
                                                block $case31|0
                                                 block $case30|0
                                                  block $case29|0
                                                   block $case28|0
                                                    block $case27|0
                                                     block $case26|0
                                                      block $case25|0
                                                       block $case24|0
                                                        block $case23|0
                                                         block $case22|0
                                                          block $case21|0
                                                           block $case20|0
                                                            block $case19|0
                                                             block $case18|0
                                                              block $case17|0
                                                               block $case16|0
                                                                block $case15|0
                                                                 block $case14|0
                                                                  block $case13|0
                                                                   block $case12|0
                                                                    block $case11|0
                                                                     block $case10|0
                                                                      block $case9|0
                                                                       block $case8|0
                                                                        block $case7|0
                                                                         block $case6|0
                                                                          block $case5|0
                                                                           block $case4|0
                                                                            block $case3|0
                                                                             block $case2|0
                                                                              block $case1|0
                                                                               block $case0|0
                                                                                local.get $0
                                                                                i32.const 65535
                                                                                i32.and
                                                                                br_table $case0|0 $case1|0 $case2|0 $case3|0 $case4|0 $case5|0 $case6|0 $case7|0 $case8|0 $case9|0 $case10|0 $case11|0 $case12|0 $case13|0 $case14|0 $case15|0 $case16|0 $case17|0 $case18|0 $case19|0 $case20|0 $case21|0 $case22|0 $case23|0 $case24|0 $case25|0 $case26|0 $case27|0 $case28|0 $case29|0 $case30|0 $case31|0 $case32|0 $case33|0 $case34|0 $case35|0 $case36|0 $case37|0 $case38|0 $case39|0 $case40|0 $case41|0 $case42|0 $case43|0 $case44|0 $case45|0 $case46|0 $case47|0 $case48|0 $case49|0 $case50|0 $case51|0 $case52|0 $case53|0 $case54|0 $case55|0 $case56|0 $case57|0 $case58|0 $case59|0 $case60|0 $case61|0 $case62|0 $case63|0 $case64|0 $case65|0 $case66|0 $case67|0 $case68|0 $case69|0 $case70|0 $case71|0 $case72|0 $case73|0 $case74|0 $case75|0 $case76|0 $break|0
                                                                               end
                                                                               i32.const 256
                                                                               return
                                                                              end
                                                                              i32.const 304
                                                                              return
                                                                             end
                                                                             i32.const 336
                                                                             return
                                                                            end
                                                                            i32.const 368
                                                                            return
                                                                           end
                                                                           i32.const 416
                                                                           return
                                                                          end
                                                                          i32.const 464
                                                                          return
                                                                         end
                                                                         i32.const 512
                                                                         return
                                                                        end
                                                                        i32.const 544
                                                                        return
                                                                       end
                                                                       i32.const 592
                                                                       return
                                                                      end
                                                                      i32.const 624
                                                                      return
                                                                     end
                                                                     i32.const 656
                                                                     return
                                                                    end
                                                                    i32.const 688
                                                                    return
                                                                   end
                                                                   i32.const 736
                                                                   return
                                                                  end
                                                                  i32.const 768
                                                                  return
                                                                 end
                                                                 i32.const 816
                                                                 return
                                                                end
                                                                i32.const 864
                                                                return
                                                               end
                                                               i32.const 912
                                                               return
                                                              end
                                                              i32.const 944
                                                              return
                                                             end
                                                             i32.const 992
                                                             return
                                                            end
                                                            i32.const 1024
                                                            return
                                                           end
                                                           i32.const 1056
                                                           return
                                                          end
                                                          i32.const 1088
                                                          return
                                                         end
                                                         i32.const 1120
                                                         return
                                                        end
                                                        i32.const 1152
                                                        return
                                                       end
                                                       i32.const 1200
                                                       return
                                                      end
                                                      i32.const 1232
                                                      return
                                                     end
                                                     i32.const 1264
                                                     return
                                                    end
                                                    i32.const 1312
                                                    return
                                                   end
                                                   i32.const 1344
                                                   return
                                                  end
                                                  i32.const 1376
                                                  return
                                                 end
                                                 i32.const 1408
                                                 return
                                                end
                                                i32.const 1440
                                                return
                                               end
                                               i32.const 1472
                                               return
                                              end
                                              i32.const 1504
                                              return
                                             end
                                             i32.const 1536
                                             return
                                            end
                                            i32.const 1568
                                            return
                                           end
                                           i32.const 1616
                                           return
                                          end
                                          i32.const 1664
                                          return
                                         end
                                         i32.const 1712
                                         return
                                        end
                                        i32.const 1760
                                        return
                                       end
                                       i32.const 1808
                                       return
                                      end
                                      i32.const 1856
                                      return
                                     end
                                     i32.const 1888
                                     return
                                    end
                                    i32.const 1920
                                    return
                                   end
                                   i32.const 1952
                                   return
                                  end
                                  i32.const 1984
                                  return
                                 end
                                 i32.const 2016
                                 return
                                end
                                i32.const 2048
                                return
                               end
                               i32.const 2080
                               return
                              end
                              i32.const 2112
                              return
                             end
                             i32.const 2144
                             return
                            end
                            i32.const 2192
                            return
                           end
                           i32.const 2224
                           return
                          end
                          i32.const 2256
                          return
                         end
                         i32.const 2304
                         return
                        end
                        i32.const 2336
                        return
                       end
                       i32.const 2384
                       return
                      end
                      i32.const 2432
                      return
                     end
                     i32.const 2480
                     return
                    end
                    i32.const 2512
                    return
                   end
                   i32.const 2544
                   return
                  end
                  i32.const 2576
                  return
                 end
                 i32.const 2624
                 return
                end
                i32.const 2672
                return
               end
               i32.const 2704
               return
              end
              i32.const 2736
              return
             end
             i32.const 2768
             return
            end
            i32.const 2816
            return
           end
           i32.const 2864
           return
          end
          i32.const 2896
          return
         end
         i32.const 2928
         return
        end
        i32.const 2960
        return
       end
       i32.const 2992
       return
      end
      i32.const 3024
      return
     end
     i32.const 3072
     return
    end
    i32.const 3104
    return
   end
   i32.const 3136
   return
  end
  i32.const 3184
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
   i32.const 3344
   i32.const 245
   i32.const 14
   call $~lib/wasi_snapshot_preview1/wasi_internal/wasi_abort
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
   i32.const 3344
   i32.const 247
   i32.const 14
   call $~lib/wasi_snapshot_preview1/wasi_internal/wasi_abort
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
   i32.const 3344
   i32.const 261
   i32.const 14
   call $~lib/wasi_snapshot_preview1/wasi_internal/wasi_abort
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
   i32.const 3344
   i32.const 178
   i32.const 14
   call $~lib/wasi_snapshot_preview1/wasi_internal/wasi_abort
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
   i32.const 3344
   i32.const 180
   i32.const 14
   call $~lib/wasi_snapshot_preview1/wasi_internal/wasi_abort
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
    i32.const 3344
    i32.const 198
    i32.const 16
    call $~lib/wasi_snapshot_preview1/wasi_internal/wasi_abort
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
   i32.const 3344
   i32.const 210
   i32.const 14
   call $~lib/wasi_snapshot_preview1/wasi_internal/wasi_abort
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
   i32.const 3344
   i32.const 211
   i32.const 14
   call $~lib/wasi_snapshot_preview1/wasi_internal/wasi_abort
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
   i32.const 3344
   i32.const 228
   i32.const 14
   call $~lib/wasi_snapshot_preview1/wasi_internal/wasi_abort
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
    i32.const 3344
    i32.const 357
    i32.const 14
    call $~lib/wasi_snapshot_preview1/wasi_internal/wasi_abort
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
     i32.const 3344
     i32.const 365
     i32.const 16
     call $~lib/wasi_snapshot_preview1/wasi_internal/wasi_abort
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
     i32.const 3344
     i32.const 378
     i32.const 5
     call $~lib/wasi_snapshot_preview1/wasi_internal/wasi_abort
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
  i32.const 36256
  i32.const 0
  i32.store
  i32.const 37824
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
    i32.const 36256
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
      i32.const 36256
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
  i32.const 36256
  i32.const 37828
  memory.size
  i64.extend_i32_s
  i64.const 16
  i64.shl
  call $~lib/rt/tlsf/addMemory
  i32.const 36256
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
   i32.const 3344
   i32.const 309
   i32.const 14
   call $~lib/wasi_snapshot_preview1/wasi_internal/wasi_abort
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
     i32.const 3344
     i32.const 322
     i32.const 18
     call $~lib/wasi_snapshot_preview1/wasi_internal/wasi_abort
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
 (func $~lib/wasi_snapshot_preview1/wasi_process/writeString (param $0 i32)
  (local $1 i32)
  (local $2 i32)
  (local $3 i32)
  (local $4 i32)
  (local $5 i32)
  (local $6 i32)
  (local $7 i32)
  block $break|0
   block $case4|0
    block $case3|0
     block $case2|0
      block $case1|0
       block $case0|0
        local.get $0
        i32.const 20
        i32.sub
        i32.load offset=16
        i32.const 1
        i32.shr_u
        local.tee $7
        br_table $case4|0 $case3|0 $case2|0 $case1|0 $case0|0 $break|0
       end
       local.get $0
       i32.load16_u offset=6
       local.tee $1
       i32.const 128
       i32.ge_u
       br_if $break|0
      end
      local.get $0
      i32.load16_u offset=4
      local.tee $3
      i32.const 128
      i32.ge_u
      br_if $break|0
     end
     local.get $0
     i32.load16_u offset=2
     local.tee $4
     i32.const 128
     i32.ge_u
     br_if $break|0
    end
    local.get $0
    i32.load16_u
    local.tee $2
    i32.const 128
    i32.ge_u
    br_if $break|0
    i32.const 96
    i32.const 104
    i32.store
    i32.const 100
    local.get $7
    i32.store
    i32.const 104
    local.get $2
    local.get $4
    i32.const 8
    i32.shl
    i32.or
    local.get $3
    i32.const 16
    i32.shl
    i32.or
    local.get $1
    i32.const 24
    i32.shl
    i32.or
    i32.store
    i32.const 1
    i32.const 96
    i32.const 1
    i32.const 108
    call $~lib/wasi_snapshot_preview1/bindings/wasi_snapshot_preview1/fd_write
    local.tee $0
    i32.const 65535
    i32.and
    if
     local.get $0
     call $~lib/wasi_snapshot_preview1/bindings/wasi_snapshot_preview1/errnoToString
     i32.const 3232
     i32.const 178
     i32.const 16
     call $~lib/wasi_snapshot_preview1/wasi_internal/wasi_abort
     unreachable
    end
   end
   return
  end
  i32.const 0
  local.set $3
  local.get $0
  local.tee $1
  i32.const 20
  i32.sub
  i32.load offset=16
  local.get $1
  i32.add
  local.set $4
  loop $while-continue|0
   local.get $1
   local.get $4
   i32.lt_u
   if
    local.get $1
    i32.load16_u
    local.tee $2
    i32.const 128
    i32.lt_u
    if (result i32)
     local.get $3
     i32.const 1
     i32.add
    else
     local.get $2
     i32.const 2048
     i32.lt_u
     if (result i32)
      local.get $3
      i32.const 2
      i32.add
     else
      local.get $2
      i32.const 64512
      i32.and
      i32.const 55296
      i32.eq
      local.get $1
      i32.const 2
      i32.add
      local.get $4
      i32.lt_u
      i32.and
      if
       local.get $1
       i32.load16_u offset=2
       i32.const 64512
       i32.and
       i32.const 56320
       i32.eq
       if
        local.get $3
        i32.const 4
        i32.add
        local.set $3
        local.get $1
        i32.const 4
        i32.add
        local.set $1
        br $while-continue|0
       end
      end
      local.get $3
      i32.const 3
      i32.add
     end
    end
    local.set $3
    local.get $1
    i32.const 2
    i32.add
    local.set $1
    br $while-continue|0
   end
  end
  global.get $~lib/rt/tlsf/ROOT
  i32.eqz
  if
   call $~lib/rt/tlsf/initialize
  end
  global.get $~lib/rt/tlsf/ROOT
  local.set $5
  local.get $3
  i32.const 1073741820
  i32.gt_u
  if
   i32.const 3408
   i32.const 3344
   i32.const 435
   i32.const 29
   call $~lib/wasi_snapshot_preview1/wasi_internal/wasi_abort
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
  local.tee $2
  call $~lib/rt/tlsf/searchBlock
  local.tee $1
  i32.eqz
  if
   memory.size
   local.tee $4
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
   local.tee $1
   local.get $1
   local.get $4
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
   local.get $2
   call $~lib/rt/tlsf/searchBlock
   local.tee $1
   i32.eqz
   if
    i32.const 0
    i32.const 3344
    i32.const 472
    i32.const 16
    call $~lib/wasi_snapshot_preview1/wasi_internal/wasi_abort
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
   i32.const 3344
   i32.const 474
   i32.const 14
   call $~lib/wasi_snapshot_preview1/wasi_internal/wasi_abort
   unreachable
  end
  local.get $5
  local.get $1
  call $~lib/rt/tlsf/removeBlock
  local.get $1
  i32.load
  local.set $6
  local.get $2
  i32.const 4
  i32.add
  i32.const 15
  i32.and
  if
   i32.const 0
   i32.const 3344
   i32.const 336
   i32.const 14
   call $~lib/wasi_snapshot_preview1/wasi_internal/wasi_abort
   unreachable
  end
  local.get $6
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
   local.get $6
   i32.const 2
   i32.and
   i32.or
   i32.store
   local.get $1
   i32.const 4
   i32.add
   local.get $2
   i32.add
   local.tee $2
   local.get $4
   i32.const 4
   i32.sub
   i32.const 1
   i32.or
   i32.store
   local.get $5
   local.get $2
   call $~lib/rt/tlsf/insertBlock
  else
   local.get $1
   local.get $6
   i32.const -2
   i32.and
   i32.store
   local.get $1
   i32.const 4
   i32.add
   local.tee $4
   local.get $1
   i32.load
   i32.const -4
   i32.and
   local.tee $2
   i32.add
   local.get $2
   local.get $4
   i32.add
   i32.load
   i32.const -3
   i32.and
   i32.store
  end
  i32.const 3
  global.set $~argumentsLength
  local.get $0
  local.get $7
  local.get $1
  i32.const 4
  i32.add
  local.tee $2
  i32.const 0
  call $~lib/string/String.UTF8.encodeUnsafe@varargs
  local.get $3
  i32.ne
  if
   i32.const 0
   i32.const 3232
   i32.const 185
   i32.const 3
   call $~lib/wasi_snapshot_preview1/wasi_internal/wasi_abort
   unreachable
  end
  i32.const 96
  local.get $2
  i32.store
  i32.const 100
  local.get $3
  i32.store
  i32.const 1
  i32.const 96
  i32.const 1
  i32.const 104
  call $~lib/wasi_snapshot_preview1/bindings/wasi_snapshot_preview1/fd_write
  local.set $1
  local.get $2
  i32.const 36252
  i32.ge_u
  if
   global.get $~lib/rt/tlsf/ROOT
   i32.eqz
   if
    call $~lib/rt/tlsf/initialize
   end
   global.get $~lib/rt/tlsf/ROOT
   local.set $0
   local.get $2
   i32.const 4
   i32.sub
   local.set $3
   local.get $2
   i32.const 15
   i32.and
   i32.const 1
   local.get $2
   select
   if (result i32)
    i32.const 1
   else
    local.get $3
    i32.load
    i32.const 1
    i32.and
   end
   if
    i32.const 0
    i32.const 3344
    i32.const 532
    i32.const 3
    call $~lib/wasi_snapshot_preview1/wasi_internal/wasi_abort
    unreachable
   end
   local.get $3
   local.get $3
   i32.load
   i32.const 1
   i32.or
   i32.store
   local.get $0
   local.get $3
   call $~lib/rt/tlsf/insertBlock
  end
  local.get $1
  i32.const 65535
  i32.and
  if
   local.get $1
   call $~lib/wasi_snapshot_preview1/bindings/wasi_snapshot_preview1/errnoToString
   i32.const 3232
   i32.const 190
   i32.const 12
   call $~lib/wasi_snapshot_preview1/wasi_internal/wasi_abort
   unreachable
  end
 )
 (func $~start
  i32.const 32
  call $~lib/wasi_snapshot_preview1/wasi_process/writeString
  i32.const 3472
  call $~lib/wasi_snapshot_preview1/wasi_process/writeString
 )
)
