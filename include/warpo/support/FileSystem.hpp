// Copyright (C) 2024 Bayerische Motoren Werke Aktiengesellschaft (BMW AG)
// Copyright (C) 2025 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

#pragma once

#include <cstdint>
#include <filesystem>
#include <fstream>
#include <vector>

namespace warpo {

std::ofstream openOFStream(std::filesystem::path const &file, std::ios_base::openmode mode);

void ensureFileDirectory(const std::filesystem::path &filePath);
void ensureDirectory(const std::filesystem::path &dirPath);

std::string getBaseName(std::filesystem::path const &path);

std::filesystem::path replaceExtension(std::filesystem::path const &path, std::filesystem::path const &newExt);

std::string readTextFile(std::filesystem::path const &path);

std::string readBinaryFile(std::filesystem::path const &path);

void writeBinaryFile(std::filesystem::path const &path, std::string const &data);
void writeBinaryFile(std::filesystem::path const &path, std::vector<uint8_t> const &data);

bool isDirectory(const std::filesystem::path &path);
bool isRegularFile(std::filesystem::path const &path);

} // namespace warpo
