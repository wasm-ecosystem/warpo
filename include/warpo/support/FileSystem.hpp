// Copyright (C) 2024 Bayerische Motoren Werke Aktiengesellschaft (BMW AG)
// Copyright (C) 2025 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

#pragma once

#include <filesystem>

namespace warpo {

void ensureFileDirectory(const std::filesystem::path &filePath);
void ensureDirectory(const std::filesystem::path &dirPath);

std::string getBaseName(std::filesystem::path const &path);

std::filesystem::path replaceExtension(std::filesystem::path const &path, std::filesystem::path const &newExt);

std::string readTextFile(std::string const &path);

std::string readBinaryFile(std::string const &path);

void writeBinaryFile(std::string const &path, std::string data);

bool isDirectory(const std::filesystem::path &path);
bool isRegularFile(std::filesystem::path const &path);

} // namespace warpo
