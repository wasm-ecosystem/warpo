#include <fstream>
#include <iostream>
#include <map>
#include <stdexcept>
#include <string>

#include "CostModel.hpp"
#include "ToString.hpp"
#include "support/Container.hpp"
#include "support/Opt.hpp"
#include "wasm-traversal.h"
#include "wasm.h"

namespace warpo::passes {

static cli::Opt<std::string> CostModelFile{
    "--cost-model-file",
    [](argparse::Argument &arg) {
      arg.help("Tolerable instruction increase for each inline function").default_value("");
    },
};

static Opcode getOpcodeByName(std::string const &name) {
#define OPCODE(str, code, cost)                                                                                        \
  if (name == str) {                                                                                                   \
    return Opcode::code;                                                                                               \
  }
#define SPECIAL_OPCODE(str, code, cost)                                                                                \
  if (name == str) {                                                                                                   \
    return Opcode::code;                                                                                               \
  }
#include "CostModel.inc"
  return Opcode::INVALID;
}

static float getDefaultCostByOpcode(Opcode opcode) {
#define OPCODE(str, code, cost)                                                                                        \
  if (Opcode::code == opcode) {                                                                                        \
    return static_cast<float>(cost);                                                                                   \
  }
#define SPECIAL_OPCODE(str, code, cost)                                                                                \
  if (Opcode::code == opcode) {                                                                                        \
    return static_cast<float>(cost);                                                                                   \
  }
#include "CostModel.inc"
  std::cerr << "cost model does not contain cost for opcode: " << static_cast<uint16_t>(opcode) << "\n";
  return 1.0f;
}

namespace {
struct CostModel {
  static CostModel const &ins() {
    static CostModel costModelParser{};
    return costModelParser;
  }

