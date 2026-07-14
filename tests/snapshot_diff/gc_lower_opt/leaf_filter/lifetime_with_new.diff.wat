;; ====================
(func $tests/snapshot_diff/gc_lower_opt/leaf_filter/lifetime_with_new/_start (result i32))
  (local i32)
  (local i32)
  (local i32)
  block ;;i32
;; ======remove=======
;;    i32.const 12
;; =========add========
      i32.const 4
;; ====================
    call $~lib/rt/__decrease_sp
      block ;;unreachable
          block ;;i32
;; ======remove=======
;;              block ;;i32
;; ====================
                  i32.const 4
                  i32.const 4
                call $~lib/rt/itcms/__new
;; =========add========
              call $tests/snapshot_diff/common_lib/normal/Normal#constructor
;; ====================
            local.set $2
              global.get $~lib/memory/__stack_pointer
              local.get $2
            i32.store $0 align=1
            local.get $2
          end
;; ======remove=======
;;            call $tests/snapshot_diff/common_lib/normal/Normal#constructor
;;          local.set $2
;;            global.get $~lib/memory/__stack_pointer
;;            local.get $2
;;          i32.store $0 offset=4 align=1
;;          local.get $2
;;        end
;; ====================
        local.set $0
;; ======remove=======
;;          block ;;i32
;; ====================
              i32.const 4
              i32.const 4
            call $~lib/rt/itcms/__new
;; ======remove=======
;;            local.set $2
;;              global.get $~lib/memory/__stack_pointer
;;              local.get $2
;;            i32.store $0 offset=8 align=1
;;            local.get $2
;;          end
;; ====================
          call $tests/snapshot_diff/common_lib/normal/Normal#constructor
        drop
        block ;;unreachable
            local.get $0
          local.set $1
;; ======remove=======
;;          i32.const 12
;; =========add========
            i32.const 4
;; ====================
          call $~lib/rt/__increase_sp
            local.get $1
          return
        end
      end
    local.set $1
;; ======remove=======
;;    i32.const 12
;; =========add========
      i32.const 4
;; ====================
    call $~lib/rt/__increase_sp
    local.get $1
  end
)
