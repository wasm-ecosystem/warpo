;; ====================
(func $tests/snapshot_diff/gc_lower_opt/base/new_obj_with_conditional_use/_start (result i32))
  (local i32)
;; =========add========
  (local i32)
  (local i32)
;; ====================
  block ;;i32
;; =========add========
      i32.const 4
    call $~lib/rt/__decrease_sp
      block ;;unreachable
          block ;;i32
;; ====================
                i32.const 0
              call $tests/snapshot_diff/common_lib/normal/Normal#constructor
;; ======remove=======
;;    call $~lib/rt/__localtostack
;; =========add========
            local.set $2
              global.get $~lib/memory/__stack_pointer
              local.get $2
            i32.store $0 align=1
            local.get $2
          end
;; ====================
        local.set $0
        if ;;unreachable
          global.get $tests/snapshot_diff/gc_lower_opt/base/new_obj_with_conditional_use/v
;; =========add========
          block ;;unreachable
;; ====================
              local.get $0
;; =========add========
            local.set $1
              i32.const 4
            call $~lib/rt/__increase_sp
              local.get $1
;; ====================
            return
;; =========add========
          end
          block ;;unreachable
;; ====================
              i32.const 0
;; =========add========
            local.set $1
              i32.const 4
            call $~lib/rt/__increase_sp
              local.get $1
;; ====================
            return
          end
        end
;; =========add========
      end
    local.tee $1
      i32.const 4
    call $~lib/rt/__increase_sp
    local.get $1
  end
;; ====================
)