  float getCostByExpr(wasm::Expression *expr) const;
  float getCostByOpcode(Opcode opcode) const;

private:
  bool hasCostModel_;
  std::map<Opcode, float> cost_; // FIXME: should we use opcode to index?
  CostModel();
};

CostModel::CostModel() : hasCostModel_(false), cost_() {
  std::string const costModelPath = CostModelFile.get();
  if (costModelPath.empty()) {
    return;
  }
  hasCostModel_ = true;
  std::fstream costFile(costModelPath, std::ios::in);
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
    if (cost_.contains(opcode)) {
      throw std::runtime_error("Duplicate opcode in cost model: '" + opcodeStr + "'");
    }
    cost_.insert_or_assign(opcode, cost);
  }
}

float CostModel::getCostByExpr(wasm::Expression *expr) const {
  switch (expr->_id) {
  case wasm::Expression::BlockId:
    return getCostByOpcode(Opcode::BLOCK) + getCostByOpcode(Opcode::END);
  case wasm::Expression::IfId:
    return getCostByOpcode(Opcode::IF) +
           (expr->cast<wasm::If>()->ifFalse == nullptr ? 0.0f : getCostByOpcode(Opcode::ELSE)) +
           getCostByOpcode(Opcode::END);
  case wasm::Expression::LoopId:
    return getCostByOpcode(Opcode::LOOP) + getCostByOpcode(Opcode::END);
  case wasm::Expression::BreakId:
    return expr->cast<wasm::Break>()->condition == nullptr ? getCostByOpcode(Opcode::BR)
                                                           : getCostByOpcode(Opcode::BR_IF);
  case wasm::Expression::SwitchId:
    return getCostByOpcode(Opcode::BR_TABLE);
  case wasm::Expression::CallId:
    return getCostByOpcode(Opcode::CALL);
  case wasm::Expression::CallIndirectId:
    return getCostByOpcode(Opcode::CALL_INDIRECT);
  case wasm::Expression::LocalGetId:
    return getCostByOpcode(Opcode::LOCAL_GET);
  case wasm::Expression::LocalSetId:
    return expr->cast<wasm::LocalSet>()->isTee() ? getCostByOpcode(Opcode::LOCAL_TEE)
                                                 : getCostByOpcode(Opcode::LOCAL_SET);
  case wasm::Expression::GlobalGetId:
    return getCostByOpcode(Opcode::GLOBAL_GET);
  case wasm::Expression::GlobalSetId:
    return getCostByOpcode(Opcode::GLOBAL_SET);
  case wasm::Expression::LoadId: {
    auto *load = expr->cast<wasm::Load>();
    switch (load->type.getBasic()) {
    case wasm::Type::i32:
      return getCostByOpcode(Opcode::I32_LOAD);
    case wasm::Type::i64:
      return getCostByOpcode(Opcode::I64_LOAD);
    case wasm::Type::f32:
      return getCostByOpcode(Opcode::F32_LOAD);
    case wasm::Type::f64:
      return getCostByOpcode(Opcode::F64_LOAD);
    default:
      throw std::runtime_error("Unknown expression: " + toString(expr));
    }
  }
  case wasm::Expression::StoreId: {
    auto *store = expr->cast<wasm::Store>();
    switch (store->valueType.getBasic()) {
    case wasm::Type::i32:
      return getCostByOpcode(Opcode::I32_STORE);
    case wasm::Type::i64:
      return getCostByOpcode(Opcode::I64_STORE);
    case wasm::Type::f32:
      return getCostByOpcode(Opcode::F32_STORE);
    case wasm::Type::f64:
      return getCostByOpcode(Opcode::F64_STORE);
    default:
      throw std::runtime_error("Unknown expression: " + toString(expr));
    }
  }
  case wasm::Expression::ConstId:
    return getCostByOpcode(Opcode::I32_CONST);
  case wasm::Expression::UnaryId: {
    auto *unary = expr->cast<wasm::Unary>();
    switch (unary->op) {
    case wasm::UnaryOp::ClzInt32:
      return getCostByOpcode(Opcode::I32_CLZ);
    case wasm::UnaryOp::CtzInt32:
      return getCostByOpcode(Opcode::I32_CTZ);
    case wasm::UnaryOp::PopcntInt32:
      return getCostByOpcode(Opcode::I32_POPCNT);
    case wasm::UnaryOp::ClzInt64:
      return getCostByOpcode(Opcode::I64_CLZ);
    case wasm::UnaryOp::CtzInt64:
      return getCostByOpcode(Opcode::I64_CTZ);
    case wasm::UnaryOp::PopcntInt64:
      return getCostByOpcode(Opcode::I64_POPCNT);
    case wasm::UnaryOp::AbsFloat32:
      return getCostByOpcode(Opcode::F32_ABS);
    case wasm::UnaryOp::NegFloat32:
      return getCostByOpcode(Opcode::F32_NEG);
    case wasm::UnaryOp::CeilFloat32:
      return getCostByOpcode(Opcode::F32_CEIL);
    case wasm::UnaryOp::FloorFloat32:
      return getCostByOpcode(Opcode::F32_FLOOR);
    case wasm::UnaryOp::TruncFloat32:
      return getCostByOpcode(Opcode::F32_TRUNC);
    case wasm::UnaryOp::NearestFloat32:
      return getCostByOpcode(Opcode::F32_NEAREST);
    case wasm::UnaryOp::SqrtFloat32:
      return getCostByOpcode(Opcode::F32_SQRT);
    case wasm::UnaryOp::AbsFloat64:
      return getCostByOpcode(Opcode::F64_ABS);
    case wasm::UnaryOp::NegFloat64:
      return getCostByOpcode(Opcode::F64_NEG);
    case wasm::UnaryOp::CeilFloat64:
      return getCostByOpcode(Opcode::F64_CEIL);
    case wasm::UnaryOp::FloorFloat64:
      return getCostByOpcode(Opcode::F64_FLOOR);
    case wasm::UnaryOp::TruncFloat64:
      return getCostByOpcode(Opcode::F64_TRUNC);
    case wasm::UnaryOp::NearestFloat64:
      return getCostByOpcode(Opcode::F64_NEAREST);
    case wasm::UnaryOp::SqrtFloat64:
      return getCostByOpcode(Opcode::F64_SQRT);
    case wasm::UnaryOp::ExtendSInt32:
      return getCostByOpcode(Opcode::I64_EXTEND_I32_S);
    case wasm::UnaryOp::ExtendUInt32:
      return getCostByOpcode(Opcode::I64_EXTEND_I32_U);
    case wasm::UnaryOp::WrapInt64:
      return getCostByOpcode(Opcode::I32_WRAP_I64);
    case wasm::UnaryOp::TruncSFloat32ToInt32:
      return getCostByOpcode(Opcode::I32_TRUNC_F32_S);
    case wasm::UnaryOp::TruncUFloat32ToInt32:
      return getCostByOpcode(Opcode::I32_TRUNC_F32_U);
    case wasm::UnaryOp::TruncSFloat64ToInt32:
      return getCostByOpcode(Opcode::I32_TRUNC_F64_S);
    case wasm::UnaryOp::TruncUFloat64ToInt32:
      return getCostByOpcode(Opcode::I32_TRUNC_F64_U);
    case wasm::UnaryOp::TruncSFloat32ToInt64:
      return getCostByOpcode(Opcode::I64_TRUNC_F32_S);
    case wasm::UnaryOp::TruncUFloat32ToInt64:
      return getCostByOpcode(Opcode::I64_TRUNC_F32_U);
    case wasm::UnaryOp::TruncSFloat64ToInt64:
      return getCostByOpcode(Opcode::I64_TRUNC_F64_S);
    case wasm::UnaryOp::TruncUFloat64ToInt64:
      return getCostByOpcode(Opcode::I64_TRUNC_F64_U);
    case wasm::UnaryOp::ConvertSInt32ToFloat32:
      return getCostByOpcode(Opcode::F32_CONVERT_I32_S);
    case wasm::UnaryOp::ConvertUInt32ToFloat32:
      return getCostByOpcode(Opcode::F32_CONVERT_I32_U);
    case wasm::UnaryOp::ConvertSInt64ToFloat32:
      return getCostByOpcode(Opcode::F32_CONVERT_I64_S);
    case wasm::UnaryOp::ConvertUInt64ToFloat32:
      return getCostByOpcode(Opcode::F32_CONVERT_I64_U);
    case wasm::UnaryOp::ConvertSInt32ToFloat64:
      return getCostByOpcode(Opcode::F64_CONVERT_I32_S);
    case wasm::UnaryOp::ConvertUInt32ToFloat64:
      return getCostByOpcode(Opcode::F64_CONVERT_I32_U);
    case wasm::UnaryOp::ConvertSInt64ToFloat64:
      return getCostByOpcode(Opcode::F64_CONVERT_I64_S);
    case wasm::UnaryOp::ConvertUInt64ToFloat64:
      return getCostByOpcode(Opcode::F64_CONVERT_I64_U);
    case wasm::UnaryOp::PromoteFloat32:
      return getCostByOpcode(Opcode::F64_PROMOTE_F32);
    case wasm::UnaryOp::DemoteFloat64:
      return getCostByOpcode(Opcode::F32_DEMOTE_F64);
    case wasm::UnaryOp::ReinterpretInt32:
      return getCostByOpcode(Opcode::F32_REINTERPRET_I32);
    case wasm::UnaryOp::ReinterpretInt64:
      return getCostByOpcode(Opcode::F64_REINTERPRET_I64);
    case wasm::UnaryOp::ReinterpretFloat32:
      return getCostByOpcode(Opcode::I32_REINTERPRET_F32);
    case wasm::UnaryOp::ReinterpretFloat64:
      return getCostByOpcode(Opcode::I64_REINTERPRET_F64);
    case wasm::UnaryOp::ExtendS8Int32:
      return getCostByOpcode(Opcode::I32_EXTEND8_S);
    case wasm::UnaryOp::ExtendS16Int32:
      return getCostByOpcode(Opcode::I32_EXTEND16_S);
    case wasm::UnaryOp::ExtendS8Int64:
      return getCostByOpcode(Opcode::I64_EXTEND8_S);
    case wasm::UnaryOp::ExtendS16Int64:
      return getCostByOpcode(Opcode::I64_EXTEND16_S);
    case wasm::UnaryOp::ExtendS32Int64:
      return getCostByOpcode(Opcode::I64_EXTEND32_S);
    case wasm::UnaryOp::TruncSatSFloat32ToInt32:
      return getCostByOpcode(Opcode::I32_TRUNC_SAT_F32_S);
    case wasm::UnaryOp::TruncSatUFloat32ToInt32:
      return getCostByOpcode(Opcode::I32_TRUNC_SAT_F32_U);
    case wasm::UnaryOp::TruncSatSFloat64ToInt32:
      return getCostByOpcode(Opcode::I32_TRUNC_SAT_F64_S);
    case wasm::UnaryOp::TruncSatUFloat64ToInt32:
      return getCostByOpcode(Opcode::I32_TRUNC_SAT_F64_U);
    case wasm::UnaryOp::TruncSatSFloat32ToInt64:
      return getCostByOpcode(Opcode::I64_TRUNC_SAT_F32_S);
    case wasm::UnaryOp::TruncSatUFloat32ToInt64:
      return getCostByOpcode(Opcode::I64_TRUNC_SAT_F32_U);
    case wasm::UnaryOp::TruncSatSFloat64ToInt64:
      return getCostByOpcode(Opcode::I64_TRUNC_SAT_F64_S);
    case wasm::UnaryOp::TruncSatUFloat64ToInt64:
      return getCostByOpcode(Opcode::I64_TRUNC_SAT_F64_U);
    case wasm::EqZInt32:
      return getCostByOpcode(Opcode::I32_EQZ);
    case wasm::EqZInt64:
      return getCostByOpcode(Opcode::I64_EQZ);
    default:
      throw std::runtime_error("Unknown unary operation: " + toString(expr));
    }
  }
  case wasm::Expression::BinaryId: {
    auto *binary = expr->cast<wasm::Binary>();
    switch (binary->op) {
    case wasm::BinaryOp::AddInt32:
      return getCostByOpcode(Opcode::I32_ADD);
    case wasm::BinaryOp::SubInt32:
      return getCostByOpcode(Opcode::I32_SUB);
    case wasm::BinaryOp::MulInt32:
      return getCostByOpcode(Opcode::I32_MUL);
    case wasm::BinaryOp::DivSInt32:
      return getCostByOpcode(Opcode::I32_DIV_S);
    case wasm::BinaryOp::DivUInt32:
      return getCostByOpcode(Opcode::I32_DIV_U);
    case wasm::BinaryOp::RemSInt32:
      return getCostByOpcode(Opcode::I32_REM_S);
    case wasm::BinaryOp::RemUInt32:
      return getCostByOpcode(Opcode::I32_REM_U);
    case wasm::BinaryOp::AndInt32:
      return getCostByOpcode(Opcode::I32_AND);
    case wasm::BinaryOp::OrInt32:
      return getCostByOpcode(Opcode::I32_OR);
    case wasm::BinaryOp::XorInt32:
      return getCostByOpcode(Opcode::I32_XOR);
    case wasm::BinaryOp::ShlInt32:
      return getCostByOpcode(Opcode::I32_SHL);
    case wasm::BinaryOp::ShrSInt32:
      return getCostByOpcode(Opcode::I32_SHR_S);
    case wasm::BinaryOp::ShrUInt32:
      return getCostByOpcode(Opcode::I32_SHR_U);
    case wasm::BinaryOp::RotLInt32:
      return getCostByOpcode(Opcode::I32_ROTL);
    case wasm::BinaryOp::RotRInt32:
      return getCostByOpcode(Opcode::I32_ROTR);
    case wasm::BinaryOp::EqInt32:
      return getCostByOpcode(Opcode::I32_EQ);
    case wasm::BinaryOp::NeInt32:
      return getCostByOpcode(Opcode::I32_NE);
    case wasm::BinaryOp::LtSInt32:
      return getCostByOpcode(Opcode::I32_LT_S);
    case wasm::BinaryOp::LtUInt32:
      return getCostByOpcode(Opcode::I32_LT_U);
    case wasm::BinaryOp::GtSInt32:
      return getCostByOpcode(Opcode::I32_GT_S);
    case wasm::BinaryOp::GtUInt32:
      return getCostByOpcode(Opcode::I32_GT_U);
    case wasm::BinaryOp::LeSInt32:
      return getCostByOpcode(Opcode::I32_LE_S);
    case wasm::BinaryOp::LeUInt32:
      return getCostByOpcode(Opcode::I32_LE_U);
    case wasm::BinaryOp::GeSInt32:
      return getCostByOpcode(Opcode::I32_GE_S);
    case wasm::BinaryOp::GeUInt32:
      return getCostByOpcode(Opcode::I32_GE_U);

    case wasm::BinaryOp::AddInt64:
      return getCostByOpcode(Opcode::I64_ADD);
    case wasm::BinaryOp::SubInt64:
      return getCostByOpcode(Opcode::I64_SUB);
    case wasm::BinaryOp::MulInt64:
      return getCostByOpcode(Opcode::I64_MUL);
    case wasm::BinaryOp::DivSInt64:
      return getCostByOpcode(Opcode::I64_DIV_S);
    case wasm::BinaryOp::DivUInt64:
      return getCostByOpcode(Opcode::I64_DIV_U);
    case wasm::BinaryOp::RemSInt64:
      return getCostByOpcode(Opcode::I64_REM_S);
    case wasm::BinaryOp::RemUInt64:
      return getCostByOpcode(Opcode::I64_REM_U);
    case wasm::BinaryOp::AndInt64:
      return getCostByOpcode(Opcode::I64_AND);
    case wasm::BinaryOp::OrInt64:
      return getCostByOpcode(Opcode::I64_OR);
    case wasm::BinaryOp::XorInt64:
      return getCostByOpcode(Opcode::I64_XOR);
    case wasm::BinaryOp::ShlInt64:
      return getCostByOpcode(Opcode::I64_SHL);
    case wasm::BinaryOp::ShrSInt64:
      return getCostByOpcode(Opcode::I64_SHR_S);
    case wasm::BinaryOp::ShrUInt64:
      return getCostByOpcode(Opcode::I64_SHR_U);
    case wasm::BinaryOp::RotLInt64:
      return getCostByOpcode(Opcode::I64_ROTL);
    case wasm::BinaryOp::RotRInt64:
      return getCostByOpcode(Opcode::I64_ROTR);
    case wasm::BinaryOp::EqInt64:
      return getCostByOpcode(Opcode::I64_EQ);
    case wasm::BinaryOp::NeInt64:
      return getCostByOpcode(Opcode::I64_NE);
    case wasm::BinaryOp::LtSInt64:
      return getCostByOpcode(Opcode::I64_LT_S);
    case wasm::BinaryOp::LtUInt64:
      return getCostByOpcode(Opcode::I64_LT_U);
    case wasm::BinaryOp::GtSInt64:
      return getCostByOpcode(Opcode::I64_GT_S);
    case wasm::BinaryOp::GtUInt64:
      return getCostByOpcode(Opcode::I64_GT_U);
    case wasm::BinaryOp::LeSInt64:
      return getCostByOpcode(Opcode::I64_LE_S);
    case wasm::BinaryOp::LeUInt64:
      return getCostByOpcode(Opcode::I64_LE_U);
    case wasm::BinaryOp::GeSInt64:
      return getCostByOpcode(Opcode::I64_GE_S);
    case wasm::BinaryOp::GeUInt64:
      return getCostByOpcode(Opcode::I64_GE_U);

    case wasm::BinaryOp::AddFloat32:
      return getCostByOpcode(Opcode::F32_ADD);
    case wasm::BinaryOp::SubFloat32:
      return getCostByOpcode(Opcode::F32_SUB);
    case wasm::BinaryOp::MulFloat32:
      return getCostByOpcode(Opcode::F32_MUL);
    case wasm::BinaryOp::DivFloat32:
      return getCostByOpcode(Opcode::F32_DIV);
    case wasm::BinaryOp::MinFloat32:
      return getCostByOpcode(Opcode::F32_MIN);
    case wasm::BinaryOp::MaxFloat32:
      return getCostByOpcode(Opcode::F32_MAX);
    case wasm::BinaryOp::CopySignFloat32:
      return getCostByOpcode(Opcode::F32_COPYSIGN);
    case wasm::BinaryOp::EqFloat32:
      return getCostByOpcode(Opcode::F32_EQ);
    case wasm::BinaryOp::NeFloat32:
      return getCostByOpcode(Opcode::F32_NE);
    case wasm::BinaryOp::LtFloat32:
      return getCostByOpcode(Opcode::F32_LT);
    case wasm::BinaryOp::GtFloat32:
      return getCostByOpcode(Opcode::F32_GT);
    case wasm::BinaryOp::LeFloat32:
      return getCostByOpcode(Opcode::F32_LE);
    case wasm::BinaryOp::GeFloat32:
      return getCostByOpcode(Opcode::F32_GE);

    case wasm::BinaryOp::AddFloat64:
      return getCostByOpcode(Opcode::F64_ADD);
    case wasm::BinaryOp::SubFloat64:
      return getCostByOpcode(Opcode::F64_SUB);
    case wasm::BinaryOp::MulFloat64:
      return getCostByOpcode(Opcode::F64_MUL);
    case wasm::BinaryOp::DivFloat64:
      return getCostByOpcode(Opcode::F64_DIV);
    case wasm::BinaryOp::MinFloat64:
      return getCostByOpcode(Opcode::F64_MIN);
    case wasm::BinaryOp::MaxFloat64:
      return getCostByOpcode(Opcode::F64_MAX);
    case wasm::BinaryOp::CopySignFloat64:
      return getCostByOpcode(Opcode::F64_COPYSIGN);
    case wasm::BinaryOp::EqFloat64:
      return getCostByOpcode(Opcode::F64_EQ);
    case wasm::BinaryOp::NeFloat64:
      return getCostByOpcode(Opcode::F64_NE);
    case wasm::BinaryOp::LtFloat64:
      return getCostByOpcode(Opcode::F64_LT);
    case wasm::BinaryOp::GtFloat64:
      return getCostByOpcode(Opcode::F64_GT);
    case wasm::BinaryOp::LeFloat64:
      return getCostByOpcode(Opcode::F64_LE);
    case wasm::BinaryOp::GeFloat64:
      return getCostByOpcode(Opcode::F64_GE);

    default:
      throw std::runtime_error("Unknown unary operation: " + toString(expr));
    }
  }
  case wasm::Expression::SelectId:
    return getCostByOpcode(Opcode::SELECT);
  case wasm::Expression::DropId:
    return getCostByOpcode(Opcode::DROP);
  case wasm::Expression::ReturnId:
    return getCostByOpcode(Opcode::RETURN);
  case wasm::Expression::MemorySizeId:
    return getCostByOpcode(Opcode::MEMORY_SIZE);
  case wasm::Expression::MemoryGrowId:
    return getCostByOpcode(Opcode::MEMORY_GROW);

  case wasm::Expression::NopId:
    return getCostByOpcode(Opcode::NOP);
  case wasm::Expression::UnreachableId:
    return getCostByOpcode(Opcode::UNREACHABLE);

  case wasm::Expression::MemoryInitId:
    return getCostByOpcode(Opcode::MEMORY_INIT);
  case wasm::Expression::DataDropId:
    return getCostByOpcode(Opcode::DATA_DROP);
  case wasm::Expression::MemoryCopyId:
    return getCostByOpcode(Opcode::MEMORY_COPY);
  case wasm::Expression::MemoryFillId:
    return getCostByOpcode(Opcode::MEMORY_FILL);
  default:
    throw std::runtime_error("Unknown expression: " + toString(expr));
  }
}

float CostModel::getCostByOpcode(Opcode opcode) const {
  auto it = cost_.find(opcode);
  if (it == cost_.end())
    return getDefaultCostByOpcode(opcode);
  return it->second;
}

} // namespace
} // namespace warpo::passes

float warpo::passes::getFunctionCost() {
  return CostModel::ins().getCostByOpcode(Opcode::FUNC) + CostModel::ins().getCostByOpcode(Opcode::END);
}

float warpo::passes::getOpcodeCost(wasm::Expression *expr) { return CostModel::ins().getCostByExpr(expr); }

float warpo::passes::getOpcodeCost(Opcode opcode) { return CostModel::ins().getCostByOpcode(opcode); }

float warpo::passes::measureCost(wasm::Expression *expr) {
  struct CostMeasure : public wasm::PostWalker<CostMeasure, wasm::UnifiedExpressionVisitor<CostMeasure>> {
    float cost = 0;
    void visitExpression(wasm::Expression *expr) { cost += CostModel::ins().getCostByExpr(expr); }
  };
  CostMeasure measurer{};
  measurer.walk(expr);
  return measurer.cost;
}
