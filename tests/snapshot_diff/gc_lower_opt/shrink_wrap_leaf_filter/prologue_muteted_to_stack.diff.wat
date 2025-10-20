;; ====================
(func $tests/snapshot_diff/gc_lower_opt/shrink_wrap_leaf_filter/prologue_muteted_to_stack/_start (result i32))
  (local i32)
  (local i32)
  (local i32)
;; =========add========
  (local i32)
;; ====================
  block ;;i32
;; ======remove=======
;;    i32.const 4
;;  call $~lib/rt/__decrease_sp
;; ====================
      block ;;unreachable
;; =========add========
          block ;;i32
;; ====================
              if ;;i32
                global.get $tests/snapshot_diff/gc_lower_opt/shrink_wrap_leaf_filter/prologue_muteted_to_stack/a
                global.get $tests/snapshot_diff/gc_lower_opt/shrink_wrap_leaf_filter/prologue_muteted_to_stack/v0
                global.get $tests/snapshot_diff/gc_lower_opt/shrink_wrap_leaf_filter/prologue_muteted_to_stack/v1
              end
;; =========add========
            local.set $2
              i32.const 4
            call $~lib/rt/__decrease_sp
            local.get $2
          end
;; ====================
        call $tests/snapshot_diff/gc_lower_opt/shrink_wrap_leaf_filter/prologue_muteted_to_stack/foo
          block ;;i32
                i32.const 0
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
            i32.const 0
          call $tests/snapshot_diff/common_lib/normal/Normal#constructor
        drop
        block ;;unreachable
            local.get $0
          local.set $1
            i32.const 4
          call $~lib/rt/__increase_sp
            local.get $1
          return
        end
      end
    local.tee $1
      i32.const 4
    call $~lib/rt/__increase_sp
    local.get $1
  end
)
