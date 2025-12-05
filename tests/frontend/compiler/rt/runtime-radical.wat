(module
 (type $0 (func (param i32 i32)))
 (type $1 (func (param i32) (result i32)))
 (type $2 (func))
 (type $3 (func (param i32)))
 (type $4 (func (param i32 i32) (result i32)))
 (type $5 (func (param i32 i32 i32)))
 (type $6 (func (param i32 i32 i32 i32)))
 (type $7 (func (param i32 i32 i32) (result i32)))
 (type $8 (func (param i32 i32 i64) (result i32)))
 (import "env" "abort" (func $~lib/builtins/abort (param i32 i32 i32 i32)))
 (import "as-builtin-fn" "~lib/rt/__localtostack" (func $~lib/rt/__localtostack (param i32) (result i32)))
 (import "as-builtin-fn" "~lib/rt/__tmptostack" (func $~lib/rt/__tmptostack (param i32) (result i32)))
 (global $~lib/rt/tcms/total (mut i32) (i32.const 0))
 (global $~lib/rt/tcms/threshold (mut i32) (i32.const 0))
 (global $~lib/rt/tcms/white (mut i32) (i32.const 0))
 (global $~lib/rt/tcms/toSpace (mut i32) (i32.const 0))
 (global $~lib/rt/tcms/pinSpace (mut i32) (i32.const 0))
 (global $~lib/rt/tcms/fromSpace (mut i32) (i32.const 0))
 (global $~lib/rt/tlsf/ROOT (mut i32) (i32.const 0))
 (global $~lib/native/ASC_LOW_MEMORY_LIMIT i32 (i32.const 0))
 (global $~lib/shared/runtime/Runtime.Stub i32 (i32.const 0))
 (global $~lib/shared/runtime/Runtime.Radical i32 (i32.const 1))
 (global $~lib/shared/runtime/Runtime.Incremental i32 (i32.const 2))
 (global $~lib/native/ASC_RUNTIME i32 (i32.const 1))
 (global $~lib/rt/__rtti_base i32 (i32.const 528))
 (global $~lib/memory/__data_end i32 (i32.const 556))
 (global $~lib/memory/__stack_pointer (mut i32) (i32.const 33324))
 (global $~lib/memory/__heap_base i32 (i32.const 33324))
 (memory $0 1)
 (data $0 (i32.const 12) "<\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00(\00\00\00A\00l\00l\00o\00c\00a\00t\00i\00o\00n\00 \00t\00o\00o\00 \00l\00a\00r\00g\00e\00\00\00\00\00")
 (data $1 (i32.const 76) "<\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\1e\00\00\00~\00l\00i\00b\00/\00r\00t\00/\00t\00c\00m\00s\00.\00t\00s\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00")
 (data $2 (i32.const 144) "\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00")
 (data $3 (i32.const 176) "\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00")
 (data $4 (i32.const 208) "\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00")
 (data $5 (i32.const 236) "<\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\1e\00\00\00~\00l\00i\00b\00/\00r\00t\00/\00t\00l\00s\00f\00.\00t\00s\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00")
 (data $6 (i32.const 300) ",\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\1c\00\00\00I\00n\00v\00a\00l\00i\00d\00 \00l\00e\00n\00g\00t\00h\00")
 (data $7 (i32.const 348) ",\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\1a\00\00\00~\00l\00i\00b\00/\00a\00r\00r\00a\00y\00.\00t\00s\00\00\00")
 (data $8 (i32.const 396) "<\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00*\00\00\00O\00b\00j\00e\00c\00t\00 \00a\00l\00r\00e\00a\00d\00y\00 \00p\00i\00n\00n\00e\00d\00\00\00")
 (data $9 (i32.const 460) "<\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00(\00\00\00O\00b\00j\00e\00c\00t\00 \00i\00s\00 \00n\00o\00t\00 \00p\00i\00n\00n\00e\00d\00\00\00\00\00")
 (data $10 (i32.const 528) "\06\00\00\00 \00\00\00 \00\00\00 \00\00\00\00\00\00\00\00\00\00\00\02\t\00\00")
 (table $0 1 1 funcref)
 (elem $0 (i32.const 1))
 (export "__new" (func $~lib/rt/tcms/__new))
 (export "__pin" (func $~lib/rt/tcms/__pin))
 (export "__unpin" (func $~lib/rt/tcms/__unpin))
 (export "__collect" (func $~lib/rt/tcms/__collect))
 (export "__rtti_base" (global $~lib/rt/__rtti_base))
 (export "memory" (memory $0))
 (start $~start)
 (func $~lib/rt/tcms/Object#get:nextWithColor (param $this i32) (result i32)
  (i32.load offset=4
   (local.get $this)
  )
 )
 (func $~lib/rt/tcms/Object#get:color (param $this i32) (result i32)
  (return
   (i32.and
    (call $~lib/rt/tcms/Object#get:nextWithColor
     (local.get $this)
    )
    (i32.const 3)
   )
  )
 )
 (func $~lib/rt/tcms/Object#get:next (param $this i32) (result i32)
  (return
   (i32.and
    (call $~lib/rt/tcms/Object#get:nextWithColor
     (local.get $this)
    )
    (i32.xor
     (i32.const 3)
     (i32.const -1)
    )
   )
  )
 )
 (func $~lib/rt/tcms/Object#get:prev (param $this i32) (result i32)
  (i32.load offset=8
   (local.get $this)
  )
 )
 (func $~lib/rt/tcms/Object#set:prev (param $this i32) (param $prev i32)
  (i32.store offset=8
   (local.get $this)
   (local.get $prev)
  )
 )
 (func $~lib/rt/tcms/Object#set:nextWithColor (param $this i32) (param $nextWithColor i32)
  (i32.store offset=4
   (local.get $this)
   (local.get $nextWithColor)
  )
 )
 (func $~lib/rt/tcms/Object#set:next (param $this i32) (param $obj i32)
  (call $~lib/rt/tcms/Object#set:nextWithColor
   (local.get $this)
   (i32.or
    (local.get $obj)
    (i32.and
     (call $~lib/rt/tcms/Object#get:nextWithColor
      (local.get $this)
     )
     (i32.const 3)
    )
   )
  )
 )
 (func $~lib/rt/tcms/Object#unlink (param $this i32)
  (local $next i32)
  (local $prev i32)
  (local.set $next
   (call $~lib/rt/tcms/Object#get:next
    (local.get $this)
   )
  )
  (if
   (i32.eq
    (local.get $next)
    (i32.const 0)
   )
   (then
    (drop
     (i32.const 1)
    )
    (if
     (i32.eqz
      (if (result i32)
       (i32.eq
        (call $~lib/rt/tcms/Object#get:prev
         (local.get $this)
        )
        (i32.const 0)
       )
       (then
        (i32.lt_u
         (local.get $this)
         (global.get $~lib/memory/__heap_base)
        )
       )
       (else
        (i32.const 0)
       )
      )
     )
     (then
      (call $~lib/builtins/abort
       (i32.const 0)
       (i32.const 96)
       (i32.const 100)
       (i32.const 18)
      )
      (unreachable)
     )
    )
    (return)
   )
  )
  (local.set $prev
   (call $~lib/rt/tcms/Object#get:prev
    (local.get $this)
   )
  )
  (drop
   (i32.const 1)
  )
  (if
   (i32.eqz
    (local.get $prev)
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 96)
     (i32.const 104)
     (i32.const 16)
    )
    (unreachable)
   )
  )
  (call $~lib/rt/tcms/Object#set:prev
   (local.get $next)
   (local.get $prev)
  )
  (call $~lib/rt/tcms/Object#set:next
   (local.get $prev)
   (local.get $next)
  )
 )
 (func $~lib/rt/tcms/initLazy (param $space i32) (result i32)
  (call $~lib/rt/tcms/Object#set:nextWithColor
   (local.get $space)
   (local.get $space)
  )
  (call $~lib/rt/tcms/Object#set:prev
   (local.get $space)
   (local.get $space)
  )
  (return
   (local.get $space)
  )
 )
 (func $~lib/rt/tcms/Object#linkTo (param $this i32) (param $list i32) (param $withColor i32)
  (local $prev i32)
  (local.set $prev
   (call $~lib/rt/tcms/Object#get:prev
    (local.get $list)
   )
  )
  (call $~lib/rt/tcms/Object#set:nextWithColor
   (local.get $this)
   (i32.or
    (local.get $list)
    (local.get $withColor)
   )
  )
  (call $~lib/rt/tcms/Object#set:prev
   (local.get $this)
   (local.get $prev)
  )
  (call $~lib/rt/tcms/Object#set:next
   (local.get $prev)
   (local.get $this)
  )
  (call $~lib/rt/tcms/Object#set:prev
   (local.get $list)
   (local.get $this)
  )
 )
 (func $~lib/rt/tcms/__visit (param $ptr i32) (param $cookie i32)
  (local $obj i32)
  (if
   (i32.eqz
    (local.get $ptr)
   )
   (then
    (return)
   )
  )
  (local.set $obj
   (i32.sub
    (local.get $ptr)
    (i32.const 20)
   )
  )
  (if
   (i32.eq
    (call $~lib/rt/tcms/Object#get:color
     (local.get $obj)
    )
    (global.get $~lib/rt/tcms/white)
   )
   (then
    (call $~lib/rt/tcms/Object#unlink
     (local.get $obj)
    )
    (call $~lib/rt/tcms/Object#linkTo
     (local.get $obj)
     (global.get $~lib/rt/tcms/toSpace)
     (i32.eqz
      (global.get $~lib/rt/tcms/white)
     )
    )
   )
  )
 )
 (func $~lib/rt/tcms/visitStack
  (local $ptr i32)
  (local.set $ptr
   (global.get $~lib/memory/__stack_pointer)
  )
  (block $while-break|0
   (loop $while-continue|0
    (if
     (i32.lt_u
      (local.get $ptr)
      (global.get $~lib/memory/__heap_base)
     )
     (then
      (call $~lib/rt/tcms/__visit
       (i32.load
        (local.get $ptr)
       )
       (i32.const 0)
      )
      (local.set $ptr
       (i32.add
        (local.get $ptr)
        (i32.const 4)
       )
      )
      (br $while-continue|0)
     )
    )
   )
  )
 )
 (func $~lib/rt/tcms/visitPinned
  (local $pn i32)
  (local $iter i32)
  (local.set $pn
   (global.get $~lib/rt/tcms/pinSpace)
  )
  (local.set $iter
   (call $~lib/rt/tcms/Object#get:next
    (local.get $pn)
   )
  )
  (block $while-break|0
   (loop $while-continue|0
    (if
     (i32.ne
      (local.get $iter)
      (local.get $pn)
     )
     (then
      (call $~lib/rt/__visit_members
       (i32.add
        (local.get $iter)
        (i32.const 20)
       )
       (i32.const 0)
      )
      (local.set $iter
       (call $~lib/rt/tcms/Object#get:next
        (local.get $iter)
       )
      )
      (br $while-continue|0)
     )
    )
   )
  )
 )
 (func $~lib/rt/common/BLOCK#get:mmInfo (param $this i32) (result i32)
  (i32.load
   (local.get $this)
  )
 )
 (func $~lib/rt/tcms/Object#get:size (param $this i32) (result i32)
  (return
   (i32.add
    (i32.const 4)
    (i32.and
     (call $~lib/rt/common/BLOCK#get:mmInfo
      (local.get $this)
     )
     (i32.xor
      (i32.const 3)
      (i32.const -1)
     )
    )
   )
  )
 )
 (func $~lib/rt/tlsf/Root#set:flMap (param $this i32) (param $flMap i32)
  (i32.store
   (local.get $this)
   (local.get $flMap)
  )
 )
 (func $~lib/rt/tlsf/SETTAIL (param $root i32) (param $tail i32)
  (i32.store offset=1568
   (local.get $root)
   (local.get $tail)
  )
 )
 (func $~lib/rt/tlsf/SETSL (param $root i32) (param $fl i32) (param $slMap i32)
  (i32.store offset=4
   (i32.add
    (local.get $root)
    (i32.shl
     (local.get $fl)
     (i32.const 2)
    )
   )
   (local.get $slMap)
  )
 )
 (func $~lib/rt/tlsf/SETHEAD (param $root i32) (param $fl i32) (param $sl i32) (param $head i32)
  (i32.store offset=96
   (i32.add
    (local.get $root)
    (i32.shl
     (i32.add
      (i32.shl
       (local.get $fl)
       (i32.const 4)
      )
      (local.get $sl)
     )
     (i32.const 2)
    )
   )
   (local.get $head)
  )
 )
 (func $~lib/rt/tlsf/GETTAIL (param $root i32) (result i32)
  (return
   (i32.load offset=1568
    (local.get $root)
   )
  )
 )
 (func $~lib/rt/common/BLOCK#set:mmInfo (param $this i32) (param $mmInfo i32)
  (i32.store
   (local.get $this)
   (local.get $mmInfo)
  )
 )
 (func $~lib/rt/tlsf/Block#set:prev (param $this i32) (param $prev i32)
  (i32.store offset=4
   (local.get $this)
   (local.get $prev)
  )
 )
 (func $~lib/rt/tlsf/Block#set:next (param $this i32) (param $next i32)
  (i32.store offset=8
   (local.get $this)
   (local.get $next)
  )
 )
 (func $~lib/rt/tlsf/GETRIGHT (param $block i32) (result i32)
  (return
   (i32.add
    (i32.add
     (local.get $block)
     (i32.const 4)
    )
    (i32.and
     (call $~lib/rt/common/BLOCK#get:mmInfo
      (local.get $block)
     )
     (i32.xor
      (i32.const 3)
      (i32.const -1)
     )
    )
   )
  )
 )
 (func $~lib/rt/tlsf/Block#get:prev (param $this i32) (result i32)
  (i32.load offset=4
   (local.get $this)
  )
 )
 (func $~lib/rt/tlsf/Block#get:next (param $this i32) (result i32)
  (i32.load offset=8
   (local.get $this)
  )
 )
 (func $~lib/rt/tlsf/GETHEAD (param $root i32) (param $fl i32) (param $sl i32) (result i32)
  (return
   (i32.load offset=96
    (i32.add
     (local.get $root)
     (i32.shl
      (i32.add
       (i32.shl
        (local.get $fl)
        (i32.const 4)
       )
       (local.get $sl)
      )
      (i32.const 2)
     )
    )
   )
  )
 )
 (func $~lib/rt/tlsf/GETSL (param $root i32) (param $fl i32) (result i32)
  (return
   (i32.load offset=4
    (i32.add
     (local.get $root)
     (i32.shl
      (local.get $fl)
      (i32.const 2)
     )
    )
   )
  )
 )
 (func $~lib/rt/tlsf/Root#get:flMap (param $this i32) (result i32)
  (i32.load
   (local.get $this)
  )
 )
 (func $~lib/rt/tlsf/removeBlock (param $root i32) (param $block i32)
  (local $blockInfo i32)
  (local $size i32)
  (local $fl i32)
  (local $sl i32)
  (local $6 i32)
  (local $7 i32)
  (local $boundedSize i32)
  (local $prev i32)
  (local $next i32)
  (local $slMap i32)
  (local.set $blockInfo
   (call $~lib/rt/common/BLOCK#get:mmInfo
    (local.get $block)
   )
  )
  (drop
   (i32.const 1)
  )
  (if
   (i32.eqz
    (i32.and
     (local.get $blockInfo)
     (i32.const 1)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 256)
     (i32.const 268)
     (i32.const 14)
    )
    (unreachable)
   )
  )
  (local.set $size
   (i32.and
    (local.get $blockInfo)
    (i32.xor
     (i32.const 3)
     (i32.const -1)
    )
   )
  )
  (drop
   (i32.const 1)
  )
  (if
   (i32.eqz
    (i32.ge_u
     (local.get $size)
     (i32.const 12)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 256)
     (i32.const 270)
     (i32.const 14)
    )
    (unreachable)
   )
  )
  (if
   (i32.lt_u
    (local.get $size)
    (i32.const 256)
   )
   (then
    (local.set $fl
     (i32.const 0)
    )
    (local.set $sl
     (i32.shr_u
      (local.get $size)
      (i32.const 4)
     )
    )
   )
   (else
    (local.set $boundedSize
     (select
      (local.tee $6
       (local.get $size)
      )
      (local.tee $7
       (i32.const 1073741820)
      )
      (i32.lt_u
       (local.get $6)
       (local.get $7)
      )
     )
    )
    (local.set $fl
     (i32.sub
      (i32.const 31)
      (i32.clz
       (local.get $boundedSize)
      )
     )
    )
    (local.set $sl
     (i32.xor
      (i32.shr_u
       (local.get $boundedSize)
       (i32.sub
        (local.get $fl)
        (i32.const 4)
       )
      )
      (i32.shl
       (i32.const 1)
       (i32.const 4)
      )
     )
    )
    (local.set $fl
     (i32.sub
      (local.get $fl)
      (i32.sub
       (i32.const 8)
       (i32.const 1)
      )
     )
    )
   )
  )
  (drop
   (i32.const 1)
  )
  (if
   (i32.eqz
    (if (result i32)
     (i32.lt_u
      (local.get $fl)
      (i32.const 23)
     )
     (then
      (i32.lt_u
       (local.get $sl)
       (i32.const 16)
      )
     )
     (else
      (i32.const 0)
     )
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 256)
     (i32.const 284)
     (i32.const 14)
    )
    (unreachable)
   )
  )
  (local.set $prev
   (call $~lib/rt/tlsf/Block#get:prev
    (local.get $block)
   )
  )
  (local.set $next
   (call $~lib/rt/tlsf/Block#get:next
    (local.get $block)
   )
  )
  (if
   (local.get $prev)
   (then
    (call $~lib/rt/tlsf/Block#set:next
     (local.get $prev)
     (local.get $next)
    )
   )
  )
  (if
   (local.get $next)
   (then
    (call $~lib/rt/tlsf/Block#set:prev
     (local.get $next)
     (local.get $prev)
    )
   )
  )
  (if
   (i32.eq
    (local.get $block)
    (call $~lib/rt/tlsf/GETHEAD
     (local.get $root)
     (local.get $fl)
     (local.get $sl)
    )
   )
   (then
    (call $~lib/rt/tlsf/SETHEAD
     (local.get $root)
     (local.get $fl)
     (local.get $sl)
     (local.get $next)
    )
    (if
     (i32.eqz
      (local.get $next)
     )
     (then
      (local.set $slMap
       (call $~lib/rt/tlsf/GETSL
        (local.get $root)
        (local.get $fl)
       )
      )
      (call $~lib/rt/tlsf/SETSL
       (local.get $root)
       (local.get $fl)
       (local.tee $slMap
        (i32.and
         (local.get $slMap)
         (i32.xor
          (i32.shl
           (i32.const 1)
           (local.get $sl)
          )
          (i32.const -1)
         )
        )
       )
      )
      (if
       (i32.eqz
        (local.get $slMap)
       )
       (then
        (call $~lib/rt/tlsf/Root#set:flMap
         (local.get $root)
         (i32.and
          (call $~lib/rt/tlsf/Root#get:flMap
           (local.get $root)
          )
          (i32.xor
           (i32.shl
            (i32.const 1)
            (local.get $fl)
           )
           (i32.const -1)
          )
         )
        )
       )
      )
     )
    )
   )
  )
 )
 (func $~lib/rt/tlsf/GETFREELEFT (param $block i32) (result i32)
  (return
   (i32.load
    (i32.sub
     (local.get $block)
     (i32.const 4)
    )
   )
  )
 )
 (func $~lib/rt/tlsf/insertBlock (param $root i32) (param $block i32)
  (local $blockInfo i32)
  (local $right i32)
  (local $rightInfo i32)
  (local $left i32)
  (local $leftInfo i32)
  (local $size i32)
  (local $fl i32)
  (local $sl i32)
  (local $10 i32)
  (local $11 i32)
  (local $boundedSize i32)
  (local $head i32)
  (drop
   (i32.const 1)
  )
  (if
   (i32.eqz
    (local.get $block)
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 256)
     (i32.const 201)
     (i32.const 14)
    )
    (unreachable)
   )
  )
  (local.set $blockInfo
   (call $~lib/rt/common/BLOCK#get:mmInfo
    (local.get $block)
   )
  )
  (drop
   (i32.const 1)
  )
  (if
   (i32.eqz
    (i32.and
     (local.get $blockInfo)
     (i32.const 1)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 256)
     (i32.const 203)
     (i32.const 14)
    )
    (unreachable)
   )
  )
  (local.set $right
   (call $~lib/rt/tlsf/GETRIGHT
    (local.get $block)
   )
  )
  (local.set $rightInfo
   (call $~lib/rt/common/BLOCK#get:mmInfo
    (local.get $right)
   )
  )
  (if
   (i32.and
    (local.get $rightInfo)
    (i32.const 1)
   )
   (then
    (call $~lib/rt/tlsf/removeBlock
     (local.get $root)
     (local.get $right)
    )
    (call $~lib/rt/common/BLOCK#set:mmInfo
     (local.get $block)
     (local.tee $blockInfo
      (i32.add
       (i32.add
        (local.get $blockInfo)
        (i32.const 4)
       )
       (i32.and
        (local.get $rightInfo)
        (i32.xor
         (i32.const 3)
         (i32.const -1)
        )
       )
      )
     )
    )
    (local.set $right
     (call $~lib/rt/tlsf/GETRIGHT
      (local.get $block)
     )
    )
    (local.set $rightInfo
     (call $~lib/rt/common/BLOCK#get:mmInfo
      (local.get $right)
     )
    )
   )
  )
  (if
   (i32.and
    (local.get $blockInfo)
    (i32.const 2)
   )
   (then
    (local.set $left
     (call $~lib/rt/tlsf/GETFREELEFT
      (local.get $block)
     )
    )
    (local.set $leftInfo
     (call $~lib/rt/common/BLOCK#get:mmInfo
      (local.get $left)
     )
    )
    (drop
     (i32.const 1)
    )
    (if
     (i32.eqz
      (i32.and
       (local.get $leftInfo)
       (i32.const 1)
      )
     )
     (then
      (call $~lib/builtins/abort
       (i32.const 0)
       (i32.const 256)
       (i32.const 221)
       (i32.const 16)
      )
      (unreachable)
     )
    )
    (call $~lib/rt/tlsf/removeBlock
     (local.get $root)
     (local.get $left)
    )
    (local.set $block
     (local.get $left)
    )
    (call $~lib/rt/common/BLOCK#set:mmInfo
     (local.get $block)
     (local.tee $blockInfo
      (i32.add
       (i32.add
        (local.get $leftInfo)
        (i32.const 4)
       )
       (i32.and
        (local.get $blockInfo)
        (i32.xor
         (i32.const 3)
         (i32.const -1)
        )
       )
      )
     )
    )
   )
  )
  (call $~lib/rt/common/BLOCK#set:mmInfo
   (local.get $right)
   (i32.or
    (local.get $rightInfo)
    (i32.const 2)
   )
  )
  (local.set $size
   (i32.and
    (local.get $blockInfo)
    (i32.xor
     (i32.const 3)
     (i32.const -1)
    )
   )
  )
  (drop
   (i32.const 1)
  )
  (if
   (i32.eqz
    (i32.ge_u
     (local.get $size)
     (i32.const 12)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 256)
     (i32.const 233)
     (i32.const 14)
    )
    (unreachable)
   )
  )
  (drop
   (i32.const 1)
  )
  (if
   (i32.eqz
    (i32.eq
     (i32.add
      (i32.add
       (local.get $block)
       (i32.const 4)
      )
      (local.get $size)
     )
     (local.get $right)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 256)
     (i32.const 234)
     (i32.const 14)
    )
    (unreachable)
   )
  )
  (i32.store
   (i32.sub
    (local.get $right)
    (i32.const 4)
   )
   (local.get $block)
  )
  (if
   (i32.lt_u
    (local.get $size)
    (i32.const 256)
   )
   (then
    (local.set $fl
     (i32.const 0)
    )
    (local.set $sl
     (i32.shr_u
      (local.get $size)
      (i32.const 4)
     )
    )
   )
   (else
    (local.set $boundedSize
     (select
      (local.tee $10
       (local.get $size)
      )
      (local.tee $11
       (i32.const 1073741820)
      )
      (i32.lt_u
       (local.get $10)
       (local.get $11)
      )
     )
    )
    (local.set $fl
     (i32.sub
      (i32.const 31)
      (i32.clz
       (local.get $boundedSize)
      )
     )
    )
    (local.set $sl
     (i32.xor
      (i32.shr_u
       (local.get $boundedSize)
       (i32.sub
        (local.get $fl)
        (i32.const 4)
       )
      )
      (i32.shl
       (i32.const 1)
       (i32.const 4)
      )
     )
    )
    (local.set $fl
     (i32.sub
      (local.get $fl)
      (i32.sub
       (i32.const 8)
       (i32.const 1)
      )
     )
    )
   )
  )
  (drop
   (i32.const 1)
  )
  (if
   (i32.eqz
    (if (result i32)
     (i32.lt_u
      (local.get $fl)
      (i32.const 23)
     )
     (then
      (i32.lt_u
       (local.get $sl)
       (i32.const 16)
      )
     )
     (else
      (i32.const 0)
     )
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 256)
     (i32.const 251)
     (i32.const 14)
    )
    (unreachable)
   )
  )
  (local.set $head
   (call $~lib/rt/tlsf/GETHEAD
    (local.get $root)
    (local.get $fl)
    (local.get $sl)
   )
  )
  (call $~lib/rt/tlsf/Block#set:prev
   (local.get $block)
   (i32.const 0)
  )
  (call $~lib/rt/tlsf/Block#set:next
   (local.get $block)
   (local.get $head)
  )
  (if
   (local.get $head)
   (then
    (call $~lib/rt/tlsf/Block#set:prev
     (local.get $head)
     (local.get $block)
    )
   )
  )
  (call $~lib/rt/tlsf/SETHEAD
   (local.get $root)
   (local.get $fl)
   (local.get $sl)
   (local.get $block)
  )
  (call $~lib/rt/tlsf/Root#set:flMap
   (local.get $root)
   (i32.or
    (call $~lib/rt/tlsf/Root#get:flMap
     (local.get $root)
    )
    (i32.shl
     (i32.const 1)
     (local.get $fl)
    )
   )
  )
  (call $~lib/rt/tlsf/SETSL
   (local.get $root)
   (local.get $fl)
   (i32.or
    (call $~lib/rt/tlsf/GETSL
     (local.get $root)
     (local.get $fl)
    )
    (i32.shl
     (i32.const 1)
     (local.get $sl)
    )
   )
  )
 )
 (func $~lib/rt/tlsf/addMemory (param $root i32) (param $start i32) (param $endU64 i64) (result i32)
  (local $end i32)
  (local $tail i32)
  (local $tailInfo i32)
  (local $size i32)
  (local $leftSize i32)
  (local $left i32)
  (local.set $end
   (i32.wrap_i64
    (local.get $endU64)
   )
  )
  (drop
   (i32.const 1)
  )
  (if
   (i32.eqz
    (i64.le_u
     (i64.extend_i32_u
      (local.get $start)
     )
     (local.get $endU64)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 256)
     (i32.const 382)
     (i32.const 14)
    )
    (unreachable)
   )
  )
  (local.set $start
   (i32.sub
    (i32.and
     (i32.add
      (i32.add
       (local.get $start)
       (i32.const 4)
      )
      (i32.const 15)
     )
     (i32.xor
      (i32.const 15)
      (i32.const -1)
     )
    )
    (i32.const 4)
   )
  )
  (local.set $end
   (i32.and
    (local.get $end)
    (i32.xor
     (i32.const 15)
     (i32.const -1)
    )
   )
  )
  (local.set $tail
   (call $~lib/rt/tlsf/GETTAIL
    (local.get $root)
   )
  )
  (local.set $tailInfo
   (i32.const 0)
  )
  (if
   (local.get $tail)
   (then
    (drop
     (i32.const 1)
    )
    (if
     (i32.eqz
      (i32.ge_u
       (local.get $start)
       (i32.add
        (local.get $tail)
        (i32.const 4)
       )
      )
     )
     (then
      (call $~lib/builtins/abort
       (i32.const 0)
       (i32.const 256)
       (i32.const 389)
       (i32.const 16)
      )
      (unreachable)
     )
    )
    (if
     (i32.eq
      (i32.sub
       (local.get $start)
       (i32.const 16)
      )
      (local.get $tail)
     )
     (then
      (local.set $start
       (i32.sub
        (local.get $start)
        (i32.const 16)
       )
      )
      (local.set $tailInfo
       (call $~lib/rt/common/BLOCK#get:mmInfo
        (local.get $tail)
       )
      )
     )
     (else
      (nop)
     )
    )
   )
   (else
    (drop
     (i32.const 1)
    )
    (if
     (i32.eqz
      (i32.ge_u
       (local.get $start)
       (i32.add
        (local.get $root)
        (i32.const 1572)
       )
      )
     )
     (then
      (call $~lib/builtins/abort
       (i32.const 0)
       (i32.const 256)
       (i32.const 402)
       (i32.const 5)
      )
      (unreachable)
     )
    )
   )
  )
  (local.set $size
   (i32.sub
    (local.get $end)
    (local.get $start)
   )
  )
  (if
   (i32.lt_u
    (local.get $size)
    (i32.add
     (i32.add
      (i32.const 4)
      (i32.const 12)
     )
     (i32.const 4)
    )
   )
   (then
    (return
     (i32.const 0)
    )
   )
  )
  (local.set $leftSize
   (i32.sub
    (local.get $size)
    (i32.mul
     (i32.const 2)
     (i32.const 4)
    )
   )
  )
  (local.set $left
   (local.get $start)
  )
  (call $~lib/rt/common/BLOCK#set:mmInfo
   (local.get $left)
   (i32.or
    (i32.or
     (local.get $leftSize)
     (i32.const 1)
    )
    (i32.and
     (local.get $tailInfo)
     (i32.const 2)
    )
   )
  )
  (call $~lib/rt/tlsf/Block#set:prev
   (local.get $left)
   (i32.const 0)
  )
  (call $~lib/rt/tlsf/Block#set:next
   (local.get $left)
   (i32.const 0)
  )
  (local.set $tail
   (i32.add
    (i32.add
     (local.get $start)
     (i32.const 4)
    )
    (local.get $leftSize)
   )
  )
  (call $~lib/rt/common/BLOCK#set:mmInfo
   (local.get $tail)
   (i32.or
    (i32.const 0)
    (i32.const 2)
   )
  )
  (call $~lib/rt/tlsf/SETTAIL
   (local.get $root)
   (local.get $tail)
  )
  (call $~lib/rt/tlsf/insertBlock
   (local.get $root)
   (local.get $left)
  )
  (return
   (i32.const 1)
  )
 )
 (func $~lib/rt/tlsf/initialize
  (local $rootOffset i32)
  (local $pagesBefore i32)
  (local $pagesNeeded i32)
  (local $root i32)
  (local $fl i32)
  (local $sl i32)
  (local $memStart i32)
  (drop
   (i32.const 0)
  )
  (local.set $rootOffset
   (i32.and
    (i32.add
     (global.get $~lib/memory/__heap_base)
     (i32.const 15)
    )
    (i32.xor
     (i32.const 15)
     (i32.const -1)
    )
   )
  )
  (local.set $pagesBefore
   (memory.size)
  )
  (local.set $pagesNeeded
   (i32.shr_u
    (i32.and
     (i32.add
      (i32.add
       (local.get $rootOffset)
       (i32.const 1572)
      )
      (i32.const 65535)
     )
     (i32.xor
      (i32.const 65535)
      (i32.const -1)
     )
    )
    (i32.const 16)
   )
  )
  (if
   (if (result i32)
    (i32.gt_s
     (local.get $pagesNeeded)
     (local.get $pagesBefore)
    )
    (then
     (i32.lt_s
      (memory.grow
       (i32.sub
        (local.get $pagesNeeded)
        (local.get $pagesBefore)
       )
      )
      (i32.const 0)
     )
    )
    (else
     (i32.const 0)
    )
   )
   (then
    (unreachable)
   )
  )
  (local.set $root
   (local.get $rootOffset)
  )
  (call $~lib/rt/tlsf/Root#set:flMap
   (local.get $root)
   (i32.const 0)
  )
  (call $~lib/rt/tlsf/SETTAIL
   (local.get $root)
   (i32.const 0)
  )
  (local.set $fl
   (i32.const 0)
  )
  (loop $for-loop|0
   (if
    (i32.lt_u
     (local.get $fl)
     (i32.const 23)
    )
    (then
     (call $~lib/rt/tlsf/SETSL
      (local.get $root)
      (local.get $fl)
      (i32.const 0)
     )
     (local.set $sl
      (i32.const 0)
     )
     (loop $for-loop|1
      (if
       (i32.lt_u
        (local.get $sl)
        (i32.const 16)
       )
       (then
        (call $~lib/rt/tlsf/SETHEAD
         (local.get $root)
         (local.get $fl)
         (local.get $sl)
         (i32.const 0)
        )
        (local.set $sl
         (i32.add
          (local.get $sl)
          (i32.const 1)
         )
        )
        (br $for-loop|1)
       )
      )
     )
     (local.set $fl
      (i32.add
       (local.get $fl)
       (i32.const 1)
      )
     )
     (br $for-loop|0)
    )
   )
  )
  (local.set $memStart
   (i32.add
    (local.get $rootOffset)
    (i32.const 1572)
   )
  )
  (drop
   (i32.const 0)
  )
  (drop
   (call $~lib/rt/tlsf/addMemory
    (local.get $root)
    (local.get $memStart)
    (i64.shl
     (i64.extend_i32_s
      (memory.size)
     )
     (i64.const 16)
    )
   )
  )
  (global.set $~lib/rt/tlsf/ROOT
   (local.get $root)
  )
 )
 (func $~lib/rt/tlsf/checkUsedBlock (param $ptr i32) (result i32)
  (local $block i32)
  (local.set $block
   (i32.sub
    (local.get $ptr)
    (i32.const 4)
   )
  )
  (if
   (i32.eqz
    (if (result i32)
     (if (result i32)
      (i32.ne
       (local.get $ptr)
       (i32.const 0)
      )
      (then
       (i32.eqz
        (i32.and
         (local.get $ptr)
         (i32.const 15)
        )
       )
      )
      (else
       (i32.const 0)
      )
     )
     (then
      (i32.eqz
       (i32.and
        (call $~lib/rt/common/BLOCK#get:mmInfo
         (local.get $block)
        )
        (i32.const 1)
       )
      )
     )
     (else
      (i32.const 0)
     )
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 256)
     (i32.const 562)
     (i32.const 3)
    )
    (unreachable)
   )
  )
  (return
   (local.get $block)
  )
 )
 (func $~lib/rt/tlsf/freeBlock (param $root i32) (param $block i32)
  (drop
   (i32.const 0)
  )
  (call $~lib/rt/common/BLOCK#set:mmInfo
   (local.get $block)
   (i32.or
    (call $~lib/rt/common/BLOCK#get:mmInfo
     (local.get $block)
    )
    (i32.const 1)
   )
  )
  (call $~lib/rt/tlsf/insertBlock
   (local.get $root)
   (local.get $block)
  )
 )
 (func $~lib/rt/tlsf/__free (param $ptr i32)
  (if
   (i32.lt_u
    (local.get $ptr)
    (global.get $~lib/memory/__heap_base)
   )
   (then
    (return)
   )
  )
  (if
   (i32.eqz
    (global.get $~lib/rt/tlsf/ROOT)
   )
   (then
    (call $~lib/rt/tlsf/initialize)
   )
  )
  (call $~lib/rt/tlsf/freeBlock
   (global.get $~lib/rt/tlsf/ROOT)
   (call $~lib/rt/tlsf/checkUsedBlock
    (local.get $ptr)
   )
  )
 )
 (func $~lib/rt/tcms/free (param $obj i32)
  (if
   (i32.lt_u
    (local.get $obj)
    (global.get $~lib/memory/__heap_base)
   )
   (then
    (call $~lib/rt/tcms/Object#set:nextWithColor
     (local.get $obj)
     (i32.const 0)
    )
    (call $~lib/rt/tcms/Object#set:prev
     (local.get $obj)
     (i32.const 0)
    )
   )
   (else
    (drop
     (i32.const 0)
    )
    (global.set $~lib/rt/tcms/total
     (i32.sub
      (global.get $~lib/rt/tcms/total)
      (call $~lib/rt/tcms/Object#get:size
       (local.get $obj)
      )
     )
    )
    (call $~lib/rt/tlsf/__free
     (i32.add
      (local.get $obj)
      (i32.const 4)
     )
    )
   )
  )
 )
 (func $~lib/rt/tcms/__collect
  (local $beforeTotal i32)
  (local $iter i32)
  (local $next i32)
  (local $tmp i32)
  (local.set $beforeTotal
   (global.get $~lib/rt/tcms/total)
  )
  (call $~lib/rt/__visit_globals
   (i32.const 0)
  )
  (call $~lib/rt/tcms/visitStack)
  (call $~lib/rt/tcms/visitPinned)
  (local.set $iter
   (call $~lib/rt/tcms/Object#get:next
    (global.get $~lib/rt/tcms/toSpace)
   )
  )
  (block $while-break|0
   (loop $while-continue|0
    (if
     (i32.ne
      (local.get $iter)
      (global.get $~lib/rt/tcms/toSpace)
     )
     (then
      (drop
       (i32.const 1)
      )
      (if
       (i32.eqz
        (i32.ne
         (call $~lib/rt/tcms/Object#get:color
          (local.get $iter)
         )
         (global.get $~lib/rt/tcms/white)
        )
       )
       (then
        (call $~lib/builtins/abort
         (i32.const 0)
         (i32.const 96)
         (i32.const 249)
         (i32.const 16)
        )
        (unreachable)
       )
      )
      (call $~lib/rt/__visit_members
       (i32.add
        (local.get $iter)
        (i32.const 20)
       )
       (i32.const 0)
      )
      (local.set $iter
       (call $~lib/rt/tcms/Object#get:next
        (local.get $iter)
       )
      )
      (br $while-continue|0)
     )
    )
   )
  )
  (local.set $iter
   (call $~lib/rt/tcms/Object#get:next
    (global.get $~lib/rt/tcms/fromSpace)
   )
  )
  (block $while-break|1
   (loop $while-continue|1
    (if
     (i32.ne
      (local.get $iter)
      (global.get $~lib/rt/tcms/fromSpace)
     )
     (then
      (local.set $next
       (call $~lib/rt/tcms/Object#get:next
        (local.get $iter)
       )
      )
      (call $~lib/rt/tcms/free
       (local.get $iter)
      )
      (local.set $iter
       (local.get $next)
      )
      (br $while-continue|1)
     )
    )
   )
  )
  (call $~lib/rt/tcms/Object#set:nextWithColor
   (global.get $~lib/rt/tcms/fromSpace)
   (global.get $~lib/rt/tcms/fromSpace)
  )
  (call $~lib/rt/tcms/Object#set:prev
   (global.get $~lib/rt/tcms/fromSpace)
   (global.get $~lib/rt/tcms/fromSpace)
  )
  (local.set $tmp
   (global.get $~lib/rt/tcms/fromSpace)
  )
  (global.set $~lib/rt/tcms/fromSpace
   (global.get $~lib/rt/tcms/toSpace)
  )
  (global.set $~lib/rt/tcms/toSpace
   (local.get $tmp)
  )
  (global.set $~lib/rt/tcms/white
   (i32.eqz
    (global.get $~lib/rt/tcms/white)
   )
  )
  (if
   (i32.gt_u
    (i32.sub
     (local.get $beforeTotal)
     (global.get $~lib/rt/tcms/total)
    )
    (i32.const 65536)
   )
   (then
    (global.set $~lib/rt/tcms/threshold
     (local.get $beforeTotal)
    )
   )
   (else
    (global.set $~lib/rt/tcms/threshold
     (i32.add
      (local.get $beforeTotal)
      (i32.const 65536)
     )
    )
   )
  )
 )
 (func $~lib/rt/tlsf/computeSize (param $size i32) (result i32)
  (return
   (if (result i32)
    (i32.le_u
     (local.get $size)
     (i32.const 12)
    )
    (then
     (i32.const 12)
    )
    (else
     (i32.sub
      (i32.and
       (i32.add
        (i32.add
         (local.get $size)
         (i32.const 4)
        )
        (i32.const 15)
       )
       (i32.xor
        (i32.const 15)
        (i32.const -1)
       )
      )
      (i32.const 4)
     )
    )
   )
  )
 )
 (func $~lib/rt/tlsf/prepareSize (param $size i32) (result i32)
  (if
   (i32.gt_u
    (local.get $size)
    (i32.const 1073741820)
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 32)
     (i32.const 256)
     (i32.const 461)
     (i32.const 29)
    )
    (unreachable)
   )
  )
  (return
   (call $~lib/rt/tlsf/computeSize
    (local.get $size)
   )
  )
 )
 (func $~lib/rt/tlsf/roundSize (param $size i32) (result i32)
  (return
   (if (result i32)
    (i32.lt_u
     (local.get $size)
     (i32.const 536870910)
    )
    (then
     (i32.sub
      (i32.add
       (local.get $size)
       (i32.shl
        (i32.const 1)
        (i32.sub
         (i32.const 27)
         (i32.clz
          (local.get $size)
         )
        )
       )
      )
      (i32.const 1)
     )
    )
    (else
     (local.get $size)
    )
   )
  )
 )
 (func $~lib/rt/tlsf/searchBlock (param $root i32) (param $size i32) (result i32)
  (local $fl i32)
  (local $sl i32)
  (local $requestSize i32)
  (local $slMap i32)
  (local $head i32)
  (local $flMap i32)
  (if
   (i32.lt_u
    (local.get $size)
    (i32.const 256)
   )
   (then
    (local.set $fl
     (i32.const 0)
    )
    (local.set $sl
     (i32.shr_u
      (local.get $size)
      (i32.const 4)
     )
    )
   )
   (else
    (local.set $requestSize
     (call $~lib/rt/tlsf/roundSize
      (local.get $size)
     )
    )
    (local.set $fl
     (i32.sub
      (i32.sub
       (i32.mul
        (i32.const 4)
        (i32.const 8)
       )
       (i32.const 1)
      )
      (i32.clz
       (local.get $requestSize)
      )
     )
    )
    (local.set $sl
     (i32.xor
      (i32.shr_u
       (local.get $requestSize)
       (i32.sub
        (local.get $fl)
        (i32.const 4)
       )
      )
      (i32.shl
       (i32.const 1)
       (i32.const 4)
      )
     )
    )
    (local.set $fl
     (i32.sub
      (local.get $fl)
      (i32.sub
       (i32.const 8)
       (i32.const 1)
      )
     )
    )
   )
  )
  (drop
   (i32.const 1)
  )
  (if
   (i32.eqz
    (if (result i32)
     (i32.lt_u
      (local.get $fl)
      (i32.const 23)
     )
     (then
      (i32.lt_u
       (local.get $sl)
       (i32.const 16)
      )
     )
     (else
      (i32.const 0)
     )
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 256)
     (i32.const 334)
     (i32.const 14)
    )
    (unreachable)
   )
  )
  (local.set $slMap
   (i32.and
    (call $~lib/rt/tlsf/GETSL
     (local.get $root)
     (local.get $fl)
    )
    (i32.shl
     (i32.xor
      (i32.const 0)
      (i32.const -1)
     )
     (local.get $sl)
    )
   )
  )
  (local.set $head
   (i32.const 0)
  )
  (if
   (i32.eqz
    (local.get $slMap)
   )
   (then
    (local.set $flMap
     (i32.and
      (call $~lib/rt/tlsf/Root#get:flMap
       (local.get $root)
      )
      (i32.shl
       (i32.xor
        (i32.const 0)
        (i32.const -1)
       )
       (i32.add
        (local.get $fl)
        (i32.const 1)
       )
      )
     )
    )
    (if
     (i32.eqz
      (local.get $flMap)
     )
     (then
      (local.set $head
       (i32.const 0)
      )
     )
     (else
      (local.set $fl
       (i32.ctz
        (local.get $flMap)
       )
      )
      (local.set $slMap
       (call $~lib/rt/tlsf/GETSL
        (local.get $root)
        (local.get $fl)
       )
      )
      (drop
       (i32.const 1)
      )
      (if
       (i32.eqz
        (local.get $slMap)
       )
       (then
        (call $~lib/builtins/abort
         (i32.const 0)
         (i32.const 256)
         (i32.const 347)
         (i32.const 18)
        )
        (unreachable)
       )
      )
      (local.set $head
       (call $~lib/rt/tlsf/GETHEAD
        (local.get $root)
        (local.get $fl)
        (i32.ctz
         (local.get $slMap)
        )
       )
      )
     )
    )
   )
   (else
    (local.set $head
     (call $~lib/rt/tlsf/GETHEAD
      (local.get $root)
      (local.get $fl)
      (i32.ctz
       (local.get $slMap)
      )
     )
    )
   )
  )
  (return
   (local.get $head)
  )
 )
 (func $~lib/rt/tlsf/growMemory (param $root i32) (param $size i32)
  (local $pagesBefore i32)
  (local $pagesNeeded i32)
  (local $4 i32)
  (local $5 i32)
  (local $pagesWanted i32)
  (local $pagesAfter i32)
  (drop
   (i32.const 0)
  )
  (if
   (i32.ge_u
    (local.get $size)
    (i32.const 256)
   )
   (then
    (local.set $size
     (call $~lib/rt/tlsf/roundSize
      (local.get $size)
     )
    )
   )
  )
  (local.set $pagesBefore
   (memory.size)
  )
  (local.set $size
   (i32.add
    (local.get $size)
    (i32.shl
     (i32.const 4)
     (i32.ne
      (i32.sub
       (i32.shl
        (local.get $pagesBefore)
        (i32.const 16)
       )
       (i32.const 4)
      )
      (call $~lib/rt/tlsf/GETTAIL
       (local.get $root)
      )
     )
    )
   )
  )
  (local.set $pagesNeeded
   (i32.shr_u
    (i32.and
     (i32.add
      (local.get $size)
      (i32.const 65535)
     )
     (i32.xor
      (i32.const 65535)
      (i32.const -1)
     )
    )
    (i32.const 16)
   )
  )
  (local.set $pagesWanted
   (select
    (local.tee $4
     (local.get $pagesBefore)
    )
    (local.tee $5
     (local.get $pagesNeeded)
    )
    (i32.gt_s
     (local.get $4)
     (local.get $5)
    )
   )
  )
  (if
   (i32.lt_s
    (memory.grow
     (local.get $pagesWanted)
    )
    (i32.const 0)
   )
   (then
    (if
     (i32.lt_s
      (memory.grow
       (local.get $pagesNeeded)
      )
      (i32.const 0)
     )
     (then
      (unreachable)
     )
    )
   )
  )
  (local.set $pagesAfter
   (memory.size)
  )
  (drop
   (call $~lib/rt/tlsf/addMemory
    (local.get $root)
    (i32.shl
     (local.get $pagesBefore)
     (i32.const 16)
    )
    (i64.shl
     (i64.extend_i32_s
      (local.get $pagesAfter)
     )
     (i64.const 16)
    )
   )
  )
 )
 (func $~lib/rt/tlsf/prepareBlock (param $root i32) (param $block i32) (param $size i32)
  (local $blockInfo i32)
  (local $remaining i32)
  (local $spare i32)
  (local.set $blockInfo
   (call $~lib/rt/common/BLOCK#get:mmInfo
    (local.get $block)
   )
  )
  (drop
   (i32.const 1)
  )
  (if
   (i32.eqz
    (i32.eqz
     (i32.and
      (i32.add
       (local.get $size)
       (i32.const 4)
      )
      (i32.const 15)
     )
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 256)
     (i32.const 361)
     (i32.const 14)
    )
    (unreachable)
   )
  )
  (local.set $remaining
   (i32.sub
    (i32.and
     (local.get $blockInfo)
     (i32.xor
      (i32.const 3)
      (i32.const -1)
     )
    )
    (local.get $size)
   )
  )
  (if
   (i32.ge_u
    (local.get $remaining)
    (i32.add
     (i32.const 4)
     (i32.const 12)
    )
   )
   (then
    (call $~lib/rt/common/BLOCK#set:mmInfo
     (local.get $block)
     (i32.or
      (local.get $size)
      (i32.and
       (local.get $blockInfo)
       (i32.const 2)
      )
     )
    )
    (local.set $spare
     (i32.add
      (i32.add
       (local.get $block)
       (i32.const 4)
      )
      (local.get $size)
     )
    )
    (call $~lib/rt/common/BLOCK#set:mmInfo
     (local.get $spare)
     (i32.or
      (i32.sub
       (local.get $remaining)
       (i32.const 4)
      )
      (i32.const 1)
     )
    )
    (call $~lib/rt/tlsf/insertBlock
     (local.get $root)
     (local.get $spare)
    )
   )
   (else
    (call $~lib/rt/common/BLOCK#set:mmInfo
     (local.get $block)
     (i32.and
      (local.get $blockInfo)
      (i32.xor
       (i32.const 1)
       (i32.const -1)
      )
     )
    )
    (call $~lib/rt/common/BLOCK#set:mmInfo
     (call $~lib/rt/tlsf/GETRIGHT
      (local.get $block)
     )
     (i32.and
      (call $~lib/rt/common/BLOCK#get:mmInfo
       (call $~lib/rt/tlsf/GETRIGHT
        (local.get $block)
       )
      )
      (i32.xor
       (i32.const 2)
       (i32.const -1)
      )
     )
    )
   )
  )
 )
 (func $~lib/rt/tlsf/allocateBlock (param $root i32) (param $size i32) (result i32)
  (local $payloadSize i32)
  (local $block i32)
  (local.set $payloadSize
   (call $~lib/rt/tlsf/prepareSize
    (local.get $size)
   )
  )
  (local.set $block
   (call $~lib/rt/tlsf/searchBlock
    (local.get $root)
    (local.get $payloadSize)
   )
  )
  (if
   (i32.eqz
    (local.get $block)
   )
   (then
    (call $~lib/rt/tlsf/growMemory
     (local.get $root)
     (local.get $payloadSize)
    )
    (local.set $block
     (call $~lib/rt/tlsf/searchBlock
      (local.get $root)
      (local.get $payloadSize)
     )
    )
    (drop
     (i32.const 1)
    )
    (if
     (i32.eqz
      (local.get $block)
     )
     (then
      (call $~lib/builtins/abort
       (i32.const 0)
       (i32.const 256)
       (i32.const 499)
       (i32.const 16)
      )
      (unreachable)
     )
    )
   )
  )
  (drop
   (i32.const 1)
  )
  (if
   (i32.eqz
    (i32.ge_u
     (i32.and
      (call $~lib/rt/common/BLOCK#get:mmInfo
       (local.get $block)
      )
      (i32.xor
       (i32.const 3)
       (i32.const -1)
      )
     )
     (local.get $payloadSize)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 256)
     (i32.const 501)
     (i32.const 14)
    )
    (unreachable)
   )
  )
  (call $~lib/rt/tlsf/removeBlock
   (local.get $root)
   (local.get $block)
  )
  (call $~lib/rt/tlsf/prepareBlock
   (local.get $root)
   (local.get $block)
   (local.get $payloadSize)
  )
  (drop
   (i32.const 0)
  )
  (return
   (local.get $block)
  )
 )
 (func $~lib/rt/tlsf/__alloc (param $size i32) (result i32)
  (if
   (i32.eqz
    (global.get $~lib/rt/tlsf/ROOT)
   )
   (then
    (call $~lib/rt/tlsf/initialize)
   )
  )
  (return
   (i32.add
    (call $~lib/rt/tlsf/allocateBlock
     (global.get $~lib/rt/tlsf/ROOT)
     (local.get $size)
    )
    (i32.const 4)
   )
  )
 )
 (func $~lib/rt/tcms/Object#set:rtId (param $this i32) (param $rtId i32)
  (i32.store offset=12
   (local.get $this)
   (local.get $rtId)
  )
 )
 (func $~lib/rt/tcms/Object#set:rtSize (param $this i32) (param $rtSize i32)
  (i32.store offset=16
   (local.get $this)
   (local.get $rtSize)
  )
 )
 (func $~lib/rt/tcms/__new (param $size i32) (param $id i32) (result i32)
  (local $obj i32)
  (local $ptr i32)
  (if
   (i32.ge_u
    (local.get $size)
    (i32.const 1073741804)
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 32)
     (i32.const 96)
     (i32.const 136)
     (i32.const 31)
    )
    (unreachable)
   )
  )
  (if
   (i32.ge_u
    (global.get $~lib/rt/tcms/total)
    (global.get $~lib/rt/tcms/threshold)
   )
   (then
    (call $~lib/rt/tcms/__collect)
   )
  )
  (local.set $obj
   (i32.sub
    (call $~lib/rt/tlsf/__alloc
     (i32.add
      (i32.const 16)
      (local.get $size)
     )
    )
    (i32.const 4)
   )
  )
  (call $~lib/rt/tcms/Object#set:rtId
   (local.get $obj)
   (local.get $id)
  )
  (call $~lib/rt/tcms/Object#set:rtSize
   (local.get $obj)
   (local.get $size)
  )
  (call $~lib/rt/tcms/Object#linkTo
   (local.get $obj)
   (global.get $~lib/rt/tcms/fromSpace)
   (global.get $~lib/rt/tcms/white)
  )
  (global.set $~lib/rt/tcms/total
   (i32.add
    (global.get $~lib/rt/tcms/total)
    (call $~lib/rt/tcms/Object#get:size
     (local.get $obj)
    )
   )
  )
  (local.set $ptr
   (i32.add
    (local.get $obj)
    (i32.const 20)
   )
  )
  (memory.fill
   (local.get $ptr)
   (i32.const 0)
   (local.get $size)
  )
  (return
   (local.get $ptr)
  )
 )
 (func $~lib/object/Object#constructor (param $this i32) (result i32)
  (if
   (i32.eqz
    (local.get $this)
   )
   (then
    (local.set $this
     (call $~lib/rt/__localtostack
      (call $~lib/rt/tcms/__new
       (i32.const 0)
       (i32.const 0)
      )
     )
    )
   )
  )
  (local.get $this)
 )
 (func $~lib/rt/tcms/__link (param $parentPtr i32) (param $childPtr i32) (param $expectMultiple i32)
  (nop)
 )
 (func $~lib/array/Array<i32>#set:buffer (param $this i32) (param $buffer i32)
  (i32.store
   (local.get $this)
   (local.get $buffer)
  )
  (call $~lib/rt/tcms/__link
   (local.get $this)
   (local.get $buffer)
   (i32.const 0)
  )
 )
 (func $~lib/array/Array<i32>#set:dataStart (param $this i32) (param $dataStart i32)
  (i32.store offset=4
   (local.get $this)
   (local.get $dataStart)
  )
 )
 (func $~lib/array/Array<i32>#set:byteLength (param $this i32) (param $byteLength i32)
  (i32.store offset=8
   (local.get $this)
   (local.get $byteLength)
  )
 )
 (func $~lib/array/Array<i32>#set:length_ (param $this i32) (param $length_ i32)
  (i32.store offset=12
   (local.get $this)
   (local.get $length_)
  )
 )
 (func $~lib/array/Array<i32>#constructor (param $this i32) (param $length i32) (result i32)
  (local $2 i32)
  (local $3 i32)
  (local $bufferSize i32)
  (local $buffer i32)
  (if
   (i32.eqz
    (local.get $this)
   )
   (then
    (local.set $this
     (call $~lib/rt/__localtostack
      (call $~lib/rt/tcms/__new
       (i32.const 16)
       (i32.const 5)
      )
     )
    )
   )
  )
  (if
   (i32.gt_u
    (local.get $length)
    (i32.shr_u
     (i32.const 1073741820)
     (i32.const 2)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 320)
     (i32.const 368)
     (i32.const 70)
     (i32.const 60)
    )
    (unreachable)
   )
  )
  (local.set $bufferSize
   (i32.shl
    (select
     (local.tee $2
      (local.get $length)
     )
     (local.tee $3
      (i32.const 8)
     )
     (i32.gt_u
      (local.get $2)
      (local.get $3)
     )
    )
    (i32.const 2)
   )
  )
  (local.set $buffer
   (call $~lib/rt/__localtostack
    (call $~lib/rt/tcms/__new
     (local.get $bufferSize)
     (i32.const 1)
    )
   )
  )
  (drop
   (i32.eq
    (i32.const 1)
    (global.get $~lib/shared/runtime/Runtime.Stub)
   )
  )
  (call $~lib/array/Array<i32>#set:buffer
   (call $~lib/rt/__tmptostack
    (local.get $this)
   )
   (call $~lib/rt/__tmptostack
    (local.get $buffer)
   )
  )
  (call $~lib/array/Array<i32>#set:dataStart
   (call $~lib/rt/__tmptostack
    (local.get $this)
   )
   (local.get $buffer)
  )
  (call $~lib/array/Array<i32>#set:byteLength
   (call $~lib/rt/__tmptostack
    (local.get $this)
   )
   (local.get $bufferSize)
  )
  (call $~lib/array/Array<i32>#set:length_
   (call $~lib/rt/__tmptostack
    (local.get $this)
   )
   (local.get $length)
  )
  (local.get $this)
 )
 (func $rt/runtime-radical/RadicalObject#set:i0 (param $this i32) (param $i0 i32)
  (i32.store
   (local.get $this)
   (local.get $i0)
  )
  (call $~lib/rt/tcms/__link
   (local.get $this)
   (local.get $i0)
   (i32.const 0)
  )
 )
 (func $rt/runtime-radical/RadicalObject#set:i1 (param $this i32) (param $i1 i32)
  (i32.store offset=4
   (local.get $this)
   (local.get $i1)
  )
  (call $~lib/rt/tcms/__link
   (local.get $this)
   (local.get $i1)
   (i32.const 0)
  )
 )
 (func $rt/runtime-radical/RadicalObject#set:i2 (param $this i32) (param $i2 i32)
  (i32.store offset=8
   (local.get $this)
   (local.get $i2)
  )
  (call $~lib/rt/tcms/__link
   (local.get $this)
   (local.get $i2)
   (i32.const 0)
  )
 )
 (func $rt/runtime-radical/RadicalObject#set:i3 (param $this i32) (param $i3 i32)
  (i32.store offset=12
   (local.get $this)
   (local.get $i3)
  )
  (call $~lib/rt/tcms/__link
   (local.get $this)
   (local.get $i3)
   (i32.const 0)
  )
 )
 (func $rt/runtime-radical/RadicalObject#set:i4 (param $this i32) (param $i4 i32)
  (i32.store offset=16
   (local.get $this)
   (local.get $i4)
  )
  (call $~lib/rt/tcms/__link
   (local.get $this)
   (local.get $i4)
   (i32.const 0)
  )
 )
 (func $rt/runtime-radical/RadicalObject#set:i5 (param $this i32) (param $i5 i32)
  (i32.store offset=20
   (local.get $this)
   (local.get $i5)
  )
  (call $~lib/rt/tcms/__link
   (local.get $this)
   (local.get $i5)
   (i32.const 0)
  )
 )
 (func $rt/runtime-radical/RadicalObject#set:i6 (param $this i32) (param $i6 i32)
  (i32.store offset=24
   (local.get $this)
   (local.get $i6)
  )
  (call $~lib/rt/tcms/__link
   (local.get $this)
   (local.get $i6)
   (i32.const 0)
  )
 )
 (func $rt/runtime-radical/RadicalObject#set:i7 (param $this i32) (param $i7 i32)
  (i32.store offset=28
   (local.get $this)
   (local.get $i7)
  )
  (call $~lib/rt/tcms/__link
   (local.get $this)
   (local.get $i7)
   (i32.const 0)
  )
 )
 (func $rt/runtime-radical/RadicalObject#set:i8 (param $this i32) (param $i8 i32)
  (i32.store offset=32
   (local.get $this)
   (local.get $i8)
  )
  (call $~lib/rt/tcms/__link
   (local.get $this)
   (local.get $i8)
   (i32.const 0)
  )
 )
 (func $rt/runtime-radical/RadicalObject#set:i9 (param $this i32) (param $i9 i32)
  (i32.store offset=36
   (local.get $this)
   (local.get $i9)
  )
  (call $~lib/rt/tcms/__link
   (local.get $this)
   (local.get $i9)
   (i32.const 0)
  )
 )
 (func $rt/runtime-radical/RadicalObject#set:i10 (param $this i32) (param $i10 i32)
  (i32.store offset=40
   (local.get $this)
   (local.get $i10)
  )
  (call $~lib/rt/tcms/__link
   (local.get $this)
   (local.get $i10)
   (i32.const 0)
  )
 )
 (func $rt/runtime-radical/RadicalObject#constructor (param $this i32) (result i32)
  (if
   (i32.eqz
    (local.get $this)
   )
   (then
    (local.set $this
     (call $~lib/rt/__localtostack
      (call $~lib/rt/tcms/__new
       (i32.const 44)
       (i32.const 4)
      )
     )
    )
   )
  )
  (local.set $this
   (call $~lib/rt/__localtostack
    (call $~lib/object/Object#constructor
     (call $~lib/rt/__tmptostack
      (local.get $this)
     )
    )
   )
  )
  (call $rt/runtime-radical/RadicalObject#set:i0
   (call $~lib/rt/__tmptostack
    (local.get $this)
   )
   (call $~lib/rt/__tmptostack
    (call $~lib/array/Array<i32>#constructor
     (i32.const 0)
     (i32.const 100)
    )
   )
  )
  (call $rt/runtime-radical/RadicalObject#set:i1
   (call $~lib/rt/__tmptostack
    (local.get $this)
   )
   (call $~lib/rt/__tmptostack
    (call $~lib/array/Array<i32>#constructor
     (i32.const 0)
     (i32.const 100)
    )
   )
  )
  (call $rt/runtime-radical/RadicalObject#set:i2
   (call $~lib/rt/__tmptostack
    (local.get $this)
   )
   (call $~lib/rt/__tmptostack
    (call $~lib/array/Array<i32>#constructor
     (i32.const 0)
     (i32.const 100)
    )
   )
  )
  (call $rt/runtime-radical/RadicalObject#set:i3
   (call $~lib/rt/__tmptostack
    (local.get $this)
   )
   (call $~lib/rt/__tmptostack
    (call $~lib/array/Array<i32>#constructor
     (i32.const 0)
     (i32.const 100)
    )
   )
  )
  (call $rt/runtime-radical/RadicalObject#set:i4
   (call $~lib/rt/__tmptostack
    (local.get $this)
   )
   (call $~lib/rt/__tmptostack
    (call $~lib/array/Array<i32>#constructor
     (i32.const 0)
     (i32.const 100)
    )
   )
  )
  (call $rt/runtime-radical/RadicalObject#set:i5
   (call $~lib/rt/__tmptostack
    (local.get $this)
   )
   (call $~lib/rt/__tmptostack
    (call $~lib/array/Array<i32>#constructor
     (i32.const 0)
     (i32.const 100)
    )
   )
  )
  (call $rt/runtime-radical/RadicalObject#set:i6
   (call $~lib/rt/__tmptostack
    (local.get $this)
   )
   (call $~lib/rt/__tmptostack
    (call $~lib/array/Array<i32>#constructor
     (i32.const 0)
     (i32.const 100)
    )
   )
  )
  (call $rt/runtime-radical/RadicalObject#set:i7
   (call $~lib/rt/__tmptostack
    (local.get $this)
   )
   (call $~lib/rt/__tmptostack
    (call $~lib/array/Array<i32>#constructor
     (i32.const 0)
     (i32.const 100)
    )
   )
  )
  (call $rt/runtime-radical/RadicalObject#set:i8
   (call $~lib/rt/__tmptostack
    (local.get $this)
   )
   (call $~lib/rt/__tmptostack
    (call $~lib/array/Array<i32>#constructor
     (i32.const 0)
     (i32.const 100)
    )
   )
  )
  (call $rt/runtime-radical/RadicalObject#set:i9
   (call $~lib/rt/__tmptostack
    (local.get $this)
   )
   (call $~lib/rt/__tmptostack
    (call $~lib/array/Array<i32>#constructor
     (i32.const 0)
     (i32.const 100)
    )
   )
  )
  (call $rt/runtime-radical/RadicalObject#set:i10
   (call $~lib/rt/__tmptostack
    (local.get $this)
   )
   (call $~lib/rt/__tmptostack
    (call $~lib/array/Array<i32>#constructor
     (i32.const 0)
     (i32.const 100)
    )
   )
  )
  (local.get $this)
 )
 (func $start:rt/runtime-radical
  (local $i i32)
  (global.set $~lib/rt/tcms/threshold
   (i32.shr_u
    (i32.sub
     (i32.shl
      (memory.size)
      (i32.const 16)
     )
     (global.get $~lib/memory/__heap_base)
    )
    (i32.const 1)
   )
  )
  (global.set $~lib/rt/tcms/toSpace
   (call $~lib/rt/tcms/initLazy
    (i32.const 144)
   )
  )
  (global.set $~lib/rt/tcms/pinSpace
   (call $~lib/rt/tcms/initLazy
    (i32.const 176)
   )
  )
  (global.set $~lib/rt/tcms/fromSpace
   (call $~lib/rt/tcms/initLazy
    (i32.const 208)
   )
  )
  (block
   (local.set $i
    (i32.const 0)
   )
   (loop $for-loop|0
    (if
     (i32.lt_s
      (local.get $i)
      (i32.const 10)
     )
     (then
      (drop
       (call $rt/runtime-radical/RadicalObject#constructor
        (i32.const 0)
       )
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
 )
 (func $~lib/rt/tcms/__pin (param $ptr i32) (result i32)
  (local $obj i32)
  (if
   (local.get $ptr)
   (then
    (local.set $obj
     (i32.sub
      (local.get $ptr)
      (i32.const 20)
     )
    )
    (if
     (i32.eq
      (call $~lib/rt/tcms/Object#get:color
       (local.get $obj)
      )
      (i32.const 3)
     )
     (then
      (call $~lib/builtins/abort
       (i32.const 416)
       (i32.const 96)
       (i32.const 189)
       (i32.const 7)
      )
      (unreachable)
     )
    )
    (call $~lib/rt/tcms/Object#unlink
     (local.get $obj)
    )
    (call $~lib/rt/tcms/Object#linkTo
     (local.get $obj)
     (global.get $~lib/rt/tcms/pinSpace)
     (i32.const 3)
    )
   )
  )
  (return
   (local.get $ptr)
  )
 )
 (func $~lib/rt/tcms/__unpin (param $ptr i32)
  (local $obj i32)
  (if
   (i32.eqz
    (local.get $ptr)
   )
   (then
    (return)
   )
  )
  (local.set $obj
   (i32.sub
    (local.get $ptr)
    (i32.const 20)
   )
  )
  (if
   (i32.ne
    (call $~lib/rt/tcms/Object#get:color
     (local.get $obj)
    )
    (i32.const 3)
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 480)
     (i32.const 96)
     (i32.const 203)
     (i32.const 5)
    )
    (unreachable)
   )
  )
  (call $~lib/rt/tcms/Object#unlink
   (local.get $obj)
  )
  (call $~lib/rt/tcms/Object#linkTo
   (local.get $obj)
   (global.get $~lib/rt/tcms/fromSpace)
   (global.get $~lib/rt/tcms/white)
  )
 )
 (func $~lib/rt/__visit_globals (param $0 i32)
  (local $1 i32)
  (nop)
 )
 (func $~lib/arraybuffer/ArrayBufferView~visit (param $0 i32) (param $1 i32)
  (local $2 i32)
  (call $~lib/object/Object~visit
   (local.get $0)
   (local.get $1)
  )
  (call $~lib/rt/tcms/__visit
   (i32.load
    (local.get $0)
   )
   (local.get $1)
  )
 )
 (func $~lib/object/Object~visit (param $0 i32) (param $1 i32)
  (nop)
 )
 (func $rt/runtime-radical/RadicalObject~visit (param $0 i32) (param $1 i32)
  (local $2 i32)
  (call $~lib/object/Object~visit
   (local.get $0)
   (local.get $1)
  )
  (call $~lib/rt/tcms/__visit
   (i32.load
    (local.get $0)
   )
   (local.get $1)
  )
  (call $~lib/rt/tcms/__visit
   (i32.load offset=4
    (local.get $0)
   )
   (local.get $1)
  )
  (call $~lib/rt/tcms/__visit
   (i32.load offset=8
    (local.get $0)
   )
   (local.get $1)
  )
  (call $~lib/rt/tcms/__visit
   (i32.load offset=12
    (local.get $0)
   )
   (local.get $1)
  )
  (call $~lib/rt/tcms/__visit
   (i32.load offset=16
    (local.get $0)
   )
   (local.get $1)
  )
  (call $~lib/rt/tcms/__visit
   (i32.load offset=20
    (local.get $0)
   )
   (local.get $1)
  )
  (call $~lib/rt/tcms/__visit
   (i32.load offset=24
    (local.get $0)
   )
   (local.get $1)
  )
  (call $~lib/rt/tcms/__visit
   (i32.load offset=28
    (local.get $0)
   )
   (local.get $1)
  )
  (call $~lib/rt/tcms/__visit
   (i32.load offset=32
    (local.get $0)
   )
   (local.get $1)
  )
  (call $~lib/rt/tcms/__visit
   (i32.load offset=36
    (local.get $0)
   )
   (local.get $1)
  )
  (call $~lib/rt/tcms/__visit
   (i32.load offset=40
    (local.get $0)
   )
   (local.get $1)
  )
 )
 (func $~lib/array/Array<i32>#get:buffer (param $this i32) (result i32)
  (i32.load
   (local.get $this)
  )
 )
 (func $~lib/array/Array<i32>#__visit (param $this i32) (param $cookie i32)
  (drop
   (i32.const 0)
  )
  (call $~lib/rt/tcms/__visit
   (call $~lib/array/Array<i32>#get:buffer
    (call $~lib/rt/__tmptostack
     (local.get $this)
    )
   )
   (local.get $cookie)
  )
 )
 (func $~lib/array/Array<i32>~visit (param $0 i32) (param $1 i32)
  (call $~lib/object/Object~visit
   (local.get $0)
   (local.get $1)
  )
  (call $~lib/array/Array<i32>#__visit
   (local.get $0)
   (local.get $1)
  )
 )
 (func $~lib/rt/__visit_members (param $0 i32) (param $1 i32)
  (block $invalid
   (block $~lib/array/Array<i32>
    (block $rt/runtime-radical/RadicalObject
     (block $~lib/arraybuffer/ArrayBufferView
      (block $~lib/string/String
       (block $~lib/arraybuffer/ArrayBuffer
        (block $~lib/object/Object
         (br_table $~lib/object/Object $~lib/arraybuffer/ArrayBuffer $~lib/string/String $~lib/arraybuffer/ArrayBufferView $rt/runtime-radical/RadicalObject $~lib/array/Array<i32> $invalid
          (i32.load
           (i32.sub
            (local.get $0)
            (i32.const 8)
           )
          )
         )
        )
        (return)
       )
       (return)
      )
      (return)
     )
     (block
      (call $~lib/arraybuffer/ArrayBufferView~visit
       (local.get $0)
       (local.get $1)
      )
      (return)
     )
    )
    (block
     (call $rt/runtime-radical/RadicalObject~visit
      (local.get $0)
      (local.get $1)
     )
     (return)
    )
   )
   (block
    (call $~lib/array/Array<i32>~visit
     (local.get $0)
     (local.get $1)
    )
    (return)
   )
  )
  (unreachable)
 )
 (func $~start
  (call $start:rt/runtime-radical)
 )
)
