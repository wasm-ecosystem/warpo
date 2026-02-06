// Copyright (C) 2025 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

#pragma once

#include <string_view>

namespace warpo::passes::instrumentation {

static constexpr const char *unittestFrameworkEnvModuleName = "__unittest_framework_env";

static constexpr const char *checkMockFunctionName = "checkMock";
static constexpr const char *checkMockInternalFunctionName = "__unittest_framework_env/checkMock";

static constexpr const char *traceFunctionName = "traceExpression";
static constexpr const char *traceInternalFunctionName = "__unittest_framework_env/traceExpression";

static constexpr std::string_view defaultCoverageDebugInfoSectionName = "warpo.coverage.debug-info";
static constexpr std::string_view defaultTestExpectInfoSectionName = "warpo.test.expect-info";

} // namespace warpo::passes::instrumentation
