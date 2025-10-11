(module
 (type $0 (func))
 (type $1 (func (param i32) (result i32)))
 (type $2 (func (param i32 i32 i32) (result i32)))
 (type $3 (func (param i32 i32 i32 i32)))
 (import "env" "abort" (func $~lib/builtins/abort (param i32 i32 i32 i32)))
 (import "as-builtin-fn" "~lib/rt/__localtostack" (func $~lib/rt/__localtostack (param i32) (result i32)))
 (import "as-builtin-fn" "~lib/rt/__tmptostack" (func $~lib/rt/__tmptostack (param i32) (result i32)))
 (global $memmove/base i32 (i32.const 8))
 (global $memmove/dest (mut i32) (i32.const 0))
 (global $~lib/memory/__data_end i32 (i32.const 60))
 (global $~lib/memory/__stack_pointer (mut i32) (i32.const 32828))
 (global $~lib/memory/__heap_base i32 (i32.const 32828))
 (memory $0 1)
 (data $0 (i32.const 12) ",\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\14\00\00\00m\00e\00m\00m\00o\00v\00e\00.\00t\00s\00\00\00\00\00\00\00\00\00")
 (table $0 1 1 funcref)
 (elem $0 (i32.const 1))
 (export "memory" (memory $0))
 (start $~start)
 (func $memmove/memmove (param $dest i32) (param $src i32) (param $n i32) (result i32)
  (local $ret i32)
  (local $4 i32)
  (local $5 i32)
  (local $6 i32)
  (local $7 i32)
  (local.set $ret
   (local.get $dest)
  )
  (if
   (i32.eq
    (local.get $dest)
    (local.get $src)
   )
   (then
    (return
     (local.get $ret)
    )
   )
  )
  (if
   (i32.lt_u
    (local.get $dest)
    (local.get $src)
   )
   (then
    (if
     (i32.eq
      (i32.rem_u
       (local.get $src)
       (i32.const 8)
      )
      (i32.rem_u
       (local.get $dest)
       (i32.const 8)
      )
     )
     (then
      (block $while-break|0
       (loop $while-continue|0
        (if
         (i32.rem_u
          (local.get $dest)
          (i32.const 8)
         )
         (then
          (if
           (i32.eqz
            (local.get $n)
           )
           (then
            (return
             (local.get $ret)
            )
           )
          )
          (local.set $n
           (i32.sub
            (local.get $n)
            (i32.const 1)
           )
          )
          (i32.store8
           (block (result i32)
            (local.set $dest
             (i32.add
              (local.tee $4
               (local.get $dest)
              )
              (i32.const 1)
             )
            )
            (local.get $4)
           )
           (i32.load8_u
            (block (result i32)
             (local.set $src
              (i32.add
               (local.tee $5
                (local.get $src)
               )
               (i32.const 1)
              )
             )
             (local.get $5)
            )
           )
          )
          (br $while-continue|0)
         )
        )
       )
      )
      (block $while-break|1
       (loop $while-continue|1
        (if
         (i32.ge_u
          (local.get $n)
          (i32.const 8)
         )
         (then
          (i64.store
           (local.get $dest)
           (i64.load
            (local.get $src)
           )
          )
          (local.set $n
           (i32.sub
            (local.get $n)
            (i32.const 8)
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
          (br $while-continue|1)
         )
        )
       )
      )
     )
    )
    (block $while-break|2
     (loop $while-continue|2
      (if
       (local.get $n)
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
        (br $while-continue|2)
       )
      )
     )
    )
   )
   (else
    (if
     (i32.eq
      (i32.rem_u
       (local.get $src)
       (i32.const 8)
      )
      (i32.rem_u
       (local.get $dest)
       (i32.const 8)
      )
     )
     (then
      (block $while-break|3
       (loop $while-continue|3
        (if
         (i32.rem_u
          (i32.add
           (local.get $dest)
           (local.get $n)
          )
          (i32.const 8)
         )
         (then
          (if
           (i32.eqz
            (local.get $n)
           )
           (then
            (return
             (local.get $ret)
            )
           )
          )
          (i32.store8
           (i32.add
            (local.get $dest)
            (local.tee $n
             (i32.sub
              (local.get $n)
              (i32.const 1)
             )
            )
           )
           (i32.load8_u
            (i32.add
             (local.get $src)
             (local.get $n)
            )
           )
          )
          (br $while-continue|3)
         )
        )
       )
      )
      (block $while-break|4
       (loop $while-continue|4
        (if
         (i32.ge_u
          (local.get $n)
          (i32.const 8)
         )
         (then
          (local.set $n
           (i32.sub
            (local.get $n)
            (i32.const 8)
           )
          )
          (i64.store
           (i32.add
            (local.get $dest)
            (local.get $n)
           )
           (i64.load
            (i32.add
             (local.get $src)
             (local.get $n)
            )
           )
          )
          (br $while-continue|4)
         )
        )
       )
      )
     )
    )
    (block $while-break|5
     (loop $while-continue|5
      (if
       (local.get $n)
       (then
        (i32.store8
         (i32.add
          (local.get $dest)
          (local.tee $n
           (i32.sub
            (local.get $n)
            (i32.const 1)
           )
          )
         )
         (i32.load8_u
          (i32.add
           (local.get $src)
           (local.get $n)
          )
         )
        )
        (br $while-continue|5)
       )
      )
     )
    )
   )
  )
  (return
   (local.get $ret)
  )
 )
 (func $start:memmove
  (i64.store
   (global.get $memmove/base)
   (i64.const 1229782938247303441)
  )
  (i64.store
   (i32.add
    (global.get $memmove/base)
    (i32.const 8)
   )
   (i64.const 2459565876494606882)
  )
  (i64.store
   (i32.add
    (global.get $memmove/base)
    (i32.const 16)
   )
   (i64.const 3689348814741910323)
  )
  (i64.store
   (i32.add
    (global.get $memmove/base)
    (i32.const 24)
   )
   (i64.const 4919131752989213764)
  )
  (global.set $memmove/dest
   (call $memmove/memmove
    (i32.add
     (global.get $memmove/base)
     (i32.const 1)
    )
    (i32.add
     (global.get $memmove/base)
     (i32.const 16)
    )
    (i32.const 4)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (global.get $memmove/dest)
     (i32.add
      (global.get $memmove/base)
      (i32.const 1)
     )
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 52)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (i64.eq
     (i64.load
      (global.get $memmove/base)
     )
     (i64.const 1229783084848853777)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 53)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (global.set $memmove/dest
   (call $memmove/memmove
    (global.get $memmove/base)
    (global.get $memmove/base)
    (i32.const 32)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (global.get $memmove/dest)
     (global.get $memmove/base)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 56)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (i64.eq
     (i64.load
      (global.get $memmove/base)
     )
     (i64.const 1229783084848853777)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 57)
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
       (global.get $memmove/base)
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
     (i32.const 58)
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
       (global.get $memmove/base)
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
     (i32.const 59)
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
       (global.get $memmove/base)
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
     (i32.const 60)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (global.set $memmove/dest
   (call $memmove/memmove
    (i32.add
     (global.get $memmove/base)
     (i32.const 5)
    )
    (i32.add
     (global.get $memmove/base)
     (i32.const 28)
    )
    (i32.const 3)
   )
  )
  (if
   (i32.eqz
    (i64.eq
     (i64.load
      (global.get $memmove/base)
     )
     (i64.const 4919131679688438545)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 63)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (global.set $memmove/dest
   (call $memmove/memmove
    (i32.add
     (global.get $memmove/base)
     (i32.const 8)
    )
    (i32.add
     (global.get $memmove/base)
     (i32.const 16)
    )
    (i32.const 15)
   )
  )
  (if
   (i32.eqz
    (i64.eq
     (i64.load
      (global.get $memmove/base)
     )
     (i64.const 4919131679688438545)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 66)
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
       (global.get $memmove/base)
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
     (i32.const 67)
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
       (global.get $memmove/base)
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
     (i32.const 68)
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
       (global.get $memmove/base)
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
     (i32.const 69)
     (i32.const 1)
    )
    (unreachable)
   )
  )
 )
 (func $~start
  (call $start:memmove)
 )
)
