// Copyright (C) 2024 Bayerische Motoren Werke Aktiengesellschaft (BMW AG)
// Copyright (C) 2025 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

#include <fstream>
#include <iostream>
#include <map>
#include <stdexcept>
#include <string>

#include "CostModel.hpp"
#include "ToString.hpp"
#include "warpo/support/Container.hpp"
#include "warpo/support/Opt.hpp"
#include "wasm-traversal.h"
#include "wasm.h"

namespace warpo::passes {

static cli::Opt<std::string> sizeCostModelFile{
    cli::Category::Optimization,
    "--size-cost-model-file",
    [](argparse::Argument &arg) { arg.help("Instruction cost model file for size").default_value("").hidden(); },
};
static cli::Opt<std::string> performanceCostModelFile{
    cli::Category::Optimization,
    "--performance-cost-model-file",
    [](argparse::Argument &arg) { arg.help("Instruction cost model file for performance").default_value("").hidden(); },
};

static Opcode getOpcodeByName(std::string const &name) {
#define OPCODE(str, code, cost)                                                                                        \
  if ((name) == (str)) {                                                                                               \
    return Opcode::code;                                                                                               \
  }
#define SPECIAL_OPCODE(str, code, cost)                                                                                \
  if ((name) == (str)) {                                                                                               \
    return Opcode::code;                                                                                               \
  }
#include "InstructionSizeCostModel.inc"
  return Opcode::INVALID;
}

static float getDefaultSizeCostAverage(Opcode opcode) {
  static_cast<void>(opcode);
  size_t cnt = 0;
  float sum = 0.0F;
#define OPCODE(str, code, cost)                                                                                        \
  cnt++;                                                                                                               \
  sum += static_cast<float>(cost);
#define SPECIAL_OPCODE(str, code, cost)                                                                                \
  cnt++;                                                                                                               \
  sum += static_cast<float>(cost);
#include "InstructionSizeCostModel.inc"
  return sum / static_cast<float>(cnt);
}
static float getDefaultSizeCostByOpcode(Opcode opcode) {
  static float const average = getDefaultSizeCostAverage(opcode);
  switch (opcode) {
#define OPCODE(str, code, cost)                                                                                        \
  case Opcode::code:                                                                                                   \
    return static_cast<float>(cost) / average;
#define SPECIAL_OPCODE(str, code, cost)                                                                                \
  case Opcode::code:                                                                                                   \
    return static_cast<float>(cost) / average;
#include "InstructionSizeCostModel.inc"
  default:
    std::cerr << "cost model does not contain cost for opcode: " << static_cast<uint16_t>(opcode) << "\n";
    return average;
  }
}

float getDefaultPerformanceCostAverage(Opcode opcode) {
  static_cast<void>(opcode);
  size_t cnt = 0;
  float sum = 0.0F;
#define OPCODE(str, code, cost)                                                                                        \
  cnt++;                                                                                                               \
  sum += static_cast<float>(cost);
#define SPECIAL_OPCODE(str, code, cost)                                                                                \
  cnt++;                                                                                                               \
  sum += static_cast<float>(cost);
#include "InstructionPerformanceCostModel.inc"
  return sum / static_cast<float>(cnt);
}
static float getDefaultPerformanceByOpcode(Opcode opcode) {
  static float const average = getDefaultPerformanceCostAverage(opcode);
  switch (opcode) {
#define OPCODE(str, code, cost)                                                                                        \
  case Opcode::code:                                                                                                   \
    return static_cast<float>(cost) / average;
#define SPECIAL_OPCODE(str, code, cost)                                                                                \
  case Opcode::code:                                                                                                   \
    return static_cast<float>(cost) / average;
#include "InstructionPerformanceCostModel.inc"
  default:
    std::cerr << "cost model does not contain cost for opcode: " << static_cast<uint16_t>(opcode) << "\n";
    return average;
  }
}

namespace {

struct CostModel {
  static CostModel const &ins() {
    static CostModel const costModelParser{};
    return costModelParser;
  }

