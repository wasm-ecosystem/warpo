;; ====================
(func $tests/snapshot_diff/gc_lower_opt/base/new_obj_with_loop_use/_start)
  (local i32)
  (local i32)
;; =========add========
  (local i32)
;; ====================
  block ;;none
;; =========add========
      i32.const 8
    call $~lib/rt/__decrease_sp
    block ;;none
        block ;;i32
            global.get $~lib/memory/__stack_pointer
;; ====================
            i32.const 0
;; ======remove=======
;;    call $~lib/rt/__localtostack
;; =========add========
          i32.store $0 align=1
          i32.const 0
        end
;; ====================
      local.set $0
;; ======remove=======
;;  block ;;none
;; ====================
      loop ;;none
        if ;;none
          global.get $tests/snapshot_diff/gc_lower_opt/base/new_obj_with_loop_use/v
          block ;;unreachable
                local.get $0
                i32.const 0
              i32.eq
            local.set $1
;; =========add========
              block ;;i32
;; ====================
                    i32.const 0
                  call $tests/snapshot_diff/common_lib/normal/Normal#constructor
;; ======remove=======
;;            call $~lib/rt/__localtostack
;; =========add========
                local.set $2
                  global.get $~lib/memory/__stack_pointer
                  local.get $2
                i32.store $0 offset=4 align=1
                local.get $2
              end
;; ====================
            local.set $0
            br $while-continue|0
          end
        end
      end
    end
;; =========add========
      i32.const 8
    call $~lib/rt/__increase_sp
;; ====================
  end
)
