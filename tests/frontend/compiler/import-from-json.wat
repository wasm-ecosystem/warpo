(module
 (type $0 (func (param i32) (result i32)))
 (type $1 (func (param i32 i32) (result i32)))
 (type $2 (func))
 (type $3 (func (param i32 i32 i32 i32 i32) (result i32)))
 (type $4 (func (param i32 i32 i32 i32)))
 (type $5 (func (param i32 i32) (result f64)))
 (import "env" "abort" (func $~lib/builtins/abort (param i32 i32 i32 i32)))
 (import "as-builtin-fn" "~lib/rt/__localtostack" (func $~lib/rt/__localtostack (param i32) (result i32)))
 (import "as-builtin-fn" "~lib/rt/__tmptostack" (func $~lib/rt/__tmptostack (param i32) (result i32)))
 (global $import-from-json.json/name (mut i32) (i32.const 32))
 (global $~lib/shared/runtime/Runtime.Stub i32 (i32.const 0))
 (global $~lib/shared/runtime/Runtime.Minimal i32 (i32.const 1))
 (global $~lib/shared/runtime/Runtime.Incremental i32 (i32.const 2))
 (global $~lib/native/ASC_SHRINK_LEVEL i32 (i32.const 0))
 (global $import-from-json.json/version (mut i32) (i32.const 160))
 (global $import-from-json.json/major (mut i32) (i32.const 1))
 (global $import-from-json.json/minor (mut i32) (i32.const 2))
 (global $import-from-json.json/integer_array (mut i32) (i32.const 224))
 (global $import-from-json.json/float_array (mut i32) (i32.const 432))
 (global $import-from-json.json/string_array (mut i32) (i32.const 608))
 (global $import-from-json.json/int (mut i32) (i32.const 1234))
 (global $import-from-json.json/array (mut i32) (i32.const 816))
 (global $~lib/memory/__data_end i32 (i32.const 844))
 (global $~lib/memory/__stack_pointer (mut i32) (i32.const 33612))
 (global $~lib/memory/__heap_base i32 (i32.const 33612))
 (memory $0 1)
 (data $0 (i32.const 12) "<\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00 \00\00\00i\00m\00p\00o\00r\00t\00-\00f\00r\00o\00m\00-\00j\00s\00o\00n\00\00\00\00\00\00\00\00\00\00\00\00\00")
 (data $1 (i32.const 76) "<\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00&\00\00\00i\00m\00p\00o\00r\00t\00-\00f\00r\00o\00m\00-\00j\00s\00o\00n\00.\00t\00s\00\00\00\00\00\00\00")
 (data $2 (i32.const 140) "\1c\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\n\00\00\001\00.\002\00.\004\00\00\00")
 (data $3 (i32.const 172) "\1c\00\00\00\00\00\00\00\00\00\00\00\01\00\00\00\0c\00\00\00\01\00\00\00\02\00\00\00\03\00\00\00")
 (data $4 (i32.const 204) ",\00\00\00\00\00\00\00\00\00\00\00\04\00\00\00\10\00\00\00\c0\00\00\00\c0\00\00\00\0c\00\00\00\03\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00")
 (data $5 (i32.const 252) "<\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00$\00\00\00I\00n\00d\00e\00x\00 \00o\00u\00t\00 \00o\00f\00 \00r\00a\00n\00g\00e\00\00\00\00\00\00\00\00\00")
 (data $6 (i32.const 316) ",\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\1a\00\00\00~\00l\00i\00b\00/\00a\00r\00r\00a\00y\00.\00t\00s\00\00\00")
 (data $7 (i32.const 364) ",\00\00\00\00\00\00\00\00\00\00\00\01\00\00\00\18\00\00\00\00\00\00\00\00\00\f0?\00\00\00\00\00\00\00@\00\00\00\00\00\00\08@\00\00\00\00")
 (data $8 (i32.const 412) ",\00\00\00\00\00\00\00\00\00\00\00\05\00\00\00\10\00\00\00\80\01\00\00\80\01\00\00\18\00\00\00\03\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00")
 (data $9 (i32.const 460) "\1c\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\06\00\00\00o\00n\00e\00\00\00\00\00\00\00")
 (data $10 (i32.const 492) "\1c\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\06\00\00\00t\00w\00o\00\00\00\00\00\00\00")
 (data $11 (i32.const 524) "\1c\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\n\00\00\00t\00h\00r\00e\00e\00\00\00")
 (data $12 (i32.const 556) "\1c\00\00\00\00\00\00\00\00\00\00\00\01\00\00\00\0c\00\00\00\e0\01\00\00\00\02\00\00 \02\00\00")
 (data $13 (i32.const 588) ",\00\00\00\00\00\00\00\00\00\00\00\06\00\00\00\10\00\00\00@\02\00\00@\02\00\00\0c\00\00\00\03\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00")
 (data $14 (i32.const 636) "|\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00^\00\00\00E\00l\00e\00m\00e\00n\00t\00 \00t\00y\00p\00e\00 \00m\00u\00s\00t\00 \00b\00e\00 \00n\00u\00l\00l\00a\00b\00l\00e\00 \00i\00f\00 \00a\00r\00r\00a\00y\00 \00i\00s\00 \00h\00o\00l\00e\00y\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00")
 (data $15 (i32.const 764) "\1c\00\00\00\00\00\00\00\00\00\00\00\01\00\00\00\08\00\00\00\n\00\00\00\0b\00\00\00\00\00\00\00")
 (data $16 (i32.const 796) ",\00\00\00\00\00\00\00\00\00\00\00\04\00\00\00\10\00\00\00\10\03\00\00\10\03\00\00\08\00\00\00\02\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00")
 (table $0 1 1 funcref)
 (elem $0 (i32.const 1))
 (export "memory" (memory $0))
 (start $~start)
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
 (func $~lib/array/Array<i32>#get:length_ (param $this i32) (result i32)
  (i32.load offset=12
   (local.get $this)
  )
 )
 (func $~lib/array/Array<i32>#get:length (param $this i32) (result i32)
  (return
   (call $~lib/array/Array<i32>#get:length_
    (call $~lib/rt/__tmptostack
     (local.get $this)
    )
   )
  )
 )
 (func $~lib/array/Array<i32>#get:dataStart (param $this i32) (result i32)
  (i32.load offset=4
   (local.get $this)
  )
 )
 (func $~lib/array/Array<i32>#__get (param $this i32) (param $index i32) (result i32)
  (local $value i32)
  (if
   (i32.ge_u
    (local.get $index)
    (call $~lib/array/Array<i32>#get:length_
     (call $~lib/rt/__tmptostack
      (local.get $this)
     )
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 272)
     (i32.const 336)
     (i32.const 114)
     (i32.const 42)
    )
    (unreachable)
   )
  )
  (local.set $value
   (i32.load
    (i32.add
     (call $~lib/array/Array<i32>#get:dataStart
      (call $~lib/rt/__tmptostack
       (local.get $this)
      )
     )
     (i32.shl
      (local.get $index)
      (i32.const 2)
     )
    )
   )
  )
  (drop
   (i32.const 0)
  )
  (return
   (local.get $value)
  )
 )
 (func $~lib/array/Array<f64>#get:length_ (param $this i32) (result i32)
  (i32.load offset=12
   (local.get $this)
  )
 )
 (func $~lib/array/Array<f64>#get:length (param $this i32) (result i32)
  (return
   (call $~lib/array/Array<f64>#get:length_
    (call $~lib/rt/__tmptostack
     (local.get $this)
    )
   )
  )
 )
 (func $~lib/array/Array<f64>#get:dataStart (param $this i32) (result i32)
  (i32.load offset=4
   (local.get $this)
  )
 )
 (func $~lib/array/Array<f64>#__get (param $this i32) (param $index i32) (result f64)
  (local $value f64)
  (if
   (i32.ge_u
    (local.get $index)
    (call $~lib/array/Array<f64>#get:length_
     (call $~lib/rt/__tmptostack
      (local.get $this)
     )
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 272)
     (i32.const 336)
     (i32.const 114)
     (i32.const 42)
    )
    (unreachable)
   )
  )
  (local.set $value
   (f64.load
    (i32.add
     (call $~lib/array/Array<f64>#get:dataStart
      (call $~lib/rt/__tmptostack
       (local.get $this)
      )
     )
     (i32.shl
      (local.get $index)
      (i32.const 3)
     )
    )
   )
  )
  (drop
   (i32.const 0)
  )
  (return
   (local.get $value)
  )
 )
 (func $~lib/array/Array<~lib/string/String>#get:length_ (param $this i32) (result i32)
  (i32.load offset=12
   (local.get $this)
  )
 )
 (func $~lib/array/Array<~lib/string/String>#get:length (param $this i32) (result i32)
  (return
   (call $~lib/array/Array<~lib/string/String>#get:length_
    (call $~lib/rt/__tmptostack
     (local.get $this)
    )
   )
  )
 )
 (func $~lib/array/Array<~lib/string/String>#get:dataStart (param $this i32) (result i32)
  (i32.load offset=4
   (local.get $this)
  )
 )
 (func $~lib/array/Array<~lib/string/String>#__get (param $this i32) (param $index i32) (result i32)
  (local $value i32)
  (if
   (i32.ge_u
    (local.get $index)
    (call $~lib/array/Array<~lib/string/String>#get:length_
     (call $~lib/rt/__tmptostack
      (local.get $this)
     )
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 272)
     (i32.const 336)
     (i32.const 114)
     (i32.const 42)
    )
    (unreachable)
   )
  )
  (local.set $value
   (call $~lib/rt/__localtostack
    (i32.load
     (i32.add
      (call $~lib/array/Array<~lib/string/String>#get:dataStart
       (call $~lib/rt/__tmptostack
        (local.get $this)
       )
      )
      (i32.shl
       (local.get $index)
       (i32.const 2)
      )
     )
    )
   )
  )
  (drop
   (i32.const 1)
  )
  (block
   (drop
    (i32.eqz
     (i32.const 0)
    )
   )
   (if
    (i32.eqz
     (local.get $value)
    )
    (then
     (call $~lib/builtins/abort
      (i32.const 656)
      (i32.const 336)
      (i32.const 118)
      (i32.const 40)
     )
     (unreachable)
    )
   )
  )
  (return
   (local.get $value)
  )
 )
 (func $start:import-from-json
  (if
   (i32.eqz
    (call $~lib/string/String.__eq
     (call $~lib/rt/__tmptostack
      (global.get $import-from-json.json/name)
     )
     (i32.const 32)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 96)
     (i32.const 12)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (call $~lib/string/String.__eq
     (call $~lib/rt/__tmptostack
      (global.get $import-from-json.json/version)
     )
     (i32.const 160)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 96)
     (i32.const 13)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (global.get $import-from-json.json/major)
     (i32.const 1)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 96)
     (i32.const 14)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (global.get $import-from-json.json/minor)
     (i32.const 2)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 96)
     (i32.const 15)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (call $~lib/array/Array<i32>#get:length
      (call $~lib/rt/__tmptostack
       (global.get $import-from-json.json/integer_array)
      )
     )
     (i32.const 3)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 96)
     (i32.const 17)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (call $~lib/array/Array<i32>#__get
      (call $~lib/rt/__tmptostack
       (global.get $import-from-json.json/integer_array)
      )
      (i32.const 0)
     )
     (i32.const 1)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 96)
     (i32.const 18)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (call $~lib/array/Array<i32>#__get
      (call $~lib/rt/__tmptostack
       (global.get $import-from-json.json/integer_array)
      )
      (i32.const 1)
     )
     (i32.const 2)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 96)
     (i32.const 19)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (call $~lib/array/Array<i32>#__get
      (call $~lib/rt/__tmptostack
       (global.get $import-from-json.json/integer_array)
      )
      (i32.const 2)
     )
     (i32.const 3)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 96)
     (i32.const 20)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (call $~lib/array/Array<f64>#get:length
      (call $~lib/rt/__tmptostack
       (global.get $import-from-json.json/float_array)
      )
     )
     (i32.const 3)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 96)
     (i32.const 22)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (f64.eq
     (call $~lib/array/Array<f64>#__get
      (call $~lib/rt/__tmptostack
       (global.get $import-from-json.json/float_array)
      )
      (i32.const 0)
     )
     (f64.const 1)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 96)
     (i32.const 23)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (f64.eq
     (call $~lib/array/Array<f64>#__get
      (call $~lib/rt/__tmptostack
       (global.get $import-from-json.json/float_array)
      )
      (i32.const 1)
     )
     (f64.const 2)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 96)
     (i32.const 24)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (f64.eq
     (call $~lib/array/Array<f64>#__get
      (call $~lib/rt/__tmptostack
       (global.get $import-from-json.json/float_array)
      )
      (i32.const 2)
     )
     (f64.const 3)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 96)
     (i32.const 25)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (call $~lib/array/Array<~lib/string/String>#get:length
      (call $~lib/rt/__tmptostack
       (global.get $import-from-json.json/string_array)
      )
     )
     (i32.const 3)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 96)
     (i32.const 27)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (call $~lib/string/String.__eq
     (call $~lib/rt/__tmptostack
      (call $~lib/array/Array<~lib/string/String>#__get
       (call $~lib/rt/__tmptostack
        (global.get $import-from-json.json/string_array)
       )
       (i32.const 0)
      )
     )
     (i32.const 480)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 96)
     (i32.const 28)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (call $~lib/string/String.__eq
     (call $~lib/rt/__tmptostack
      (call $~lib/array/Array<~lib/string/String>#__get
       (call $~lib/rt/__tmptostack
        (global.get $import-from-json.json/string_array)
       )
       (i32.const 1)
      )
     )
     (i32.const 512)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 96)
     (i32.const 29)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (call $~lib/string/String.__eq
     (call $~lib/rt/__tmptostack
      (call $~lib/array/Array<~lib/string/String>#__get
       (call $~lib/rt/__tmptostack
        (global.get $import-from-json.json/string_array)
       )
       (i32.const 2)
      )
     )
     (i32.const 544)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 96)
     (i32.const 30)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (global.get $import-from-json.json/int)
     (i32.const 1234)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 96)
     (i32.const 32)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (call $~lib/array/Array<i32>#get:length
      (call $~lib/rt/__tmptostack
       (global.get $import-from-json.json/array)
      )
     )
     (i32.const 2)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 96)
     (i32.const 33)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (call $~lib/array/Array<i32>#__get
      (call $~lib/rt/__tmptostack
       (global.get $import-from-json.json/array)
      )
      (i32.const 0)
     )
     (i32.const 10)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 96)
     (i32.const 34)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (call $~lib/array/Array<i32>#__get
      (call $~lib/rt/__tmptostack
       (global.get $import-from-json.json/array)
      )
      (i32.const 1)
     )
     (i32.const 11)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 96)
     (i32.const 35)
     (i32.const 1)
    )
    (unreachable)
   )
  )
 )
 (func $~start
  (call $start:import-from-json)
 )
)
