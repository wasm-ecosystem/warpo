#include <cassert>
#include <filesystem>
#include <fmt/base.h>
#include <fmt/format.h>
#include <map>
#include <optional>
#include <regex>
#include <string>

#include "ModuleResolver.hpp"
#include "warpo/support/Debug.hpp"
#include "warpo/support/FileSystem.hpp"

#define PASS_NAME "ModuleResolve"

namespace warpo::frontend {

using PackageResolveResult = std::optional<std::pair<std::string, std::optional<std::string>>>;

static PackageResolveResult getPackageName(std::string const &fileInternalPath) {
  static std::regex const libRegex{R"(^~lib/((?:@[^/]+/)?[^/]+)(?:/(.*?))?$)"};
  std::smatch match;
  if (!std::regex_match(fileInternalPath, match, libRegex))
    return std::nullopt;
  std::string const packageName = match[1].str();
  std::optional<std::string> const filePath =
      (match.size() > 2 && match[2].matched) ? std::optional<std::string>{match[2].str()} : std::nullopt;
  return std::pair<std::string, std::optional<std::string>>{packageName, filePath};
}

std::optional<std::filesystem::path> ModuleResolver::findPackageRoot(std::filesystem::path const &sourceInternalPath,
                                                                     std::string const &packageName) {
  auto const it = packageRootMap_.find(packageName);
  if (it != packageRootMap_.end())
    return it->second;
  std::filesystem::path current;
  PackageResolveResult const sourcePackage = getPackageName(sourceInternalPath);
  if (sourcePackage.has_value()) {
    std::string const sourcePackageName = (*sourcePackage).first;
    assert(packageRootMap_.contains(sourcePackageName));
    std::filesystem::path const packagePath = packageRootMap_.at(sourcePackageName);
    current = packagePath;
  } else {
    current = std::filesystem::absolute(sourceInternalPath).parent_path();
  }
  while (current != current.root_path()) {
    std::filesystem::path const target = current / "node_modules" / packageName;
    // fmt::println("[module resolve] try to resolving library '{}' in '{}'", packageName, target.c_str());
    if (std::filesystem::exists(target) && std::filesystem::is_directory(target)) {
      packageRootMap_[packageName] = target;
      if (support::isDebug("ModuleResolve"))
        fmt::println("[module resolve] resolve library '{}' in '{}'", packageName, target.c_str());
      return target;
    }
    current = current.parent_path();
  }
  return std::nullopt;
}

Dependency ModuleResolver::getDependencyForUserCode(std::string const &nextFileInternalPath) {
  const std::string filePathWithExt = nextFileInternalPath + extension;
  if (std::filesystem::exists(filePathWithExt) && std::filesystem::is_regular_file(filePathWithExt)) {
    if (support::isDebug("ModuleResolve"))
      fmt::println("[module resolve] find user code '{}'", filePathWithExt);
    return {readTextFile(filePathWithExt), filePathWithExt};
  }
  const std::string indexPathWithExt = std::filesystem::path{nextFileInternalPath} / (std::string{"index"} + extension);
  if (std::filesystem::exists(indexPathWithExt) && std::filesystem::is_regular_file(indexPathWithExt)) {
    return {readTextFile(indexPathWithExt), indexPathWithExt};
  }
  const std::string dFilePathWithExt = nextFileInternalPath + ".d" + extension;
  if (std::filesystem::exists(dFilePathWithExt) && std::filesystem::is_regular_file(dFilePathWithExt)) {
    return {readTextFile(dFilePathWithExt), filePathWithExt};
  }
  if (support::isDebug("ModuleResolve"))
    fmt::println("[module resolve] cannot find library '{}'", nextFileInternalPath);
  return {std::nullopt, nextFileInternalPath + extension};
}

Dependency ModuleResolver::getDependencyForNodeModules(std::string const &nextFileInternalPath,
                                                       std::string const &dependeePath) {
  if (support::isDebug("ModuleResolve"))
    fmt::println("[module resolve] get dependency for '{}'", nextFileInternalPath);
  if (PackageResolveResult const package = getPackageName(nextFileInternalPath); package.has_value()) {
    auto const [packageName, filePath] = *package;
    std::optional<std::filesystem::path> const packageRoot = findPackageRoot(dependeePath, packageName);
    if (!packageRoot) {
      if (support::isDebug("ModuleResolve"))
        fmt::println("[module resolve] cannot find node_modules for package '{}'", packageName);
      return {std::nullopt, nextFileInternalPath + extension};
    }
    std::filesystem::path const plainPath = filePath.has_value() ? (*packageRoot / *filePath) : (*packageRoot);
    const std::string filePathWithExt = plainPath.string() + extension;
    if (std::filesystem::exists(filePathWithExt) && std::filesystem::is_regular_file(filePathWithExt)) {
      std::string const internalPath = libraryPrefix + packageName + "/" + *filePath + extension;
      if (support::isDebug("ModuleResolve"))
        fmt::println("[module resolve] resolve '{}' to '{}'", nextFileInternalPath, internalPath);
      return {readTextFile(filePathWithExt), internalPath};
    }
    const std::string indexPathWithExt = plainPath / (std::string{"index"} + extension);
    if (std::filesystem::exists(indexPathWithExt) && std::filesystem::is_regular_file(indexPathWithExt)) {
      std::string const internalPath =
          libraryPrefix + packageName + (filePath.has_value() ? ("/" + *filePath) : "") + "/index" + extension;
      if (support::isDebug("ModuleResolve"))
        fmt::println("[module resolve] resolve '{}' to '{}'", nextFileInternalPath, internalPath);
      return {readTextFile(indexPathWithExt), internalPath};
    }
  }
  if (support::isDebug("ModuleResolve"))
    fmt::println("[module resolve] cannot find library '{}'", nextFileInternalPath);
  return {std::nullopt, nextFileInternalPath + extension};
}

} // namespace warpo::frontend
