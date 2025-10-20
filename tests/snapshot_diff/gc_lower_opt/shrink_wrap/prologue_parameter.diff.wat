;; ====================
(func $tests/snapshot_diff/gc_lower_opt/shrink_wrap/prologue_parameter/_start (param i32) (result i32))
  (local i32)
  (local i32)
;; ======remove=======
;;block ;;i32
;;    i32.const 4
;;  call $~lib/rt/__decrease_sp
;; =========add========
  (local i32)
;; ====================
  block ;;unreachable
    if ;;none
        local.get $0
        i32.const 0
      i32.eq
;; ======remove=======
;;        block ;;unreachable
;; ====================
        i32.const 0
;; ======remove=======
;;          local.set $1
;;            i32.const 4
;;          call $~lib/rt/__increase_sp
;;            local.get $1
;; ====================
      return
    end
;; ======remove=======
;;      end
;; ====================
      block ;;i32
;; =========add========
            block ;;i32
                i32.const 4
              call $~lib/rt/__decrease_sp
;; ====================
              i32.const 0
;; =========add========
            end
;; ====================
          call $tests/snapshot_diff/common_lib/normal/Normal#constructor
;; ======remove=======
;;          local.set $2
;; =========add========
        local.set $3
;; ====================
          global.get $~lib/memory/__stack_pointer
;; ======remove=======
;;            local.get $2
;; =========add========
          local.get $3
;; ====================
        i32.store $0 align=1
;; ======remove=======
;;          local.get $2
;; =========add========
        local.get $3
;; ====================
      end
    local.set $0
;; ======remove=======
;;      block ;;unreachable
;; =========add========
      block ;;i32
;; ====================
          local.get $0
;; ======remove=======
;;        local.set $1
;; =========add========
        local.set $2
;; ====================
          i32.const 4
        call $~lib/rt/__increase_sp
;; ======remove=======
;;          local.get $1
;; =========add========
        local.get $2
      end
;; ====================
    return
  end
;; ======remove=======
;;    end
;;  local.tee $1
;;    i32.const 4
;;  call $~lib/rt/__increase_sp
;;  local.get $1
;;end
;; ====================
)
