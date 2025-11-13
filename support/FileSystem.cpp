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

std::ofstream warpo::openOFStream(std::filesystem::path const &file, std::ios_base::openmode mode) {
  ensureFileDirectory(file);
  std::ofstream of{file, mode};
  if (!of.good())
    throw std::runtime_error("cannot open file " + file.string());
  return of;
}

void warpo::ensureFileDirectory(const std::filesystem::path &filePath) {
  std::filesystem::path const dirPath = filePath.parent_path();
  // handle a.txt case where parent_path() is empty
  if (dirPath.empty())
    return;
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

std::string warpo::readTextFile(std::filesystem::path const &path) {
  if (!std::filesystem::exists(path))
    throw std::runtime_error{"cannot open file: " + path.string()};
  std::ifstream const ifs{path, std::ios::in};
  if (!ifs.is_open())
    throw std::runtime_error{"cannot open file: " + path.string()};
  std::stringstream buffer;
  buffer << ifs.rdbuf();
  return std::move(buffer).str();
}

std::string warpo::readBinaryFile(std::filesystem::path const &path) {
  if (!std::filesystem::exists(path))
    throw std::runtime_error{"cannot open file: " + path.string()};
  std::ifstream const ifs{path, std::ios::in | std::ios::binary};
  if (!ifs.is_open())
    throw std::runtime_error{"cannot open file: " + path.string()};
  std::stringstream buffer;
  buffer << ifs.rdbuf();
  return std::move(buffer).str();
}

void warpo::writeBinaryFile(std::filesystem::path const &path, std::string const &data) {
  std::ofstream out = openOFStream(path, std::ios::binary | std::ios::out | std::ios::trunc);
  out << data;
}
void warpo::writeBinaryFile(std::filesystem::path const &path, std::vector<uint8_t> const &data) {
  std::ofstream out = openOFStream(path, std::ios::binary | std::ios::out | std::ios::trunc);
  out.write(reinterpret_cast<char const *>(data.data()), static_cast<std::streamsize>(data.size()));
}

bool warpo::isDirectory(std::filesystem::path const &path) { return std::filesystem::is_directory(path); }

bool warpo::isRegularFile(std::filesystem::path const &path) { return std::filesystem::is_regular_file(path); }

#ifdef WARPO_ENABLE_UNIT_TESTS

#include <gtest/gtest.h>
namespace warpo::ut {

TEST(FsTest, BaseName) { EXPECT_EQ(getBaseName("a/b/c.d"), "c.d"); }

TEST(FsTest, EnsureFileDir) {
  ensureFileDirectory("build/tmp_ut/a/b");
  EXPECT_TRUE(std::filesystem::exists("build/tmp_ut/a"));
}

} // namespace warpo::ut

#endif
