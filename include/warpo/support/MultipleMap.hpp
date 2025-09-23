// Copyright (C) 2024 Bayerische Motoren Werke Aktiengesellschaft (BMW AG)
// Copyright (C) 2025 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

#pragma once

#include <map>
#include <set>
#include <utility>

namespace warpo {

template <class K, class V> struct MultipleMap : public std::map<K, std::set<V>> {
  void insert_or_assign(K k, V v) {
    auto it = this->find(k);
    if (it == this->end()) {
      std::map<K, std::set<V>>::insert_or_assign(std::move(k), std::set<V>{std::move(v)});
    } else {
      it->second.insert(std::move(v));
    }
  }
};

} // namespace warpo
