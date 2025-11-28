// Copyright (C) 2025 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

#include <gtest/gtest.h>
#include <string>

#include "passes/DwarfGenerator/IntervalTree.hpp"

using namespace warpo::passes;

TEST(IntervalTreeTest, SingleInterval) {
  IntervalTree<std::string> tree;
  std::vector<std::pair<wasm::BinaryLocations::Span, std::string>> intervals = {{{1, 10}, "root"}};
  tree.build(std::move(intervals));

  auto const &roots = tree.getRoots();
  ASSERT_EQ(roots.size(), 1);
  EXPECT_EQ(roots[0].span.start, 1);
  EXPECT_EQ(roots[0].span.end, 10);
  EXPECT_EQ(roots[0].data, "root");
  EXPECT_TRUE(roots[0].children.empty());
}

TEST(IntervalTreeTest, NestedIntervals) {
  // Example from the question: [1,10], [2,5], [7,10], [3,4], [8,9]
  IntervalTree<int> tree;

  std::vector<std::pair<wasm::BinaryLocations::Span, int>> intervals = {
      {{1, 10}, 0}, {{2, 5}, 1}, {{7, 10}, 2}, {{3, 4}, 3}, {{8, 9}, 4}};

  tree.build(std::move(intervals));

  auto const &roots = tree.getRoots();
  ASSERT_EQ(roots.size(), 1);

  // Root should be [1,10]
  EXPECT_EQ(roots[0].span.start, 1);
  EXPECT_EQ(roots[0].span.end, 10);
  EXPECT_EQ(roots[0].data, 0);

  // [1,10] should have 2 children: [2,5] and [7,10]
  ASSERT_EQ(roots[0].children.size(), 2);

  IntervalTree<int>::Node const *const child1 = roots[0].children[0].get();
  IntervalTree<int>::Node const *const child2 = roots[0].children[1].get();

  // [2,5]
  EXPECT_EQ(child1->span.start, 2);
  EXPECT_EQ(child1->span.end, 5);
  EXPECT_EQ(child1->data, 1);
  EXPECT_EQ(child1->parent, &roots[0]);

  // [2,5] should have 1 child: [3,4]
  ASSERT_EQ(child1->children.size(), 1);
  EXPECT_EQ(child1->children[0]->span.start, 3);
  EXPECT_EQ(child1->children[0]->span.end, 4);
  EXPECT_EQ(child1->children[0]->data, 3);

  // [7,10]
  EXPECT_EQ(child2->span.start, 7);
  EXPECT_EQ(child2->span.end, 10);
  EXPECT_EQ(child2->data, 2);
  EXPECT_EQ(child2->parent, &roots[0]);

  // [7,10] should have 1 child: [8,9]
  ASSERT_EQ(child2->children.size(), 1);
  EXPECT_EQ(child2->children[0]->span.start, 8);
  EXPECT_EQ(child2->children[0]->span.end, 9);
  EXPECT_EQ(child2->children[0]->data, 4);
}

TEST(IntervalTreeTest, MultipleRoots) {
  IntervalTree<std::string> tree;

  std::vector<std::pair<wasm::BinaryLocations::Span, std::string>> intervals = {
      {{1, 5}, "root1"}, {{10, 15}, "root2"}, {{20, 25}, "root3"}, {{2, 3}, "child1"}, {{11, 13}, "child2"}};

  tree.build(std::move(intervals));

  auto const &roots = tree.getRoots();
  ASSERT_EQ(roots.size(), 3);

  // First root [1,5]
  EXPECT_EQ(roots[0].span.start, 1);
  EXPECT_EQ(roots[0].span.end, 5);
  EXPECT_EQ(roots[0].data, "root1");
  ASSERT_EQ(roots[0].children.size(), 1);
  EXPECT_EQ(roots[0].children[0]->data, "child1");

  // Second root [10,15]
  EXPECT_EQ(roots[1].span.start, 10);
  EXPECT_EQ(roots[1].span.end, 15);
  EXPECT_EQ(roots[1].data, "root2");
  ASSERT_EQ(roots[1].children.size(), 1);
  EXPECT_EQ(roots[1].children[0]->data, "child2");

  // Third root [20,25] - adjacent intervals are separate roots
  EXPECT_EQ(roots[2].span.start, 20);
  EXPECT_EQ(roots[2].span.end, 25);
  EXPECT_EQ(roots[2].data, "root3");
  EXPECT_TRUE(roots[2].children.empty());
}

TEST(IntervalTreeTest, Clear) {
  IntervalTree<int> tree;

  std::vector<std::pair<wasm::BinaryLocations::Span, int>> intervals = {{{1, 10}, 0}, {{2, 5}, 1}};

  tree.build(std::move(intervals));
  EXPECT_FALSE(tree.getRoots().empty());

  tree.clear();
  EXPECT_TRUE(tree.getRoots().empty());
}

TEST(IntervalTreeTest, ComplexNesting) {
  IntervalTree<int> tree;

  // Create a deep nesting structure with same-start intervals
  std::vector<std::pair<wasm::BinaryLocations::Span, int>> intervals = {{{0, 100}, 0},  // Root
                                                                        {{10, 90}, 1},  // Level 1
                                                                        {{20, 80}, 2},  // Level 2
                                                                        {{30, 70}, 3},  // Level 3
                                                                        {{40, 60}, 4},  // Level 4
                                                                        {{40, 50}, 5},  // Same start as Level 4
                                                                        {{40, 45}, 6}}; // Same start, nested deeper

  tree.build(std::move(intervals));

  // Check the tree structure
  auto const &roots = tree.getRoots();
  ASSERT_EQ(roots.size(), 1);

  auto const *current = &roots[0];
  for (int i = 0; i < 4; ++i) {
    EXPECT_EQ(current->data, i);
    ASSERT_EQ(current->children.size(), 1);
    current = current->children[0].get();
  }
  // Level 4: [40,60] should have child [40,50]
  EXPECT_EQ(current->data, 4);
  ASSERT_EQ(current->children.size(), 1);
  EXPECT_EQ(current->children[0]->span.start, 40);
  EXPECT_EQ(current->children[0]->span.end, 50);
  EXPECT_EQ(current->children[0]->data, 5);
  // [40,50] should have child [40,45]
  ASSERT_EQ(current->children[0]->children.size(), 1);
  EXPECT_EQ(current->children[0]->children[0]->data, 6);
  EXPECT_TRUE(current->children[0]->children[0]->children.empty());
}
