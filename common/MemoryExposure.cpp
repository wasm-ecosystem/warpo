// Copyright (C) 2026 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

#include <vector>

#include "warpo/common/ClassHierarchy.hpp"
#include "warpo/common/MemoryExposure.hpp"
#include "warpo/common/VariableInfo.hpp"

namespace warpo {

void MemoryExposure::addType(std::string_view const typeName) {
  seedTypes_.emplace(typeName);
  types_.emplace(typeName);
}

void MemoryExposure::finalize(VariableInfo const &variableInfo) {
  ClassHierarchy const hierarchy{variableInfo};
  types_ = seedTypes_;

  // Expand each direct exposure independently. Reprocessing an ancestor as a seed would reach the root class and
  // incorrectly expose every sibling branch below it.
  auto const addClassFamily = [this, &hierarchy](std::string_view const className) {
    types_.emplace(className);
    for (std::string_view const ancestor : hierarchy.getAncestors(className))
      types_.emplace(ancestor);
    for (std::string_view const descendant : hierarchy.getDescendants(className))
      types_.emplace(descendant);
  };

  for (std::string_view const seed : seedTypes_) {
    if (hierarchy.isClass(seed)) {
      addClassFamily(seed);
      continue;
    }
    if (!hierarchy.isInterface(seed))
      continue;

    TypeRegistry visitedInterfaces;
    std::vector<std::string_view> pendingInterfaces{seed};
    while (!pendingInterfaces.empty()) {
      std::string_view const interfaceName = pendingInterfaces.back();
      pendingInterfaces.pop_back();
      if (!visitedInterfaces.emplace(interfaceName).second)
        continue;

      types_.emplace(interfaceName);
      for (std::string_view const subInterface : hierarchy.getDirectSubinterfaces(interfaceName))
        pendingInterfaces.push_back(subInterface);
      for (std::string_view const implementer : hierarchy.getDirectImplementers(interfaceName))
        addClassFamily(implementer);
    }
  }
}

} // namespace warpo

#ifdef WARPO_ENABLE_UNIT_TESTS

#include <gmock/gmock.h>
#include <gtest/gtest.h>

