///
/// @file WasmModule.hpp
/// @copyright Copyright (C) 2025, BMW Group
///

#ifndef VB_WASM_MODULE_HPP
#define VB_WASM_MODULE_HPP
#include <cassert>
#include <cstddef>
#include <cstdint>

#include "src/config.hpp"

#if !LINEAR_MEMORY_BOUNDS_CHECKS || !ACTIVE_STACK_OVERFLOW_CHECK
#ifndef VB_NEED_SIGNAL_HANDLER
#define VB_NEED_SIGNAL_HANDLER 1
#endif
#endif

#ifdef VB_NEED_SIGNAL_HANDLER
#include "src/utils/SignalFunctionWrapper.hpp"
#endif

#if LINEAR_MEMORY_BOUNDS_CHECKS
#ifndef JIT_TARGET_TRICORE
#include <mutex>
#endif
#endif

#ifdef VB_WIN32_OR_POSIX
#if LINEAR_MEMORY_BOUNDS_CHECKS
#else
#include "src/utils/LinearMemoryAllocator.hpp"
#endif

#include "src/utils/ExecutableMemory.hpp"
#endif

#include "src/core/common/FunctionRef.hpp"
#include "src/core/common/ILogger.hpp"
#include "src/core/common/TrapCode.hpp"
#include "src/core/compiler/common/ManagedBinary.hpp"
#include "src/core/runtime/Runtime.hpp"

#ifndef ENABLE_ADVANCED_APIS
#define ENABLE_ADVANCED_APIS 0
#endif

namespace vb {
/// @brief A class to represent a WebAssembly module
/// @note All methods of this class are not thread-safe
class WasmModule final {
public:
  /// @brief Compile result of a Wasm module
  class CompileResult final {
  public:
    /// @brief Constructor for CompileResult
    /// @param module The compiled binary module
    /// @param debugSymbol The debug symbol for the module
    inline CompileResult(ManagedBinary &&module, ManagedBinary &&debugSymbol) VB_NOEXCEPT : module_{std::move(module)},
                                                                                            debugSymbol_{std::move(debugSymbol)} {
    }

    CompileResult() = default;

    /// @brief Get the compiled binary module
    /// @return Const reference to the compiled binary module
    inline const ManagedBinary &getModule() const VB_NOEXCEPT {
      return module_;
    }

    /// @brief Get the debug symbol for the module
    /// @return Const reference to the debug symbol
    inline const ManagedBinary &getDebugSymbol() const VB_NOEXCEPT {
      return debugSymbol_;
    }

  private:
    ManagedBinary module_;      ///< The compiled binary module
    ManagedBinary debugSymbol_; ///< The debug symbol for the module
  };

  using ReallocFunction = void *(*)(void *const, size_t const); ///< Type of reallocation function

  using FreeFunction = void (*)(void *const); ///< Type of free function

  using MallocFunction = void *(*)(size_t const); ///< Type of malloc function

  /// @brief initialize the global environment for the WARP compiler.
  /// @warning This function must be called once before any other WARP compiler functions.
  /// @warning This function must be called pair to destroyEnvironment(), otherwise the behavior is undefined.
  /// @throws std::runtime_error signal handler set failed
  static void initEnvironment(MallocFunction const mallocFunction, ReallocFunction const reallocFunction, FreeFunction const freeFunction);

  /// @brief destroy the global environment for the WARP compiler.
  static void destroyEnvironment() VB_NOEXCEPT;

  /// @brief Constructor
  /// @param logger The logger for the module
  explicit inline WasmModule(ILogger &logger) VB_NOEXCEPT : WasmModule{UINT64_MAX, logger, false, nullptr, 10U} {
  }

  /// @brief Constructor
  /// @param maxRam Max RAM size for the module in bytes
  /// @param logger The logger for the module
  /// @param debugBuild If true, the module will be compiled in debug mode
  /// @param ctx Custom context
  /// @param stackRecordCount The number of stack records to keep
  inline WasmModule(uint64_t const maxRam, ILogger &logger, bool const debugBuild, void *const ctx, uint8_t const stackRecordCount) VB_NOEXCEPT
      : logger_{logger},
        debugBuild_{debugBuild},
        maxRam_{maxRam},
        ctx_{ctx},
        stackRecordCount_{stackRecordCount} {
  }