  float getSizeCostByExpr(wasm::Expression *expr) const;
  float getSizeCostByOpcode(Opcode opcode) const;
  float getPerformanceCostByOpcode(Opcode opcode) const;

private:
  std::map<Opcode, float> sizeCost_;
  std::map<Opcode, float> performanceCost_;
  CostModel();
};

std::map<Opcode, float> createCostModelFromFile(std::string const &costModelPath) {
  std::map<Opcode, float> costModel;
  std::fstream costFile{costModelPath, std::ios::in};
  if (!costFile.is_open()) {
    throw std::runtime_error("Failed to open cost model file: " + costModelPath);
  }
  std::string line;
  while (std::getline(costFile, line)) {
    if (line.empty() || line[0] == '#' || all_of(line, [](char ch) { return ch == ' '; })) {
      continue;
    }
    size_t const spaceIndex = line.find(' ');
    if (spaceIndex == std::string::npos) {
      throw std::runtime_error("Invalid cost model line: '" + line + "'");
    }
    if (spaceIndex == 0 || spaceIndex == line.size() - 1) {
      throw std::runtime_error("Invalid cost model line: '" + line + "'");
    }
    std::string const costStr = line.substr(spaceIndex + 1);
    float const cost = std::stof(costStr);
    std::string const opcodeStr = line.substr(0, spaceIndex);
    Opcode const opcode = getOpcodeByName(opcodeStr);
    if (opcode == Opcode::INVALID) {
      throw std::runtime_error("Unknown opcode in cost model: '" + opcodeStr + "'");
    }
    if (costModel.contains(opcode)) {
      throw std::runtime_error("Duplicate opcode in cost model: '" + opcodeStr + "'");
    }
    costModel.insert_or_assign(opcode, cost);
  }
  return costModel;
}

CostModel::CostModel() {
  std::string const sizeCostModelPath = sizeCostModelFile.get();
  if (!sizeCostModelPath.empty())
    sizeCost_ = createCostModelFromFile(sizeCostModelPath);
  std::string const performanceCostModelPath = performanceCostModelFile.get();
  if (!performanceCostModelPath.empty())
    performanceCost_ = createCostModelFromFile(performanceCostModelPath);
}

float CostModel::getSizeCostByExpr(wasm::Expression *expr) const {
  switch (expr->_id) {
  case wasm::Expression::BlockId:
    return getSizeCostByOpcode(Opcode::BLOCK) + getSizeCostByOpcode(Opcode::END);
  case wasm::Expression::IfId:
    return getSizeCostByOpcode(Opcode::IF) +
           (expr->cast<wasm::If>()->ifFalse == nullptr ? 0.0F : getSizeCostByOpcode(Opcode::ELSE)) +
           getSizeCostByOpcode(Opcode::END);
  case wasm::Expression::LoopId:
    return getSizeCostByOpcode(Opcode::LOOP) + getSizeCostByOpcode(Opcode::END);
  case wasm::Expression::BreakId:
    return expr->cast<wasm::Break>()->condition == nullptr ? getSizeCostByOpcode(Opcode::BR)
                                                           : getSizeCostByOpcode(Opcode::BR_IF);
  case wasm::Expression::SwitchId:
    return getSizeCostByOpcode(Opcode::BR_TABLE);
  case wasm::Expression::CallId:
    return getSizeCostByOpcode(Opcode::CALL);
  case wasm::Expression::CallIndirectId:
    return getSizeCostByOpcode(Opcode::CALL_INDIRECT);
  case wasm::Expression::LocalGetId:
    return getSizeCostByOpcode(Opcode::LOCAL_GET);
  case wasm::Expression::LocalSetId:
    return expr->cast<wasm::LocalSet>()->isTee() ? getSizeCostByOpcode(Opcode::LOCAL_TEE)
                                                 : getSizeCostByOpcode(Opcode::LOCAL_SET);
  case wasm::Expression::GlobalGetId:
    return getSizeCostByOpcode(Opcode::GLOBAL_GET);
  case wasm::Expression::GlobalSetId:
    return getSizeCostByOpcode(Opcode::GLOBAL_SET);
  case wasm::Expression::LoadId: {
    auto *load = expr->cast<wasm::Load>();
    switch (load->type.getBasic()) {
    case wasm::Type::i32:
      return getSizeCostByOpcode(Opcode::I32_LOAD);
    case wasm::Type::i64:
      return getSizeCostByOpcode(Opcode::I64_LOAD);
    case wasm::Type::f32:
      return getSizeCostByOpcode(Opcode::F32_LOAD);
    case wasm::Type::f64:
      return getSizeCostByOpcode(Opcode::F64_LOAD);
    default:
      throw std::runtime_error("Unknown expression: " + toString(expr));
    }
  }
  case wasm::Expression::StoreId: {
    auto *store = expr->cast<wasm::Store>();
    switch (store->valueType.getBasic()) {
    case wasm::Type::i32:
      return getSizeCostByOpcode(Opcode::I32_STORE);
    case wasm::Type::i64:
      return getSizeCostByOpcode(Opcode::I64_STORE);
    case wasm::Type::f32:
      return getSizeCostByOpcode(Opcode::F32_STORE);
    case wasm::Type::f64:
      return getSizeCostByOpcode(Opcode::F64_STORE);
    default:
      throw std::runtime_error("Unknown expression: " + toString(expr));
    }
  }
  case wasm::Expression::ConstId:
    return getSizeCostByOpcode(Opcode::I32_CONST);
  case wasm::Expression::UnaryId: {
    auto *unary = expr->cast<wasm::Unary>();
    switch (unary->op) {
    case wasm::UnaryOp::ClzInt32:
      return getSizeCostByOpcode(Opcode::I32_CLZ);
    case wasm::UnaryOp::CtzInt32:
      return getSizeCostByOpcode(Opcode::I32_CTZ);
    case wasm::UnaryOp::PopcntInt32:
      return getSizeCostByOpcode(Opcode::I32_POPCNT);
    case wasm::UnaryOp::ClzInt64:
      return getSizeCostByOpcode(Opcode::I64_CLZ);
    case wasm::UnaryOp::CtzInt64:
      return getSizeCostByOpcode(Opcode::I64_CTZ);
    case wasm::UnaryOp::PopcntInt64:
      return getSizeCostByOpcode(Opcode::I64_POPCNT);
    case wasm::UnaryOp::AbsFloat32:
      return getSizeCostByOpcode(Opcode::F32_ABS);
    case wasm::UnaryOp::NegFloat32:
      return getSizeCostByOpcode(Opcode::F32_NEG);
    case wasm::UnaryOp::CeilFloat32:
      return getSizeCostByOpcode(Opcode::F32_CEIL);
    case wasm::UnaryOp::FloorFloat32:
      return getSizeCostByOpcode(Opcode::F32_FLOOR);
    case wasm::UnaryOp::TruncFloat32:
      return getSizeCostByOpcode(Opcode::F32_TRUNC);
    case wasm::UnaryOp::NearestFloat32:
      return getSizeCostByOpcode(Opcode::F32_NEAREST);
    case wasm::UnaryOp::SqrtFloat32:
      return getSizeCostByOpcode(Opcode::F32_SQRT);
    case wasm::UnaryOp::AbsFloat64:
      return getSizeCostByOpcode(Opcode::F64_ABS);
    case wasm::UnaryOp::NegFloat64:
      return getSizeCostByOpcode(Opcode::F64_NEG);
    case wasm::UnaryOp::CeilFloat64:
      return getSizeCostByOpcode(Opcode::F64_CEIL);
    case wasm::UnaryOp::FloorFloat64:
      return getSizeCostByOpcode(Opcode::F64_FLOOR);
    case wasm::UnaryOp::TruncFloat64:
      return getSizeCostByOpcode(Opcode::F64_TRUNC);
    case wasm::UnaryOp::NearestFloat64:
      return getSizeCostByOpcode(Opcode::F64_NEAREST);
    case wasm::UnaryOp::SqrtFloat64:
      return getSizeCostByOpcode(Opcode::F64_SQRT);
    case wasm::UnaryOp::ExtendSInt32:
      return getSizeCostByOpcode(Opcode::I64_EXTEND_I32_S);
    case wasm::UnaryOp::ExtendUInt32:
      return getSizeCostByOpcode(Opcode::I64_EXTEND_I32_U);
    case wasm::UnaryOp::WrapInt64:
      return getSizeCostByOpcode(Opcode::I32_WRAP_I64);
    case wasm::UnaryOp::TruncSFloat32ToInt32:
      return getSizeCostByOpcode(Opcode::I32_TRUNC_F32_S);
    case wasm::UnaryOp::TruncUFloat32ToInt32:
      return getSizeCostByOpcode(Opcode::I32_TRUNC_F32_U);
    case wasm::UnaryOp::TruncSFloat64ToInt32:
      return getSizeCostByOpcode(Opcode::I32_TRUNC_F64_S);
    case wasm::UnaryOp::TruncUFloat64ToInt32:
      return getSizeCostByOpcode(Opcode::I32_TRUNC_F64_U);
    case wasm::UnaryOp::TruncSFloat32ToInt64:
      return getSizeCostByOpcode(Opcode::I64_TRUNC_F32_S);
    case wasm::UnaryOp::TruncUFloat32ToInt64:
      return getSizeCostByOpcode(Opcode::I64_TRUNC_F32_U);
    case wasm::UnaryOp::TruncSFloat64ToInt64:
      return getSizeCostByOpcode(Opcode::I64_TRUNC_F64_S);
    case wasm::UnaryOp::TruncUFloat64ToInt64:
      return getSizeCostByOpcode(Opcode::I64_TRUNC_F64_U);
    case wasm::UnaryOp::ConvertSInt32ToFloat32:
      return getSizeCostByOpcode(Opcode::F32_CONVERT_I32_S);
    case wasm::UnaryOp::ConvertUInt32ToFloat32:
      return getSizeCostByOpcode(Opcode::F32_CONVERT_I32_U);
    case wasm::UnaryOp::ConvertSInt64ToFloat32:
      return getSizeCostByOpcode(Opcode::F32_CONVERT_I64_S);
    case wasm::UnaryOp::ConvertUInt64ToFloat32:
      return getSizeCostByOpcode(Opcode::F32_CONVERT_I64_U);
    case wasm::UnaryOp::ConvertSInt32ToFloat64:
      return getSizeCostByOpcode(Opcode::F64_CONVERT_I32_S);
    case wasm::UnaryOp::ConvertUInt32ToFloat64:
      return getSizeCostByOpcode(Opcode::F64_CONVERT_I32_U);
    case wasm::UnaryOp::ConvertSInt64ToFloat64:
      return getSizeCostByOpcode(Opcode::F64_CONVERT_I64_S);
    case wasm::UnaryOp::ConvertUInt64ToFloat64:
      return getSizeCostByOpcode(Opcode::F64_CONVERT_I64_U);
    case wasm::UnaryOp::PromoteFloat32:
      return getSizeCostByOpcode(Opcode::F64_PROMOTE_F32);
    case wasm::UnaryOp::DemoteFloat64:
      return getSizeCostByOpcode(Opcode::F32_DEMOTE_F64);
    case wasm::UnaryOp::ReinterpretInt32:
      return getSizeCostByOpcode(Opcode::F32_REINTERPRET_I32);
    case wasm::UnaryOp::ReinterpretInt64:
      return getSizeCostByOpcode(Opcode::F64_REINTERPRET_I64);
    case wasm::UnaryOp::ReinterpretFloat32:
      return getSizeCostByOpcode(Opcode::I32_REINTERPRET_F32);
    case wasm::UnaryOp::ReinterpretFloat64:
      return getSizeCostByOpcode(Opcode::I64_REINTERPRET_F64);
    case wasm::UnaryOp::ExtendS8Int32:
      return getSizeCostByOpcode(Opcode::I32_EXTEND8_S);
    case wasm::UnaryOp::ExtendS16Int32:
      return getSizeCostByOpcode(Opcode::I32_EXTEND16_S);
    case wasm::UnaryOp::ExtendS8Int64:
      return getSizeCostByOpcode(Opcode::I64_EXTEND8_S);
    case wasm::UnaryOp::ExtendS16Int64:
      return getSizeCostByOpcode(Opcode::I64_EXTEND16_S);
    case wasm::UnaryOp::ExtendS32Int64:
      return getSizeCostByOpcode(Opcode::I64_EXTEND32_S);
    case wasm::UnaryOp::TruncSatSFloat32ToInt32:
      return getSizeCostByOpcode(Opcode::I32_TRUNC_SAT_F32_S);
    case wasm::UnaryOp::TruncSatUFloat32ToInt32:
      return getSizeCostByOpcode(Opcode::I32_TRUNC_SAT_F32_U);
    case wasm::UnaryOp::TruncSatSFloat64ToInt32:
      return getSizeCostByOpcode(Opcode::I32_TRUNC_SAT_F64_S);
    case wasm::UnaryOp::TruncSatUFloat64ToInt32:
      return getSizeCostByOpcode(Opcode::I32_TRUNC_SAT_F64_U);
    case wasm::UnaryOp::TruncSatSFloat32ToInt64:
      return getSizeCostByOpcode(Opcode::I64_TRUNC_SAT_F32_S);
    case wasm::UnaryOp::TruncSatUFloat32ToInt64:
      return getSizeCostByOpcode(Opcode::I64_TRUNC_SAT_F32_U);
    case wasm::UnaryOp::TruncSatSFloat64ToInt64:
      return getSizeCostByOpcode(Opcode::I64_TRUNC_SAT_F64_S);
    case wasm::UnaryOp::TruncSatUFloat64ToInt64:
      return getSizeCostByOpcode(Opcode::I64_TRUNC_SAT_F64_U);
    case wasm::EqZInt32:
      return getSizeCostByOpcode(Opcode::I32_EQZ);
    case wasm::EqZInt64:
      return getSizeCostByOpcode(Opcode::I64_EQZ);
    default:
      throw std::runtime_error("Unknown unary operation: " + toString(expr));
    }
  }
  case wasm::Expression::BinaryId: {
    auto *binary = expr->cast<wasm::Binary>();
    switch (binary->op) {
    case wasm::BinaryOp::AddInt32:
      return getSizeCostByOpcode(Opcode::I32_ADD);
    case wasm::BinaryOp::SubInt32:
      return getSizeCostByOpcode(Opcode::I32_SUB);
    case wasm::BinaryOp::MulInt32:
      return getSizeCostByOpcode(Opcode::I32_MUL);
    case wasm::BinaryOp::DivSInt32:
      return getSizeCostByOpcode(Opcode::I32_DIV_S);
    case wasm::BinaryOp::DivUInt32:
      return getSizeCostByOpcode(Opcode::I32_DIV_U);
    case wasm::BinaryOp::RemSInt32:
      return getSizeCostByOpcode(Opcode::I32_REM_S);
    case wasm::BinaryOp::RemUInt32:
      return getSizeCostByOpcode(Opcode::I32_REM_U);
    case wasm::BinaryOp::AndInt32:
      return getSizeCostByOpcode(Opcode::I32_AND);
    case wasm::BinaryOp::OrInt32:
      return getSizeCostByOpcode(Opcode::I32_OR);
    case wasm::BinaryOp::XorInt32:
      return getSizeCostByOpcode(Opcode::I32_XOR);
    case wasm::BinaryOp::ShlInt32:
      return getSizeCostByOpcode(Opcode::I32_SHL);
    case wasm::BinaryOp::ShrSInt32:
      return getSizeCostByOpcode(Opcode::I32_SHR_S);
    case wasm::BinaryOp::ShrUInt32:
      return getSizeCostByOpcode(Opcode::I32_SHR_U);
    case wasm::BinaryOp::RotLInt32:
      return getSizeCostByOpcode(Opcode::I32_ROTL);
    case wasm::BinaryOp::RotRInt32:
      return getSizeCostByOpcode(Opcode::I32_ROTR);
    case wasm::BinaryOp::EqInt32:
      return getSizeCostByOpcode(Opcode::I32_EQ);
    case wasm::BinaryOp::NeInt32:
      return getSizeCostByOpcode(Opcode::I32_NE);
    case wasm::BinaryOp::LtSInt32:
      return getSizeCostByOpcode(Opcode::I32_LT_S);
    case wasm::BinaryOp::LtUInt32:
      return getSizeCostByOpcode(Opcode::I32_LT_U);
    case wasm::BinaryOp::GtSInt32:
      return getSizeCostByOpcode(Opcode::I32_GT_S);
    case wasm::BinaryOp::GtUInt32:
      return getSizeCostByOpcode(Opcode::I32_GT_U);
    case wasm::BinaryOp::LeSInt32:
      return getSizeCostByOpcode(Opcode::I32_LE_S);
    case wasm::BinaryOp::LeUInt32:
      return getSizeCostByOpcode(Opcode::I32_LE_U);
    case wasm::BinaryOp::GeSInt32:
      return getSizeCostByOpcode(Opcode::I32_GE_S);
    case wasm::BinaryOp::GeUInt32:
      return getSizeCostByOpcode(Opcode::I32_GE_U);

    case wasm::BinaryOp::AddInt64:
      return getSizeCostByOpcode(Opcode::I64_ADD);
    case wasm::BinaryOp::SubInt64:
      return getSizeCostByOpcode(Opcode::I64_SUB);
    case wasm::BinaryOp::MulInt64:
      return getSizeCostByOpcode(Opcode::I64_MUL);
    case wasm::BinaryOp::DivSInt64:
      return getSizeCostByOpcode(Opcode::I64_DIV_S);
    case wasm::BinaryOp::DivUInt64:
      return getSizeCostByOpcode(Opcode::I64_DIV_U);
    case wasm::BinaryOp::RemSInt64:
      return getSizeCostByOpcode(Opcode::I64_REM_S);
    case wasm::BinaryOp::RemUInt64:
      return getSizeCostByOpcode(Opcode::I64_REM_U);
    case wasm::BinaryOp::AndInt64:
      return getSizeCostByOpcode(Opcode::I64_AND);
    case wasm::BinaryOp::OrInt64:
      return getSizeCostByOpcode(Opcode::I64_OR);
    case wasm::BinaryOp::XorInt64:
      return getSizeCostByOpcode(Opcode::I64_XOR);
    case wasm::BinaryOp::ShlInt64:
      return getSizeCostByOpcode(Opcode::I64_SHL);
    case wasm::BinaryOp::ShrSInt64:
      return getSizeCostByOpcode(Opcode::I64_SHR_S);
    case wasm::BinaryOp::ShrUInt64:
      return getSizeCostByOpcode(Opcode::I64_SHR_U);
    case wasm::BinaryOp::RotLInt64:
      return getSizeCostByOpcode(Opcode::I64_ROTL);
    case wasm::BinaryOp::RotRInt64:
      return getSizeCostByOpcode(Opcode::I64_ROTR);
    case wasm::BinaryOp::EqInt64:
      return getSizeCostByOpcode(Opcode::I64_EQ);
    case wasm::BinaryOp::NeInt64:
      return getSizeCostByOpcode(Opcode::I64_NE);
    case wasm::BinaryOp::LtSInt64:
      return getSizeCostByOpcode(Opcode::I64_LT_S);
    case wasm::BinaryOp::LtUInt64:
      return getSizeCostByOpcode(Opcode::I64_LT_U);
    case wasm::BinaryOp::GtSInt64:
      return getSizeCostByOpcode(Opcode::I64_GT_S);
    case wasm::BinaryOp::GtUInt64:
      return getSizeCostByOpcode(Opcode::I64_GT_U);
    case wasm::BinaryOp::LeSInt64:
      return getSizeCostByOpcode(Opcode::I64_LE_S);
    case wasm::BinaryOp::LeUInt64:
      return getSizeCostByOpcode(Opcode::I64_LE_U);
    case wasm::BinaryOp::GeSInt64:
      return getSizeCostByOpcode(Opcode::I64_GE_S);
    case wasm::BinaryOp::GeUInt64:
      return getSizeCostByOpcode(Opcode::I64_GE_U);

    case wasm::BinaryOp::AddFloat32:
      return getSizeCostByOpcode(Opcode::F32_ADD);
    case wasm::BinaryOp::SubFloat32:
      return getSizeCostByOpcode(Opcode::F32_SUB);
    case wasm::BinaryOp::MulFloat32:
      return getSizeCostByOpcode(Opcode::F32_MUL);
    case wasm::BinaryOp::DivFloat32:
      return getSizeCostByOpcode(Opcode::F32_DIV);
    case wasm::BinaryOp::MinFloat32:
      return getSizeCostByOpcode(Opcode::F32_MIN);
    case wasm::BinaryOp::MaxFloat32:
      return getSizeCostByOpcode(Opcode::F32_MAX);
    case wasm::BinaryOp::CopySignFloat32:
      return getSizeCostByOpcode(Opcode::F32_COPYSIGN);
    case wasm::BinaryOp::EqFloat32:
      return getSizeCostByOpcode(Opcode::F32_EQ);
    case wasm::BinaryOp::NeFloat32:
      return getSizeCostByOpcode(Opcode::F32_NE);
    case wasm::BinaryOp::LtFloat32:
      return getSizeCostByOpcode(Opcode::F32_LT);
    case wasm::BinaryOp::GtFloat32:
      return getSizeCostByOpcode(Opcode::F32_GT);
    case wasm::BinaryOp::LeFloat32:
      return getSizeCostByOpcode(Opcode::F32_LE);
    case wasm::BinaryOp::GeFloat32:
      return getSizeCostByOpcode(Opcode::F32_GE);

    case wasm::BinaryOp::AddFloat64:
      return getSizeCostByOpcode(Opcode::F64_ADD);
    case wasm::BinaryOp::SubFloat64:
      return getSizeCostByOpcode(Opcode::F64_SUB);
    case wasm::BinaryOp::MulFloat64:
      return getSizeCostByOpcode(Opcode::F64_MUL);
    case wasm::BinaryOp::DivFloat64:
      return getSizeCostByOpcode(Opcode::F64_DIV);
    case wasm::BinaryOp::MinFloat64:
      return getSizeCostByOpcode(Opcode::F64_MIN);
    case wasm::BinaryOp::MaxFloat64:
      return getSizeCostByOpcode(Opcode::F64_MAX);
    case wasm::BinaryOp::CopySignFloat64:
      return getSizeCostByOpcode(Opcode::F64_COPYSIGN);
    case wasm::BinaryOp::EqFloat64:
      return getSizeCostByOpcode(Opcode::F64_EQ);
    case wasm::BinaryOp::NeFloat64:
      return getSizeCostByOpcode(Opcode::F64_NE);
    case wasm::BinaryOp::LtFloat64:
      return getSizeCostByOpcode(Opcode::F64_LT);
    case wasm::BinaryOp::GtFloat64:
      return getSizeCostByOpcode(Opcode::F64_GT);
    case wasm::BinaryOp::LeFloat64:
      return getSizeCostByOpcode(Opcode::F64_LE);
    case wasm::BinaryOp::GeFloat64:
      return getSizeCostByOpcode(Opcode::F64_GE);

    default:
      throw std::runtime_error("Unknown unary operation: " + toString(expr));
    }
  }
  case wasm::Expression::SelectId:
    return getSizeCostByOpcode(Opcode::SELECT);
  case wasm::Expression::DropId:
    return getSizeCostByOpcode(Opcode::DROP);
  case wasm::Expression::ReturnId:
    return getSizeCostByOpcode(Opcode::RETURN);
  case wasm::Expression::MemorySizeId:
    return getSizeCostByOpcode(Opcode::MEMORY_SIZE);
  case wasm::Expression::MemoryGrowId:
    return getSizeCostByOpcode(Opcode::MEMORY_GROW);

  case wasm::Expression::NopId:
    return getSizeCostByOpcode(Opcode::NOP);
  case wasm::Expression::UnreachableId:
    return getSizeCostByOpcode(Opcode::UNREACHABLE);

  case wasm::Expression::MemoryInitId:
    return getSizeCostByOpcode(Opcode::MEMORY_INIT);
  case wasm::Expression::DataDropId:
    return getSizeCostByOpcode(Opcode::DATA_DROP);
  case wasm::Expression::MemoryCopyId:
    return getSizeCostByOpcode(Opcode::MEMORY_COPY);
  case wasm::Expression::MemoryFillId:
    return getSizeCostByOpcode(Opcode::MEMORY_FILL);
  default:
    throw std::runtime_error("Unknown expression: " + toString(expr));
  }
}

float CostModel::getSizeCostByOpcode(Opcode opcode) const {
  auto it = sizeCost_.find(opcode);
  if (it == sizeCost_.end())
    return getDefaultSizeCostByOpcode(opcode);
  return it->second;
}

float CostModel::getPerformanceCostByOpcode(Opcode opcode) const {
  auto it = performanceCost_.find(opcode);
  if (it == performanceCost_.end())
    return getDefaultPerformanceByOpcode(opcode);
  return it->second;
}

} // namespace
} // namespace warpo::passes