namespace warpo::ut {

TEST(TestMemoryExposure, TestClassExposureDoesNotSpreadThroughAncestorsToSiblingBranches) {
  // Hierarchy:
  // RootClass <- MidClass1 <- LeafClass1A, LeafClass1B
  // RootClass <- MidClass2 <- LeafClass2
  // OtherClassHierarchy: UnrelatedBase <- UnrelatedDerived
  VariableInfo variableInfo;
  variableInfo.createClass("RootClass");
  variableInfo.createClass("MidClass1");
  variableInfo.createClass("MidClass2");
  variableInfo.createClass("LeafClass1A");
  variableInfo.createClass("LeafClass1B");
  variableInfo.createClass("LeafClass2");
  variableInfo.createClass("UnrelatedBase");
  variableInfo.createClass("UnrelatedDerived");

  variableInfo.addBaseClass("MidClass1", "RootClass");
  variableInfo.addBaseClass("MidClass2", "RootClass");
  variableInfo.addBaseClass("LeafClass1A", "MidClass1");
  variableInfo.addBaseClass("LeafClass1B", "MidClass1");
  variableInfo.addBaseClass("LeafClass2", "MidClass2");
  variableInfo.addBaseClass("UnrelatedDerived", "UnrelatedBase");

  // Ancestor setters can operate on LeafClass1A, but objects from sibling branches cannot alias it.
  variableInfo.addMemoryExposureType("LeafClass1A");
  variableInfo.finalizeMemoryExposure();

  EXPECT_THAT(variableInfo.getMemoryExposureTypeRegistry(),
              ::testing::ElementsAre("LeafClass1A", "MidClass1", "RootClass"));
}

TEST(TestMemoryExposure, TestMultipleRootsAndComplexInterfaceDAG) {
  /*
   * Interfaces:
   * ITop1      ITop2
   *   \       /    \
   *    IMidJoin     ISub2
   *       |
   *     IBottom
   *
   * Classes:
   * ClassBase (implements ITop1)
   *   |
   * ClassDerived (implements IBottom)
   *
   * UnrelatedClass (implements ISub2)
   */
  VariableInfo variableInfo;
  variableInfo.createInterface("ITop1");
  variableInfo.createInterface("ITop2");
  variableInfo.createInterface("IMidJoin");
  variableInfo.createInterface("IBottom");
  variableInfo.createInterface("ISub2");

  variableInfo.addBaseInterface("IMidJoin", "ITop1");
  variableInfo.addBaseInterface("IMidJoin", "ITop2");
  variableInfo.addBaseInterface("IBottom", "IMidJoin");
  variableInfo.addBaseInterface("ISub2", "ITop2");

  variableInfo.createClass("ClassBase");
  variableInfo.createClass("ClassDerived");
  variableInfo.createClass("ClassSibling");
  variableInfo.createClass("UnrelatedClass");

  variableInfo.addBaseClass("ClassDerived", "ClassBase");
  variableInfo.addBaseClass("ClassSibling", "ClassBase");

  variableInfo.addInterface("ClassBase", "ITop1");
  variableInfo.addInterface("ClassDerived", "IBottom");
  variableInfo.addInterface("UnrelatedClass", "ISub2");

  // Expose ITop2:
  // - Sub-interfaces of ITop2: IMidJoin, ISub2
  // - Sub-interfaces of IMidJoin: IBottom
  // - Implementers of IBottom: ClassDerived
  // - ClassDerived adds its ancestor ClassBase, but not the sibling ClassSibling
  // - Implementers of ISub2: UnrelatedClass
  // - Note: ITop1 is an interface, interfaces do not pull in their parents or unrelated peer interfaces
  variableInfo.addMemoryExposureType("ITop2");
  variableInfo.finalizeMemoryExposure();

  EXPECT_THAT(
      variableInfo.getMemoryExposureTypeRegistry(),
      ::testing::ElementsAre("ClassBase", "ClassDerived", "IBottom", "IMidJoin", "ISub2", "ITop2", "UnrelatedClass"));
}

TEST(TestMemoryExposure, TestClassExposureDoesNotExposeImplementedInterface) {
  // If a class is exposed, it should propagate to base and derived classes,
  // but should NOT expose interfaces it implements (interfaces only propagate downwards to implementers).
  VariableInfo variableInfo;
  variableInfo.createInterface("MyInterface");
  variableInfo.createClass("MyBase");
  variableInfo.createClass("MyDerived");

  variableInfo.addBaseClass("MyDerived", "MyBase");
  variableInfo.addInterface("MyBase", "MyInterface");

  variableInfo.addMemoryExposureType("MyDerived");
  variableInfo.finalizeMemoryExposure();

  EXPECT_THAT(variableInfo.getMemoryExposureTypeRegistry(), ::testing::ElementsAre("MyBase", "MyDerived"));
}

TEST(TestMemoryExposure, TestMultipleIndependentSeedsAndDiamondClassGraph) {
  VariableInfo variableInfo;
  variableInfo.createInterface("InterfaceA");
  variableInfo.createInterface("InterfaceB");
  variableInfo.createClass("ClassA");
  variableInfo.createClass("ClassB");
  variableInfo.createClass("ClassC");

  variableInfo.addInterface("ClassA", "InterfaceA");
  variableInfo.addInterface("ClassB", "InterfaceB");

  variableInfo.addMemoryExposureType("InterfaceA");
  variableInfo.addMemoryExposureType("InterfaceB");
  variableInfo.finalizeMemoryExposure();

  EXPECT_THAT(variableInfo.getMemoryExposureTypeRegistry(),
              ::testing::ElementsAre("ClassA", "ClassB", "InterfaceA", "InterfaceB"));
}

TEST(TestMemoryExposure, TestDeepClassHierarchyWithMultipleBranchesAndMidExposed) {
  // Deep linear chain + multiple side branches:
  // Level0
  //   |-- Level1A
  //   |     |-- Level2A_1
  //   |     |     |-- Level3A_1
  //   |     |-- Level2A_2
  //   |-- Level1B
  //         |-- Level2B_1
  //
  // Independent forest:
  // OtherRoot
  //   |-- OtherChild
  VariableInfo variableInfo;
  variableInfo.createClass("Level0");
  variableInfo.createClass("Level1A");
  variableInfo.createClass("Level1B");
  variableInfo.createClass("Level2A_1");
  variableInfo.createClass("Level2A_2");
  variableInfo.createClass("Level2B_1");
  variableInfo.createClass("Level3A_1");
  variableInfo.createClass("OtherRoot");
  variableInfo.createClass("OtherChild");

  variableInfo.addBaseClass("Level1A", "Level0");
  variableInfo.addBaseClass("Level1B", "Level0");
  variableInfo.addBaseClass("Level2A_1", "Level1A");
  variableInfo.addBaseClass("Level2A_2", "Level1A");
  variableInfo.addBaseClass("Level2B_1", "Level1B");
  variableInfo.addBaseClass("Level3A_1", "Level2A_1");
  variableInfo.addBaseClass("OtherChild", "OtherRoot");

  // Exposing a middle node traverses to its ancestors and descendants, but not its cousin branch.
  variableInfo.addMemoryExposureType("Level1A");
  variableInfo.finalizeMemoryExposure();

  EXPECT_THAT(variableInfo.getMemoryExposureTypeRegistry(),
              ::testing::ElementsAre("Level0", "Level1A", "Level2A_1", "Level2A_2", "Level3A_1"));
}

TEST(TestMemoryExposure, TestDisjointClassTreesWithCrossTreeInterfaceAndMultipleSeeds) {
  // Tree 1:
  // AlphaRoot <- AlphaMid <- AlphaLeaf1, AlphaLeaf2
  //
  // Tree 2:
  // BetaRoot <- BetaMid <- BetaLeaf
  //
  // Tree 3 (completely isolated):
  // GammaRoot <- GammaLeaf
  //
  // Bridge interface implemented by classes in Tree 1 and Tree 2:
  // IBridge is implemented by AlphaLeaf2 and BetaRoot
  VariableInfo variableInfo;
  variableInfo.createClass("AlphaRoot");
  variableInfo.createClass("AlphaMid");
  variableInfo.createClass("AlphaLeaf1");
  variableInfo.createClass("AlphaLeaf2");

  variableInfo.createClass("BetaRoot");
  variableInfo.createClass("BetaMid");
  variableInfo.createClass("BetaLeaf");

  variableInfo.createClass("GammaRoot");
  variableInfo.createClass("GammaLeaf");

  variableInfo.createInterface("IBridge");

  variableInfo.addBaseClass("AlphaMid", "AlphaRoot");
  variableInfo.addBaseClass("AlphaLeaf1", "AlphaMid");
  variableInfo.addBaseClass("AlphaLeaf2", "AlphaMid");

  variableInfo.addBaseClass("BetaMid", "BetaRoot");
  variableInfo.addBaseClass("BetaLeaf", "BetaMid");

  variableInfo.addBaseClass("GammaLeaf", "GammaRoot");

  variableInfo.addInterface("AlphaLeaf2", "IBridge");
  variableInfo.addInterface("BetaRoot", "IBridge");

  // Exposing AlphaLeaf1 adds its ancestors, but not its sibling AlphaLeaf2 or the interface that sibling implements.
  variableInfo.addMemoryExposureType("AlphaLeaf1");
  variableInfo.finalizeMemoryExposure();

  EXPECT_THAT(variableInfo.getMemoryExposureTypeRegistry(),
              ::testing::ElementsAre("AlphaLeaf1", "AlphaMid", "AlphaRoot"));
}

TEST(TestMemoryExposure, TestMultipleClassSeedsAcrossForest) {
  // Forest with 3 independent class hierarchies:
  // Tree A: A1 <- A2 <- A3
  // Tree B: B1 <- B2
  // Tree C: C1 <- C2 <- C3
  VariableInfo variableInfo;
  variableInfo.createClass("A1");
  variableInfo.createClass("A2");
  variableInfo.createClass("A3");
  variableInfo.createClass("B1");
  variableInfo.createClass("B2");
  variableInfo.createClass("C1");
  variableInfo.createClass("C2");
  variableInfo.createClass("C3");

  variableInfo.addBaseClass("A2", "A1");
  variableInfo.addBaseClass("A3", "A2");
  variableInfo.addBaseClass("B2", "B1");
  variableInfo.addBaseClass("C2", "C1");
  variableInfo.addBaseClass("C3", "C2");

  // Expose deep leaf in Tree A (A3) and root in Tree B (B1).
  // Tree C must remain unexposed.
  variableInfo.addMemoryExposureType("A3");
  variableInfo.addMemoryExposureType("B1");
  variableInfo.finalizeMemoryExposure();

  EXPECT_THAT(variableInfo.getMemoryExposureTypeRegistry(), ::testing::ElementsAre("A1", "A2", "A3", "B1", "B2"));
}

TEST(TestMemoryExposure, TestClassDiamondInheritanceWithInterfaces) {
  /*
   * AssemblyScript restricts classes to single inheritance, but classes + interfaces form
   * a classic non-tree diamond graph (DAG) where two independent classes implement the same interface:
   *            BaseInterface
   *             /         \
   *      DerivedClassA   DerivedClassB
   *             \         /
   *            (both exposed when BaseInterface is exposed)
   * And each branch can have its own derived class:
   *      LeafA extends DerivedClassA
   *      LeafB extends DerivedClassB
   */
  VariableInfo variableInfo;
  variableInfo.createInterface("BaseInterface");
  variableInfo.createClass("DerivedClassA");
  variableInfo.createClass("DerivedClassB");
  variableInfo.createClass("LeafA");
  variableInfo.createClass("LeafB");
  variableInfo.createClass("IsolatedClass");

  variableInfo.addInterface("DerivedClassA", "BaseInterface");
  variableInfo.addInterface("DerivedClassB", "BaseInterface");

  variableInfo.addBaseClass("LeafA", "DerivedClassA");
  variableInfo.addBaseClass("LeafB", "DerivedClassB");

  variableInfo.addMemoryExposureType("BaseInterface");
  variableInfo.finalizeMemoryExposure();

  EXPECT_THAT(variableInfo.getMemoryExposureTypeRegistry(),
              ::testing::ElementsAre("BaseInterface", "DerivedClassA", "DerivedClassB", "LeafA", "LeafB"));
}

TEST(TestMemoryExposure, TestCrossClassInterfaceMultipathDAGNonTree) {
  /*
   * Non-tree graph formed by classes and interfaces (DAG with multiple convergent paths):
   * Interfaces:
   *      IData
   *     /     \
   *  IRead   IWrite
   *     \     /
   *    IIOStream
   *
   * Classes:
   * ClassReader (implements IRead)
   * ClassWriter (implements IWrite)
   * ClassDuplex (inherits from ClassReader, implements IIOStream)
   *
   * When IData is exposed:
   * - Downwards via interface DAG to IRead, IWrite, IIOStream
   * - Downwards to implementers: ClassReader, ClassWriter, ClassDuplex
   * - Bi-directional class propagation connects ClassDuplex <-> ClassReader
   * All nodes in this multi-path DAG must be collected without duplicate looping.
   */
  VariableInfo variableInfo;
  variableInfo.createInterface("IData");
  variableInfo.createInterface("IRead");
  variableInfo.createInterface("IWrite");
  variableInfo.createInterface("IIOStream");

  variableInfo.addBaseInterface("IRead", "IData");
  variableInfo.addBaseInterface("IWrite", "IData");
  variableInfo.addBaseInterface("IIOStream", "IRead");
  variableInfo.addBaseInterface("IIOStream", "IWrite");

  variableInfo.createClass("ClassReader");
  variableInfo.createClass("ClassWriter");
  variableInfo.createClass("ClassDuplex");
  variableInfo.createClass("UnrelatedClass");

  variableInfo.addBaseClass("ClassDuplex", "ClassReader");

  variableInfo.addInterface("ClassReader", "IRead");
  variableInfo.addInterface("ClassWriter", "IWrite");
  variableInfo.addInterface("ClassDuplex", "IIOStream");

  variableInfo.addMemoryExposureType("IData");
  variableInfo.finalizeMemoryExposure();

  EXPECT_THAT(
      variableInfo.getMemoryExposureTypeRegistry(),
      ::testing::ElementsAre("ClassDuplex", "ClassReader", "ClassWriter", "IData", "IIOStream", "IRead", "IWrite"));
}

} // namespace warpo::ut

#endif