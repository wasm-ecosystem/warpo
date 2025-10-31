///
/// @file VariableInfo.cpp
/// @copyright Copyright (C) 2025 wasm-ecosystem
/// SPDX-License-Identifier: Apache-2.0
/// Licensed under the Apache License, Version 2.0 (the "License");
/// you may not use this file except in compliance with the License.
/// You may obtain a copy of the License at
///
///     http://www.apache.org/licenses/LICENSE-2.0
///
/// Unless required by applicable law or agreed to in writing, software
/// distributed under the License is distributed on an "AS IS" BASIS,
/// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
/// See the License for the specific language governing permissions and
/// limitations under the License.
#include <cassert>
#include <cstring>
#include <fstream>
#include <iomanip>
#include <iostream>
#include <memory>
#include <unordered_map>
#include <utility>
#include <vector>

#include "warpo/common/ClassInfo.hpp"
#include "warpo/common/FieldInfo.hpp"
#include "warpo/common/TypeNameHelper.hpp"
#include "warpo/common/VariableInfo.hpp"

namespace warpo {

void VariableInfo::addField(std::string_view const className, std::string fieldName, std::string const typeName,
                            uint32_t const offset, uint32_t const nullable) {
  ClassRegistry::iterator const classIt = classRegistry_.find(className);
  assert(classIt != classRegistry_.end());
  std::string_view const internedTypeName = stringPool_.internString(typeName);
  classIt->second.addMember(std::move(fieldName), internedTypeName, offset, nullable != 0);
}

void VariableInfo::createClass(std::string const className, std::string const parentName, uint32_t const rtid) {
  std::string_view const internedClassName = stringPool_.internString(className);
  std::string_view const internedParentName = stringPool_.internString(parentName);
  classRegistry_.emplace(internedClassName, ClassInfo{internedClassName, internedParentName, rtid});
}

void VariableInfo::addTemplateType(std::string_view const className, std::string_view const templateTypeName) {
  ClassRegistry::iterator const classIt = classRegistry_.find(className);
  assert(classIt != classRegistry_.end());
  std::string_view const normalizedTypeName = TypeNameHelper::normalizeTypeName(templateTypeName);
  std::string_view const internedTypeName = stringPool_.internString(normalizedTypeName);
  classIt->second.addTemplateType(internedTypeName);
}

} // namespace warpo

#ifdef WARPO_ENABLE_UNIT_TESTS

#include <gtest/gtest.h>

