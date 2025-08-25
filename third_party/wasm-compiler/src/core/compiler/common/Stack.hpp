///
/// @file Stack.hpp
/// @copyright Copyright (C) 2021 BMW Group
///
/// Compiler stack
///

#ifndef STACK_HPP
#define STACK_HPP

#include <cassert>
#include <cstddef>
#include <cstdint>
#include <type_traits>

#include "StackElement.hpp"

#include "src/config.hpp"
#include "src/core/common/util.hpp"
#include "src/core/compiler/common/BumpAllocator.hpp"
#include "src/core/compiler/common/ListIterator.hpp"

namespace vb {

///
/// @brief Stack for the compiler where not-yet-emitted WebAssembly instructions and variables will be stored during
/// compilation
///
/// This is vaguely related to the operand stack of a WebAssembly module
///
class Stack final {
public:
  using node = List_node<StackElement>;                     ///< node
  using iterator = List_iterator<StackElement>;             ///< iterator
  using const_iterator = List_const_iterator<StackElement>; ///< const_iterator

  ///
  /// @brief Default constructor
  ///
  Stack() VB_NOEXCEPT;

  ///
  /// @brief Constructor
  ///
  /// @param compilerMemoryAllocFnc AllocFnc for internal compiler memory
  /// @param compilerMemoryFreeFnc FreeFnc for internal compiler memory
  /// @param ctx User defined context
  ///
  explicit Stack(AllocFnc const compilerMemoryAllocFnc, FreeFnc const compilerMemoryFreeFnc, void *const ctx);

  /// @brief first iterator
  iterator begin() VB_NOEXCEPT {
    return iterator{sentinel_->next};
  }

  /// @brief last iterator
  iterator end() VB_NOEXCEPT {
    return iterator(sentinel_);
  }

  /// @brief first const_iterator
  const_iterator cbegin() const VB_NOEXCEPT {
    return const_iterator{sentinel_->next};
  }

  /// @brief last const_iterator
  const_iterator cend() const VB_NOEXCEPT {
    return const_iterator(sentinel_);
  }

  /// @brief is empty
  /// @return true when empty
  bool empty() const VB_NOEXCEPT {
    return cbegin() == cend();
  }

  ///
  /// @brief Pushes a StackElement onto the stack
  ///
  /// @param element StackElement to push onto the stack
  /// @return StackElement* Pointer to the stack element on the stack
  /// @throws std::range_error If not enough memory is available
  iterator push(StackElement const &element);

  ///
  /// @brief Pops a StackElement from the top of the stack and returns it
  void pop() VB_NOEXCEPT;

  ///
  /// @brief last element, unsafe
  ///
  StackElement &unsafeBack() VB_NOEXCEPT {
    iterator tmp{end()};
    --tmp;
    return *tmp;
  }

  ///
  /// @brief last element
  ///
  /// @throw No_element_on_stack
  StackElement &back();

  ///
  /// @brief last iterator
  ///
  iterator last() VB_NOEXCEPT {
    return end().prev();
  }

  ///
  /// @brief erase iterator
  ///
  /// @param position Iterator to erase
  iterator erase(iterator const position) VB_NOEXCEPT;

  ///
  /// @brief insert given element before specified iterator
  /// @param position Specified iterator
  /// @param element Given StackElement
  /// @return An iterator that points to the inserted element.
  iterator insert(iterator const position, StackElement const &element);

  ///
  /// @brief Find the first occurrence of a StackElement in stack.
  ///
  /// @param ptr Pointer points to the StackElement
  /// @return An valid iterator if the element is on the stack, empty iterator otherwise
  iterator find(StackElement const *const ptr) VB_NOEXCEPT;

  ///
  /// @brief Init the stack, allocate the sentinel node
  inline void init() {
    sentinel_ = vb::pCast<node *>(allocator_.step());
    sentinel_->value.type = StackType::INVALID;
    sentinel_->prev = sentinel_;
    sentinel_->next = sentinel_;
    size_ = 0U;
  }

  ///
  /// @brief reset the stack
  void reset() {
    allocator_.reset();
    init();
  }

private:
  FixedBumpAllocator<sizeof(node)> allocator_; ///< Underlying allocator manages instance/memory where the StackElements in the Stack are stored
  node *sentinel_;                             ///< The sentinel node hold the head and tail iterator
  uint32_t size_;                              ///< The number of elements on the stack
};

} // namespace vb

#endif // STACK_HPP
