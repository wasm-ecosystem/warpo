// Copyright (C) 2024 Bayerische Motoren Werke Aktiengesellschaft (BMW AG)
// Copyright (C) 2025 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

import { LiteralKind, StringLiteralExpression } from "../../assemblyscript/src/ast";
import { builtinFunctions, BuiltinFunctionContext } from "../../assemblyscript/src/builtins";
import { DiagnosticCode } from "../../assemblyscript/src/diagnosticMessages.generated";
import { ExpressionRef } from "../../assemblyscript/src/module";
import { getUtf8Cache } from "./utf8_cache";

namespace ExtNames {
  export const utf8_const_str = "~lib/utf8_const_str/utf8.ConstStr";
  export const utf8_build = "~lib/utf8_const_str/utf8.build";
}

function checkTypeAbsent(ctx: BuiltinFunctionContext): i32 {
  let typeArguments = ctx.typeArguments;
  if (typeArguments) {
    let prototype = ctx.prototype;
    prototype.program.error(
      DiagnosticCode.Type_0_is_not_generic,
      ctx.reportNode.typeArgumentsRange,
      prototype.internalName
    );
    return 1;
  }
  return 0;
}

function builtin_utf8_build(ctx: BuiltinFunctionContext): ExpressionRef {
  checkTypeAbsent(ctx);
  let compiler = ctx.compiler;
  let module = compiler.module;
  let operands = ctx.operands;
  let program = compiler.program;

  let constStrClass = program.requireClass(ExtNames.utf8_const_str);

  if (operands.length != 1) {
    compiler.error(
      DiagnosticCode.Expected_0_arguments_but_got_1,
      ctx.reportNode.argumentsRange,
      "1",
      operands.length.toString()
    );
    compiler.currentType = constStrClass.type;
    return module.unreachable();
  }
  if (!operands[0].isLiteralKind(LiteralKind.String)) {
    compiler.error(DiagnosticCode.String_literal_expected, ctx.reportNode.argumentsRange);
    compiler.currentType = constStrClass.type;
    return module.unreachable();
  }

  let literal: string = (<StringLiteralExpression>operands[0]).value;

  let cache = getUtf8Cache(constStrClass, compiler, program);
  const stringPtr = cache.ensure(literal);
  compiler.currentType = constStrClass.type;
  return module.i32(stringPtr);
}

export function activeExtensions(): void {
  builtinFunctions.set(ExtNames.utf8_build, builtin_utf8_build);
}
