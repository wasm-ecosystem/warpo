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

void VariableInfo::addGlobalType(std::string variableName, std::string_view const typeName) {
  std::string_view const normalizedTypeName = TypeNameHelper::normalizeTypeName(typeName);
  std::string_view const internedTypeName = stringPool_.internString(normalizedTypeName);
  globalTypes_.emplace(std::move(variableName), internedTypeName);
}

void VariableInfo::addSubProgram(std::string subProgramName, std::string_view const belongClassName) {

  if (!belongClassName.empty() && (belongClassName != "<<NULL>>")) {
    auto classIt = classRegistry_.find(belongClassName);
    assert(classIt != classRegistry_.end() && "Class not found in registry");
    // NOLINTNEXTLINE(misc-const-correctness)
    SubProgramInfo &subProgramInfo = classIt->second.addSubProgram(std::move(subProgramName));
    subProgramLookupMap_.emplace(subProgramInfo.getName(), subProgramInfo);
  } else {
    // NOLINTNEXTLINE(misc-const-correctness)
    SubProgramInfo &subProgramInfo = subProgramRegistry_.addSubProgram(std::move(subProgramName));
    subProgramLookupMap_.emplace(subProgramInfo.getName(), subProgramInfo);
  }
}

void VariableInfo::addParameter(std::string_view const subProgramName, std::string variableName,
                                std::string_view const typeName, uint32_t const index, bool const nullable) {
  SubProgramLookupMap::iterator const it = subProgramLookupMap_.find(subProgramName);
  std::string_view const normalizedTypeName = TypeNameHelper::normalizeTypeName(typeName);
  std::string_view const internedTypeName = stringPool_.internString(normalizedTypeName);
  assert(it != subProgramLookupMap_.end() && "SubProgram not found in registry");
  it->second.addParameter(std::move(variableName), internedTypeName, index, nullable);
}

void VariableInfo::addLocal(std::string_view const subProgramName, std::string variableName,
                            std::string_view const typeName, uint32_t const index, uint32_t const start,
                            uint32_t const end, bool const nullable) {
  SubProgramLookupMap::iterator const it = subProgramLookupMap_.find(subProgramName);
  std::string_view const normalizedTypeName = TypeNameHelper::normalizeTypeName(typeName);
  std::string_view const internedTypeName = stringPool_.internString(normalizedTypeName);
  assert(it != subProgramLookupMap_.end() && "SubProgram not found in registry");
  it->second.addLocal(std::move(variableName), internedTypeName, index, start, end, nullable);
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
  const VariableInfo::ClassRegistry &classRegistry = variableInfo.getClassRegistry();

  // 4. Assert if the classes and members are correctly added
  // Verify we have exactly 2 classes
  ASSERT_EQ(classRegistry.size(), 2);

  // Verify Person class
  VariableInfo::ClassRegistry::const_iterator const personIt = classRegistry.find("Person");
  ASSERT_NE(personIt, classRegistry.end());
  const ClassInfo &personClass = personIt->second;

  EXPECT_EQ(personClass.getName(), "Person");
  EXPECT_EQ(personClass.getRtid(), 1);
  EXPECT_EQ(personClass.getFields().size(), 3);

  // Verify Person fields
  const std::vector<FieldInfo> &personFields = personClass.getFields();
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
  VariableInfo::ClassRegistry::const_iterator const employeeIt = classRegistry.find("Employee");
  ASSERT_NE(employeeIt, classRegistry.end());
  const ClassInfo &employeeClass = employeeIt->second;

  EXPECT_EQ(employeeClass.getName(), "Employee");
  EXPECT_EQ(employeeClass.getRtid(), 2);
  EXPECT_EQ(employeeClass.getFields().size(), 6);

  // Verify Employee fields
  const std::vector<FieldInfo> &employeeFields = employeeClass.getFields();
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
  const VariableInfo::ClassRegistry &classRegistry = variableInfo.getClassRegistry();

  // Verify the container class exists
  VariableInfo::ClassRegistry::const_iterator const containerIt = classRegistry.find("Container<T>");
  ASSERT_NE(containerIt, classRegistry.end());
  const ClassInfo &containerClass = containerIt->second;

  // Verify template types
  const std::vector<std::string_view> &templateTypes = containerClass.getTemplateTypes();
  ASSERT_EQ(templateTypes.size(), 2);

  // i32 should be normalized to ~lib/number/I32
  EXPECT_EQ(templateTypes[0], "~lib/number/I32");

  // ~lib/string/String should remain unchanged
  EXPECT_EQ(templateTypes[1], "~lib/string/String");
}

TEST(TestVariableInfo, TestGlobalTypes) {
  VariableInfo variableInfo;

  variableInfo.addGlobalType("counter", "i32");
  variableInfo.addGlobalType("message", "~lib/string/String");

  const VariableInfo::GlobalTypes &globalTypes = variableInfo.getGlobalTypes();

  ASSERT_EQ(globalTypes.size(), 2);
  EXPECT_EQ(globalTypes.at("counter"), "~lib/number/I32");
  EXPECT_EQ(globalTypes.at("message"), "~lib/string/String");
}

