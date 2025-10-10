// Copyright (C) 2024 Bayerische Motoren Werke Aktiengesellschaft (BMW AG)
// Copyright (C) 2025 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

#include "ToString.hpp"
#include "wasm-traversal.h"
#include "wasm.h"

std::string warpo::passes::toString(wasm::Expression *expr) {
  if (expr == nullptr)
    return "<<NULL>>";
  std::stringstream ss{};
  ss << wasm::ShallowExpression{expr, nullptr};
  return std::move(ss).str();
}

std::string warpo::passes::toString(wasm::Function *f) {
  struct Printer : wasm::ExpressionStackWalker<Printer, wasm::UnifiedExpressionVisitor<Printer>> {
    using Supper = wasm::ExpressionStackWalker<Printer, wasm::UnifiedExpressionVisitor<Printer>>;
    std::stringstream ss;
    void walkFunction(wasm::Function *func) {
      ss << "(func $" << func->name << " " << func->type << "\n";
      for (auto &local : func->vars) {
        ss << "  (local " << local << ")\n";
      }
      if (func->body != nullptr) {
        Supper::walkFunction(func);
      }
      ss << ")\n";
    }
    static void doPreVisit(Printer *self, wasm::Expression **currp) {
      Supper::doPreVisit(self, currp);
      if (auto expr = (*currp)->dynCast<wasm::Block>()) {
        self->indent();
        self->ss << "block ;;" << expr->type << "\n";
      } else if (auto expr = (*currp)->dynCast<wasm::If>()) {
        self->indent();
        self->ss << "if ;;" << expr->type << "\n";
      } else if (auto expr = (*currp)->dynCast<wasm::Loop>()) {
        self->indent();
        self->ss << "loop ;;" << expr->type << "\n";
      }
    }
    static void doPostVisit(Printer *self, wasm::Expression **currp) {
      if ((*currp)->is<wasm::Block>() || (*currp)->is<wasm::If>() || (*currp)->is<wasm::Loop>()) {
        self->indent();
        self->ss << "end\n";
      } else {
        self->indent();
        self->ss << wasm::ShallowExpression{*currp, nullptr} << "\n";
      }
      Supper::doPostVisit(self, currp);
    }

    // static void doVisitBlock(Printer *self, wasm::Expression **currp) {
    //   self->indent();
    //   self->ss << "block\n";
    //   Supper::doVisitBlock(self, currp);
    //   self->indent();
    //   self->ss << "end\n";
    // }
    // static void doVisitIf(Printer *self, wasm::Expression **currp) {
    //   self->indent();
    //   self->ss << "if\n";
    //   Supper::doVisitIf(self, currp);
    //   self->indent();
    //   self->ss << "end\n";
    // }

    void indent() {
      for (wasm::Expression const *const _ : expressionStack) {
        static_cast<void>(_);
        ss << "  ";
      }
    }
  };
  Printer printer{};
  printer.walkFunction(f);
  return std::move(printer.ss).str();
}
