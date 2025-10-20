;; ====================
(func $tests/snapshot_diff/gc_lower_fast/normal/_start (result i32))
  (local i32)
;; =========add========
  (local i32)
;; ====================
  block ;;i32
;; =========add========
      i32.const 4
    call $~lib/rt/__decrease_sp
      block ;;i32
;; ====================
              i32.const 0
            call $tests/snapshot_diff/common_lib/normal/Normal#constructor
;; =========add========
            i32.const 0
;; ====================
          call $~lib/rt/__localtostack
        local.set $0
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
        end
;; =========add========
      end
    local.set $1
      i32.const 4
    call $~lib/rt/__increase_sp
    local.get $1
  end
;; ====================
)
