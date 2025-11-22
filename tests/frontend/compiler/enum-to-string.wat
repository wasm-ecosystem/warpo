(module
 (type $0 (func (param i32) (result i32)))
 (type $1 (func))
 (type $2 (func (param i32 i32 i32 i32 i32) (result i32)))
 (type $3 (func (param i32 i32) (result i32)))
 (type $4 (func (param i32 i32 i32 i32)))
 (import "env" "abort" (func $~lib/builtins/abort (param i32 i32 i32 i32)))
 (import "as-builtin-fn" "~lib/rt/__localtostack" (func $~lib/rt/__localtostack (param i32) (result i32)))
 (import "as-builtin-fn" "~lib/rt/__tmptostack" (func $~lib/rt/__tmptostack (param i32) (result i32)))
 (global $enum-to-string/Enum.E0 i32 (i32.const 0))
 (global $enum-to-string/Enum.E1 i32 (i32.const 1))
 (global $enum-to-string/Enum.E2 i32 (i32.const 2))
 (global $~lib/shared/runtime/Runtime.Stub i32 (i32.const 0))
 (global $~lib/shared/runtime/Runtime.Minimal i32 (i32.const 1))
 (global $~lib/shared/runtime/Runtime.Incremental i32 (i32.const 2))
 (global $~lib/native/ASC_SHRINK_LEVEL i32 (i32.const 0))
 (global $enum-to-string/v (mut i32) (i32.const 0))
 (global $enum-to-string/EnumWithInit.E0 i32 (i32.const 1))
 (global $enum-to-string/EnumWithInit.E1 i32 (i32.const 2))
 (global $enum-to-string/EnumWithInit.E2 i32 (i32.const 4))
 (global $enum-to-string/EnumWithDup.E0 i32 (i32.const 1))
 (global $enum-to-string/EnumWithDup.E1 i32 (i32.const 2))
 (global $enum-to-string/EnumWithDup.E2 i32 (i32.const 1))
 (global $~lib/memory/__data_end i32 (i32.const 268))
 (global $~lib/memory/__stack_pointer (mut i32) (i32.const 33036))
 (global $~lib/memory/__heap_base i32 (i32.const 33036))
 (memory $0 1)
 (data $0 (i32.const 12) "\1c\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\04\00\00\00E\002\00\00\00\00\00\00\00\00\00")
 (data $1 (i32.const 44) "\1c\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\04\00\00\00E\001\00\00\00\00\00\00\00\00\00")
 (data $2 (i32.const 76) "\1c\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\04\00\00\00E\000\00\00\00\00\00\00\00\00\00")
 (data $3 (i32.const 108) "<\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\"\00\00\00e\00n\00u\00m\00-\00t\00o\00-\00s\00t\00r\00i\00n\00g\00.\00t\00s\00\00\00\00\00\00\00\00\00\00\00")
 (data $4 (i32.const 172) "\1c\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\06\00\00\00C\00E\002\00\00\00\00\00\00\00")
 (data $5 (i32.const 204) "\1c\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\06\00\00\00C\00E\001\00\00\00\00\00\00\00")
 (data $6 (i32.const 236) "\1c\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\06\00\00\00C\00E\000\00\00\00\00\00\00\00")
 (table $0 1 1 funcref)
 (elem $0 (i32.const 1))
 (export "memory" (memory $0))
 (start $~start)
 (func $enum-to-string/Enum#__enum_to_string (param $0 i32) (result i32)
  (if
   (i32.eq
    (global.get $enum-to-string/Enum.E2)
    (local.get $0)
   )
   (then
    (return
     (i32.const 32)
    )
   )
  )
  (if
   (i32.eq
    (global.get $enum-to-string/Enum.E1)
    (local.get $0)
   )
   (then
    (return
     (i32.const 64)
    )
   )
  )
  (if
   (i32.eq
    (global.get $enum-to-string/Enum.E0)
    (local.get $0)
   )
   (then
    (return
     (i32.const 96)
    )
   )
  )
  (unreachable)
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
 (func $enum-to-string/InlineEnum#__enum_to_string (param $0 i32) (result i32)
  (if
   (i32.eq
    (i32.const 2)
    (local.get $0)
   )
   (then
    (return
     (i32.const 192)
    )
   )
  )
  (if
   (i32.eq
    (i32.const 1)
    (local.get $0)
   )
   (then
    (return
     (i32.const 224)
    )
   )
  )
  (if
   (i32.eq
    (i32.const 0)
    (local.get $0)
   )
   (then
    (return
     (i32.const 256)
    )
   )
  )
  (unreachable)
 )
 (func $enum-to-string/EnumWithInit#__enum_to_string (param $0 i32) (result i32)
  (if
   (i32.eq
    (global.get $enum-to-string/EnumWithInit.E2)
    (local.get $0)
   )
   (then
    (return
     (i32.const 32)
    )
   )
  )
  (if
   (i32.eq
    (global.get $enum-to-string/EnumWithInit.E1)
    (local.get $0)
   )
   (then
    (return
     (i32.const 64)
    )
   )
  )
  (if
   (i32.eq
    (global.get $enum-to-string/EnumWithInit.E0)
    (local.get $0)
   )
   (then
    (return
     (i32.const 96)
    )
   )
  )
  (unreachable)
 )
 (func $enum-to-string/EnumWithDup#__enum_to_string (param $0 i32) (result i32)
  (if
   (i32.eq
    (global.get $enum-to-string/EnumWithDup.E2)
    (local.get $0)
   )
   (then
    (return
     (i32.const 32)
    )
   )
  )
  (if
   (i32.eq
    (global.get $enum-to-string/EnumWithDup.E1)
    (local.get $0)
   )
   (then
    (return
     (i32.const 64)
    )
   )
  )
  (if
   (i32.eq
    (global.get $enum-to-string/EnumWithDup.E0)
    (local.get $0)
   )
   (then
    (return
     (i32.const 96)
    )
   )
  )
  (unreachable)
 )
 (func $start:enum-to-string
  (if
   (i32.eqz
    (call $~lib/string/String.__eq
     (call $~lib/rt/__tmptostack
      (call $enum-to-string/Enum#__enum_to_string
       (global.get $enum-to-string/Enum.E0)
      )
     )
     (i32.const 96)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 128)
     (i32.const 7)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (call $~lib/string/String.__eq
     (call $~lib/rt/__tmptostack
      (call $enum-to-string/Enum#__enum_to_string
       (global.get $enum-to-string/Enum.E1)
      )
     )
     (i32.const 64)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 128)
     (i32.const 8)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (call $~lib/string/String.__eq
     (call $~lib/rt/__tmptostack
      (call $enum-to-string/Enum#__enum_to_string
       (global.get $enum-to-string/Enum.E2)
      )
     )
     (i32.const 32)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 128)
     (i32.const 9)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (global.set $enum-to-string/v
   (global.get $enum-to-string/Enum.E2)
  )
  (if
   (i32.eqz
    (call $~lib/string/String.__eq
     (call $~lib/rt/__tmptostack
      (call $enum-to-string/Enum#__enum_to_string
       (global.get $enum-to-string/v)
      )
     )
     (i32.const 32)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 128)
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
      (call $enum-to-string/InlineEnum#__enum_to_string
       (i32.const 0)
      )
     )
     (i32.const 256)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 128)
     (i32.const 22)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (call $~lib/string/String.__eq
     (call $~lib/rt/__tmptostack
      (call $enum-to-string/InlineEnum#__enum_to_string
       (i32.const 1)
      )
     )
     (i32.const 224)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 128)
     (i32.const 23)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (call $~lib/string/String.__eq
     (call $~lib/rt/__tmptostack
      (call $enum-to-string/InlineEnum#__enum_to_string
       (i32.const 2)
      )
     )
     (i32.const 192)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 128)
     (i32.const 24)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (call $~lib/string/String.__eq
     (call $~lib/rt/__tmptostack
      (call $enum-to-string/EnumWithInit#__enum_to_string
       (global.get $enum-to-string/EnumWithInit.E0)
      )
     )
     (i32.const 96)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 128)
     (i32.const 32)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (call $~lib/string/String.__eq
     (call $~lib/rt/__tmptostack
      (call $enum-to-string/EnumWithInit#__enum_to_string
       (global.get $enum-to-string/EnumWithInit.E1)
      )
     )
     (i32.const 64)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 128)
     (i32.const 33)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (call $~lib/string/String.__eq
     (call $~lib/rt/__tmptostack
      (call $enum-to-string/EnumWithInit#__enum_to_string
       (global.get $enum-to-string/EnumWithInit.E2)
      )
     )
     (i32.const 32)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 128)
     (i32.const 34)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (call $~lib/string/String.__eq
     (call $~lib/rt/__tmptostack
      (call $enum-to-string/EnumWithDup#__enum_to_string
       (global.get $enum-to-string/EnumWithDup.E0)
      )
     )
     (i32.const 32)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 128)
     (i32.const 42)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (call $~lib/string/String.__eq
     (call $~lib/rt/__tmptostack
      (call $enum-to-string/EnumWithDup#__enum_to_string
       (global.get $enum-to-string/EnumWithDup.E1)
      )
     )
     (i32.const 64)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 128)
     (i32.const 43)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (call $~lib/string/String.__eq
     (call $~lib/rt/__tmptostack
      (call $enum-to-string/EnumWithDup#__enum_to_string
       (global.get $enum-to-string/EnumWithDup.E2)
      )
     )
     (i32.const 32)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 128)
     (i32.const 44)
     (i32.const 1)
    )
    (unreachable)
   )
  )
 )
 (func $~start
  (call $start:enum-to-string)
 )
)