float warpo::passes::getFunctionSizeCost() {
  return CostModel::ins().getSizeCostByOpcode(Opcode::FUNC) + CostModel::ins().getSizeCostByOpcode(Opcode::END);
}

float warpo::passes::getOpcodeSizeCost(wasm::Expression *expr) { return CostModel::ins().getSizeCostByExpr(expr); }

float warpo::passes::getOpcodeSizeCost(Opcode opcode) { return CostModel::ins().getSizeCostByOpcode(opcode); }

float warpo::passes::measureSizeCost(wasm::Expression *expr) {
  struct CostMeasure : public wasm::PostWalker<CostMeasure, wasm::UnifiedExpressionVisitor<CostMeasure>> {
    float cost = 0;
    void visitExpression(wasm::Expression *expr) { cost += CostModel::ins().getSizeCostByExpr(expr); }
  };
  CostMeasure measurer{};
  measurer.walk(expr);
  return measurer.cost;
}

float warpo::passes::getFunctionPerformanceCost() {
  return CostModel::ins().getPerformanceCostByOpcode(Opcode::FUNC) +
         CostModel::ins().getPerformanceCostByOpcode(Opcode::END);
}

float warpo::passes::getOpcodePerformanceCost(Opcode opcode) {
  return CostModel::ins().getPerformanceCostByOpcode(opcode);
}
