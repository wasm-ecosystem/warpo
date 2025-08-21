(func $assemblyscript/src/compiler/Compiler#compileExpression (type $func.0 (func (param i32 i32 i32 i32) (result i32)))
  (local i32)
  (local i32)
  (local i32)
  (local i32)
  (local i32)
  (local i32)
  (local i32)
  (local i32)
  (local i32)
  (local i32)
  (local i32)
  (local i32)
  (local i32)
  (local i32)
  (local i32)
  (local i32)
  (local i32)
  (local i32)
  (local i32)
  (local i32)
  (local i32)
  (local i32)
  block ;;i32
      block ;;unreachable
        loop ;;none
          if ;;none
                block ;;i32
                    i32.const 28
                  call $~lib/rt/__decrease_sp
                  local.get $1
                end
              call $assemblyscript/src/ast/Node#get:kind
              i32.const 20
            i32.eq
            block ;;unreachable
                    if ;;i32
                          local.get $1
                        local.tee $4
                      call $~instanceof|assemblyscript/src/ast/ParenthesizedExpression
                      local.get $4
                      block ;;unreachable
                          i32.const 98016
                          i32.const 98080
                          i32.const 3370
                          i32.const 46
                        call $~lib/builtins/abort
                        unreachable
                      end
                    end
                  call $assemblyscript/src/ast/ParenthesizedExpression#get:expression
                call $~lib/rt/__tostack<4>
              local.set $1
              br $while-continue|0
            end
          end
        end
          local.get $0
          local.get $2
        call $assemblyscript/src/compiler/Compiler#set:currentType
        if ;;none
            local.get $2
            global.get $assemblyscript/src/types/Type.void
          i32.eq
              local.get $3
              i32.const 8
            i32.or
          local.set $3
        end
            local.get $1
          call $assemblyscript/src/ast/Node#get:kind
        local.set $6
        block ;;none
          block ;;none
            block ;;none
              block ;;none
                block ;;none
                  block ;;none
                    block ;;none
                      block ;;none
                        block ;;none
                          block ;;none
                            block ;;none
                              block ;;none
                                block ;;none
                                  block ;;none
                                    block ;;none
                                      block ;;none
                                        block ;;none
                                          block ;;none
                                            block ;;none
                                              block ;;none
                                                block ;;none
                                                  block ;;none
                                                    block ;;none
                                                          local.get $6
                                                          i32.const 7
                                                        i32.eq
                                                      br_if $case0|1
                                                          local.get $6
                                                          i32.const 8
                                                        i32.eq
                                                      br_if $case1|1
                                                          local.get $6
                                                          i32.const 9
                                                        i32.eq
                                                      br_if $case2|1
                                                          local.get $6
                                                          i32.const 11
                                                        i32.eq
                                                      br_if $case3|1
                                                          local.get $6
                                                          i32.const 12
                                                        i32.eq
                                                      br_if $case4|1
                                                          local.get $6
                                                          i32.const 14
                                                        i32.eq
                                                      br_if $case5|1
                                                          local.get $6
                                                          i32.const 6
                                                        i32.eq
                                                      br_if $case6|1
                                                          local.get $6
                                                          i32.const 13
                                                        i32.eq
                                                      br_if $case7|1
                                                          local.get $6
                                                          i32.const 18
                                                        i32.eq
                                                      br_if $case8|1
                                                          local.get $6
                                                          i32.const 24
                                                        i32.eq
                                                      br_if $case9|1
                                                          local.get $6
                                                          i32.const 23
                                                        i32.eq
                                                      br_if $case10|1
                                                          local.get $6
                                                          i32.const 25
                                                        i32.eq
                                                      br_if $case11|1
                                                          local.get $6
                                                          i32.const 15
                                                        i32.eq
                                                      br_if $case12|1
                                                          local.get $6
                                                          i32.const 16
                                                        i32.eq
                                                      br_if $case13|1
                                                          local.get $6
                                                          i32.const 17
                                                        i32.eq
                                                      br_if $case14|1
                                                          local.get $6
                                                          i32.const 21
                                                        i32.eq
                                                      br_if $case15|1
                                                          local.get $6
                                                          i32.const 22
                                                        i32.eq
                                                      br_if $case16|1
                                                          local.get $6
                                                          i32.const 27
                                                        i32.eq
                                                      br_if $case17|1
                                                          local.get $6
                                                          i32.const 28
                                                        i32.eq
                                                      br_if $case18|1
                                                          local.get $6
                                                          i32.const 29
                                                        i32.eq
                                                      br_if $case19|1
                                                          local.get $6
                                                          i32.const 10
                                                        i32.eq
                                                      br_if $case20|1
                                                      br $case21|1
                                                    end
                                                        local.get $0
                                                          if ;;i32
                                                                local.get $1
                                                              local.tee $7
                                                            call $~instanceof|assemblyscript/src/ast/AssertionExpression
                                                            local.get $7
                                                            block ;;unreachable
                                                                i32.const 98016
                                                                i32.const 98080
                                                                i32.const 3377
                                                                i32.const 69
                                                              call $~lib/builtins/abort
                                                              unreachable
                                                            end
                                                          end
                                                        call $~lib/rt/__tostack<20>
                                                        local.get $2
                                                        local.get $3
                                                      call $assemblyscript/src/compiler/Compiler#compileAssertionExpression
                                                    local.set $5
                                                    br $break|1
                                                  end
                                                      local.get $0
                                                        if ;;i32
                                                              local.get $1
                                                            local.tee $8
                                                          call $~instanceof|assemblyscript/src/ast/BinaryExpression
                                                          local.get $8
                                                          block ;;unreachable
                                                              i32.const 98016
                                                              i32.const 98080
                                                              i32.const 3381
                                                              i32.const 63
                                                            call $~lib/builtins/abort
                                                            unreachable
                                                          end
                                                        end
                                                      call $~lib/rt/__tostack<20>
                                                      local.get $2
                                                      local.get $3
                                                    call $assemblyscript/src/compiler/Compiler#compileBinaryExpression
                                                  local.set $5
                                                  br $break|1
                                                end
                                                    local.get $0
                                                      if ;;i32
                                                            local.get $1
                                                          local.tee $9
                                                        call $~instanceof|assemblyscript/src/ast/CallExpression
                                                        local.get $9
                                                        block ;;unreachable
                                                            i32.const 98016
                                                            i32.const 98080
                                                            i32.const 3385
                                                            i32.const 59
                                                          call $~lib/builtins/abort
                                                          unreachable
                                                        end
                                                      end
                                                    call $~lib/rt/__tostack<20>
                                                    local.get $2
                                                    local.get $3
                                                  call $assemblyscript/src/compiler/Compiler#compileCallExpression
                                                local.set $5
                                                br $break|1
                                              end
                                                  local.get $0
                                                    if ;;i32
                                                          local.get $1
                                                        local.tee $10
                                                      call $~instanceof|assemblyscript/src/ast/CommaExpression
                                                      local.get $10
                                                      block ;;unreachable
                                                          i32.const 98016
                                                          i32.const 98080
                                                          i32.const 3389
                                                          i32.const 61
                                                        call $~lib/builtins/abort
                                                        unreachable
                                                      end
                                                    end
                                                  call $~lib/rt/__tostack<20>
                                                  local.get $2
                                                  local.get $3
                                                call $assemblyscript/src/compiler/Compiler#compileCommaExpression
                                              local.set $5
                                              br $break|1
                                            end
                                                local.get $0
                                                  if ;;i32
                                                        local.get $1
                                                      local.tee $11
                                                    call $~instanceof|assemblyscript/src/ast/ElementAccessExpression
                                                    local.get $11
                                                    block ;;unreachable
                                                        i32.const 98016
                                                        i32.const 98080
                                                        i32.const 3393
                                                        i32.const 77
                                                      call $~lib/builtins/abort
                                                      unreachable
                                                    end
                                                  end
                                                call $~lib/rt/__tostack<20>
                                                local.get $2
                                                local.get $3
                                              call $assemblyscript/src/compiler/Compiler#compileElementAccessExpression
                                            local.set $5
                                            br $break|1
                                          end
                                              local.get $0
                                                if ;;i32
                                                      local.get $1
                                                    local.tee $12
                                                  call $~instanceof|assemblyscript/src/ast/FunctionExpression
                                                  local.get $12
                                                  block ;;unreachable
                                                      i32.const 98016
                                                      i32.const 98080
                                                      i32.const 3397
                                                      i32.const 67
                                                    call $~lib/builtins/abort
                                                    unreachable
                                                  end
                                                end
                                              call $~lib/rt/__tostack<20>
                                              local.get $2
                                              local.get $3
                                            call $assemblyscript/src/compiler/Compiler#compileFunctionExpression
                                          local.set $5
                                          br $break|1
                                        end
                                      end
                                    end
                                  end
                                end
                              end
                                  local.get $0
                                    if ;;i32
                                          local.get $1
                                        local.tee $13
                                      call $~instanceof|assemblyscript/src/ast/IdentifierExpression
                                      local.get $13
                                      block ;;unreachable
                                          i32.const 98016
                                          i32.const 98080
                                          i32.const 3406
                                          i32.const 71
                                        call $~lib/builtins/abort
                                        unreachable
                                      end
                                    end
                                  call $~lib/rt/__tostack<20>
                                  local.get $2
                                  local.get $3
                                call $assemblyscript/src/compiler/Compiler#compileIdentifierExpression
                              local.set $5
                              br $break|1
                            end
                                local.get $0
                                  if ;;i32
                                        local.get $1
                                      local.tee $14
                                    call $~instanceof|assemblyscript/src/ast/InstanceOfExpression
                                    local.get $14
                                    block ;;unreachable
                                        i32.const 98016
                                        i32.const 98080
                                        i32.const 3410
                                        i32.const 71
                                      call $~lib/builtins/abort
                                      unreachable
                                    end
                                  end
                                call $~lib/rt/__tostack<20>
                                local.get $2
                                local.get $3
                              call $assemblyscript/src/compiler/Compiler#compileInstanceOfExpression
                            local.set $5
                            br $break|1
                          end
                              local.get $0
                                if ;;i32
                                      local.get $1
                                    local.tee $15
                                  call $~instanceof|assemblyscript/src/ast/LiteralExpression
                                  local.get $15
                                  block ;;unreachable
                                      i32.const 98016
                                      i32.const 98080
                                      i32.const 3414
                                      i32.const 65
                                    call $~lib/builtins/abort
                                    unreachable
                                  end
                                end
                              call $~lib/rt/__tostack<20>
                              local.get $2
                              local.get $3
                              i32.const 0
                            call $assemblyscript/src/compiler/Compiler#compileLiteralExpression
                          local.set $5
                          br $break|1
                        end
                            local.get $0
                              if ;;i32
                                    local.get $1
                                  local.tee $16
                                call $~instanceof|assemblyscript/src/ast/NewExpression
                                local.get $16
                                block ;;unreachable
                                    i32.const 98016
                                    i32.const 98080
                                    i32.const 3418
                                    i32.const 57
                                  call $~lib/builtins/abort
                                  unreachable
                                end
                              end
                            call $~lib/rt/__tostack<20>
                            local.get $2
                            local.get $3
                          call $assemblyscript/src/compiler/Compiler#compileNewExpression
                        local.set $5
                        br $break|1
                      end
                          local.get $0
                            if ;;i32
                                  local.get $1
                                local.tee $17
                              call $~instanceof|assemblyscript/src/ast/PropertyAccessExpression
                              local.get $17
                              block ;;unreachable
                                  i32.const 98016
                                  i32.const 98080
                                  i32.const 3422
                                  i32.const 79
                                call $~lib/builtins/abort
                                unreachable
                              end
                            end
                          call $~lib/rt/__tostack<20>
                          local.get $2
                          local.get $3
                        call $assemblyscript/src/compiler/Compiler#compilePropertyAccessExpression
                      local.set $5
                      br $break|1
                    end
                        local.get $0
                          if ;;i32
                                local.get $1
                              local.tee $18
                            call $~instanceof|assemblyscript/src/ast/TernaryExpression
                            local.get $18
                            block ;;unreachable
                                i32.const 98016
                                i32.const 98080
                                i32.const 3426
                                i32.const 65
                              call $~lib/builtins/abort
                              unreachable
                            end
                          end
                        call $~lib/rt/__tostack<20>
                        local.get $2
                        local.get $3
                      call $assemblyscript/src/compiler/Compiler#compileTernaryExpression
                    local.set $5
                    br $break|1
                  end
                      local.get $0
                        if ;;i32
                              local.get $1
                            local.tee $19
                          call $~instanceof|assemblyscript/src/ast/UnaryPostfixExpression
                          local.get $19
                          block ;;unreachable
                              i32.const 98016
                              i32.const 98080
                              i32.const 3430
                              i32.const 75
                            call $~lib/builtins/abort
                            unreachable
                          end
                        end
                      call $~lib/rt/__tostack<20>
                      local.get $2
                      local.get $3
                    call $assemblyscript/src/compiler/Compiler#compileUnaryPostfixExpression
                  local.set $5
                  br $break|1
                end
                    local.get $0
                      if ;;i32
                            local.get $1
                          local.tee $20
                        call $~instanceof|assemblyscript/src/ast/UnaryPrefixExpression
                        local.get $20
                        block ;;unreachable
                            i32.const 98016
                            i32.const 98080
                            i32.const 3434
                            i32.const 73
                          call $~lib/builtins/abort
                          unreachable
                        end
                      end
                    call $~lib/rt/__tostack<20>
                    local.get $2
                    local.get $3
                  call $assemblyscript/src/compiler/Compiler#compileUnaryPrefixExpression
                local.set $5
                br $break|1
              end
                if ;;i32
                      local.get $1
                    local.tee $21
                  call $~instanceof|assemblyscript/src/ast/CompiledExpression
                  local.get $21
                  block ;;unreachable
                      i32.const 98016
                      i32.const 98080
                      i32.const 3438
                      i32.const 44
                    call $~lib/builtins/abort
                    unreachable
                  end
                end
              local.set $22
                  local.get $22
                call $assemblyscript/src/ast/CompiledExpression#get:expr
              local.set $5
                local.get $0
                  local.get $22
                call $assemblyscript/src/ast/CompiledExpression#get:type
              call $assemblyscript/src/compiler/Compiler#set:currentType
              br $break|1
            end
              local.get $0
              global.get $assemblyscript/src/diagnosticMessages.generated/DiagnosticCode.Not_implemented_0
                  local.get $1
                call $assemblyscript/src/ast/Node#get:range
              call $~lib/rt/__tostack<24>
                i32.const 113264
              call $~lib/rt/__tostack<20>
              i32.const 0
              i32.const 0
            call $assemblyscript/src/diagnostics/DiagnosticEmitter#error
                  local.get $0
                call $assemblyscript/src/compiler/Compiler#get:module
              call $assemblyscript/src/module/Module#unreachable
            local.set $5
            br $break|1
          end
          if ;;none
              i32.const 0
            i32.eqz
            block ;;unreachable
                i32.const 0
                i32.const 98080
                i32.const 3454
                i32.const 9
              call $~lib/builtins/abort
              unreachable
            end
          end
                local.get $0
              call $assemblyscript/src/compiler/Compiler#get:module
            call $assemblyscript/src/module/Module#unreachable
          local.set $5
        end
              local.get $0
            call $assemblyscript/src/compiler/Compiler#get:currentType
          call $~lib/rt/__tostack<20>
        local.set $23
              local.get $3
              i32.const 4
            i32.and
            i32.const 0
          i32.ne
        local.set $24
        if ;;none
            local.get $23
              local.get $2
            call $assemblyscript/src/types/Type#get:nonNullableType
          i32.ne
          if ;;none
              local.get $3
              i32.const 2
            i32.and
            block ;;none
                  local.get $0
                  local.get $5
                  local.get $23
                  local.get $2
                  i32.const 1
                  local.get $1
                call $assemblyscript/src/compiler/Compiler#convertExpression
              local.set $5
                local.get $0
                    local.get $2
                  call $~lib/rt/__tostack<16>
                local.tee $23
              call $assemblyscript/src/compiler/Compiler#set:currentType
            end
            if ;;none
                local.get $3
                i32.const 1
              i32.and
              block ;;none
                    local.get $0
                    local.get $5
                    local.get $23
                    local.get $2
                    i32.const 0
                    local.get $1
                  call $assemblyscript/src/compiler/Compiler#convertExpression
                local.set $5
                  local.get $0
                      local.get $2
                    call $~lib/rt/__tostack<12>
                  local.tee $23
                call $assemblyscript/src/compiler/Compiler#set:currentType
              end
            end
          end
        end
        if ;;none
          local.get $24
              local.get $0
              local.get $5
              local.get $23
            call $assemblyscript/src/compiler/Compiler#ensureSmallIntegerWrap
          local.set $5
        end
        if ;;none
              local.get $0
            call $assemblyscript/src/compiler/Compiler#get:options
          call $assemblyscript/src/compiler/Options#get:sourceMap
            local.get $0
            local.get $5
                local.get $1
              call $assemblyscript/src/ast/Node#get:range
            call $~lib/rt/__tostack<4>
          call $assemblyscript/src/compiler/Compiler#addDebugLocation
        end
        block ;;unreachable
            local.get $5
          local.set $25
            i32.const 28
          call $~lib/rt/__increase_sp
            local.get $25
          return
        end
      end
    local.tee $25
      i32.const 28
    call $~lib/rt/__increase_sp
    local.get $25
  end
)