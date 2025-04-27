;; ====================
(module
;; ======remove=======
;; (type $0 (func (param i32) (result i32)))
;; (import "as-builtin-fn" "~lib/rt/__localtostack" (func $~lib/rt/__localtostack (param i32) (result i32)))
;; (import "as-builtin-fn" "~lib/rt/__tmptostack" (func $~lib/rt/__tmptostack (param i32) (result i32)))
;; =========add========
 (type $1 (func (param i32)))
 (type $2 (func (param i32 i32) (result i32)))
;; ====================
 (global $~lib/memory/__data_end i32 (i32.const 8))
 (global $~lib/memory/__stack_pointer (mut i32) (i32.const 32776))
 (global $~lib/memory/__heap_base i32 (i32.const 32776))
 (memory $0 0)
 (table $0 1 1 funcref)
 (elem $0 (i32.const 1))
 (export "memory" (memory $0))
;; =========add========
 (func $~lib/rt/__decrease_sp (param $0 i32)
  global.get $~lib/memory/__stack_pointer
  local.get $0
  i32.sub
  global.set $~lib/memory/__stack_pointer
  global.get $~lib/memory/__stack_pointer
  i32.const 0
  local.get $0
  memory.fill
  global.get $~lib/memory/__stack_pointer
  global.get $~lib/memory/__data_end
  i32.lt_s
  if
   unreachable
  end
;; ====================
 )
;; =========add========
 (func $~lib/rt/__increase_sp (param $0 i32)
  global.get $~lib/memory/__stack_pointer
  local.get $0
  i32.add
  global.set $~lib/memory/__stack_pointer
 )
 (func $~lib/rt/__tostack (param $0 i32) (param $1 i32) (result i32)
  global.get $~lib/memory/__stack_pointer
  local.get $1
  i32.add
  local.get $0
  i32.store align=1
  local.get $0
 )
)