  /// @brief Constructor with default Wasm Linear memory control
  /// @param logger The logger for the module
  /// @param debugBuild If true, the module will be compiled in debug mode
  inline WasmModule(ILogger &logger, bool const debugBuild) VB_NOEXCEPT : WasmModule{UINT64_MAX, logger, debugBuild, nullptr, 10U} {
  }

  // Delete copy constructor and assignment operator
  // Delete move constructor and assignment operator
  WasmModule(const WasmModule &) = delete;
  ///@brief Move constructor
  /// @param other The WasmModule to move from
  WasmModule(WasmModule &&other) = delete;
  WasmModule &operator=(const WasmModule &) & = delete;
  /// @brief Move assignment operator
  /// @param other The WasmModule to move from
  WasmModule &operator=(WasmModule &&other) & = delete;

  ~WasmModule() VB_NOEXCEPT; ///< Destructor

  /// @brief Load the WebAssembly module from bytecode
  /// @param bytecode The bytecode of the WebAssembly module
  /// @param linkedFunctions The list of functions that should be linked
  /// @throws std::bad_alloc not enough memory for executable memory
  /// @throws vb::RuntimeError If compilation failed
  void initFromBytecode(Span<uint8_t const> const &bytecode, Span<NativeSymbol const> const &linkedFunctions);

  /// @brief Load the WebAssembly module from bytecode
  /// @param bytecode The bytecode of the WebAssembly module
  /// @param linkedFunctions The list of functions that should be linked
  /// @throws vb::RuntimeError If compilation failed
  inline CompileResult compile(Span<uint8_t const> const &bytecode, Span<NativeSymbol const> const &linkedFunctions) {
    return compile(bytecode, linkedFunctions, true, false);
  }

  ///
  /// @brief Init the Wasm module from pre compiled JIT code
  ///
  /// @param compiledBinary The pre compiled JIT code
  /// @param linkedFunctions The list of Wasm import functions that should be linked
  /// @param rawDebugSymbol The pre compiled rawDebugSymbol
  /// @throw std::bad_alloc not enough memory for executable memory
  /// @throw vb::RuntimeError Module has static liked library
  /// @throw vb::RuntimeError the input compiledBinary is invalid
  /// @throw vb::RuntimeError Could not init module linear memory
  void initFromCompiledBinary(Span<uint8_t const> const &compiledBinary, Span<NativeSymbol const> const &linkedFunctions,
                              Span<uint8_t const> const &rawDebugSymbol);

  ///
  /// @brief Requests termination of a running Wasm module as soon as possible (this will take a few 10s to a few 100s of CPU instructions)
  /// @param trapCode requested trap code of the interruption
  /// @note This does nothing if the module is not currently executing
  ///
  void requestInterruption(vb::TrapCode const trapCode) VB_NOEXCEPT;

  /// @brief start a Wasm module
  /// @param stackTop Pointer to the top of the stack
  /// @throw vb::TrapException Wasm function trap
  /// @throw vb::RuntimeError Signal wrapper setup failed
  /// @throw vb::RuntimeError start function not found or wrong signature
  /// @throws vb::RuntimeError if the stack fence is too high
  /// @warning According to Wasm spec, the start must be executed once before any other function call.
  void start(uint8_t const *const stackTop);

  ///
  /// @brief call a exported Wasm function by function name
  ///
  /// @tparam NumReturnValue Number of return values of the Wasm function
  /// @tparam FunctionArguments Argument types of the Wasm function
  /// @param functionName function name
  /// @param stackTop Pointer to the top of the stack
  /// @param args function arguments
  /// @throw vb::RuntimeError The function name not exists
  /// @throw vb::TrapException Wasm function trap
  ///
  template <size_t NumReturnValue, typename... FunctionArguments>
  std::array<WasmValue, NumReturnValue> callExportedFunctionWithName(uint8_t const *const stackTop, const char *const functionName,
                                                                     FunctionArguments... args) VB_THROW {
    // GCOVR_EXCL_START
    assert(functionName != nullptr && "functionName must not be nullptr");
    // GCOVR_EXCL_STOP

    vb::ModuleFunction<NumReturnValue, FunctionArguments...> const fnc{
        runtime_.getExportedFunctionByName<NumReturnValue, FunctionArguments...>(functionName)};

    return executeWasmFunction<NumReturnValue, FunctionArguments...>(stackTop, fnc, std::forward<FunctionArguments>(args)...);
  }

