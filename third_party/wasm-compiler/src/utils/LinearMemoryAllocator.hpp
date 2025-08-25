///
/// @file LinearMemoryAllocator.hpp
/// @copyright Copyright (C) 2022, BMW Group
///

#ifndef LINEAR_MEMORY_ALLOCATOR_HPP
#define LINEAR_MEMORY_ALLOCATOR_HPP

#include <atomic>
#include <cstddef>
#include <cstdint>

#include "VirtualMemoryAllocator.hpp"

#include "src/config.hpp"
#include "src/core/common/WasmConstants.hpp"
#include "src/core/common/util.hpp"

namespace vb {
///
/// @brief Allocator of Wasm Linear memory in passive linear memory protection mode
///
class LinearMemoryAllocator final {
public:
  ///
  /// @brief Construct a new LinearMemoryAllocator
  ///
  explicit LinearMemoryAllocator() VB_NOEXCEPT;
  LinearMemoryAllocator(LinearMemoryAllocator const &) = delete;
  ///
  /// @brief Move constructor
  ///
  /// @param other
  ///
  LinearMemoryAllocator(LinearMemoryAllocator &&other) VB_NOEXCEPT;
  LinearMemoryAllocator &operator=(LinearMemoryAllocator const &) & = delete;
  ///
  /// @brief Move assignment
  ///
  /// @param other
  /// @return LinearMemoryAllocator&
  ///
  LinearMemoryAllocator &operator=(LinearMemoryAllocator &&other) & VB_NOEXCEPT;
  ///
  /// @brief user-defined no-throw swap function
  ///
  /// @param lhs Left hand side Object
  /// @param rhs Right hand side Object
  static inline void swap(LinearMemoryAllocator &lhs, LinearMemoryAllocator &&rhs) VB_NOEXCEPT {
    if (&lhs != &rhs) {
      lhs.virtualMemoryAllocator_ = std::move(rhs.virtualMemoryAllocator_);
      lhs.pagedBasedataSize_ = rhs.pagedBasedataSize_;
      lhs.linMemPages_ = rhs.linMemPages_;
      lhs.pagedMemoryLimit_.store(std::move(rhs.pagedMemoryLimit_));
    }
  }
  ///
  /// @brief Default destructor
  ///
  ~LinearMemoryAllocator() = default;
  ///
  /// @brief Initialize the memory for a WebAssembly module so that the linear memory after the basedata starts at a
  /// memory page boundary
  ///
  /// @param basedataSize Size of the module's basedata section in the job memory (Part before the linear memory starts)
  /// @param initialLinMemPages Maximum size of the module's linear memory (in Wasm pages)
  /// @return void* Start of the WebAssembly basedata
  /// @throws std::runtime_error allocate initial memory failed
  void *init(uint32_t const basedataSize, uint32_t const initialLinMemPages);
  ///
  /// @brief extend linear memory
  ///
  /// @param newTotalLinMemPages new total linear memory pages
  /// @return true extend success
  /// @return false extend failed
  ///
  bool extend(uint32_t const newTotalLinMemPages) VB_NOEXCEPT;
  ///
  /// @brief shrink linear memory to minimal length
  ///
  /// @param minimumLength the minimal length needed by linear memory
  /// @return true shrink success
  /// @return false shrink failed
  ///
  bool shrink(uint32_t const minimumLength) VB_NOEXCEPT;
  ///
  /// @brief probe access the linear memory
  ///
  /// @param linMemOffset the linear memory offset to probe
  /// @return true The probe address is ready commited or commit success
  /// @return false Commit failed during probe
  ///
  bool probe(uint32_t const linMemOffset) VB_NOEXCEPT;
  ///
  /// @brief Get the Memory Usage
  ///
  /// @return Memory usage in bytes
  ///
  inline uint64_t getMemoryUsage() const VB_NOEXCEPT {
    return virtualMemoryAllocator_.getCommitedSize();
  }
  ///
  /// @brief Calculate linear memory size
  ///
  /// @param baseDataSize base data size
  /// @return uint32_t Actual linear memory size
  ///
  uint32_t getLinearMemorySize(uint32_t const baseDataSize) const VB_NOEXCEPT;
  ///
  /// @brief Get the Memory Limit
  ///
  /// @return Memory limit in bytes
  ///
  inline uint64_t getMemoryLimit() const VB_NOEXCEPT {
    return pagedMemoryLimit_.load();
  }
  ///
  /// @brief Set the Memory Limit
  ///
  /// @param memoryLimit new memory limit in bytes
  /// @throws std::runtime_error new memory limit is less than already used memory
  ///
  void setMemoryLimit(uint64_t const memoryLimit);

  static constexpr size_t offsetGuardRegionSize{WasmConstants::maxLinearMemoryOffset +
                                                (1_U64 << 16_U64)}; ///< The maximal possible accessed size by Wasm

private:
  ///
  /// @brief Let the virtualMemoryAllocator to commit virtual memory
  ///
  /// @param newPagedSize new total size to commit
  /// @return true commit success
  /// @return false new size is larger than memory limit, commit failed.
  /// @throws std::runtime_error commit memory failed
  ///
  bool commit(size_t const newPagedSize);

  VirtualMemoryAllocator virtualMemoryAllocator_; ///< The virtual memory allocator
  size_t pagedBasedataSize_;                      ///< The base data size
  uint32_t linMemPages_;                          ///< The pages of the linear memory
  std::atomic<uint64_t> pagedMemoryLimit_;        ///< The OS page aligned memory limit
};

} // namespace vb

#endif
