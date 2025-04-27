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
            i32.const 0
          call $~lib/rt/__tostack
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
            i32.const 0
          call $~lib/rt/__tostack
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
  (local i32)
  block ;;i32
      i32.const 4
    call $~lib/rt/__decrease_sp
      block ;;unreachable
              i32.const 0
            call $tests/common_lib/normal/Normal#constructor
            i32.const 0
          call $~lib/rt/__tostack
        local.set $0
        if ;;none
          global.get $tests/gc_leaf_filter/lifetime_with_condition_collect/v
          block ;;unreachable
              local.get $0
            local.set $1
              i32.const 4
            call $~lib/rt/__increase_sp
              local.get $1
            return
          end
          call $~lib/rt/itcms/__collect
        end
        block ;;unreachable
            i32.const 0
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
