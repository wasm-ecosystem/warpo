#ifndef __ASC_COV_BASICBLOCK_WALKER_HPP__
#define __ASC_COV_BASICBLOCK_WALKER_HPP__
#include <algorithm>
#include <cstddef>
#include <cstdint>
#include <cstdlib>
#include <memory>
#include <vector>
#include "BasicBlockAnalysis.hpp"
#include "cfg/cfg-traversal.h"
#include "ir/module-utils.h"
#include "support/index.h"
#include "wasm.h"
namespace wasmInstrumentation {

struct InstrumentPosition {
  wasm::Index basicBlockIndex;
  bool pre; // pre = true means instrument before expression
};

///
///@brief information about debugLocation in a basic block
///
class BasicBlockInfo final {
public:
  ///
  /// @brief Copy constructor for BasicBlockInfo
  ///
  /// @param src
  BasicBlockInfo(const BasicBlockInfo &src) noexcept
      : exprs(src.exprs), debugLocations(src.debugLocations), basicBlockIndex(src.basicBlockIndex) {
  }

  ///
  /// @brief Move constructor for BasicBlockInfo
  ///
  /// @param src
  BasicBlockInfo(BasicBlockInfo &&src) noexcept
      : exprs(std::move(src.exprs)), debugLocations(std::move(src.debugLocations)),
        basicBlockIndex(src.basicBlockIndex) {
  }

  ///
  /// @brief Destructors for BasicBlockInfo
  ///
  ~BasicBlockInfo() noexcept {
    basicBlockIndex = static_cast<wasm::Index>(-1);
  }

  ///
  /// @brief Default constructor for BasicBlockInfo
  ///
  BasicBlockInfo() noexcept : basicBlockIndex(static_cast<wasm::Index>(-1)) {
  }

  ///
  /// @brief Copy equal operator function
  ///
  BasicBlockInfo &operator=(const BasicBlockInfo &src) noexcept {
    this->exprs = src.exprs;
    this->debugLocations = src.debugLocations;
    this->basicBlockIndex = src.basicBlockIndex;
    return *this;
  }

  ///
  /// @brief moves equal operator function
  ///
  BasicBlockInfo &operator=(BasicBlockInfo &&src) noexcept {
    this->exprs = std::move(src.exprs);
    this->debugLocations = std::move(src.debugLocations);
    this->basicBlockIndex = src.basicBlockIndex;
    src.basicBlockIndex = static_cast<wasm::Index>(-1);
    return *this;
  }
  std::vector<wasm::Expression *> exprs;                  ///< expressions
  std::set<wasm::Function::DebugLocation> debugLocations; ///< debug infos
  wasm::Index basicBlockIndex;                            ///< basic block ID
};

/// @brief Class for the analysis result of each function of analysis
class FunctionAnalysisResult final {
public:
  /// @brief Default constructor of FunctionAnalysisResult
  FunctionAnalysisResult() noexcept : functionIndex(static_cast<wasm::Index>(-1)) {
  }
  std::vector<BasicBlockInfo> basicBlocks;                     ///< basicBlocks in this function
  std::vector<std::pair<wasm::Index, wasm::Index>> branchInfo; ///< function branch info
  wasm::Index functionIndex;                                   ///< function Index
};

///
///@brief Basic block walker with basic block information
///
class BasicBlockWalker final
    : public wasm::WalkerPass<wasm::CFGWalker<
          BasicBlockWalker, wasm::UnifiedExpressionVisitor<BasicBlockWalker>, BasicBlockInfo>> {
public:
  ///
  /// @brief Constructor for BasicBlockWalker
  ///
  /// @param _module
  /// @param _reportFunName
  BasicBlockWalker(wasm::Module *const _module, BasicBlockAnalysis &_basicBlockAnalysis) noexcept
      : module(_module), basicBlockAnalysis(_basicBlockAnalysis) {
  }
  BasicBlockWalker(const BasicBlockWalker &src) = delete;
  BasicBlockWalker(BasicBlockWalker &&src) = delete;
  BasicBlockWalker &operator=(const BasicBlockWalker &) = delete;
  BasicBlockWalker &operator=(BasicBlockWalker &&) = delete;

  ///
  /// @brief Destructor for BasicBlockWalker
  ///
  ~BasicBlockWalker() noexcept override = default;

  ///
  ///@brief Inherit from CFGWalker for expression visitor
  ///
  ///@param curr Current expression
  void visitExpression(wasm::Expression *const curr) noexcept;

  static void doEndBlock(BasicBlockWalker* self, wasm::Expression** currp);

  ///
  ///@brief Inherit from CFGWalker for function visitor
  ///
  ///@param func Current function
  void doWalkFunction(wasm::Function *const func) noexcept;

  ///
  /// @brief Search function id by function Name
  ///
  /// @param name
  /// @return Function ID
  wasm::Index getFunctionIndexByName(const std::string_view &funcName) const noexcept;

  ///
  /// @brief Query coverage instrument position by expression reference
  ///
  /// @param expr
  ///
  const std::vector<InstrumentPosition> *
  getCovInstrumentPosition(wasm::Expression *const expr) const noexcept;

  BasicBlockAnalysis getBasicBlockAnalysis() const noexcept;

  ///
  /// @brief basicBlock walk
  ///
  void basicBlockWalk() noexcept;

  inline const std::unordered_map<std::string_view, FunctionAnalysisResult> &
  getResults() const noexcept {
    return results;
  }

private:
  wasm::Module *const module;                   ///< working wasm module
  wasm::Index functionIndex = 0U;               ///< function Index
  const BasicBlockAnalysis &basicBlockAnalysis; ///< include analysis
  std::unordered_map<wasm::Expression *, std::vector<InstrumentPosition>> covInstrumentPosition;
  std::unordered_map<std::string_view, FunctionAnalysisResult> results; ///< analysis results
  ///
  /// @brief traverse CFG to set the instrumentation position
  ///
  void setCovInstrumentPosition(wasm::Expression *const expr,
                                const InstrumentPosition &position) noexcept;
  ///
  /// @brief remove empty block that do not belong to any branch
  ///
  void cleanBlock() noexcept;
};
} // namespace wasmInstrumentation

#endif