TEST(TestVariableInfo, TestAddParameter) {
  VariableInfo variableInfo;

  // Test adding parameters to global function
  variableInfo.addSubProgram("calculateSum", "");
  variableInfo.addParameter("calculateSum", "a", "i32", 0, false);
  variableInfo.addParameter("calculateSum", "b", "i32", 1, false);

  // Verify global function parameters
  const SubProgramRegistry &subProgramRegistry = variableInfo.getSubProgramRegistry();
  const std::deque<SubProgramInfo> &globalFunctions = subProgramRegistry.getList();
  ASSERT_EQ(globalFunctions.size(), 1);

  const SubProgramInfo &calculateSum = globalFunctions[0];
  EXPECT_EQ(calculateSum.getName(), "calculateSum");

  const std::vector<LocalInfo> &calcParams = calculateSum.getParameters();
  ASSERT_EQ(calcParams.size(), 2);
  EXPECT_EQ(calcParams[0].getName(), "a");
  EXPECT_EQ(calcParams[0].getType(), "~lib/number/I32");
  EXPECT_EQ(calcParams[0].getIndex(), 0);
  EXPECT_FALSE(calcParams[0].isNullable());
  EXPECT_EQ(calcParams[1].getName(), "b");
  EXPECT_EQ(calcParams[1].getType(), "~lib/number/I32");
  EXPECT_EQ(calcParams[1].getIndex(), 1);
  EXPECT_FALSE(calcParams[1].isNullable());

  // Test adding parameters to class member function
  variableInfo.createClass("Math", "Object", 200);
  variableInfo.addSubProgram("multiply", "Math");
  variableInfo.addParameter("multiply", "x", "i32", 0, false);
  variableInfo.addParameter("multiply", "y", "i32", 1, false);

  // Verify class member function parameters
  const VariableInfo::ClassRegistry &classRegistry = variableInfo.getClassRegistry();
  VariableInfo::ClassRegistry::const_iterator const mathIt = classRegistry.find("Math");
  ASSERT_NE(mathIt, classRegistry.end());

  const ClassInfo &mathClass = mathIt->second;
  const std::deque<SubProgramInfo> &memberFunctions = mathClass.getSubProgramRegistry().getList();
  ASSERT_EQ(memberFunctions.size(), 1);

  const SubProgramInfo &multiply = memberFunctions[0];
  EXPECT_EQ(multiply.getName(), "multiply");

  const std::vector<LocalInfo> &multiplyParams = multiply.getParameters();
  ASSERT_EQ(multiplyParams.size(), 2);
  EXPECT_EQ(multiplyParams[0].getName(), "x");
  EXPECT_EQ(multiplyParams[0].getType(), "~lib/number/I32");
  EXPECT_EQ(multiplyParams[0].getIndex(), 0);
  EXPECT_FALSE(multiplyParams[0].isNullable());
  EXPECT_EQ(multiplyParams[1].getName(), "y");
  EXPECT_EQ(multiplyParams[1].getType(), "~lib/number/I32");
  EXPECT_EQ(multiplyParams[1].getIndex(), 1);
  EXPECT_FALSE(multiplyParams[1].isNullable());
}

TEST(TestVariableInfo, TestAddLocal) {
  VariableInfo variableInfo;

  // Test global function
  variableInfo.addSubProgram("processData", "");
  variableInfo.addLocal("processData", "result", "i32", 1, 10, 50, false);

  const SubProgramRegistry &subProgramRegistry = variableInfo.getSubProgramRegistry();
  const std::deque<SubProgramInfo> &globalFunctions = subProgramRegistry.getList();
  ASSERT_EQ(globalFunctions.size(), 1);

  const std::vector<LocalInfo> &locals = globalFunctions[0].getLocals();
  ASSERT_EQ(locals.size(), 1);
  EXPECT_EQ(locals[0].getName(), "result");
  EXPECT_EQ(locals[0].getIndex(), 1);
  EXPECT_EQ(locals[0].getStart(), 10);
  EXPECT_EQ(locals[0].getEnd(), 50);

  // Test class member function
  variableInfo.createClass("Math", "Object", 300);
  variableInfo.addSubProgram("compute", "Math");
  variableInfo.addLocal("compute", "temp", "i32", 1, 5, 30, false);

  const VariableInfo::ClassRegistry &classRegistry = variableInfo.getClassRegistry();
  VariableInfo::ClassRegistry::const_iterator const mathIt = classRegistry.find("Math");
  ASSERT_NE(mathIt, classRegistry.end());

  const std::deque<SubProgramInfo> &memberFunctions = mathIt->second.getSubProgramRegistry().getList();
  ASSERT_EQ(memberFunctions.size(), 1);

  const std::vector<LocalInfo> &computeLocals = memberFunctions[0].getLocals();
  ASSERT_EQ(computeLocals.size(), 1);
  EXPECT_EQ(computeLocals[0].getName(), "temp");
  EXPECT_EQ(computeLocals[0].getIndex(), 1);
  EXPECT_EQ(computeLocals[0].getStart(), 5);
  EXPECT_EQ(computeLocals[0].getEnd(), 30);
}
} // namespace warpo::ut
#endif