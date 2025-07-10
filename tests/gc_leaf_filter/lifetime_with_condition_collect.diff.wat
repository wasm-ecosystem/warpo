;; ====================
(func $tests/gc_leaf_filter/lifetime_with_condition_collect/foo_true (type $func.0 (func (result i32)))
  (local i32)
  (local i32)
  block ;;i32
      i32.const 4
    call $~lib/rt/__decrease_sp
      block ;;unreachable
              i32.const 0
            call $tests/common_lib/normal/Normal#constructor
          call $~lib/rt/__tostack<0>
        local.set $0
        if ;;none
          global.get $tests/gc_leaf_filter/lifetime_with_condition_collect/v
          call $~lib/rt/itcms/__collect
        end
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
(func $tests/gc_leaf_filter/lifetime_with_condition_collect/foo_false (type $func.0 (func (result i32)))
  (local i32)
  (local i32)
  block ;;i32
      i32.const 4
    call $~lib/rt/__decrease_sp
      block ;;unreachable
              i32.const 0
            call $tests/common_lib/normal/Normal#constructor
          call $~lib/rt/__tostack<0>
        local.set $0
        if ;;none
            global.get $tests/gc_leaf_filter/lifetime_with_condition_collect/v
          i32.eqz
          call $~lib/rt/itcms/__collect
        end
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
(func $tests/gc_leaf_filter/lifetime_with_condition_collect/foo_other_branch (type $func.0 (func (result i32)))
  (local i32)
;; ======remove=======
;;(local i32)
;;block ;;i32
;;    i32.const 4
;;  call $~lib/rt/__decrease_sp
;; ====================
  block ;;unreachable
        i32.const 0
      call $tests/common_lib/normal/Normal#constructor
;; ======remove=======
;;        call $~lib/rt/__tostack<0>
;; ====================
    local.set $0
    if ;;none
      global.get $tests/gc_leaf_filter/lifetime_with_condition_collect/v
;; ======remove=======
;;        block ;;unreachable
;; ====================
        local.get $0
;; ======remove=======
;;          local.set $1
;;            i32.const 4
;;          call $~lib/rt/__increase_sp
;;            local.get $1
;; ====================
      return
;; ======remove=======
;;        end
;; ====================
      call $~lib/rt/itcms/__collect
    end
;; ======remove=======
;;      block ;;unreachable
;; ====================
      i32.const 0
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
