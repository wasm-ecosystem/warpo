// Copyright (C) 2026 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

#include <algorithm>
#include <unordered_set>

#include "warpo/common/ClassHierarchy.hpp"

namespace warpo {

bool ClassHierarchy::isAncestorOrSelf(std::string_view const ancestor,
                                      std::string_view const descendant) const noexcept {
  std::string_view current = descendant;
  while (!current.empty()) {
    if (current == ancestor)
      return true;
    current = getParentClass(current);
  }
  return false;
}

bool ClassHierarchy::areRelatedClasses(std::string_view const first, std::string_view const second) const noexcept {
  return isAncestorOrSelf(first, second) || isAncestorOrSelf(second, first);
}

std::vector<std::string_view> ClassHierarchy::getAncestors(std::string_view const className) const {
  std::vector<std::string_view> ancestors;
  for (std::string_view parent = getParentClass(className); !parent.empty(); parent = getParentClass(parent))
    ancestors.push_back(parent);
  return ancestors;
}

std::vector<std::string_view> ClassHierarchy::getDescendants(std::string_view const className) const {
  std::unordered_set<std::string_view> descendants;
  std::vector<std::string_view> pending = getDirectSubclasses(className);
  while (!pending.empty()) {
    std::string_view const child = pending.back();
    pending.pop_back();
    if (descendants.contains(child))
      continue;
    descendants.insert(child);
    std::vector<std::string_view> directChildren = getDirectSubclasses(child);
    pending.insert(pending.end(), directChildren.begin(), directChildren.end());
  }
  return std::vector<std::string_view>(descendants.begin(), descendants.end());
}

std::string_view ClassHierarchy::getParentClass(std::string_view const className) const noexcept {
  VariableInfo::ClassRegistry const &registry = variableInfo_.getClassRegistry();
  VariableInfo::ClassRegistry::const_iterator const it = registry.find(className);
  if (it == registry.end())
    return {};
  std::string_view const parent = it->second.getParentName();
  return registry.contains(parent) ? parent : std::string_view{};
}

std::vector<std::string_view> ClassHierarchy::getDirectSubclasses(std::string_view const className) const {
  std::vector<std::string_view> subclasses;
  for (auto const &[childName, childInfo] : variableInfo_.getClassRegistry()) {
    if (childInfo.getParentName() == className)
      subclasses.push_back(childName);
  }
  return subclasses;
}

std::vector<std::string_view> ClassHierarchy::getImplementedInterfaces(std::string_view const className) const {
  std::vector<std::string_view> interfaces;
  VariableInfo::ClassRegistry const &registry = variableInfo_.getClassRegistry();
  VariableInfo::ClassRegistry::const_iterator const it = registry.find(className);
  if (it == registry.end())
    return interfaces;
  VariableInfo::InterfaceRegistry const &interfaceRegistry = variableInfo_.getInterfaceRegistry();
  for (std::string_view const interfaceName : it->second.getInterfaces()) {
    if (interfaceRegistry.contains(interfaceName))
      interfaces.push_back(interfaceName);
  }
  return interfaces;
}

std::string_view ClassHierarchy::getParentInterface(std::string_view const interfaceName) const noexcept {
  VariableInfo::InterfaceRegistry const &registry = variableInfo_.getInterfaceRegistry();
  VariableInfo::InterfaceRegistry::const_iterator const it = registry.find(interfaceName);
  if (it == registry.end())
    return {};
  std::string_view const parent = it->second.getParentName();
  return registry.contains(parent) ? parent : std::string_view{};
}

std::vector<std::string_view> ClassHierarchy::getDirectSubinterfaces(std::string_view const interfaceName) const {
  std::vector<std::string_view> subinterfaces;
  for (auto const &[childName, childInfo] : variableInfo_.getInterfaceRegistry()) {
    if (childInfo.getParentName() == interfaceName)
      subinterfaces.push_back(childName);
  }
  return subinterfaces;
}

std::vector<std::string_view> ClassHierarchy::getDirectImplementers(std::string_view const interfaceName) const {
  std::vector<std::string_view> implementers;
  for (auto const &[className, classInfo] : variableInfo_.getClassRegistry()) {
    for (std::string_view const implemented : classInfo.getInterfaces()) {
      if (implemented == interfaceName) {
        implementers.push_back(className);
        break;
      }
    }
  }
  return implementers;
}

bool ClassHierarchy::isClass(std::string_view const typeName) const noexcept {
  return variableInfo_.getClassRegistry().contains(typeName);
}

bool ClassHierarchy::isInterface(std::string_view const typeName) const noexcept {
  return variableInfo_.getInterfaceRegistry().contains(typeName);
}

} // namespace warpo