namespace warpo::ut {
TEST(TestVariableInfo, TestCreateClass) {
  VariableInfo variableInfo;

  // 1. Add two classes
  variableInfo.createClass("Person", "Object", 1);
  variableInfo.createClass("Employee", "Person", 2);

  // 2. Add several members to each class
  // Person class members
  variableInfo.addField("Person", "name", "~lib/string/String", 0, 0);
  variableInfo.addField("Person", "age", "~lib/number/I32", 8, 0);
  variableInfo.addField("Person", "email", "~lib/string/String", 12, 1); // nullable

  // Employee class members
  variableInfo.addField("Employee", "name", "~lib/string/String", 0, 0);
  variableInfo.addField("Employee", "age", "~lib/number/I32", 8, 0);
  variableInfo.addField("Employee", "email", "~lib/string/String", 12, 1);
  variableInfo.addField("Employee", "employeeId", "~lib/number/I32", 16, 0);
  variableInfo.addField("Employee", "department", "~lib/string/String", 20, 0);
  variableInfo.addField("Employee", "salary", "~lib/number/F64", 24, 0);

  // 3. Get the class registry
  const auto &classRegistry = variableInfo.getClassRegistry();

  // 4. Assert if the classes and members are correctly added
  // Verify we have exactly 2 classes
  ASSERT_EQ(classRegistry.size(), 2);

  // Verify Person class
  auto personIt = classRegistry.find("Person");
  ASSERT_NE(personIt, classRegistry.end());
  const ClassInfo &personClass = personIt->second;

  EXPECT_EQ(personClass.getName(), "Person");
  EXPECT_EQ(personClass.getRtid(), 1);
  EXPECT_EQ(personClass.getFields().size(), 3);

  // Verify Person fields
  const auto &personFields = personClass.getFields();
  EXPECT_EQ(personFields[0].getName(), "name");
  EXPECT_EQ(personFields[0].getType(), "~lib/string/String");
  EXPECT_EQ(personFields[0].getOffsetInClass(), 0);
  EXPECT_FALSE(personFields[0].isNullable());

  EXPECT_EQ(personFields[1].getName(), "age");
  EXPECT_EQ(personFields[1].getType(), "~lib/number/I32");
  EXPECT_EQ(personFields[1].getOffsetInClass(), 8);
  EXPECT_FALSE(personFields[1].isNullable());

  EXPECT_EQ(personFields[2].getName(), "email");
  EXPECT_EQ(personFields[2].getType(), "~lib/string/String");
  EXPECT_EQ(personFields[2].getOffsetInClass(), 12);
  EXPECT_TRUE(personFields[2].isNullable());

  // Verify Employee class
  auto employeeIt = classRegistry.find("Employee");
  ASSERT_NE(employeeIt, classRegistry.end());
  const ClassInfo &employeeClass = employeeIt->second;

  EXPECT_EQ(employeeClass.getName(), "Employee");
  EXPECT_EQ(employeeClass.getRtid(), 2);
  EXPECT_EQ(employeeClass.getFields().size(), 6);

  // Verify Employee fields
  const auto &employeeFields = employeeClass.getFields();
  EXPECT_EQ(employeeFields[0].getName(), "name");
  EXPECT_EQ(employeeFields[0].getType(), "~lib/string/String");
  EXPECT_EQ(employeeFields[0].getOffsetInClass(), 0);

  EXPECT_EQ(employeeFields[1].getName(), "age");
  EXPECT_EQ(employeeFields[1].getType(), "~lib/number/I32");
  EXPECT_EQ(employeeFields[1].getOffsetInClass(), 8);

  EXPECT_EQ(employeeFields[2].getName(), "email");
  EXPECT_EQ(employeeFields[2].getType(), "~lib/string/String");
  EXPECT_EQ(employeeFields[2].getOffsetInClass(), 12);
  EXPECT_TRUE(employeeFields[2].isNullable());

  EXPECT_EQ(employeeFields[3].getName(), "employeeId");
  EXPECT_EQ(employeeFields[3].getType(), "~lib/number/I32");
  EXPECT_EQ(employeeFields[3].getOffsetInClass(), 16);
  EXPECT_FALSE(employeeFields[3].isNullable());

  EXPECT_EQ(employeeFields[4].getName(), "department");
  EXPECT_EQ(employeeFields[4].getType(), "~lib/string/String");
  EXPECT_EQ(employeeFields[4].getOffsetInClass(), 20);
  EXPECT_FALSE(employeeFields[4].isNullable());

  EXPECT_EQ(employeeFields[5].getName(), "salary");
  EXPECT_EQ(employeeFields[5].getType(), "~lib/number/F64");
  EXPECT_EQ(employeeFields[5].getOffsetInClass(), 24);
  EXPECT_FALSE(employeeFields[5].isNullable());
}

TEST(TestVariableInfo, TestTemplateTypes) {
  VariableInfo variableInfo;

  // Create a generic container class
  variableInfo.createClass("Container<T>", "Object", 10);

  // Add template types - one basic type (i32) and one complex type (String)
  variableInfo.addTemplateType("Container<T>", "i32");
  variableInfo.addTemplateType("Container<T>", "~lib/string/String");

  // Get the class registry
  const auto &classRegistry = variableInfo.getClassRegistry();

  // Verify the container class exists
  auto containerIt = classRegistry.find("Container<T>");
  ASSERT_NE(containerIt, classRegistry.end());
  const ClassInfo &containerClass = containerIt->second;

  // Verify template types
  const auto &templateTypes = containerClass.getTemplateTypes();
  ASSERT_EQ(templateTypes.size(), 2);

  // i32 should be normalized to ~lib/number/I32
  EXPECT_EQ(templateTypes[0], "~lib/number/I32");

  // ~lib/string/String should remain unchanged
  EXPECT_EQ(templateTypes[1], "~lib/string/String");
}
} // namespace warpo::ut
#endif