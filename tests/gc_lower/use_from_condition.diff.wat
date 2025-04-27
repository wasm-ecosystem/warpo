;; ====================
(func $tests/gc_lower/use_from_condition/_start (type $func.0 (func (result i32)))
  (local i32)
;; =========add========
  (local i32)
  block ;;i32
      i32.const 8
    call $~lib/rt/__decrease_sp
;; ====================
      block ;;unreachable
        if ;;none
          global.get $tests/gc_lower/use_from_condition/v
                i32.const 0
              call $tests/common_lib/normal/Normal#constructor
;; ======remove=======
;;      call $~lib/rt/__localtostack
;; =========add========
              i32.const 0
            call $~lib/rt/__tostack
;; ====================
          local.set $0
                i32.const 0
              call $tests/common_lib/normal/Normal#constructor
;; ======remove=======
;;      call $~lib/rt/__localtostack
;; =========add========
              i32.const 4
            call $~lib/rt/__tostack
;; ====================
          local.set $0
        end
;; =========add========
        block ;;unreachable
;; ====================
            local.get $0
;; =========add========
          local.set $1
            i32.const 8
          call $~lib/rt/__increase_sp
            local.get $1
;; ====================
          return
        end
;; =========add========
      end
    local.tee $1
      i32.const 8
    call $~lib/rt/__increase_sp
    local.get $1
  end
;; ====================
)
