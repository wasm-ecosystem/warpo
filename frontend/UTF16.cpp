// Copyright (C) 2025 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

#include <stdexcept>
#include <string>
#include <string_view>

#include "UTF16.hpp"
#include "llvm/Support/ConvertUTF.h"

namespace warpo::frontend {

static_assert(sizeof(std::string_view::value_type) == sizeof(llvm::UTF8),
              "std::string::value_type and llvm::UTF8 must have the same size");
static_assert(sizeof(std::u16string_view::value_type) == sizeof(llvm::UTF16),
              "std::u16string::value_type and llvm::UTF16 must have the same size");

std::u16string utf16::fromUTF8(std::string_view utf8Str) {
  if (utf8Str.empty())
    return std::u16string{};
  const llvm::UTF8 *src = reinterpret_cast<const llvm::UTF8 *>(&utf8Str[0]);
  llvm::UTF8 const *const srcEnd = reinterpret_cast<const llvm::UTF8 *>(&utf8Str[utf8Str.size()]);
  std::u16string utf16Str;
  utf16Str.resize(utf8Str.size());
  llvm::UTF16 *dst = reinterpret_cast<llvm::UTF16 *>(utf16Str.data());
  llvm::UTF16 *const dstEnd = dst + utf16Str.size();

  if (llvm::ConvertUTF8toUTF16(&src, srcEnd, &dst, dstEnd, llvm::strictConversion) != llvm::conversionOK)
    throw std::runtime_error("UTF8 to UTF16 conversion failed");
  // Resize the string to the actual number of UTF-16 code units written.
  // The pointer subtraction yields a ptrdiff_t; it must be non-negative and fit into size_t.
  ptrdiff_t const written16 = dst - reinterpret_cast<llvm::UTF16 *>(utf16Str.data());
  utf16Str.resize(static_cast<std::u16string::size_type>(written16));
  return utf16Str;
}

std::string utf16::toUTF8(std::u16string_view utf16Str) {
  if (utf16Str.empty())
    return std::string{};
  const llvm::UTF16 *src = reinterpret_cast<const llvm::UTF16 *>(&utf16Str[0]);
  llvm::UTF16 const *const srcEnd = reinterpret_cast<const llvm::UTF16 *>(&utf16Str[utf16Str.size()]);
  std::string utf8Str;
  utf8Str.resize(utf16Str.size() * 2); // UTF-8 can be up to 4 bytes per Unicode code point
  llvm::UTF8 *dst = reinterpret_cast<llvm::UTF8 *>(&utf8Str[0]);
  llvm::UTF8 *const dstEnd = reinterpret_cast<llvm::UTF8 *>(&utf8Str[utf8Str.size()]);

  if (llvm::ConvertUTF16toUTF8(&src, srcEnd, &dst, dstEnd, llvm::strictConversion) != llvm::conversionOK)
    throw std::runtime_error("UTF16 to UTF8 conversion failed");
  // Resize the string to the actual number of UTF-8 bytes written.
  ptrdiff_t const written8 = dst - reinterpret_cast<llvm::UTF8 *>(utf8Str.data());
  utf8Str.resize(static_cast<std::string::size_type>(written8));
  return utf8Str;
}

} // namespace warpo::frontend
