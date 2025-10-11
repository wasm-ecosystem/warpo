(module
 (type $0 (func))
 (type $1 (func (param i32) (result i32)))
 (type $2 (func (param i32 i32 i32) (result i32)))
 (type $3 (func (param i32 i32 i32 i32)))
 (import "env" "abort" (func $~lib/builtins/abort (param i32 i32 i32 i32)))
 (import "as-builtin-fn" "~lib/rt/__localtostack" (func $~lib/rt/__localtostack (param i32) (result i32)))
 (import "as-builtin-fn" "~lib/rt/__tmptostack" (func $~lib/rt/__tmptostack (param i32) (result i32)))
 (global $memcpy/base i32 (i32.const 8))
 (global $memcpy/dest (mut i32) (i32.const 0))
 (global $~lib/memory/__data_end i32 (i32.const 60))
 (global $~lib/memory/__stack_pointer (mut i32) (i32.const 32828))
 (global $~lib/memory/__heap_base i32 (i32.const 32828))
 (memory $0 1)
 (data $0 (i32.const 12) ",\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\12\00\00\00m\00e\00m\00c\00p\00y\00.\00t\00s\00\00\00\00\00\00\00\00\00\00\00")
 (table $0 1 1 funcref)
 (elem $0 (i32.const 1))
 (export "memcpy" (func $memcpy/memcpy))
 (export "memory" (memory $0))
 (start $~start)
 (func $memcpy/memcpy (param $dest i32) (param $src i32) (param $n i32) (result i32)
  (local $ret i32)
  (local $w i32)
  (local $x i32)
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
  (local $16 i32)
  (local $17 i32)
  (local $18 i32)
  (local $19 i32)
  (local $20 i32)
  (local $21 i32)
  (local $22 i32)
  (local $23 i32)
  (local $24 i32)
  (local $25 i32)
  (local $26 i32)
  (local $27 i32)
  (local $28 i32)
  (local $29 i32)
  (local $30 i32)
  (local $31 i32)
  (local $32 i32)
  (local $33 i32)
  (local $34 i32)
  (local $35 i32)
  (local $36 i32)
  (local $37 i32)
  (local $38 i32)
  (local $39 i32)
  (local $40 i32)
  (local $41 i32)
  (local $42 i32)
  (local $43 i32)
  (local $44 i32)
  (local $45 i32)
  (local $46 i32)
  (local $47 i32)
  (local $48 i32)
  (local $49 i32)
  (local $50 i32)
  (local $51 i32)
  (local $52 i32)
  (local $53 i32)
  (local $54 i32)
  (local $55 i32)
  (local $56 i32)
  (local $57 i32)
  (local $58 i32)
  (local $59 i32)
  (local $60 i32)
  (local $61 i32)
  (local $62 i32)
  (local $63 i32)
  (local $64 i32)
  (local $65 i32)
  (local $66 i32)
  (local $67 i32)
  (local $68 i32)
  (local $69 i32)
  (local $70 i32)
  (local $71 i32)
  (local $72 i32)
  (local $73 i32)
  (local $74 i32)
  (local $75 i32)
  (local $76 i32)
  (local $77 i32)
  (local $78 i32)
  (local $79 i32)
  (local $80 i32)
  (local $81 i32)
  (local $82 i32)
  (local $83 i32)
  (local $84 i32)
  (local.set $ret
   (local.get $dest)
  )
  (block $while-break|0
   (loop $while-continue|0
    (if
     (if (result i32)
      (local.get $n)
      (then
       (i32.rem_u
        (local.get $src)
        (i32.const 4)
       )
      )
      (else
       (i32.const 0)
      )
     )
     (then
      (i32.store8
       (block (result i32)
        (local.set $dest
         (i32.add
          (local.tee $6
           (local.get $dest)
          )
          (i32.const 1)
         )
        )
        (local.get $6)
       )
       (i32.load8_u
        (block (result i32)
         (local.set $src
          (i32.add
           (local.tee $7
            (local.get $src)
           )
           (i32.const 1)
          )
         )
         (local.get $7)
        )
       )
      )
      (local.set $n
       (i32.sub
        (local.get $n)
        (i32.const 1)
       )
      )
      (br $while-continue|0)
     )
    )
   )
  )
  (if
   (i32.eq
    (i32.rem_u
     (local.get $dest)
     (i32.const 4)
    )
    (i32.const 0)
   )
   (then
    (block $while-break|1
     (loop $while-continue|1
      (if
       (i32.ge_u
        (local.get $n)
        (i32.const 16)
       )
       (then
        (i32.store
         (local.get $dest)
         (i32.load
          (local.get $src)
         )
        )
        (i32.store
         (i32.add
          (local.get $dest)
          (i32.const 4)
         )
         (i32.load
          (i32.add
           (local.get $src)
           (i32.const 4)
          )
         )
        )
        (i32.store
         (i32.add
          (local.get $dest)
          (i32.const 8)
         )
         (i32.load
          (i32.add
           (local.get $src)
           (i32.const 8)
          )
         )
        )
        (i32.store
         (i32.add
          (local.get $dest)
          (i32.const 12)
         )
         (i32.load
          (i32.add
           (local.get $src)
           (i32.const 12)
          )
         )
        )
        (local.set $src
         (i32.add
          (local.get $src)
          (i32.const 16)
         )
        )
        (local.set $dest
         (i32.add
          (local.get $dest)
          (i32.const 16)
         )
        )
        (local.set $n
         (i32.sub
          (local.get $n)
          (i32.const 16)
         )
        )
        (br $while-continue|1)
       )
      )
     )
    )
    (if
     (i32.and
      (local.get $n)
      (i32.const 8)
     )
     (then
      (i32.store
       (local.get $dest)
       (i32.load
        (local.get $src)
       )
      )
      (i32.store
       (i32.add
        (local.get $dest)
        (i32.const 4)
       )
       (i32.load
        (i32.add
         (local.get $src)
         (i32.const 4)
        )
       )
      )
      (local.set $dest
       (i32.add
        (local.get $dest)
        (i32.const 8)
       )
      )
      (local.set $src
       (i32.add
        (local.get $src)
        (i32.const 8)
       )
      )
     )
    )
    (if
     (i32.and
      (local.get $n)
      (i32.const 4)
     )
     (then
      (i32.store
       (local.get $dest)
       (i32.load
        (local.get $src)
       )
      )
      (local.set $dest
       (i32.add
        (local.get $dest)
        (i32.const 4)
       )
      )
      (local.set $src
       (i32.add
        (local.get $src)
        (i32.const 4)
       )
      )
     )
    )
    (if
     (i32.and
      (local.get $n)
      (i32.const 2)
     )
     (then
      (i32.store16
       (local.get $dest)
       (i32.load16_u
        (local.get $src)
       )
      )
      (local.set $dest
       (i32.add
        (local.get $dest)
        (i32.const 2)
       )
      )
      (local.set $src
       (i32.add
        (local.get $src)
        (i32.const 2)
       )
      )
     )
    )
    (if
     (i32.and
      (local.get $n)
      (i32.const 1)
     )
     (then
      (i32.store8
       (block (result i32)
        (local.set $dest
         (i32.add
          (local.tee $8
           (local.get $dest)
          )
          (i32.const 1)
         )
        )
        (local.get $8)
       )
       (i32.load8_u
        (block (result i32)
         (local.set $src
          (i32.add
           (local.tee $9
            (local.get $src)
           )
           (i32.const 1)
          )
         )
         (local.get $9)
        )
       )
      )
     )
    )
    (return
     (local.get $ret)
    )
   )
  )
  (if
   (i32.ge_u
    (local.get $n)
    (i32.const 32)
   )
   (then
    (block $break|2
     (block $case2|2
      (block $case1|2
       (block $case0|2
        (local.set $10
         (i32.rem_u
          (local.get $dest)
          (i32.const 4)
         )
        )
        (br_if $case0|2
         (i32.eq
          (local.get $10)
          (i32.const 1)
         )
        )
        (br_if $case1|2
         (i32.eq
          (local.get $10)
          (i32.const 2)
         )
        )
        (br_if $case2|2
         (i32.eq
          (local.get $10)
          (i32.const 3)
         )
        )
        (br $break|2)
       )
       (local.set $w
        (i32.load
         (local.get $src)
        )
       )
       (i32.store8
        (block (result i32)
         (local.set $dest
          (i32.add
           (local.tee $11
            (local.get $dest)
           )
           (i32.const 1)
          )
         )
         (local.get $11)
        )
        (i32.load8_u
         (block (result i32)
          (local.set $src
           (i32.add
            (local.tee $12
             (local.get $src)
            )
            (i32.const 1)
           )
          )
          (local.get $12)
         )
        )
       )
       (i32.store8
        (block (result i32)
         (local.set $dest
          (i32.add
           (local.tee $13
            (local.get $dest)
           )
           (i32.const 1)
          )
         )
         (local.get $13)
        )
        (i32.load8_u
         (block (result i32)
          (local.set $src
           (i32.add
            (local.tee $14
             (local.get $src)
            )
            (i32.const 1)
           )
          )
          (local.get $14)
         )
        )
       )
       (i32.store8
        (block (result i32)
         (local.set $dest
          (i32.add
           (local.tee $15
            (local.get $dest)
           )
           (i32.const 1)
          )
         )
         (local.get $15)
        )
        (i32.load8_u
         (block (result i32)
          (local.set $src
           (i32.add
            (local.tee $16
             (local.get $src)
            )
            (i32.const 1)
           )
          )
          (local.get $16)
         )
        )
       )
       (local.set $n
        (i32.sub
         (local.get $n)
         (i32.const 3)
        )
       )
       (block $while-break|3
        (loop $while-continue|3
         (if
          (i32.ge_u
           (local.get $n)
           (i32.const 17)
          )
          (then
           (local.set $x
            (i32.load
             (i32.add
              (local.get $src)
              (i32.const 1)
             )
            )
           )
           (i32.store
            (local.get $dest)
            (i32.or
             (i32.shr_u
              (local.get $w)
              (i32.const 24)
             )
             (i32.shl
              (local.get $x)
              (i32.const 8)
             )
            )
           )
           (local.set $w
            (i32.load
             (i32.add
              (local.get $src)
              (i32.const 5)
             )
            )
           )
           (i32.store
            (i32.add
             (local.get $dest)
             (i32.const 4)
            )
            (i32.or
             (i32.shr_u
              (local.get $x)
              (i32.const 24)
             )
             (i32.shl
              (local.get $w)
              (i32.const 8)
             )
            )
           )
           (local.set $x
            (i32.load
             (i32.add
              (local.get $src)
              (i32.const 9)
             )
            )
           )
           (i32.store
            (i32.add
             (local.get $dest)
             (i32.const 8)
            )
            (i32.or
             (i32.shr_u
              (local.get $w)
              (i32.const 24)
             )
             (i32.shl
              (local.get $x)
              (i32.const 8)
             )
            )
           )
           (local.set $w
            (i32.load
             (i32.add
              (local.get $src)
              (i32.const 13)
             )
            )
           )
           (i32.store
            (i32.add
             (local.get $dest)
             (i32.const 12)
            )
            (i32.or
             (i32.shr_u
              (local.get $x)
              (i32.const 24)
             )
             (i32.shl
              (local.get $w)
              (i32.const 8)
             )
            )
           )
           (local.set $src
            (i32.add
             (local.get $src)
             (i32.const 16)
            )
           )
           (local.set $dest
            (i32.add
             (local.get $dest)
             (i32.const 16)
            )
           )
           (local.set $n
            (i32.sub
             (local.get $n)
             (i32.const 16)
            )
           )
           (br $while-continue|3)
          )
         )
        )
       )
       (br $break|2)
      )
      (local.set $w
       (i32.load
        (local.get $src)
       )
      )
      (i32.store8
       (block (result i32)
        (local.set $dest
         (i32.add
          (local.tee $17
           (local.get $dest)
          )
          (i32.const 1)
         )
        )
        (local.get $17)
       )
       (i32.load8_u
        (block (result i32)
         (local.set $src
          (i32.add
           (local.tee $18
            (local.get $src)
           )
           (i32.const 1)
          )
         )
         (local.get $18)
        )
       )
      )
      (i32.store8
       (block (result i32)
        (local.set $dest
         (i32.add
          (local.tee $19
           (local.get $dest)
          )
          (i32.const 1)
         )
        )
        (local.get $19)
       )
       (i32.load8_u
        (block (result i32)
         (local.set $src
          (i32.add
           (local.tee $20
            (local.get $src)
           )
           (i32.const 1)
          )
         )
         (local.get $20)
        )
       )
      )
      (local.set $n
       (i32.sub
        (local.get $n)
        (i32.const 2)
       )
      )
      (block $while-break|4
       (loop $while-continue|4
        (if
         (i32.ge_u
          (local.get $n)
          (i32.const 18)
         )
         (then
          (local.set $x
           (i32.load
            (i32.add
             (local.get $src)
             (i32.const 2)
            )
           )
          )
          (i32.store
           (local.get $dest)
           (i32.or
            (i32.shr_u
             (local.get $w)
             (i32.const 16)
            )
            (i32.shl
             (local.get $x)
             (i32.const 16)
            )
           )
          )
          (local.set $w
           (i32.load
            (i32.add
             (local.get $src)
             (i32.const 6)
            )
           )
          )
          (i32.store
           (i32.add
            (local.get $dest)
            (i32.const 4)
           )
           (i32.or
            (i32.shr_u
             (local.get $x)
             (i32.const 16)
            )
            (i32.shl
             (local.get $w)
             (i32.const 16)
            )
           )
          )
          (local.set $x
           (i32.load
            (i32.add
             (local.get $src)
             (i32.const 10)
            )
           )
          )
          (i32.store
           (i32.add
            (local.get $dest)
            (i32.const 8)
           )
           (i32.or
            (i32.shr_u
             (local.get $w)
             (i32.const 16)
            )
            (i32.shl
             (local.get $x)
             (i32.const 16)
            )
           )
          )
          (local.set $w
           (i32.load
            (i32.add
             (local.get $src)
             (i32.const 14)
            )
           )
          )
          (i32.store
           (i32.add
            (local.get $dest)
            (i32.const 12)
           )
           (i32.or
            (i32.shr_u
             (local.get $x)
             (i32.const 16)
            )
            (i32.shl
             (local.get $w)
             (i32.const 16)
            )
           )
          )
          (local.set $src
           (i32.add
            (local.get $src)
            (i32.const 16)
           )
          )
          (local.set $dest
           (i32.add
            (local.get $dest)
            (i32.const 16)
           )
          )
          (local.set $n
           (i32.sub
            (local.get $n)
            (i32.const 16)
           )
          )
          (br $while-continue|4)
         )
        )
       )
      )
      (br $break|2)
     )
     (local.set $w
      (i32.load
       (local.get $src)
      )
     )
     (i32.store8
      (block (result i32)
       (local.set $dest
        (i32.add
         (local.tee $21
          (local.get $dest)
         )
         (i32.const 1)
        )
       )
       (local.get $21)
      )
      (i32.load8_u
       (block (result i32)
        (local.set $src
         (i32.add
          (local.tee $22
           (local.get $src)
          )
          (i32.const 1)
         )
        )
        (local.get $22)
       )
      )
     )
     (local.set $n
      (i32.sub
       (local.get $n)
       (i32.const 1)
      )
     )
     (block $while-break|5
      (loop $while-continue|5
       (if
        (i32.ge_u
         (local.get $n)
         (i32.const 19)
        )
        (then
         (local.set $x
          (i32.load
           (i32.add
            (local.get $src)
            (i32.const 3)
           )
          )
         )
         (i32.store
          (local.get $dest)
          (i32.or
           (i32.shr_u
            (local.get $w)
            (i32.const 8)
           )
           (i32.shl
            (local.get $x)
            (i32.const 24)
           )
          )
         )
         (local.set $w
          (i32.load
           (i32.add
            (local.get $src)
            (i32.const 7)
           )
          )
         )
         (i32.store
          (i32.add
           (local.get $dest)
           (i32.const 4)
          )
          (i32.or
           (i32.shr_u
            (local.get $x)
            (i32.const 8)
           )
           (i32.shl
            (local.get $w)
            (i32.const 24)
           )
          )
         )
         (local.set $x
          (i32.load
           (i32.add
            (local.get $src)
            (i32.const 11)
           )
          )
         )
         (i32.store
          (i32.add
           (local.get $dest)
           (i32.const 8)
          )
          (i32.or
           (i32.shr_u
            (local.get $w)
            (i32.const 8)
           )
           (i32.shl
            (local.get $x)
            (i32.const 24)
           )
          )
         )
         (local.set $w
          (i32.load
           (i32.add
            (local.get $src)
            (i32.const 15)
           )
          )
         )
         (i32.store
          (i32.add
           (local.get $dest)
           (i32.const 12)
          )
          (i32.or
           (i32.shr_u
            (local.get $x)
            (i32.const 8)
           )
           (i32.shl
            (local.get $w)
            (i32.const 24)
           )
          )
         )
         (local.set $src
          (i32.add
           (local.get $src)
           (i32.const 16)
          )
         )
         (local.set $dest
          (i32.add
           (local.get $dest)
           (i32.const 16)
          )
         )
         (local.set $n
          (i32.sub
           (local.get $n)
           (i32.const 16)
          )
         )
         (br $while-continue|5)
        )
       )
      )
     )
     (br $break|2)
    )
   )
  )
  (if
   (i32.and
    (local.get $n)
    (i32.const 16)
   )
   (then
    (i32.store8
     (block (result i32)
      (local.set $dest
       (i32.add
        (local.tee $23
         (local.get $dest)
        )
        (i32.const 1)
       )
      )
      (local.get $23)
     )
     (i32.load8_u
      (block (result i32)
       (local.set $src
        (i32.add
         (local.tee $24
          (local.get $src)
         )
         (i32.const 1)
        )
       )
       (local.get $24)
      )
     )
    )
    (i32.store8
     (block (result i32)
      (local.set $dest
       (i32.add
        (local.tee $25
         (local.get $dest)
        )
        (i32.const 1)
       )
      )
      (local.get $25)
     )
     (i32.load8_u
      (block (result i32)
       (local.set $src
        (i32.add
         (local.tee $26
          (local.get $src)
         )
         (i32.const 1)
        )
       )
       (local.get $26)
      )
     )
    )
    (i32.store8
     (block (result i32)
      (local.set $dest
       (i32.add
        (local.tee $27
         (local.get $dest)
        )
        (i32.const 1)
       )
      )
      (local.get $27)
     )
     (i32.load8_u
      (block (result i32)
       (local.set $src
        (i32.add
         (local.tee $28
          (local.get $src)
         )
         (i32.const 1)
        )
       )
       (local.get $28)
      )
     )
    )
    (i32.store8
     (block (result i32)
      (local.set $dest
       (i32.add
        (local.tee $29
         (local.get $dest)
        )
        (i32.const 1)
       )
      )
      (local.get $29)
     )
     (i32.load8_u
      (block (result i32)
       (local.set $src
        (i32.add
         (local.tee $30
          (local.get $src)
         )
         (i32.const 1)
        )
       )
       (local.get $30)
      )
     )
    )
    (i32.store8
     (block (result i32)
      (local.set $dest
       (i32.add
        (local.tee $31
         (local.get $dest)
        )
        (i32.const 1)
       )
      )
      (local.get $31)
     )
     (i32.load8_u
      (block (result i32)
       (local.set $src
        (i32.add
         (local.tee $32
          (local.get $src)
         )
         (i32.const 1)
        )
       )
       (local.get $32)
      )
     )
    )
    (i32.store8
     (block (result i32)
      (local.set $dest
       (i32.add
        (local.tee $33
         (local.get $dest)
        )
        (i32.const 1)
       )
      )
      (local.get $33)
     )
     (i32.load8_u
      (block (result i32)
       (local.set $src
        (i32.add
         (local.tee $34
          (local.get $src)
         )
         (i32.const 1)
        )
       )
       (local.get $34)
      )
     )
    )
    (i32.store8
     (block (result i32)
      (local.set $dest
       (i32.add
        (local.tee $35
         (local.get $dest)
        )
        (i32.const 1)
       )
      )
      (local.get $35)
     )
     (i32.load8_u
      (block (result i32)
       (local.set $src
        (i32.add
         (local.tee $36
          (local.get $src)
         )
         (i32.const 1)
        )
       )
       (local.get $36)
      )
     )
    )
    (i32.store8
     (block (result i32)
      (local.set $dest
       (i32.add
        (local.tee $37
         (local.get $dest)
        )
        (i32.const 1)
       )
      )
      (local.get $37)
     )
     (i32.load8_u
      (block (result i32)
       (local.set $src
        (i32.add
         (local.tee $38
          (local.get $src)
         )
         (i32.const 1)
        )
       )
       (local.get $38)
      )
     )
    )
    (i32.store8
     (block (result i32)
      (local.set $dest
       (i32.add
        (local.tee $39
         (local.get $dest)
        )
        (i32.const 1)
       )
      )
      (local.get $39)
     )
     (i32.load8_u
      (block (result i32)
       (local.set $src
        (i32.add
         (local.tee $40
          (local.get $src)
         )
         (i32.const 1)
        )
       )
       (local.get $40)
      )
     )
    )
    (i32.store8
     (block (result i32)
      (local.set $dest
       (i32.add
        (local.tee $41
         (local.get $dest)
        )
        (i32.const 1)
       )
      )
      (local.get $41)
     )
     (i32.load8_u
      (block (result i32)
       (local.set $src
        (i32.add
         (local.tee $42
          (local.get $src)
         )
         (i32.const 1)
        )
       )
       (local.get $42)
      )
     )
    )
    (i32.store8
     (block (result i32)
      (local.set $dest
       (i32.add
        (local.tee $43
         (local.get $dest)
        )
        (i32.const 1)
       )
      )
      (local.get $43)
     )
     (i32.load8_u
      (block (result i32)
       (local.set $src
        (i32.add
         (local.tee $44
          (local.get $src)
         )
         (i32.const 1)
        )
       )
       (local.get $44)
      )
     )
    )
    (i32.store8
     (block (result i32)
      (local.set $dest
       (i32.add
        (local.tee $45
         (local.get $dest)
        )
        (i32.const 1)
       )
      )
      (local.get $45)
     )
     (i32.load8_u
      (block (result i32)
       (local.set $src
        (i32.add
         (local.tee $46
          (local.get $src)
         )
         (i32.const 1)
        )
       )
       (local.get $46)
      )
     )
    )
    (i32.store8
     (block (result i32)
      (local.set $dest
       (i32.add
        (local.tee $47
         (local.get $dest)
        )
        (i32.const 1)
       )
      )
      (local.get $47)
     )
     (i32.load8_u
      (block (result i32)
       (local.set $src
        (i32.add
         (local.tee $48
          (local.get $src)
         )
         (i32.const 1)
        )
       )
       (local.get $48)
      )
     )
    )
    (i32.store8
     (block (result i32)
      (local.set $dest
       (i32.add
        (local.tee $49
         (local.get $dest)
        )
        (i32.const 1)
       )
      )
      (local.get $49)
     )
     (i32.load8_u
      (block (result i32)
       (local.set $src
        (i32.add
         (local.tee $50
          (local.get $src)
         )
         (i32.const 1)
        )
       )
       (local.get $50)
      )
     )
    )
    (i32.store8
     (block (result i32)
      (local.set $dest
       (i32.add
        (local.tee $51
         (local.get $dest)
        )
        (i32.const 1)
       )
      )
      (local.get $51)
     )
     (i32.load8_u
      (block (result i32)
       (local.set $src
        (i32.add
         (local.tee $52
          (local.get $src)
         )
         (i32.const 1)
        )
       )
       (local.get $52)
      )
     )
    )
    (i32.store8
     (block (result i32)
      (local.set $dest
       (i32.add
        (local.tee $53
         (local.get $dest)
        )
        (i32.const 1)
       )
      )
      (local.get $53)
     )
     (i32.load8_u
      (block (result i32)
       (local.set $src
        (i32.add
         (local.tee $54
          (local.get $src)
         )
         (i32.const 1)
        )
       )
       (local.get $54)
      )
     )
    )
   )
  )
  (if
   (i32.and
    (local.get $n)
    (i32.const 8)
   )
   (then
    (i32.store8
     (block (result i32)
      (local.set $dest
       (i32.add
        (local.tee $55
         (local.get $dest)
        )
        (i32.const 1)
       )
      )
      (local.get $55)
     )
     (i32.load8_u
      (block (result i32)
       (local.set $src
        (i32.add
         (local.tee $56
          (local.get $src)
         )
         (i32.const 1)
        )
       )
       (local.get $56)
      )
     )
    )
    (i32.store8
     (block (result i32)
      (local.set $dest
       (i32.add
        (local.tee $57
         (local.get $dest)
        )
        (i32.const 1)
       )
      )
      (local.get $57)
     )
     (i32.load8_u
      (block (result i32)
       (local.set $src
        (i32.add
         (local.tee $58
          (local.get $src)
         )
         (i32.const 1)
        )
       )
       (local.get $58)
      )
     )
    )
    (i32.store8
     (block (result i32)
      (local.set $dest
       (i32.add
        (local.tee $59
         (local.get $dest)
        )
        (i32.const 1)
       )
      )
      (local.get $59)
     )
     (i32.load8_u
      (block (result i32)
       (local.set $src
        (i32.add
         (local.tee $60
          (local.get $src)
         )
         (i32.const 1)
        )
       )
       (local.get $60)
      )
     )
    )
    (i32.store8
     (block (result i32)
      (local.set $dest
       (i32.add
        (local.tee $61
         (local.get $dest)
        )
        (i32.const 1)
       )
      )
      (local.get $61)
     )
     (i32.load8_u
      (block (result i32)
       (local.set $src
        (i32.add
         (local.tee $62
          (local.get $src)
         )
         (i32.const 1)
        )
       )
       (local.get $62)
      )
     )
    )
    (i32.store8
     (block (result i32)
      (local.set $dest
       (i32.add
        (local.tee $63
         (local.get $dest)
        )
        (i32.const 1)
       )
      )
      (local.get $63)
     )
     (i32.load8_u
      (block (result i32)
       (local.set $src
        (i32.add
         (local.tee $64
          (local.get $src)
         )
         (i32.const 1)
        )
       )
       (local.get $64)
      )
     )
    )
    (i32.store8
     (block (result i32)
      (local.set $dest
       (i32.add
        (local.tee $65
         (local.get $dest)
        )
        (i32.const 1)
       )
      )
      (local.get $65)
     )
     (i32.load8_u
      (block (result i32)
       (local.set $src
        (i32.add
         (local.tee $66
          (local.get $src)
         )
         (i32.const 1)
        )
       )
       (local.get $66)
      )
     )
    )
    (i32.store8
     (block (result i32)
      (local.set $dest
       (i32.add
        (local.tee $67
         (local.get $dest)
        )
        (i32.const 1)
       )
      )
      (local.get $67)
     )
     (i32.load8_u
      (block (result i32)
       (local.set $src
        (i32.add
         (local.tee $68
          (local.get $src)
         )
         (i32.const 1)
        )
       )
       (local.get $68)
      )
     )
    )
    (i32.store8
     (block (result i32)
      (local.set $dest
       (i32.add
        (local.tee $69
         (local.get $dest)
        )
        (i32.const 1)
       )
      )
      (local.get $69)
     )
     (i32.load8_u
      (block (result i32)
       (local.set $src
        (i32.add
         (local.tee $70
          (local.get $src)
         )
         (i32.const 1)
        )
       )
       (local.get $70)
      )
     )
    )
   )
  )
  (if
   (i32.and
    (local.get $n)
    (i32.const 4)
   )
   (then
    (i32.store8
     (block (result i32)
      (local.set $dest
       (i32.add
        (local.tee $71
         (local.get $dest)
        )
        (i32.const 1)
       )
      )
      (local.get $71)
     )
     (i32.load8_u
      (block (result i32)
       (local.set $src
        (i32.add
         (local.tee $72
          (local.get $src)
         )
         (i32.const 1)
        )
       )
       (local.get $72)
      )
     )
    )
    (i32.store8
     (block (result i32)
      (local.set $dest
       (i32.add
        (local.tee $73
         (local.get $dest)
        )
        (i32.const 1)
       )
      )
      (local.get $73)
     )
     (i32.load8_u
      (block (result i32)
       (local.set $src
        (i32.add
         (local.tee $74
          (local.get $src)
         )
         (i32.const 1)
        )
       )
       (local.get $74)
      )
     )
    )
    (i32.store8
     (block (result i32)
      (local.set $dest
       (i32.add
        (local.tee $75
         (local.get $dest)
        )
        (i32.const 1)
       )
      )
      (local.get $75)
     )
     (i32.load8_u
      (block (result i32)
       (local.set $src
        (i32.add
         (local.tee $76
          (local.get $src)
         )
         (i32.const 1)
        )
       )
       (local.get $76)
      )
     )
    )
    (i32.store8
     (block (result i32)
      (local.set $dest
       (i32.add
        (local.tee $77
         (local.get $dest)
        )
        (i32.const 1)
       )
      )
      (local.get $77)
     )
     (i32.load8_u
      (block (result i32)
       (local.set $src
        (i32.add
         (local.tee $78
          (local.get $src)
         )
         (i32.const 1)
        )
       )
       (local.get $78)
      )
     )
    )
   )
  )
  (if
   (i32.and
    (local.get $n)
    (i32.const 2)
   )
   (then
    (i32.store8
     (block (result i32)
      (local.set $dest
       (i32.add
        (local.tee $79
         (local.get $dest)
        )
        (i32.const 1)
       )
      )
      (local.get $79)
     )
     (i32.load8_u
      (block (result i32)
       (local.set $src
        (i32.add
         (local.tee $80
          (local.get $src)
         )
         (i32.const 1)
        )
       )
       (local.get $80)
      )
     )
    )
    (i32.store8
     (block (result i32)
      (local.set $dest
       (i32.add
        (local.tee $81
         (local.get $dest)
        )
        (i32.const 1)
       )
      )
      (local.get $81)
     )
     (i32.load8_u
      (block (result i32)
       (local.set $src
        (i32.add
         (local.tee $82
          (local.get $src)
         )
         (i32.const 1)
        )
       )
       (local.get $82)
      )
     )
    )
   )
  )
  (if
   (i32.and
    (local.get $n)
    (i32.const 1)
   )
   (then
    (i32.store8
     (block (result i32)
      (local.set $dest
       (i32.add
        (local.tee $83
         (local.get $dest)
        )
        (i32.const 1)
       )
      )
      (local.get $83)
     )
     (i32.load8_u
      (block (result i32)
       (local.set $src
        (i32.add
         (local.tee $84
          (local.get $src)
         )
         (i32.const 1)
        )
       )
       (local.get $84)
      )
     )
    )
   )
  )
  (return
   (local.get $ret)
  )
 )
 (func $start:memcpy
  (i64.store
   (global.get $memcpy/base)
   (i64.const 1229782938247303441)
  )
  (i64.store
   (i32.add
    (global.get $memcpy/base)
    (i32.const 8)
   )
   (i64.const 2459565876494606882)
  )
  (i64.store
   (i32.add
    (global.get $memcpy/base)
    (i32.const 16)
   )
   (i64.const 3689348814741910323)
  )
  (i64.store
   (i32.add
    (global.get $memcpy/base)
    (i32.const 24)
   )
   (i64.const 4919131752989213764)
  )
  (global.set $memcpy/dest
   (call $memcpy/memcpy
    (i32.add
     (global.get $memcpy/base)
     (i32.const 1)
    )
    (i32.add
     (global.get $memcpy/base)
     (i32.const 16)
    )
    (i32.const 4)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (global.get $memcpy/dest)
     (i32.add
      (global.get $memcpy/base)
      (i32.const 1)
     )
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 164)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (i64.eq
     (i64.load
      (global.get $memcpy/base)
     )
     (i64.const 1229783084848853777)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 165)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (global.set $memcpy/dest
   (call $memcpy/memcpy
    (global.get $memcpy/base)
    (global.get $memcpy/base)
    (i32.const 32)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (global.get $memcpy/dest)
     (global.get $memcpy/base)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 168)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (i64.eq
     (i64.load
      (global.get $memcpy/base)
     )
     (i64.const 1229783084848853777)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 169)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (i64.eq
     (i64.load
      (i32.add
       (global.get $memcpy/base)
       (i32.const 8)
      )
     )
     (i64.const 2459565876494606882)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 170)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (i64.eq
     (i64.load
      (i32.add
       (global.get $memcpy/base)
       (i32.const 16)
      )
     )
     (i64.const 3689348814741910323)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 171)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (i64.eq
     (i64.load
      (i32.add
       (global.get $memcpy/base)
       (i32.const 24)
      )
     )
     (i64.const 4919131752989213764)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 172)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (global.set $memcpy/dest
   (call $memcpy/memcpy
    (i32.add
     (global.get $memcpy/base)
     (i32.const 5)
    )
    (i32.add
     (global.get $memcpy/base)
     (i32.const 28)
    )
    (i32.const 3)
   )
  )
  (if
   (i32.eqz
    (i64.eq
     (i64.load
      (global.get $memcpy/base)
     )
     (i64.const 4919131679688438545)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 175)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (global.set $memcpy/dest
   (call $memcpy/memcpy
    (i32.add
     (global.get $memcpy/base)
     (i32.const 8)
    )
    (i32.add
     (global.get $memcpy/base)
     (i32.const 16)
    )
    (i32.const 15)
   )
  )
  (if
   (i32.eqz
    (i64.eq
     (i64.load
      (global.get $memcpy/base)
     )
     (i64.const 4919131679688438545)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 178)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (i64.eq
     (i64.load
      (i32.add
       (global.get $memcpy/base)
       (i32.const 8)
      )
     )
     (i64.const 3689348814741910323)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 179)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (i64.eq
     (i64.load
      (i32.add
       (global.get $memcpy/base)
       (i32.const 16)
      )
     )
     (i64.const 3694152654344438852)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 180)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (i64.eq
     (i64.load
      (i32.add
       (global.get $memcpy/base)
       (i32.const 24)
      )
     )
     (i64.const 4919131752989213764)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 181)
     (i32.const 1)
    )
    (unreachable)
   )
  )
 )
 (func $~start
  (call $start:memcpy)
 )
)
