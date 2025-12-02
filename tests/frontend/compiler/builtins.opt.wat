(module
 (type $0 (func (param i32 i32 i32 i32)))
 (type $1 (func (param i32 i32) (result i32)))
 (type $2 (func))
 (type $3 (func (param i32 i32 f64 f64 f64 f64 f64)))
 (import "env" "abort" (func $~lib/builtins/abort (param i32 i32 i32 i32)))
 (import "env" "trace" (func $~lib/builtins/trace (param i32 i32 f64 f64 f64 f64 f64)))
 (global $builtins/i (mut i32) (i32.const 0))
 (global $builtins/I (mut i64) (i64.const 0))
 (global $builtins/f (mut f32) (f32.const 0))
 (global $builtins/F (mut f64) (f64.const 0))
 (memory $0 1)
 (data $0 (i32.const 12) "\1c")
 (data $0.1 (i32.const 24) "\02")
 (data $1 (i32.const 44) "\1c")
 (data $1.1 (i32.const 56) "\02\00\00\00\06\00\00\00a\00b\00c")
 (data $2 (i32.const 76) ",")
 (data $2.1 (i32.const 88) "\02\00\00\00\16\00\00\00b\00u\00i\00l\00t\00i\00n\00s\00.\00t\00s")
 (data $3 (i32.const 124) "\1c")
 (data $3.1 (i32.const 136) "\07\00\00\00\08\00\00\00\01")
 (data $4 (i32.const 156) "L")
 (data $4.1 (i32.const 168) "\02\00\00\008\00\00\00f\00u\00n\00c\00t\00i\00o\00n\00(\00)\00 \00{\00 \00[\00n\00a\00t\00i\00v\00e\00 \00c\00o\00d\00e\00]\00 \00}")
 (data $5 (i32.const 236) ",")
 (data $5.1 (i32.const 248) "\02\00\00\00\14\00\00\00s\00i\00g\00n\00a\00t\00u\00r\00e\00s")
 (data $6 (i32.const 284) ",")
 (data $6.1 (i32.const 296) "\02\00\00\00\0e\00\00\00t\00e\00s\00t\00i\00n\00g")
 (data $7 (i32.const 332) ",")
 (data $7.1 (i32.const 344) "\02\00\00\00\10\00\00\00F\00u\00n\00c\00t\00i\00o\00n")
 (data $8 (i32.const 380) "\1c")
 (data $8.1 (i32.const 392) "\02\00\00\00\02\00\00\00C")
 (data $9 (i32.const 412) "\1c")
 (data $9.1 (i32.const 424) "\02\00\00\00\0c\00\00\00S\00t\00r\00i\00n\00g")
 (data $10 (i32.const 444) "\1c")
 (data $10.1 (i32.const 456) "\02\00\00\00\08\00\00\00b\00o\00o\00l")
 (data $11 (i32.const 476) "\1c")
 (data $11.1 (i32.const 488) "\02\00\00\00\04\00\00\00i\008")
 (data $12 (i32.const 508) "\1c")
 (data $12.1 (i32.const 520) "\02\00\00\00\04\00\00\00u\008")
 (data $13 (i32.const 540) "\1c")
 (data $13.1 (i32.const 552) "\02\00\00\00\06\00\00\00i\001\006")
 (data $14 (i32.const 572) "\1c")
 (data $14.1 (i32.const 584) "\02\00\00\00\06\00\00\00u\001\006")
 (data $15 (i32.const 604) "\1c")
 (data $15.1 (i32.const 616) "\02\00\00\00\06\00\00\00i\003\002")
 (data $16 (i32.const 636) "\1c")
 (data $16.1 (i32.const 648) "\02\00\00\00\06\00\00\00u\003\002")
 (data $17 (i32.const 668) "\1c")
 (data $17.1 (i32.const 680) "\02\00\00\00\06\00\00\00f\003\002")
 (data $18 (i32.const 700) "\1c")
 (data $18.1 (i32.const 712) "\02\00\00\00\06\00\00\00i\006\004")
 (data $19 (i32.const 732) "\1c")
 (data $19.1 (i32.const 744) "\02\00\00\00\06\00\00\00u\006\004")
 (data $20 (i32.const 764) "\1c")
 (data $20.1 (i32.const 776) "\02\00\00\00\06\00\00\00f\006\004")
 (data $21 (i32.const 796) "\1c")
 (data $21.1 (i32.const 808) "\02\00\00\00\n\00\00\00i\00s\00i\00z\00e")
 (data $22 (i32.const 828) "\1c")
 (data $22.1 (i32.const 840) "\02\00\00\00\n\00\00\00u\00s\00i\00z\00e")
 (data $23 (i32.const 860) "\1c")
 (data $23.1 (i32.const 872) "\02\00\00\00\08\00\00\00v\00o\00i\00d")
 (data $24 (i32.const 892) ",")
 (data $24.1 (i32.const 904) "\02\00\00\00\14\00\00\00s\00o\00m\00e\00 \00v\00a\00l\00u\00e")
 (data $25 (i32.const 940) "\1c")
 (data $25.1 (i32.const 952) "\0c\00\00\00\08\00\00\00\02")
 (data $26 (i32.const 972) "\1c")
 (data $26.1 (i32.const 984) "\r\00\00\00\08\00\00\00\03")
 (table $0 4 4 funcref)
 (elem $0 (i32.const 1) $start:builtins~anonymous|0 $start:builtins~anonymous|1 $start:builtins~anonymous|2)
 (export "test" (func $start:builtins~anonymous|1))
 (export "memory" (memory $0))
 (start $~start)
 (func $start:builtins~anonymous|0 (param $0 i32) (param $1 i32) (result i32)
  local.get $0
  local.get $1
  i32.add
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
  block $__inlined_func$~lib/util/string/compareImpl$1 (result i32)
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
      br $__inlined_func$~lib/util/string/compareImpl$1
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
 (func $start:builtins~anonymous|1
  nop
 )
 (func $start:builtins~anonymous|2 (param $0 i32) (param $1 i32) (param $2 i32) (param $3 i32)
  unreachable
 )
 (func $~start
  i32.const 1
  global.set $builtins/i
  i32.const 0
  global.set $builtins/i
  i32.const 0
  global.set $builtins/i
  i32.const 1
  global.set $builtins/i
  i32.const 31
  global.set $builtins/i
  i32.const 0
  global.set $builtins/i
  i32.const 1
  global.set $builtins/i
  i32.const 2
  global.set $builtins/i
  i32.const -2147483648
  global.set $builtins/i
  i32.const 42
  global.set $builtins/i
  i32.const 2
  global.set $builtins/i
  i32.const 1
  global.set $builtins/i
  i32.const 3
  global.set $builtins/i
  i32.const 1
  global.set $builtins/i
  i32.const 6
  global.set $builtins/i
  i32.const 3
  global.set $builtins/i
  i32.const 1
  global.set $builtins/i
  i32.const 0
  global.set $builtins/i
  i32.const 0
  global.set $builtins/i
  i32.const 1
  global.set $builtins/i
  i32.const 1
  global.set $builtins/i
  i32.const 3
  global.set $builtins/i
  i64.const 63
  global.set $builtins/I
  i64.const 0
  global.set $builtins/I
  i64.const 1
  global.set $builtins/I
  i64.const 2
  global.set $builtins/I
  i64.const -9223372036854775808
  global.set $builtins/I
  i64.const 42
  global.set $builtins/I
  i64.const 2
  global.set $builtins/I
  i64.const 1
  global.set $builtins/I
  i64.const 3
  global.set $builtins/I
  i64.const 1
  global.set $builtins/I
  i64.const 6
  global.set $builtins/I
  i64.const 3
  global.set $builtins/I
  i32.const 1
  global.set $builtins/i
  i32.const 0
  global.set $builtins/i
  i32.const 0
  global.set $builtins/i
  i32.const 1
  global.set $builtins/i
  i64.const 1
  global.set $builtins/I
  i64.const 3
  global.set $builtins/I
  f32.const nan:0x400000
  global.set $builtins/f
  f32.const inf
  global.set $builtins/f
  f32.const 1.25
  global.set $builtins/f
  f32.const 2
  global.set $builtins/f
  f32.const 1.25
  global.set $builtins/f
  f32.const 1
  global.set $builtins/f
  f32.const 4
  global.set $builtins/f
  f32.const 1
  global.set $builtins/f
  f32.const 3
  global.set $builtins/f
  f32.const 3
  global.set $builtins/f
  f32.const 2.5
  global.set $builtins/f
  f32.const 1.25
  global.set $builtins/f
  f32.const 1
  global.set $builtins/f
  f32.const 1.1180340051651
  global.set $builtins/f
  f32.const 1
  global.set $builtins/f
  i32.const 1
  global.set $builtins/i
  i32.const 0
  global.set $builtins/i
  i32.const 0
  global.set $builtins/i
  i32.const 1
  global.set $builtins/i
  f64.const nan:0x8000000000000
  global.set $builtins/F
  f64.const inf
  global.set $builtins/F
  f64.const 1.25
  global.set $builtins/F
  f64.const 2
  global.set $builtins/F
  f64.const 1.25
  global.set $builtins/F
  f64.const 1
  global.set $builtins/F
  f64.const 4
  global.set $builtins/F
  f64.const 1
  global.set $builtins/F
  f64.const 3
  global.set $builtins/F
  f64.const 3
  global.set $builtins/F
  f64.const 2.5
  global.set $builtins/F
  f64.const 1.25
  global.set $builtins/F
  f64.const 1
  global.set $builtins/F
  f64.const 1.118033988749895
  global.set $builtins/F
  f64.const 1
  global.set $builtins/F
  i32.const 1
  global.set $builtins/i
  i32.const 0
  global.set $builtins/i
  i32.const 0
  global.set $builtins/i
  i32.const 1
  global.set $builtins/i
  f64.const 0
  global.set $builtins/F
  f32.const 1
  global.set $builtins/f
  f64.const 1.5
  global.set $builtins/F
  f32.const 1
  global.set $builtins/f
  f64.const 1
  global.set $builtins/F
  f32.const 1
  global.set $builtins/f
  f64.const 2
  global.set $builtins/F
  global.get $builtins/f
  global.get $builtins/f
  f32.add
  global.set $builtins/f
  f64.const 2
  global.set $builtins/F
  f32.const 2
  global.get $builtins/f
  f32.div
  global.set $builtins/f
  i32.const 8
  i32.load
  global.set $builtins/i
  i32.const 8
  global.get $builtins/i
  i32.store
  i32.const 8
  i32.const 8
  i32.load
  i32.store
  i32.const 8
  i64.load
  global.set $builtins/I
  i32.const 8
  global.get $builtins/I
  i64.store
  i32.const 8
  i32.const 8
  i64.load
  i64.store
  i32.const 8
  f32.load
  global.set $builtins/f
  i32.const 8
  global.get $builtins/f
  f32.store
  i32.const 8
  i32.const 8
  f32.load
  f32.store
  i32.const 8
  f64.load
  global.set $builtins/F
  i32.const 8
  global.get $builtins/F
  f64.store
  i32.const 8
  i32.const 8
  f64.load
  f64.store
  i32.const 8
  i32.load
  global.set $builtins/i
  i32.const 8
  global.get $builtins/i
  i32.store
  i32.const 8
  i32.const 8
  i32.load
  i32.store
  i32.const 8
  i64.load
  global.set $builtins/I
  i32.const 8
  global.get $builtins/I
  i64.store
  i32.const 8
  i32.const 8
  i64.load
  i64.store
  i32.const 8
  f32.load
  global.set $builtins/f
  i32.const 8
  global.get $builtins/f
  f32.store
  i32.const 8
  i32.const 8
  f32.load
  f32.store
  i32.const 8
  f64.load
  global.set $builtins/F
  i32.const 8
  global.get $builtins/F
  f64.store
  i32.const 8
  i32.const 8
  f64.load
  f64.store
  i32.const 8
  i32.load8_s
  global.set $builtins/i
  i32.const 8
  i32.load16_s
  global.set $builtins/i
  i32.const 8
  i32.load
  global.set $builtins/i
  i32.const 8
  i32.load8_u
  global.set $builtins/i
  i32.const 8
  i32.load16_u
  global.set $builtins/i
  i32.const 8
  i32.load
  global.set $builtins/i
  i32.const 8
  i64.load8_s
  global.set $builtins/I
  i32.const 8
  i64.load16_s
  global.set $builtins/I
  i32.const 8
  i64.load32_s
  global.set $builtins/I
  i32.const 8
  i64.load
  global.set $builtins/I
  i32.const 8
  i32.const 1
  i32.store8
  i32.const 8
  i32.const 1
  i32.store16
  i32.const 8
  i32.const 1
  i32.store
  i32.const 8
  i64.const 1
  i64.store8
  i32.const 8
  i64.const 1
  i64.store16
  i32.const 8
  i64.const 1
  i64.store32
  i32.const 8
  i64.const 1
  i64.store
  i32.const 8
  i64.const 1
  i64.store
  i32.const 1067450368
  global.set $builtins/i
  f32.const 3.5032461608120427e-44
  global.set $builtins/f
  i64.const 4608308318706860032
  global.set $builtins/I
  f64.const 1.24e-322
  global.set $builtins/F
  memory.size
  drop
  i32.const 1
  memory.grow
  drop
  memory.size
  drop
  i32.const 1
  memory.grow
  drop
  i32.const 10
  global.set $builtins/i
  i64.const 200
  global.set $builtins/I
  f32.const 1.25
  global.set $builtins/f
  f64.const 25
  global.set $builtins/F
  i32.const 1
  i32.const 2
  call $start:builtins~anonymous|0
  i32.const 3
  i32.ne
  if
   i32.const 0
   i32.const 96
   i32.const 465
   i32.const 1
   call $~lib/builtins/abort
   unreachable
  end
  i32.const 2
  i32.const 3
  call $start:builtins~anonymous|0
  i32.const 5
  i32.ne
  if
   i32.const 0
   i32.const 96
   i32.const 466
   i32.const 1
   call $~lib/builtins/abort
   unreachable
  end
  i32.const 32
  i32.const 32
  call $~lib/string/String.__eq
  i32.eqz
  if
   i32.const 0
   i32.const 96
   i32.const 467
   i32.const 1
   call $~lib/builtins/abort
   unreachable
  end
  i32.const 176
  i32.const 176
  call $~lib/string/String.__eq
  i32.eqz
  if
   i32.const 0
   i32.const 96
   i32.const 470
   i32.const 1
   call $~lib/builtins/abort
   unreachable
  end
  i32.const 8
  i32.const 1
  i32.store8
  i32.const 8
  i32.const 1
  i32.store16
  i32.const 8
  i32.const 1
  i32.store
  i32.const 8
  i64.const 1
  i64.store8
  i32.const 8
  i64.const 1
  i64.store16
  i32.const 8
  i64.const 1
  i64.store32
  i32.const 8
  i64.const 1
  i64.store
  i32.const 8
  f32.const 1
  f32.store
  i32.const 8
  f64.const 1
  f64.store
  i32.const 256
  i32.const 5
  f64.const 0
  f64.const 0
  f64.const 51
  f64.const 52
  f64.const 52
  call $~lib/builtins/trace
  i32.const 352
  i32.const 352
  call $~lib/string/String.__eq
  i32.eqz
  if
   i32.const 0
   i32.const 96
   i32.const 680
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  i32.const 352
  i32.const 352
  call $~lib/string/String.__eq
  i32.eqz
  if
   i32.const 0
   i32.const 96
   i32.const 681
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  i32.const 400
  i32.const 400
  call $~lib/string/String.__eq
  i32.eqz
  if
   i32.const 0
   i32.const 96
   i32.const 682
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  i32.const 432
  i32.const 432
  call $~lib/string/String.__eq
  i32.eqz
  if
   i32.const 0
   i32.const 96
   i32.const 683
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  i32.const 464
  i32.const 464
  call $~lib/string/String.__eq
  i32.eqz
  if
   i32.const 0
   i32.const 96
   i32.const 684
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  i32.const 496
  i32.const 496
  call $~lib/string/String.__eq
  i32.eqz
  if
   i32.const 0
   i32.const 96
   i32.const 685
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  i32.const 528
  i32.const 528
  call $~lib/string/String.__eq
  i32.eqz
  if
   i32.const 0
   i32.const 96
   i32.const 686
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  i32.const 560
  i32.const 560
  call $~lib/string/String.__eq
  i32.eqz
  if
   i32.const 0
   i32.const 96
   i32.const 687
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  i32.const 592
  i32.const 592
  call $~lib/string/String.__eq
  i32.eqz
  if
   i32.const 0
   i32.const 96
   i32.const 688
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  i32.const 624
  i32.const 624
  call $~lib/string/String.__eq
  i32.eqz
  if
   i32.const 0
   i32.const 96
   i32.const 689
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  i32.const 656
  i32.const 656
  call $~lib/string/String.__eq
  i32.eqz
  if
   i32.const 0
   i32.const 96
   i32.const 690
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  i32.const 688
  i32.const 688
  call $~lib/string/String.__eq
  i32.eqz
  if
   i32.const 0
   i32.const 96
   i32.const 691
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  i32.const 720
  i32.const 720
  call $~lib/string/String.__eq
  i32.eqz
  if
   i32.const 0
   i32.const 96
   i32.const 692
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  i32.const 752
  i32.const 752
  call $~lib/string/String.__eq
  i32.eqz
  if
   i32.const 0
   i32.const 96
   i32.const 693
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  i32.const 784
  i32.const 784
  call $~lib/string/String.__eq
  i32.eqz
  if
   i32.const 0
   i32.const 96
   i32.const 694
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  i32.const 816
  i32.const 816
  call $~lib/string/String.__eq
  i32.eqz
  if
   i32.const 0
   i32.const 96
   i32.const 695
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  i32.const 848
  i32.const 848
  call $~lib/string/String.__eq
  i32.eqz
  if
   i32.const 0
   i32.const 96
   i32.const 696
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  i32.const 880
  i32.const 880
  call $~lib/string/String.__eq
  i32.eqz
  if
   i32.const 0
   i32.const 96
   i32.const 697
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  i32.const 432
  i32.const 432
  call $~lib/string/String.__eq
  i32.eqz
  if
   i32.const 0
   i32.const 96
   i32.const 698
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  i32.const 352
  i32.const 352
  call $~lib/string/String.__eq
  i32.eqz
  if
   i32.const 0
   i32.const 96
   i32.const 699
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
 )
)
