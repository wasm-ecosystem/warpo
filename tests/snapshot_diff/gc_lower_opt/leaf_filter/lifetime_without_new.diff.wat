;; ====================
(func $tests/snapshot_diff/gc_lower_opt/leaf_filter/lifetime_without_new/_start (result i32))
  (local i32)
;; ======remove=======
;;(local i32)
;;(local i32)
;;block ;;i32
;;    i32.const 4
;;  call $~lib/rt/__decrease_sp
;; ====================
  block ;;unreachable
;; ======remove=======
;;        block ;;i32
;; ====================
        i32.const 0
      call $tests/snapshot_diff/common_lib/normal/Normal#constructor
;; ======remove=======
;;          local.set $2
;;            global.get $~lib/memory/__stack_pointer
;;            local.get $2
;;          i32.store $0 align=1
;;          local.get $2
;;        end
;; ====================
    local.set $0
;; ======remove=======
;;      block ;;unreachable
;; ====================
      local.get $0
;; ======remove=======
;;        local.set $1
;;          i32.const 4
;;        call $~lib/rt/__increase_sp
;;          local.get $1
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
