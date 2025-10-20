;; ======remove=======
;;(func $~lib/rt/__localtostack (param i32) (result i32))
;; =========add========
(func $~lib/rt/__localtostack (param i32 i32) (result i32))
  block ;;i32
        global.get $~lib/memory/__stack_pointer
        local.get $1
      i32.add
      local.get $0
    i32.store $0 align=1
    local.get $0
  end
;; ====================
)
;; ======remove=======
;;(func $~lib/rt/__tmptostack (param i32) (result i32))
;; =========add========
(func $~lib/rt/__tmptostack (param i32 i32) (result i32))
  block ;;i32
        global.get $~lib/memory/__stack_pointer
        local.get $1
      i32.add
      local.get $0
    i32.store $0 align=1
    local.get $0
  end
;; ====================
)
;; =========add========
(func $~lib/rt/__decrease_sp (param i32))
  block ;;none
        global.get $~lib/memory/__stack_pointer
        local.get $0
      i32.sub
    global.set $~lib/memory/__stack_pointer
      global.get $~lib/memory/__stack_pointer
      i32.const 0
      local.get $0
    memory.fill $0
    if ;;none
        global.get $~lib/memory/__stack_pointer
        global.get $~lib/memory/__data_end
      i32.lt_s
      unreachable
    end
  end
)
(func $~lib/rt/__increase_sp (param i32))
  block ;;none
        global.get $~lib/memory/__stack_pointer
        local.get $0
      i32.add
    global.set $~lib/memory/__stack_pointer
  end
)