  ///
  /// @brief call a exported Wasm function by function index
  ///
  /// @tparam NumReturnValue Number of return values of the Wasm function
  /// @tparam Args FunctionArguments Argument types of the Wasm function
  /// @param stackTop Pointer to the top of the stack
  /// @param tableIndex function table index
  /// @param args function arguments
  /// @throw vb::RuntimeError The function index not exists
  /// @throw vb::TrapException Wasm function trap
  ///
  template <size_t NumReturnValue, typename... FunctionArguments>
  std::array<WasmValue, NumReturnValue> callWasmFunctionByExportedTableIndex(uint8_t const *const stackTop, uint32_t const tableIndex,
                                                                             FunctionArguments... args) VB_THROW {
    vb::ModuleFunction<NumReturnValue, FunctionArguments...> const fnc{
        runtime_.getFunctionByExportedTableIndex<NumReturnValue, FunctionArguments...>(tableIndex)};
    return executeWasmFunction<NumReturnValue, FunctionArguments...>(stackTop, fnc, std::forward<FunctionArguments>(args)...);
  }

  ///
  /// @brief Get the Max RAM
  ///
  /// @return uint64_t
  ///
  inline uint64_t getMaxRam() const VB_NOEXCEPT {
    return maxRam_;
  }

  /// @brief Set the Max RAM
  /// @param maxRam Max RAM size in bytes
  inline void setMaxRam(uint64_t const maxRam) VB_NOEXCEPT {
    maxRam_ = maxRam;
  }

#if ENABLE_ADVANCED_APIS
  /// @brief update trace buffer for trace API
  /// only used for testing.
  inline void setTraceBuffer(Span<uint32_t> const &buffer) VB_NOEXCEPT {
    runtime_.setTraceBuffer(buffer);
  }
#endif

  ///
  /// @brief link memory to the Wasm module
  ///
  /// @param linkedMemory Memory to link
  /// @details This function usually used to pass async IO data to callback functions
  /// @return true if the memory was linked successfully, false otherwise
  ///
  inline bool linkMemory(Span<uint8_t const> const &linkedMemory) const VB_NOEXCEPT {
    return runtime_.linkMemory(linkedMemory.data(), static_cast<uint32_t>(linkedMemory.size()));
  }
  ///
  /// @brief unlink the linked memory
  ///
  inline void unlinkMemory() VB_NOEXCEPT {
    runtime_.unlinkMemory();
  }

  ///
  /// @brief Shrink linear memory to minimal length
  ///
  /// @param minimumLength Minimal length required by linear memory of wasm
  /// @throws std::range_error Linear memory shrink failed
  /// @note shrink linear memory is not a feature of Wasm spec.
  ///
  void shrinkMemory(uint32_t const minimumLength);

  /// @see Runtime::printStacktrace
  inline void printStacktrace(ILogger &logger) const {
    runtime_.printStacktrace(logger);
  }

  /// @see Runtime::iterateStacktraceRecords
  inline void iterateStacktraceRecords(FunctionRef<void(uint32_t fncIndex)> const &lambda) const {
    runtime_.iterateStacktraceRecords(lambda);
  }

  /// @brief get the range of compiled executable memory
  /// @return This function returns empty span on tricore
  Span<uint8_t const> getCompiledBinary() const VB_NOEXCEPT;

  ///
  /// @brief Get ram usage of the Wasm module
  ///
  /// @return memory usage in bytes
  ///
  inline uint64_t getRamUsage() const VB_NOEXCEPT {
#if LINEAR_MEMORY_BOUNDS_CHECKS == 0
    return linearMemoryAllocator_.getMemoryUsage();
#else
    return static_cast<uint64_t>(runtime_.getAllocationSize());
#endif
  }

  /// @brief set stack record count
  /// @param count The number of stack records to keep
  inline void setStacktraceRecordCount(uint8_t const count) VB_NOEXCEPT {
    stackRecordCount_ = count;
  }

  /// @brief get exported global variable
  /// @param name name of the global variable
  /// @throw vb::RuntimeError If the global variable with the given name does not exist or has a different type
  template <typename T> inline ModuleGlobal<T> getExportedGlobalByName(char const *const name) const VB_THROW {
    return runtime_.getExportedGlobalByName<T>(name);
  }