#ifdef WARPO_ENABLE_UNIT_TESTS

#include <gtest/gtest.h>

namespace warpo::ut {

TEST(TestClassHierarchy, IsAncestorOrSelfAndAreRelatedClasses) {
  VariableInfo variableInfo;
  variableInfo.createClass("GrandParent");
  variableInfo.createClass("Parent");
  variableInfo.createClass("Child");
  variableInfo.createClass("Uncle");

  variableInfo.addBaseClass("Parent", "GrandParent");
  variableInfo.addBaseClass("Child", "Parent");
  variableInfo.addBaseClass("Uncle", "GrandParent");

  ClassHierarchy const hierarchy{variableInfo};

  EXPECT_TRUE(hierarchy.isAncestorOrSelf("GrandParent", "Child"));
  EXPECT_TRUE(hierarchy.isAncestorOrSelf("Child", "Child"));
  EXPECT_FALSE(hierarchy.isAncestorOrSelf("Child", "GrandParent"));
  EXPECT_FALSE(hierarchy.isAncestorOrSelf("Uncle", "Child"));

  EXPECT_TRUE(hierarchy.areRelatedClasses("GrandParent", "Child"));
  EXPECT_TRUE(hierarchy.areRelatedClasses("Child", "GrandParent"));
  EXPECT_FALSE(hierarchy.areRelatedClasses("Uncle", "Child"));
}

TEST(TestClassHierarchy, DirectRelationshipsAndInterfaceImplementers) {
  VariableInfo variableInfo;
  variableInfo.createInterface("IBase");
  variableInfo.createInterface("IDerived");
  variableInfo.addBaseInterface("IDerived", "IBase");

  variableInfo.createClass("BaseClass");
  variableInfo.createClass("DerivedClass1");
  variableInfo.createClass("DerivedClass2");
  variableInfo.addBaseClass("DerivedClass1", "BaseClass");
  variableInfo.addBaseClass("DerivedClass2", "BaseClass");

  variableInfo.addInterface("DerivedClass1", "IDerived");
  variableInfo.addInterface("BaseClass", "IBase");

  ClassHierarchy const hierarchy{variableInfo};

  EXPECT_TRUE(hierarchy.isClass("BaseClass"));
  EXPECT_FALSE(hierarchy.isInterface("BaseClass"));
  EXPECT_TRUE(hierarchy.isInterface("IBase"));
  EXPECT_FALSE(hierarchy.isClass("IBase"));

  EXPECT_EQ(hierarchy.getParentClass("DerivedClass1"), "BaseClass");
  EXPECT_EQ(hierarchy.getParentClass("BaseClass"), "");

  std::vector<std::string_view> const subClasses = hierarchy.getDirectSubclasses("BaseClass");
  EXPECT_EQ(subClasses.size(), 2U);

  EXPECT_EQ(hierarchy.getParentInterface("IDerived"), "IBase");
  EXPECT_EQ(hierarchy.getParentInterface("IBase"), "");

  std::vector<std::string_view> const subInterfaces = hierarchy.getDirectSubinterfaces("IBase");
  EXPECT_EQ(subInterfaces.size(), 1U);
  EXPECT_EQ(subInterfaces.front(), "IDerived");

  std::vector<std::string_view> const implementers = hierarchy.getDirectImplementers("IDerived");
  EXPECT_EQ(implementers.size(), 1U);
  EXPECT_EQ(implementers.front(), "DerivedClass1");
}

} // namespace warpo::ut

#endif
