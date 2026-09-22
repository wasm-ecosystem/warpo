;; ====================
(func $tests/snapshot_diff/gc_lower_opt/base/void_conditional_return/_start)
  (local i32)
;; =========add========
  (local i32)
;; ====================
  block ;;none
;; =========add========
      i32.const 12
    call $~lib/rt/__decrease_sp
    block ;;none
        block ;;i32
              block ;;i32
;; ====================
                    i32.const 4
                    i32.const 4
                  call $~lib/rt/itcms/__new
;; ======remove=======
;;        call $~lib/rt/__tmptostack
;; =========add========
                local.set $1
                  global.get $~lib/memory/__stack_pointer
                  local.get $1
                i32.store $0 align=1
                local.get $1
              end
;; ====================
            call $tests/snapshot_diff/common_lib/normal/Normal#constructor
;; ======remove=======
;;    call $~lib/rt/__localtostack
;; =========add========
          local.set $1
            global.get $~lib/memory/__stack_pointer
            local.get $1
          i32.store $0 offset=4 align=1
          local.get $1
        end
;; ====================
      local.set $0
;; ======remove=======
;;  if ;;none
;; ====================
        global.get $tests/snapshot_diff/gc_lower_opt/base/void_conditional_return/shouldReturn
;; ======remove=======
;;    return
;;  end
;; =========add========
      br_if $CONDITION_RETURN#0
        block ;;i32
            global.get $~lib/memory/__stack_pointer
;; ====================
            local.get $0
;; ======remove=======
;;    call $~lib/rt/__tmptostack
;; =========add========
          i32.store $0 offset=8 align=1
          local.get $0
        end
;; ====================
      call $tests/snapshot_diff/gc_lower_opt/base/void_conditional_return/use
    end
;; =========add========
      i32.const 12
    call $~lib/rt/__increase_sp
  end
;; ====================
)