  ///
  /// @brief Get the Linear Memory Region
  ///
  /// @param offset Linear memory offset
  /// @param size The needed size
  /// @return uint8_t* address of the linear memory
  /// @throws vb::RuntimeError memory out of range
  inline uint8_t *getLinearMemoryRegion(uint32_t const offset, uint32_t const size) const {
    return runtime_.getLinearMemoryRegion(offset, size);
  }

  /// @brief Get the context pointer
  /// @return void* user defined context pointer
  inline void *getContext() const VB_NOEXCEPT {
    return ctx_;
  }

  /// @brief Set the context pointer
  /// @param ctx The context pointer to set
  inline void setContext(void *const ctx) VB_NOEXCEPT {
    ctx_ = ctx;
  }

#if ENABLE_ADVANCED_APIS
  /// @brief Load the WebAssembly module from bytecode
  /// @param bytecode The bytecode of the WebAssembly module
  /// @param linkedFunctions The list of functions that should be linked
  /// @param highPressureMode If true, the compiler will use high register pressure for testing purposes
  /// @throws vb::RuntimeError If compilation failed
  inline CompileResult compile(Span<uint8_t const> const &bytecode, Span<NativeSymbol const> const &linkedFunctions, bool const highPressureMode) {
    return compile(bytecode, linkedFunctions, true, highPressureMode);
  }

  /// @brief call a raw exported function by name
  /// @param functionName The name of the function to call
  /// @param stackTop Pointer to the top of the stack
  /// @param serializedArgs Serialized arguments for the function
  /// @param results Pointer to the results buffer, must be large enough to hold the results
  /// @throws vb::RuntimeError If the function with the given name does not exist
  /// @throws vb::TrapException Wasm function trap
  void callRawExportedFunctionByName(Span<char const> const &functionName, uint8_t const *const stackTop, uint8_t const *const serializedArgs,
                                     uint8_t *const results);

  /// @brief  get the function signature by name
  /// @param functionName The name of the function to get the signature for
  /// @return char* const Pointer to the function signature
  inline vb::Span<char const> getFunctionSignatureByName(Span<char const> const &functionName) const {
    RawModuleFunction const wasmFunction{runtime_.getRawExportedFunctionByName(functionName, vb::Span<char const>{})};
    return wasmFunction.signature();
  }

#endif

private:
  /// @brief Used to alloc memory blocks for compiler
  /// @param size The size of memory to allocate in bytes
  /// @param ctx The context pointer (this pointer)
  /// @return Pointer to the allocated memory or nullptr if allocation fails
  static void *compilerMemoryAllocFnc(uint32_t const size, void *const ctx) VB_NOEXCEPT;

  /// @brief Frees memory previously allocated for the compiler
  /// @param ptr Pointer to the memory to free
  /// @param ctx The context pointer (this pointer)
  static void compilerMemoryFreeFnc(void *const ptr, void *const ctx) VB_NOEXCEPT;

  /// @brief Reallocates memory for linear grow memory in the compiler
  /// @param currentObject The current memory object to be reallocated
  /// @param minimumLength The minimum required length in bytes
  /// @param ctx The context pointer (this pointer)
  static void compilerRealloc(ExtendableMemory &currentObject, uint32_t minimumLength, void *const ctx) VB_NOEXCEPT;

  /// @brief Reallocates memory for JIT compilation
  /// @param currentObject The current memory object to be reallocated
  /// @param minimumLength The minimum required length in bytes
  /// @param ctx The context pointer (this pointer)
  static void jitRealloc(ExtendableMemory &currentObject, uint32_t const minimumLength, void *const ctx) VB_NOEXCEPT;

  /// @brief Manages memory for debug line information
  /// @param currentObject The current memory object to be reallocated
  /// @param minimumLength The minimum required length in bytes
  /// @param ctx The context pointer (this pointer)
  static void debugLineFnc(vb::ExtendableMemory &currentObject, uint32_t const minimumLength, void *const ctx) VB_NOEXCEPT;

  /// @brief Allocates memory for the runtime linear memory
  /// @param currentObject The current memory object to be reallocated
  /// @param minimumLength The minimum required length in bytes
  /// @param ctx The context pointer (WasmModule instance)
  static void runtimeMemoryAllocFncRaw(ExtendableMemory &currentObject, uint32_t const minimumLength, void *const ctx) VB_NOEXCEPT;

