(module
 (type $0 (func (param i32) (result i32)))
 (type $1 (func (param i32 i32) (result i32)))
 (type $2 (func))
 (type $3 (func (param f32) (result i32)))
 (type $4 (func (param i64) (result i32)))
 (type $5 (func (param f64) (result i32)))
 (import "as-builtin-fn" "~lib/rt/__localtostack" (func $~lib/rt/__localtostack (param i32) (result i32)))
 (import "as-builtin-fn" "~lib/rt/__tmptostack" (func $~lib/rt/__tmptostack (param i32) (result i32)))
 (global $~lib/shared/runtime/Runtime.Stub i32 (i32.const 0))
 (global $~lib/shared/runtime/Runtime.Radical i32 (i32.const 1))
 (global $~lib/shared/runtime/Runtime.Incremental i32 (i32.const 2))
 (global $~lib/memory/__data_end i32 (i32.const 380))
 (global $~lib/memory/__stack_pointer (mut i32) (i32.const 33148))
 (global $~lib/memory/__heap_base i32 (i32.const 33148))
 (memory $0 1)
 (data $0 (i32.const 12) "\1c\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00")
 (data $1 (i32.const 44) "\1c\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\02\00\00\00a\00\00\00\00\00\00\00\00\00\00\00")
 (data $2 (i32.const 76) "\1c\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\04\00\00\00a\00b\00\00\00\00\00\00\00\00\00")
 (data $3 (i32.const 108) "\1c\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\06\00\00\00a\00b\00c\00\00\00\00\00\00\00")
 (data $4 (i32.const 140) "\1c\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\08\00\00\00a\00b\00c\00d\00\00\00\00\00")
 (data $5 (i32.const 172) "\1c\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\n\00\00\00a\00b\00c\00d\00e\00\00\00")
 (data $6 (i32.const 204) "\1c\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\0c\00\00\00a\00b\00c\00d\00e\00f\00")
 (data $7 (i32.const 236) ",\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\0e\00\00\00a\00b\00c\00d\00e\00f\00g\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00")
 (data $8 (i32.const 284) ",\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\10\00\00\00a\00b\00c\00d\00e\00f\00g\00h\00\00\00\00\00\00\00\00\00\00\00\00\00")
 (data $9 (i32.const 332) ",\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\12\00\00\00a\00b\00c\00d\00e\00f\00g\00h\00i\00\00\00\00\00\00\00\00\00\00\00")
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
 (func $~lib/util/hash/mix (param $h i32) (param $key i32) (result i32)
  (return
   (i32.mul
    (i32.rotl
     (i32.add
      (local.get $h)
      (i32.mul
       (local.get $key)
       (i32.const -2048144777)
      )
     )
     (i32.const 13)
    )
    (i32.const -1640531535)
   )
  )
 )
 (func $~lib/util/hash/hashStr (param $key i32) (result i32)
  (local $h i32)
  (local $len i32)
  (local $pos i32)
  (local $s1 i32)
  (local $s2 i32)
  (local $s3 i32)
  (local $s4 i32)
  (local $end i32)
  (local $end|9 i32)
  (if
   (i32.eq
    (local.get $key)
    (i32.const 0)
   )
   (then
    (return
     (i32.const 0)
    )
   )
  )
  (local.set $h
   (i32.shl
    (call $~lib/string/String#get:length
     (call $~lib/rt/__tmptostack
      (local.get $key)
     )
    )
    (i32.const 1)
   )
  )
  (local.set $len
   (local.get $h)
  )
  (local.set $pos
   (local.get $key)
  )
  (if
   (i32.ge_u
    (local.get $len)
    (i32.const 16)
   )
   (then
    (local.set $s1
     (i32.add
      (i32.add
       (i32.const 0)
       (i32.const -1640531535)
      )
      (i32.const -2048144777)
     )
    )
    (local.set $s2
     (i32.add
      (i32.const 0)
      (i32.const -2048144777)
     )
    )
    (local.set $s3
     (i32.const 0)
    )
    (local.set $s4
     (i32.sub
      (i32.const 0)
      (i32.const -1640531535)
     )
    )
    (local.set $end
     (i32.sub
      (i32.add
       (local.get $len)
       (local.get $pos)
      )
      (i32.const 16)
     )
    )
    (block $while-break|0
     (loop $while-continue|0
      (if
       (i32.le_u
        (local.get $pos)
        (local.get $end)
       )
       (then
        (local.set $s1
         (call $~lib/util/hash/mix
          (local.get $s1)
          (i32.load
           (local.get $pos)
          )
         )
        )
        (local.set $s2
         (call $~lib/util/hash/mix
          (local.get $s2)
          (i32.load offset=4
           (local.get $pos)
          )
         )
        )
        (local.set $s3
         (call $~lib/util/hash/mix
          (local.get $s3)
          (i32.load offset=8
           (local.get $pos)
          )
         )
        )
        (local.set $s4
         (call $~lib/util/hash/mix
          (local.get $s4)
          (i32.load offset=12
           (local.get $pos)
          )
         )
        )
        (local.set $pos
         (i32.add
          (local.get $pos)
          (i32.const 16)
         )
        )
        (br $while-continue|0)
       )
      )
     )
    )
    (local.set $h
     (i32.add
      (local.get $h)
      (i32.add
       (i32.add
        (i32.add
         (i32.rotl
          (local.get $s1)
          (i32.const 1)
         )
         (i32.rotl
          (local.get $s2)
          (i32.const 7)
         )
        )
        (i32.rotl
         (local.get $s3)
         (i32.const 12)
        )
       )
       (i32.rotl
        (local.get $s4)
        (i32.const 18)
       )
      )
     )
    )
   )
   (else
    (local.set $h
     (i32.add
      (local.get $h)
      (i32.add
       (i32.const 0)
       (i32.const 374761393)
      )
     )
    )
   )
  )
  (local.set $end|9
   (i32.sub
    (i32.add
     (local.get $key)
     (local.get $len)
    )
    (i32.const 4)
   )
  )
  (block $while-break|1
   (loop $while-continue|1
    (if
     (i32.le_u
      (local.get $pos)
      (local.get $end|9)
     )
     (then
      (local.set $h
       (i32.add
        (local.get $h)
        (i32.mul
         (i32.load
          (local.get $pos)
         )
         (i32.const -1028477379)
        )
       )
      )
      (local.set $h
       (i32.mul
        (i32.rotl
         (local.get $h)
         (i32.const 17)
        )
        (i32.const 668265263)
       )
      )
      (local.set $pos
       (i32.add
        (local.get $pos)
        (i32.const 4)
       )
      )
      (br $while-continue|1)
     )
    )
   )
  )
  (local.set $end|9
   (i32.add
    (local.get $key)
    (local.get $len)
   )
  )
  (block $while-break|2
   (loop $while-continue|2
    (if
     (i32.lt_u
      (local.get $pos)
      (local.get $end|9)
     )
     (then
      (local.set $h
       (i32.add
        (local.get $h)
        (i32.mul
         (i32.load8_u
          (local.get $pos)
         )
         (i32.const 374761393)
        )
       )
      )
      (local.set $h
       (i32.mul
        (i32.rotl
         (local.get $h)
         (i32.const 11)
        )
        (i32.const -1640531535)
       )
      )
      (local.set $pos
       (i32.add
        (local.get $pos)
        (i32.const 1)
       )
      )
      (br $while-continue|2)
     )
    )
   )
  )
  (local.set $h
   (i32.xor
    (local.get $h)
    (i32.shr_u
     (local.get $h)
     (i32.const 15)
    )
   )
  )
  (local.set $h
   (i32.mul
    (local.get $h)
    (i32.const -2048144777)
   )
  )
  (local.set $h
   (i32.xor
    (local.get $h)
    (i32.shr_u
     (local.get $h)
     (i32.const 13)
    )
   )
  )
  (local.set $h
   (i32.mul
    (local.get $h)
    (i32.const -1028477379)
   )
  )
  (local.set $h
   (i32.xor
    (local.get $h)
    (i32.shr_u
     (local.get $h)
     (i32.const 16)
    )
   )
  )
  (return
   (local.get $h)
  )
 )
 (func $~lib/util/hash/HASH<~lib/string/String|null> (param $key i32) (result i32)
  (drop
   (i32.const 1)
  )
  (return
   (call $~lib/util/hash/hashStr
    (call $~lib/rt/__tmptostack
     (local.get $key)
    )
   )
  )
 )
 (func $std/hash/check (param $hash i32) (result i32)
  (return
   (i32.const 1)
  )
 )
 (func $~lib/util/hash/HASH<~lib/string/String> (param $key i32) (result i32)
  (drop
   (i32.const 1)
  )
  (return
   (call $~lib/util/hash/hashStr
    (call $~lib/rt/__tmptostack
     (local.get $key)
    )
   )
  )
 )
 (func $~lib/util/hash/hash32 (param $key i32) (param $len i32) (result i32)
  (local $h i32)
  (local.set $h
   (i32.add
    (i32.add
     (i32.const 0)
     (i32.const 374761393)
    )
    (local.get $len)
   )
  )
  (local.set $h
   (i32.add
    (local.get $h)
    (i32.mul
     (local.get $key)
     (i32.const -1028477379)
    )
   )
  )
  (local.set $h
   (i32.mul
    (i32.rotl
     (local.get $h)
     (i32.const 17)
    )
    (i32.const 668265263)
   )
  )
  (local.set $h
   (i32.xor
    (local.get $h)
    (i32.shr_u
     (local.get $h)
     (i32.const 15)
    )
   )
  )
  (local.set $h
   (i32.mul
    (local.get $h)
    (i32.const -2048144777)
   )
  )
  (local.set $h
   (i32.xor
    (local.get $h)
    (i32.shr_u
     (local.get $h)
     (i32.const 13)
    )
   )
  )
  (local.set $h
   (i32.mul
    (local.get $h)
    (i32.const -1028477379)
   )
  )
  (local.set $h
   (i32.xor
    (local.get $h)
    (i32.shr_u
     (local.get $h)
     (i32.const 16)
    )
   )
  )
  (return
   (local.get $h)
  )
 )
 (func $~lib/util/hash/HASH<f32> (param $key f32) (result i32)
  (drop
   (i32.const 0)
  )
  (block
   (drop
    (i32.const 0)
   )
   (block
    (drop
     (i32.const 1)
    )
    (block
     (drop
      (i32.eq
       (i32.const 4)
       (i32.const 4)
      )
     )
     (return
      (call $~lib/util/hash/hash32
       (i32.reinterpret_f32
        (local.get $key)
       )
       (i32.const 4)
      )
     )
    )
   )
  )
 )
 (func $~lib/util/hash/hash64 (param $key i64) (result i32)
  (local $h i32)
  (local.set $h
   (i32.add
    (i32.add
     (i32.const 0)
     (i32.const 374761393)
    )
    (i32.const 8)
   )
  )
  (local.set $h
   (i32.add
    (local.get $h)
    (i32.mul
     (i32.wrap_i64
      (local.get $key)
     )
     (i32.const -1028477379)
    )
   )
  )
  (local.set $h
   (i32.mul
    (i32.rotl
     (local.get $h)
     (i32.const 17)
    )
    (i32.const 668265263)
   )
  )
  (local.set $h
   (i32.add
    (local.get $h)
    (i32.mul
     (i32.wrap_i64
      (i64.shr_u
       (local.get $key)
       (i64.const 32)
      )
     )
     (i32.const -1028477379)
    )
   )
  )
  (local.set $h
   (i32.mul
    (i32.rotl
     (local.get $h)
     (i32.const 17)
    )
    (i32.const 668265263)
   )
  )
  (local.set $h
   (i32.xor
    (local.get $h)
    (i32.shr_u
     (local.get $h)
     (i32.const 15)
    )
   )
  )
  (local.set $h
   (i32.mul
    (local.get $h)
    (i32.const -2048144777)
   )
  )
  (local.set $h
   (i32.xor
    (local.get $h)
    (i32.shr_u
     (local.get $h)
     (i32.const 13)
    )
   )
  )
  (local.set $h
   (i32.mul
    (local.get $h)
    (i32.const -1028477379)
   )
  )
  (local.set $h
   (i32.xor
    (local.get $h)
    (i32.shr_u
     (local.get $h)
     (i32.const 16)
    )
   )
  )
  (return
   (local.get $h)
  )
 )
 (func $~lib/util/hash/HASH<f64> (param $key f64) (result i32)
  (drop
   (i32.const 0)
  )
  (block
   (drop
    (i32.const 0)
   )
   (block
    (drop
     (i32.const 1)
    )
    (block
     (drop
      (i32.eq
       (i32.const 8)
       (i32.const 4)
      )
     )
     (drop
      (i32.eq
       (i32.const 8)
       (i32.const 8)
      )
     )
     (return
      (call $~lib/util/hash/hash64
       (i64.reinterpret_f64
        (local.get $key)
       )
      )
     )
    )
   )
  )
 )
 (func $start:std/hash
  (drop
   (call $std/hash/check
    (call $~lib/util/hash/HASH<~lib/string/String|null>
     (i32.const 0)
    )
   )
  )
  (drop
   (call $std/hash/check
    (call $~lib/util/hash/HASH<~lib/string/String>
     (i32.const 32)
    )
   )
  )
  (drop
   (call $std/hash/check
    (call $~lib/util/hash/HASH<~lib/string/String>
     (i32.const 64)
    )
   )
  )
  (drop
   (call $std/hash/check
    (call $~lib/util/hash/HASH<~lib/string/String>
     (i32.const 96)
    )
   )
  )
  (drop
   (call $std/hash/check
    (call $~lib/util/hash/HASH<~lib/string/String>
     (i32.const 128)
    )
   )
  )
  (drop
   (call $std/hash/check
    (call $~lib/util/hash/HASH<~lib/string/String>
     (i32.const 160)
    )
   )
  )
  (drop
   (call $std/hash/check
    (call $~lib/util/hash/HASH<~lib/string/String>
     (i32.const 192)
    )
   )
  )
  (drop
   (call $std/hash/check
    (call $~lib/util/hash/HASH<~lib/string/String>
     (i32.const 224)
    )
   )
  )
  (drop
   (call $std/hash/check
    (call $~lib/util/hash/HASH<~lib/string/String>
     (i32.const 256)
    )
   )
  )
  (drop
   (call $std/hash/check
    (call $~lib/util/hash/HASH<~lib/string/String>
     (i32.const 304)
    )
   )
  )
  (drop
   (call $std/hash/check
    (call $~lib/util/hash/HASH<~lib/string/String>
     (i32.const 352)
    )
   )
  )
  (drop
   (call $std/hash/check
    (call $~lib/util/hash/HASH<f32>
     (f32.const 0)
    )
   )
  )
  (drop
   (call $std/hash/check
    (call $~lib/util/hash/HASH<f32>
     (f32.const 1)
    )
   )
  )
  (drop
   (call $std/hash/check
    (call $~lib/util/hash/HASH<f32>
     (f32.const 1.100000023841858)
    )
   )
  )
  (drop
   (call $std/hash/check
    (call $~lib/util/hash/HASH<f32>
     (f32.const -0)
    )
   )
  )
  (drop
   (call $std/hash/check
    (call $~lib/util/hash/HASH<f32>
     (f32.const inf)
    )
   )
  )
  (drop
   (call $std/hash/check
    (call $~lib/util/hash/HASH<f32>
     (f32.const nan:0x400000)
    )
   )
  )
  (drop
   (call $std/hash/check
    (call $~lib/util/hash/HASH<f64>
     (f64.const 0)
    )
   )
  )
  (drop
   (call $std/hash/check
    (call $~lib/util/hash/HASH<f64>
     (f64.const 1)
    )
   )
  )
  (drop
   (call $std/hash/check
    (call $~lib/util/hash/HASH<f64>
     (f64.const 1.1)
    )
   )
  )
  (drop
   (call $std/hash/check
    (call $~lib/util/hash/HASH<f64>
     (f64.const -0)
    )
   )
  )
  (drop
   (call $std/hash/check
    (call $~lib/util/hash/HASH<f64>
     (f64.const inf)
    )
   )
  )
  (drop
   (call $std/hash/check
    (call $~lib/util/hash/HASH<f64>
     (f64.const nan:0x8000000000000)
    )
   )
  )
 )
 (func $~start
  (call $start:std/hash)
 )
)
