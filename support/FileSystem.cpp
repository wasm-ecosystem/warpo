// Copyright (C) 2024 Bayerische Motoren Werke Aktiengesellschaft (BMW AG)
// Copyright (C) 2025 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

#include <filesystem>
#include <fmt/format.h>
#include <fstream>
#include <ios>
#include <sstream>
#include <stdexcept>

#include "warpo/support/FileSystem.hpp"

void warpo::ensureFileDirectory(const std::filesystem::path &filePath) {
  std::filesystem::path const dirPath = filePath.parent_path();
  ensureDirectory(dirPath);
}

void warpo::ensureDirectory(const std::filesystem::path &dirPath) {
  if (std::filesystem::exists(dirPath)) {
    if (!std::filesystem::is_directory(dirPath)) {
      throw std::runtime_error(fmt::format("Path '{}' exists and is not a directory", dirPath.string()));
    }
  }
  std::error_code ec;
  std::filesystem::create_directories(dirPath, ec);
  if (ec) {
    throw std::runtime_error(
        fmt::format("Failed to create directories for path '{}': {}", dirPath.string(), ec.message()));
  }
}

std::string warpo::getBaseName(std::filesystem::path const &path) { return path.filename().string(); }

std::filesystem::path warpo::replaceExtension(std::filesystem::path const &path, std::filesystem::path const &newExt) {
  std::filesystem::path newPath = path;
  newPath.replace_extension(newExt);
  return newPath;
}

std::string warpo::readTextFile(std::string const &path) {
  if (!std::filesystem::exists(path))
    throw std::runtime_error{"cannot open file: " + path};
  std::ifstream ifs{path, std::ios::in};
  if (!ifs.is_open())
    throw std::runtime_error{"cannot open file: " + path};
  std::stringstream buffer;
  buffer << ifs.rdbuf();
  return std::move(buffer).str();
}

std::string warpo::readBinaryFile(std::string const &path) {
  if (!std::filesystem::exists(path))
    throw std::runtime_error{"cannot open file: " + path};
  std::ifstream ifs{path, std::ios::in | std::ios::binary};
  if (!ifs.is_open())
    throw std::runtime_error{"cannot open file: " + path};
  std::stringstream buffer;
  buffer << ifs.rdbuf();
  return std::move(buffer).str();
}

void warpo::writeBinaryFile(std::string const &path, std::string data) {
  std::ofstream out{path, std::ios::binary};
  if (!out.good())
    throw std::runtime_error("cannot open file " + path);
  out << data;
}

#ifdef WARPO_ENABLE_UNIT_TESTS

#include <gtest/gtest.h>
namespace warpo::ut {

TEST(FsTest, BaseName) { EXPECT_EQ(getBaseName("a/b/c.d"), "c.d"); }

} // namespace warpo::ut

#endif
