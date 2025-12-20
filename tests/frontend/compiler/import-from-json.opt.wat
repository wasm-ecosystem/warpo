(module
 (type $0 (func (param i32 i32) (result i32)))
 (type $1 (func (param i32 i32 i32 i32)))
 (type $2 (func (param i32) (result f64)))
 (type $3 (func (param i32) (result i32)))
 (type $4 (func))
 (import "env" "abort" (func $~lib/builtins/abort (param i32 i32 i32 i32)))
 (memory $0 1)
 (data $0 (i32.const 12) "<")
 (data $0.1 (i32.const 24) "\02\00\00\00 \00\00\00i\00m\00p\00o\00r\00t\00-\00f\00r\00o\00m\00-\00j\00s\00o\00n")
 (data $1 (i32.const 76) "<")
 (data $1.1 (i32.const 88) "\02\00\00\00&\00\00\00i\00m\00p\00o\00r\00t\00-\00f\00r\00o\00m\00-\00j\00s\00o\00n\00.\00t\00s")
 (data $2 (i32.const 140) "\1c")
 (data $2.1 (i32.const 152) "\02\00\00\00\n\00\00\001\00.\002\00.\004")
 (data $3 (i32.const 172) "\1c")
 (data $3.1 (i32.const 184) "\01\00\00\00\0c\00\00\00\01\00\00\00\02\00\00\00\03")
 (data $4 (i32.const 204) ",")
 (data $4.1 (i32.const 216) "\04\00\00\00\10\00\00\00\c0\00\00\00\c0\00\00\00\0c\00\00\00\03")
 (data $5 (i32.const 252) "<")
 (data $5.1 (i32.const 264) "\02\00\00\00$\00\00\00I\00n\00d\00e\00x\00 \00o\00u\00t\00 \00o\00f\00 \00r\00a\00n\00g\00e")
 (data $6 (i32.const 316) ",")
 (data $6.1 (i32.const 328) "\02\00\00\00\1a\00\00\00~\00l\00i\00b\00/\00a\00r\00r\00a\00y\00.\00t\00s")
 (data $7 (i32.const 364) ",")
 (data $7.1 (i32.const 376) "\01\00\00\00\18")
 (data $7.2 (i32.const 390) "\f0?\00\00\00\00\00\00\00@\00\00\00\00\00\00\08@")
 (data $8 (i32.const 412) ",")
 (data $8.1 (i32.const 424) "\05\00\00\00\10\00\00\00\80\01\00\00\80\01\00\00\18\00\00\00\03")
 (data $9 (i32.const 460) "\1c")
 (data $9.1 (i32.const 472) "\02\00\00\00\06\00\00\00o\00n\00e")
 (data $10 (i32.const 492) "\1c")
 (data $10.1 (i32.const 504) "\02\00\00\00\06\00\00\00t\00w\00o")
 (data $11 (i32.const 524) "\1c")
 (data $11.1 (i32.const 536) "\02\00\00\00\n\00\00\00t\00h\00r\00e\00e")
 (data $12 (i32.const 556) "\1c")
 (data $12.1 (i32.const 568) "\01\00\00\00\0c\00\00\00\e0\01\00\00\00\02\00\00 \02")
 (data $13 (i32.const 588) ",")
 (data $13.1 (i32.const 600) "\06\00\00\00\10\00\00\00@\02\00\00@\02\00\00\0c\00\00\00\03")
 (data $14 (i32.const 636) "|")
 (data $14.1 (i32.const 648) "\02\00\00\00^\00\00\00E\00l\00e\00m\00e\00n\00t\00 \00t\00y\00p\00e\00 \00m\00u\00s\00t\00 \00b\00e\00 \00n\00u\00l\00l\00a\00b\00l\00e\00 \00i\00f\00 \00a\00r\00r\00a\00y\00 \00i\00s\00 \00h\00o\00l\00e\00y")
 (data $15 (i32.const 764) "\1c")
 (data $15.1 (i32.const 776) "\01\00\00\00\08\00\00\00\n\00\00\00\0b")
 (data $16 (i32.const 796) ",")
 (data $16.1 (i32.const 808) "\04\00\00\00\10\00\00\00\10\03\00\00\10\03\00\00\08\00\00\00\02")
 (export "memory" (memory $0))
 (start $~start)
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
 (func $~lib/array/Array<i32>#__get (param $0 i32) (param $1 i32) (result i32)
  local.get $1
  local.get $0
  i32.load offset=12
  i32.ge_u
  if
   i32.const 272
   i32.const 336
   i32.const 118
   i32.const 42
   call $~lib/builtins/abort
   unreachable
  end
  local.get $0
  i32.load offset=4
  local.get $1
  i32.const 2
  i32.shl
  i32.add
  i32.load
 )
 (func $~lib/array/Array<f64>#__get (param $0 i32) (result f64)
  local.get $0
  i32.const 444
  i32.load
  i32.ge_u
  if
   i32.const 272
   i32.const 336
   i32.const 118
   i32.const 42
   call $~lib/builtins/abort
   unreachable
  end
  i32.const 436
  i32.load
  local.get $0
  i32.const 3
  i32.shl
  i32.add
  f64.load
 )
 (func $~lib/array/Array<~lib/string/String>#__get (param $0 i32) (result i32)
  local.get $0
  i32.const 620
  i32.load
  i32.ge_u
  if
   i32.const 272
   i32.const 336
   i32.const 118
   i32.const 42
   call $~lib/builtins/abort
   unreachable
  end
  i32.const 612
  i32.load
  local.get $0
  i32.const 2
  i32.shl
  i32.add
  i32.load
  local.tee $0
  i32.eqz
  if
   i32.const 656
   i32.const 336
   i32.const 122
   i32.const 40
   call $~lib/builtins/abort
   unreachable
  end
  local.get $0
 )
 (func $~start
  i32.const 32
  i32.const 32
  call $~lib/string/String.__eq
  i32.eqz
  if
   i32.const 0
   i32.const 96
   i32.const 12
   i32.const 1
   call $~lib/builtins/abort
   unreachable
  end
  i32.const 160
  i32.const 160
  call $~lib/string/String.__eq
  i32.eqz
  if
   i32.const 0
   i32.const 96
   i32.const 13
   i32.const 1
   call $~lib/builtins/abort
   unreachable
  end
  i32.const 236
  i32.load
  i32.const 3
  i32.ne
  if
   i32.const 0
   i32.const 96
   i32.const 17
   i32.const 1
   call $~lib/builtins/abort
   unreachable
  end
  i32.const 224
  i32.const 0
  call $~lib/array/Array<i32>#__get
  i32.const 1
  i32.ne
  if
   i32.const 0
   i32.const 96
   i32.const 18
   i32.const 1
   call $~lib/builtins/abort
   unreachable
  end
  i32.const 224
  i32.const 1
  call $~lib/array/Array<i32>#__get
  i32.const 2
  i32.ne
  if
   i32.const 0
   i32.const 96
   i32.const 19
   i32.const 1
   call $~lib/builtins/abort
   unreachable
  end
  i32.const 224
  i32.const 2
  call $~lib/array/Array<i32>#__get
  i32.const 3
  i32.ne
  if
   i32.const 0
   i32.const 96
   i32.const 20
   i32.const 1
   call $~lib/builtins/abort
   unreachable
  end
  i32.const 444
  i32.load
  i32.const 3
  i32.ne
  if
   i32.const 0
   i32.const 96
   i32.const 22
   i32.const 1
   call $~lib/builtins/abort
   unreachable
  end
  i32.const 0
  call $~lib/array/Array<f64>#__get
  f64.const 1
  f64.ne
  if
   i32.const 0
   i32.const 96
   i32.const 23
   i32.const 1
   call $~lib/builtins/abort
   unreachable
  end
  i32.const 1
  call $~lib/array/Array<f64>#__get
  f64.const 2
  f64.ne
  if
   i32.const 0
   i32.const 96
   i32.const 24
   i32.const 1
   call $~lib/builtins/abort
   unreachable
  end
  i32.const 2
  call $~lib/array/Array<f64>#__get
  f64.const 3
  f64.ne
  if
   i32.const 0
   i32.const 96
   i32.const 25
   i32.const 1
   call $~lib/builtins/abort
   unreachable
  end
  i32.const 620
  i32.load
  i32.const 3
  i32.ne
  if
   i32.const 0
   i32.const 96
   i32.const 27
   i32.const 1
   call $~lib/builtins/abort
   unreachable
  end
  i32.const 0
  call $~lib/array/Array<~lib/string/String>#__get
  i32.const 480
  call $~lib/string/String.__eq
  i32.eqz
  if
   i32.const 0
   i32.const 96
   i32.const 28
   i32.const 1
   call $~lib/builtins/abort
   unreachable
  end
  i32.const 1
  call $~lib/array/Array<~lib/string/String>#__get
  i32.const 512
  call $~lib/string/String.__eq
  i32.eqz
  if
   i32.const 0
   i32.const 96
   i32.const 29
   i32.const 1
   call $~lib/builtins/abort
   unreachable
  end
  i32.const 2
  call $~lib/array/Array<~lib/string/String>#__get
  i32.const 544
  call $~lib/string/String.__eq
  i32.eqz
  if
   i32.const 0
   i32.const 96
   i32.const 30
   i32.const 1
   call $~lib/builtins/abort
   unreachable
  end
  i32.const 828
  i32.load
  i32.const 2
  i32.ne
  if
   i32.const 0
   i32.const 96
   i32.const 33
   i32.const 1
   call $~lib/builtins/abort
   unreachable
  end
  i32.const 816
  i32.const 0
  call $~lib/array/Array<i32>#__get
  i32.const 10
  i32.ne
  if
   i32.const 0
   i32.const 96
   i32.const 34
   i32.const 1
   call $~lib/builtins/abort
   unreachable
  end
  i32.const 816
  i32.const 1
  call $~lib/array/Array<i32>#__get
  i32.const 11
  i32.ne
  if
   i32.const 0
   i32.const 96
   i32.const 35
   i32.const 1
   call $~lib/builtins/abort
   unreachable
  end
 )
)
