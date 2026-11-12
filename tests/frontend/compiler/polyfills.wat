(module
 (type $0 (func (param i32) (result i32)))
 (type $1 (func (param i64) (result i64)))
 (type $2 (func))
 (type $3 (func (param i32 i32 i32 i32)))
 (type $4 (func (param i32 i32 i32)))
 (import "env" "abort" (func $~lib/builtins/abort (param i32 i32 i32 i32)))
 (import "as-builtin-fn" "~lib/rt/__localtostack" (func $~lib/rt/__localtostack (param i32) (result i32)))
 (import "as-builtin-fn" "~lib/rt/__tmptostack" (func $~lib/rt/__tmptostack (param i32) (result i32)))
 (global $~lib/memory/__data_end i32 (i32.const 60))
 (global $~lib/memory/__stack_pointer (mut i32) (i32.const 32828))
 (global $~lib/memory/__heap_base i32 (i32.const 32828))
 (memory $0 1)
 (data $0 (i32.const 12) ",\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\18\00\00\00p\00o\00l\00y\00f\00i\00l\00l\00s\00.\00t\00s\00\00\00\00\00")
 (table $0 1 1 funcref)
 (elem $0 (i32.const 1))
 (export "memory" (memory $0))
 (start $~start)
 (func $~lib/polyfills/bswap<u8> (param $value i32) (result i32)
  (drop
   (i32.const 1)
  )
  (block
   (drop
    (i32.eq
     (i32.const 1)
     (i32.const 1)
    )
   )
   (return
    (local.get $value)
   )
  )
 )
 (func $~lib/polyfills/bswap<i8> (param $value i32) (result i32)
  (drop
   (i32.const 1)
  )
  (block
   (drop
    (i32.eq
     (i32.const 1)
     (i32.const 1)
    )
   )
   (return
    (local.get $value)
   )
  )
 )
 (func $~lib/polyfills/bswap<u16> (param $value i32) (result i32)
  (drop
   (i32.const 1)
  )
  (block
   (drop
    (i32.eq
     (i32.const 2)
     (i32.const 1)
    )
   )
   (drop
    (i32.eq
     (i32.const 2)
     (i32.const 2)
    )
   )
   (return
    (i32.or
     (i32.shl
      (local.get $value)
      (i32.and
       (i32.const 8)
       (i32.const 15)
      )
     )
     (i32.shr_u
      (i32.and
       (local.get $value)
       (i32.const 65535)
      )
      (i32.and
       (i32.const 8)
       (i32.const 15)
      )
     )
    )
   )
  )
 )
 (func $~lib/polyfills/bswap<i16> (param $value i32) (result i32)
  (drop
   (i32.const 1)
  )
  (block
   (drop
    (i32.eq
     (i32.const 2)
     (i32.const 1)
    )
   )
   (drop
    (i32.eq
     (i32.const 2)
     (i32.const 2)
    )
   )
   (return
    (i32.or
     (i32.shl
      (local.get $value)
      (i32.and
       (i32.const 8)
       (i32.const 15)
      )
     )
     (i32.shr_u
      (i32.and
       (local.get $value)
       (i32.const 65535)
      )
      (i32.and
       (i32.const 8)
       (i32.const 15)
      )
     )
    )
   )
  )
 )
 (func $~lib/polyfills/bswap<u32> (param $value i32) (result i32)
  (drop
   (i32.const 1)
  )
  (block
   (drop
    (i32.eq
     (i32.const 4)
     (i32.const 1)
    )
   )
   (drop
    (i32.eq
     (i32.const 4)
     (i32.const 2)
    )
   )
   (drop
    (i32.eq
     (i32.const 4)
     (i32.const 4)
    )
   )
   (return
    (i32.or
     (i32.rotl
      (i32.and
       (local.get $value)
       (i32.const -16711936)
      )
      (i32.const 8)
     )
     (i32.rotr
      (i32.and
       (local.get $value)
       (i32.const 16711935)
      )
      (i32.const 8)
     )
    )
   )
  )
 )
 (func $~lib/polyfills/bswap<i32> (param $value i32) (result i32)
  (drop
   (i32.const 1)
  )
  (block
   (drop
    (i32.eq
     (i32.const 4)
     (i32.const 1)
    )
   )
   (drop
    (i32.eq
     (i32.const 4)
     (i32.const 2)
    )
   )
   (drop
    (i32.eq
     (i32.const 4)
     (i32.const 4)
    )
   )
   (return
    (i32.or
     (i32.rotl
      (i32.and
       (local.get $value)
       (i32.const -16711936)
      )
      (i32.const 8)
     )
     (i32.rotr
      (i32.and
       (local.get $value)
       (i32.const 16711935)
      )
      (i32.const 8)
     )
    )
   )
  )
 )
 (func $~lib/polyfills/bswap<u64> (param $value i64) (result i64)
  (local $a i64)
  (local $b i64)
  (local $v i64)
  (drop
   (i32.const 1)
  )
  (block
   (drop
    (i32.eq
     (i32.const 8)
     (i32.const 1)
    )
   )
   (drop
    (i32.eq
     (i32.const 8)
     (i32.const 2)
    )
   )
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
   (block
    (local.set $a
     (i64.and
      (i64.shr_u
       (local.get $value)
       (i64.const 8)
      )
      (i64.const 71777214294589695)
     )
    )
    (local.set $b
     (i64.shl
      (i64.and
       (local.get $value)
       (i64.const 71777214294589695)
      )
      (i64.const 8)
     )
    )
    (local.set $v
     (i64.or
      (local.get $a)
      (local.get $b)
     )
    )
    (local.set $a
     (i64.and
      (i64.shr_u
       (local.get $v)
       (i64.const 16)
      )
      (i64.const 281470681808895)
     )
    )
    (local.set $b
     (i64.shl
      (i64.and
       (local.get $v)
       (i64.const 281470681808895)
      )
      (i64.const 16)
     )
    )
    (return
     (i64.rotr
      (i64.or
       (local.get $a)
       (local.get $b)
      )
      (i64.const 32)
     )
    )
   )
  )
 )
 (func $~lib/polyfills/bswap<i64> (param $value i64) (result i64)
  (local $a i64)
  (local $b i64)
  (local $v i64)
  (drop
   (i32.const 1)
  )
  (block
   (drop
    (i32.eq
     (i32.const 8)
     (i32.const 1)
    )
   )
   (drop
    (i32.eq
     (i32.const 8)
     (i32.const 2)
    )
   )
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
   (block
    (local.set $a
     (i64.and
      (i64.shr_u
       (local.get $value)
       (i64.const 8)
      )
      (i64.const 71777214294589695)
     )
    )
    (local.set $b
     (i64.shl
      (i64.and
       (local.get $value)
       (i64.const 71777214294589695)
      )
      (i64.const 8)
     )
    )
    (local.set $v
     (i64.or
      (local.get $a)
      (local.get $b)
     )
    )
    (local.set $a
     (i64.and
      (i64.shr_u
       (local.get $v)
       (i64.const 16)
      )
      (i64.const 281470681808895)
     )
    )
    (local.set $b
     (i64.shl
      (i64.and
       (local.get $v)
       (i64.const 281470681808895)
      )
      (i64.const 16)
     )
    )
    (return
     (i64.rotr
      (i64.or
       (local.get $a)
       (local.get $b)
      )
      (i64.const 32)
     )
    )
   )
  )
 )
 (func $~lib/polyfills/bswap<usize> (param $value i32) (result i32)
  (drop
   (i32.const 1)
  )
  (block
   (drop
    (i32.eq
     (i32.const 4)
     (i32.const 1)
    )
   )
   (drop
    (i32.eq
     (i32.const 4)
     (i32.const 2)
    )
   )
   (drop
    (i32.eq
     (i32.const 4)
     (i32.const 4)
    )
   )
   (return
    (i32.or
     (i32.rotl
      (i32.and
       (local.get $value)
       (i32.const -16711936)
      )
      (i32.const 8)
     )
     (i32.rotr
      (i32.and
       (local.get $value)
       (i32.const 16711935)
      )
      (i32.const 8)
     )
    )
   )
  )
 )
 (func $~lib/polyfills/bswap<isize> (param $value i32) (result i32)
  (drop
   (i32.const 1)
  )
  (block
   (drop
    (i32.eq
     (i32.const 4)
     (i32.const 1)
    )
   )
   (drop
    (i32.eq
     (i32.const 4)
     (i32.const 2)
    )
   )
   (drop
    (i32.eq
     (i32.const 4)
     (i32.const 4)
    )
   )
   (return
    (i32.or
     (i32.rotl
      (i32.and
       (local.get $value)
       (i32.const -16711936)
      )
      (i32.const 8)
     )
     (i32.rotr
      (i32.and
       (local.get $value)
       (i32.const 16711935)
      )
      (i32.const 8)
     )
    )
   )
  )
 )
 (func $start:polyfills
  (if
   (i32.eqz
    (i32.eq
     (i32.and
      (call $~lib/polyfills/bswap<u8>
       (i32.const 170)
      )
      (i32.const 255)
     )
     (i32.const 170)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 2)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (i32.extend8_s
      (call $~lib/polyfills/bswap<i8>
       (i32.const 170)
      )
     )
     (i32.extend8_s
      (i32.const 170)
     )
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 3)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (i32.and
      (call $~lib/polyfills/bswap<u16>
       (i32.const 43707)
      )
      (i32.const 65535)
     )
     (i32.const 48042)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 6)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (i32.extend16_s
      (call $~lib/polyfills/bswap<i16>
       (i32.const 43707)
      )
     )
     (i32.extend16_s
      (i32.const 48042)
     )
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 7)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (i32.extend16_s
      (call $~lib/polyfills/bswap<i16>
       (i32.const 43707)
      )
     )
     (i32.extend16_s
      (i32.const 48042)
     )
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 8)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (call $~lib/polyfills/bswap<u32>
      (i32.const -1430532899)
     )
     (i32.const -573785174)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 11)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (call $~lib/polyfills/bswap<i32>
      (i32.const -1430532899)
     )
     (i32.const -573785174)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 12)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (call $~lib/polyfills/bswap<i32>
      (i32.const -1430532899)
     )
     (i32.const -573785174)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 13)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (i64.eq
     (call $~lib/polyfills/bswap<u64>
      (i64.const 4822679907192029)
     )
     (i64.const -2464388556401798912)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 16)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (i64.eq
     (call $~lib/polyfills/bswap<i64>
      (i64.const 4822679907192029)
     )
     (i64.const -2464388556401798912)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 17)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (i64.eq
     (call $~lib/polyfills/bswap<i64>
      (i64.const 4822679907192029)
     )
     (i64.const -2464388556401798912)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 18)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (call $~lib/polyfills/bswap<usize>
      (i32.const -1430532899)
     )
     (i32.const -573785174)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 21)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (call $~lib/polyfills/bswap<isize>
      (i32.const -1430532899)
     )
     (i32.const -573785174)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 22)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (call $~lib/polyfills/bswap<isize>
      (i32.const -1430532899)
     )
     (i32.const -573785174)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 23)
     (i32.const 1)
    )
    (unreachable)
   )
  )
 )
 (func $~lib/memory/memory.fill (param $0 i32) (param $1 i32) (param $2 i32)
  (memory.fill
   (local.get $0)
   (local.get $1)
   (local.get $2)
  )
 )
 (func $~start
  (call $start:polyfills)
 )
)