  /// @brief Allocates memory for the runtime linear memory
  /// @param currentObject The current memory object to be reallocated
  /// @param minimumLength The minimum required length in bytes
  void runtimeMemoryAllocFnc(ExtendableMemory &currentObject, uint32_t minimumLength) VB_NOEXCEPT;

  /// @brief Frees memory allocated, wrappers over the freeFunction_
  /// @param ptr Pointer to the memory to free
  static void memFree(void *const ptr) VB_NOEXCEPT;

  /// @brief Load the WebAssembly module from bytecode
  /// @param bytecode The bytecode of the WebAssembly module
  /// @param linkedFunctions The list of functions that should be linked
  /// @param enableUnknownImports If true, the compiler will allow unknown imports and check for imports linking at runtime
  /// @param highPressureMode If true, the compiler will use high register pressure for testing purposes
  /// @throws vb::RuntimeError If compilation failed
  CompileResult compile(Span<uint8_t const> const &bytecode, Span<NativeSymbol const> const &linkedFunctions, bool const enableUnknownImports,
                        bool const highPressureMode);

  ///
  /// @brief Init the Wasm module from pre compiled JIT code
  ///
  /// @param compiledBinary The pre compiled JIT code
  /// @param linkedFunctions The list of Wasm import functions that should be linked
  /// @param rawDebugSymbol The pre compiled rawDebugSymbol
  /// @throw std::bad_alloc not enough memory
  void setupRuntime(Span<uint8_t const> const &compiledBinary, Span<NativeSymbol const> const &linkedFunctions,
                    Span<uint8_t const> const &rawDebugSymbol);

  /// @brief Send debug symbol to the debugger
  /// @param debugSymbol
  static void sendDebugSymbolToDebugger(Span<uint8_t const> const &debugSymbol) VB_NOEXCEPT;

  /// @brief Set the stack top pointer
  /// @param stackTop Pointer to the top of the stack
  /// @throw vb::RuntimeError if the stack fence is too high
  void setStackTop(uint8_t const *stackTop) const;

  ///
  /// @brief call a exported Wasm function by function name
  ///
  /// @tparam NumReturnValue Number of return values of the Wasm function
  /// @tparam FunctionArguments Argument types of the Wasm function
  /// @param stackTop Pointer to the top of the stack
  /// @param wasmFunction The Wasm function to call
  /// @param args function arguments
  /// @throw vb::RuntimeError if stack top too high
  /// @throw vb::TrapException Wasm function trap
  ///
  template <size_t NumReturnValue, typename... FunctionArguments>
  std::array<WasmValue, NumReturnValue> executeWasmFunction(uint8_t const *const stackTop,
                                                            ModuleFunction<NumReturnValue, FunctionArguments...> const &wasmFunction,
                                                            FunctionArguments... args) VB_THROW {
    setStackTop(stackTop);
#ifdef VB_NEED_SIGNAL_HANDLER
    std::array<WasmValue, NumReturnValue> const res{SignalFunctionWrapper::call(wasmFunction, std::forward<FunctionArguments>(args)...)};
#else
    std::array<WasmValue, NumReturnValue> const res{wasmFunction(std::forward<FunctionArguments>(args)...)};
#endif
    return res;
  }

  static MallocFunction mallocFunction_;   ///< Memory allocation function for the module
  static ReallocFunction reallocFunction_; ///< Reallocation function for the module
  static FreeFunction freeFunction_;       ///< Free function for the module
  Runtime runtime_;                        ///< The runtime for the module
  ILogger &logger_;                        ///< Logger for the module
  bool debugBuild_;                        ///< Debug mode flag
  uint64_t maxRam_;                        ///< Maximum RAM size for the module in bytes
  void *ctx_;                              ///< user defined context

#if LINEAR_MEMORY_BOUNDS_CHECKS
#ifndef JIT_TARGET_TRICORE
  std::mutex linearMemoryMutex_; ///< The mutex to protect linear memory realloc. Avoid raise condition when kill Wasm Module from other thread
#endif
#else
  vb::LinearMemoryAllocator linearMemoryAllocator_; ///< The allocator for linear memory in passive linear memory protection mode
#endif

#ifdef VB_WIN32_OR_POSIX
  ExecutableMemory executableMemory_; ///< The executable memory for the module
#endif

  uint8_t stackRecordCount_; ///< Number of Wasm function stack record in backtrace
};
} // namespace vb

#endif
