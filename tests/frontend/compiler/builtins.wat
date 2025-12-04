(module
 (type $0 (func (param i32) (result i32)))
 (type $1 (func (param i32 i32) (result i32)))
 (type $2 (func))
 (type $3 (func (param i32 i32 i32) (result i32)))
 (type $4 (func (param i32 i32 i32 i32)))
 (type $5 (func (param i32 i32 i32 i32 i32) (result i32)))
 (type $6 (func (param i32 i32 f64 f64 f64 f64 f64)))
 (import "env" "abort" (func $~lib/builtins/abort (param i32 i32 i32 i32)))
 (import "env" "trace" (func $~lib/builtins/trace (param i32 i32 f64 f64 f64 f64 f64)))
 (import "as-builtin-fn" "~lib/rt/__localtostack" (func $~lib/rt/__localtostack (param i32) (result i32)))
 (import "as-builtin-fn" "~lib/rt/__tmptostack" (func $~lib/rt/__tmptostack (param i32) (result i32)))
 (global $builtins/b (mut i32) (i32.const 0))
 (global $builtins/i (mut i32) (i32.const 0))
 (global $builtins/l (mut i32) (i32.const 0))
 (global $builtins/v (mut i32) (i32.const 0))
 (global $builtins/I (mut i64) (i64.const 0))
 (global $builtins/f (mut f32) (f32.const 0))
 (global $~lib/builtins/f32.NaN f32 (f32.const nan:0x400000))
 (global $builtins/F (mut f64) (f64.const 0))
 (global $~lib/builtins/f64.NaN f64 (f64.const nan:0x8000000000000))
 (global $builtins/constantOffset i32 (i32.const 8))
 (global $builtins/u (mut i32) (i32.const 0))
 (global $builtins/U (mut i64) (i64.const 0))
 (global $builtins/s (mut i32) (i32.const 0))
 (global $builtins/fn (mut i32) (i32.const 144))
 (global $~argumentsLength (mut i32) (i32.const 0))
 (global $~lib/shared/runtime/Runtime.Stub i32 (i32.const 0))
 (global $~lib/shared/runtime/Runtime.Radical i32 (i32.const 1))
 (global $~lib/shared/runtime/Runtime.Incremental i32 (i32.const 2))
 (global $~lib/native/ASC_SHRINK_LEVEL i32 (i32.const 0))
 (global $~lib/builtins/i8.MIN_VALUE i32 (i32.const -128))
 (global $~lib/builtins/i8.MAX_VALUE i32 (i32.const 127))
 (global $~lib/builtins/i16.MIN_VALUE i32 (i32.const -32768))
 (global $~lib/builtins/i16.MAX_VALUE i32 (i32.const 32767))
 (global $~lib/builtins/i32.MIN_VALUE i32 (i32.const -2147483648))
 (global $~lib/builtins/i32.MAX_VALUE i32 (i32.const 2147483647))
 (global $~lib/builtins/i64.MIN_VALUE i64 (i64.const -9223372036854775808))
 (global $~lib/builtins/i64.MAX_VALUE i64 (i64.const 9223372036854775807))
 (global $~lib/builtins/u8.MIN_VALUE i32 (i32.const 0))
 (global $~lib/builtins/u8.MAX_VALUE i32 (i32.const 255))
 (global $~lib/builtins/u16.MIN_VALUE i32 (i32.const 0))
 (global $~lib/builtins/u16.MAX_VALUE i32 (i32.const 65535))
 (global $~lib/builtins/u32.MIN_VALUE i32 (i32.const 0))
 (global $~lib/builtins/u32.MAX_VALUE i32 (i32.const -1))
 (global $~lib/builtins/u64.MIN_VALUE i64 (i64.const 0))
 (global $~lib/builtins/u64.MAX_VALUE i64 (i64.const -1))
 (global $~lib/builtins/bool.MIN_VALUE i32 (i32.const 0))
 (global $~lib/builtins/bool.MAX_VALUE i32 (i32.const 1))
 (global $~lib/builtins/f32.MIN_NORMAL_VALUE f32 (f32.const 1.1754943508222875e-38))
 (global $~lib/builtins/f32.MIN_VALUE f32 (f32.const 1.401298464324817e-45))
 (global $~lib/builtins/f32.MAX_VALUE f32 (f32.const 3402823466385288598117041e14))
 (global $~lib/builtins/f32.MIN_SAFE_INTEGER f32 (f32.const -16777215))
 (global $~lib/builtins/f32.MAX_SAFE_INTEGER f32 (f32.const 16777215))
 (global $~lib/builtins/f32.EPSILON f32 (f32.const 1.1920928955078125e-07))
 (global $~lib/builtins/f64.MIN_NORMAL_VALUE f64 (f64.const 2.2250738585072014e-308))
 (global $~lib/builtins/f64.MIN_VALUE f64 (f64.const 5e-324))
 (global $~lib/builtins/f64.MAX_VALUE f64 (f64.const 1797693134862315708145274e284))
 (global $~lib/builtins/f64.MIN_SAFE_INTEGER f64 (f64.const -9007199254740991))
 (global $~lib/builtins/f64.MAX_SAFE_INTEGER f64 (f64.const 9007199254740991))
 (global $~lib/builtins/f64.EPSILON f64 (f64.const 2.220446049250313e-16))
 (global $~lib/memory/__data_end i32 (i32.const 1004))
 (global $~lib/memory/__stack_pointer (mut i32) (i32.const 33772))
 (global $~lib/memory/__heap_base i32 (i32.const 33772))
 (memory $0 1)
 (data $0 (i32.const 12) "\1c\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00")
 (data $1 (i32.const 44) "\1c\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\06\00\00\00a\00b\00c\00\00\00\00\00\00\00")
 (data $2 (i32.const 76) ",\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\16\00\00\00b\00u\00i\00l\00t\00i\00n\00s\00.\00t\00s\00\00\00\00\00\00\00")
 (data $3 (i32.const 124) "\1c\00\00\00\00\00\00\00\00\00\00\00\07\00\00\00\08\00\00\00\01\00\00\00\00\00\00\00\00\00\00\00")
 (data $4 (i32.const 156) "L\00\00\00\00\00\00\00\00\00\00\00\02\00\00\008\00\00\00f\00u\00n\00c\00t\00i\00o\00n\00(\00)\00 \00{\00 \00[\00n\00a\00t\00i\00v\00e\00 \00c\00o\00d\00e\00]\00 \00}\00\00\00\00\00")
 (data $5 (i32.const 236) ",\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\14\00\00\00s\00i\00g\00n\00a\00t\00u\00r\00e\00s\00\00\00\00\00\00\00\00\00")
 (data $6 (i32.const 284) ",\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\0e\00\00\00t\00e\00s\00t\00i\00n\00g\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00")
 (data $7 (i32.const 332) ",\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\10\00\00\00F\00u\00n\00c\00t\00i\00o\00n\00\00\00\00\00\00\00\00\00\00\00\00\00")
 (data $8 (i32.const 380) "\1c\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\02\00\00\00C\00\00\00\00\00\00\00\00\00\00\00")
 (data $9 (i32.const 412) "\1c\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\0c\00\00\00S\00t\00r\00i\00n\00g\00")
 (data $10 (i32.const 444) "\1c\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\08\00\00\00b\00o\00o\00l\00\00\00\00\00")
 (data $11 (i32.const 476) "\1c\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\04\00\00\00i\008\00\00\00\00\00\00\00\00\00")
 (data $12 (i32.const 508) "\1c\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\04\00\00\00u\008\00\00\00\00\00\00\00\00\00")
 (data $13 (i32.const 540) "\1c\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\06\00\00\00i\001\006\00\00\00\00\00\00\00")
 (data $14 (i32.const 572) "\1c\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\06\00\00\00u\001\006\00\00\00\00\00\00\00")
 (data $15 (i32.const 604) "\1c\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\06\00\00\00i\003\002\00\00\00\00\00\00\00")
 (data $16 (i32.const 636) "\1c\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\06\00\00\00u\003\002\00\00\00\00\00\00\00")
 (data $17 (i32.const 668) "\1c\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\06\00\00\00f\003\002\00\00\00\00\00\00\00")
 (data $18 (i32.const 700) "\1c\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\06\00\00\00i\006\004\00\00\00\00\00\00\00")
 (data $19 (i32.const 732) "\1c\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\06\00\00\00u\006\004\00\00\00\00\00\00\00")
 (data $20 (i32.const 764) "\1c\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\06\00\00\00f\006\004\00\00\00\00\00\00\00")
 (data $21 (i32.const 796) "\1c\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\n\00\00\00i\00s\00i\00z\00e\00\00\00")
 (data $22 (i32.const 828) "\1c\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\n\00\00\00u\00s\00i\00z\00e\00\00\00")
 (data $23 (i32.const 860) "\1c\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\08\00\00\00v\00o\00i\00d\00\00\00\00\00")
 (data $24 (i32.const 892) ",\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\14\00\00\00s\00o\00m\00e\00 \00v\00a\00l\00u\00e\00\00\00\00\00\00\00\00\00")
 (data $25 (i32.const 940) "\1c\00\00\00\00\00\00\00\00\00\00\00\0c\00\00\00\08\00\00\00\02\00\00\00\00\00\00\00\00\00\00\00")
 (data $26 (i32.const 972) "\1c\00\00\00\00\00\00\00\00\00\00\00\r\00\00\00\08\00\00\00\03\00\00\00\00\00\00\00\00\00\00\00")
 (table $0 4 4 funcref)
 (elem $0 (i32.const 1) $start:builtins~anonymous|0 $start:builtins~anonymous|1 $start:builtins~anonymous|2)
 (export "test" (func $builtins/test))
 (export "memory" (memory $0))
 (start $~start)
 (func $start:builtins~anonymous|0 (param $a i32) (param $b i32) (result i32)
  (return
   (i32.add
    (local.get $a)
    (local.get $b)
   )
  )
 )
 (func $~lib/function/Function<%28i32%2Ci32%29=>i32>#get:index (param $this i32) (result i32)
  (return
   (i32.load
    (local.get $this)
   )
  )
 )
 (func $~lib/function/Function<%28i32%2Ci32%29=>i32>#get:name (param $this i32) (result i32)
  (return
   (i32.const 32)
  )
 )
 (func $~lib/rt/common/OBJECT#get:rtSize (param $this i32) (result i32)
  (i32.load offset=16
   (local.get $this)
  )
 )
 (func $~lib/string/String#get:length (param $this i32) (result i32)
  (return
   (i32.shr_u
    (call $~lib/rt/common/OBJECT#get:rtSize
     (i32.sub
      (local.get $this)
      (i32.const 20)
     )
    )
    (i32.const 1)
   )
  )
 )
 (func $~lib/util/string/compareImpl (param $str1 i32) (param $index1 i32) (param $str2 i32) (param $index2 i32) (param $len i32) (result i32)
  (local $ptr1 i32)
  (local $ptr2 i32)
  (local $7 i32)
  (local $a i32)
  (local $b i32)
  (local.set $ptr1
   (i32.add
    (local.get $str1)
    (i32.shl
     (local.get $index1)
     (i32.const 1)
    )
   )
  )
  (local.set $ptr2
   (i32.add
    (local.get $str2)
    (i32.shl
     (local.get $index2)
     (i32.const 1)
    )
   )
  )
  (drop
   (i32.lt_s
    (i32.const 0)
    (i32.const 2)
   )
  )
  (if
   (if (result i32)
    (i32.ge_u
     (local.get $len)
     (i32.const 4)
    )
    (then
     (i32.eqz
      (i32.or
       (i32.and
        (local.get $ptr1)
        (i32.const 7)
       )
       (i32.and
        (local.get $ptr2)
        (i32.const 7)
       )
      )
     )
    )
    (else
     (i32.const 0)
    )
   )
   (then
    (block $do-break|0
     (loop $do-loop|0
      (if
       (i64.ne
        (i64.load
         (local.get $ptr1)
        )
        (i64.load
         (local.get $ptr2)
        )
       )
       (then
        (br $do-break|0)
       )
      )
      (local.set $ptr1
       (i32.add
        (local.get $ptr1)
        (i32.const 8)
       )
      )
      (local.set $ptr2
       (i32.add
        (local.get $ptr2)
        (i32.const 8)
       )
      )
      (local.set $len
       (i32.sub
        (local.get $len)
        (i32.const 4)
       )
      )
      (br_if $do-loop|0
       (i32.ge_u
        (local.get $len)
        (i32.const 4)
       )
      )
     )
    )
   )
  )
  (block $while-break|1
   (loop $while-continue|1
    (if
     (block (result i32)
      (local.set $len
       (i32.sub
        (local.tee $7
         (local.get $len)
        )
        (i32.const 1)
       )
      )
      (local.get $7)
     )
     (then
      (local.set $a
       (i32.load16_u
        (local.get $ptr1)
       )
      )
      (local.set $b
       (i32.load16_u
        (local.get $ptr2)
       )
      )
      (if
       (i32.ne
        (local.get $a)
        (local.get $b)
       )
       (then
        (return
         (i32.sub
          (local.get $a)
          (local.get $b)
         )
        )
       )
      )
      (local.set $ptr1
       (i32.add
        (local.get $ptr1)
        (i32.const 2)
       )
      )
      (local.set $ptr2
       (i32.add
        (local.get $ptr2)
        (i32.const 2)
       )
      )
      (br $while-continue|1)
     )
    )
   )
  )
  (return
   (i32.const 0)
  )
 )
 (func $~lib/string/String.__eq (param $left i32) (param $right i32) (result i32)
  (local $leftLength i32)
  (if
   (i32.eq
    (local.get $left)
    (local.get $right)
   )
   (then
    (return
     (i32.const 1)
    )
   )
  )
  (if
   (if (result i32)
    (i32.eq
     (local.get $left)
     (i32.const 0)
    )
    (then
     (i32.const 1)
    )
    (else
     (i32.eq
      (local.get $right)
      (i32.const 0)
     )
    )
   )
   (then
    (return
     (i32.const 0)
    )
   )
  )
  (local.set $leftLength
   (call $~lib/string/String#get:length
    (call $~lib/rt/__tmptostack
     (local.get $left)
    )
   )
  )
  (if
   (i32.ne
    (local.get $leftLength)
    (call $~lib/string/String#get:length
     (call $~lib/rt/__tmptostack
      (local.get $right)
     )
    )
   )
   (then
    (return
     (i32.const 0)
    )
   )
  )
  (return
   (i32.eqz
    (call $~lib/util/string/compareImpl
     (call $~lib/rt/__tmptostack
      (local.get $left)
     )
     (i32.const 0)
     (call $~lib/rt/__tmptostack
      (local.get $right)
     )
     (i32.const 0)
     (local.get $leftLength)
    )
   )
  )
 )
 (func $~lib/function/Function<%28i32%2Ci32%29=>i32>#get:length (param $this i32) (result i32)
  (return
   (i32.const 2)
  )
 )
 (func $~lib/function/Function<%28i32%2Ci32%29=>i32>#toString (param $this i32) (result i32)
  (return
   (i32.const 176)
  )
 )
 (func $~lib/atomics/Atomics.isLockFree (param $size i32) (result i32)
  (return
   (if (result i32)
    (if (result i32)
     (i32.eq
      (local.get $size)
      (i32.const 1)
     )
     (then
      (i32.const 1)
     )
     (else
      (i32.eq
       (local.get $size)
       (i32.const 2)
      )
     )
    )
    (then
     (i32.const 1)
    )
    (else
     (i32.eq
      (local.get $size)
      (i32.const 4)
     )
    )
   )
  )
 )
 (func $start:builtins~anonymous|1
  (nop)
 )
 (func $start:builtins~anonymous|2 (param $a i32) (param $b i32) (param $c i32) (param $d i32)
  (nop)
 )
 (func $builtins/max3 (param $a i32) (param $b i32) (param $c i32) (result i32)
  (local $3 i32)
  (local $4 i32)
  (local $5 i32)
  (local $6 i32)
  (return
   (select
    (local.tee $5
     (local.get $a)
    )
    (local.tee $6
     (select
      (local.tee $3
       (local.get $b)
      )
      (local.tee $4
       (local.get $c)
      )
      (i32.gt_s
       (local.get $3)
       (local.get $4)
      )
     )
    )
    (i32.gt_s
     (local.get $5)
     (local.get $6)
    )
   )
  )
 )
 (func $builtins/min3 (param $a i32) (param $b i32) (param $c i32) (result i32)
  (local $3 i32)
  (local $4 i32)
  (local $5 i32)
  (local $6 i32)
  (return
   (select
    (local.tee $5
     (local.get $a)
    )
    (local.tee $6
     (select
      (local.tee $3
       (local.get $b)
      )
      (local.tee $4
       (local.get $c)
      )
      (i32.lt_s
       (local.get $3)
       (local.get $4)
      )
     )
    )
    (i32.lt_s
     (local.get $5)
     (local.get $6)
    )
   )
  )
 )
 (func $builtins/rotl3 (param $a i32) (param $b i32) (param $c i32) (result i32)
  (local $3 i32)
  (local $4 i32)
  (local $5 i32)
  (local $6 i32)
  (return
   (i32.extend8_s
    (i32.or
     (i32.shl
      (local.tee $5
       (i32.extend8_s
        (local.get $a)
       )
      )
      (i32.and
       (local.tee $6
        (i32.or
         (i32.shl
          (local.tee $3
           (i32.extend8_s
            (local.get $b)
           )
          )
          (i32.and
           (local.tee $4
            (local.get $c)
           )
           (i32.const 7)
          )
         )
         (i32.shr_u
          (local.get $3)
          (i32.and
           (i32.sub
            (i32.const 0)
            (local.get $4)
           )
           (i32.const 7)
          )
         )
        )
       )
       (i32.const 7)
      )
     )
     (i32.shr_u
      (local.get $5)
      (i32.and
       (i32.sub
        (i32.const 0)
        (local.get $6)
       )
       (i32.const 7)
      )
     )
    )
   )
  )
 )
 (func $builtins/rotr3 (param $a i32) (param $b i32) (param $c i32) (result i32)
  (local $3 i32)
  (local $4 i32)
  (local $5 i32)
  (local $6 i32)
  (return
   (i32.extend8_s
    (i32.or
     (i32.shr_u
      (local.tee $5
       (i32.extend8_s
        (local.get $a)
       )
      )
      (i32.and
       (local.tee $6
        (i32.or
         (i32.shr_u
          (local.tee $3
           (i32.extend8_s
            (local.get $b)
           )
          )
          (i32.and
           (local.tee $4
            (local.get $c)
           )
           (i32.const 7)
          )
         )
         (i32.shl
          (local.get $3)
          (i32.and
           (i32.sub
            (i32.const 0)
            (local.get $4)
           )
           (i32.const 7)
          )
         )
        )
       )
       (i32.const 7)
      )
     )
     (i32.shl
      (local.get $5)
      (i32.and
       (i32.sub
        (i32.const 0)
        (local.get $6)
       )
       (i32.const 7)
      )
     )
    )
   )
  )
 )
 (func $start:builtins
  (local $0 i32)
  (local $1 i32)
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
  (local $12 i32)
  (local $13 i32)
  (local $14 i32)
  (local $15 i32)
  (local $16 i64)
  (local $17 i64)
  (local $18 i64)
  (local $19 i64)
  (local $20 i64)
  (local $21 i64)
  (local $22 i64)
  (local $23 i64)
  (local $24 f32)
  (local $25 f32)
  (local $26 f32)
  (local $27 f32)
  (local $28 f32)
  (local $29 f32)
  (local $30 f32)
  (local $31 f32)
  (local $32 f64)
  (local $33 f64)
  (local $34 f64)
  (local $35 f64)
  (local $36 f64)
  (local $37 f64)
  (local $38 f64)
  (local $39 f64)
  (local $40 f32)
  (local $41 f64)
  (local $42 f32)
  (local $43 f32)
  (local $44 f64)
  (local $45 f64)
  (local $46 f32)
  (local $47 f64)
  (local $a i32)
  (local $b i32)
  (local $c i32)
  (local $d i32)
  (local $e i32)
  (drop
   (i32.const 1)
  )
  (drop
   (i32.eqz
    (i32.const 0)
   )
  )
  (drop
   (i32.const 1)
  )
  (drop
   (i32.eqz
    (i32.const 0)
   )
  )
  (drop
   (i32.const 1)
  )
  (drop
   (i32.eqz
    (i32.const 0)
   )
  )
  (drop
   (i32.const 1)
  )
  (drop
   (i32.eqz
    (i32.const 0)
   )
  )
  (drop
   (i32.const 1)
  )
  (drop
   (i32.const 1)
  )
  (drop
   (i32.const 1)
  )
  (drop
   (i32.eqz
    (i32.const 0)
   )
  )
  (drop
   (i32.const 1)
  )
  (drop
   (i32.eqz
    (i32.const 0)
   )
  )
  (drop
   (i32.const 1)
  )
  (drop
   (i32.eqz
    (i32.const 0)
   )
  )
  (drop
   (i32.const 1)
  )
  (drop
   (i32.eqz
    (i32.const 0)
   )
  )
  (drop
   (i32.const 1)
  )
  (drop
   (i32.eqz
    (i32.const 0)
   )
  )
  (drop
   (i32.const 1)
  )
  (drop
   (i32.eqz
    (i32.const 0)
   )
  )
  (drop
   (i32.const 1)
  )
  (drop
   (i32.const 1)
  )
  (drop
   (i32.eqz
    (i32.const 0)
   )
  )
  (drop
   (i32.const 1)
  )
  (drop
   (i32.const 1)
  )
  (drop
   (i32.const 1)
  )
  (drop
   (i32.const 1)
  )
  (drop
   (i32.eqz
    (i32.const 0)
   )
  )
  (drop
   (i32.const 1)
  )
  (drop
   (i32.eqz
    (i32.const 0)
   )
  )
  (drop
   (i32.const 1)
  )
  (drop
   (i32.eqz
    (i32.const 0)
   )
  )
  (drop
   (i32.const 1)
  )
  (drop
   (i32.eqz
    (i32.const 0)
   )
  )
  (drop
   (i32.const 1)
  )
  (drop
   (i32.eqz
    (i32.const 0)
   )
  )
  (global.set $builtins/l
   (i32.extend8_s
    (i32.add
     (i32.const 1)
     (i32.const 2)
    )
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (global.get $builtins/l)
     (i32.const 3)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 96)
     (i32.const 54)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (global.set $builtins/l
   (i32.extend8_s
    (i32.sub
     (i32.const 2)
     (i32.const 1)
    )
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (global.get $builtins/l)
     (i32.const 1)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 96)
     (i32.const 56)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (global.set $builtins/l
   (i32.mul
    (i32.const 1)
    (i32.const 2)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (global.get $builtins/l)
     (i32.const 2)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 96)
     (i32.const 58)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (global.set $builtins/l
   (i32.extend8_s
    (i32.div_s
     (i32.const 6)
     (i32.const 2)
    )
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (global.get $builtins/l)
     (i32.const 3)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 96)
     (i32.const 60)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (global.set $builtins/i
   (i32.eq
    (i32.const 1)
    (i32.const 1)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (global.get $builtins/i)
     (i32.const 1)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 96)
     (i32.const 62)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (global.set $builtins/i
   (i32.eq
    (i32.const 1)
    (i32.const 0)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (global.get $builtins/i)
     (i32.const 0)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 96)
     (i32.const 64)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (global.set $builtins/i
   (i32.ne
    (i32.const 1)
    (i32.const 1)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (global.get $builtins/i)
     (i32.const 0)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 96)
     (i32.const 66)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (global.set $builtins/i
   (i32.ne
    (i32.const 1)
    (i32.const 0)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (global.get $builtins/i)
     (i32.const 1)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 96)
     (i32.const 68)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (global.set $builtins/v
   (i32.and
    (i32.or
     (i32.shl
      (local.tee $0
       (i32.const 143)
      )
      (i32.and
       (local.tee $1
        (i32.const 3)
       )
       (i32.const 7)
      )
     )
     (i32.shr_u
      (local.get $0)
      (i32.and
       (i32.sub
        (i32.const 0)
        (local.get $1)
       )
       (i32.const 7)
      )
     )
    )
    (i32.const 255)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (global.get $builtins/v)
     (i32.const 124)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 96)
     (i32.const 72)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (global.set $builtins/v
   (i32.and
    (i32.or
     (i32.shr_u
      (local.tee $2
       (i32.const 170)
      )
      (i32.and
       (local.tee $3
        (i32.const 1)
       )
       (i32.const 7)
      )
     )
     (i32.shl
      (local.get $2)
      (i32.and
       (i32.sub
        (i32.const 0)
        (local.get $3)
       )
       (i32.const 7)
      )
     )
    )
    (i32.const 255)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (global.get $builtins/v)
     (i32.const 85)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 96)
     (i32.const 74)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (drop
   (i32.clz
    (i32.const 1)
   )
  )
  (drop
   (i32.ctz
    (i32.const 1)
   )
  )
  (drop
   (i32.popcnt
    (i32.const 1)
   )
  )
  (drop
   (i32.rotl
    (i32.const 1)
    (i32.const 1)
   )
  )
  (drop
   (i32.rotr
    (i32.const 1)
    (i32.const 1)
   )
  )
  (drop
   (i32.xor
    (i32.add
     (local.tee $5
      (i32.shr_s
       (local.tee $4
        (i32.const -42)
       )
       (i32.const 31)
      )
     )
     (local.get $4)
    )
    (local.get $5)
   )
  )
  (drop
   (select
    (local.tee $6
     (i32.const 1)
    )
    (local.tee $7
     (i32.const 2)
    )
    (i32.gt_s
     (local.get $6)
     (local.get $7)
    )
   )
  )
  (drop
   (select
    (local.tee $8
     (i32.const 1)
    )
    (local.tee $9
     (i32.const 2)
    )
    (i32.lt_s
     (local.get $8)
     (local.get $9)
    )
   )
  )
  (drop
   (i32.add
    (i32.const 1)
    (i32.const 2)
   )
  )
  (drop
   (i32.sub
    (i32.const 2)
    (i32.const 1)
   )
  )
  (drop
   (i32.mul
    (i32.const 1)
    (i32.const 2)
   )
  )
  (drop
   (i32.div_s
    (i32.const 6)
    (i32.const 2)
   )
  )
  (drop
   (i32.eq
    (i32.const 1)
    (i32.const 0)
   )
  )
  (drop
   (i32.ne
    (i32.const 1)
    (i32.const 0)
   )
  )
  (drop
   (i32.clz
    (i32.const 1)
   )
  )
  (drop
   (i32.ctz
    (i32.const 1)
   )
  )
  (drop
   (i32.popcnt
    (i32.const 1)
   )
  )
  (drop
   (i32.rotl
    (i32.const 1)
    (i32.const 1)
   )
  )
  (drop
   (i32.rotr
    (i32.const 1)
    (i32.const 1)
   )
  )
  (drop
   (i32.add
    (i32.const 1)
    (i32.const 2)
   )
  )
  (drop
   (i32.sub
    (i32.const 2)
    (i32.const 1)
   )
  )
  (drop
   (i32.mul
    (i32.const 1)
    (i32.const 2)
   )
  )
  (drop
   (i32.eq
    (i32.const 1)
    (i32.const 0)
   )
  )
  (drop
   (i32.ne
    (i32.const 1)
    (i32.const 0)
   )
  )
  (global.set $builtins/i
   (i32.clz
    (i32.const 1)
   )
  )
  (global.set $builtins/i
   (i32.ctz
    (i32.const 1)
   )
  )
  (global.set $builtins/i
   (i32.popcnt
    (i32.const 1)
   )
  )
  (global.set $builtins/i
   (i32.rotl
    (i32.const 1)
    (i32.const 1)
   )
  )
  (global.set $builtins/i
   (i32.rotr
    (i32.const 1)
    (i32.const 1)
   )
  )
  (global.set $builtins/i
   (i32.xor
    (i32.add
     (local.tee $11
      (i32.shr_s
       (local.tee $10
        (i32.const -42)
       )
       (i32.const 31)
      )
     )
     (local.get $10)
    )
    (local.get $11)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (global.get $builtins/i)
     (i32.const 42)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 96)
     (i32.const 109)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (global.set $builtins/i
   (select
    (local.tee $12
     (i32.const 1)
    )
    (local.tee $13
     (i32.const 2)
    )
    (i32.gt_s
     (local.get $12)
     (local.get $13)
    )
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (global.get $builtins/i)
     (i32.const 2)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 96)
     (i32.const 111)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (global.set $builtins/i
   (select
    (local.tee $14
     (i32.const 1)
    )
    (local.tee $15
     (i32.const 2)
    )
    (i32.lt_s
     (local.get $14)
     (local.get $15)
    )
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (global.get $builtins/i)
     (i32.const 1)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 96)
     (i32.const 113)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (global.set $builtins/i
   (i32.add
    (i32.const 1)
    (i32.const 2)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (global.get $builtins/i)
     (i32.const 3)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 96)
     (i32.const 115)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (global.set $builtins/i
   (i32.sub
    (i32.const 2)
    (i32.const 1)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (global.get $builtins/i)
     (i32.const 1)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 96)
     (i32.const 117)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (global.set $builtins/i
   (i32.mul
    (i32.const 2)
    (i32.const 3)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (global.get $builtins/i)
     (i32.const 6)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 96)
     (i32.const 119)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (global.set $builtins/i
   (i32.div_s
    (i32.const 6)
    (i32.const 2)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (global.get $builtins/i)
     (i32.const 3)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 96)
     (i32.const 121)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (global.set $builtins/i
   (i32.eq
    (i32.const 1)
    (i32.const 1)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (global.get $builtins/i)
     (i32.const 1)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 96)
     (i32.const 123)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (global.set $builtins/i
   (i32.eq
    (i32.const 1)
    (i32.const 0)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (global.get $builtins/i)
     (i32.const 0)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 96)
     (i32.const 125)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (global.set $builtins/i
   (i32.ne
    (i32.const 1)
    (i32.const 1)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (global.get $builtins/i)
     (i32.const 0)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 96)
     (i32.const 127)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (global.set $builtins/i
   (i32.ne
    (i32.const 1)
    (i32.const 0)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (global.get $builtins/i)
     (i32.const 1)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 96)
     (i32.const 129)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (global.set $builtins/i
   (i32.rem_s
    (i32.const 1)
    (i32.const 3)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (global.get $builtins/i)
     (i32.const 1)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 96)
     (i32.const 131)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (global.set $builtins/i
   (i32.rem_s
    (i32.const 15)
    (i32.const 4)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (global.get $builtins/i)
     (i32.const 3)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 96)
     (i32.const 133)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (drop
   (i64.clz
    (i64.const 1)
   )
  )
  (drop
   (i64.ctz
    (i64.const 1)
   )
  )
  (drop
   (i64.popcnt
    (i64.const 1)
   )
  )
  (drop
   (i64.rotl
    (i64.const 1)
    (i64.const 1)
   )
  )
  (drop
   (i64.rotr
    (i64.const 1)
    (i64.const 1)
   )
  )
  (drop
   (i64.xor
    (i64.add
     (local.tee $17
      (i64.shr_s
       (local.tee $16
        (i64.const -42)
       )
       (i64.const 63)
      )
     )
     (local.get $16)
    )
    (local.get $17)
   )
  )
  (drop
   (i64.eq
    (i64.const 1)
    (i64.const 0)
   )
  )
  (drop
   (i64.ne
    (i64.const 1)
    (i64.const 0)
   )
  )
  (drop
   (i64.clz
    (i64.const 1)
   )
  )
  (drop
   (i64.ctz
    (i64.const 1)
   )
  )
  (drop
   (i64.popcnt
    (i64.const 1)
   )
  )
  (drop
   (i64.rotl
    (i64.const 1)
    (i64.const 1)
   )
  )
  (drop
   (i64.rotr
    (i64.const 1)
    (i64.const 1)
   )
  )
  (drop
   (i64.eq
    (i64.const 1)
    (i64.const 0)
   )
  )
  (drop
   (i64.ne
    (i64.const 1)
    (i64.const 0)
   )
  )
  (global.set $builtins/I
   (i64.clz
    (i64.const 1)
   )
  )
  (global.set $builtins/I
   (i64.ctz
    (i64.const 1)
   )
  )
  (global.set $builtins/I
   (i64.popcnt
    (i64.const 1)
   )
  )
  (global.set $builtins/I
   (i64.rotl
    (i64.const 1)
    (i64.const 1)
   )
  )
  (global.set $builtins/I
   (i64.rotr
    (i64.const 1)
    (i64.const 1)
   )
  )
  (global.set $builtins/I
   (i64.xor
    (i64.add
     (local.tee $19
      (i64.shr_s
       (local.tee $18
        (i64.const -42)
       )
       (i64.const 63)
      )
     )
     (local.get $18)
    )
    (local.get $19)
   )
  )
  (if
   (i32.eqz
    (i64.eq
     (global.get $builtins/I)
     (i64.const 42)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 96)
     (i32.const 160)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (global.set $builtins/I
   (select
    (local.tee $20
     (i64.const 1)
    )
    (local.tee $21
     (i64.const 2)
    )
    (i64.gt_s
     (local.get $20)
     (local.get $21)
    )
   )
  )
  (if
   (i32.eqz
    (i64.eq
     (global.get $builtins/I)
     (i64.const 2)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 96)
     (i32.const 162)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (global.set $builtins/I
   (select
    (local.tee $22
     (i64.const 1)
    )
    (local.tee $23
     (i64.const 2)
    )
    (i64.lt_s
     (local.get $22)
     (local.get $23)
    )
   )
  )
  (if
   (i32.eqz
    (i64.eq
     (global.get $builtins/I)
     (i64.const 1)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 96)
     (i32.const 164)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (global.set $builtins/I
   (i64.add
    (i64.const 1)
    (i64.const 2)
   )
  )
  (if
   (i32.eqz
    (i64.eq
     (global.get $builtins/I)
     (i64.const 3)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 96)
     (i32.const 166)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (global.set $builtins/I
   (i64.sub
    (i64.const 2)
    (i64.const 1)
   )
  )
  (if
   (i32.eqz
    (i64.eq
     (global.get $builtins/I)
     (i64.const 1)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 96)
     (i32.const 168)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (global.set $builtins/I
   (i64.mul
    (i64.const 2)
    (i64.const 3)
   )
  )
  (if
   (i32.eqz
    (i64.eq
     (global.get $builtins/I)
     (i64.const 6)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 96)
     (i32.const 170)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (global.set $builtins/I
   (i64.div_s
    (i64.const 6)
    (i64.const 2)
   )
  )
  (if
   (i32.eqz
    (i64.eq
     (global.get $builtins/I)
     (i64.const 3)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 96)
     (i32.const 172)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (global.set $builtins/i
   (i64.eq
    (i64.const 1)
    (i64.const 1)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (global.get $builtins/i)
     (i32.const 1)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 96)
     (i32.const 174)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (global.set $builtins/i
   (i64.eq
    (i64.const 1)
    (i64.const 0)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (global.get $builtins/i)
     (i32.const 0)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 96)
     (i32.const 176)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (global.set $builtins/i
   (i64.ne
    (i64.const 1)
    (i64.const 1)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (global.get $builtins/i)
     (i32.const 0)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 96)
     (i32.const 178)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (global.set $builtins/i
   (i64.ne
    (i64.const 1)
    (i64.const 0)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (global.get $builtins/i)
     (i32.const 1)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 96)
     (i32.const 180)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (global.set $builtins/I
   (i64.rem_s
    (i64.const 1)
    (i64.const 3)
   )
  )
  (if
   (i32.eqz
    (i64.eq
     (global.get $builtins/I)
     (i64.const 1)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 96)
     (i32.const 182)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (global.set $builtins/I
   (i64.rem_s
    (i64.const 15)
    (i64.const 4)
   )
  )
  (if
   (i32.eqz
    (i64.eq
     (global.get $builtins/I)
     (i64.const 3)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 96)
     (i32.const 184)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (drop
   (f32.const nan:0x400000)
  )
  (drop
   (f32.const inf)
  )
  (drop
   (f32.abs
    (f32.const 1.25)
   )
  )
  (drop
   (f32.ceil
    (f32.const 1.25)
   )
  )
  (drop
   (f32.copysign
    (f32.const 1.25)
    (f32.const 2.5)
   )
  )
  (drop
   (f32.floor
    (f32.const 1.25)
   )
  )
  (drop
   (f32.add
    (f32.const 1.5)
    (f32.const 2.5)
   )
  )
  (drop
   (f32.sub
    (f32.const 2.5)
    (f32.const 1.5)
   )
  )
  (drop
   (f32.mul
    (f32.const 1.5)
    (f32.const 2)
   )
  )
  (drop
   (f32.div
    (f32.const 1.5)
    (f32.const 0.5)
   )
  )
  (drop
   (f32.max
    (f32.const 1.25)
    (f32.const 2.5)
   )
  )
  (drop
   (f32.min
    (f32.const 1.25)
    (f32.const 2.5)
   )
  )
  (drop
   (f32.nearest
    (f32.const 1.25)
   )
  )
  (drop
   (f32.sqrt
    (f32.const 1.25)
   )
  )
  (drop
   (f32.trunc
    (f32.const 1.25)
   )
  )
  (drop
   (f32.eq
    (f32.const 1.5)
    (f32.const 2.5)
   )
  )
  (drop
   (f32.ne
    (f32.const 1.5)
    (f32.const 2.5)
   )
  )
  (drop
   (i32.eq
    (f32.ne
     (local.tee $24
      (f32.const 1.25)
     )
     (local.get $24)
    )
    (i32.const 0)
   )
  )
  (drop
   (i32.eq
    (f32.ne
     (local.tee $25
      (f32.const nan:0x400000)
     )
     (local.get $25)
    )
    (i32.const 1)
   )
  )
  (drop
   (i32.eq
    (f32.eq
     (f32.sub
      (local.tee $26
       (f32.const 1.25)
      )
      (local.get $26)
     )
     (f32.const 0)
    )
    (i32.const 1)
   )
  )
  (drop
   (i32.eq
    (f32.eq
     (f32.sub
      (local.tee $27
       (f32.const inf)
      )
      (local.get $27)
     )
     (f32.const 0)
    )
    (i32.const 0)
   )
  )
  (drop
   (i32.eq
    (f32.eq
     (f32.sub
      (local.tee $28
       (f32.neg
        (f32.const inf)
       )
      )
      (local.get $28)
     )
     (f32.const 0)
    )
    (i32.const 0)
   )
  )
  (drop
   (i32.eq
    (f32.eq
     (f32.sub
      (local.tee $29
       (f32.const nan:0x400000)
      )
      (local.get $29)
     )
     (f32.const 0)
    )
    (i32.const 0)
   )
  )
  (drop
   (global.get $~lib/builtins/f32.NaN)
  )
  (drop
   (f32.abs
    (f32.const 1.25)
   )
  )
  (drop
   (f32.ceil
    (f32.const 1.25)
   )
  )
  (drop
   (f32.copysign
    (f32.const 1.25)
    (f32.const 2.5)
   )
  )
  (drop
   (f32.floor
    (f32.const 1.25)
   )
  )
  (drop
   (f32.add
    (f32.const 1.5)
    (f32.const 2.5)
   )
  )
  (drop
   (f32.sub
    (f32.const 2.5)
    (f32.const 1.5)
   )
  )
  (drop
   (f32.mul
    (f32.const 1.5)
    (f32.const 2)
   )
  )
  (drop
   (f32.div
    (f32.const 1.5)
    (f32.const 0.5)
   )
  )
  (drop
   (f32.max
    (f32.const 1.25)
    (f32.const 2.5)
   )
  )
  (drop
   (f32.min
    (f32.const 1.25)
    (f32.const 2.5)
   )
  )
  (drop
   (f32.nearest
    (f32.const 1.25)
   )
  )
  (drop
   (f32.sqrt
    (f32.const 1.25)
   )
  )
  (drop
   (f32.trunc
    (f32.const 1.25)
   )
  )
  (drop
   (f32.eq
    (f32.const 1.5)
    (f32.const 2.5)
   )
  )
  (drop
   (f32.ne
    (f32.const 1.5)
    (f32.const 2.5)
   )
  )
  (global.set $builtins/f
   (f32.const nan:0x400000)
  )
  (global.set $builtins/f
   (f32.const inf)
  )
  (global.set $builtins/f
   (f32.abs
    (f32.const 1.25)
   )
  )
  (global.set $builtins/f
   (f32.ceil
    (f32.const 1.25)
   )
  )
  (global.set $builtins/f
   (f32.copysign
    (f32.const 1.25)
    (f32.const 2.5)
   )
  )
  (global.set $builtins/f
   (f32.floor
    (f32.const 1.25)
   )
  )
  (global.set $builtins/f
   (f32.add
    (f32.const 1.5)
    (f32.const 2.5)
   )
  )
  (if
   (i32.eqz
    (f32.eq
     (global.get $builtins/f)
     (f32.const 4)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 96)
     (i32.const 237)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (global.set $builtins/f
   (f32.sub
    (f32.const 2.5)
    (f32.const 1.5)
   )
  )
  (if
   (i32.eqz
    (f32.eq
     (global.get $builtins/f)
     (f32.const 1)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 96)
     (i32.const 239)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (global.set $builtins/f
   (f32.mul
    (f32.const 1.5)
    (f32.const 2)
   )
  )
  (if
   (i32.eqz
    (f32.eq
     (global.get $builtins/f)
     (f32.const 3)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 96)
     (i32.const 241)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (global.set $builtins/f
   (f32.div
    (f32.const 1.5)
    (f32.const 0.5)
   )
  )
  (if
   (i32.eqz
    (f32.eq
     (global.get $builtins/f)
     (f32.const 3)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 96)
     (i32.const 243)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (global.set $builtins/f
   (f32.max
    (f32.const 1.25)
    (f32.const 2.5)
   )
  )
  (if
   (i32.eqz
    (f32.eq
     (global.get $builtins/f)
     (f32.const 2.5)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 96)
     (i32.const 245)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (global.set $builtins/f
   (f32.min
    (f32.const 1.25)
    (f32.const 2.5)
   )
  )
  (global.set $builtins/f
   (f32.nearest
    (f32.const 1.25)
   )
  )
  (global.set $builtins/f
   (f32.sqrt
    (f32.const 1.25)
   )
  )
  (global.set $builtins/f
   (f32.trunc
    (f32.const 1.25)
   )
  )
  (global.set $builtins/i
   (f32.eq
    (f32.const 1.5)
    (f32.const 1.5)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (global.get $builtins/i)
     (i32.const 1)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 96)
     (i32.const 251)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (global.set $builtins/i
   (f32.eq
    (f32.const 1.5)
    (f32.const 2.5)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (global.get $builtins/i)
     (i32.const 0)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 96)
     (i32.const 253)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (global.set $builtins/i
   (f32.ne
    (f32.const 1.5)
    (f32.const 1.5)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (global.get $builtins/i)
     (i32.const 0)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 96)
     (i32.const 255)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (global.set $builtins/i
   (f32.ne
    (f32.const 1.5)
    (f32.const 2.5)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (global.get $builtins/i)
     (i32.const 1)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 96)
     (i32.const 257)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (global.set $builtins/b
   (f32.ne
    (local.tee $30
     (f32.const 1.25)
    )
    (local.get $30)
   )
  )
  (global.set $builtins/b
   (f32.eq
    (f32.sub
     (local.tee $31
      (f32.const 1.25)
     )
     (local.get $31)
    )
    (f32.const 0)
   )
  )
  (drop
   (f64.const nan:0x8000000000000)
  )
  (drop
   (f64.const inf)
  )
  (drop
   (f64.const nan:0x8000000000000)
  )
  (drop
   (f64.const inf)
  )
  (drop
   (f64.abs
    (f64.const 1.25)
   )
  )
  (drop
   (f64.ceil
    (f64.const 1.25)
   )
  )
  (drop
   (f64.copysign
    (f64.const 1.25)
    (f64.const 2.5)
   )
  )
  (drop
   (f64.floor
    (f64.const 1.25)
   )
  )
  (drop
   (f64.add
    (f64.const 1.5)
    (f64.const 2.5)
   )
  )
  (drop
   (f64.sub
    (f64.const 2.5)
    (f64.const 1.5)
   )
  )
  (drop
   (f64.mul
    (f64.const 1.5)
    (f64.const 2)
   )
  )
  (drop
   (f64.div
    (f64.const 1.5)
    (f64.const 0.5)
   )
  )
  (drop
   (f64.max
    (f64.const 1.25)
    (f64.const 2.5)
   )
  )
  (drop
   (f64.min
    (f64.const 1.25)
    (f64.const 2.5)
   )
  )
  (drop
   (f64.nearest
    (f64.const 1.25)
   )
  )
  (drop
   (f64.sqrt
    (f64.const 1.25)
   )
  )
  (drop
   (f64.trunc
    (f64.const 1.25)
   )
  )
  (drop
   (f64.eq
    (f64.const 1.5)
    (f64.const 1.5)
   )
  )
  (drop
   (f64.eq
    (f64.const 1.5)
    (f64.const 2.5)
   )
  )
  (drop
   (f64.ne
    (f64.const 1.5)
    (f64.const 1.5)
   )
  )
  (drop
   (f64.ne
    (f64.const 1.5)
    (f64.const 2.5)
   )
  )
  (drop
   (i32.eq
    (f64.ne
     (local.tee $32
      (f64.const 1.25)
     )
     (local.get $32)
    )
    (i32.const 0)
   )
  )
  (drop
   (i32.eq
    (f64.ne
     (local.tee $33
      (f64.const nan:0x8000000000000)
     )
     (local.get $33)
    )
    (i32.const 1)
   )
  )
  (drop
   (i32.eq
    (f64.eq
     (f64.sub
      (local.tee $34
       (f64.const 1.25)
      )
      (local.get $34)
     )
     (f64.const 0)
    )
    (i32.const 1)
   )
  )
  (drop
   (i32.eq
    (f64.eq
     (f64.sub
      (local.tee $35
       (f64.const inf)
      )
      (local.get $35)
     )
     (f64.const 0)
    )
    (i32.const 0)
   )
  )
  (drop
   (i32.eq
    (f64.eq
     (f64.sub
      (local.tee $36
       (f64.neg
        (f64.const inf)
       )
      )
      (local.get $36)
     )
     (f64.const 0)
    )
    (i32.const 0)
   )
  )
  (drop
   (i32.eq
    (f64.eq
     (f64.sub
      (local.tee $37
       (f64.const nan:0x8000000000000)
      )
      (local.get $37)
     )
     (f64.const 0)
    )
    (i32.const 0)
   )
  )
  (drop
   (global.get $~lib/builtins/f64.NaN)
  )
  (drop
   (f64.abs
    (f64.const 1.25)
   )
  )
  (drop
   (f64.ceil
    (f64.const 1.25)
   )
  )
  (drop
   (f64.copysign
    (f64.const 1.25)
    (f64.const 2.5)
   )
  )
  (drop
   (f64.floor
    (f64.const 1.25)
   )
  )
  (drop
   (f64.add
    (f64.const 1.5)
    (f64.const 2.5)
   )
  )
  (drop
   (f64.sub
    (f64.const 2.5)
    (f64.const 1.5)
   )
  )
  (drop
   (f64.mul
    (f64.const 1.5)
    (f64.const 2)
   )
  )
  (drop
   (f64.div
    (f64.const 1.5)
    (f64.const 0.5)
   )
  )
  (drop
   (f64.max
    (f64.const 1.25)
    (f64.const 2.5)
   )
  )
  (drop
   (f64.min
    (f64.const 1.25)
    (f64.const 2.5)
   )
  )
  (drop
   (f64.nearest
    (f64.const 1.25)
   )
  )
  (drop
   (f64.sqrt
    (f64.const 1.25)
   )
  )
  (drop
   (f64.trunc
    (f64.const 1.25)
   )
  )
  (drop
   (f64.eq
    (f64.const 1.5)
    (f64.const 2.5)
   )
  )
  (drop
   (f64.ne
    (f64.const 1.5)
    (f64.const 2.5)
   )
  )
  (global.set $builtins/F
   (f64.const nan:0x8000000000000)
  )
  (global.set $builtins/F
   (f64.const inf)
  )
  (global.set $builtins/F
   (f64.abs
    (f64.const 1.25)
   )
  )
  (global.set $builtins/F
   (f64.ceil
    (f64.const 1.25)
   )
  )
  (global.set $builtins/F
   (f64.copysign
    (f64.const 1.25)
    (f64.const 2.5)
   )
  )
  (global.set $builtins/F
   (f64.floor
    (f64.const 1.25)
   )
  )
  (global.set $builtins/F
   (f64.add
    (f64.const 1.5)
    (f64.const 2.5)
   )
  )
  (if
   (i32.eqz
    (f64.eq
     (global.get $builtins/F)
     (f64.const 4)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 96)
     (i32.const 314)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (global.set $builtins/F
   (f64.sub
    (f64.const 2.5)
    (f64.const 1.5)
   )
  )
  (if
   (i32.eqz
    (f64.eq
     (global.get $builtins/F)
     (f64.const 1)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 96)
     (i32.const 316)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (global.set $builtins/F
   (f64.mul
    (f64.const 1.5)
    (f64.const 2)
   )
  )
  (if
   (i32.eqz
    (f64.eq
     (global.get $builtins/F)
     (f64.const 3)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 96)
     (i32.const 318)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (global.set $builtins/F
   (f64.div
    (f64.const 1.5)
    (f64.const 0.5)
   )
  )
  (if
   (i32.eqz
    (f64.eq
     (global.get $builtins/F)
     (f64.const 3)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 96)
     (i32.const 320)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (global.set $builtins/F
   (f64.max
    (f64.const 1.25)
    (f64.const 2.5)
   )
  )
  (global.set $builtins/F
   (f64.min
    (f64.const 1.25)
    (f64.const 2.5)
   )
  )
  (global.set $builtins/F
   (f64.nearest
    (f64.const 1.25)
   )
  )
  (global.set $builtins/F
   (f64.sqrt
    (f64.const 1.25)
   )
  )
  (global.set $builtins/F
   (f64.trunc
    (f64.const 1.25)
   )
  )
  (global.set $builtins/i
   (f64.eq
    (f64.const 1.5)
    (f64.const 1.5)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (global.get $builtins/i)
     (i32.const 1)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 96)
     (i32.const 327)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (global.set $builtins/i
   (f64.eq
    (f64.const 1.5)
    (f64.const 2.5)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (global.get $builtins/i)
     (i32.const 0)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 96)
     (i32.const 329)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (global.set $builtins/i
   (f64.ne
    (f64.const 1.5)
    (f64.const 1.5)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (global.get $builtins/i)
     (i32.const 0)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 96)
     (i32.const 331)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (global.set $builtins/i
   (f64.ne
    (f64.const 1.5)
    (f64.const 2.5)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (global.get $builtins/i)
     (i32.const 1)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 96)
     (i32.const 333)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (global.set $builtins/b
   (f64.ne
    (local.tee $38
     (f64.const 1.25)
    )
    (local.get $38)
   )
  )
  (global.set $builtins/b
   (f64.eq
    (f64.sub
     (local.tee $39
      (f64.const 1.25)
     )
     (local.get $39)
    )
    (f64.const 0)
   )
  )
  (global.set $builtins/F
   (f64.min
    (f64.const 0)
    (f64.const 1)
   )
  )
  (global.set $builtins/f
   (f32.max
    (f32.const 0)
    (global.get $builtins/f)
   )
  )
  (global.set $builtins/F
   (f64.add
    (f64.const 0)
    (f64.const 1.5)
   )
  )
  (global.set $builtins/f
   (f32.add
    (f32.const 0)
    (global.get $builtins/f)
   )
  )
  (global.set $builtins/F
   (f64.sub
    (f64.const 2)
    (f64.const 1)
   )
  )
  (global.set $builtins/f
   (f32.sub
    (f32.const 2)
    (global.get $builtins/f)
   )
  )
  (global.set $builtins/F
   (f64.mul
    (f64.const 2)
    (f64.const 1)
   )
  )
  (global.set $builtins/f
   (f32.mul
    (f32.const 2)
    (global.get $builtins/f)
   )
  )
  (global.set $builtins/F
   (f64.div
    (f64.const 2)
    (f64.const 1)
   )
  )
  (global.set $builtins/f
   (f32.div
    (f32.const 2)
    (global.get $builtins/f)
   )
  )
  (global.set $builtins/i
   (i32.load
    (i32.const 8)
   )
  )
  (i32.store
   (i32.const 8)
   (global.get $builtins/i)
  )
  (i32.store
   (i32.const 8)
   (i32.load
    (i32.const 8)
   )
  )
  (global.set $builtins/I
   (i64.load
    (i32.const 8)
   )
  )
  (i64.store
   (i32.const 8)
   (global.get $builtins/I)
  )
  (i64.store
   (i32.const 8)
   (i64.load
    (i32.const 8)
   )
  )
  (global.set $builtins/f
   (f32.load
    (i32.const 8)
   )
  )
  (f32.store
   (i32.const 8)
   (global.get $builtins/f)
  )
  (f32.store
   (i32.const 8)
   (f32.load
    (i32.const 8)
   )
  )
  (global.set $builtins/F
   (f64.load
    (i32.const 8)
   )
  )
  (f64.store
   (i32.const 8)
   (global.get $builtins/F)
  )
  (f64.store
   (i32.const 8)
   (f64.load
    (i32.const 8)
   )
  )
  (global.set $builtins/i
   (i32.load offset=8
    (i32.const 0)
   )
  )
  (i32.store offset=8
   (i32.const 0)
   (global.get $builtins/i)
  )
  (i32.store offset=8
   (i32.const 0)
   (i32.load offset=8
    (i32.const 0)
   )
  )
  (global.set $builtins/I
   (i64.load offset=8
    (i32.const 0)
   )
  )
  (i64.store offset=8
   (i32.const 0)
   (global.get $builtins/I)
  )
  (i64.store offset=8
   (i32.const 0)
   (i64.load offset=8
    (i32.const 0)
   )
  )
  (global.set $builtins/f
   (f32.load offset=8
    (i32.const 0)
   )
  )
  (f32.store offset=8
   (i32.const 0)
   (global.get $builtins/f)
  )
  (f32.store offset=8
   (i32.const 0)
   (f32.load offset=8
    (i32.const 0)
   )
  )
  (global.set $builtins/F
   (f64.load offset=8
    (i32.const 0)
   )
  )
  (f64.store offset=8
   (i32.const 0)
   (global.get $builtins/F)
  )
  (f64.store offset=8
   (i32.const 0)
   (f64.load offset=8
    (i32.const 0)
   )
  )
  (global.set $builtins/i
   (i32.load8_s
    (i32.const 8)
   )
  )
  (global.set $builtins/i
   (i32.load16_s
    (i32.const 8)
   )
  )
  (global.set $builtins/i
   (i32.load
    (i32.const 8)
   )
  )
  (global.set $builtins/i
   (i32.load8_u
    (i32.const 8)
   )
  )
  (global.set $builtins/i
   (i32.load16_u
    (i32.const 8)
   )
  )
  (global.set $builtins/i
   (i32.load
    (i32.const 8)
   )
  )
  (global.set $builtins/u
   (i32.load8_u
    (i32.const 8)
   )
  )
  (global.set $builtins/u
   (i32.load16_u
    (i32.const 8)
   )
  )
  (global.set $builtins/u
   (i32.load
    (i32.const 8)
   )
  )
  (global.set $builtins/u
   (i32.load8_s
    (i32.const 8)
   )
  )
  (global.set $builtins/u
   (i32.load16_s
    (i32.const 8)
   )
  )
  (global.set $builtins/u
   (i32.load
    (i32.const 8)
   )
  )
  (global.set $builtins/I
   (i64.load8_s
    (i32.const 8)
   )
  )
  (global.set $builtins/I
   (i64.load16_s
    (i32.const 8)
   )
  )
  (global.set $builtins/I
   (i64.load32_s
    (i32.const 8)
   )
  )
  (global.set $builtins/I
   (i64.load
    (i32.const 8)
   )
  )
  (global.set $builtins/u
   (i32.rem_u
    (i32.const 15)
    (i32.const 4)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (global.get $builtins/u)
     (i32.const 3)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 96)
     (i32.const 404)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (global.set $builtins/U
   (i64.load8_u
    (i32.const 8)
   )
  )
  (global.set $builtins/U
   (i64.load16_u
    (i32.const 8)
   )
  )
  (global.set $builtins/U
   (i64.load32_u
    (i32.const 8)
   )
  )
  (global.set $builtins/U
   (i64.load
    (i32.const 8)
   )
  )
  (i32.store8
   (i32.const 8)
   (i32.const 1)
  )
  (i32.store16
   (i32.const 8)
   (i32.const 1)
  )
  (i32.store
   (i32.const 8)
   (i32.const 1)
  )
  (i64.store8
   (i32.const 8)
   (i64.const 1)
  )
  (i64.store16
   (i32.const 8)
   (i64.const 1)
  )
  (i64.store32
   (i32.const 8)
   (i64.const 1)
  )
  (i64.store
   (i32.const 8)
   (i64.const 1)
  )
  (i64.store
   (i32.const 8)
   (i64.extend_i32_s
    (i32.const 1)
   )
  )
  (global.set $builtins/U
   (i64.rem_u
    (i64.const 15)
    (i64.const 4)
   )
  )
  (if
   (i32.eqz
    (i64.eq
     (global.get $builtins/U)
     (i64.const 3)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 96)
     (i32.const 424)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (drop
   (i32.reinterpret_f32
    (f32.const 1.25)
   )
  )
  (drop
   (f32.reinterpret_i32
    (i32.const 25)
   )
  )
  (drop
   (i64.reinterpret_f64
    (f64.const 1.25)
   )
  )
  (drop
   (f64.reinterpret_i64
    (i64.const 25)
   )
  )
  (global.set $builtins/i
   (i32.reinterpret_f32
    (f32.const 1.25)
   )
  )
  (global.set $builtins/f
   (f32.reinterpret_i32
    (i32.const 25)
   )
  )
  (global.set $builtins/I
   (i64.reinterpret_f64
    (f64.const 1.25)
   )
  )
  (global.set $builtins/F
   (f64.reinterpret_i64
    (i64.const 25)
   )
  )
  (drop
   (memory.size)
  )
  (drop
   (memory.grow
    (i32.const 1)
   )
  )
  (global.set $builtins/s
   (memory.size)
  )
  (global.set $builtins/s
   (memory.grow
    (i32.const 1)
   )
  )
  (drop
   (select
    (i32.const 10)
    (i32.const 20)
    (i32.const 1)
   )
  )
  (drop
   (select
    (i64.const 100)
    (i64.const 200)
    (i32.const 0)
   )
  )
  (drop
   (select
    (f32.const 1.25)
    (f32.const 2.5)
    (i32.const 1)
   )
  )
  (drop
   (select
    (f64.const 12.5)
    (f64.const 25)
    (i32.const 0)
   )
  )
  (global.set $builtins/i
   (select
    (i32.const 10)
    (i32.const 20)
    (i32.const 1)
   )
  )
  (global.set $builtins/I
   (select
    (i64.const 100)
    (i64.const 200)
    (i32.const 0)
   )
  )
  (global.set $builtins/f
   (select
    (f32.const 1.25)
    (f32.const 2.5)
    (i32.const 1)
   )
  )
  (global.set $builtins/F
   (select
    (f64.const 12.5)
    (f64.const 25)
    (i32.const 0)
   )
  )
  (if
   (i32.eqz
    (global.get $builtins/i)
   )
   (then
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (call_indirect (type $1)
      (i32.const 1)
      (i32.const 2)
      (i32.load
       (block (result i32)
        (global.set $~argumentsLength
         (i32.const 2)
        )
        (global.get $builtins/fn)
       )
      )
     )
     (i32.const 3)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 96)
     (i32.const 465)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (i32.const 5)
     (call_indirect (type $1)
      (i32.const 2)
      (i32.const 3)
      (call $~lib/function/Function<%28i32%2Ci32%29=>i32>#get:index
       (call $~lib/rt/__tmptostack
        (global.get $builtins/fn)
       )
      )
     )
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 96)
     (i32.const 466)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (call $~lib/string/String.__eq
     (call $~lib/rt/__tmptostack
      (call $~lib/function/Function<%28i32%2Ci32%29=>i32>#get:name
       (call $~lib/rt/__tmptostack
        (global.get $builtins/fn)
       )
      )
     )
     (i32.const 32)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 96)
     (i32.const 467)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (call $~lib/function/Function<%28i32%2Ci32%29=>i32>#get:length
      (call $~lib/rt/__tmptostack
       (global.get $builtins/fn)
      )
     )
     (i32.const 2)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 96)
     (i32.const 468)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (call $~lib/function/Function<%28i32%2Ci32%29=>i32>#get:length
      (call $~lib/rt/__tmptostack
       (global.get $builtins/fn)
      )
     )
     (i32.const 2)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 96)
     (i32.const 469)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (call $~lib/string/String.__eq
     (call $~lib/rt/__tmptostack
      (call $~lib/function/Function<%28i32%2Ci32%29=>i32>#toString
       (call $~lib/rt/__tmptostack
        (global.get $builtins/fn)
       )
      )
     )
     (i32.const 176)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 96)
     (i32.const 470)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (drop
   (i32.eq
    (i32.const 1)
    (i32.const 1)
   )
  )
  (drop
   (i32.eq
    (i32.const 2)
    (i32.const 2)
   )
  )
  (drop
   (i32.eq
    (i32.const 4)
    (i32.const 4)
   )
  )
  (drop
   (i32.eq
    (i32.const 8)
    (i32.const 8)
   )
  )
  (drop
   (i32.const 4)
  )
  (drop
   (i32.eq
    (i32.const 1)
    (i32.const 1)
   )
  )
  (drop
   (i32.eq
    (i32.const 1)
    (i32.const 1)
   )
  )
  (drop
   (i32.eq
    (i32.const 2)
    (i32.const 2)
   )
  )
  (drop
   (i32.eq
    (i32.const 4)
    (i32.const 4)
   )
  )
  (drop
   (i32.eq
    (i32.const 8)
    (i32.const 8)
   )
  )
  (drop
   (i32.const 4)
  )
  (drop
   (i32.eq
    (i32.const 4)
    (i32.const 4)
   )
  )
  (drop
   (i32.eq
    (i32.const 8)
    (i32.const 8)
   )
  )
  (drop
   (i32.eq
    (i32.const 0)
    (i32.const 0)
   )
  )
  (drop
   (i32.eq
    (i32.const 1)
    (i32.const 1)
   )
  )
  (drop
   (i32.eq
    (i32.const 2)
    (i32.const 2)
   )
  )
  (drop
   (i32.eq
    (i32.const 3)
    (i32.const 3)
   )
  )
  (drop
   (i32.eq
    (i32.const 0)
    (i32.const 0)
   )
  )
  (drop
   (i32.eq
    (i32.const 0)
    (i32.const 0)
   )
  )
  (drop
   (i32.eq
    (i32.const 4)
    (i32.const 4)
   )
  )
  (drop
   (i32.eq
    (i32.const 0)
    (i32.const 0)
   )
  )
  (drop
   (i32.eq
    (i32.const 2)
    (i32.const 2)
   )
  )
  (drop
   (i32.eq
    (i32.const 0)
    (i32.const 0)
   )
  )
  (drop
   (i32.eq
    (i32.const 8)
    (i32.const 8)
   )
  )
  (drop
   (f64.ne
    (f64.const nan:0x8000000000000)
    (f64.const nan:0x8000000000000)
   )
  )
  (drop
   (f32.ne
    (local.tee $40
     (f32.const nan:0x400000)
    )
    (local.get $40)
   )
  )
  (drop
   (f64.ne
    (local.tee $41
     (f64.const nan:0x8000000000000)
    )
    (local.get $41)
   )
  )
  (drop
   (i32.eqz
    (f32.eq
     (f32.sub
      (local.tee $42
       (f32.const nan:0x400000)
      )
      (local.get $42)
     )
     (f32.const 0)
    )
   )
  )
  (drop
   (i32.eqz
    (f32.eq
     (f32.sub
      (local.tee $43
       (f32.const inf)
      )
      (local.get $43)
     )
     (f32.const 0)
    )
   )
  )
  (drop
   (i32.eqz
    (f64.eq
     (f64.sub
      (local.tee $44
       (f64.const nan:0x8000000000000)
      )
      (local.get $44)
     )
     (f64.const 0)
    )
   )
  )
  (drop
   (i32.eqz
    (f64.eq
     (f64.sub
      (local.tee $45
       (f64.const inf)
      )
      (local.get $45)
     )
     (f64.const 0)
    )
   )
  )
  (drop
   (f32.eq
    (f32.sub
     (local.tee $46
      (f32.const 0)
     )
     (local.get $46)
    )
    (f32.const 0)
   )
  )
  (drop
   (f64.eq
    (f64.sub
     (local.tee $47
      (f64.const 0)
     )
     (local.get $47)
    )
    (f64.const 0)
   )
  )
  (drop
   (i32.eq
    (global.get $~lib/builtins/i8.MIN_VALUE)
    (i32.extend8_s
     (i32.const 128)
    )
   )
  )
  (drop
   (i32.eq
    (global.get $~lib/builtins/i8.MAX_VALUE)
    (i32.const 127)
   )
  )
  (drop
   (i32.eq
    (global.get $~lib/builtins/i16.MIN_VALUE)
    (i32.extend16_s
     (i32.const 32768)
    )
   )
  )
  (drop
   (i32.eq
    (global.get $~lib/builtins/i16.MAX_VALUE)
    (i32.const 32767)
   )
  )
  (drop
   (i32.eq
    (global.get $~lib/builtins/i32.MIN_VALUE)
    (i32.const -2147483648)
   )
  )
  (drop
   (i32.eq
    (global.get $~lib/builtins/i32.MAX_VALUE)
    (i32.const 2147483647)
   )
  )
  (drop
   (i64.eq
    (global.get $~lib/builtins/i64.MIN_VALUE)
    (i64.const -9223372036854775808)
   )
  )
  (drop
   (i64.eq
    (global.get $~lib/builtins/i64.MAX_VALUE)
    (i64.const 9223372036854775807)
   )
  )
  (drop
   (i32.eq
    (global.get $~lib/builtins/u8.MIN_VALUE)
    (i32.const 0)
   )
  )
  (drop
   (i32.eq
    (global.get $~lib/builtins/u8.MAX_VALUE)
    (i32.const 255)
   )
  )
  (drop
   (i32.eq
    (global.get $~lib/builtins/u16.MIN_VALUE)
    (i32.const 0)
   )
  )
  (drop
   (i32.eq
    (global.get $~lib/builtins/u16.MAX_VALUE)
    (i32.const 65535)
   )
  )
  (drop
   (i32.eq
    (global.get $~lib/builtins/u32.MIN_VALUE)
    (i32.const 0)
   )
  )
  (drop
   (i32.eq
    (global.get $~lib/builtins/u32.MAX_VALUE)
    (i32.const -1)
   )
  )
  (drop
   (i64.eq
    (global.get $~lib/builtins/u64.MIN_VALUE)
    (i64.const 0)
   )
  )
  (drop
   (i64.eq
    (global.get $~lib/builtins/u64.MAX_VALUE)
    (i64.const -1)
   )
  )
  (drop
   (i32.eq
    (global.get $~lib/builtins/bool.MIN_VALUE)
    (i32.const 0)
   )
  )
  (drop
   (i32.eq
    (global.get $~lib/builtins/bool.MIN_VALUE)
    (i32.const 0)
   )
  )
  (drop
   (i32.eq
    (global.get $~lib/builtins/bool.MAX_VALUE)
    (i32.const 1)
   )
  )
  (drop
   (i32.eq
    (global.get $~lib/builtins/bool.MAX_VALUE)
    (i32.const 1)
   )
  )
  (drop
   (f32.eq
    (global.get $~lib/builtins/f32.MIN_NORMAL_VALUE)
    (f32.const 1.1754943508222875e-38)
   )
  )
  (drop
   (f32.eq
    (global.get $~lib/builtins/f32.MIN_VALUE)
    (f32.const 1.401298464324817e-45)
   )
  )
  (drop
   (f32.eq
    (global.get $~lib/builtins/f32.MAX_VALUE)
    (f32.const 3402823466385288598117041e14)
   )
  )
  (drop
   (f32.eq
    (global.get $~lib/builtins/f32.MIN_SAFE_INTEGER)
    (f32.const -16777215)
   )
  )
  (drop
   (f32.eq
    (global.get $~lib/builtins/f32.MAX_SAFE_INTEGER)
    (f32.const 16777215)
   )
  )
  (drop
   (f32.eq
    (global.get $~lib/builtins/f32.EPSILON)
    (f32.const 1.1920928955078125e-07)
   )
  )
  (drop
   (f64.eq
    (global.get $~lib/builtins/f64.MIN_NORMAL_VALUE)
    (f64.const 2.2250738585072014e-308)
   )
  )
  (drop
   (f64.eq
    (global.get $~lib/builtins/f64.MIN_VALUE)
    (f64.const 5e-324)
   )
  )
  (drop
   (f64.eq
    (global.get $~lib/builtins/f64.MAX_VALUE)
    (f64.const 1797693134862315708145274e284)
   )
  )
  (drop
   (f64.eq
    (global.get $~lib/builtins/f64.MIN_SAFE_INTEGER)
    (f64.const -9007199254740991)
   )
  )
  (drop
   (f64.eq
    (global.get $~lib/builtins/f64.MAX_SAFE_INTEGER)
    (f64.const 9007199254740991)
   )
  )
  (drop
   (f64.eq
    (global.get $~lib/builtins/f64.EPSILON)
    (f64.const 2.220446049250313e-16)
   )
  )
  (drop
   (f32.abs
    (f32.const 1)
   )
  )
  (drop
   (f64.abs
    (f64.const 1)
   )
  )
  (drop
   (f32.ceil
    (f32.const 1)
   )
  )
  (drop
   (f64.ceil
    (f64.const 1)
   )
  )
  (drop
   (i32.clz
    (i32.const 1)
   )
  )
  (drop
   (i64.clz
    (i64.const 1)
   )
  )
  (drop
   (f32.copysign
    (f32.const 1)
    (f32.const 2)
   )
  )
  (drop
   (f64.copysign
    (f64.const 1)
    (f64.const 2)
   )
  )
  (drop
   (i32.ctz
    (i32.const 1)
   )
  )
  (drop
   (i64.ctz
    (i64.const 1)
   )
  )
  (drop
   (f32.floor
    (f32.const 1)
   )
  )
  (drop
   (f64.floor
    (f64.const 1)
   )
  )
  (drop
   (f32.nearest
    (f32.const 1)
   )
  )
  (drop
   (f64.nearest
    (f64.const 1)
   )
  )
  (drop
   (i32.popcnt
    (i32.const 1)
   )
  )
  (drop
   (i64.popcnt
    (i64.const 1)
   )
  )
  (drop
   (i32.add
    (i32.const 1)
    (i32.const 2)
   )
  )
  (drop
   (i64.add
    (i64.const 1)
    (i64.const 2)
   )
  )
  (drop
   (i32.sub
    (i32.const 2)
    (i32.const 1)
   )
  )
  (drop
   (i64.sub
    (i64.const 2)
    (i64.const 1)
   )
  )
  (drop
   (i32.mul
    (i32.const 3)
    (i32.const 1)
   )
  )
  (drop
   (i64.mul
    (i64.const 3)
    (i64.const 1)
   )
  )
  (drop
   (i32.div_s
    (i32.const 4)
    (i32.const 1)
   )
  )
  (drop
   (i32.div_u
    (i32.const 4)
    (i32.const 1)
   )
  )
  (drop
   (i64.div_s
    (i64.const 5)
    (i64.const 1)
   )
  )
  (drop
   (i64.div_u
    (i64.const 5)
    (i64.const 1)
   )
  )
  (drop
   (i32.load8_s
    (i32.const 8)
   )
  )
  (drop
   (i32.load8_u
    (i32.const 8)
   )
  )
  (drop
   (i32.load16_s
    (i32.const 8)
   )
  )
  (drop
   (i32.load16_u
    (i32.const 8)
   )
  )
  (drop
   (i32.load
    (i32.const 8)
   )
  )
  (drop
   (i64.load8_s
    (i32.const 8)
   )
  )
  (drop
   (i64.load8_u
    (i32.const 8)
   )
  )
  (drop
   (i64.load16_s
    (i32.const 8)
   )
  )
  (drop
   (i64.load16_u
    (i32.const 8)
   )
  )
  (drop
   (i64.load32_s
    (i32.const 8)
   )
  )
  (drop
   (i64.load32_u
    (i32.const 8)
   )
  )
  (drop
   (i64.load
    (i32.const 8)
   )
  )
  (drop
   (f32.load
    (i32.const 8)
   )
  )
  (drop
   (f64.load
    (i32.const 8)
   )
  )
  (drop
   (f32.add
    (f32.const 1)
    (f32.const 2)
   )
  )
  (drop
   (f64.add
    (f64.const 1)
    (f64.const 2)
   )
  )
  (drop
   (f32.sub
    (f32.const 2)
    (f32.const 1)
   )
  )
  (drop
   (f64.sub
    (f64.const 2)
    (f64.const 1)
   )
  )
  (drop
   (f32.mul
    (f32.const 1)
    (f32.const 2)
   )
  )
  (drop
   (f64.mul
    (f64.const 1)
    (f64.const 2)
   )
  )
  (drop
   (f32.div
    (f32.const 1.5)
    (f32.const 0.5)
   )
  )
  (drop
   (f64.div
    (f64.const 1.5)
    (f64.const 0.5)
   )
  )
  (drop
   (f32.max
    (f32.const 1)
    (f32.const 2)
   )
  )
  (drop
   (f64.max
    (f64.const 1)
    (f64.const 2)
   )
  )
  (drop
   (f32.min
    (f32.const 1)
    (f32.const 2)
   )
  )
  (drop
   (f64.min
    (f64.const 1)
    (f64.const 2)
   )
  )
  (drop
   (i32.reinterpret_f32
    (f32.const 1)
   )
  )
  (drop
   (i64.reinterpret_f64
    (f64.const 1)
   )
  )
  (drop
   (f32.reinterpret_i32
    (i32.const 1)
   )
  )
  (drop
   (f64.reinterpret_i64
    (i64.const 1)
   )
  )
  (drop
   (i32.rotl
    (i32.const 1)
    (i32.const 2)
   )
  )
  (drop
   (i64.rotl
    (i64.const 1)
    (i64.const 2)
   )
  )
  (drop
   (i32.rotr
    (i32.const 1)
    (i32.const 2)
   )
  )
  (drop
   (i64.rotr
    (i64.const 1)
    (i64.const 2)
   )
  )
  (drop
   (f32.sqrt
    (f32.const 1)
   )
  )
  (drop
   (f64.sqrt
    (f64.const 1)
   )
  )
  (i32.store8
   (i32.const 8)
   (i32.const 1)
  )
  (i32.store16
   (i32.const 8)
   (i32.const 1)
  )
  (i32.store
   (i32.const 8)
   (i32.const 1)
  )
  (i64.store8
   (i32.const 8)
   (i64.const 1)
  )
  (i64.store16
   (i32.const 8)
   (i64.const 1)
  )
  (i64.store32
   (i32.const 8)
   (i64.const 1)
  )
  (i64.store
   (i32.const 8)
   (i64.const 1)
  )
  (f32.store
   (i32.const 8)
   (f32.const 1)
  )
  (f64.store
   (i32.const 8)
   (f64.const 1)
  )
  (drop
   (f32.trunc
    (f32.const 1)
   )
  )
  (drop
   (f64.trunc
    (f64.const 1)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (call $~lib/atomics/Atomics.isLockFree
      (i32.const 0)
     )
     (i32.const 0)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 96)
     (i32.const 657)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (call $~lib/atomics/Atomics.isLockFree
      (i32.const 1)
     )
     (i32.const 1)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 96)
     (i32.const 658)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (call $~lib/atomics/Atomics.isLockFree
      (i32.const 2)
     )
     (i32.const 1)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 96)
     (i32.const 659)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (call $~lib/atomics/Atomics.isLockFree
      (i32.const 3)
     )
     (i32.const 0)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 96)
     (i32.const 660)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (call $~lib/atomics/Atomics.isLockFree
      (i32.const 4)
     )
     (i32.const 1)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 96)
     (i32.const 661)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (call $~lib/atomics/Atomics.isLockFree
      (i32.const 5)
     )
     (i32.const 0)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 96)
     (i32.const 662)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (call $~lib/atomics/Atomics.isLockFree
      (i32.const 8)
     )
     (i32.const 0)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 96)
     (i32.const 663)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (block
   (local.set $a
    (i32.const 0)
   )
   (local.set $b
    (i32.const 0)
   )
   (local.set $c
    (i32.const 51)
   )
   (local.set $d
    (i32.const 52)
   )
   (local.set $e
    (i32.const 52)
   )
   (call $~lib/builtins/trace
    (i32.const 256)
    (i32.const 5)
    (f64.convert_i32_u
     (local.get $a)
    )
    (f64.convert_i32_u
     (local.get $b)
    )
    (f64.convert_i32_u
     (local.get $c)
    )
    (f64.convert_i32_u
     (local.get $d)
    )
    (f64.convert_i32_u
     (local.get $e)
    )
   )
   (if
    (i32.eqz
     (i32.eq
      (local.get $a)
      (local.get $b)
     )
    )
    (then
     (call $~lib/builtins/abort
      (i32.const 304)
      (i32.const 96)
      (i32.const 673)
      (i32.const 3)
     )
     (unreachable)
    )
   )
   (if
    (i32.eqz
     (i32.ne
      (local.get $a)
      (local.get $c)
     )
    )
    (then
     (call $~lib/builtins/abort
      (i32.const 0)
      (i32.const 96)
      (i32.const 674)
      (i32.const 3)
     )
     (unreachable)
    )
   )
   (if
    (i32.eqz
     (i32.eq
      (local.get $c)
      (i32.const 51)
     )
    )
    (then
     (call $~lib/builtins/abort
      (i32.const 0)
      (i32.const 96)
      (i32.const 675)
      (i32.const 3)
     )
     (unreachable)
    )
   )
   (if
    (i32.eqz
     (i32.eq
      (local.get $d)
      (local.get $e)
     )
    )
    (then
     (call $~lib/builtins/abort
      (i32.const 0)
      (i32.const 96)
      (i32.const 676)
      (i32.const 3)
     )
     (unreachable)
    )
   )
  )
  (block
   (if
    (i32.eqz
     (call $~lib/string/String.__eq
      (i32.const 352)
      (i32.const 352)
     )
    )
    (then
     (call $~lib/builtins/abort
      (i32.const 0)
      (i32.const 96)
      (i32.const 680)
      (i32.const 3)
     )
     (unreachable)
    )
   )
   (if
    (i32.eqz
     (call $~lib/string/String.__eq
      (i32.const 352)
      (i32.const 352)
     )
    )
    (then
     (call $~lib/builtins/abort
      (i32.const 0)
      (i32.const 96)
      (i32.const 681)
      (i32.const 3)
     )
     (unreachable)
    )
   )
   (if
    (i32.eqz
     (call $~lib/string/String.__eq
      (i32.const 400)
      (i32.const 400)
     )
    )
    (then
     (call $~lib/builtins/abort
      (i32.const 0)
      (i32.const 96)
      (i32.const 682)
      (i32.const 3)
     )
     (unreachable)
    )
   )
   (if
    (i32.eqz
     (call $~lib/string/String.__eq
      (i32.const 432)
      (i32.const 432)
     )
    )
    (then
     (call $~lib/builtins/abort
      (i32.const 0)
      (i32.const 96)
      (i32.const 683)
      (i32.const 3)
     )
     (unreachable)
    )
   )
   (if
    (i32.eqz
     (call $~lib/string/String.__eq
      (i32.const 464)
      (i32.const 464)
     )
    )
    (then
     (call $~lib/builtins/abort
      (i32.const 0)
      (i32.const 96)
      (i32.const 684)
      (i32.const 3)
     )
     (unreachable)
    )
   )
   (if
    (i32.eqz
     (call $~lib/string/String.__eq
      (i32.const 496)
      (i32.const 496)
     )
    )
    (then
     (call $~lib/builtins/abort
      (i32.const 0)
      (i32.const 96)
      (i32.const 685)
      (i32.const 3)
     )
     (unreachable)
    )
   )
   (if
    (i32.eqz
     (call $~lib/string/String.__eq
      (i32.const 528)
      (i32.const 528)
     )
    )
    (then
     (call $~lib/builtins/abort
      (i32.const 0)
      (i32.const 96)
      (i32.const 686)
      (i32.const 3)
     )
     (unreachable)
    )
   )
   (if
    (i32.eqz
     (call $~lib/string/String.__eq
      (i32.const 560)
      (i32.const 560)
     )
    )
    (then
     (call $~lib/builtins/abort
      (i32.const 0)
      (i32.const 96)
      (i32.const 687)
      (i32.const 3)
     )
     (unreachable)
    )
   )
   (if
    (i32.eqz
     (call $~lib/string/String.__eq
      (i32.const 592)
      (i32.const 592)
     )
    )
    (then
     (call $~lib/builtins/abort
      (i32.const 0)
      (i32.const 96)
      (i32.const 688)
      (i32.const 3)
     )
     (unreachable)
    )
   )
   (if
    (i32.eqz
     (call $~lib/string/String.__eq
      (i32.const 624)
      (i32.const 624)
     )
    )
    (then
     (call $~lib/builtins/abort
      (i32.const 0)
      (i32.const 96)
      (i32.const 689)
      (i32.const 3)
     )
     (unreachable)
    )
   )
   (if
    (i32.eqz
     (call $~lib/string/String.__eq
      (i32.const 656)
      (i32.const 656)
     )
    )
    (then
     (call $~lib/builtins/abort
      (i32.const 0)
      (i32.const 96)
      (i32.const 690)
      (i32.const 3)
     )
     (unreachable)
    )
   )
   (if
    (i32.eqz
     (call $~lib/string/String.__eq
      (i32.const 688)
      (i32.const 688)
     )
    )
    (then
     (call $~lib/builtins/abort
      (i32.const 0)
      (i32.const 96)
      (i32.const 691)
      (i32.const 3)
     )
     (unreachable)
    )
   )
   (if
    (i32.eqz
     (call $~lib/string/String.__eq
      (i32.const 720)
      (i32.const 720)
     )
    )
    (then
     (call $~lib/builtins/abort
      (i32.const 0)
      (i32.const 96)
      (i32.const 692)
      (i32.const 3)
     )
     (unreachable)
    )
   )
   (if
    (i32.eqz
     (call $~lib/string/String.__eq
      (i32.const 752)
      (i32.const 752)
     )
    )
    (then
     (call $~lib/builtins/abort
      (i32.const 0)
      (i32.const 96)
      (i32.const 693)
      (i32.const 3)
     )
     (unreachable)
    )
   )
   (if
    (i32.eqz
     (call $~lib/string/String.__eq
      (i32.const 784)
      (i32.const 784)
     )
    )
    (then
     (call $~lib/builtins/abort
      (i32.const 0)
      (i32.const 96)
      (i32.const 694)
      (i32.const 3)
     )
     (unreachable)
    )
   )
   (if
    (i32.eqz
     (call $~lib/string/String.__eq
      (i32.const 816)
      (i32.const 816)
     )
    )
    (then
     (call $~lib/builtins/abort
      (i32.const 0)
      (i32.const 96)
      (i32.const 695)
      (i32.const 3)
     )
     (unreachable)
    )
   )
   (if
    (i32.eqz
     (call $~lib/string/String.__eq
      (i32.const 848)
      (i32.const 848)
     )
    )
    (then
     (call $~lib/builtins/abort
      (i32.const 0)
      (i32.const 96)
      (i32.const 696)
      (i32.const 3)
     )
     (unreachable)
    )
   )
   (if
    (i32.eqz
     (call $~lib/string/String.__eq
      (i32.const 880)
      (i32.const 880)
     )
    )
    (then
     (call $~lib/builtins/abort
      (i32.const 0)
      (i32.const 96)
      (i32.const 697)
      (i32.const 3)
     )
     (unreachable)
    )
   )
   (if
    (i32.eqz
     (call $~lib/string/String.__eq
      (i32.const 432)
      (i32.const 432)
     )
    )
    (then
     (call $~lib/builtins/abort
      (i32.const 0)
      (i32.const 96)
      (i32.const 698)
      (i32.const 3)
     )
     (unreachable)
    )
   )
   (if
    (i32.eqz
     (call $~lib/string/String.__eq
      (i32.const 352)
      (i32.const 352)
     )
    )
    (then
     (call $~lib/builtins/abort
      (i32.const 0)
      (i32.const 96)
      (i32.const 699)
      (i32.const 3)
     )
     (unreachable)
    )
   )
  )
  (drop
   (i32.const 1)
  )
  (drop
   (i32.eqz
    (i32.const 0)
   )
  )
  (drop
   (i32.eqz
    (i32.const 0)
   )
  )
  (drop
   (i32.eqz
    (i32.const 0)
   )
  )
  (drop
   (i32.eqz
    (i32.const 0)
   )
  )
  (drop
   (i32.eqz
    (i32.const 0)
   )
  )
  (drop
   (i32.eqz
    (i32.const 0)
   )
  )
  (drop
   (i32.eqz
    (i32.const 0)
   )
  )
  (drop
   (i32.eqz
    (i32.const 0)
   )
  )
  (drop
   (i32.eqz
    (i32.const 0)
   )
  )
  (drop
   (i32.eqz
    (i32.const 0)
   )
  )
  (drop
   (i32.eqz
    (i32.const 0)
   )
  )
  (drop
   (i32.eqz
    (i32.const 0)
   )
  )
  (drop
   (i32.eq
    (i32.const 0)
    (i32.const 0)
   )
  )
  (drop
   (i32.eq
    (i32.const 1)
    (i32.const 1)
   )
  )
  (drop
   (i32.eq
    (i32.const 2)
    (i32.const 2)
   )
  )
  (drop
   (i32.eq
    (i32.const 3)
    (i32.const 3)
   )
  )
  (drop
   (i32.eq
    (i32.const 4)
    (i32.const 4)
   )
  )
  (drop
   (i32.const 1)
  )
  (drop
   (i32.const 1)
  )
  (drop
   (i32.const 1)
  )
  (drop
   (i32.const 1)
  )
  (if
   (i32.eqz
    (i32.eq
     (call $builtins/max3
      (i32.const 3)
      (i32.const 2)
      (i32.const 1)
     )
     (i32.const 3)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 96)
     (i32.const 733)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (call $builtins/min3
      (i32.const 1)
      (i32.const 2)
      (i32.const 3)
     )
     (i32.const 1)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 96)
     (i32.const 738)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (call $builtins/rotl3
      (i32.const 3)
      (i32.const 2)
      (i32.const 1)
     )
     (i32.const 48)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 96)
     (i32.const 743)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (call $builtins/rotr3
      (i32.const 48)
      (i32.const 8)
      (i32.const 1)
     )
     (i32.const 3)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 96)
     (i32.const 748)
     (i32.const 1)
    )
    (unreachable)
   )
  )
 )
 (func $builtins/test
  (nop)
 )
 (func $~start
  (call $start:builtins)
 )
)
