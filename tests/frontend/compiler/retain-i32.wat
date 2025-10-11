(module
 (type $0 (func))
 (type $1 (func (param i32) (result i32)))
 (type $2 (func (param i32 i32 i32 i32)))
 (type $3 (func (param i32 i32)))
 (import "env" "abort" (func $~lib/builtins/abort (param i32 i32 i32 i32)))
 (import "as-builtin-fn" "~lib/rt/__localtostack" (func $~lib/rt/__localtostack (param i32) (result i32)))
 (import "as-builtin-fn" "~lib/rt/__tmptostack" (func $~lib/rt/__tmptostack (param i32) (result i32)))
 (global $~lib/builtins/i8.MAX_VALUE i32 (i32.const 127))
 (global $~lib/builtins/i8.MIN_VALUE i32 (i32.const -128))
 (global $~lib/builtins/u8.MAX_VALUE i32 (i32.const 255))
 (global $~lib/builtins/i16.MIN_VALUE i32 (i32.const -32768))
 (global $~lib/builtins/i16.MAX_VALUE i32 (i32.const 32767))
 (global $~lib/builtins/u16.MAX_VALUE i32 (i32.const 65535))
 (global $~lib/builtins/i32.MAX_VALUE i32 (i32.const 2147483647))
 (global $~lib/builtins/i32.MIN_VALUE i32 (i32.const -2147483648))
 (global $~lib/builtins/u32.MAX_VALUE i32 (i32.const -1))
 (global $retain-i32/si (mut i32) (i32.const 0))
 (global $retain-i32/ui (mut i32) (i32.const 0))
 (global $retain-i32/ri (mut i32) (i32.const 0))
 (global $~lib/memory/__data_end i32 (i32.const 60))
 (global $~lib/memory/__stack_pointer (mut i32) (i32.const 32828))
 (global $~lib/memory/__heap_base i32 (i32.const 32828))
 (memory $0 1)
 (data $0 (i32.const 12) ",\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\1a\00\00\00r\00e\00t\00a\00i\00n\00-\00i\003\002\00.\00t\00s\00\00\00")
 (table $0 1 1 funcref)
 (elem $0 (i32.const 1))
 (export "memory" (memory $0))
 (start $~start)
 (func $retain-i32/test (param $a i32) (param $b i32)
  (if
   (i32.eqz
    (i32.eq
     (i32.extend8_s
      (i32.add
       (local.get $a)
       (local.get $b)
      )
     )
     (i32.extend8_s
      (i32.add
       (local.get $a)
       (local.get $b)
      )
     )
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 3)
     (i32.const 3)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (i32.extend8_s
      (i32.sub
       (local.get $a)
       (local.get $b)
      )
     )
     (i32.extend8_s
      (i32.sub
       (local.get $a)
       (local.get $b)
      )
     )
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 4)
     (i32.const 3)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (i32.extend8_s
      (i32.mul
       (local.get $a)
       (local.get $b)
      )
     )
     (i32.extend8_s
      (i32.mul
       (local.get $a)
       (local.get $b)
      )
     )
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 5)
     (i32.const 3)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (i32.extend8_s
      (i32.and
       (local.get $a)
       (local.get $b)
      )
     )
     (i32.extend8_s
      (i32.and
       (local.get $a)
       (local.get $b)
      )
     )
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 6)
     (i32.const 3)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (i32.extend8_s
      (i32.or
       (local.get $a)
       (local.get $b)
      )
     )
     (i32.extend8_s
      (i32.or
       (local.get $a)
       (local.get $b)
      )
     )
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 7)
     (i32.const 3)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (i32.extend8_s
      (i32.xor
       (local.get $a)
       (local.get $b)
      )
     )
     (i32.extend8_s
      (i32.xor
       (local.get $a)
       (local.get $b)
      )
     )
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 8)
     (i32.const 3)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (i32.extend8_s
      (i32.shl
       (local.get $a)
       (i32.and
        (local.get $b)
        (i32.const 7)
       )
      )
     )
     (i32.extend8_s
      (i32.shl
       (local.get $a)
       (i32.and
        (local.get $b)
        (i32.const 7)
       )
      )
     )
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 9)
     (i32.const 3)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (i32.and
      (i32.add
       (local.get $a)
       (local.get $b)
      )
      (i32.const 255)
     )
     (i32.and
      (i32.add
       (local.get $a)
       (local.get $b)
      )
      (i32.const 255)
     )
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 12)
     (i32.const 3)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (i32.and
      (i32.sub
       (local.get $a)
       (local.get $b)
      )
      (i32.const 255)
     )
     (i32.and
      (i32.sub
       (local.get $a)
       (local.get $b)
      )
      (i32.const 255)
     )
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 13)
     (i32.const 3)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (i32.and
      (i32.mul
       (local.get $a)
       (local.get $b)
      )
      (i32.const 255)
     )
     (i32.and
      (i32.mul
       (local.get $a)
       (local.get $b)
      )
      (i32.const 255)
     )
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 14)
     (i32.const 3)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (i32.and
      (i32.and
       (local.get $a)
       (local.get $b)
      )
      (i32.const 255)
     )
     (i32.and
      (i32.and
       (local.get $a)
       (local.get $b)
      )
      (i32.const 255)
     )
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 15)
     (i32.const 3)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (i32.and
      (i32.or
       (local.get $a)
       (local.get $b)
      )
      (i32.const 255)
     )
     (i32.and
      (i32.or
       (local.get $a)
       (local.get $b)
      )
      (i32.const 255)
     )
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 16)
     (i32.const 3)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (i32.and
      (i32.xor
       (local.get $a)
       (local.get $b)
      )
      (i32.const 255)
     )
     (i32.and
      (i32.xor
       (local.get $a)
       (local.get $b)
      )
      (i32.const 255)
     )
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 17)
     (i32.const 3)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (i32.and
      (i32.shl
       (local.get $a)
       (i32.and
        (local.get $b)
        (i32.const 7)
       )
      )
      (i32.const 255)
     )
     (i32.and
      (i32.shl
       (local.get $a)
       (i32.and
        (local.get $b)
        (i32.const 7)
       )
      )
      (i32.const 255)
     )
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 18)
     (i32.const 3)
    )
    (unreachable)
   )
  )
 )
 (func $retain-i32/testLocalRetain
  (local $ri i32)
  (local.set $ri
   (i32.load8_s
    (i32.const 0)
   )
  )
  (drop
   (i32.const 1)
  )
 )
 (func $start:retain-i32
  (local $i i32)
  (call $retain-i32/test
   (i32.const 0)
   (global.get $~lib/builtins/i8.MAX_VALUE)
  )
  (call $retain-i32/test
   (global.get $~lib/builtins/i8.MAX_VALUE)
   (i32.const 0)
  )
  (call $retain-i32/test
   (i32.const 1)
   (global.get $~lib/builtins/i8.MAX_VALUE)
  )
  (call $retain-i32/test
   (global.get $~lib/builtins/i8.MAX_VALUE)
   (i32.const 1)
  )
  (call $retain-i32/test
   (i32.const -1)
   (global.get $~lib/builtins/i8.MAX_VALUE)
  )
  (call $retain-i32/test
   (global.get $~lib/builtins/i8.MAX_VALUE)
   (i32.const -1)
  )
  (call $retain-i32/test
   (i32.const 0)
   (global.get $~lib/builtins/i8.MIN_VALUE)
  )
  (call $retain-i32/test
   (global.get $~lib/builtins/i8.MIN_VALUE)
   (i32.const 0)
  )
  (call $retain-i32/test
   (i32.const 1)
   (global.get $~lib/builtins/i8.MIN_VALUE)
  )
  (call $retain-i32/test
   (global.get $~lib/builtins/i8.MIN_VALUE)
   (i32.const 1)
  )
  (call $retain-i32/test
   (i32.const -1)
   (global.get $~lib/builtins/i8.MIN_VALUE)
  )
  (call $retain-i32/test
   (global.get $~lib/builtins/i8.MIN_VALUE)
   (i32.const -1)
  )
  (call $retain-i32/test
   (global.get $~lib/builtins/i8.MAX_VALUE)
   (global.get $~lib/builtins/i8.MAX_VALUE)
  )
  (call $retain-i32/test
   (global.get $~lib/builtins/i8.MIN_VALUE)
   (global.get $~lib/builtins/i8.MIN_VALUE)
  )
  (call $retain-i32/test
   (global.get $~lib/builtins/i8.MAX_VALUE)
   (global.get $~lib/builtins/i8.MIN_VALUE)
  )
  (call $retain-i32/test
   (global.get $~lib/builtins/i8.MIN_VALUE)
   (global.get $~lib/builtins/i8.MAX_VALUE)
  )
  (call $retain-i32/test
   (i32.const 0)
   (global.get $~lib/builtins/u8.MAX_VALUE)
  )
  (call $retain-i32/test
   (global.get $~lib/builtins/u8.MAX_VALUE)
   (i32.const 0)
  )
  (call $retain-i32/test
   (i32.const 1)
   (global.get $~lib/builtins/u8.MAX_VALUE)
  )
  (call $retain-i32/test
   (global.get $~lib/builtins/u8.MAX_VALUE)
   (i32.const 1)
  )
  (call $retain-i32/test
   (i32.const -1)
   (global.get $~lib/builtins/u8.MAX_VALUE)
  )
  (call $retain-i32/test
   (global.get $~lib/builtins/u8.MAX_VALUE)
   (i32.const -1)
  )
  (call $retain-i32/test
   (global.get $~lib/builtins/u8.MAX_VALUE)
   (global.get $~lib/builtins/u8.MAX_VALUE)
  )
  (block
   (local.set $i
    (global.get $~lib/builtins/i8.MIN_VALUE)
   )
   (loop $for-loop|0
    (if
     (i32.le_s
      (local.get $i)
      (global.get $~lib/builtins/u8.MAX_VALUE)
     )
     (then
      (call $retain-i32/test
       (i32.const 0)
       (local.get $i)
      )
      (call $retain-i32/test
       (i32.const 1)
       (local.get $i)
      )
      (call $retain-i32/test
       (i32.const -1)
       (local.get $i)
      )
      (call $retain-i32/test
       (global.get $~lib/builtins/i8.MIN_VALUE)
       (local.get $i)
      )
      (call $retain-i32/test
       (global.get $~lib/builtins/i8.MAX_VALUE)
       (local.get $i)
      )
      (call $retain-i32/test
       (global.get $~lib/builtins/u8.MAX_VALUE)
       (local.get $i)
      )
      (call $retain-i32/test
       (global.get $~lib/builtins/i16.MIN_VALUE)
       (local.get $i)
      )
      (call $retain-i32/test
       (global.get $~lib/builtins/i16.MAX_VALUE)
       (local.get $i)
      )
      (call $retain-i32/test
       (global.get $~lib/builtins/u16.MAX_VALUE)
       (local.get $i)
      )
      (call $retain-i32/test
       (global.get $~lib/builtins/i32.MAX_VALUE)
       (local.get $i)
      )
      (call $retain-i32/test
       (global.get $~lib/builtins/i32.MIN_VALUE)
       (local.get $i)
      )
      (call $retain-i32/test
       (global.get $~lib/builtins/u32.MAX_VALUE)
       (local.get $i)
      )
      (local.set $i
       (i32.add
        (local.get $i)
        (i32.const 1)
       )
      )
      (br $for-loop|0)
     )
    )
   )
  )
  (global.set $retain-i32/si
   (i32.extend8_s
    (i32.add
     (i32.add
      (i32.const 127)
      (i32.const 127)
     )
     (i32.const 1)
    )
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (global.get $retain-i32/si)
     (i32.const -1)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 77)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (global.set $retain-i32/si
   (i32.extend8_s
    (i32.sub
     (i32.sub
      (i32.const 127)
      (i32.const 1)
     )
     (i32.const 127)
    )
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (global.get $retain-i32/si)
     (i32.const -1)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 80)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (global.set $retain-i32/si
   (i32.extend8_s
    (i32.mul
     (i32.const 127)
     (i32.const 2)
    )
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (global.get $retain-i32/si)
     (i32.const -2)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 83)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (global.set $retain-i32/si
   (i32.extend8_s
    (i32.sub
     (i32.const 0)
     (i32.const -128)
    )
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (global.get $retain-i32/si)
     (i32.const -128)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 86)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (global.set $retain-i32/si
   (i32.extend8_s
    (i32.mul
     (i32.const -128)
     (i32.const -1)
    )
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (global.get $retain-i32/si)
     (i32.const -128)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 89)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (global.set $retain-i32/si
   (i32.extend8_s
    (i32.div_s
     (i32.const 127)
     (i32.const -1)
    )
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (global.get $retain-i32/si)
     (i32.const -127)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 92)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (global.set $retain-i32/si
   (i32.extend8_s
    (i32.div_s
     (i32.const -128)
     (i32.const -1)
    )
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (global.get $retain-i32/si)
     (i32.const -128)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 95)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (global.set $retain-i32/si
   (i32.rem_s
    (i32.const 127)
    (i32.const 2)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (global.get $retain-i32/si)
     (i32.const 1)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 98)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (global.set $retain-i32/si
   (i32.rem_s
    (i32.const 1)
    (i32.const 127)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (global.get $retain-i32/si)
     (i32.const 1)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 101)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (global.set $retain-i32/si
   (i32.rem_s
    (i32.const -128)
    (i32.const 2)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (global.get $retain-i32/si)
     (i32.const 0)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 104)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (global.set $retain-i32/si
   (i32.rem_s
    (i32.const 1)
    (i32.const -128)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (global.get $retain-i32/si)
     (i32.const 1)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 107)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (global.set $retain-i32/ui
   (i32.and
    (i32.add
     (i32.add
      (i32.const 255)
      (i32.const 255)
     )
     (i32.const 1)
    )
    (i32.const 255)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (global.get $retain-i32/ui)
     (i32.const 255)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 112)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (global.set $retain-i32/ui
   (i32.and
    (i32.sub
     (i32.sub
      (i32.const 255)
      (i32.const 1)
     )
     (i32.const 255)
    )
    (i32.const 255)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (global.get $retain-i32/ui)
     (i32.const 255)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 115)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (global.set $retain-i32/ui
   (i32.and
    (i32.mul
     (i32.const 255)
     (i32.const 2)
    )
    (i32.const 255)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (global.get $retain-i32/ui)
     (i32.const 254)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 118)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (global.set $retain-i32/ui
   (i32.and
    (i32.mul
     (i32.const 255)
     (i32.const 255)
    )
    (i32.const 255)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (global.get $retain-i32/ui)
     (i32.const 1)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 121)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (global.set $retain-i32/ui
   (i32.div_u
    (i32.const 255)
    (i32.const 255)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (global.get $retain-i32/ui)
     (i32.const 1)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 124)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (global.set $retain-i32/ui
   (i32.rem_u
    (i32.const 255)
    (i32.const 2)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (global.get $retain-i32/ui)
     (i32.const 1)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 127)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (global.set $retain-i32/ui
   (i32.rem_u
    (i32.const 255)
    (i32.const 255)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (global.get $retain-i32/ui)
     (i32.const 0)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 130)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (global.set $retain-i32/ri
   (i32.load8_s
    (i32.const 0)
   )
  )
  (drop
   (i32.const 1)
  )
  (call $retain-i32/testLocalRetain)
 )
 (func $~start
  (call $start:retain-i32)
 )
)
