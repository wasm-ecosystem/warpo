// Copyright (C) 2024 Bayerische Motoren Werke Aktiengesellschaft (BMW AG)
// Copyright (C) 2025 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

/*
 * Copyright 2023 WebAssembly Community Group participants
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#pragma once

#include <vector>

#include "analysis/lattice.h"

namespace warpo::passes {

// Represents a powerset lattice constructed from a finite set of consecutive
// integers from 0 to n which can be represented by a bitvector. Set elements
// are represented by FiniteIntPowersetLattice::Element, which represents
// members present in each element by bits in the bitvector.
class FiniteIntPowersetLattice {
  // The size of the set that the powerset lattice was created from. This is
  // equivalent to the size of the Top lattice element.
  size_t setSize;

public:
  explicit FiniteIntPowersetLattice(size_t setSize) : setSize(setSize) {}

  // Returns the size of the set that the powerset lattices was created from.
  size_t getSetSize() const { return setSize; }

  // This represents an element of a powerset lattice. The element is itself a
  // set which has set members. The bitvector tracks which possible members of
  // the element are actually present.
  class Element {
    // If bitvector[i] is true, then member i is present in the lattice element,
    // otherwise it isn't.
    std::vector<bool> bitvector;

    // This constructs a bottom element, given the lattice set size. Used by the
    // lattice's getBottom function.
    explicit Element(size_t latticeSetSize) : bitvector(latticeSetSize) {}

  public:
    // Counts the number of members present the element itself. For instance, if
    // we had {true, false, true}, the count would be 2. O(N) operation which
    // iterates through the bitvector.
    size_t count() const;

    bool get(size_t index) { return bitvector[index]; }
    void set(size_t index, bool value) { bitvector[index] = value; }

    bool isTop() const { return count() == bitvector.size(); }
    bool isBottom() const { return count() == 0; }

    friend FiniteIntPowersetLattice;
  };

  // Compares two lattice elements and returns a result indicating the
  // left element's relation to the right element.
  wasm::analysis::LatticeComparison compare(const Element &left, const Element &right) const noexcept;

  // Returns an instance of the bottom lattice element.
  Element getBottom() const noexcept;
  Element getTop() const noexcept;

  // Modifies `joinee` to be the join (aka least upper bound) of `joinee` and
  // `joiner`. Returns true if `joinee` was modified, i.e. if it was not already
  // an upper bound of `joiner`.
  bool join(Element &joinee, const Element &joiner) const noexcept;
  bool meet(Element &meetee, const Element &meeter) const noexcept;
};

static_assert(wasm::analysis::FullLattice<FiniteIntPowersetLattice>, "FiniteIntPowersetLattice is not a full lattice");

} // namespace warpo::passes
