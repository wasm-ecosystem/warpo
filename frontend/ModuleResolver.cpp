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
  // cache hit
  auto const it = packageRootMap_.find(packageName);
  if (it != packageRootMap_.end())
    return it->second;
  // plugin
  if (plugin_ != nullptr) {
    if (std::optional<std::filesystem::path> packageRoot = plugin_->getPackageRoot(packageName);
        packageRoot.has_value())
      return packageRoot;
  }
  // default resolver
  std::filesystem::path current;
  PackageResolveResult const sourcePackage = getPackageName(sourceInternalPath.string());
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
        fmt::println("[module resolve] resolve library '{}' in '{}'", packageName, target.string());
      return target;
    }
    current = current.parent_path();
  }
  return std::nullopt;
}

// priority:
// 1. If X is a file, load X as its file extension format.
// 2. If X is a directory, X/index.ts is a file, load X/index.ts.
// 3. If X.d.ts is a file, load X.d.ts.
// 4. THROW "not found".
Dependency ModuleResolver::getDependencyForUserCode(std::string const &nextFileInternalPath) {
  // currently we only support *.json
  if (isRegularFile(nextFileInternalPath) && nextFileInternalPath.ends_with(".json")) {
    if (support::isDebug("ModuleResolve"))
      fmt::println("[module resolve] find user code in json format '{}'", nextFileInternalPath);
    return {readTextFile(nextFileInternalPath), nextFileInternalPath};
  }

  const std::string filePathWithExt = nextFileInternalPath + extension;
  if (isRegularFile(filePathWithExt)) {
    if (support::isDebug("ModuleResolve"))
      fmt::println("[module resolve] find user code '{}'", filePathWithExt);
    return {readTextFile(filePathWithExt), filePathWithExt};
  }

  const std::filesystem::path indexPathWithExt =
      std::filesystem::path{nextFileInternalPath} / (std::string{"index"} + extension);
  if (isRegularFile(indexPathWithExt.string())) {
    return {readTextFile(indexPathWithExt.string()), indexPathWithExt.string()};
  }

  const std::string dFilePathWithExt = nextFileInternalPath + ".d" + extension;
  if (isRegularFile(dFilePathWithExt)) {
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
    const std::filesystem::path indexPathWithExt = plainPath / (std::string{"index"} + extension);
    if (std::filesystem::exists(indexPathWithExt) && std::filesystem::is_regular_file(indexPathWithExt)) {
      std::string const internalPath =
          libraryPrefix + packageName + (filePath.has_value() ? ("/" + *filePath) : "") + "/index" + extension;
      if (support::isDebug("ModuleResolve"))
        fmt::println("[module resolve] resolve '{}' to '{}'", nextFileInternalPath, internalPath);
      return {readTextFile(indexPathWithExt.string()), internalPath};
    }
  }
  if (support::isDebug("ModuleResolve"))
    fmt::println("[module resolve] cannot find library '{}'", nextFileInternalPath);
  return {std::nullopt, nextFileInternalPath + extension};
}

} // namespace warpo::frontend
